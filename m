Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CAB57735B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiGQCuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiGQCtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A411EC68
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ92Nj024333;
        Sun, 17 Jul 2022 02:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Nr0GO3LN8h+QW5Z9FMDPCnW9L/41UBlRuV63erX52QY=;
 b=ncvE6JBry01d2Oiq73UTOzHHFV7ws0S/OuhHLjvLtg4I8KnlOSDVcwNhGzePmuv4tiGU
 Y8+sOuXqKiI1N98Z+mefd6VMeXFprJTCeeEhhMGkvV597C59UW1K1YFl7EJqbTw5GMnD
 y3XzmgFJasL6mCVdBOkyAmQboLRFAdPhPGILCVPMLkejWRB/jDu8y/nhsYlBo4H7vsW9
 cCIGau3Hx4Afbmxgl4a2UaODstCEYgbYIiZsFh/Q4Y5MhjKCr9cV6wG9im/nnZnW8Xn2
 PFkTxB5vXXCYq5stJ9tp3Nc+ph9UJXg4kUYFJAa74+48KrLp8EuTu8//7k2O73NXUvPD 2w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvt8xdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISK036113;
        Sun, 17 Jul 2022 02:47:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xrey/3Fo6g5hwbMBx8vOC4MJGJKkcpKrsLF3bXs/7bQpSXFTjNesgj7R5chrk+CbuLPl9mfbg6d8+s0MytLiqLHqdV1rvToOSZB9HInDQ1mm4Nf1pXjUDaD5jAKggjJcbcne5SPtaC87VeWNEN4Y5+2RXxhMkVSwuKLEL+3CAL6122GSjlK+PWQjzZ+Tbc5zg0XJJr5p7rBoxCxnv74X0VV326xF8safgDnd6Hw3RvddutH650a2XOOYMyfhrKjHrb3KdMmhPCO6RrB1WVQSjftCCjRLmiaX3fQhbWedfedTNfFde5qXAhplPQs9hhqkBM0mAjJPDag0WWz2qJ5IYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr0GO3LN8h+QW5Z9FMDPCnW9L/41UBlRuV63erX52QY=;
 b=eppMxhUQkPBLO706RVGo6IvuSGyjLrx00D3YEhxkLg18CqInEzGVH899BVWfmKqPzcj36kQt2pZWfhZq4+gi0+C48YjqKOAN9ZoHwhXEG9xIny8SKIE3XXNOwl38gKjFV+25L8RCd7EmSHs2t8q6KrMqqSXbCaoN6gARBWhPlKl8Ev4uWDGLpliPBvaxMBNF4hheDcMPjXTvBijJp9wNVfTdctiH2A3TwqY5ZqvkObHxl7c62YpQn+mOmgVDFGR0OtcbQAtvaCjr3RTsrvmXkomG1AQc33aSqtPh1Y4y797V3EQKB9DEIpxnam/MK6zPhfB8Dc/9B1MpjVtMlMEX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr0GO3LN8h+QW5Z9FMDPCnW9L/41UBlRuV63erX52QY=;
 b=xOAJ6Pwumrh2j+VeQscbaMKZVM+vPH3OcwgTG6q24qlgfgrOuy4Z7FNSP+3eZGGKitBROoV0KpZQfVFJVRsbMOZM/vofqSAYwZgNWf/SMg8ERB0rEPP9MZSVl66bw/GP2iYOCds/KweQmC0BgIi/aw/IJIyLwG8ubbRauEjd+n8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 37/69] cxl: remove vma linked list walk
