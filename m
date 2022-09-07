Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5115B0ACE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIGQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiIGQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:56:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EFBBBA57
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:56:32 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287FJa2W005618;
        Wed, 7 Sep 2022 16:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mF99mamVuuLkaTpFjpFy/FqD8j2D34RrsXMyHYjIpXc=;
 b=iNde3zFYVzz5KR1RutvwW/JWXZR9x+RRCmX9FPn/PFfWT+FaxNCT9nYFCqw4ydeLrPlV
 /db1suYeDeX14+pF+ZoaJbol28i9k1BbAVrpc4lbOpXZiVF03WLPefjtkPJ17MMqLt7a
 X7W515iofNfdSZKhOMiQWXqcngQ0DVIBwh5p6so19FFVs3mZ/ZadQMg3FGiEqlOmQFyk
 IyrH8HdkxjcBVs8phAItgTVsCWy6gqXSUdjh78AG2KVvgNsKS/RuR07uQu+mjLEODgDA
 XZPA3NuoRsjriMRgFLtCNsbNyY7IMDj9ok3/thI2+aDwLvmX6lIWBWVI/PiLnXnvvRTI zA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jefntb0vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 16:56:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 287GuI1A029289
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 16:56:18 GMT
Received: from [10.110.17.89] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 09:56:17 -0700
Message-ID: <f5d17990-ec36-e930-be33-e2566b9c0593@quicinc.com>
Date:   Wed, 7 Sep 2022 09:56:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [mani-mhi:mhi-next 2/3]
 drivers/bus/mhi/host/pci_generic.c:734:60: error: assignment of member 'irq'
 in read-only object
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>
References: <202209072144.lWoBySRH-lkp@intel.com>
 <20220907164506.GA499781@thinkpad>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220907164506.GA499781@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bgkEWnsr0yUwN5vA_t9piW0t6Xb8YQHt
X-Proofpoint-GUID: bgkEWnsr0yUwN5vA_t9piW0t6Xb8YQHt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_08,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070066
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2022 9:45 AM, Manivannan Sadhasivam wrote:
> On Wed, Sep 07, 2022 at 09:47:42PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
>> head:   0a3b31f6259f4849e4e93731d4c8d7910be072a7
>> commit: 4a98958ca237a4b7974ea1ec2092b3666bdd26ab [2/3] bus: mhi: host: make mhi_controller_config::event_cfg const
>> config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220907/202209072144.lWoBySRH-lkp@intel.com/config)
>> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
>> reproduce (this is a W=1 build):
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?id=4a98958ca237a4b7974ea1ec2092b3666bdd26ab
>>          git remote add mani-mhi https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
>>          git fetch --no-tags mani-mhi mhi-next
>>          git checkout 4a98958ca237a4b7974ea1ec2092b3666bdd26ab
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/bus/mhi/host/pci_generic.c: In function 'mhi_pci_get_irqs':
>>>> drivers/bus/mhi/host/pci_generic.c:734:60: error: assignment of member 'irq' in read-only object
>>       734 |                         mhi_cntrl_config->event_cfg[i].irq = 0;
> 
> Ah, so this is why I didn't make it constant in the first place...
> Dropped the patch now.
> 
> Thanks,
> Mani

I believe it should be const in the MHI config, but in this case the 
declaration in drivers/bus/mhi/host/pci_generic.c can't be const.

Let me respin the patch with this in mind.

