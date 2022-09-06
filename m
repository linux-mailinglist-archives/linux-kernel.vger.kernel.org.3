Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E725AF417
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiIFTEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIFTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:04:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0358C466
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:04:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v5so12195352plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=u5M6QxdAPtDOUZYM968YPfYQgKBWh+diykgOvWRU0/o=;
        b=d+qIdUiwBS4vrHLafCK0ZewwWsNsAresJB4Ha48hicYnkPEiiLzJJ9HIYP5gpQp9Q6
         MLY24WiB+HBZQDlXE+zB3hVXOuJsZup37ch73XmdcCyJEaqM6DmnXc7twtV1wW4aJiwZ
         yYPBJ9HdxQ6Kh4A5xJuZHjD7u0cBwmHsZUr/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=u5M6QxdAPtDOUZYM968YPfYQgKBWh+diykgOvWRU0/o=;
        b=HmI/xNGw1l/J/OQ3v0LAegaHFyPqb/+Jp2rTz3MZ0xvhaj4C68XWogz+0BPSHT/DHI
         aQvJq3GhkHJzXNZ4Oyjfr9N7hUlNo/PkO8oZ3JvPAwP1vRaDRTY9SOwYtFhrilOndeYq
         EnsT5xE8j9hAmCcVh6gHaXQlINrAMgFyzpxgdclFv2yRiZFXdd3oKa1OHaAEvZX6d9dl
         OFzu+O+fLFOGs8s32CvO2cLcWR1NzV64VMI9vOBKIBB6ubt/s2zrno2VUACsEgHPWicy
         OM9ysVNlSuyuefWyGYF+tIlsQ/Zx/lLia++I8s9/74rocR+l8BWqRa8SB9QqTgVLbUtZ
         7GLg==
X-Gm-Message-State: ACgBeo3/k6y7ozASmuYdRHrwpd8InVqMmm/nDCb1gpMaEDeh9NmgEK8l
        K2X4Kbs3SBI0ou6V3IvEM71kzw==
X-Google-Smtp-Source: AA6agR7U2bm4Qk9QDupReQP6foEFsmxKNcPMJZV3bm3IXBlg6jD5XNYwq9ld8GkXR0taSv15gfL9/A==
X-Received: by 2002:a17:902:be01:b0:176:8bc3:b379 with SMTP id r1-20020a170902be0100b001768bc3b379mr51706pls.109.1662491057388;
        Tue, 06 Sep 2022 12:04:17 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:acea:5f9a:4de:10c7])
        by smtp.gmail.com with UTF8SMTPSA id q13-20020a170902dacd00b001743be790b4sm10337536plx.215.2022.09.06.12.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 12:04:16 -0700 (PDT)
Date:   Tue, 6 Sep 2022 12:04:14 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Configure USB as wakeup
 source
Message-ID: <YxeZrvKvRB/ct3Ss@google.com>
References: <20220901102946.v2.1.I347ea409ee3134bd32a29e33fecd1a6ef32085a0@changeid>
 <CAD=FV=WBzVTaz1dtMswNMWhBzBBUQZTxqXff_DgiuP6WJgG8Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=WBzVTaz1dtMswNMWhBzBBUQZTxqXff_DgiuP6WJgG8Qg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tue, Sep 06, 2022 at 11:33:56AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Sep 1, 2022 at 10:29 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > The dwc3 USB controller of the sc7180 supports USB remote
> > wakeup, configure it as a wakeup source.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> > Changes in v2:
> > - use qcom/arm64-for-6.1 as base, v1 was unintendedly based on a
> >   downstream branch that was used for testing
> >
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > index e8debb0da411..af5bab27eaf3 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > @@ -2782,6 +2782,8 @@ usb_1: usb@a6f8800 {
> >                                         <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3 0>;
> >                         interconnect-names = "usb-ddr", "apps-usb";
> >
> > +                       wakeup-source;
> > +
> 
> The patch documenting this property has landed in commit 416b61893860
> ("dt-bindings: usb: qcom,dwc3: add wakeup-source property"). I guess
> the only question is whether this should be in the general sc7180
> device tree file or just for trogdor.

I had a similar comment on the patch for sc7280 [1], there the rationale
for putting the property into the .dtsi of the SoC was that the wakeup
capability is provided by the SoC.

For sc8280xp.dtsi the property is also in the .dtsi of the SoC:

https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/tree/arch/arm64/boot/dts/qcom/sc8280xp.dtsi?h=arm64-for-6.1#n1315

> Any chance it could cause problems for devices that aren't designed like
> trogdor?

Probably not in a functional sense, however power consumption during system
suspend is slightly higher (2-3 mW) when USB wakeup is enabled. Boards can
disable wakeup by deleting the property in their .dtsi file, though it
is not necessarily evident that this is an option to reduce power
consumption.

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1649321104-31322-7-git-send-email-quic_c_sanm@quicinc.com/
