Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241F757143A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiGLIRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiGLIRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:17:23 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9F3A1244;
        Tue, 12 Jul 2022 01:17:22 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C6FC1w017805;
        Tue, 12 Jul 2022 10:17:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=V6sjMB7RYrAmyXGWjhUGVzI5Qe/pzRzlrpCoknQyqNs=;
 b=hR8WRcgff5vb8gEEHH7cKung5pd0Mn+XE0gch4XVWOT7VRjf9d0uO4gUkC89ue5wloJK
 xPNI6YH2vSVQsayiBpmH9ng7JhhV4gOE3GXKkoYkQBMjDpl0LhoNN64yHx4+BZRtGiNd
 PDwYv14fQ8Kq+8JCZP6Clbt5eGY+Cl3OHhMe6tn+yLOyoVEEDsPW0CGLs+NU3b8Astau
 LUeDgz4aAFEhapyxWI8oULgU/87iTBFZ8tVjNlMYwt2o47M+AvcSkldQmwVW/aY8chsm
 ct4maonrWSvFa4PWyt8/uxKSMG4b7qK8N8Q5nMHe6tN582sIHpc7gSgI05Q/2hgELMRN JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h71127u5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 10:17:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B258D10002A;
        Tue, 12 Jul 2022 10:17:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A59A1212FA9;
        Tue, 12 Jul 2022 10:17:03 +0200 (CEST)
Received: from [10.201.20.246] (10.75.127.45) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 12 Jul
 2022 10:17:02 +0200
Message-ID: <18ffb30b-692d-4a67-896d-7b9485734336@foss.st.com>
Date:   Tue, 12 Jul 2022 10:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] arm64: defconfig: Config that had RPMSG_CHAR now gets
 RPMSG_CTRL
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20220405161114.1107745-1-arnaud.pouliquen@foss.st.com>
 <c497e1ef-5a62-d956-4516-87e7b53a6001@foss.st.com> <YpdutV3/jOsfPb5c@arm.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <YpdutV3/jOsfPb5c@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_05,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 6/1/22 15:50, Catalin Marinas wrote:
> On Wed, Jun 01, 2022 at 03:25:42PM +0200, Arnaud POULIQUEN wrote:
>> Gentle reminder.
>> Please notice that Mathieu replied with a "Reviewed-by".
> 
> We usually leave the defconfig updates to the SoC team. Cc'ing Arnd.

This patch seems still be stalled, should I resent it?

Thanks,
Arnaud

> 
> Catalin
> 
>> Thanks,
>> Arnaud
>>
>> On 4/5/22 18:11, Arnaud Pouliquen wrote:
>>> In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
>>> from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
>>> By default give everyone who had the old driver enabled the rpmsg_ctrl
>>> driver too.
>>>
>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>> ---
>>>
>>> This patch is extracted from the series [1] that has been partially
>>> integrated in the Linux Kernel 5.18-rc1.
>>>
>>> Update vs previous version:
>>> - Add missing "---" separation marker after "Signed-off-by".
>>>
>>> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
>>> [2]https://lore.kernel.org/linux-arm-kernel/CANLsYky1_b80qPbgOaLGVYD-GEr21V6C653iGEB7VCU=GbGvAQ@mail.gmail.com/T/
>>> ---
>>>  arch/arm64/configs/defconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 50aa3d75ab4f..3f8906b8a2ca 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -1053,6 +1053,7 @@ CONFIG_QCOM_Q6V5_PAS=m
>>>  CONFIG_QCOM_SYSMON=m
>>>  CONFIG_QCOM_WCNSS_PIL=m
>>>  CONFIG_RPMSG_CHAR=m
>>> +CONFIG_RPMSG_CTRL=m
>>>  CONFIG_RPMSG_QCOM_GLINK_RPM=y
>>>  CONFIG_RPMSG_QCOM_GLINK_SMEM=m
>>>  CONFIG_RPMSG_QCOM_SMD=y