Thread-Topic: [PATCH v11 37/69] cxl: remove vma linked list walk
Thread-Index: AQHYmYd2znkJjHBwAUWZpAnYsh7oOw==
Date:   Sun, 17 Jul 2022 02:46:49 +0000
Message-ID: <20220717024615.2106835-38-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a51fc80-a1b5-4502-f52a-08da679eae11
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D5x4m8tF0dh1kYsjDdQNlmzdHptKTq730z6zfn1ZB9RZvZLO6p6SwnD8ykHAlghebps6xhOL1eve+NJaPGAbf8gB4gMFIOs6tauXg25+BixnqZXDutUsniGhjQK/OLdPV6C6ec8OGTWhD2PJXvjerkrjgLwXevLOMo7i3/sa1at/YhDzOIDqbKBP0+U8Uq74J/JCLEdUJf1BkJwoEE+5j+MczSVZFI1I7DgePorzHjKP8Jbe17vfC7KzsKxRIDOW+Z93uo66OBJJ/Mn91oDsRPRcq2fEOOFhxanjAYL4fnYHF0WprCtIh1T0jSudfZcrMvkGjci74sYg+yuB5aDMa/ScAcLTI1H3p7yC8PC/xf8HqLE2ZdIKDDDbgYU2MO36Na1GmHPywudjMRSE5aRYCaPmeL05qg5X+EgkN7Nm4FJRRurWgpg3LDfissicsmK1ViOwwSyOzlQPkvSl/q5Pxk4AoEoTvx8wwPTO0LUy850F26p6sqqVOgfp7M2cxbVa2FJYn51KOsy2TlOmsqL62964c457lqCzvR7ZJVIVWYmR3clYsezNDvHYNpSBK7iXDOG+48BVvnXr1DfT96rYEJsne3jhrWnmOiB22vBnWpHrx7WbDq1FfImR5ALE7xFhiWYJxxytgENWiAij23JNC5a6gGn6h1RXmsjBP3Pi2iHTk+U18wuLipERQdMqNUshWXrzMIQRgCzQ/R2bKgfdUBDT7WKRsmtWna3kdVnUH3ssqIkDBftCSsb7nGB1udUxJY2R7JTztjZvjue+6NVZUa4ObCEGqtJycMev5Om9V1uatNYLlsrF0yerubUoqj/sZW8UOSI3lYVaiVMMk/aRqb9EHmpNkc29DTa1JS8G/sYRHlHcd1vIhmm39ccqsWSI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ejrjcakpCsU0wGXbx4WhI484PBleq5AxLZZtceffq5XRnJN9sSaElF4kPb?=
 =?iso-8859-1?Q?Bw/dV/2XqdtvDRdWeRVQJOIflgntvyIMdl3PNr17RKw0sllCcieGVA76yY?=
 =?iso-8859-1?Q?KzAytEmvw5HtN1BxvNiTsAsAx13Mv8KGMxoj1Ticq//rx6yW8nFUojqAaC?=
 =?iso-8859-1?Q?OG/LkAXGdP+DrRBqztG55jGEmcBLe7wJnrV+jnmsVtlbY3Cyby1kscyh+s?=
 =?iso-8859-1?Q?u420xGVQhwZElpxuKSJIpX2MAoou0GiOLQkUCSflp8rBr5HqBzWf1RnTHw?=
 =?iso-8859-1?Q?S5Rr++Z88hqZqhW0KpWcMgnNozGYOlzb/YfWiGOZuDrwnu9erEnVuVBw7g?=
 =?iso-8859-1?Q?h6SDnG3dsIgM+wl5FY823NptXV0UD4dLOZHuDqWKjTIithyZL2AVJbOcyb?=
 =?iso-8859-1?Q?JgQqRdwmQcGawakBEnw/1Tgk/vjilmsNpMIx7a1RRLKCukYv1kcgJ2lDHS?=
 =?iso-8859-1?Q?Z/ks65rni+EqIAr0hhFSQ/wZ23ghZkB3OhTNZh9Oik0SvXOuNtdP/WS1Mm?=
 =?iso-8859-1?Q?JU4NCFdZL13e10MZSAk/6vM/E3Cftt3SKOUdNaAd5PNbDLablR1t2zI0E9?=
 =?iso-8859-1?Q?jeQURIp/zqbP1EHEiUT6E2Cj9oJzSY6JZjR69sFWp1oOPiGtwjvsi4nVaf?=
 =?iso-8859-1?Q?+BB4c94jUXwJDoteAFaMKYIWWowWZic1rVLIZhycNSpwSXIgb05VSkEPo7?=
 =?iso-8859-1?Q?81xVQT59GpboyXkD5oPbO86R+/A/XwkRQVQnC3Qt2oQf7FA59l+yEvQVhO?=
 =?iso-8859-1?Q?vYinxpwDKT81dmUxuFj+TSPbt0LjsY4rOfFZO4TyKLa2SA23tiazx0YJDc?=
 =?iso-8859-1?Q?JiY0ilAZSLllIhoZLW8UHSKtKeBMul462cIApoYmXhdVR9SkNxnQ+BGFxk?=
 =?iso-8859-1?Q?oNB/10bvFgMvyyPLg77CxezOc5+qE91JdofRQ+8ShSB0DZg9kdBu7jKu8b?=
 =?iso-8859-1?Q?SM8d42sOiDgoozCEZbETkCKadPS1KDXj6yfzvze4j7mtNYTLyZo0PJ2msQ?=
 =?iso-8859-1?Q?8R6UGKro/fNnki0fw6P5TFs3Z63f0IvG9QbOiTEr+JiNrKgWGVUJd11wDE?=
 =?iso-8859-1?Q?bZTwhAnzuXQSRuIiALAhPHy88OHVabPv8SzJM300LWaNVyxu2lik9+tjjY?=
 =?iso-8859-1?Q?WyNsJKb3s3lKDp3yKFpXMHePe41ZzUd3QmiGRmAXenrsTcniRHufCWK+y7?=
 =?iso-8859-1?Q?pZKVhxK9knPcjRmKrSzAY5Gz29UIcQYGqau1pjqglVMvn5PEZMGQFtkKWd?=
 =?iso-8859-1?Q?ST7tS3eRhfBgOkg8Ojda/Y3B+Jof5cJhQ/cq2eNyjlLMDsjPgZjRLacmta?=
 =?iso-8859-1?Q?sTAi6f4sgDinATpY7+HSMXX9UpZQqXwms3JbvScDBRYG/I/4GZ6yhUTkEE?=
 =?iso-8859-1?Q?fFikee7Cphedyi0Q8npskLM10w7XaavL4eqhv/QYixTqLjv0P/sr5tHhn6?=
 =?iso-8859-1?Q?MQTFtSuyFReJcZUa+vNR/GcZqXQF7GOCgUMjwQidMDRCB0qAGB99qPCagL?=
 =?iso-8859-1?Q?VPD3+QuNhgW5Ql+9W7y/tFLuV9LenC24rvT3Ta2lpAloRqYQaPDDE8QkGv?=
 =?iso-8859-1?Q?PTuTUHuyZKaxBrN1Nrh6e6eHSx2mX5pSj27Jf9z4J3hyF+0PP9pcvLH3NJ?=
 =?iso-8859-1?Q?GnC+nxVyu80g+IegIvKC+CkBGL5eOBIa6UhzLvyEKciFIzRRpX7EwefA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a51fc80-a1b5-4502-f52a-08da679eae11
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:49.8026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YmafemO/Op5be6JMrKuReJ9X4sq5+aKBUUkInOlMGJdxwtj3tid0V4PvxrrRQMnmSc1y8PPyKSJ3n5PtNNpkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: 0logszWYCJsQKEhcdh8_l-Eru5t2lYRv
X-Proofpoint-ORIG-GUID: 0logszWYCJsQKEhcdh8_l-Eru5t2lYRv
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

