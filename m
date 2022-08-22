Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4B59C229
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiHVPHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiHVPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:05:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8832F3A1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:05:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpjil016581;
        Mon, 22 Aug 2022 15:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NoL4VqTGZC0RKkzQY8HNwgT3vNdUtyaMFi7wHrI0B9w=;
 b=GJDLellenfS8dkxhVl2E5QENi/Kmvc/haOh6PeVTF+AsWnB/G6MwglceTYNSpasNtUYL
 zQA1/d1/H7vatBrYlNeIzbiEgVMtbgOYyxeViXLOcQIWzp9z8DDlIgCWrK3MusPrSIYA
 Jj/9jhsk25nF5b/AXoch3RwMsAOfRGhpMpFb7i/UNbVhuft04NY3COmxVHEWlBnNggPK
 uSYSk2hqu1AvsRIfU9HfPgFWto9ZCUsnBjnhRsZshiVyvluQVnYdLZNQ1DgXDw/cfLgR
 mSxqFq7zQSJA1eIQrtl2HAjPXS3cvb24t2CNwhkoN64T+mCvBrVB4TBXQXzd3KXwuz72 6w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4ObA005123;
        Mon, 22 Aug 2022 15:05:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn3txey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/diorcZ/P+dK7onpzvnMtiz/H1j2KQAfDNlIvaIyt8zbU88v11UXnIi5ASQRUaJOrN8gv1Kc2lkL03tpYUTeS1wZH8u+lzoZlmtrraGxpsiPflm4XkZuaasXUoSgCZMFk289XoSIQRwtiY93iVzar0OMZwdMeLaN+T1ef6LL4FyukiXcfuFhmbMCVP5lp/KpCFP2D6RdhBWyTUX4oPI4nOPMV87Mr1zR8k53zzSTA0sGMdRkSgYywUpYS4EotI2dS7pHSZdyA58gkgVCIwehokSKMS4zMn0fVXDhluKNdzQs5+17kLd1tqMhISFWpPGQf5DFyK6RiJc9+2IVJfkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoL4VqTGZC0RKkzQY8HNwgT3vNdUtyaMFi7wHrI0B9w=;
 b=BhmGrkU03ZW0m2AocGKkBZ/2kYSwNKwKAUKCwOaHozzzoXZYYZJMDAQqLoI836XXsZssKsCRH9jEwF3u3B2nSGX4ZPl0QpKor7CkZbhO35XnyCVfCDv7E+12GVjIKU6d79tYxM9WYgna8BJtdEU+2bxU4154QSog6uLTBQIz03JnLJSCU4sTIksPiX7GdxryC5kWWYGQ3CUaM21aBh5WodudYahXRFXspam8MVrrXYcgO2BtuE7CjDJJ2cItXpzpaWga7jn7qV/xGIzvSGEZhFERHXxduC7YcgnAmfXPlSVXLn8Mg1x/szaZi8lpByvql4IwD4a0K8y1NWWaOpYSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoL4VqTGZC0RKkzQY8HNwgT3vNdUtyaMFi7wHrI0B9w=;
 b=ol7rBD+LQG/LxH3DLGoZNMmc/inaB5y5FC7ZydY/imvZ6C9EuWlNaLgibxK7m4vKyxCapZg1m+y/E02ifIVL9vKUlzDqphDb2T7FhUFLsib3EGeIO2yGm+fotbsNas5ni7HRBS+Q/GeR19UdxfCd82BNijkzFBr1knncNMSYlKs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:05:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 24/70] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v13 24/70] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Index: AQHYtjiRxW3txf/Dp0+4jT4uU9pIZg==
