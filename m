Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1257735D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiGQCuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiGQCtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857371F2CD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8OWq003733;
        Sun, 17 Jul 2022 02:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VjO+QY9BIMwTt2eiSzdiJ52Z9YWqkR93FraspttOc4I=;
 b=drDA5m9dWAqBqyzeYVFAZhzzpi9DhNWeGgBJuBJNRJUqvFyeisk+hXwwIa/Fwj9YlLAa
 QtZq97YXlHc9GG547P9hdhraLcPhbx0N+PiFPZssuXiHT8vbXFfq9qgyd2w6D0jmbXUx
 +1ovFU7aDqSjCglSnVDJldb5IEXQbjkdu/Y0tJMr3YOlDmFNwGCuFqec3siMp4v1Vyvx
 MoCCkP3S5+4RvObAWG44+4dAIdWcYZXS77907z/COouAWDdQ1p5xgG/JAkMxIov2Xk7O
 fzpI7/QaVcxDV9lmR1G6RKc/kmIqTNQvf4vzw1KHYd0A9CSYoq9TB4Qr1IemitjExynR kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISM036113;
        Sun, 17 Jul 2022 02:47:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzOiH1bBwfkd2ehieVgfHFw1AvlnRjoCQTsIC3/QENQjJu2dd4ARgbphe43Dr/ePxoYNuw2rkV4WAjf1NFn9vKkBKUuIJ7sQM3HO3B9yYmI2eGuUN+EcbnebW5ivBK+LqT9LGYB9myPC2XdKJKKv/YPhOQLLvJsyzXCHNUkhd6zXsQ5oEqpfW/gRhVP2+dXySisaK4Y6NL+Veqv21G6qPARnoMSrrYAwVhcVtqjWlFyBQlICmsH0NMVtUoOgNUrl3m/BpmLkFWHcGFtDKkrIOUbLtXpsYWDvxE7ZisHWUIEhy9isIUUENRvBy8sVoZepXXKJauHFVPvwrsqAmALyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjO+QY9BIMwTt2eiSzdiJ52Z9YWqkR93FraspttOc4I=;
 b=igjWhq5Af3JczTcC6aWxNvKTFH8h7roOnUdt4pGutkcdSMdk1HGPWN9aNGc/FKwYkU1jNy4SyMCFqo6UaAybFfDhtisrfapWSCge/tdituOVD5u7p85EVCMRTfXQpHyQJwiXDzIx216XxK1Dg3h4msN2ipWB8oCU5b86J5ULrnTlbw7FX47VM6aFNAmrv3x3GLUUBNzPrsXWmbaCTE0uTU8F2khXi0vZlLFSwD1t0Sx1N4iG+sPkyS31BSX6Qjwr70TRrLdiq+i9HPd+6r9J2VXOwzqq1SRM06ctypD6jSeAUmL6iK4p358BtFSghjbh5aqlGIzWXSihdM8eudOqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjO+QY9BIMwTt2eiSzdiJ52Z9YWqkR93FraspttOc4I=;
 b=wQ99E0MUc4bWUvmZc6042VoRnaEeorkIIoOT2FF1z5gk350os54VO418Y3igA5Y8V7/inKNsIra9H60gz5KNsx8/571w6ws5iX7JH7MU9SllSasKOpThAH2FMmw3yYGwFLMAYNKj2mWMePowNOaPCHitdFj+GoReTyPYsxVE+ow=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 39/69] um: remove vma linked list walk
