Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60816508190
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359538AbiDTHBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiDTHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:01:22 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715F536176
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:58:36 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w27-20020a056830061b00b00604cde931a0so543585oti.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSaPVxqUElsuAugf+lTz1Lk55X/LOO3DSjAti4V4PLM=;
        b=ofPJPhX4ltLEJkA1rOf++phksrK9ka18wA/xiNND9o9YTY8t049A7bGAjoB4+wZ+M1
         f6BUKDR4afoZezKXLdn94PqDDAVQFZDPaYzo1TLwasfNMrXWPY/Bz1JvlZpBjbb1u3CT
         I3yDB98LsQ0c+o/UHz5t5KWTQuinsW80gm8IWp/pG/wcidMLW8Vr1SMgxfgX5F6mO2ej
         zy5j1ANdx501TJX0h9L7hnqr6IoCJAG2hQJ/xA9kNhw+cAULXE64OVa6Tk3vAKPRSDWX
         MKfl5n3/LXlR8yNO4D8l2BfxEhxke9Pm3yU1FNr8xyD602tU2f0LJPehW3+SZ3V/18fh
         jPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSaPVxqUElsuAugf+lTz1Lk55X/LOO3DSjAti4V4PLM=;
        b=EajwWPOm87SeVk7YPSI/yMPtfUH+SpGo4oHDleFiuH54Pi9urPdqH3xUFnvj0Utmju
         w1zq2GpVVeNZTVzLfvdyeKm3uPlaszWGy3aftM7mzZu9MdKr7ncUfrcPazdNQL6cjtQA
         pfbinQMoLyowqIXPDXMzM46CFBH0r2n5BGwBgs3/f/dDk/q31UELP4qHN9/yNt6ORABJ
         jPS67URSY881HOyMsy81gsZ+KjCrNW7so4nZruO2aFjkpEH7vsCPm5mWEjBsNwgJAiGg
         gGouGXSpmFSiRrGSTkvSiPUFJjF30NO0VYKtx13a3yA4RdLg4Ee0YxUfIt3tQnO3MlHP
         6KMg==
X-Gm-Message-State: AOAM530w7m2jJppc9q2EvekiBKAQr0SgJuabGp9WpGh1rY7+SixItZwz
        kKs5KSo1YqsNsW4YazvWoZlO+syy/VgB99gpmKsvEQ==
X-Google-Smtp-Source: ABdhPJxiWsUR8OR24fa+Za6Sxyd3NPQjKZYvJR2DZCStyfS1fNcKqB+WQg+mQlFJ/nbyHWJW8Rk6Sf8gaJIb7sFfm88=
X-Received: by 2002:a05:6830:33d0:b0:5cf:bb0a:6d4a with SMTP id
 q16-20020a05683033d000b005cfbb0a6d4amr7047337ott.28.1650437915710; Tue, 19
 Apr 2022 23:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220419205854.1269922-1-bhupesh.sharma@linaro.org> <Yl9y668H/N+bcrP4@builder.lan>
In-Reply-To: <Yl9y668H/N+bcrP4@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 20 Apr 2022 12:28:24 +0530
Message-ID: <CAH=2NtwCsRmPbBJ6SAb4fL_Di3SxfUsw=mZMrRGyefd+NW=PQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: sm8350-sagami: usb qmp phy node
 - add 'vdda-pll-supply' & 'vdda-phy-supply'
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Wed, 20 Apr 2022 at 08:11, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 19 Apr 15:58 CDT 2022, Bhupesh Sharma wrote:
>
> How about making the subject:
>
> "arm64: dts: qcom: sm8350-sagami: add supplies to USB phy node"
>
> It still says the same thing, but in much less characters.

Sure, this wording seems better to me. Will fix this in v3.

> > As suggested by Bjorn during review of [1], the 'vdda-pll-supply' &
> > 'vdda-phy-supply' supplies denote the power for the bus and the
> > clock of the usb qmp phy and are used by the qcom qmp phy driver.
> >
> > So, its safe to assume that the two regulators are the same as on
> > the MTP. So let's wire them up in the same way as the MTP.
> >
>
> I'm not sure it's "safe to assume", so I would like to get Konrad's
> input before merging this.

Right. @Konrad Dybcio , @Marijn Suijten - Any comments on this fix?
Please share your thoughts.

Thanks,
Bhupesh

> > In absence of the same 'make dtbs_check' leads to following warnings:
> >
> > arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
> >  phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
> >
> > arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
> >  phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
> >
>
> This is good!
>
> Thanks for the patch Bhupesh,
> Bjorn
>
> > [1]. https://lore.kernel.org/lkml/20220228123019.382037-9-bhupesh.sharma@linaro.org/
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: konrad.dybcio@somainline.org
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Marijn Suijten <marijn.suijten@somainline.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> > Changes since v1:
> > -----------------
> > - v1 can be found here: https://www.spinics.net/lists/linux-arm-msm/msg108467.html
> > - Fixed the commit message to read usb qmp phy instead of ufs phy (which
> >   was introduced erroraneously in the commit log).
> >
> >  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > index 90b13cbe2fa6..238ac9380ca2 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > @@ -3,6 +3,7 @@
> >   * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
> >   */
> >
> > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >  #include "sm8350.dtsi"
> >  #include "pm8350.dtsi"
> >  #include "pm8350b.dtsi"
> > @@ -75,6 +76,27 @@ ramoops@ffc00000 {
> >       };
> >  };
> >
> > +&apps_rsc {
> > +     pm8350-rpmh-regulators {
> > +             compatible = "qcom,pm8350-rpmh-regulators";
> > +             qcom,pmic-id = "b";
> > +
> > +             vreg_l1b_0p88: ldo1 {
> > +                     regulator-name = "vreg_l1b_0p88";
> > +                     regulator-min-microvolt = <912000>;
> > +                     regulator-max-microvolt = <920000>;
> > +                     regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > +             };
> > +
> > +             vreg_l6b_1p2: ldo6 {
> > +                     regulator-name = "vreg_l6b_1p2";
> > +                     regulator-min-microvolt = <1200000>;
> > +                     regulator-max-microvolt = <1208000>;
> > +                     regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > +             };
> > +     };
> > +};
> > +
> >  &adsp {
> >       status = "okay";
> >       firmware-name = "qcom/adsp.mbn";
> > @@ -256,4 +278,7 @@ &usb_1_hsphy {
> >
> >  &usb_1_qmpphy {
> >       status = "okay";
> > +
> > +     vdda-phy-supply = <&vreg_l6b_1p2>;
> > +     vdda-pll-supply = <&vreg_l1b_0p88>;
> >  };
> > --
> > 2.35.1
> >
