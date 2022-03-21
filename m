Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB18E4E2037
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 06:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344436AbiCUFqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 01:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbiCUFqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 01:46:42 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412EB3467E;
        Sun, 20 Mar 2022 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647841518; x=1679377518;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5jpBW6uLsQb0YnPNbiHNaZP2OmTuH9tT+u8HihjWK8Y=;
  b=jobQ4oOHQ30u19jP0tFiCUv8wdZK55VOlsq0JKs+Mn2ia9mjB08tHETt
   BMeQUw15WlM34FtGuV6Acgx4mz4Gyo+R/dOxv8uGBfxVvTKo2w8mE5m+k
   vLTSGijA24dVRC29fcqudFiu+Vvny0jxI7hgvlFY36+4Hx7jfFgyVC3xd
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Mar 2022 22:45:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 22:45:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 20 Mar 2022 22:45:16 -0700
Received: from [10.216.35.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 20 Mar
 2022 22:45:13 -0700
Message-ID: <c808dc08-09c8-bb08-6656-18dd649af036@quicinc.com>
Date:   Mon, 21 Mar 2022 11:14:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 2/4] arm64: dts: qcom: sc7280: Add 'piglin' to the
 crd-r3 compatible strings
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>, <devicetree@vger.kernel.org>,
        "Douglas Anderson" <dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
 <20220316172814.v1.2.Ib0fbb7e5218201c81a2d064ff13c9bc1b0863212@changeid>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220316172814.v1.2.Ib0fbb7e5218201c81a2d064ff13c9bc1b0863212@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/2022 5:58 AM, Matthias Kaehlcke wrote:
> With newer bootloader versions the crd-r3 (aka CRD 1.0 and 2.0) is
> identified as a 'piglin' board (like the IDP2 board), instead of 'hoglin'
> Add the compatible strings 'google,piglin-rev{3,4}'. The hoglin entries
> are kept to make sure the board keeps booting with older bootloader
> versions.

The older bootloaders really look for the google,hoglin-rev3/google,hoglin-rev4
compatibles or just google,hoglin? If its just google,hoglin, won;t it pick the
crd-rev5+ dtb now?

> 
> The compatible string 'google,piglin' (without revision information) is
> still used by the IDP2 board, which is not expected to evolve further.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>   arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> index 7a028b9248c3..344338ad8a01 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> @@ -12,7 +12,10 @@
>   
>   / {
>   	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev3 - 4)";
> -	compatible = "qcom,sc7280-crd", "google,hoglin-rev3", "google,hoglin-rev4", "qcom,sc7280";
> +	compatible = "qcom,sc7280-crd",
> +		     "google,hoglin-rev3", "google,hoglin-rev4",
> +		     "google,piglin-rev3", "google,piglin-rev4",
> +		     "qcom,sc7280";
>   
>   	aliases {
>   		serial0 = &uart5;
