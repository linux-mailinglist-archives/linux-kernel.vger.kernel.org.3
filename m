Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74B55AF4E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiIFTxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIFTub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCC2FE4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYVT029915;
        Tue, 6 Sep 2022 19:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=r1giLiqobVgWalpGRtsW4+6ZGSEoKPLOFx/DDBog4ec=;
 b=yGcWO1nL9jOVSbWA43eapkMAE3oJNoKmZTxuVSu5r6yFkil4msmureZtL01PdXt1/SsL
 z0sKtGK9dcCladRAInTAMxn6ck3PvPhbW0K7oqc62pVW4yzLa7Jds/18n7MR5v9eWfOI
 lgeqlqFqSLyAqKXK6Teu/s9NJRJZ/4+lCcaoJPGHl035qLBlryu3G67HNsbK58QvbsG0
 wCxdXFgGQgRhj0LXXU606zBgVRwwUt0iGCsj0kCFakd1in5C9mGnTViSlxPDntZUCs9U
 CwQWsj+DCpzva96/s3SBfXnRzvj4zYmByQS5NsCZR3b9cvAOYaZoHWAKvBog4TJ/z65u VQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67W031251;
        Tue, 6 Sep 2022 19:49:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb82dqk02PeHhqvoH+UQ8PN3RDQMI7T98XA4U4nvJTQZNeVImdAGSj6UlZuGwX1YmSxWpYdxQJNgleKvFhNo84Hj3jR0tFuQemZq6tgPFbrTlA9LTqVhLBKXeZoESq+77DpCPbqdVUYvbJCkfl9FiHV4BL3KSYwIgjQXeBVKf6+0cS/p7j3QjYY7/yPCo13JEEnO7ecPCYiEvZYBLsPdv6z3pwvCvQzkwdNiiiSS7Z11ETj3euOo4TfprXQeGJdtPnGhl3HZVxnc2hUAj0HQgOLZE/DriBnhZlwCinawwReR9ECcY57YT9GCsnzwbMowjmM/inE+XbFb7yLQYv2hTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1giLiqobVgWalpGRtsW4+6ZGSEoKPLOFx/DDBog4ec=;
 b=ZFRYd2lXrByQZeyeszbuqygtNjsbaR1RpOLZIuli+bh/muxUan9EqoonjMUKnAmbG3pBawhpAP6bkJR2bC9husBk1OqSmFVQLwcvIGfQfwRhML6dX+SX/vSS1oabggNUVFJ4aRMCnkFX63VQ56RaWFami65ZT5MFFjClgcxKiZyBm1wckMvBIut7KNykcSUlKaPIaLyDGNZGqYQzXBViyLHcRPpbSlGgerra9vnOYIARHwZ21ljxT/sFgSW9zn3OgkRpgHcGdwJ2/tzF+na8Br3OPxhsSKOZzcUtt2zeM/Jqkd9nxD0SuZG99oTMj8psLVV/As3FOprolRB/OQi5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1giLiqobVgWalpGRtsW4+6ZGSEoKPLOFx/DDBog4ec=;
 b=P/UTqXYKewR2fqUe6pJDGwngv2IvQ1yWPIPN1yqdeonO0rKAcaj32HDV/goIm4ZwBQE/XWqiqU3AZRAMrOy63LSnubvMFvdk/X2TTRddWWt1pYCBErtu1JvRMKzBSlHJ48suZ82L9gnPayLZLEVOlawVU+Kx8xhNZReIV4WGpOE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 57/70] mm/mlock: use vma iterator and maple state instead
 of vma linked list
