Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC36520526
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbiEITX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiEITXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:23:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78E04B865
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 12:19:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j14so14784299plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KxPqHT2Kr+KyNj+2ntbnJAJv8pZrB8xBI5SfIaP2vFc=;
        b=B4IwO0nyKOAm5augILPM3hpD8rDu9e6FzqYla0dT2S8wGmnvAM7pRZbRKSnGeFFxpm
         cNw5/XjodsTZgEN3O/QJ3ymKLQU6m3EkhA+wl5idtToj9//MAKok8i9+vJG5EkTtiQby
         NFRCqT/KmrHY7WCJANDmfE6basadEMlF+PxpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KxPqHT2Kr+KyNj+2ntbnJAJv8pZrB8xBI5SfIaP2vFc=;
        b=YHwLdxW977i5bhrRvPmnxOIqdsb+Mr+J16RqEp9zX+LZVMvCDSKdsSy3bv9Vf1XWeG
         PmH4YnQ1rVRwCC/2G2k/9hJE/eorz8fXzI+xY44XUdfCYT8fa2pwD3lbGhzuZWWBgjlO
         umKQ67ZupkERXX7jgSyHdbnv69b0TAadgtHks3n42CuyL3DBlAPXYneiAMhCM13MQpie
         GOKLmpdwwnH67g88N1wWM+x36OknuU0Km3C34aGcb0ihzDDMHOFEBo4HqKARox+dlLvl
         9usDkSoLyl0bJ2RQuUGPhvplfJSMpOuc8L2rrItBay5e4l7/eZL0aMXWdVjXNxVEhOg7
         Lu9w==
X-Gm-Message-State: AOAM5314U8oaoPynp1PFfiORDpHF/2HBA7bWnAByWpK/DXeSXZMlfMJ7
        G4lGC+hxVch5dVaYOIOzzEWyRQ==
X-Google-Smtp-Source: ABdhPJynK+hgyAqxpMUsozaBIsBVXpWHnA1HB/wZaD2Fn2o0ZomfaUwWpc0M5alYMbL3GWwl6Pyb8A==
X-Received: by 2002:a17:90b:17c1:b0:1dc:a6e6:ef26 with SMTP id me1-20020a17090b17c100b001dca6e6ef26mr28136922pjb.22.1652123989602;
        Mon, 09 May 2022 12:19:49 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:753:614a:caf8:e14d])
        by smtp.gmail.com with UTF8SMTPSA id f19-20020a63dc53000000b003c14af50631sm8918375pgj.73.2022.05.09.12.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 12:19:49 -0700 (PDT)
Date:   Mon, 9 May 2022 12:19:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>, swboyd@chromium.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, krzysztof.kozlowski@canonical.com,
        agross@kernel.org, dianders@chromium.org, ohad@wizery.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add SC7280 MSS
 bindings
Message-ID: <YnlpU+sCfO86+qc2@google.com>
References: <1652082798-5855-1-git-send-email-quic_sibis@quicinc.com>
 <1652082798-5855-2-git-send-email-quic_sibis@quicinc.com>
 <1652098858.589911.3576234.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1652098858.589911.3576234.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 07:20:58AM -0500, Rob Herring wrote:
> On Mon, 09 May 2022 13:23:17 +0530, Sibi Sankar wrote:
> > Add MSS PIL loading bindings for SC7280 SoCs.
> > 
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > ---
> >  .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 261 +++++++++++++++++++++
> >  1 file changed, 261 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/

The culprit is this snippet in arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi:

/* Modem setup is different on Chrome setups than typical Qualcomm setup */
&remoteproc_mpss {
	status = "okay";
	compatible = "qcom,sc7280-mss-pil";
	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
	memory-region = <&mba_mem>, <&mpss_mem>;
};

The original compatible string from sc7280.dtsi is 'qcom,sc7280-mpss-pas'.

> remoteproc@4080000: clock-names:1: 'snoc_axi' was expected
> 	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-idp.dtb
> 
> remoteproc@4080000: clock-names:2: 'offline' was expected
> 	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

The fix probably consists in adding overrides for 'clocks' and
'clock-names' to the extension in sc7280-chrome-common.dtsi, unless
we add a dedicated 'qcom,sc7280-mss-pil' node to sc7280.dtsi. This
can be done once the binding landed.

> remoteproc@4080000: 'interconnects' is a required property
> 	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

This can be fixed by adding an 'interconnects' to either the
extension in sc7280-chrome-common.dtsi, or the original node if
'qcom,sc7280-mpss-pas' uses the same interconnect.

> remoteproc@4080000: reset-names:1: 'pdc_sync' was expected
> 	arch/arm64/boot/dts/qcom/sc7280-crd.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb
> 	arch/arm64/boot/dts/qcom/sc7280-idp.dtb
>

This could be fixed by aligning the reset names of the
'qcom,sc7280-mpss-pas' and 'qcom,sc7280-mss-pil' bindings.
The reset is called 'pdc_reset' for 'mpss-pas', and 'pdc_sync'
for 'mpss-pil'.
