Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220FE4E747D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358413AbiCYNvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358370AbiCYNvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:51:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6582D99EEE;
        Fri, 25 Mar 2022 06:49:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so15485159ejd.5;
        Fri, 25 Mar 2022 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtFdY7L9jEbHbUZpEsaJVL8bmFr2sDAxxXdfZ2px3oI=;
        b=BaJZvsjy2DkrATetK7H3L7xir9hO+k/EXO7DZZiJbce+DlXKd5VCZApZjtmo/n7hER
         1AR2mU/epdU/QxaDgsu+thXCv93/FNGJzXhbNXms8Cv6+9090pmn/0u7o82Y1RXF1pmg
         frunay+g/Y57RopSrItzVpyEsdY7RCcg4yf4dspf0qEpzfLv6E8RcWAqqkf7pQjFHDwh
         o/z7NYOSYppHFkPX2cEi1wgJpzFfBFM6QJZD6ajGMZBq7tvRIQSdCsBkZbqYHjeHwhya
         yWGdjYe9oUoPYdHc3yX8+sufKDjdzyuZHqAJZAHmaLe833uiWfA5muy5PiY8GkK17Dx4
         dpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtFdY7L9jEbHbUZpEsaJVL8bmFr2sDAxxXdfZ2px3oI=;
        b=nt9Tv042XSim8cHG1pDPiz8X25YF144Q53SvKrK+3Nt7ZuFVCgwJQrMN8c16MszZfI
         VEXDo1+NgsPVxvvBgyaeRW/m3nG/gsqEEnms2NQiLevZYR5oTZsmFCPk3eoqNj1oME6k
         /Joe1+1gIgwIl9PWC4lOPjnpFlCqrYfnQyDz2UMYMO2aRwC/u55g2ZfzU8/9uml0OjSn
         3MGYH3LgtV6nVfl0NWlMn7bnHWiMBgSFh+QkjslFvB0LQ5OelrVihIKXhssC6At8gIfS
         xagD7sMCpx2jGCpuRTjoSgPZv9jKdeCfvROSzcgXvsi+30E/cu6ki0laS+t9+aFCHX7J
         OxgQ==
X-Gm-Message-State: AOAM532uBGgRS3TkJhcqoRAehjvR1SDM9eekDkUm2cqjw9XPCkwYxcuJ
        jaWJunH7KySqWvPS7MRYtFgrii2q06XmGOztPCI=
X-Google-Smtp-Source: ABdhPJz3EPwc6GGnyxYAiulRj2xGw2MKAtvjd0z+LnHTEFNdudI7z/624RNYWrQ5ejxcXnuvBVN28dIXGNZElNwcEQQ=
X-Received: by 2002:a17:906:32d0:b0:6ce:e1cf:3f2e with SMTP id
 k16-20020a17090632d000b006cee1cf3f2emr11263307ejk.214.1648216169815; Fri, 25
 Mar 2022 06:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
In-Reply-To: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 25 Mar 2022 10:49:17 -0300
Message-ID: <CAOMZO5D4_WboF4S0dgSLD1m15a13c2irK2yjDV4C77_Wb15=2w@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx
 audio card node
To:     "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:56 AM Ariel D'Alessandro
<ariel.dalessandro@collabora.com> wrote:
>
> BSH SystemMaster (SMM) S2 PRO board comes with an audio card based on
> tlv320aic31xx family codec.
>
> The audio card exposes two playback devices, one of them using the EASRC
> (Enhanced Asynchronous Sample Rate Converter) module. Note that this
> would require SDMA and EASRC firmware in order to work.
>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---

What are the changes in v4?

I see you removed 'clock-names' so this looks good:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
