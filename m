Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567B5577368
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiGQCvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiGQCta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB6222B7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8or0009632;
        Sun, 17 Jul 2022 02:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wdrE/nUwbQ3B/eUPWBXX8jHi9gWVAa/HGKSZN/xnxPE=;
 b=RimFTbYlgpprCUzIm6ovOgvCx2xelEF/W3VVZ9ZK2iumhcyy7sBKWprkPcgWOR5BQnP2
 qXC4vAakuk04Vyyg+HLdPdz9gfdMZLJSAQajVMiOuFMBMKO1lQJ+/6wxufljKK5jN4Ij
 AGCAKbePE/NEdjgFoWByKpXKnszdq+FS7NgMQS1HSQdwWwoo4kkY2gwUzWj2CeUXS/sC
 DcXD83dP6pnqrIdzu/4NLUU8F61CPFf2U0TXbcrxnByjKNG7YNmJjsvS+YUwBX17qZtk
 TwU4DiWJ2o9lwRKCou+Ejg4FL4Qjdtkxltkszk7dkTJdY0JYtic0SENk3Uqh2pUgYLkc 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0ynj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYI00036125;
        Sun, 17 Jul 2022 02:47:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqp5K4gBZeNwCnOUET1wNLGtEr6+3uiWlc9cm43pXRPUtpBScgfAawju0+uUKoXx0UQKBRzxPX7mKi4BEMGD73lw6H7K6/WM7sZ/SpbTDBhTtdJOFo1iBPXMVx6e8OhiCnEu92olhZhvgebevW2tmFY1eJsPruM7cBK+HrQkXo+4AbplG8SJclB+gclqaKAmbLovSNz7YOlmiOLFpF5bPmMInqDQqlNYflMRoSv1p8Ha4sdS69FWDzpV2P9xuq+DO1QFMzlnMcMhtcX3f+wmfA0lj4tlM68/rm1ogRvMXm7mHa5XdeB+/Mo3Hn9vL60eRTHII59zj3P4T6cyRXKQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdrE/nUwbQ3B/eUPWBXX8jHi9gWVAa/HGKSZN/xnxPE=;
 b=M3NuMj9iX7B7OUO/scVd9QmEOKzLX3+elm/mgNbA1oHS7zfw5hEVPQPMdjqGsdD1K7xdUQqfP//sectqFNDRRzU6ox4fMllpUksroOv8eeW3977G76UWAN6aNhx/UozhGvxURcRq+RTlLDkMF1gpECaCpB4Yg5rr2QD8+k4U6ur5PtO3SDHLMg3Ritx+IUa1FlT9vsoSbLHrYy5vOnseOXEMONDmAjn9LHmke6l7iBYd8lUYUaUhTJqVwVsXCuAoCyJ8al8TkPnjf9TBh0QShX+3HDeRGds0rEExSrQiSITrALGiWHsEecFCQWAgQiCe7VXTQWLjZ/0U382B8NMPRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdrE/nUwbQ3B/eUPWBXX8jHi9gWVAa/HGKSZN/xnxPE=;
 b=GFVcqXL/jI/eNTrFR3FezsmtzemUqZ+MvvcH0u03unveWLNQhA0NBiBY4172PKEUmAusWO40DhyA8MvPJv/p01cU6cxDoAfTOWHDVm9Szf/wkbGkPLo+JFFkELZlymBJw+/4H/iD6MiaIwB+313cyuoPMcbMm82pr1gGgZSalm8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 58/69] mm/mprotect: use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v11 58/69] mm/mprotect: use maple tree navigation instead
 of vma linked list
