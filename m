Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E60553BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354488AbiFUUsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354381AbiFUUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A492CE39
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ5LR7018710;
        Tue, 21 Jun 2022 20:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WuBThV3pbFu5lKOpBch58kBnl6+HqWOGEiVAnZJnRaA=;
 b=xNwdsBJLZAmifMzidb1tgUN2/dmiKG/aVdAljTC2g5q7Y/GaQJSZq3qI5ncMM6sKgDxT
 SnFl0Lnc0lgzkcVpb5CQtR/iAE4XGJ7CQKwFMLppuOJ0OiWa5opSQHlqQ9Yl3hrTvKCY
 Is+5ccVN8qmiW/MvN4CfKplsikeop5iFVpRgnBXJp4W+uJz3esVtJXlL4gJ2TxNaOogv
 /cEbvBTkvNKJs/IH9/zwBOjiF94vLd7gdjS8cFbxZBPBbsl054zoTLY5HDPOligWYQnq
 Y0dLVUL6SbYZW8fwU9DRi8U7g0a2rpzcSqAR8qd9QveIQLqtBibV+8l+jeNY4RC1Q3Av /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhX027847;
        Tue, 21 Jun 2022 20:47:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp0s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8anZ+PsfBIqk1+rZ+gaFqCxxltjAKb2ovx5ZyngCLlj6c1+25iPARN3WvYqVGXvwe6ipTvO/mJ+dyE4EuqOyVAZKE66gbZqqUDbf2FpCbSSMFPmrcp7mjooZCxU92E5S4Ob3VLVwHXWoOS5Jb9bRsYRMnLP/lIwjtdaAHW3J+qfFIPaM3eF3zqQSojKUGG8TabpJJo0bNwogXZWB2gKFne2+Fh1Yj06FyrP3DEnSwxhpCnYnvBH1lMwWunkfuEcTQEuEDPvhTkzXEvAITvlYk1gxRALZPaIxH98vZCiCjK+fpxXEOhm4W14+HIvb2ufVb/lc989sXew0JKKx3hwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuBThV3pbFu5lKOpBch58kBnl6+HqWOGEiVAnZJnRaA=;
 b=QF0tDTf6WAbrPVSXBoTzMDFLD8C0vVzTWDPo5HVmt117gQJAXyXW4gNe8S/r0eBGJyVLQtIoIz5LndUwELQWhdlvTJhJHRbMmxPlW/ZoeiC+8mwXYAsAoUdidySHNaHqhD2ml1Oo5PJX9N1N7QHrF6/J+mxZ4D/oh7+nigixqbBno3u6aVxeuzjrXLIyhtkRT0iAO/nt5zqWyNknkbCGWDZPGrduDFFevYEZyZHIu23KdYEuphl/5HiQZHrm5WgRtb51RWAWdMU0T5TJTBB2Tl6ZfqRCPoBED6JFHNEWgOZGcQNrRo3mCEE7WqzO18UdpN89qGuORYTcKAoh3ly0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuBThV3pbFu5lKOpBch58kBnl6+HqWOGEiVAnZJnRaA=;
 b=t03lGweEfV4ucMSGCfXTAYwGk+U207KaL+oOSmW0IinmgZZBvrR7KV4rKfZFPsHAcdR2zLs3MJqHLa8NPb51+a0ttpT3pB7QvrN1Wi6Pt7BxlZEEtKrTm42cSqdJ4Vk7D34MAnSKTBLmMjZOHN1skvHSiOU7SasdMpDO/hacOjY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 14/69] kernel/fork: use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v10 14/69] kernel/fork: use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYhbALw8Cgd88Oq0u0JtGnbVJYIA==
