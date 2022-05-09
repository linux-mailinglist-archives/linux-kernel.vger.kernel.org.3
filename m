Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D032C51F2FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiEIDeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiEIDYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:24:10 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCC95A2F;
        Sun,  8 May 2022 20:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652066417; x=1683602417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dTZrcfWUgN6fGzVBM2+6gc6m+RANq5DplIKCSgrMy/c=;
  b=xKFM0RVgohZ7GstS0cDYzhraxOlTssDcZraXehIxhhtP4eVNNGcYNCJl
   4FAyfmhV5OivhD/pEWOoMY2nbXFiZ+/NTzY0BMUlb7HRndVz8Wd6XvfC7
   ON/QraL6uLbRpULdrPfN8yBQyaQQwVZT88Fk6bRfImXXJtxXst00vmIp+
   Y=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 08 May 2022 20:20:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 20:20:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 8 May 2022 20:20:15 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 8 May 2022 20:20:09 -0700
Date:   Mon, 9 May 2022 08:50:05 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [v3 3/3] arm64: dts: qcom: sc7280: Update SNPS Phy params for
 SC7280 IDP device
Message-ID: <20220509032005.GJ4640@hu-pkondeti-hyd.qualcomm.com>
References: <1652011947-18575-1-git-send-email-quic_kriskura@quicinc.com>
 <1652011947-18575-4-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1652011947-18575-4-git-send-email-quic_kriskura@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On Sun, May 08, 2022 at 05:42:27PM +0530, Krishna Kurapati wrote:
> Overriding the SNPS Phy tuning parameters for SC7280 IDP device.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 5eb6689..ad85ffb 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -325,6 +325,12 @@
>  	vdda-pll-supply = <&vreg_l10c_0p8>;
>  	vdda33-supply = <&vreg_l2b_3p0>;
>  	vdda18-supply = <&vreg_l1c_1p8>;
> +	qcom,hs-rise-fall-time-bps = <0>;
> +	qcom,squelch-detector-bps = <(-2090)>;
> +	qcom,hs-disconnect-bps = <1743>;
> +	qcom,hs-amplitude-bps = <1780>;
> +	qcom,hs-crossover-voltage = <(-31)>;
> +	qcom,hs-output-impedance = <2600>;
>  };

Is this an example change or do we see any HS electrical compliance failures
on SC7280 IDP that will get fixed with these override sequence? 

Thanks,
Pavan
