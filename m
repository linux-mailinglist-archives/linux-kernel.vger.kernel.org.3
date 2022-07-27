Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D213C582381
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiG0Jyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiG0Jyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:54:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79782220E2;
        Wed, 27 Jul 2022 02:54:39 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R9Ndhl005647;
        Wed, 27 Jul 2022 09:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vw/E6rEnxAsVPMswqMXlt7xlMZHwJZUQCy6gXVnRmCw=;
 b=iEFSA6Xd1YVWOXLBKmHceGxbHjjlNY96tbwEJ2LL8IDpv7l4SEjNMZLFy9RF9aKQeWiL
 NUc7RWhYkUnN6LeWnPtP7Xwud79uFC9Azx4j2FHCcNfvr6MWjppxhZ3y4CE61yr8NX2j
 ZbYn0GMUPgEGFMn+TkvFbGd97h8AuRzJdxuSC8+3XsZHPXNu5rcCQIlCPF0CFhf8/yG+
 PgGsAXakmwrHVAPo8LL2Kp+D3nQF0JSAcIAipBCcHF45/6G2P2OhrIEdVqwuWeDH8XRK
 YqFTTDF58cZYSjbu/x7VdyH0Ql+Ol1w4yxhil09JZ1nfSER4rB8scnAnyc9Vpi6LkKKq Hw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hk2pn8v3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 09:54:32 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26R9oEPE010016;
        Wed, 27 Jul 2022 09:54:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3hg94ebpkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 09:54:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26R9qRjd24314348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 09:52:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B55C11C04C;
        Wed, 27 Jul 2022 09:54:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A2ED11C04A;
        Wed, 27 Jul 2022 09:54:27 +0000 (GMT)
Received: from [9.171.1.91] (unknown [9.171.1.91])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jul 2022 09:54:27 +0000 (GMT)
Message-ID: <9a2743ee-28e1-f49d-8b2d-4850ce7ca524@linux.ibm.com>
Date:   Wed, 27 Jul 2022 11:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf/tests: Fix test case 95 Check branch stack sampling
 on s390
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        german.gomez@arm.com
References: <20220727071159.173360-1-tmricht@linux.ibm.com>
 <62efe3a0-21d7-dfee-2532-cf2090359548@arm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <62efe3a0-21d7-dfee-2532-cf2090359548@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ADVDdqARLfxkzbEFywWd193H9e_WVTlX
X-Proofpoint-ORIG-GUID: ADVDdqARLfxkzbEFywWd193H9e_WVTlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 11:27, James Clark wrote:
> perf record -b -o- -e dummy -B true

I think you refer to the attr member branch_sample_type which should be
non-zero for branches, will look into this. Thanks

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