Thread-Topic: [PATCH v14 57/70] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Thread-Index: AQHYwim2zJwfk3M7EUG4CKgBkyCqoQ==
Date:   Tue, 6 Sep 2022 19:49:02 +0000
Message-ID: <20220906194824.2110408-58-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b29537df-3c79-42d2-4b41-08da9040f4e1
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWElvPXPRNVhZ6jUkUWD0IwNb172vX0GGZ5DlJsiQ+VDeVopsWa9/DvN1AKq9rPiwitjyXvRgPvDr9wU0BNdxP6Jcte1kpws6eUuIjyWOPlpnZZm2rj0o9hirBFGX61dlZiW8aE4w3qKXLIJXfXHJalIRnVAv7z/zJzCIT94dbPCsf1IBQ9k3AvsMy4+xQRdaw9vC8Ln7Bsf/kuq+UzX7QN7kbwDXq7MBJ5nqZArpIzrQEiJF1Fy4sPghoBsYC3mZOFbRqHMi5ji0xNjnIo0KYsf/9xlAg6ccgHKVo4WRrFZcgThriiMSt5w1SMhuhH1E4glYDM+Rx3k9b7jxsICgqGV5RnYsSl/zKj/FE+bzNoUHXLwqZyfCFAdt3Ef/7LVPFkPv9QLrIgpYBeDcXhpmW/Zz38I7k+TOy7xVAGbzBDGuUzvGxNN4JhwnisVlg5ejk1HF1QVTSXstcabX/a9jMcXYki/DvEygVXxV6nPTamOhPmFWVl5mdTh54iw79lkvwM8IOaP3PLiCvB1hpJy3yFSkDawCNBUoRU2VgEKPqqBb4xUuApVvcNB+1xeJhMyvqd3DjSeq7d+fOqsSPiKQb6JPMdKx3jmzF/WskOuqe7Wid8qHZK485CmLt3KGBIc2oR/A2/TjCID8ONFTwPPhDH7NVsakDl0qh/GY6FtrNxuSK80Ruew8DanJxDsjXe7ONVn/wUP7V8iS3vCURIRbN/M2sOXflfr3Tkm2Vl0lFX5NV0pibyLQuAXVqZK9QFz9ILCtHiLPInpQ2WYQxgegw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(107886003)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3r3D5iiFyRTmXp05qaDNWfmMab5JJotCO3ZLHcsq9bFqOaKuRKp/fRXdwE?=
 =?iso-8859-1?Q?jePjgURTIG2n8+zz1y9SgZvQmpCapw6wPjzJT1YRkgBJToPWTaHc0vZYhy?=
 =?iso-8859-1?Q?0aHXfkWovezEZtBjBgh5yJLHEMmwzidhXUhHefUej6CBxh2KCC97r2iKiD?=
 =?iso-8859-1?Q?5mGhl/qP83H9rbyTIMjCcrA2lLrbFPN+7ayIzza0KZYzJl84dW2VozG8eS?=
 =?iso-8859-1?Q?ZVNy/p/K4Bak+6dGgRghOSosLPR/VNoQcYo7HEvPx2PZPDMW2lnZfp+Zvo?=
 =?iso-8859-1?Q?q13CF/lCYBYETFXIepd2mocLbzrNVGmb7q+majSq1kHmRwIw+JP6/8PZQc?=
 =?iso-8859-1?Q?jmF96Mi+KguMp1SRZk7EpGloL1PnFUwCl1TvJDqetSf5V/tYSoUVJSzcj7?=
 =?iso-8859-1?Q?eV10VTdTd/fKTGc33OD4/tokoKFKDRPWtKDOaVdazYJS//RVMbVAdlIYZs?=
 =?iso-8859-1?Q?zAStAsyi/8BgRccSn+3v4ie0yfLCOaJ12ZobCDSUoq0p+RnsrW4wohLwZ1?=
 =?iso-8859-1?Q?6Hn8SeKZbahVDwZ/kc1dI8BLpmuZnx3I3YRMlc0OsombvDt3PsEVMCqof3?=
 =?iso-8859-1?Q?2H86wbmg7RP1bor4ML2XR3pGYRvUObkiHCXgDSqnhZvq0y49ZFc1xaRqOd?=
 =?iso-8859-1?Q?O/NwYhRPHQ2R4KhTJp4HnPseT2DS+x6M+wqe0Z/gF/7LqmBrWhvHBRXcUy?=
 =?iso-8859-1?Q?GUxQv6iWyi19Uxd0dlqOcJA72fZt1P+29rtfN8pMFa5ziXi65rtfa6IIeI?=
 =?iso-8859-1?Q?L668pYSVowpYKnfw68sx9DtDF7gbtzdinDHoZqxqnaCagro2sD+aj0cFQi?=
 =?iso-8859-1?Q?OJVDNYswaJaF9+qYAFvuHuylRVN7fhXQ/sU6LQtrosM5fzLYgzuzjpWUAx?=
 =?iso-8859-1?Q?IBBCDRJNouCrsDgU3rmoyWqvWlsXKKCrpAARv6/Mvyxaw6ybFkA8OYwdur?=
 =?iso-8859-1?Q?xm7y61CVsmcmtbVJV20s6rWFGF+QD2RuvlbX3ehXVfkSDEJ8Z2aVjRFaDl?=
 =?iso-8859-1?Q?QDOv1AJ/lqu8W91ZLCGnWo6SVZ+DzqGLM7bFx7zp0OWdRkOYHuqvWQ8ZuE?=
 =?iso-8859-1?Q?O8GxeCxOkjB5Ugg0wEm22TlhZVyGOAINy11gA2P78weYCq6ZI2fFSwZuYM?=
 =?iso-8859-1?Q?aMLUGYkqOQ/g2Xg47MaxS/QMuPFp9FGFB60qOulSo75ppDmXvWbccaqUME?=
 =?iso-8859-1?Q?9FbNPSCQO3HrmrbZeE7DUzKM1t918AkvR/oCr91jDEnqu0Iy1UgAUxjiGf?=
 =?iso-8859-1?Q?h9ZR1aea1Yo9EUJm7YTg4gFcUbHdTZsz39DBqhnTgqgjeR+ylcAR7B5HJ4?=
 =?iso-8859-1?Q?gFCFgXTWQq8YpVn46rMMN2fez+KWyU5HhLONZIyDjrIJ5giMdMrL10WPTN?=
 =?iso-8859-1?Q?KAx6gkke6QRF5AXBYbcnz4oaxcvOtdp734d9rYichbEtNQjoL5KbvlTQgV?=
 =?iso-8859-1?Q?jlrGfrceXIAXg9XQU11HotuNXqkMYmAE4nSQmsHcfgHIc2xJD+/hWfs5WZ?=
 =?iso-8859-1?Q?OSFDGtZXbafIhZ7R84VZ6Qne3RMm8yKxcinbz4cQQIhf6NAK2nX8wgDkaH?=
 =?iso-8859-1?Q?UoO8DfV1DhG54QrwLyqJuX9sWCwg3yKOz+XJARFCweqsuiZIK/ghNb3w79?=
 =?iso-8859-1?Q?fDEtPXM0wkSUK/Vaeukme0LZSEpy7MHUzbgyMDTlWBsCGi4q8MoiGKvA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29537df-3c79-42d2-4b41-08da9040f4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:02.4433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vq8gVRUXWTv7Gu33UqI2PzLUkhjggDO8lo9UrrewIms9InGClDVFFPqecWDC8QObvITI3WXdrVzZeqN6zTvM2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: b8NYYlwEo7P1MvnMz11keu9i2lM8nGwP
