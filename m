Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E861F51936B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbiEDBWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245469AbiEDBTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B189B44A16
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:15:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LIGqI026258;
        Wed, 4 May 2022 01:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5zY4WG8nIKPzKVgG39yVAjCB7qLU9Kg4nZ1hxliCarE=;
 b=mUreAYM71ixzN+PAS6r/EgRrAZMGQkc2+qoboRWrRRIPwz6Gf8eY8+7tX1VLp7lexo3p
 mwRDyUQ0G6wMXRr6JYCIG4LHKknFKBOUsGt51C0O/6VNBT6G7kWD6LBz4mX4xHGRdvcy
 M0st0z4uU8daIf6WndhxYaVOuXJBl0OM7frolWHcUfh+AIchHx5aXfOobA533JZJ6mga
 N8dx0hAHs8BKLkEiWGXzeKIHDp3XNpLPqjFvjkliI86829lwwrNK/w10E7F4vM3dY7Cd
 EfX8Le4SYXdBI6zKT+CaypuA3Tb1p8C0AFkHjXPVOuh3PAFRMNRvutKp2pfT9tUra+hu EQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BJT1001264;
        Wed, 4 May 2022 01:14:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a57vyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz/ffe65ug24XiTxgi/Kok7ajzOn16TUV8iZCIvcVVDAYgOAfqQiz0isspmzYkwgaUPIFMik/LNb17hys8azMv3iIdCZ7iG6uRfpyjF94rE4d9pNNxNirwgocVTMS66JwCvt0VXAu46auSnl7cCFJVs/M29u9272T9Lc3NkbK52iBFzxyBScwC+xC+yqTuL96STCncIRM/ST+usLc5Hzb7EFzMmhd5sKHNkrWCIMlb7CkZPP/7N19NCxsrtK3TGVA08JxWVPEni68HqWzH7dTe4yIcpVq3EzYPyU0mEmyfDSYBeip8YxukXrYa4AYKn0c8gmxTKQeMDEkgTyzCbImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zY4WG8nIKPzKVgG39yVAjCB7qLU9Kg4nZ1hxliCarE=;
 b=eLlPwlLTfJZnsONpt4wQUP38FoefCpdKSZaIPyfpq67ciFPso9KpKNUSmFft+elP8pX8QJJPEohBZBw5i9b1iyKfYXlGe3+0WSju/Qs4LCyfSCo2ZjpaDr2uXUQinhw8Xxbx5+oO1Cy6sybeknxabg22XEHbqcBctN+hBoaOApUGMyl1TTDd5BiKqccHEBGKNqMuepBoqrRqVMPyLValkNy3RwCg1o3p8ZGGJFoNSFwqf6RZedDq2+wkUCyx+p2h0OF13B8xQXXjtEz/WB3Xe64d/ML6tzmVIpjkT9OxyvCX2pTCM4EUgNGUsLPkaL1BK0KO+l5WzlXehnoHerM/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zY4WG8nIKPzKVgG39yVAjCB7qLU9Kg4nZ1hxliCarE=;
 b=Jk6pXvXGsspuKMGUpDLsu23JSeUIRJMPh8KxLYKtxMz7mvp5ViC+x6ZQa9WDW1uEQkZuoSsPj24S2u5td1tku2oMEaXi0VqA/VCa9s96uoiTUDuzOPENq8xWYqMM3IQHEeX9AqJO3PiO6clBGsxPEVMqe8qliEFK0CmG/10DtKk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 57/69] mm/mlock: use vma iterator and maple state instead
 of vma linked list
