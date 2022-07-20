Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C791057ADED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiGTCTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbiGTCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8345D61D83
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K02wnY031777;
        Wed, 20 Jul 2022 02:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ec0cHycsDPhyi7HO3m3QKum6pid8nANYMV+OihbOSqY=;
 b=iNpBRFhdtytB2Pnd7ZAcJ2MBfAQaiy9i/froyNMYq4OGqJJcqvIIegF1EuAyoJmJ3C2v
 V31a2TLSSBZgkphx0/Lqvo2hAPKfLTpyUsBzzymsJ4F732Ni8GMTqYOJ2ovz/gTTOAQg
 myF9tTvO9x5GvmsSvnz83AZ6UloVJNYFEY5mQfuXetfApTkznikb/SqXThD5byCyvAxa
 vZa1haY5wax6WTeefuzClJyKWBnPdEzlTePSUh7Re0N0XQCe7UV1bdqmxFqaaRyOtpk2
 u8x4/PgummJ3WKNY8kANEwiAx0kTMKTMmxHa5chpqxw+gUV7IozfDr/d6A0D2E5ZePDr EQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLL4022321;
        Wed, 20 Jul 2022 02:17:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rbn2dSA5IytwE5nf2y5OVlAZLwEnoWaqdQdkNhOhHyccgNhNxJa69nOHAHrUoRbnmXChtLVHNLAvo2SeKyzHcrsNm//sb8oj7f5rUzkITEWIDacwrER3GuOGRMEUUMBEu2vadX7r8RSe1UIVWUFaHANupW5jPLsdQqtYSRsTOO25PfF5KSBNlTYvcmx08ANCLrQ5LZMKm95RuoqQN5MtJOPy0r3Zm98mJur/qOrGAPtiHg84C2UQcsCtxbRMJcoFsewozLcBgfxshcY0u6CJf3i5JostGnRBdf8CIQuMk0UPDgRA61849bU/W3M/PWmkeR5dffPKYwIfQMVZfjV/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec0cHycsDPhyi7HO3m3QKum6pid8nANYMV+OihbOSqY=;
 b=RGTEsAfIMMCqFvzfXyQtGXy+I3gCjL6GvfjRd/l6c2Uum+m8PAWqc1SeJv//8bRCJe65cTBYM9psWcAL3eBpsPvaeH0hznEHTTzrAIcbMAImO/m7mmSgLKhxns3FI3APCuh6WSWH/hkJP97kOJ6PTgTshvMsh4O9LjQkvebkOqZ+TqHqx24H/uaSLqsPRrFtFvH28gAjZcGdTndog/Tk8blA8ypPvxGW5/zV1xQY46YCv5bIFja5siSjlHObUzZiaD4y/ZK+Dgd+sd1EOTCBIXpYz1HUp85M5t10e3/j8G5HIkPDpjq8mTEQSBYUqu/XZ4f09BwVSw95z4QAFl0y8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec0cHycsDPhyi7HO3m3QKum6pid8nANYMV+OihbOSqY=;
 b=zSlVUNNRDMxFHwjTHGpjGndFuzIRoUB3pacJzcs4CTBUNqxILzSYnVNAlpESfsOGibo45euHaIUff3F+zWDfI73w1onZNj3l+iDd+64WEuyskN83vG10PzP+y6KaBXA6v3pJ4SyIDRUwjBnR4XP8f77kbKUCAGcwQPA7oH5D6pI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 18/69] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Topic: [PATCH v12 18/69] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Index: AQHYm97o9eoOtI+y4USPXgtJH4WYmg==