X-Proofpoint-GUID: b8NYYlwEo7P1MvnMz11keu9i2lM8nGwP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Handle overflow checking in count_mm_mlocked_page_nr() differently.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mlock.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index b14e929084cc..43d19a1f28eb 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -471,6 +471,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -479,13 +480,14 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
 	if (start > vma->vm_start)
 		prev =3D vma;
+	else
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -505,7 +507,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(prev->vm_mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -526,24 +528,23 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	unsigned long end;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
-		if (start >=3D vma->vm_end)
-			continue;
-		if (start + len <=3D  vma->vm_start)
-			break;
+	/* Don't overflow past ULONG_MAX */
+	if (unlikely(ULONG_MAX - len < start))
+		end =3D ULONG_MAX;
+	else
+		end =3D start + len;
+	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_flags & VM_LOCKED) {
 			if (start > vma->vm_start)
 				count -=3D (start - vma->vm_start);
-			if (start + len < vma->vm_end) {
-				count +=3D start + len - vma->vm_start;
+			if (end < vma->vm_end) {
+				count +=3D end - vma->vm_start;
 				break;
 			}
 			count +=3D vma->vm_end - vma->vm_start;
@@ -659,6 +660,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -679,7 +681,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -687,6 +689,7 @@ static int apply_mlockall_flags(int flags)
=20
 		/* Ignore errors */
 		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
+		mas_pause(&mas);
 		cond_resched();
 	}
 out:
--=20
2.35.1
