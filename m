Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5990588198
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiHBSCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbiHBSBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:01:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E15550723;
        Tue,  2 Aug 2022 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659463245; x=1690999245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H9H/J/Y8vTONOMCsoFtnKSU588klsT0jif+kmYaamfc=;
  b=m4sV6ITvMABvG0FTGb6BSn2kILWZSOSah0hRj+SQIoJDRkm+5kGhpuwx
   MR9sPJHH5PNzITG3dAAlX3zM5+LZ4J2fQrTaOpF54mbn10UTW3kGm5hz9
   TnERJUzovsZpIJ308tb0CyXWdofhx8+DeNAqdhyXa/XwuhAtzHSM7XtRO
   I=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Aug 2022 11:00:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 11:00:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 2 Aug 2022 11:00:43 -0700
Received: from [10.216.16.162] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 2 Aug 2022
 11:00:37 -0700
Message-ID: <3c175fd4-861a-37a9-4cd7-87370c2e46df@quicinc.com>
Date:   Tue, 2 Aug 2022 23:30:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/8] Revert "usb: dwc3: qcom: Keep power domain on to
 retain controller status"
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-3-johan+linaro@kernel.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20220802151404.1797-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/2/2022 8:43 PM, Johan Hovold wrote:
> This reverts commit d9be8d5c5b032e5383ff5c404ff4155e9c705429.
>
> Generic power-domain flags must be set before the power-domain is
> initialised and must specifically not be modified by drivers for devices
> that happen to be in the domain.
>
> To make sure that USB power-domains are left enabled during system
> suspend when a device in the domain is in the wakeup path, the
> GENPD_FLAG_ACTIVE_WAKEUP flag should instead be set for the domain
> unconditionally when it is registered.
Hi Johan, Thanks for the review and suggestion.

In case we need the genpd framework to set the GENPD_FLAG_ACTIVE_WAKEUP
flag for a particular domain that will be used by a device (which is
wakeup capable) and hasn't been probed yet , can you help me understand if
there any dt-flags we  can add to convey the same the genpd  framework
so that it will set that flag during domain registration ?

Regards,
Krishna,
>
> Note that this also avoids keeping power-domains on during suspend when
> wakeup has not been enabled (e.g. through sysfs).
>
> For the runtime PM case, making sure that the PHYs are not suspended and
> that they are in the same domain as the controller prevents the domain
> from being suspended. If there are cases where this is not possible or
> desirable, the genpd implementation may need to be extended.
>
> Fixes: d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/usb/dwc3/dwc3-qcom.c | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index c5e482f53e9d..be2e3dd36440 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -17,7 +17,6 @@
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/phy/phy.h>
> -#include <linux/pm_domain.h>
>   #include <linux/usb/of.h>
>   #include <linux/reset.h>
>   #include <linux/iopoll.h>
> @@ -757,13 +756,12 @@ dwc3_qcom_create_urs_usb_platdev(struct device *dev)
>   
>   static int dwc3_qcom_probe(struct platform_device *pdev)
>   {
> -	struct device_node *np = pdev->dev.of_node;
> -	struct device *dev = &pdev->dev;
> -	struct dwc3_qcom *qcom;
> -	struct resource	*res, *parent_res = NULL;
> -	int ret, i;
> -	bool ignore_pipe_clk;
> -	struct generic_pm_domain *genpd;
> +	struct device_node	*np = pdev->dev.of_node;
> +	struct device		*dev = &pdev->dev;
> +	struct dwc3_qcom	*qcom;
> +	struct resource		*res, *parent_res = NULL;
> +	int			ret, i;
> +	bool			ignore_pipe_clk;
>   
>   	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
>   	if (!qcom)
> @@ -772,8 +770,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, qcom);
>   	qcom->dev = &pdev->dev;
>   
> -	genpd = pd_to_genpd(qcom->dev->pm_domain);
> -
>   	if (has_acpi_companion(dev)) {
>   		qcom->acpi_pdata = acpi_device_get_match_data(dev);
>   		if (!qcom->acpi_pdata) {
> @@ -881,17 +877,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto interconnect_exit;
>   
> -	if (device_can_wakeup(&qcom->dwc3->dev)) {
> -		/*
> -		 * Setting GENPD_FLAG_ALWAYS_ON flag takes care of keeping
> -		 * genpd on in both runtime suspend and system suspend cases.
> -		 */
> -		genpd->flags |= GENPD_FLAG_ALWAYS_ON;
> -		device_init_wakeup(&pdev->dev, true);
> -	} else {
> -		genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
> -	}
> -
> +	device_init_wakeup(&pdev->dev, 1);
>   	qcom->is_suspended = false;
>   	pm_runtime_set_active(dev);
>   	pm_runtime_enable(dev);
