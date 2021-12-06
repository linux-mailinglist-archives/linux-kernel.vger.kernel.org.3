Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86563469601
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbhLFM5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:57:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243423AbhLFM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:57:00 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6BRJ24023793;
        Mon, 6 Dec 2021 12:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=H6m35SoZ4Ana9r8BQ7GvxH1od4yyAkLYvYTpN25udGI=;
 b=N169qN0UvunE7WLAy4UlwXPoGMr5Tu6ju62yi5eAvIcqZUdFdPy7905ju9z8zLTgTIi7
 aIq52qLRTwO+/CbQYkzCBohOcElNszzNoD+kVdBFiScKQ1DSvBPLPboV5UdYZuWBCdCo
 sg3rHkTdR2k1cRRNSvhszoelfPsVbSHC35kiFdxf0ygGBPdiWbKcyxx0oAhrm6vaUNle
 oEUc/etRkm9iqQvhhgZjsHVi975fatG0iiONqqDHKPwKO0dg/EyZ8eTt7pPpSDnkpfMm
 5H3kTAx1XF1Jrldth9Ak8ngilXZ6FlUAqexM96AHgnYg7JteMYrIPzow1fqRdGnmS1ut Hw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csfa8cgw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 12:53:18 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Chkqd012344;
        Mon, 6 Dec 2021 12:53:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3cqyy9mtnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 12:53:16 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6CrD4L29295094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 12:53:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81011A4060;
        Mon,  6 Dec 2021 12:53:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46DE2A4064;
        Mon,  6 Dec 2021 12:53:13 +0000 (GMT)
Received: from osiris (unknown [9.145.12.237])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Dec 2021 12:53:13 +0000 (GMT)
Date:   Mon, 6 Dec 2021 13:53:11 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the driver-core tree
Message-ID: <Ya4Ht2K9x2+lUtuR@osiris>
References: <20211206193050.17ad78aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206193050.17ad78aa@canb.auug.org.au>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O7WWFLt4nlmKSXaxGScShcl1yqnDb2Cc
X-Proofpoint-GUID: O7WWFLt4nlmKSXaxGScShcl1yqnDb2Cc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_04,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 07:30:50PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/admin-guide/cputopology.rst:49: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   f1045056c726 ("topology/sysfs: rework book and drawer topology ifdefery")

Thanks for reporting!

Greg, please find below a patch which fixes this. I added a full
changelog just in case you don't want to rebase your branch so it can
be applied on top, instead of being merged into the existing patch.

From 7450195242db825520efbddef5df6f337dbf686f Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Mon, 6 Dec 2021 13:37:20 +0100
Subject: [PATCH] topology/sysfs: get rid of htmldoc warning

Stephen Rothwell reported the following warning caused by commit
f1045056c726 ("topology/sysfs: rework book and drawer topology
ifdefery"):

Documentation/admin-guide/cputopology.rst:49: WARNING: Block quote
ends without a blank line; unexpected unindent.

To fix this remove the extra indentation again.

Fixes: f1045056c726 ("topology/sysfs: rework book and drawer topology ifdefery")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 Documentation/admin-guide/cputopology.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index 677ba1c2c820..d29cacc9b3c3 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -37,15 +37,15 @@ To be consistent on all architectures, include/linux/topology.h
 provides default definitions for any of the above macros that are
 not defined by include/asm-XXX/topology.h:
 
- 1) topology_physical_package_id: -1
- 2) topology_die_id: -1
- 3) topology_cluster_id: -1
- 4) topology_core_id: 0
- 5) topology_book_id: -1
- 6) topology_drawer_id: -1
- 7) topology_sibling_cpumask: just the given CPU
- 8) topology_core_cpumask: just the given CPU
- 9) topology_cluster_cpumask: just the given CPU
+1) topology_physical_package_id: -1
+2) topology_die_id: -1
+3) topology_cluster_id: -1
+4) topology_core_id: 0
+5) topology_book_id: -1
+6) topology_drawer_id: -1
+7) topology_sibling_cpumask: just the given CPU
+8) topology_core_cpumask: just the given CPU
+9) topology_cluster_cpumask: just the given CPU
 10) topology_die_cpumask: just the given CPU
 11) topology_book_cpumask:  just the given CPU
 12) topology_drawer_cpumask: just the given CPU
-- 
2.32.0