Thread-Topic: [PATCH v11 39/69] um: remove vma linked list walk
Thread-Index: AQHYmYd3EDjNyioOtUmOVzy9WE1nLQ==
Date:   Sun, 17 Jul 2022 02:46:50 +0000
Message-ID: <20220717024615.2106835-40-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3611934-0085-4ef6-41d2-08da679eaf69
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IlbPwCJF6HjpetgOVhxAMxgjawLYZzTue3qrJneNr54L4mL+Co5cAOL0l8T+QAH6A4GzF6GcddjsEwJE+v98HnhqhO1T9U7m72Hbt6j/qNJno18px0V+ot8Uo+wdqwAKw+1MHSVk3CM/mRCEamizcU9sHutJPwBjHmdwghHOMNLtuet+e3IbDncm596oLRv24m44Lb3osYSID56y3hQb6C+j4hFpRd+MC4gf1i78sA4n/TLJZ0oyTaVP5vg7kr6Xn45jKOt7iGwKQtTIVHnUliAeUWVdoS63F6IyEqtw6SvO4iuFnb/TSegV6F7xm6RlVbSJXBz48x0q7ArFYk5ZhPccEtKUiHg9DhNiYYtHrwcWI+lWo7nzqVGBqYxA/dgsocGiwtMPsrGBp+psgq2XHATWfaTiKv7tWaOV9yGI9bOsgF+JYUM4sTLNGRwNgp0v39E1TbySKiOO6DPXqTRkGObAZpMB9O417Ylu2+3gUPHUSQjtXL/Vzq81fHvUzwNPF1Aa03aKJWEHamVDfWaK+DvcOrsr6ji1wsKkuPggEGGcs90B11DaU4m5akx6Qt5j1ELTfXef+Sa4MSsS9FAtXxLcwzeWBr3fQzPxqdRHyOtZTkIPeU5QnYAmabYQ9JRpwvmZAgKB4BFX2oGBLLF5hB9Jql49Q58u0nNAmls0VcJ8eERMHxjL+ZkVNMFH7BLas41fq5Et9bTFlWdf4ymHJdE22LIZSUCA7v4SB6XRh5WGAXGQiU6pI/6NvpAot7RTgyfkg5wB47m8WVWZapy4RTOZnFe4Uq30ILM4u/XnsZ4rsRi6iTgCSyGwS0h5HIN0opoVUavtxw9EnRrdklIbIyR+AgAgtJEl/5yt9cboiTpyxG64vdYAi1zqBkTakZc/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kt1I+prHOy4JpcA13I0Xb86mSlGYlSfZJK8JRg4suFz8dxuVev097DecTx?=
 =?iso-8859-1?Q?zwhidJSX+28ry7DRVVh/ef/CfJSPOZR2wQ+zubF9qXf5tiV8G2bFqRYmpC?=
 =?iso-8859-1?Q?QY8osUhxSCyLPH7PGJd8qH44ysY6KG0F9aE0HCrw9AXLXDcLV00PYwga/y?=
 =?iso-8859-1?Q?UwtdTd+ujSH2C53mlL0tuYvdykMl2aAfl1uEFxg8eiRExoozp3Qa3AFLWX?=
 =?iso-8859-1?Q?g1lvWe0lZdv7PTA+VODcJTB6M7NovCDxXm1crbkaUoz0iRJ+aK6g5cUarQ?=
 =?iso-8859-1?Q?f8XUpAG6FDn8kzd79zqGPNAX3aGEoreFme09TIM78BzwHGy1r2yryE4dm6?=
 =?iso-8859-1?Q?LMroNMVwB6X2yoIWXDMjpqB0T5U9cXoifKx9y98YdwOCQfL+SePfhKtAME?=
 =?iso-8859-1?Q?9Odsaw5uM4Fp7OD8OfdlKizvEXdJNu0w/PltFl1nF2JtPJwhQ69/wxtvm/?=
 =?iso-8859-1?Q?mgchUQOfKxid/lyby8JPErWkoYYpsmKKMSTDzOhjuhe1mILwGumPJBRaxI?=
 =?iso-8859-1?Q?kVvH1UIXQupK3Gp88hgwRKfFaXrw4oB80vmz/cy2zR5OBxKgFPSIarNiuX?=
 =?iso-8859-1?Q?50gj4v+O7wdzDdpJq5gBXJ81H1nhjoXOtjeLK+DStdQ7WdQTWtXRQ1wD8Q?=
 =?iso-8859-1?Q?hs4IjCNRiPHGE79NVYXi4iVvM9fb4268MR1TCC77nd76OfdglAmf5TDoLc?=
 =?iso-8859-1?Q?81o7Qgvs5SD/0AzQ/Ef8tgnsIAA3Ch/hzos7fQnVvpJtw54AKIoa4cFE9j?=
 =?iso-8859-1?Q?hQbLA1eaj0cwHrWtB/phQ78UJHPZCzxpEsFQMAR4Q6AS2LUvvZ3oUVFrno?=
 =?iso-8859-1?Q?LQFdcHpUb44wgOQOX6QKclw0VU9sUpTONDFr7feGzOZTDjSpbpIOqDItKp?=
 =?iso-8859-1?Q?97GBSBIurFPQSeOS/4We9olqrB/vXalRtNrGl/Eb4Q06QYN/YQ2mSWNXHX?=
 =?iso-8859-1?Q?HNE1uHqMvQ5XrDz5VPmWi7RcaYi3B5rpOpjB3q9mnk4UczSGMPKv1KDsx3?=
 =?iso-8859-1?Q?gUFUlGauAsD8VpBIoT8N6Mawtk9HAg0PjFakqNXL0SR3zVp3GOjOI1SrFE?=
 =?iso-8859-1?Q?lo2ZtKsgOCIsdn5sAgCBrSzKzDazjY7nhooa9bhoSCgAnEosDCAi9E1Zl7?=
 =?iso-8859-1?Q?4EMPznCBIbLUdjEazjzBdmwhdCNOviZllSYfsev0ygJ+nrKQlC9ewBYxKs?=
 =?iso-8859-1?Q?iuZsiH3UT1/24scaX+PyVlgiXeXlGuuYqsBF+94FWYYeixTLAaveR4FKmH?=
 =?iso-8859-1?Q?W4yaYc/giqSBOxZY3wCPfHMVFhQ9dDSRVjKjZhognv7aqDwOFoue20mcWn?=
 =?iso-8859-1?Q?rfhbGRtHg7stAgeeLA0vQhJPiEYeC9KbRr3meKz+FIJIQ420/0C6EztxAS?=
 =?iso-8859-1?Q?7L1N0A3bOG3LJg7Vr8xPuU1FLf2YmaloP0M8Z7/CwtdmopsyESR8ySED0L?=
 =?iso-8859-1?Q?j+IVZscI3N6757wG+Smlj7D4jojbBfTU90nrkXll08UJ0dHX5D3hOncB5x?=
 =?iso-8859-1?Q?L6CdRq0m7NMUM94RPIRMPoAySIDMGa5NpkQ+/tzoRbcK2syJx8hjVtRPjQ?=
 =?iso-8859-1?Q?QqeaY0W8mVbY6RkELbf8+iCghk487G1QtHbrvZ0g7gkNzuHPV5fkweGAoU?=
 =?iso-8859-1?Q?zL017gK7s4V5wAqY4OF5dSr03oOF6wT0ycy1gs9BGJwB0doPtZtOwjzA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3611934-0085-4ef6-41d2-08da679eaf69
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:50.3963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +oOa04R+bTCEcLcX57BO21dr9MhF8BNz0fB5XSy+GBALQzrY1hXLCUBGKD12hQxJrt4nGjlhPfF68SHEYJ8C9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: Oz_97IGZa-4XrhTSc0xQWkwOBO0pYM0B
X-Proofpoint-ORIG-GUID: Oz_97IGZa-4XrhTSc0xQWkwOBO0pYM0B
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

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-24-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-40-Liam.Howlett@orac=
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
 arch/um/kernel/tlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..ad449173a1a1 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -584,21 +584,19 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-		vma =3D vma->vm_next;
-	}
 }
=20
 void force_flush_all(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.35.1
