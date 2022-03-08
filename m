Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A584D2272
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350223AbiCHUW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350244AbiCHUWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:22:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3254692;
        Tue,  8 Mar 2022 12:21:57 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228HJJx1003039;
        Tue, 8 Mar 2022 20:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=aUmpq3/gedphZ0HCbq8IcpU6KYbu4FDfoTHZmJKY8zM=;
 b=Xe6eyj7QrWGgC0kTioz4yjCw3Gb92o2whnCljwc4aVrS/JyOS5KbLYeZDkNhdzQUhObw
 ZlGm519azKOV7mxXcSs94tHvrT7IHY737MDfRBkx8U74HxVsgkLVQtRVK0wIRpQJTvIQ
 8QcSk9TyXyn3sPA3NsRLZJ2VETbgewklATab58NYyrvzIhKfygC1SeVHd1QCCT4sHbv+
 OrYoPMDjsgdCrn1PqcQs1TwM79BmAs46q9kLYlHh0sJ7ztQoDshuy8CJFxPgVq7Ujz7u
 DHauMr3GGz4WR/0H3VDIX7Q0bj9ZHWt93RKziK5vzrTWFxRZpxD1gMvmKwNnaWO8Qqsk KQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3env4uee4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 20:21:47 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228JaXAL012109;
        Tue, 8 Mar 2022 20:21:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3ekyg977wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 20:21:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228KLhI251577294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 20:21:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 008B1AE051;
        Tue,  8 Mar 2022 20:21:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EF0AAE04D;
        Tue,  8 Mar 2022 20:21:42 +0000 (GMT)
Received: from localhost (unknown [9.171.69.133])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Mar 2022 20:21:42 +0000 (GMT)
Date:   Tue, 8 Mar 2022 21:21:41 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <your-ad-here.call-01646770901-ext-3299@work.hours>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303201312.3255347-7-kbusch@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FrdWzzvmbea_LPGEzKr2854rpZdc0D5Q
X-Proofpoint-ORIG-GUID: FrdWzzvmbea_LPGEzKr2854rpZdc0D5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_08,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=822 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> Hardware specific features may be able to calculate a crc64, so provide
> a framework for drivers to register their implementation. If nothing is
> registered, fallback to the generic table lookup implementation. The
> implementation is modeled after the crct10dif equivalent.

Hi Keith,

this is failing on big-endian systems. I get the following on s390:

[    0.551573] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
[    0.551575] crc32: self tests passed, processed 225944 bytes in 118879 nsec
[    0.551697] crc32c: CRC_LE_BITS = 64
[    0.551698] crc32c: self tests passed, processed 112972 bytes in 58963 nsec
[    0.577325] crc32_combine: 8373 self tests passed
[    0.603321] crc32c_combine: 8373 self tests passed
[    0.603502] alg: shash: crc64-rocksoft-generic test failed (wrong result) on test vector 0, cfg="init+update+final aligned buffer"
[    0.603506] ------------[ cut here ]------------
[    0.603507] alg: self-tests for crc64-rocksoft-generic (crc64-rocksoft) failed (rc=-22)
[    0.603542] WARNING: CPU: 0 PID: 43 at crypto/testmgr.c:5726 alg_test+0x3c2/0x638
[    0.603554] Modules linked in:
[    0.603557] CPU: 0 PID: 43 Comm: cryptomgr_test Not tainted 5.17.0-rc7-next-20220308-118584-gcb153b68ff91 #168
[    0.603560] Hardware name: IBM 8561 T01 701 (KVM/Linux)
[    0.603562] Krnl PSW : 0704e00180000000 00000000007d2286 (alg_test+0x3c6/0x638)
[    0.603565]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[    0.603568] Krnl GPRS: 00000000ffffffea 000000000177c350 000000000000004b 00000000ffffefff
[    0.603570]            0000000001663ed0 0000038000000001 0000000001ed1720 0000000081a4e480
[    0.603572]            0000000081a4e400 000003800000003e ffffffffffffffea 000000000000003e
[    0.603611]            0000000081a5a100 000000000000003e 00000000007d2282 00000380001b7cf0
[    0.603618] Krnl Code: 00000000007d2276: c02000495b9e        larl    %r2,00000000010fd9b2
[    0.603618]            00000000007d227c: c0e50026dbc6        brasl   %r14,0000000000cada08
[    0.603618]           #00000000007d2282: af000000            mc      0,0
[    0.603618]           >00000000007d2286: b904002a            lgr     %r2,%r10
[    0.603618]            00000000007d228a: eb6ff1380004        lmg     %r6,%r15,312(%r15)
[    0.603618]            00000000007d2290: 07fe                bcr     15,%r14
[    0.603618]            00000000007d2292: 47000700            bc      0,1792
[    0.603618]            00000000007d2296: 1842                lr      %r4,%r2
[    0.603632] Call Trace:
[    0.603634]  [<00000000007d2286>] alg_test+0x3c6/0x638
[    0.603636] ([<00000000007d2282>] alg_test+0x3c2/0x638)
[    0.603638]  [<00000000007cfff8>] cryptomgr_test+0x68/0x70
[    0.603641]  [<000000000017b228>] kthread+0x108/0x110
[    0.603646]  [<0000000000103374>] __ret_from_fork+0x3c/0x58
[    0.603650]  [<0000000000ccc3ba>] ret_from_fork+0xa/0x40
[    0.603658] Last Breaking-Event-Address:
[    0.603659]  [<0000000000cada68>] __warn_printk+0x60/0x68
[    0.603663] ---[ end trace 0000000000000000 ]---