Thread-Topic: [PATCH v9 57/69] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Thread-Index: AQHYX1Q+r1/29byhiUK3STs14LgIEA==
Date:   Wed, 4 May 2022 01:14:04 +0000
Message-ID: <20220504011345.662299-42-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 970a71eb-9232-4c15-f313-08da2d6b7608
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB26881EE60A480118855EFD30FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bv8v1iG79K3jetHa/g5URtw2bceK8SjYy61dR684v4WiHjQ9/fycApbOAl4KdCSKd9rh7KvSet76uQquWzDyypcrECkoMnlOK8QkkGOLkIgaJxC4GfGV9ZELC51DhcmeouHAJeCLm4hb4x/D9grR7q4hOKHJYuiS8oyiWT//TAOqk9Hx/EQYruWd2C558PtKl+2wiDDfptoOvtNIICTC5QxwZV4jFYXknbxehVUw/exX2IfoFySi6kHjJTjUwzdnD2pqA7CKuhpOxt53G7L4tXwpOBU4MncEsbZbe0qGIOLmtSVAc3S1+h81i7G2sfT49WzJ3oypxuh8WBiEcg0MBliHdOrS82SBuK5HDYsIqMXhsO0x8fNJ56c7wuTSAxt3jatyyQlmDq4wtBxl15VGZgHBxIHyTxV8UbaAAZLsaDifGuLlzcUVz+VKJM//MA0fkDPLrT40PZTOo9ZpmpsuywjnkWxu2vpgT1alnXNY/Ojo6f4glO/OHuIqO1at5hKzfB9iwoWpIWGLGuVTP5tIwPIgJFk71O0Q1q5Yxif9TjIW/y8lYuQ6uqPTgbjyX9X2nH7ZevrOZzfh9lL+vg4VIj4GRZu5+mAWs3kg0XmaNYBuvNMQKuwuJdPx5Wv1o3ykb6IAh7cVUTBZyTwhLQPjCMkyIiEBGWi4Z5gUt36hxWbmhDFD/OFeDiGABQl2551yatjDHqLjx8rwuzyy4/CEtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E00NYO5jByVrD5bVjTPZS/l8cEb++FgYC0ezoQqVxChtBLsCWK0ZGk8F3F?=
 =?iso-8859-1?Q?SEsmld90D9kk12Nrwo+PZniXrZ+pz163vX1+iljwQY6sv8ZIo2mx8YyL9y?=
 =?iso-8859-1?Q?OASwAzSHCQ7g89itc6zDzNttCfBXUJf/7q8hZetKn0RkCp7j8bUyxmGGK5?=
 =?iso-8859-1?Q?AW+fFUoTsj4nwDU4TuByYemSQxEaM5LnwPCSCBXQcjN27+TFm9vWxpTzJd?=
 =?iso-8859-1?Q?ogdQtWYsxkS2fXVTy/SgPHsbo3KMRFb/DrbpbUm3GPIQjuaS3/8BMEmlRQ?=
 =?iso-8859-1?Q?it/zbxx8/w1va0kdwTmhz2fLKnVVjL2Cc8M48TIQ/BMTR3sDDGq7Jt1zEi?=
 =?iso-8859-1?Q?5r7u197GNDTBHelZnsekzCssTdCs3glPmORW+esIxQ19F9jaXtrstuIFk9?=
 =?iso-8859-1?Q?PdNuoXtgk6S7AbNBNG7JAjisOimHWBf/MKQiB9BRNu3l1ohnz/xYS7fT98?=
 =?iso-8859-1?Q?TPmKXybvoDVLuNx1w28QquvUmDaT+Mw/EEjlBzye14uJEH/ULxGoy4uSIC?=
 =?iso-8859-1?Q?5KHvXo2xU4nTBn2H3/Ku7F76c8AVR6MnNiRPiwX2xC9j0tfTWL0dUcTyT1?=
 =?iso-8859-1?Q?powSN3X0Y2B/m62hK4OF+PpnTd4JPWCEMQUBk9T+4ol2Od3CthGRxkOLAQ?=
 =?iso-8859-1?Q?yqtrBFMGCgjVqZOpDTHgQq4IaG8cmJSo+pzhY3CduJF+rq4p4seSI5L754?=
 =?iso-8859-1?Q?ms3M3BSQrOs+yKJiLHKUxK6Hp4584eVNH3oEPVmAsmBA38TEjuj5VClY/Z?=
 =?iso-8859-1?Q?hXnYCHHMxUIoCZcpcZbnmxh1cFBtt+JrHqXk9FAyZ7IqmmcgiGWzEd7fVK?=
 =?iso-8859-1?Q?Fuo1DtDTV7dKHbYBIdB+bHJO9JMVymVhV4YjSA+DXzyJM4ggTgsWu3Kc16?=
 =?iso-8859-1?Q?Lq3/Gs4LBYtJtKh3MJuV64D6GJDNvYSIGDdhjW3c9IJFYt/hrTWmKfNcvw?=
 =?iso-8859-1?Q?P9TIUwzjfolD+gkYoKSSNfekumXVUCgWpCYJJBEahcc9YQxcT31eSSS2Rf?=
 =?iso-8859-1?Q?XKi2vYoooojUbk/WjKWth3dkHrTa75As3Obg1rqK7NH/XrmQv9nBWgazqM?=
 =?iso-8859-1?Q?hIg+FPZVTKhk7dm0LA0kMmAwmvnggr9TnTgJpzblVVNiLhKKrwwCLXfPri?=
 =?iso-8859-1?Q?jYCSZEYEqB255hf2jWD16LsXADFYVdZzzirDgW44ueGIORwI+5MO01xhgG?=
 =?iso-8859-1?Q?Q/QjmWXwcreV4alu7MsH3vllGiAw8O6nDF8cIvlWkloFPiWqj1S3xANg4Y?=
 =?iso-8859-1?Q?v9Wez0Bm6gxS3MIcR3sdd/EHXrcVmB3P2rdjlXlmQhMm41Q/g7q8f/X3O0?=
 =?iso-8859-1?Q?4EcJXgWy6e6TiEaDjgn1BIEwRFFGrMePZII71aHOEtON3NYDD5UFSEVgUI?=
 =?iso-8859-1?Q?potG/YP8z++dVMXLU76/mZiotLb1ewjmqS2LCt+lTcjur4/ssdjHpXFHvc?=
 =?iso-8859-1?Q?vfxdkP9DnkZeEzIe/R1jvT/CK5j0dcrmSgDiijsfQ4SpFFdKw4sUCQy9F2?=
 =?iso-8859-1?Q?o0TqGkZHaUfez/N9Q92Mc8NliR7QZgd7fhTVbqIpmV+l1oE3UxdCyHen/8?=
 =?iso-8859-1?Q?e5pCjM0nDJEC80xi5dp4t9aEO2ApL+5ftNyYvbtCIY0AiUzUnU6b8YYJaZ?=
 =?iso-8859-1?Q?zMkYFvF3LkrPWPerODuB8oW7KN4QkB6UcS8H/zVSzAW/8gIPHgpMBBJPYn?=
 =?iso-8859-1?Q?HdIj9CSKgzTl71fPjbccoQbIDPXQ8iIhYTNdD78gHFj/FmrvTku1/pPpLl?=
 =?iso-8859-1?Q?bZsBml2WU1J1DZodJcBbmdgcxF5vWsH+7OrXODORVmzdWFVo5woomTc1Mv?=
 =?iso-8859-1?Q?Z4vM91ZX0rXvHZ64kJ/+Ylws9zRcStw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970a71eb-9232-4c15-f313-08da2d6b7608
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:04.1262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwZ0OfqkjeCZXR1hk8WNXmbL8iOLkEm6cIQWPeVGz2qPAvRg0koYXGfGz0h3B1dc/i/Ecll5Oki4KFJtcf3NlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: 6MnK9PkcfIMNFiYUQDSQB-g3q34D_GGq
X-Proofpoint-ORIG-GUID: 6MnK9PkcfIMNFiYUQDSQB-g3q34D_GGq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 716caf851043..c41604ba5197 100644
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
