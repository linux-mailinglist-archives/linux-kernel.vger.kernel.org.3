Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263AE582877
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiG0OVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiG0OVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:21:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E7BE01;
        Wed, 27 Jul 2022 07:21:11 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RECiek008601;
        Wed, 27 Jul 2022 14:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NNEtgKqQd2Ulg0EEpFDmrESfRAQBHwM464PULugCseQ=;
 b=o6fhW9/vzs/8LNmVT0agAI1yC2FuFhKbEPZxrTSACAUolBQFn4a26A72/go9wRdGchw0
 c8mxQvCGMM1vNgbWmzh7A4fivgMNzPXQie5qZXpO4b0Ncv1ZnSgV5cxHZ2kRehZIXQVt
 ZmMF6YDsWuPaa49w1kDQLqwAldKiGMBDdP3QdUkK4Xtr++ccwAYSMXH9HgCu+QAIbt8h
 c+XItakkXXU2xBNuZTlfGV7E5euww4MYOfaDcc+SkiEEBHsZgScVRp5rqgwdMElhO1xU
 j2KJV5+2I2OuSz003ZldZU3f4Gl2zYxaI4hQjik34C6mDyRKf6P3On1ob7TzkLYP6HWq EQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hk6gf1pw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 14:21:01 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26RE7xZd019128;
        Wed, 27 Jul 2022 14:20:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3hg95ybwca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 14:20:58 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26REIsPL23658804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 14:18:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5BF34C040;
        Wed, 27 Jul 2022 14:20:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA53E4C044;
        Wed, 27 Jul 2022 14:20:55 +0000 (GMT)
Received: from [9.145.87.150] (unknown [9.145.87.150])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jul 2022 14:20:55 +0000 (GMT)
Message-ID: <4dd9afa4-ddc1-c6c9-1205-bca28a858022@linux.ibm.com>
Date:   Wed, 27 Jul 2022 16:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH] watchdog: Fix build error when CONFIG_SOFTLOCKUP_DETECTOR
 is not set
Content-Language: fr
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-next@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>
References: <20220727092109.31362-1-ldufour@linux.ibm.com>
 <87sfmmaipn.fsf@mpe.ellerman.id.au>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <87sfmmaipn.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2bS7xJeYOh8k7OEL6uh4WyRS94ZLkDnt
X-Proofpoint-ORIG-GUID: 2bS7xJeYOh8k7OEL6uh4WyRS94ZLkDnt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_05,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/07/2022 à 13:38, Michael Ellerman a écrit :
> Laurent Dufour <ldufour@linux.ibm.com> writes:
>> Sachin reported the following build error when CONFIG_SOFTLOCKUP_DETECTOR
>> is not set:
>>
>> kernel/watchdog.c:597:20: error: static declaration of 'lockup_detector_reconfigure' follows non-static declaration
>>  static inline void lockup_detector_reconfigure(void)
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> In file included from kernel/watchdog.c:17:
>> ./include/linux/nmi.h:125:6: note: previous declaration of 'lockup_detector_reconfigure' was here
>>  void lockup_detector_reconfigure(void);
>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> The definition of lockup_detector_reconfigure should be exported even in
>> that case, and __lockup_detector_reconfigure should remain static.
>>
>> Fixes: 24a1260705b7 ("watchdog: export lockup_detector_reconfigure")
>> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>> ---
>>  kernel/watchdog.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Thanks.
> 
> I'll squash that in to the original commit.

Thanks Michael,

I was thinking this is too late for such a squash.

Laurent.

