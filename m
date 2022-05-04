Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C65F519357
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245045AbiEDBRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbiEDBRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC64E27FCF
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:13:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243NIL3H004092;
        Wed, 4 May 2022 01:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OSTa9kaHYK2ZqH1nXuy4YN0cTqCfCvNxmCWDsGTmK/w=;
 b=DCckkX+RBGLikzVMS0SrnzidKuESLe6viC70e1TMdJxrIhgCoKSkbodKVmJkEMXeFwR6
 G78+6cYi43WL9m1yRXPns5fK5Xo5W1/4+zBDo6SLaqMUX2TDZBZ2h6gd32Q67gIxOjKB
 e33gVVhEXu9sTGy2dQqyI5PmRYco4TmXL5V7HaJR9h8rhI74CBhQgisRFHbOfR7FN8kC
 M/j7WgA4Ksn4ygvKB/NXH6TNF2ZibXvEJdI7F0B7d98XffHjhu6YIIO2CY0JZEt0yjDG
 Yl1PW81FY53DsxJw+vBJaPn+NU1lFfR0dSPYpn2a0n2tSPCEkDjFrL640jYlrwVnQUOx Kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apxyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJQ013094;
        Wed, 4 May 2022 01:13:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKXpgBTAxUf+nx/tbdHriDPwE6ld16+79Zhds857m3eJAkVXXZ3HouT3xaL5OwfTm+A9N+bK2RzHYpC5tACsZ89rwJvy5wRG7xaCui8RqKlLsi6sdSRPRZDlec707Y3uzDn6Qf7ra7bogTYggdpaPfBL8jtfespSRdHgZ0hQRrxElvbbz2RlZWnrkf5JdGWV9VsP1mhPz6uRi8bm5iTWKcB4wR7eEhx8cZK9WvbffZpdA7m+hakF+vyr96cM2JeomdoEVJdX1m9t1n1OwCaiWYmV+LwmTpIM07RGLI7wSH84MQySSycHG3rimT4HoVat0kgZBLGG8bMnBwrZqGBIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSTa9kaHYK2ZqH1nXuy4YN0cTqCfCvNxmCWDsGTmK/w=;
 b=EEy6mGD/r+UUsP29cpwITGimAoFtx3KRbf5ecyUX45aNrRRNj9sGChUzuM9lNX2Cb/1RhDMkGpXCoxZj64RWAxQYfybieRrIZsZJdaNnPKTzKb6Zs+oZzeuU04RNGAQ6NU7Fh91rw741zRmSWcyXAHh+yPqTNGOtJ3rkt2tjylueCr+mpg6kzktQhQvrMwtSsOeWIVMRzK7ax6pgQAEvEag8HF8DsPa+fKerP0vHaUIKLG5VM42bYQuFJ4dhkHpaTWupFSMXLTRGYaXmgLXTeMN67uCziIXdVV1Jb1sTzflwG3c05Dz3aOYJ7aL0Hg3JSJZfNnT8mtp3RPoNrndKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSTa9kaHYK2ZqH1nXuy4YN0cTqCfCvNxmCWDsGTmK/w=;
 b=cUCS/bYCr/yHIuaA111E6mT8aBFC9HJ8lK47q6FrdpZw9Z0/DAz6ofFweD5IQ95IiT1QcypHyqUs8/zTG/99JDE9lUqfhRJNzXDin9VvCy8GTSshfWwQ2JD/aPgWAXtVqZhYplcXMuL8+z5bmmOsCJEIKU7uo5PNeVkUzKnIcig=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 18/69] mmap: change zeroing of maple tree in __vma_adjust()
