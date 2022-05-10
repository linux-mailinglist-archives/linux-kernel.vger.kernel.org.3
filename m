Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59155522651
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiEJV3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiEJV3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:29:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2664DF6886
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:29:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g8so262415pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/IqDQEddmxFMTUC8iSV81NOx7xKeE21hCS6V6VtTJCM=;
        b=YMKse/febsjCNAJR+1ZcEdHrPHvfo8YkbP8Ipq7ShQ7JblCaf2vKxPDn/GvURTL+ik
         nJGBDulsj0SiJgysg5FnV/Ve2Js9rwxHVU1yZyRfvb+6lNnVRYp1hOnM9rUQpFGE8jUb
         /G/4KToJ6vyGy6fYna7SXTJSdpXoh4CIOUZrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/IqDQEddmxFMTUC8iSV81NOx7xKeE21hCS6V6VtTJCM=;
        b=uJy0pMNTtrup3Ukifw24ur7n2OiPAmieDQoEAJRheYh/W11MxcjyokxN3AUcilRsER
         3LvxwPCmxtP8xXAs+vA82+YbgTD+DPb8Sjmmet4jOdRIIScUpkcOjMDuZXSaIkFmT/jv
         t7w2JeWhKdV4IQ1la4l5Eo+JLywib1UWhpnINU52S6AhoYlQC6yjxg9al4G8/dss3zxe
         dIZBNmgvXADtnqGuO8y2BUR3VBvjTjqQGAQTG1d5q7AnMfG0t27ZaVZoDqvxBkpTPURt
         +50R4HP2/4wNVLGZBAaPFecQhlRiJsM6AqTZtns7+FWZQI+w22ZtCOH+M0LSBtElT9On
         JJ3A==
X-Gm-Message-State: AOAM532L/R67BjsqIRXMcZoBjH0QNuETcGMgfxx0PEF3jTLGZOjY4g/a
        75Q+6dcwqMYrCNpF5nOLWmb2ig==
X-Google-Smtp-Source: ABdhPJwDKLXVW/RgcUysfuiMzy0W7K1TutNey5ZOyYCVMrQuW1aZWAfc4QfoH3dWLVLMS2GMgxmaxQ==
X-Received: by 2002:aa7:9802:0:b0:50d:4f5d:fef6 with SMTP id e2-20020aa79802000000b0050d4f5dfef6mr22331682pfl.9.1652218180682;
        Tue, 10 May 2022 14:29:40 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:fb50:1192:2874:d4a2])
        by smtp.gmail.com with UTF8SMTPSA id o7-20020a170902d4c700b0015eb690bee9sm80694plg.196.2022.05.10.14.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 14:29:40 -0700 (PDT)
Date:   Tue, 10 May 2022 14:29:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Set modem FW path for Chrome
 OS boards
Message-ID: <YnrZQ4ggqxjlacL1@google.com>
References: <20220510104656.1.Id98b473e08c950f9a461826dde187ef7705a928c@changeid>
 <CAD=FV=U33QSjnD7ERdVBb+hk4yooGU5=C0FtnhFsDME_MePR0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=U33QSjnD7ERdVBb+hk4yooGU5=C0FtnhFsDME_MePR0w@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 12:49:30PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, May 10, 2022 at 10:47 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Specify the path of the modem FW for SC7280 Chrome OS boards in
> > the 'remoteproc_mpss' node.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> >  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > index 9f4a9c263c35..995c5bd12549 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > @@ -89,6 +89,8 @@ &remoteproc_mpss {
> >         compatible = "qcom,sc7280-mss-pil";
> >         iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> >         memory-region = <&mba_mem>, <&mpss_mem>;
> > +       firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
> > +                       "qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
> 
> We don't necessarily need to change anything, but a few thoughts:
> 
> 1. I guess technically we don't actually need the "modem" subdirectory
> for herobrine, right? WiFi works differently on sc7280 so we won't
> have a "no modem" modem firmware. ...but I guess it doesn't hurt to
> have it and it's nice to keep it symmetric.

Yeah, it seems nice to keep it symmetric and also indicate for what
kind of device the firmware is for. 'sc7280-herobrine' (or
'sc7280-chrome') doesn't reveal that.

> 2. Whenever we're ready to support WiFi only SKUs then I guess it'll
> still be OK to specify the firmware name. We'll just set the status of
> "&mdss_dp" to "disabled".

Yes, specifying the FW name is not a problem. Either we'll set the
status of 'remoteproc_mpss' to 'disabled' or have a DT snippet for
the modem that is only included for SKUs with a modem.

> 3. It's slightly weird that we're using the name "herobrine" but
> putting the change in the "chrome-common.dtsi" file. Should it be
> "sc7280-chrome" instead?

Currently OS images have the FW in 'qcom/sc7280-herobrine', but we
could change that if desired. If we change the path we could also
consider to change it to 'qcom/sc7280-q6v5' or 'qcom/sc7280-mpss'
instead of 'qcom/sc7280-chrome/modem'.
