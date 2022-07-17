Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04C57736A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiGQCud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiGQCtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493B519C0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8rqw005737;
        Sun, 17 Jul 2022 02:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=h1VGyy8O1NWAjWD+E0DkcKWxGiPNCVsxxsJgxA/7004=;
 b=U+L1+heB8Uky9Q5ds4VPfHReEZyThAyCzjnwpsExA+z0SkyNCMnEzeY7dg21S3UwP/ko
 m93JCJw0oSbojpzC3e0xpIPkjaHE0KI1mPVOl9AbnjYWom74dIDs66kUlrAModDBa2FR
 bYWha/mtV6vuDKKPsEUPEm0+DDpPh1PUJvA1tK4FMmv36Vwfdca0pRwKu8MiLmSzv4f+
 ir8ytTrnv73Y1TrSeskXXKSluvByXfLads3vHZFITVvfJvV2Z4eTQgCupfN38hXGXPBt
 nszZfhl3A6oAjOn7wLwiSwTsa5/gxBIhpbLICM5/u3I87K6T0UzrPvl83wmOfToy0I8H yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISQ036113;
        Sun, 17 Jul 2022 02:47:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5wvjXcVJncgKdr/fw2X/UfMgknGcg7SfKENzErdyAbPd4bn9uCCJ2U21oq3FYVpXCgQuRpw6XcRQ7Dj9Z9eQ+Ny95gO5dLbAc3W3WW4mnQmaunPnusYkbkH1RSiGtWxrpm58UmTutZfU76pnaAAMYhVCgYuRciCoihEdEpGbbTOkyjU6BEW4JbzOU1QyW31aakxhUvmiBeOewYtxY3Y0PwvsEG77KYKpqCGVfiMuU26oRePsh0kPQaQn/jIfCk0qD+fw6aYa2zJ6VKrgq6mMGC7/dioflCnhIN+8G+U28DTIera0gObQokbh9N22gD1KeOCAFreNi8XrLbNcn9aKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1VGyy8O1NWAjWD+E0DkcKWxGiPNCVsxxsJgxA/7004=;
 b=R7HHe2mN4FWZwFX0/2hWpeFoE5Cp2B5RraySpcVCxWZyGmc6a+69o8DRP073gUIj886hfLw30bwLRsh9G1NyHe5qMeJPYL8zIUd21WUkMJ/H5u7ujl6PZWJIeXdOCD/cAEv8AcDyc+4+7LXI6srhjUesTGJtvdZwPoWVaSxqiflSrjWbMpxBlVZBliLvOVAcTwa34T2KeGGNdqvE541oRNnYnOo/xJqdcduv82CtH4mpFMCNP7WDMaGCO7tRNbLb+jalu/SiEIJGqr7S4m+kloGU/TOXM+8QYdHtGGlS3PKYm8wGnGFj3z2hm42sgX6lTroeybzwW6JFN+3rPU6THQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1VGyy8O1NWAjWD+E0DkcKWxGiPNCVsxxsJgxA/7004=;
 b=WgNfW+CgCGBHGyX08IUVRwJg+3jd3bSjGujojE1z94QR4Be4TxiUB/YPcEuSBS5//xgf7Nlwxj2kl0g04Z9p3RtmHn3RbwcqsFxK7f/f3RfGMGbMfi8/ByZ22BtJ49KldrQaHLpM0drMs4IgW1oJC9uzOzfxYxNoXpJeJ+buZz4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 43/69] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v11 43/69] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Index: AQHYmYd3h0EDzudcRUy3IJ4a3i3XNg==