Date:   Mon, 22 Aug 2022 15:05:09 +0000
Message-ID: <20220822150128.1562046-25-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c45ebdbe-d913-4d3a-f320-08da844fb47b
x-ms-traffictypediagnostic: DM4PR10MB6063:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QxEyFXh+btinnnxp9/3cOh2OJFUJD+xvUO7ArT7CudR/byDVadkdGlkEoiD2BvFuupZhdbWKuZKDl/BBLN3QcjODgRcdN+HN3bSJ0R6AbxP8AUncJtubu0CKoVQcqngLdWq7svtv4AcChw05GF7q8NBbu6ayOMLSrAGjhTQqYZbdin4zXx3c0HWDlfD80R5R0S5ssthay6mIK0C6rO3Helt8oA+lQ9SvmRRXrsuSyWgEt1SOhJAvq5RJjVhIxfy2WrrnO2onUhU6SrONIdlz6YZrC2nXQ/aUOkfTKtfmiJNcD7mmB5HqiJmyt3rXOvu9g/JiYUlKGpnuaeh2Xe4gmVBSCpHndXd4Le1Co8qNfDMnjqFT2i7ewUfOV9zRklAeuLQKMxu6xDp5OlAVB0dRmBxBxUblqYgNbsl0hShMfU/N6tMlebqzhM16IpWTulfAcEofYKbBbWLdw8BGn54XooTjb+9+eMcnJd0BUDeLJnrWhCli1dldotBEoyrfBwGtK1GnpuCueka1dKwHiEgp/G26LWaaErTx5wJHoJRmjMlIA+43Is/VTcszmjgLskqG5ffTF4Uw2cGrEZo553RebFODKL91jyPx3xu24BhUPo7wu+ElshKxRe3MhgrT4S9GN42EgQEKUqtC+N3WaP8CHd20hn8HdFq32oHSiAh5YcfHUbdWIpWleEyoCTzXvY2EVv6cG5WZ/5UqhRhjbkvyh/xM/tcJ8WXepzAmfaGCMq+P7jPYi0KW5G7oMML4WOHAvpM6xAqMGfOvxFHduz0Q3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(396003)(136003)(346002)(86362001)(38070700005)(38100700002)(122000001)(41300700001)(107886003)(5660300002)(44832011)(30864003)(8936002)(110136005)(316002)(6486002)(66946007)(66556008)(8676002)(71200400001)(64756008)(66446008)(66476007)(91956017)(76116006)(36756003)(1076003)(2616005)(186003)(2906002)(83380400001)(6506007)(4326008)(478600001)(26005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WW7ovNE7NzjM6TpGugdFJQxZ9QpD2nnAYR6dBJErLHNbc2hnrb2b2sOlBD?=
 =?iso-8859-1?Q?sLGH0emuNIzegzqpYTo3kEvVp3qFZ7cdKNJ9JoZonKZDDkoQBB/0ZPfhA6?=
 =?iso-8859-1?Q?kDTLmMRkqJNXIgLwGGk58dQ802tfY9TkNuX6bZa9Ot3sI1qXt7K8QbfLfK?=
 =?iso-8859-1?Q?VE12Ovt1yeYy3I+3VnnEFKeDcNWUIC0so51Kx9OqWG5zXTWfUa2XJdTrpa?=
 =?iso-8859-1?Q?Xr/NSMWg97ZcNl57rq8olVyRzeg0NhQ0R12rJeMIjg65lHB2cxcXub5SIX?=
 =?iso-8859-1?Q?IsynQ6jzekcFm4miEBPztyJ07J6AnLVMw9CDbzjU4xMbJgRDws+2/oqRz2?=
 =?iso-8859-1?Q?sItiCEXwG7I0EzJvvy9zhOLIcdhivcRVDwh6IQN1gD+FIUKDEvF0rBdKOX?=
 =?iso-8859-1?Q?cD3U5wsAyIwBBy6XIGrxEY92hvpzegQGDR1GRowRQhuGcaYsn7v3jS+Vx6?=
 =?iso-8859-1?Q?H0apAKRuCZu5QA+rlMm9VY/xVlssBcmFijM8BR6gRbtJUFvnNIdRWWZtp3?=
 =?iso-8859-1?Q?MyLvvbyDwfygSBp8z0O4UwGHnmoq03etm/vUIwnVuRXsC9VIRGnNfn8I/p?=
 =?iso-8859-1?Q?J+xpTzpw914xmmvHtLk/q5XmZueSPOwShWUenpkygKSOzvREIKnmlDbxba?=
 =?iso-8859-1?Q?G/AjTAkmLs7rnTiR0HXDNevGx3PRCj5y8CDCRZ9uLA4QVInSHt0jwOk9n6?=
 =?iso-8859-1?Q?63moYh9yuRYxXuwVn7M6spZtXfe2QEXUJTWPy1AKNKlmOF4CWk3o0MP/Sb?=
 =?iso-8859-1?Q?PZ2OgxAFmS57mvXUzJdu5wQWcCaW5kam5vd98/ezHzbMSHqh+MOkLZnqoP?=
 =?iso-8859-1?Q?eFHKOln7kiq/5uvyJWdglk4mjLhDs4CP5dkT6l2zmd1jPAZdPXWncpjktj?=
 =?iso-8859-1?Q?BBAmlM6mo4wVmQfmukC8Kl/BbvYEUmiTIkxKiZX6nx6WyMgWOtHO2Uv+Jp?=
 =?iso-8859-1?Q?apAFuEDzuP65uieYBKrxv631YWKOhFnrO6PpNAI4LA6TjDvrsWDwnf/se1?=
 =?iso-8859-1?Q?HJAbQGBQ45eA8bNZCiCC0OrBrk79C5fJh/NTpMrY2/kfM5FbcI+ubSob6L?=
 =?iso-8859-1?Q?1DZZnWRr53IWpCkldNgRu4bwOCKW1eQykfJQaEtpKszROXOKXpAYolRwMi?=
 =?iso-8859-1?Q?yN1gWlGpBLbs9FoX1Wj9nQGPEd0AKsa0ZJP6TcKNnuNTMEW/UwI1/rF+Da?=
 =?iso-8859-1?Q?2cwWl92fHjfMmGmPYhgQ8eG7gVc0cNoK2e6loXtoe00M48awmY+TyFGr/S?=
 =?iso-8859-1?Q?wUEJ4M0FCQShSXadwYX7jkZXeFCv1YClnHdfSPeTgCMl2qf46K72G2WhIr?=
 =?iso-8859-1?Q?k5uM+9Pyxot/8IoY2K3VG4Viu0y+oaeVrhuITe+PmcqEBGvmKtHbtluj87?=
 =?iso-8859-1?Q?XcVhV7Vbgqz67YO5xjoG7RYR+u5LhFYh8UTDULtliJ6s12nCJ63trO2L50?=
 =?iso-8859-1?Q?+cmrqf/NEx/yVsMGVkFV7qtWIuEs2z9SbRTGlJvzKYJ8xSENckLT8QTQ51?=
 =?iso-8859-1?Q?xHysfdRhQSyTpIKH2ViahUxhqbJwV1Vk81DxnXahxSVVhn/BeMYhpP5FLF?=
 =?iso-8859-1?Q?Oqt4M9rI+O9N1VcJdEYsIgIEluSbPab/WHkw3wk74/QlGrvjH9FDcuyoh3?=
 =?iso-8859-1?Q?4pzlOfmGB3hTa8rZMEg5XFd8iCnOQ5VxdW24sIb55JgMcglDe9jJVGVQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45ebdbe-d913-4d3a-f320-08da844fb47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:09.1026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYVsyCzEzToSihBJtwoR5cWUablB/E5rrdelZZcLskIIfZvkwijwbk5s5ElrbJMEKmsUuc+j+ltWHbMeZXCTjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: qcztRbulXD8RdHisaznz-x2e4I5JzR1T
X-Proofpoint-GUID: qcztRbulXD8RdHisaznz-x2e4I5JzR1T
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

Changing mmap_region() to use the maple tree state and the advanced maple
tree interface allows for a lot less tree walking.

This change removes the last caller of munmap_vma_range(), so drop this
unused function.

Add vma_expand() to expand a VMA if possible by doing the necessary
hugepage check, uprobe_munmap of files, dcache flush, modifications then
undoing the detaches, etc.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 251 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 203 insertions(+), 48 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 57391f99afe9..ed45c6fafd94 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -470,28 +470,6 @@ static inline struct vm_area_struct *__vma_next(struct=
 mm_struct *mm,
 	return vma->vm_next;
 }
=20
-/*
- * munmap_vma_range() - munmap VMAs that overlap a range.
- * @mm: The mm struct
- * @start: The start of the range.
- * @len: The length of the range.
- * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- *
- * Find all the vm_area_struct that overlap from @start to
- * @end and munmap them.  Set @pprev to the previous vm_area_struct.
- *
- * Returns: -ENOMEM on munmap failure or 0 on success.
- */
-static inline int
-munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct list_head *uf)
-{
-	while (range_has_overlap(mm, start, start + len, pprev))
-		if (do_munmap(mm, start, len, uf))
-			return -ENOMEM;
-	return 0;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -618,6 +596,129 @@ static void __insert_vm_struct(struct mm_struct *mm, =
struct ma_state *mas,
 	mm->map_count++;
 }
=20
+/*
+ * vma_expand - Expand an existing VMA
+ *
+ * @mas: The maple state
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ * @pgoff: The page offset of vma
+ * @next: The current of next vma.
+ *
+ * Expand @vma to @start and @end.  Can expand off the start and end.  Wil=
l
+ * expand over @next if it's different from @vma and @end =3D=3D @next->vm=
_end.
+ * Checking if the @vma can expand and merge with @next needs to be handle=
d by
+ * the caller.
+ *
+ * Returns: 0 on success
+ */
+inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct address_space *mapping =3D NULL;
+	struct rb_root_cached *root =3D NULL;
+	struct anon_vma *anon_vma =3D vma->anon_vma;
+	struct file *file =3D vma->vm_file;
+	bool remove_next =3D false;
+
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		remove_next =3D true;
+		if (next->anon_vma && !vma->anon_vma) {
+			int error;
+
+			anon_vma =3D next->anon_vma;
+			vma->anon_vma =3D anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+		}
+	}
+
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_BUG_ON(next && !remove_next && next !=3D vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
+
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
+		goto nomem;
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+	}
+
+	if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	if (file) {
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
+	}
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_mas_store(vma, mas);
+
+	if (file) {
+		vma_interval_tree_insert(vma, root);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	/* Expanding over the next vma */
+	if (remove_next) {
+		/* Remove from mm linked list - also updates highest_vm_end */
+		__vma_unlink_list(mm, next);
+
+		/* Kill the cache */
+		vmacache_invalidate(mm);
+
+		if (file)
+			__remove_shared_vm_struct(next, file, mapping);
+
+	} else if (!next) {
+		mm->highest_vm_end =3D vm_end_gap(vma);
+	}
+
+	if (anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(anon_vma);
+	}
+
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
+
+	if (remove_next) {
+		if (file) {
+			uprobe_munmap(next, next->vm_start, next->vm_end);
+			fput(file);
+		}
+		if (next->anon_vma)
+			anon_vma_merge(vma, next);
+		mm->map_count--;
+		mpol_put(vma_policy(next));
+		vm_area_free(next);
+	}
+
+	validate_mm(mm);
+	return 0;
+
+nomem:
+	return -ENOMEM;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1630,9 +1731,15 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev, *merge;
-	int error;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *next, *prev, *merge;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
 	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
=20
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -1642,16 +1749,17 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 * MAP_FIXED may remove pages of mappings that intersects with
 		 * requested mapping. Account for the pages it would unmap.
 		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, addr + len);
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
=20
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
 			return -ENOMEM;
 	}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
 		return -ENOMEM;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
