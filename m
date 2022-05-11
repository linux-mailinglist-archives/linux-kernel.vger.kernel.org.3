Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF775229D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbiEKCc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242343AbiEKCcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:32:08 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10ED5C66D;
        Tue, 10 May 2022 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652236280; x=1683772280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RlxOaNZc/4I0mSrTZJv3nct2D80p9NBIlZoZaPymPRc=;
  b=qQzeNiSziR5cFz//AeO52+HaHuUi0Bf5dqItdhHTaGbzcIdoRcR7Yqt8
   /9FxxsIzgCGzefM29rcdx26JzGuF7sUTyvQPDEkG0/h2pUJ4UzE32YZYu
   2LrPu7pHahUepzyiny883PkFz1MYOYqtXllhl/JpEgtKWmIjAal9YVd3h
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 May 2022 19:31:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:31:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 19:31:19 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 19:31:13 -0700
Date:   Wed, 11 May 2022 08:01:09 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_ppratap@quicinc.com>,
        <quic_vpulyala@quicinc.com>
Subject: Re: [v3 3/3] arm64: dts: qcom: sc7280: Update SNPS Phy params for
 SC7280 IDP device
Message-ID: <20220511023109.GA13360@hu-pkondeti-hyd.qualcomm.com>
References: <1652011947-18575-1-git-send-email-quic_kriskura@quicinc.com>
 <1652011947-18575-4-git-send-email-quic_kriskura@quicinc.com>
 <20220509032005.GJ4640@hu-pkondeti-hyd.qualcomm.com>
 <7ef88262-4292-3077-00a1-dc06b2483b10@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ef88262-4292-3077-00a1-dc06b2483b10@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:05:42PM +0530, Krishna Kurapati PSSNV wrote:
> 
> On 5/9/2022 8:50 AM, Pavan Kondeti wrote:
> >Hi Krishna,
> >
> >On Sun, May 08, 2022 at 05:42:27PM +0530, Krishna Kurapati wrote:
> >>Overriding the SNPS Phy tuning parameters for SC7280 IDP device.
> >>
> >>Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> >>Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> >>---
> >>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >>diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >>index 5eb6689..ad85ffb 100644
> >>--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >>+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >>@@ -325,6 +325,12 @@
> >>  	vdda-pll-supply = <&vreg_l10c_0p8>;
> >>  	vdda33-supply = <&vreg_l2b_3p0>;
> >>  	vdda18-supply = <&vreg_l1c_1p8>;
> >>+	qcom,hs-rise-fall-time-bps = <0>;
> >>+	qcom,squelch-detector-bps = <(-2090)>;
> >>+	qcom,hs-disconnect-bps = <1743>;
> >>+	qcom,hs-amplitude-bps = <1780>;
> >>+	qcom,hs-crossover-voltage = <(-31)>;
> >>+	qcom,hs-output-impedance = <2600>;
> >>  };
> >Is this an example change or do we see any HS electrical compliance failures
> >on SC7280 IDP that will get fixed with these override sequence?
> >
> >Thanks,
> >Pavan
> 
> Hi Pavan,
> 
> These results were based on compliance testing results.
> 
Ok, Do we know what tests are failing and getting fixed with these settings?
Can you mention it in the changelog?

Thanks,
Pavan
