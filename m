Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12614591437
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbiHLQtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbiHLQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:49:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77B8B0296
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 09:49:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 73so1239929pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=F1sGXxLyV8yZhMF0HGv63B4Yk94UCJ5cdqcFyQqs35g=;
        b=YkDXZGhYjBZnCjqw61M71vpc3nq0nvkQJb0J76cx90/JgpLR23cnE+mOIlobD2sTdG
         bImyhQehYAbZ13F0qBoqKQOFGRfXjrdC/KeHOwDXZN30UWB6Ys+wKyZnhYiKlFOpQykp
         WG527xZchWivYn1TSSigcpfZnbNwvzuG98kNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=F1sGXxLyV8yZhMF0HGv63B4Yk94UCJ5cdqcFyQqs35g=;
        b=0Wn0F7jGJ38qI0mKvBwaYJJ9emoestU75lC4oqd2inD2FB2mioQpQlBWz16fzPF0iM
         s5el4pBxFikSOMZPz+4zloH8ZsezH/5QJMEZa01fdwciMSrZbGXx2sNrMoZY7WsBVNKr
         iZZnscZ9/C5XcDmkitzSa19Z7sD0+0XgmMp7OCLCjAHEob9gEUuoSmFC5T4E8ykHk3bX
         4+/4e2xY8maS6Zuok1NPS6G7pPRUNNXmjnu0ZK5tE3Z7ehvPtV5GPVm8vrtJCFRVrG/N
         5cAjw20gPsJFlrc6QFOCFY3bg9ecXZ4z0B3EvrJoZu5mkOswzY5Md/y0ojaZk3ARauSX
         Pkgg==
X-Gm-Message-State: ACgBeo29Nt40x6Pk1xhwQKn413EjOeZebS3Z5t/1wg/OzpoRX8+JDRZm
        UaNQkSr2jjnaD10rQhHooezszA==
X-Google-Smtp-Source: AA6agR4MAaTfR/7slAeE/Q2Qx/bMu0WArrZ6BMSbgPGjQTEQGvF+79EeS8pcgwDHUC52BimkMm0zrw==
X-Received: by 2002:a65:6384:0:b0:41c:5f9b:881c with SMTP id h4-20020a656384000000b0041c5f9b881cmr3765584pgv.513.1660322991241;
        Fri, 12 Aug 2022 09:49:51 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:a762:bd03:acfc:583b])
        by smtp.gmail.com with UTF8SMTPSA id s19-20020a170903201300b001712e1ea269sm1966566pla.3.2022.08.12.09.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 09:49:50 -0700 (PDT)
Date:   Fri, 12 Aug 2022 09:49:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: pm6350: add temp sensor and thermal
 zone config
Message-ID: <YvaErMmLIQaDolKR@google.com>
References: <20220812114421.1195044-1-luca.weiss@fairphone.com>
 <81ae6a31-1f37-a677-f8f8-2340e37d3a63@linaro.org>
 <CM43WTWNP8MM.3145TGVN4208B@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CM43WTWNP8MM.3145TGVN4208B@otso>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 04:06:47PM +0200, Luca Weiss wrote:
> Hi Krzysztof,
> 
> +CC Matthias Kaehlcke (author of patch mentioned further below)
> 
> On Fri Aug 12, 2022 at 3:36 PM CEST, Krzysztof Kozlowski wrote:
> > On 12/08/2022 14:44, Luca Weiss wrote:
> > > Add temp-alarm device tree node and a default configuration for the
> > > corresponding thermal zone for this PMIC. Temperatures are based on
> > > downstream values.
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > > With this config I'm getting this in dmesg, not sure if it's a warning
> > > that should be solved or just an informative warning.
> > > 
> > > [    0.268256] spmi-temp-alarm c440000.spmi:pmic@0:temp-alarm@2400: No ADC is configured and critical temperature is above the maximum stage 2 threshold of 140 C! Configuring stage 2 shutdown at 140 C.
> > > 
> > > As far as I can tell, based on downstream dts this PMIC doesn't have an
> > > ADC.

I don't seem to have access to the datasheet, in any case that the ADC isn't
configured in the downstream dts doesn't necessarily mean the PMIC doesn't
have one. The PM6150 has one, and it is probably relatively close to the
PM6350.

> > You configure 145 and driver believes 140 is the limit, so it seems
> > warning should be addressed.
> 
> Hm...
> 
> >
> > From where did you get 145 degrees as limit? Downstream DTS?
> 
> Yes, downstream dts[0].
> 
> From what I can see in the downstream driver, it always disabled this
> "software override of stage 2 and 3 shutdowns"[1]
> 
> In mainline only since f1599f9e4cd6 ("thermal: qcom-spmi: Use PMIC
> thermal stage 2 for critical trip points") this check exists, which is
> not part of downstream (wasn't in 4.19 yet), where this software
> override tries to get enabled so that thermal core can handle this.
> 
> Any suggestion what I can do here? Maybe looking at msm-5.4 sources (and
> associated dts) might reveal something..?

I wouldn't necessarily consider QC downstream code as a reliable source of
truth ...

> Maybe newer SoCs/PMICs have a different config?

Commit aa92b3310c55 ("thermal/drivers/qcom-spmi-temp-alarm: Add support
for GEN2 rev 1 PMIC peripherals") added support for gen2 PMICs, which
actually have lower thresholds than gen1. From the log it seems that the
PM6350 is identified as gen1 device (max stage 2 threshold = 140 degC).

It seems setting the limit to 140 degC or one of the other stage 2
thresholds would be a reasonable course of action. stage 2 is the
threshold at which the PMIC is so hot that the system should shut
down, and 140 degC is the highest of the stage 2 thresholds. Even
if it was possible, what would be gained from setting the trip
point 5 degC higher?