Thread-Index: AQHYmYd6Zh4lJdNBfkGCPs0zCpVKdw==
Date:   Sun, 17 Jul 2022 02:46:56 +0000
Message-ID: <20220717024615.2106835-59-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caeb191f-4ee3-4cc3-cb8b-08da679eb30f
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkDTWaKvY3Co3h61HFyw8gvExfSZm1pG4iKTYwAp8rmUPtAd7+26pRmOYhmCb1lfb1JPBULOpiAdi1rV/BROTELjx+rphLcmC1ISmf1qjk/e3/SEo2xsyo1IZooJYqKceE/i2rIOBdIXfDUEiQeE8Z3fbhqAYovzLKQGJMB12BTIIA1RSLGDUylfqk2FCOzWmVb0IUhsRPuvzuaXKrsmeaJtIUWctTQ+xXqAOpAvVlFiFgTa+4jUYIpcpOggeB3gOfTj0prAqXOSHrPGuUxG547p7/kyxS69JWwnKUs6vZhW/jQhOYIij6RVozaMUahXb+etIV5to+dkURfHLJO6Vn92bS670RgceJSNl2Qaib/otRmc6O3YgoHeI5dryIy1F5cWS3rS9weN00uL+lntpVeGpIIA7ntaTRXJ0Ug3G0P9TIeMZ4GpgTRRr/H3rbgeIxDYChnx90yQMLtxV4eep7z1/wVpI4fqtiKtrIX7kN4sZfq1iWqOIP4qESg0Pzg4pi6/PUL6UlONy62ssfw4XPtU4RwJvo+NjpBzFR+NWhfVPYTGRsu4O4mv9WWIDSY7RvEkn1V1m0ac6y/k8pV3/eeZHZMDPYRIOcu8LcrajrSEl4mM0g1cBxb/pFNfZam9altvPMWu5b2VPhDUkQPWIilzqFTKFaazbgoxYLrmbvPtfwJ8xAbTRRUsxOcf96/VHvupKaj3mBAxwIIU14rgDkIUdnbh67I6vp4vhD8PSgbE2E/IyJo+pFPahGRm/7u/7AwOwA8SqlschQ45Sv+Bk44H/AuvUd6IDBaxXahH09Fmu8NXrREkJewgwOWIMj3h1rqgyz+rIiE6sWgN+ngLXQKP81RMigdI6leD/TbWc/KiEHmiNVx9WGQ0h2D6SE8y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z3t8QkFdZldzl4exMRZKBVgmTjYgLcx//JNZNu81l2dU+spWlVh3MzvZTI?=
 =?iso-8859-1?Q?7s2qSEf3ClsqzGxAcle4VXhImnriOs/ChMGKQSowEQPfc5bXdIAQT5JpyD?=
 =?iso-8859-1?Q?2TQeBzGbotiPfO8w3i+/R28NAYYrXawpUPfMXYHd1HMOLm8mNbEV0sqWyH?=
 =?iso-8859-1?Q?SzXvTbYWvTnnXXxBSKl8ZKyyMwMNo+Jf2q1fyZ/ON820ElW50ah/Cs9o6/?=
 =?iso-8859-1?Q?dcjh4VGvU/0U6CLgCxAe78JGkDY6UiAmUQOx1IhI3yrfK2FDCuXDQ5diW4?=
 =?iso-8859-1?Q?SpfePhHLbA7yVwQYALOO2hkXam2tfbtOWVyQeyQNWOWaWJKNSm9dRlCoym?=
 =?iso-8859-1?Q?ZtO/Eo3VfWu0HqCd9w39mgsS3Jf1nJC2wsrzaqDg5FZSjrRAyTxY5WsIbg?=
 =?iso-8859-1?Q?KyS/gX9sQ77Zm3ywX2MmTdAt1ithXzAzrA4ue4Q6euhcLDtaUvgdZ9wcDx?=
 =?iso-8859-1?Q?h6CZXWlRJfkWBi1vIRSEHdcksjqEXC1gKEg9yUianNk2oH8j2N2w05At3M?=
 =?iso-8859-1?Q?5Zny5w5Q4Wo+Q7tuVHVJEuMpQ3nVyD8U9NIghs27wz+hucsJl9vjg1cVIs?=
 =?iso-8859-1?Q?8EowdETsu4jAdoGLRjwXOXxMUArcAoCaDZwMDHPLvgv0L7PJRcB+Fc8MGS?=
 =?iso-8859-1?Q?Ln0mHwREiLElphUi3rDvYeglVfTswR8j/UOgJRYEffqdZaK7xyduLdJiVY?=
 =?iso-8859-1?Q?I0M91tJjNXBMBbie3ELu1K7D69vFAZK07ZPmPIq5SJqx8mMFCySB6Hfajg?=
 =?iso-8859-1?Q?ysuThEtBKxVODbufu5MKZ/I+anWMsTkbMDpdRCgiXKqN61W8oihEkqhUxy?=
 =?iso-8859-1?Q?MQPnGBf71SXz4atSFdOjnNUbRoiZ7qW42GFvfwoK0DjJK64RiuBiCY+vYq?=
 =?iso-8859-1?Q?AA+cQpRRhPJ624PRUSyZgzhwXkrHfR8XJ5aoVNQpP50sZLeMg15C01CgGG?=
 =?iso-8859-1?Q?Se2Z6Gz+u3fNivXQ8xv7HvX9gGJWlQaZpCklMWWv76oZFbnyQ6LuzSWeoZ?=
 =?iso-8859-1?Q?3Oabaqn+N12QH/l+qIMWFDxcPV4vwi2cHuJI/g9aPW+IKF4/CNCj0PfCk/?=
 =?iso-8859-1?Q?NCvMshlU6wBetiePSgpHTg4pss1e4JPJfjnMTjuCILXj0EG1zcil+gcGjH?=
 =?iso-8859-1?Q?v+bMQMjkSTCAjZiSjOgAkZx2hCXhc4Yql+YuBkGfouPDgE10afMDFnUzzv?=
 =?iso-8859-1?Q?IYLyNWZxMeOadSwsZaGYIWO0WVDg4xhR44LIvmb+TtbcGD2wPjTXJYpX1v?=
 =?iso-8859-1?Q?SfAgrAXSDdoz9aNLh6UfW9vPNUW0ZW7pW9wWjhhJ/ciJmhjI3sFxon7Jm4?=
 =?iso-8859-1?Q?qxqanfL1Mxk9xvT9DRMMpnBVUP255Y0NgWv1IS0H//r6ZV7+4n+l9hxhQy?=
 =?iso-8859-1?Q?n/n6wFSbTti1f6LSa1gCxCtqj8Ql5GqLO9+WHNTwSYXBlo5FeeEWIDR8vE?=
 =?iso-8859-1?Q?jCFlH9HgM9VTx4vEK8GyzMKrdEMDYabVsSoheXZqEDd1HJGxrEBFw6azDM?=
 =?iso-8859-1?Q?N7w2OdyDYDktu8eCqFR0gEvqyGgNGYLTAgEmNCGmL11VY87JsH6jw6nWcK?=
 =?iso-8859-1?Q?5MFfLNrdLpVNm0N2cpRK7W25ioj4Zq9+37zyTPL4iT7EI9yrgfSMuY1czY?=
 =?iso-8859-1?Q?httDNI4HU/ZPTDTYoJMOSK/LWng5l+c2stU2Zmke5u7VSZdSyn22n+Mw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caeb191f-4ee3-4cc3-cb8b-08da679eb30f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:56.0678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwH7boXDDLMMRON4sVAX1csntaHojZdPSio6/cna1nm6XBkSc4KPuEJ4+G4hKoAaR264CxbRdXviIOU/JCpgkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: qDTlLvvxTPd8-R4HB6u9fqRJEzKQD1ik
X-Proofpoint-ORIG-GUID: qDTlLvvxTPd8-R4HB6u9fqRJEzKQD1ik
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

Link: https://lkml.kernel.org/r/20220504011345.662299-43-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-59-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..27fb652151e4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -621,6 +621,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -652,7 +653,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -678,7 +679,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	tlb_gather_mmu(&tlb, current->mm);
 	for (nstart =3D start ; ; ) {
@@ -741,7 +742,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(current->mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
--=20
2.35.1
