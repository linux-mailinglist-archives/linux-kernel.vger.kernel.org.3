Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D137581459
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbiGZNnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiGZNnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:43:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8760A1F2EA;
        Tue, 26 Jul 2022 06:43:10 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QDSEe7012478;
        Tue, 26 Jul 2022 13:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=KrGdGKXWL5EiS24fDeakBE3paAJ7JseQ0e2+cmPL8Ek=;
 b=CXGrUNYCGD2LfISUrlybA54C8tmlXnsttZ63NVuaJBF6EVrsGRqHEfKx7gKB/QnF5g2p
 jfGcU+1kzIleIFrLgGq7C1RUBz5kHhznWaPFa6qJcOAixO8H/Wxh9pAOBFpofQaUaP/8
 UDSETbL2faMAuLMmeL3mDVQmtdmJluDfFnk/PZeRV4T4faEhRM7vvKtgXGfAoglEPENF
 l7tUDZ6MISg8lZ/pZrxbB2k6oXaUNt+2o32CTlhQaAzW5ZRiI1AwLICwjid5BSezLkal
 QRvUOUCj0b/5uCVujTYB7joa7++sAlj/94xLxV6bSHOaCiSTDU1YPTmnkZYRcOEZQm+l fg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjg662tdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 13:43:09 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26QDLKuZ000760;
        Tue, 26 Jul 2022 13:43:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3hg945jvjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 13:43:07 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26QDh4Md23527862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 13:43:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05BB542041;
        Tue, 26 Jul 2022 13:43:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C40874203F;
        Tue, 26 Jul 2022 13:43:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Jul 2022 13:43:03 +0000 (GMT)
Date:   Tue, 26 Jul 2022 15:43:02 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.19
Message-ID: <Yt/vZo1eY8/C/6DU@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8WI6ifq59KNLluKgdNSFNTuAVkDWKqqZ
X-Proofpoint-GUID: 8WI6ifq59KNLluKgdNSFNTuAVkDWKqqZ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 mlxlogscore=785 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.19.

Thank you,
Alexander

The following changes since commit 2f23256c0ea20627c91ea2d468cda945f68c3395:

  s390/ap: fix error handling in __verify_queue_reservations() (2022-07-06 17:43:29 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-7

for you to fetch changes up to 918e75f77af7d2e049bb70469ec0a2c12782d96a:

  s390/archrandom: prevent CPACF trng invocations in interrupt context (2022-07-13 15:17:21 +0200)

----------------------------------------------------------------
s390 updates for 5.19

- Prevent relatively slow PRNO TRNG random number operation
  from being called from interrupt context. That could for
  example cause some network loads to timeout.
----------------------------------------------------------------

Harald Freudenberger (1):
  s390/archrandom: prevent CPACF trng invocations in interrupt context

 arch/s390/include/asm/archrandom.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