Date:   Tue, 21 Jun 2022 20:46:55 +0000
Message-ID: <20220621204632.3370049-15-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb5a30d7-183f-4b02-43ae-08da53c73266
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30852C735E27EE500D49B052FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S8yctUChEqo1InA70ghjErP8iXbvijyPamVWt9uhYo3NmsiTumGA9mhbS7LvPfuIc3hUbwG2gpP1dusH95Y2+hFsNB9Cv0+9U+9wLDc/ASMSuJzUqIUhnkDTRcnE2ET07vbYWcULcMTMK8SwfHIVVm6DtrV7/zvV/DtHVahFnG/rZi8PZrJP6Kzs4ZYe/qDxNPkXcx/slQx+CrHueFr8r/Ahiu0gvon6iS8B3rJcLhF4l1CXNky69JpndkDobH2JFzkh+Z/D+pgIj/wzKgLG4ZwKGO/LUXjZosXnanmxGjMYcJm3ndT0E0DdF5LLM0hi8vfv1TZT9qxmkqKM5eKWWIq3TO8Q7FsAQO77jEIoP3+t4q5KGESNT+1/SH5LBNZ9QbJiGZyVue57IPelLNSunzDhMW4HCPs3MXgX2ZCaZOhnTYTCFh/TQB5lTj32y4nzwmRRF/nyiUhrap7W/bpwvEdl4Gae0IhKOsC66Bg+cudFPC1lM9uxzCDFxWuQBjuF3RUIyxBF486YOQTPDYIwFyiCI/9bwQfFQnyfEO/PmchxVdBI7qnymqa/GXwd4SiPjazsnOr+ySiRXI0DuSTalJLxCbxt2PT6wwr0YTNPukyYnf2tYmbNXDp+dKCUlz0xlAXKWll1jhii7fmVHxOWnreucBTC9W+6hZx9g5tWBFpMR2ObmzF/1ff2FgFRaj4647jL6aYiLIHD84YBZiIM4oRrv597zBo/FLR1ZRHWCBU6hn/Ootsfd6em4coCJA0Sz1n0GbCU7Oem5y/No1omGGG+FN+0jOQwjkzWhSYsAi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LsN4cc0SInq3t5Y/z4wRLPHMWLSh49/DFEYBQwaqqiWwN9ID8//o+NnoJC?=
 =?iso-8859-1?Q?Fl/KX2A3cgjEDSBfYVrs8M0H09Ko16OEOdCpvCrSQ8loqnDIIExdWWABCH?=
 =?iso-8859-1?Q?9RTfHagM+Dy1ytTSkCXTydF/NSTxSdfE7fXogMgq2VfKcnDYlqkKtKirZ4?=
 =?iso-8859-1?Q?nuxmjUis+d9pRZBvc/SfGyI/yl64yP351h56+rnAiQcNTIWKTMG9ADjYTz?=
 =?iso-8859-1?Q?3UsqZh+sbCNaeCEXKPJP62+QPYip+ELyX9fYw89TTkXuckJBudl4ltJCsQ?=
 =?iso-8859-1?Q?UyG5wZJD0pwgW5nVkKz6gHLBVCoSDyNFOT+CuulgfWmRcM0fdHDs7Ea06Q?=
 =?iso-8859-1?Q?z/u5mWUIQSpU//Nvr5ls2/BldeQ3Nf2gjAFZ1HHknFoLl/v5oOoRP5H4uB?=
 =?iso-8859-1?Q?31lQeXSv9ArBTsV8tSN0y+Q+I6F8BAjh5Tbl6hsCKGigKG+F0aE7Zndx/L?=
 =?iso-8859-1?Q?pklK4Zuq5B0cTOqKj4jCDw4mgog2ELaQPQJsiISms9T2BC+cVxSP/BtPtq?=
 =?iso-8859-1?Q?5zlYTvtm3Y4eWqU6tiZyMjKmGGolbclhe+Xm7uyecOd1yt3qh708vBjaAm?=
 =?iso-8859-1?Q?hCJUqsp/PQ7/aWQPdwM0kPneukye6G6Zga4+RwbrXGJulmmuoHFc/qt46c?=
 =?iso-8859-1?Q?hxCpiiJ+rSucY+jQglhgBWjltRB/Xn7YveLKVWVjuPJl5Dl0GOgRnlBUQW?=
 =?iso-8859-1?Q?rx3DBO+DRWvsUU2ja13mwIXRr7oj1Rqds1GfhMMgSVDxBQ0ZakMNy18qcL?=
 =?iso-8859-1?Q?FAxU3HJhX4rJEI19cyUdTaGFyWDYAGs4ZAH+UlTjJC0NukqbgQihOUHU7c?=
 =?iso-8859-1?Q?ZSJ/sKUgrL+F7O7notZ057VvJnJdWNJDDdCK0joZDfZ8yJab2mWg+S3fFY?=
 =?iso-8859-1?Q?wjrGUQLkd18piB5yVUXZ7D4RkQcYNyD96EeX+0gppK3i6R261WqREdP2w3?=
 =?iso-8859-1?Q?X8/FqYZsYx6Qp3KF4+Ths8PGzIX/XQXcBK+I+vOzvD7W6o/YAEqDDdkIIA?=
 =?iso-8859-1?Q?HWZB8v/7CU25SaYTUoRfbe9ehRJlUY2CI6KZaDtvnWk+ytbXTYn45I5xvN?=
 =?iso-8859-1?Q?d7+UgjeU52N0gUyFuJJT0BtHwr94emnnCAU+9/mZ+4FRAizYbbn7ZYttIl?=
 =?iso-8859-1?Q?1avATCMSvujamxmPZBFhSqH+ct9bkahFV3VjwHoD4bcsRD1FaMKXCbgLnQ?=
 =?iso-8859-1?Q?a8Sk/iCnwk4JxYdVKSPU21BVpByi3MLTXLfqpzCkEAbbOZU0vv532hlkFW?=
 =?iso-8859-1?Q?NAFXInqCEcLeuqsmOweLm9Xvuc+x3bkjsjwwmzfzojubDTGAFUItpwg9QZ?=
 =?iso-8859-1?Q?HN9gemAnFg9LIA9/MxPaKxWoSxlInDVnlgCD/FQ7WMEaJle/B3Wq1JL22A?=
 =?iso-8859-1?Q?oHmzlxCjFrz9CEZK6nQlALy5GiRF4iKiCCHPphYGuNGW6wvp8YvzvfSIM8?=
 =?iso-8859-1?Q?E6jOQwoXaMLf6izoCEGPH+H0h5N9D+6eNHFJ00OgbhThVkyuLhZY1LcZdT?=
 =?iso-8859-1?Q?dtdQfFmr6mxHOCbGy3NBUiin4kNztlACDeVIS5IUstDOn5dfs6tE2lFcmc?=
 =?iso-8859-1?Q?OGnFeh9UVK/zQVLp+nSncqsO0Lg/TN2CIgdznXsbEERUAqPUgkkCFA34Jc?=
 =?iso-8859-1?Q?URx76g9FTc5b7GB4ivK7ROLIcsYZRhDUMTIJ/63N7yzkuqoLgCMOCJBiGh?=
 =?iso-8859-1?Q?xmmSpqCpvcSn2+DWLp6/h/JErtZjYCQWMmfzAFOVy07s+yklICyAuXlZmj?=
 =?iso-8859-1?Q?eZ0vjRJ/kOC/EvW+72r5CJmDlxqFwNPRxQfdHgf+9sQHJCapWhrzaar36R?=
 =?iso-8859-1?Q?VOxMG2I4NrL5/snmr2OkFVPnICfLays=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5a30d7-183f-4b02-43ae-08da53c73266
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:55.8792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9IZP1YU9gQmnX8ofdGZcyelq7lUVtDK7sXxjuNDPYaKjt9dIdRCl5G2NpOzEPEHbq8DBPNTgizdUguKKVCWqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: xOVsdyV0H3TO_LE__DlVcLiqOc-gwmJ_
X-Proofpoint-GUID: xOVsdyV0H3TO_LE__DlVcLiqOc-gwmJ_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator and switch to the
maple tree advanced API to avoid multiple walks of the tree during insert
operations.  Unexport the now-unused vma_store() function.

For performance reasons we bulk allocate the maple tree nodes.  The node
calculations are done internally to the tree and use the VMA count and
assume the worst-case node requirements.  The VM_DONT_COPY flag does not
allow for the most efficient copy method of the tree and so a bulk loading
algorithm is used.

Link: https://lkml.kernel.org/r/20220504010716.661115-16-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h |  2 --
 kernel/fork.c      | 12 +++++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f22c6f71a18c..27fa36a7c093 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2612,8 +2612,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* mmap.c */
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/kernel/fork.c b/kernel/fork.c
index 1840da0732f6..4ecca79556eb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -583,9 +583,10 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
-	LIST_HEAD(uf);
+	unsigned long charge =3D 0;
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	LIST_HEAD(uf);
=20
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
@@ -620,7 +621,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
--=20
2.35.1
