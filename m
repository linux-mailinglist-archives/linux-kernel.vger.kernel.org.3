Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD65525105
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355812AbiELPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbiELPPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:15:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7539D262709;
        Thu, 12 May 2022 08:15:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so6003043pjb.1;
        Thu, 12 May 2022 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=GgS0ovsnzIl+XbPdqcV3z69dQ1L8vgRNNmtPd1a560g=;
        b=iVGlYlXZyiZJ4+m4ZBMGPCqhvt8he9j9el2DQHfKlwgf+mjUwvqRQgB1E2lDLqePKr
         yFn9Tf4NAnfef8uuIUg+C8wZm1DyDa5J7plCFoL+dtAPrWBKooCDTEbECC/ChjYQIdbE
         4BAzt3raxDol3U7vxXFOILgyiWFanRoIDMA1ygO6pYBpabGVTbtc+HiDHPX0wKV3wuHO
         k4KOZEmXdXALOkTvyusvBv+PH5JxEUKIY33W7nggQk+AewiDA5TATQYjvHvVrvfN9ICZ
         /1Jw8U/nGZEdiR2bzKg/tcpiqZSuv8Sn9bwDM4970lBQ7lpUrW10IOSW8qjt1kNGoUMS
         63sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=GgS0ovsnzIl+XbPdqcV3z69dQ1L8vgRNNmtPd1a560g=;
        b=f7yAK5KBgmj620y0mwZOBIj64byLCy7jLYcyx/1sZJKRt7ORMoa7mUsoH6h4m5xv+W
         +puBDRVLwYmlLXdtby+4sZwyI4R2efLthC/cMatf/RPynlNdKYxljithopUPiB/Inw6k
         Vjbkg7DxyQD4bMxR/EMQShtyKzXFwlMMjU9nGlAxc97qETwkONlHDW/1ZaBefHgsJ6k/
         sDWBcXk3qUH3DgO1oLcvkoof37rUwxAZ/ddNTuUwygdFGzxwDpFK6hC/jQDaubaPzxBz
         Tp0BzBa3Y0AlD+p3yiCcRZzJ1Q6a2YDCAt19OUKzZjuRkBaIbE0lfV8bXpX5r+pkZ2V9
         W3Eg==
X-Gm-Message-State: AOAM53315f4s2YkA8MWy36nRKC/ghBMEwfk1+xNdn9iq0jjl2nUfl5Y3
        NeMv2/Wpd43XeJMmgIRzU6U=
X-Google-Smtp-Source: ABdhPJxC2So97x6pv0JyW4D6Tlkd964QX6zgOdt5/5Flx+sqhYg9Rx/Z6eRy6qX69MCFQqgQ7/TDlw==
X-Received: by 2002:a17:902:ef43:b0:156:9c5d:b0fe with SMTP id e3-20020a170902ef4300b001569c5db0femr73540plx.158.1652368515863;
        Thu, 12 May 2022 08:15:15 -0700 (PDT)
Received: from localhost ([49.204.239.218])
        by smtp.gmail.com with ESMTPSA id gd9-20020a17090b0fc900b001d90c8b6141sm1955741pjb.53.2022.05.12.08.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 08:15:15 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 May 2022 20:45:09 +0530
Message-Id: <CJXVR1WTNWBR.2YTXMB8GZU84K@skynet-linux>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 9/9] arm64: dts: qcom: msm8953: Add remote processor
 nodes
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
X-Mailer: aerc 0.9.0
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-10-sireeshkodali1@gmail.com>
 <2d68e610-e8ae-9e08-257a-3c94c3697334@linaro.org>
 <CJXO6ZMZ454X.M3N9HDKNA5HB@skynet-linux>
 <4c35f605-4fa0-13d0-db09-229f718c5c7c@linaro.org>
In-Reply-To: <4c35f605-4fa0-13d0-db09-229f718c5c7c@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 12, 2022 at 8:07 PM IST, Krzysztof Kozlowski wrote:
> On 12/05/2022 11:19, Sireesh Kodali wrote:
> > On Wed May 11, 2022 at 11:25 PM IST, Krzysztof Kozlowski wrote:
> >> On 11/05/2022 18:16, Sireesh Kodali wrote:
> >>> This commit adds the modem (q6v5_mss), WiFi (wcnss-pil) and audio DSP
> >>> (q6v5_pas) remote processor nodes for the MSM8953 platform. It also a=
dds
> >>> the coresponding SMP2P, SMSM and pinctrl nodes that are needed by the=
se
> >>> remote processors.
> >>>
> >>> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> >>> +			};
> >>> +
> >>> +			wcnss_sleep: wcnss-sleep-pins {
> >>> +				wcss_wlan2 {
> >>
> >> No underscores in node names, unless something needs it?
> >>
> >=20
> > wcnss_sleep is used by the pronto node defined below
>
> wcnss_sleep is not a node name and it is not in the line where I commente=
d.
>
Sorry, I'll fix it in v2
> Best regards,
> Krzysztof

Thanks,
Sireesh