Date:   Sun, 17 Jul 2022 02:46:51 +0000
Message-ID: <20220717024615.2106835-44-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb201a41-662a-4ce6-0f28-08da679eb01c
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5472CeM7ItjgvkLzMyRPUfp2caOfd5sLEZxU4kjYr7iWyTpQGgGP1OsSebDhTeBuNVxuDOY4ipWSrohjbl7vXQl+Uyg15UUGB074uisXWrGttUqUGVuTxTiLk8Go8FdJ+5e/ph5Kz55Rj/2fr9u2iVxZc9eZEGa9ngPszswCKtBXgZpR+ZZdoOKJgX1Dmv2W7TzhRKcazHYrmgV3x+5NGUYa1LSiOIopzaCwQoYdzN5ZB3K6047XIH5WucZkEMsTRfGbcF2rwOM27WyCtllIFJw4CTmVTlSvA1/rjPDlivcx+vdhN+f4e6IvoVq8KxY4Uh03bSObu/fmvpdeTg/FIZk5as8k18jDlk7qS6nTAXem17gDroCBltHMp/JZrstject8Q36IWKZMmD2IeOySwysC7kScys/haKfPYkPvni1tshdYIxy1q0jHp9DxsGzHzjncNUkvG6wugUnXa0JnBB4sajudMIzHe6Yz2N4eemcJ2JtqogBmid2ZfiG6GALrSIoPskh87agdWxw9PTIoSFqwJ3jIVJDSV0jp2OGFO8znBByX7rB3y+iGILQP40iqw8aoZAF6Wkl055Rg6sIQguyjBw6QVDNbMrepbdSPnwcQM8uXWYDwuJiBl0E+zgK4Z/fJiRx7YYNa9WijwMEbh1HYMG7Ul3ZnvlD7gGoGe5240HI5Piwp9BHx2u09YfqGzg35g4s2c0tw3MvMP6+2WNXp6JotX60EJJvSTix1DJXSNHkJmFJ/PJbeN+D1cR3xkEKLLVJR7uRDJmzIOzw0ztdQ0w3syphzwo/+HMwIu+wPySkmWnAw9NCXZw/D2txSRWLk1jVtbKKJTAOoKTRI2Q1PUPJBBVr5BaON0RDmmlu9hUzSGtuXbfyFTx4iaeoU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OoJpjwVhrdmcLOOeKcccf9ZrlbZugMnc3kmpIExD6o3g+NwH8MwYvyt1bB?=
 =?iso-8859-1?Q?gPglRcIp3Y9/6fuKXWpLkDkY8/eud/cGv7ttYSW8gsRnntNXRX7Kh3nfNB?=
 =?iso-8859-1?Q?t24PKnzZJj0bziKpeV1Dq3I/33D0yJMQvAFV3TFvIaaTj7Inh1fvvILrnM?=
 =?iso-8859-1?Q?AeMfb0xcfmEc5CH2EwwT5s/IX/VeK7Nny1QGAbGp5ALyYPUiCXsye93tmt?=
 =?iso-8859-1?Q?E8fSeArzT9zEpDquDoO63UPbZHXTl/o5o30lNhx2pEo2U8rgBuVyzxQRg5?=
 =?iso-8859-1?Q?F6ljUpFsn1y7QGMshE64eBK6UDCfI+jSkEeun3zdmsYJULPexkm3RByAFE?=
 =?iso-8859-1?Q?rZnVwjEuESxcXQXKUv5Zn+lP6wEDTDMSFYT6RFj7HBuNFKluMI16hYrzJ4?=
 =?iso-8859-1?Q?/JUd1G1bVjSjJqz8+WRp0W2obGPAOjqi6AKQfWaYz7zRlp07y473p+5QxS?=
 =?iso-8859-1?Q?dGFjw9q4IBLuCy2gFeIQYYDd4xS1YEKEoMmDGuLBUouc9CU6tZVyMA+llD?=
 =?iso-8859-1?Q?/GGaEeuBSmXb4M2zKQkCH7VCkYvfyCAxLDQ3/ijb78BljlhQQmT144YEkR?=
 =?iso-8859-1?Q?NaTW20eTiBhXJt1EVUqxM94L7wJMphsmSIc4SxFkhZ0eEFx0Yo5auAynQL?=
 =?iso-8859-1?Q?Rv43CsiHY1DWS/dBvB+7CyBAYuEJpYTubWUJEVEqpJSCJd3kpJ6lawJYSX?=
 =?iso-8859-1?Q?b5LwYtfqxNR9WrIc0pCzi/GC6yaZHgsltgURM1xxQyXqrpaJlp/yHKea7O?=
 =?iso-8859-1?Q?yUMeJWh/ePSijwtf1B2aH499YNvRYbCfipByGz/F1vh6njTlODESKV9L43?=
 =?iso-8859-1?Q?wy73/zYI/8ZBYgVkmD9q18Z80eckKkHD4xtG0OpfaAsvzZczFVhlsXVXvh?=
 =?iso-8859-1?Q?+clWgxsin1VZqIIsIQG+r4dbcHH4Tvpkrsw45Pea0fMSTs3L3SLVd2XDxK?=
 =?iso-8859-1?Q?OG9Mba2tgSrR/vone7IeTOWxl4xZ4zZnbnCA4MgvRgMCEDr59W0kpdJaDx?=
 =?iso-8859-1?Q?BbWRNP5FLH8sePJnAuUNyHvFjO0Ingv2NNPoTNXXkNDA7R+AcEM/zZl5eT?=
 =?iso-8859-1?Q?nVk9tBF3eC5iJ2CsxsaLRrhJe6JBFX9scjNjQDBbINPmWGIS/7TkIxgP3V?=
 =?iso-8859-1?Q?5N7Ls38iahh+PMHR2zHZi49aFreLve0Gznlhffbo/vtvR0mtIgsD8Q45xQ?=
 =?iso-8859-1?Q?zhZO2B/FFPU9I/K8bglo8tCwEZ5WbA/bScAVrDcXmo+8PLxz2nOBW0I7HY?=
 =?iso-8859-1?Q?5BR2BwZ5fprBTV7GI1F+NvJBN/tlLMuhVEuU2xOhcSXZ6KSYsE71+GAhhO?=
 =?iso-8859-1?Q?qjmLXMl/illXtijn+UxgRrNsYtq/kj9tItq2U6yULcX1y976d6pTV2JSob?=
 =?iso-8859-1?Q?qjAPN7kMvbHi2089TYkGtWeGbORFLbfycsmbXCqzYREN3pok66Xdepw8wD?=
 =?iso-8859-1?Q?Ex1S7r/lqzwjRWEh0moXwEwpBsUpIxWwU6g+H3rl5uX+Xhfbsedy3iMmNA?=
 =?iso-8859-1?Q?tU+/29aUqeuwSHkxwpI2wcc0Ww3jvett0aCvmON8fNfN1MPbc+HDqYVTg2?=
 =?iso-8859-1?Q?fNUd9r0iDIlUnIbg3WLHppf8nqiaY94ex2dllFBev+w+JmhWKyMrVvjnza?=
 =?iso-8859-1?Q?k17NJhBIa2rFfJ8oiMofIT5vhEJ+w8aFfGTIJFGOnX3PnSBo0TgVc+Yg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb201a41-662a-4ce6-0f28-08da679eb01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:51.5993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZI6Rktlr8/2cgEcE8nOHBHH+iPh23qdXr7g4eeVgvbA+kMPK7t5zuseuReA1sAIExYrUduBeLSM+LeVpk/GLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=954
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: mauKPUfhnuf76tiy9hxPjNFRa8Zx9wGR
X-Proofpoint-GUID: mauKPUfhnuf76tiy9hxPjNFRa8Zx9wGR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove references to mm_struct linked list and highest_vm_end for when
they are removed