Use the VMA iterator instead.  This requires a little restructuring of the
surrounding code to hoist the mm to the caller.  That turns
cxl_prefault_one() into a trivial function, so call cxl_fault_segment()
directly.

Link: https://lkml.kernel.org/r/20220504011345.662299-22-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-38-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/misc/cxl/fault.c | 45 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..2c64f55cf01f 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -280,22 +280,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		mmput(mm);
 }
=20
-static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
-{
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_one unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
-
-	cxl_fault_segment(ctx, mm, ea);
-
-	mmput(mm);
-}
-
 static u64 next_segment(u64 ea, u64 vsid)
 {
 	if (vsid & SLB_VSID_B_1T)
@@ -306,23 +290,16 @@ static u64 next_segment(u64 ea, u64 vsid)
 	return ea + 1;
 }
=20
-static void cxl_prefault_vma(struct cxl_context *ctx)
+static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct *mm=
)
 {
 	u64 ea, last_esid =3D 0;
 	struct copro_slb slb;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int rc;
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_vm unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		for (ea =3D vma->vm_start; ea < vma->vm_end;
 				ea =3D next_segment(ea, slb.vsid)) {
 			rc =3D copro_calculate_slb(mm, ea, &slb);
@@ -337,20 +314,28 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 		}
 	}
 	mmap_read_unlock(mm);
-
-	mmput(mm);
 }
=20
 void cxl_prefault(struct cxl_context *ctx, u64 wed)
 {
+	struct mm_struct *mm =3D get_mem_context(ctx);
+
+	if (mm =3D=3D NULL) {
+		pr_devel("cxl_prefault unable to get mm %i\n",
+			 pid_nr(ctx->pid));
+		return;
+	}
+
 	switch (ctx->afu->prefault_mode) {
 	case CXL_PREFAULT_WED:
-		cxl_prefault_one(ctx, wed);
+		cxl_fault_segment(ctx, mm, wed);
 		break;
 	case CXL_PREFAULT_ALL:
-		cxl_prefault_vma(ctx);
+		cxl_prefault_vma(ctx, mm);
 		break;
 	default:
 		break;
 	}
+
+	mmput(mm);
 }
--=20
2.35.1
