Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E6049C544
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiAZI3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:29:48 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58938 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238420AbiAZI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:29:47 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20Q4eNre021515;
        Wed, 26 Jan 2022 09:29:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=HqDC/OjVj/xPLO7ZZ9W6iTk/stZzn8M/W5EdEzByj68=;
 b=UWaXSzEyyD9azgCoJykNRixWshb3bYFrPJZJfzcQappHNjLhO6s4e427jgbHBnkojawH
 HrFmh79edtskl6t3g25fKLMLYWGs5Hg2Mmbv27oM2xPfqPtGD5zeqcg8HKi9jECLipD7
 xYBN74zPVpV+85EvqnxlgbWMOizbaeEmanYv8ME9Jjz6zuApT6/w7DKENGSdGQSviQco
 TaPkaUn7PJgFdJxk1U6a88lQGS+lf6VnynUaZTnobA8C9DL18GQe0Rr21jvxYF/Qoed0
 NTPfTMhpf2waUdKzhUuQQ3tBb5+VnEAcmKGvUkMUiwuLuhGhHnPPX/6BIeGxJmeV9MvM ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dtyfw13q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 09:29:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7352310002A;
        Wed, 26 Jan 2022 09:29:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 69D87210F6A;
        Wed, 26 Jan 2022 09:29:23 +0100 (CET)
Received: from lmecxl1091.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 26 Jan
 2022 09:29:22 +0100
Subject: Re: [Linux-stm32] [PATCH][next] hwspinlock: stm32: Use struct_size()
 helper in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220125021353.GA29777@embeddedor>
From:   Fabien DESSENNE <fabien.dessenne@foss.st.com>
Message-ID: <ad53072e-e497-3321-eaa4-bbe8b2da2af4@foss.st.com>
Date:   Wed, 26 Jan 2022 09:29:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220125021353.GA29777@embeddedor>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_02,2022-01-25_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

Thank you for the patch.
I am fine with it with a nit picking comment regarding the non-mandatory 
80 characters line break [1].

BR

Fabien

[1] https://lkml.org/lkml/2020/5/29/1038


On 25/01/2022 03:13, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/hwspinlock/stm32_hwspinlock.c:84:32: warning: using sizeof on a
> flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/hwspinlock/stm32_hwspinlock.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwspinlock/stm32_hwspinlock.c
> b/drivers/hwspinlock/stm32_hwspinlock.c
> index 5bd11a7fab65..716ad4401249 100644
> --- a/drivers/hwspinlock/stm32_hwspinlock.c
> +++ b/drivers/hwspinlock/stm32_hwspinlock.c
> @@ -73,15 +73,14 @@ static int stm32_hwspinlock_probe(struct
> platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct stm32_hwspinlock *hw;
>   	void __iomem *io_base;
> -	size_t array_size;
>   	int i, ret;
>   
>   	io_base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(io_base))
>   		return PTR_ERR(io_base);
>   
> -	array_size = STM32_MUTEX_NUM_LOCKS * sizeof(struct hwspinlock);
> -	hw = devm_kzalloc(dev, sizeof(*hw) + array_size, GFP_KERNEL);
> +	hw = devm_kzalloc(dev, struct_size(hw, bank.lock,
> STM32_MUTEX_NUM_LOCKS),
> +			  GFP_KERNEL);

No need from line break here.


>   	if (!hw)
>   		return -ENOMEM;
>   
> 