Date:   Wed, 20 Jul 2022 02:17:49 +0000
Message-ID: <20220720021727.17018-19-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed3b4bca-4245-4760-0395-08da69f60d10
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Qpe5GCevVstJQIWBys307yEjI+6Lq1xAj2IJNnCd6gfnZlU69M+Yu5m1IvdZGfBskkyQiRq8YHh9G8u3nD41Uf8v/e2qFDlHKIPDq+OA43JNdV7gk3podWvxoA8tZvlXESOkqVtMReASUz3JP7Lm7JOec6veSOlNk4bHwwewV7JgwDRMmYf1kIFMHVHtsgjMWdiKFzXcPoiPiCf6vGmHMAyS+8Gb5b37rFqvJVnFBrYkfDxpJ4w7HWETFG5YGzHlDg4HuY/uis65N39SEjJX+t73IgGQ5KXjGo2HyK9hy9WnB47vWVrzBFW4oUwigjrcsSkEnNjOwEUU3y7gHfH9OHMmMb8Sau3BWIw/KzXvllZSrTn4LHVzbKjx1yZyDMYNVG17jFG0ElNra0s76NoAA30uBclmRf0ZZCUyezE6jkfvbNsRiwng7TPZ1j49C7hax6KLRyLVATsHU1q2zwQwUMSCXXy3Jq7IeezqVTKBTeyaKAbZ90YDoKfY051gr4AfQpYNrOGW9W6yzpIPqvLZ8UZoFeDleiPDwHUIfhRfplzCHuL9AiX4odjZ0SNTe2S/iKdSVU7/1f3o5cFVjzz1kdJAY/hjrofR7VTyy6CPJZ5xKzZtl/1YcACy/gCE4Ubdmg3RWbeKGNNP3iB8b8MK+qdL0iFwTLV29iUgvkf5lS23JRO0y4L5AyYQe9fB+6MhhtpWXspKKcp2rMt+qrpCKBZEIny6rLzPtlue0oCwA8gFHeKGNwt5Icyqkk9L7gzCnabYDbkssXTUGCyluaXjX1yvxggZWmb/Pef1u3o1dfPoXIuByqaEfqM6Z++UeUgMLR7bWtoeuyHAi0l3tT5/PnDMJqzTNQ+Jp4dvTdiclTA7TlITYrGDgdl1xEus8Jw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(6666004)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1lzrFBHdZFqtJhBHci3ifr/40s0rgWq+giQGy/tVRyMktxMMmk17GLIsvl?=
 =?iso-8859-1?Q?E8eWMrAI21e5nJMBX7kr7xCeP53tcUuxGby6ER+xIJx9zVB5WIzX1LR/kq?=
 =?iso-8859-1?Q?1sgkJQS/aF7t6AqoxvSKGVB/v/eQ3zgocmCiTKViNLwcNUEfjJ1silxNuK?=
 =?iso-8859-1?Q?94KXoVc8n+IJw9YzCckbqyLB0yrQlie98S3ZceRYd/0B4tNL5YoR2y4Rvc?=
 =?iso-8859-1?Q?nXwpD0DCNrBM24owI0F5w+9GRBqeFDHtvFvB4sveWx7w9QR1kAYR/hiDHa?=
 =?iso-8859-1?Q?t8LKp152xiFS6+blFNBT1lMx3u21ccrH9FwMCR/ifxAM69wyq/LwwrdUtu?=
 =?iso-8859-1?Q?PXkiRvw3t8bg6v+/2fGL+H2UzZuB3dKVRnNjdvXqTsnKP+XFOtECeMuIfT?=
 =?iso-8859-1?Q?PIHM7OzerOnrUEchaZBcddYOXjYgbKZIdjm3A0wmz61v5sYPlUbduOQxUk?=
 =?iso-8859-1?Q?x55fpKvPCehnbu4c+RavgYdMdqlTFr9YaOw8q3v6UQInD6bQBhMHvKhKas?=
 =?iso-8859-1?Q?4l6Rpnh4Fl0yda87v0dESSh+K1CRUnnZ45u7+lOgxdo/ILJffpPlRyrUaj?=
 =?iso-8859-1?Q?RuXvdlN2yRURJiRCDiZ/5NAdpKPGGV4oEFBB31w+IfdeoXDH/bFj1UUSN+?=
 =?iso-8859-1?Q?fePRgeNQRqMfsPjFrRkSquhGpuV8FEQi1i/9COMB/G7y42HB0Rw240mT8R?=
 =?iso-8859-1?Q?HGZilAtVpFBbkiGLXisHPZvp6xLqc2814jF1ZKYabqV02luZIBhW1Z9Jd4?=
 =?iso-8859-1?Q?E0+52kpYmNS85Ef8bzC1yJFQ5KZjQLnH+B4Lc96aIs3ZMHUHwmsNkGZ/Na?=
 =?iso-8859-1?Q?2AUhnlWO1jVTjOEB67P3xhzcjygMJIQxfUmEgHWgi6kQZ58JRGnESgjpfs?=
 =?iso-8859-1?Q?lcg7WU65fKHDQ+hQV4EtYUm3X4IYptOx2eRlWvjopqLZ1cFGET0MX/+7lv?=
 =?iso-8859-1?Q?fHX1OeMA/3Uq8F8fSoxov7MXbsWb5fGt4g85q8lABHKHbJapW1mai8w2fU?=
 =?iso-8859-1?Q?TlvPU/9Fh3gVdvZEsx5RtZZhIX3i0GuH7/ueL1sysV58H+uaz7tmD0dg9x?=
 =?iso-8859-1?Q?nX7l+LRrs6ZPWKkav8pQ5JQY5cQT1O59kZKLVGEJ+eB7nGTmcxwaGQO3yn?=
 =?iso-8859-1?Q?tizXrs7XT0rko9kC1MAmBg5GqFpG/z8bSxmscOUva+UTCVLSwTyezQUiwl?=
 =?iso-8859-1?Q?7UPPaIxVZlTTBi4xQUHWTwbzE4+pIRTBAvbia4PkwFDx0uic4396ucRWvb?=
 =?iso-8859-1?Q?kBjyFkFilN//Ow+zChJhM3yfQo86pxSkbdciUN/pLeQ5Mf0YWMWvtqieQJ?=
 =?iso-8859-1?Q?1SI7vW9+7SqgJf7QP3blEqnkIDcx14XhaCB2yNc+n8C+IfmkRwQyuZKgv2?=
 =?iso-8859-1?Q?pnNf3qlV/pNZviEq9FY6PpDruq185/wkduZDann/nFQhsMG6Q16Dan3p7l?=
 =?iso-8859-1?Q?4LSYN7JkXuwEwLFiAFMECQxNzzYPoM/NN+Y44DHA+DOxaPS7NbDTW2dBge?=
 =?iso-8859-1?Q?ld5cWPoF+716wED3MDBGxT5stGHZ3g8mnl8kNEj5Z8k7XTqGs5sVEZ2yor?=
 =?iso-8859-1?Q?GG7hrJ8vuFTWKpdu5kiKZZO2eN0Q7ckjeyUiCeqyeMTXGarOtQl08ACeOT?=
 =?iso-8859-1?Q?2ZOglj/6byKFexs/OCTGjyyUsruVPvTdtWojK/rNA0po4saYPi1RBeLQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3b4bca-4245-4760-0395-08da69f60d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:49.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oi1HpsQGmy3vpFtAib4iawXEpLBLcZJYuPHMJyUTs5UAJCgu3x18T8tnFzpVXGszCEAEYUUvP4yZ0nK4KcBTbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=935 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: 42qYb-aen_zRfJwRUmMVBxy0yN_WRNDc
X-Proofpoint-ORIG-GUID: 42qYb-aen_zRfJwRUmMVBxy0yN_WRNDc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Link: https://lkml.kernel.org/r/20220504011345.662299-3-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-19-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 71713c661db0..02d2fd90af80 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -614,11 +614,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
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
@@ -648,6 +648,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -775,15 +776,27 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
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
@@ -830,7 +843,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, &mas, insert);
+		__insert_vm_struct(mm, &mas, insert, ll_prev);
 	}
=20
 	if (anon_vma) {
@@ -917,6 +930,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
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