Thread-Topic: [PATCH v9 18/69] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Index: AQHYX1Q2zOYtx7lWNEypQfVNSHXowg==
Date:   Wed, 4 May 2022 01:13:50 +0000
Message-ID: <20220504011345.662299-3-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12cb40c4-2c4d-4e50-cad1-08da2d6b58db
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB5830A1106F96E68E49764929FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wPlpHJDev6qnCH/Cy2EophXKV6sQ3tF+rGSFytKvr7+Y19Dhvrf3sXSB5rZ9pt3tmmiGvR4qkU4Wx/UPcydN9TrbT+v5LmOfW9eJR1zxO1Y9UDqwkibXqVi6V7eouJFCKl3ypUDr7xtkdCkQugUlyi+vjb+DuRsfOrGOZk20fiIlzYYu6Gl9OKx+Fd8MDwD8HiQ6WikFRdJARnkY2HdfmR6Yrf2fiZhANysV8SAsiTGpauNedpBrFXz+02xzLZ9yPVaJ6NWc8nnbAaLmJbU40fdRyHlTCfmCEIpdphZPzW+/zTdql1WEIg45XHIixDOaKScJGIUpAL9ptQGt80VIITacVNoxacpFtAi3AlptYXTHo4n1GPgJRV4fWeOK7L5mtpQbyMAe/PtnhG2i4xyPhZTi6pl+JGC6Br6agL/Dnvp/zXzHZYYKhbSOmAQDDrrqC50I0240bNSnHduQ96hnB/LJgjoIsalkOOymLr2hCA3VGTCLQsN/bLrisGVt8ZKzYpbRY/8/I1Kcqg2SbevwaJTqjYgPOTp/vR0dSHOKdQt06X2aaWfgyjPI2vFBizCtPqQGp05N0c8IU4tteXeQPF33txCSBskVnoyMz7+74xFDoZn2LEm0AScgB+0Rtn+qlnGQv2q8aXRcicaSZz1feGwv3XS80FeEmZOnAQlIWr0W7o0zdj7FY69TS1jujSzTQ41QoajR9W58/imeJzw4cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/CI9kQHKZye9YcxWACWtjiks1wcs9Wrn4h/xlOX/gRYuWKm4VsCuRm7mkB?=
 =?iso-8859-1?Q?gAATjx5vtM0X0Yo8SibrPrt1UOOagrf5dU9bWvWPI63znneYXN0jeBnf8G?=
 =?iso-8859-1?Q?ksUFAQbxBAT0lZzXZV5gWxItTamtDZZRdWEIuZN9Wbag9Xq3q0pJEpy1Av?=
 =?iso-8859-1?Q?r3YwAD4W7bTUSyS2qJ2a2wchKk5gcrZDa7UVFQWqh5c8rbDLOxdX2rLaOi?=
 =?iso-8859-1?Q?O6AxJEdmNrpGrrN/dDTxdqRYq3Q2Vs1E3631/E9ap03vMy5XFbWwbLFri9?=
 =?iso-8859-1?Q?QWT8zbOC/IAiDn6ntX0IcY5dHaKbvVqtzjqrHEiOF8HKc/4Kmdmq/ncxgg?=
 =?iso-8859-1?Q?hZSPKUUG4RoMs4cZ3IhTCbSww+e3YVvPgsdFjXxYVLq23UpdghpmltRzek?=
 =?iso-8859-1?Q?auVwcIxatX6Pwx0hjDM9v2qIYf+81jBBNYr/Q8jOZrolfhv04Xla2Fu9Bf?=
 =?iso-8859-1?Q?YvuuBpi/9Kokz2FzNrLdNDd6rUcly4ET00C8pIV2kAEllNjwrvSfLzLYtj?=
 =?iso-8859-1?Q?9uJpKTo9XB98F1J/xAmWHHXGCWKnlT5+RefzkDtA1icVCHKGPQM3iNZjsL?=
 =?iso-8859-1?Q?VKoNmCHJUtbtkTv6bllwwRK3csUme+PWodAghkrIWdNUqlllVoaQMSkxkn?=
 =?iso-8859-1?Q?jyPXSDiLW9OZ7Q3Sm7/Bal3+7+grJHmoNoFXHQ/6ndUmovbUpbkLN5xpER?=
 =?iso-8859-1?Q?p9Ht1rOkfiVFaB3+L2HMLhjyQmqxeeQZOZjJ5lrlotphxBMRmjkCfWcEMc?=
 =?iso-8859-1?Q?tG/4gNpfsy1jaIEJymPaJNlScNzqCq2xScrKelCGa3ym9imHvHl/bWHFy9?=
 =?iso-8859-1?Q?wLPFpOmUPJW13X/S6XQpRYCowd+WluIXfiXOHO/OdAkaKc/O35cXX3UIkd?=
 =?iso-8859-1?Q?oYwuCoh1YOdvW/9QTaGeFkRboNR6T7M7VtkMMlOKrug8Hc95JrIGyeIDkO?=
 =?iso-8859-1?Q?ctCjUkal6cRvos4l6km6JQdwrrA+4oIf7HMuRN+5lJaoECKZ3+8BKW+cVy?=
 =?iso-8859-1?Q?EnJXHuu4P9cE2uqrMY3iB38nnCBa3XvEniqnb7Nk2oYEQwT3oNqmW4uiYI?=
 =?iso-8859-1?Q?52rJiuJqMw9wT1nxKNyPjFtU6mGUXjv2txgLXm7GcnzMdCvQFZac4Xknps?=
 =?iso-8859-1?Q?NVFc/fkbU2PDPXgPXp+ilvBW1kNNEWEiKZbWY89u3AZdkrA6ErWDbDkAvT?=
 =?iso-8859-1?Q?zbCtZr2geSRbLX02iuaIYOtfxVNnwhslvOKcJLXQBxJD6FDiVG33L2zrbx?=
 =?iso-8859-1?Q?0jp12P8PzoSJzmDunpWdsAB85ZK5btA93iO1vCh/9xuUGPzRqTzCVB8XUV?=
 =?iso-8859-1?Q?IjMTHCB0SuLRnbU2Abr00kIx7Ng028gzki3ODLlXWmALme8hN8hLfoxaTS?=
 =?iso-8859-1?Q?EubLNdcKeoN9hhlKaxToTdDCcVrIOd6m0mcMJIw8U6wlg/vjkbxY9d4BtW?=
 =?iso-8859-1?Q?P1zGC6MAKn6gVf7AjCKlFx95gEIwhFLq24RREi5A8kSWsdhTn+SZiQ9yZZ?=
 =?iso-8859-1?Q?VduGNCXb50EdjD/kgKonX7P0f6FNVBS8bGKApw0e0rRoCXw8m/+5EIjL28?=
 =?iso-8859-1?Q?U4hSYH++S7bEwZvxi3Y0TKf2HvT+9+Sj4s4gXewssO/Fj+dbmwxatY2JDM?=
 =?iso-8859-1?Q?xYlc75UJLrTFFB387rl4wiOt1MiUgH0S0BSVlY60ulnyn4OcAVjAjatkZO?=
 =?iso-8859-1?Q?6f6/sRwDCusf6F/HXTZpuahx4T7yUybbvpbqY3KDPKIirHbyAMD6SbThTh?=
 =?iso-8859-1?Q?La+smPOSxKz4fTRFXYjA6fJyYQ+NsJ8TW49Jqv5YbeU7WA9KUSH5GwNktK?=
 =?iso-8859-1?Q?uBP4sZd4nJWnpuimeDHeAF05gr/CKGs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cb40c4-2c4d-4e50-cad1-08da2d6b58db
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:50.1271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnUpz+4dGpslNU3O6HrLzdYexHUeOUsuXslGBwF1AffTZmYaGfb1FeoLFCx+klcSUKlt2qYfeGnK5LJ2n9wTmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: InAmIyOke9iiIifciXoAXPRJkxgzKFdE
X-Proofpoint-ORIG-GUID: InAmIyOke9iiIifciXoAXPRJkxgzKFdE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Only write to the maple tree if we are not inserting or the insert isn't
going to overwrite the area to clear.  This avoids spanning writes and
node coealescing when unnecessary.

