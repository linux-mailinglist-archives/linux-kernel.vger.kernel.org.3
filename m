Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696DE55D54D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbiF1Maz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345814AbiF1Maw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:30:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB592DA90;
        Tue, 28 Jun 2022 05:30:51 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SBa3w2028791;
        Tue, 28 Jun 2022 12:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DpYd0mrS1evvQ/K7s1/OnGEiIdxTgUfld+Nb94O7C/M=;
 b=tViD1EBea0OA1XZJORkKssFbpTA/epXHzmbjgMj23z9idOf64c8BWLZZxaxmRkreMn5n
 rLcXEDh8pRTNn1YxMBt4Nto1HtCZtPG2id9f9+5d8kk/DWgp9W6sc9HTUc43kwq1rX/L
 bpVuoSQ3cOxsAb0voys01C/8uM08e20MbYKMa8bFUqxQGWoMuQ/YXRkgEWHWISOpKeMD
 q+7PMHdRaDfWg0cvKK8Vg3/E57clc2yiOINFrc4YESWjYhILyhytTfRoS+CMp6EoFm9c
 vGyXIeIUEdCUuMplUHGxlYp0HgilWffSGA+4FheseUf/mFyJgrWZ0/5+0DKQx4nZT2VL xA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gyxwrw8yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 12:30:47 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SCKi4H000824;
        Tue, 28 Jun 2022 12:30:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3gwsmhum5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 12:30:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SCUgNe18350522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 12:30:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72E564C044;
        Tue, 28 Jun 2022 12:30:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 085484C046;
        Tue, 28 Jun 2022 12:30:42 +0000 (GMT)
Received: from [9.145.90.158] (unknown [9.145.90.158])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jun 2022 12:30:41 +0000 (GMT)
Message-ID: <7d8686a5-9ef4-36e3-dd63-9c69e0b846f4@linux.ibm.com>
Date:   Tue, 28 Jun 2022 14:30:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] s390/dasd: drop unexpected word 'for' in comments
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>, hoeppner@linux.ibm.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220623102114.33249-1-jiangjian@cdjrlc.com>
From:   Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20220623102114.33249-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lcm9ckjWGxElW8D7rd4bPh5HFAWLWEtA
X-Proofpoint-ORIG-GUID: Lcm9ckjWGxElW8D7rd4bPh5HFAWLWEtA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=988 lowpriorityscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206280051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.06.22 um 12:21 schrieb Jiang Jian:
> there is an unexpected word 'for' in the comments that need to be dropped
>
> file - drivers/s390/block/dasd.c
> line - 1728
>
> 	/* check for for attention message */
>
> changed to:
>
> 	/* check for attention message */
>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---

applied, thanks


