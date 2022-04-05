Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ADC4F4301
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447223AbiDEUJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457533AbiDEQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:06:29 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00533DDA;
        Tue,  5 Apr 2022 09:04:29 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 235ANpX7013964;
        Tue, 5 Apr 2022 18:04:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=siZuhc+89Jo9JDA/pbHU2hXuJ1K7MHFkUHJM38FJfmw=;
 b=wjcnvV0EE/7FrSLN1x2A8CbH1mUtD2blQDYwa/L32Abma3dUt+KypinbB/YCNajWtFRR
 QadwC+5pppvKXtF3T6KAambfwcr1uH0TliGG7d6+ouJmyV3NWFJuyV+uZr5518Kqdl1K
 a13t6OlHsHmNUdYADAkZMHSN+M/cwhN831PcTFBt8sK6vXkjYAt6rzpPUR9WHhoKqq+p
 QVcZ7bLp90qHjeOSFj3rZBdGRWPcymFcg+kHOsbAchmw/bHXthgRkClkD4q4CSyW+Mla
 7qV2fe7yPDnofLmlafzNRa+H81c99c1eodrCAB5twZ3IUZbrPwLa+4znao1AkP0xyOD+ +Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f6du0r4em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 18:04:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C2A4810002A;
        Tue,  5 Apr 2022 18:04:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9B6DB245534;
        Tue,  5 Apr 2022 18:04:08 +0200 (CEST)
Received: from [10.201.20.246] (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 5 Apr
 2022 18:04:07 +0200
Message-ID: <9f10659b-a778-1c9b-09ba-bd4dbc3f7c66@foss.st.com>
Date:   Tue, 5 Apr 2022 18:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] arm64: defconfig: Config that had RPMSG_CHAR now gets
 RPMSG_CTRL
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20220405115524.1020499-1-arnaud.pouliquen@foss.st.com>
 <20220405152555.GB4147585@p14s>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220405152555.GB4147585@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-05_04,2022-04-05_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/22 17:25, Mathieu Poirier wrote:
> On Tue, Apr 05, 2022 at 01:55:24PM +0200, Arnaud Pouliquen wrote:
>> In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
>> from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
>> By default give everyone who had the old driver enabled the rpmsg_ctrl
>> driver too.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> 
> This patch is missing a separation marker, i.e "---", just above.  Without it
> the text below is also included in the changelog, and it shouldn't.

A badly controlled cleaning... I send a V3

My apologizes,
Arnaud 

> 
> Thanks,
> Mathieu
> 
>>
>> This patch is extracted from the series [1] that has been partially
>> integrated in the Linux Kernel 5.18-rc1.
>>
>> Update vs previous version:
>> - remove "Fixes:" tag in commit, requested by Mathieu Poirier in [2]
>>
>> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
>> [2]https://lore.kernel.org/linux-arm-kernel/CANLsYky1_b80qPbgOaLGVYD-GEr21V6C653iGEB7VCU=GbGvAQ@mail.gmail.com/T/
>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 50aa3d75ab4f..3f8906b8a2ca 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1053,6 +1053,7 @@ CONFIG_QCOM_Q6V5_PAS=m
>>  CONFIG_QCOM_SYSMON=m
>>  CONFIG_QCOM_WCNSS_PIL=m
>>  CONFIG_RPMSG_CHAR=m
>> +CONFIG_RPMSG_CTRL=m
>>  CONFIG_RPMSG_QCOM_GLINK_RPM=y
>>  CONFIG_RPMSG_QCOM_GLINK_SMEM=m
>>  CONFIG_RPMSG_QCOM_SMD=y
>> -- 
>> 2.25.1
>>
