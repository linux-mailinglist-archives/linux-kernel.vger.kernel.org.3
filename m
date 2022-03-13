Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEE64D76AA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiCMQQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiCMQQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:16:04 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1FE35DC0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:14:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q10so18623282ljc.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MdfBfkBUpL2bSvoudLMFBEa9b6pECpCEDNH8K1hwrao=;
        b=L2N2StlxKHhQG9J2PUUQ8BMT81Woo2WARfqwCCCaRsZCgYrB8qKZW7nYAVcxEV0MvG
         tAmI14/Fy2JGdqKqs3PVqlGuqRQ8BpIEoEsS7WIDwUntQH4fhtauk18n+SdaBbTbknEg
         T43aEH7UMyT7VepC/Q6G9X121xGeTZWPVzIIumRjSQd+j/Vsp8I3qJKLKqIHRBdZT7HA
         IFOc9cqMtBzSi/mt6pNoqCZZ9zAy3mGmED4YPsP4Q4Bi1DVExMV9Xnghx4G6cvj1mZcn
         G+f98Oe6HB9hQIR/VdLOmejfPMCiVKHSSa//IqLdDWqFJHs/Hn1z4ifHEnaaCzJ5VGYV
         oyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MdfBfkBUpL2bSvoudLMFBEa9b6pECpCEDNH8K1hwrao=;
        b=Qf1Ly8l6z4JIiLXxmLy/U0mLrbzGg81EowudykcqY14QSdHdu+mnPdmNcB2TGWi6Ty
         YWFuTP1iiQzOneyqtWjvVQWHL2KWVd3FydMF+jasCOb7p+oWxSr0SbE8OmMWp2OcMzPe
         yj/Le5HZvRZaewEHNYYRCOVEKx72u59EPRK6eZn+sZQ8u8Ah04AeqqgalLMvcbwpDf7U
         cxL4mXPLOhAMSj3CTe7wRfevPGqU1UHaZUvNNUx54HyQgfAcQTd69ohdYIatN9/lQZbS
         K5hRE14uPiD4g3M++XKjyjdAflSHd5Y91JoDdnWT8BWxJnp6UiegcYOYZXMDFoee1G0R
         DhQw==
X-Gm-Message-State: AOAM532bmPKCGDh8vyst8U6XWkbJMY2DX9jOCZ7CnF1df4nSpLIffpkU
        J2qiJ4buNEMG7In41d7pL7Q=
X-Google-Smtp-Source: ABdhPJywSUqzwjhi8sTT2bXMPlpeMIA9hr6XzmiR9VlakP+DJzJlrecpRXrO/NRoaY3lGt7mgYEN8Q==
X-Received: by 2002:a2e:320c:0:b0:247:ec95:fdea with SMTP id y12-20020a2e320c000000b00247ec95fdeamr11940110ljy.288.1647188093586;
        Sun, 13 Mar 2022 09:14:53 -0700 (PDT)
Received: from smtpclient.apple (31-178-191-245.dynamic.chello.pl. [31.178.191.245])
        by smtp.gmail.com with ESMTPSA id f17-20020a2e1f11000000b00247f8eb86a7sm3158089ljf.108.2022.03.13.09.14.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Mar 2022 09:14:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] drm/bridge: synopsys/dw-hdmi: set cec clock rate
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CAMdYzYq06QSmFAwCuTmBYy4LfQAQDxzx2PGc8HOB1iEjxXHGyg@mail.gmail.com>
Date:   Sun, 13 Mar 2022 17:14:49 +0100
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pierre-Hugues Husson <phh@phh.me>,
        Archit Taneja <architt@codeaurora.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E86F11A4-011B-43ED-90D2-BB6BA9353A3F@gmail.com>
References: <20220126202427.3047814-1-pgwipeout@gmail.com>
 <3AFD1DD4-AF0A-4ECC-B4F5-E6BD6B9F1BB7@gmail.com>
 <CAMdYzYq06QSmFAwCuTmBYy4LfQAQDxzx2PGc8HOB1iEjxXHGyg@mail.gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Wiadomo=C5=9B=C4=87 napisana przez Peter Geis <pgwipeout@gmail.com> w =
dniu 13.03.2022, o godz. 13:56:
>=20
>>=20
>=20
> I was worried about that, thanks for testing it.
> Can you send me the cec_clk rate before and after this patch?
>=20

Here it is:

working:
                                 enable  prepare  protect                =
                duty  hardware
   clock                          count    count    count        rate   =
accuracy phase  cycle    enable
=
--------------------------------------------------------------------------=
-----------------------------
clk_hdmi_cec                      1        2        0       32743        =
  0     0  50000         Y



non-working:
                                 enable  prepare  protect                =
                duty  hardware
   clock                          count    count    count        rate   =
accuracy phase  cycle    enable
=
--------------------------------------------------------------------------=
-----------------------------
clk_hdmi_cec                      1        2        0       32768        =
  0     0  50000         Y



dmesg
[   52.745988] cec-dw_hdmi: message 44 timed out
[   54.879307] cec-dw_hdmi: message 44 timed out
[   57.012654] cec-dw_hdmi: message 88 timed out
[   59.145973] cec-dw_hdmi: message 88 timed out



player:
2022-03-13 11:04:40.938355 E CECAdapter: =
CLinuxCECAdapterCommunication::Write - ioctl CEC_TRANSMIT failed - =
tx_status=3D00 errno=3D22
2022-03-13 11:04:40.938366 E CECAdapter: =
CLinuxCECAdapterCommunication::Write - ioctl CEC_TRANSMIT failed - =
tx_status=3D00 errno=3D22