@@ -1662,14 +1770,43 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	/*
-	 * Can we just expand an old mapping?
-	 */
-	vma =3D vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
+				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
+		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				       NULL_VM_UFFD_CTX, NULL))) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma(vma, vm_flags);
+		goto expanded;
+	}
=20
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1682,7 +1819,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1703,28 +1840,32 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr !=3D vma->vm_start);
=20
 		addr =3D vma->vm_start;
+		mas_reset(&mas);
=20
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
-		 * as we may succeed this time.
+		/*
+		 * If vm_flags changed after call_mmap(), we should try merge
+		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
 			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
 				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
-				/* ->mmap() can change vma->vm_file and fput the original file. So
-				 * fput the vma->vm_file here or we would add an extra fput for file
-				 * and cause general protection fault ultimately.
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
 				vma =3D merge;
 				/* Update vm_flags to pick up the change. */
+				addr =3D vma->vm_start;
 				vm_flags =3D vma->vm_flags;
 				goto unmap_writable;
 			}
@@ -1748,7 +1889,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (vma_link(mm, vma, prev)) {
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto unmap_and_free_vma;
@@ -1756,6 +1897,22 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 			goto free_vma;
 	}
=20
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	vma_mas_store(vma, &mas);
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			mapping_allow_writable(vma->vm_file->f_mapping);
+
+		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
+		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
+		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
 	/*
 	 * vma_merge() calls khugepaged_enter_vma() either, the below
 	 * call covers the non-merge case.
@@ -1767,7 +1924,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	if (file && vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
 	file =3D vma->vm_file;
-out:
+expanded:
 	perf_event_mmap(vma);
=20
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
@@ -1794,6 +1951,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1809,6 +1967,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm(mm);
 	return error;
 }
=20
@@ -2632,10 +2791,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	prev =3D vma->vm_prev;
 	/* we have start < vma->vm_end  */
=20
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >=3D end)
-		return 0;
-
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
--=20
2.35.1