The change requires a custom search for the linked list addition to find
the correct VMA for the prev link.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 44f9f4b5411e..6f1d72172ef6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -613,11 +613,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma,
  * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
-			       struct vm_area_struct *vma)
+		struct vm_area_struct *vma, unsigned long location)
 {
 	struct vm_area_struct *prev;
=20
-	mas_set(mas, vma->vm_start);
+	mas_set(mas, location);
 	prev =3D mas_prev(mas, 0);
 	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
@@ -647,6 +647,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -778,15 +779,27 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start)
+		if ((vma->vm_start < start) &&
+		    (!insert || (insert->vm_end !=3D start))) {
 			vma_mas_szero(&mas, vma->vm_start, start);
-		vma_changed =3D true;
+			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		} else {
+			vma_changed =3D true;
+		}
 		vma->vm_start =3D start;
 	}
 	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end)
-			vma_mas_szero(&mas, end, vma->vm_end);
-		vma_changed =3D true;
+		if (vma->vm_end > end) {
+			if (!insert || (insert->vm_start !=3D end)) {
+				vma_mas_szero(&mas, end, vma->vm_end);
+				VM_WARN_ON(insert &&
+					   insert->vm_end < vma->vm_end);
+			} else if (insert->vm_start =3D=3D end) {
+				ll_prev =3D vma->vm_end;
+			}
+		} else {
+			vma_changed =3D true;
+		}
 		vma->vm_end =3D end;
 		if (!next)
 			mm->highest_vm_end =3D vm_end_gap(vma);
@@ -821,7 +834,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, &mas, insert);
+		__insert_vm_struct(mm, &mas, insert, ll_prev);
 	}
=20
 	if (anon_vma) {
@@ -908,6 +921,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
+	mas_destroy(&mas);
 	validate_mm(mm);
 	return 0;
 }
--=20
2.35.1