Link: https://lkml.kernel.org/r/20220504011345.662299-28-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-44-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/proc/internal.h |  2 +-
 fs/proc/task_mmu.c | 73 ++++++++++++++++++++++++++--------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..f03000764ce5 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -285,7 +285,7 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 #ifdef CONFIG_MMU
-	struct vm_area_struct *tail_vma;
+	struct vma_iterator iter;
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 616913bb1fa7..f9c9abb50bb7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -123,12 +123,26 @@ static void release_task_mempolicy(struct proc_maps_p=
rivate *priv)
 }
 #endif
=20
+static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
+						loff_t *ppos)
+{
+	struct vm_area_struct *vma =3D vma_next(&priv->iter);
+
+	if (vma) {
+		*ppos =3D vma->vm_start;
+	} else {
+		*ppos =3D -2UL;
+		vma =3D get_gate_vma(priv->mm);
+	}
+
+	return vma;
+}
+
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	unsigned long last_addr =3D *ppos;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
=20
 	/* See m_next(). Zero at the start or after lseek. */
 	if (last_addr =3D=3D -1UL)
@@ -152,31 +166,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
 		return ERR_PTR(-EINTR);
 	}
=20
+	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
-	priv->tail_vma =3D get_gate_vma(mm);
-
-	vma =3D find_vma(mm, last_addr);
-	if (vma)
-		return vma;
+	if (last_addr =3D=3D -2UL)
+		return get_gate_vma(mm);
=20
-	return priv->tail_vma;
+	return proc_get_vma(priv, ppos);
 }
=20
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
-	struct proc_maps_private *priv =3D m->private;
-	struct vm_area_struct *next, *vma =3D v;
-
-	if (vma =3D=3D priv->tail_vma)
-		next =3D NULL;
-	else if (vma->vm_next)
-		next =3D vma->vm_next;
-	else
-		next =3D priv->tail_vma;
-
-	*ppos =3D next ? next->vm_start : -1UL;
-
-	return next;
+	if (*ppos =3D=3D -2UL) {
+		*ppos =3D -1UL;
+		return NULL;
+	}
+	return proc_get_vma(m->private, ppos);
 }
=20
 static void m_stop(struct seq_file *m, void *v)
@@ -872,16 +876,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mem_size_stats mss;
-	struct mm_struct *mm;
+	struct mm_struct *mm =3D priv->mm;
 	struct vm_area_struct *vma;
-	unsigned long last_vma_end =3D 0;
+	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
 		return -ESRCH;
=20
-	mm =3D priv->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		ret =3D -ESRCH;
 		goto out_put_task;
@@ -894,8 +898,13 @@ static int show_smaps_rollup(struct seq_file *m, void =
*v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
+	vma =3D mas_find(&mas, 0);
+
+	if (unlikely(!vma))
+		goto empty_set;
=20
-	for (vma =3D priv->mm->mmap; vma;) {
+	vma_start =3D vma->vm_start;
+	do {
 		smap_gather_stats(vma, &mss, 0);
 		last_vma_end =3D vma->vm_end;
=20
@@ -904,6 +913,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -947,7 +957,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -961,11 +971,10 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-		vma =3D vma->vm_next;
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
=20
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+empty_set:
+	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
=20
@@ -1258,6 +1267,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1277,7 +1287,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
@@ -1289,8 +1299,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
-				&cp);
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
--=20
2.35.1
