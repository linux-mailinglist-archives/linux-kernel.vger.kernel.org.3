Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6167557512C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiGNO4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGNO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:56:15 -0400
X-Greylist: delayed 1524 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 07:56:14 PDT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9F852464
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:56:14 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ECRddX021374;
        Thu, 14 Jul 2022 14:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LupV7ixCNZWBwIe/ErNzqPMhAB4KwQY5KFAC5+6N81I=;
 b=iacV4VwHrh2/PWIfASO32ZyamggQqsBCDma/Q9pUShiH3hO6KTSZHj0I8SxWwXh5UVLJ
 K68BwkO84V+6fL5S8KfYBGHJg9wb8Atg2rOedW9n88E9/f0/jFQxmlL0s0Weldy49qXD
 eVw7rLRwE3ufRcTqzVipHR7sqMAIlfk5p0VP5Y/5qymX502qqebbFCBe7KWkW8/6wpHR
 0bzMaf65K4HkZWjmjDPcx56kU1Y8wUzguMQkCRlkvBPeflzj0CMgCjiIZdcl20SKlU8W
 B1zaVmvwKrkLfF7AQAO2Fyt9CmnxxXtTXXtilXLVEo91A8QPC4N5NXYs/I0FaWDv7XUt yQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3h9wwcuan3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 14:30:24 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26EEUNEx001570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 14:30:23 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 07:30:23 -0700
Received: from [10.110.120.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Jul
 2022 07:30:22 -0700
Message-ID: <114fcde6-bdf7-68ee-d031-35a916027aee@quicinc.com>
Date:   Thu, 14 Jul 2022 07:30:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for W25Q512NW-IQ/IN
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
CC:     <clg@kaod.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <p.yadav@ti.com>,
        <quic_ggregory@quicinc.com>, <quic_jiles@quicinc.com>,
        <tudor.ambarus@microchip.com>
References: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
 <20220711095042.2095360-1-michael@walle.cc>
 <a42fbef2-3eff-9e88-233e-a805cfbe2376@quicinc.com>
 <4972a85d04e39ebb7b4a5872f6632c45@walle.cc>
 <2260955b-354d-ceda-cadc-49453bfca3e4@quicinc.com>
 <00f0c9d480ef5a414f1c34492661bd9e@walle.cc>
 <63cedfce-34bb-ed63-3871-75a6c3dd5d73@quicinc.com>
 <6be710bb5c1bf0449e54a54b78f6f7a0@walle.cc>
 <47c01d768ea56edc9a2f9d317af7b495@walle.cc>
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
In-Reply-To: <47c01d768ea56edc9a2f9d317af7b495@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GTO82u501krg2h7VqTPnVsPOzWiQ18Js
X-Proofpoint-ORIG-GUID: GTO82u501krg2h7VqTPnVsPOzWiQ18Js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_10,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=903 mlxscore=0 clxscore=1011 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/2022 7:21 AM, Michael Walle wrote:
> Am 2022-07-14 16:16, schrieb Michael Walle:
>> Am 2022-07-14 15:47, schrieb Jae Hyun Yoo:
>>> On 7/14/2022 12:41 AM, Michael Walle wrote:
>>>> What does "doesn't boot at all" mean? Are there any kernel startup
>>>> messages?
>>>
>>> I'm sharing the error messages below.
>>
>> Thanks.
>>
>>> [    0.748594] spi-nor spi0.0: w25q512nwq (65536 Kbytes)
>>> [    0.865216] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 
>>> [0x406c0741]
>>> [    0.872833] ------------[ cut here ]------------
>>> [    0.877984] WARNING: CPU: 1 PID: 1 at drivers/mtd/mtdcore.c:583
>>> add_mtd_device+0x28c/0x53c
>>> [    0.887237] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
>>> 5.15.43-AUTOINC-dirty-23801a6 #1
>>
>> Could you please try it on the latest (vanilla) linux-next?
> 
> or spi-nor/next [1] as there are quite a lot of changes. The
> patches shall be based on that.

Okay. Let me try that. I tested it using 5.15.43 with back-ported
spi-nor patches from the latest. I'll back-port more changes from
the spi-nor/next and will test the INFO(0xef6020, 0, 0, 0) setting
again.

-Jae

> -michael
> 
> [1] 
> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git#spi-nor/next
