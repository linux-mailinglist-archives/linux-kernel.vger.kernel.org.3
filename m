Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7000257734B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiGQCtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiGQCr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5CF1C123
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8dk6004121;
        Sun, 17 Jul 2022 02:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jKKC1l1afGoEblTBUmPW0FIKqOql5Q+Bhh7Xpn1mvtw=;
 b=AhssciyUU4eW04BCNyLU9Em4/e5RqsQyJXLxw/WlUMzBJ6/FIYf+6MfBw8Y9JSdbN+qV
 5dySLy1utwWITqVSb28bSjeiljNDnjr/+coe0qvDexlUvKn2A7QZpPn3wCl7ybJWLKIE
 2MFQiwPuArojv+uwd/ymwuyZ5nrnNpfsVTMftz68jYcduPSGOBeQ5Jc7ite7zApIIuRS
 /71d7oSxIP2rXn3rMRED/jv/QFhjcQBZ1HvNCIXS3H50wPK8KFr/ly0+eOaeojPZ7Pgj
 ewIpDw6ceFlB+b2EsYLqCUOPAWvuTzn08Xay+Fw4UXxrFokgXpcJ9x2XFD3PN3fYD19n pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImX036151;
        Sun, 17 Jul 2022 02:46:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwneRObloKdzb3lDlS832eCDOt/j2SMepo8B4oPjsM9zXAgUt5b8TLbFUXA2LsGd8YI0KnA71MRrdtznAjiJy5WcrfoqAE4QSGg8o1e3+5CKMZ8ickSDhMNkjUGrL6nmDA2LQcku6edkbC++MwPsyi0jqfS0pTX9TnegAcHwS6QwdgO5OPMm3Zuied2je2QbVOSbCFnhIGirsdIprazpyWBoILVmK6FF8jDmByuDOfqnvfoN6J85F1jIgXBtb2vFYNVRMUXMcc5Uaawv5XtB3Tavwwo/PhRshzPcqaJ/pDhlCD9hnyR4yg1Txq3ncqToobL1FNUQmS3Hfv3vJJkCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKKC1l1afGoEblTBUmPW0FIKqOql5Q+Bhh7Xpn1mvtw=;
 b=Hf8hS91+24Xy4k5GTj2RpGRY2uiw/CwT22qmpA8QN0ACl7f23kjxzOM742xHTmsPpw9+Dmtyxehc47bQOcxHBwFYWt2/BO/fNcY/DX9r3Xw2rZGErgC35WW7DbZQo1qvOIBvkSGh0JE8v24TIQhLdEuFKnnPvt2cGMbgs6e2Mmd91VzaQm/OWLm46zTnefVgu9s4+oLP0kctwnWgCOlRa95K1DEg9e9XyPbU2v0mJxQvSFmQZednNRqrP8Pbgl2e+vd0bALM262yFTJ49ZCD7nFPPT/LrLtxb6MKtervgLAUu853F3KjAZ/k8PSCRuvcpjhKe9e1U3uOOdCZJpOtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKKC1l1afGoEblTBUmPW0FIKqOql5Q+Bhh7Xpn1mvtw=;
 b=NR+woYpvhMZ6zIacf5aRcFDKGH4H/Wua7e50F7b2myH0I5uoKhBCx1dKXHGdT3/mUJPiTAGQpZa8N5tAU2Az74ISG8ZRI6xvcra/PcgN+ONsPDbqPvpeumlxJFolkFggLXO3EiED1u1JbgWrNXPiKe+akPoqrvuUMTvNdB81TzM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 15/69] damon: convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v11 15/69] damon: convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYmYdx12HdlS9KqUSn3eJRgHnHNg==
Date:   Sun, 17 Jul 2022 02:46:41 +0000
Message-ID: <20220717024615.2106835-16-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 313db298-8d3f-4d39-cdbb-08da679e95ca
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBlt5KkgGTg8U89jJcNl9ya5ukgwVNzrWMZsxV0fjQTUE6BZSsA3UYNv/HBxj3uP+y6t4/5l3//7CZosPTUZ7EnceZ1LUQdPHiLzCyVxW4M7e3y9ivHqyxorwvufjzYR5iigLvxWramQ6NW6vgjaGkDEKwurisjBwkfYI7G16phR3+QPEoDU9wioCC4CwA2mwS1YJUZlxD4wdaOdGZnq9r+CdFUrfWrREKRxjhqk44T0sLr3R5sVp4aPe6Q0bFG1+u4HXEqJE5SCngIcpUiMob+qKXDIN9tnVEMws9bYV9RLPzLOVFRJRFrfOzwiZUUNH7oX220hrFMlEeQCFAPzlER+baRxcRCxTCHZZ5a5opl4ohuXYYOJ2iusYgjlL8OuTkc7foA+nIw+QRH32qITWgqnsIdW4PeDYK9HkN2wURzR9U+ufsOSJhQZkxvSPAqNha9c0Sp+lRCkt4FAUersrh7oA4HnuFP2vjUpmPNd3R8+GHTj1WzyMfZsHX6vd6rZe+urm9NVqSDMALOhgpsEUWg3BLizqvS8xPdi4oUNY2uMNFfywkLIkFu9h9QhwpKDZcc1Qm/d1nFBt3G+73lS3VSczCca9uc+9NeNmDECjLluUNFycyhBemMszfmJRCq0doaeElNPPKQg8xCCKPLoYejxeB7bE6vZ0BVfc5ak/J3tvyA5v0/i311pNmsW/CAwbXrihdh3FIcMFtfRcmmqg8mFonJD92i1cWN3dZIOp2692Pf+31dsRePpdSVBkadvn9GRdX6PSudc7Wb4STAF0XJ2YoMnl1BaDNdrguI6Q95mC4TGuHJEe8/tAs5oQuZi7ILbJ/bkGDPAvnehYvFaTRaFFjwP+w2Q2+oAGoKOJvybctR54pvF4m6gjh9mQ012
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DIcqjUbb9DieJkPWdHMtY63WnJwxFsBxTrgmvxoC/A8x832wcQS6dgRBv5?=
 =?iso-8859-1?Q?801qJyGAWhXzgtRNy2FoRLDu8iX4pLJANlczxoB+mSCukvaj8srw0LF3jv?=
 =?iso-8859-1?Q?ChRajyXRVvDu6nc2Ab/rwa0+UMndesix4LzjSqiVmXWhYj5RvarqQPs62E?=
 =?iso-8859-1?Q?fyEIBZPIX/nhntmJiIPMvUPYuUuhnyzt14voNK356Oya459Goi9U2Il8O3?=
 =?iso-8859-1?Q?AJRa/2/56DSLFEU2O0duaF9j2TU68shmvFSBEZRnaruAaGfoKNYZV+9VYF?=
 =?iso-8859-1?Q?MU5c+g+n3UI/JefCO7nE7XVxMbRC/pvFCMpdFrRu2AGXr7EYmJkZOF4D3U?=
 =?iso-8859-1?Q?Y1Vg3bBl+OzcmZV2uuPu1JReLUWQeffdKWg1KShC3jr7ygXRdZssjLSueu?=
 =?iso-8859-1?Q?gmsk7TquRXG/UgCxzQhhS7BbwahefPqR+2f42+d52GHB3BYOwKm4aKlyUl?=
 =?iso-8859-1?Q?ppnWFyF9BlYszT5/Z1rBoHUuvqfwuOUNzGCiE+/kw7D8toIdaReLv10SjT?=
 =?iso-8859-1?Q?Cww/J4Ashsyd8iwuysoZZ/LRGLZlGES/Qfy5l129065LtCrEgLX0U8nqBs?=
 =?iso-8859-1?Q?pA9rPp/SUh3zhUfUkPO/q7W501A6uYDw4dQcFUFp3Se4Yel5sbREHElHgP?=
 =?iso-8859-1?Q?HCy/X3W8uzsR0go2dXkwXAuIUubm3O1UF0Rt9WBvuWZPF0tEdYl3lXtG8J?=
 =?iso-8859-1?Q?A4mKYOYPphfSXcx0RhwZSUpaH7RuVuJ040zGbQwie0u0h8jK1srCu7R3mD?=
 =?iso-8859-1?Q?zc6Ps/vXese3Yf6YiaRaqb4BQfrcuHDAspxSUvej2ekw8m+kAXu2lGSfKA?=
 =?iso-8859-1?Q?CfDLBBZjXxRfCwo9BBkrk8yR+8iJGsKhkd4ORc/+ZRFoUeMiRBFWzuj3hG?=
 =?iso-8859-1?Q?XAIaN1nqPAhG8Mez3SF8Uo3AvAgqYfFVxqIb9glf4E+Tb9KQjvcXCoo1Nw?=
 =?iso-8859-1?Q?8GtK4G79MJ3II98VtjShFPKMw2bp26JRmJKbe4jozLF6tFl9hsORWq/2c/?=
 =?iso-8859-1?Q?oarg/yuSgqoqT44Uvk8ohLDumolGacFfaGvFO+r+oimj0N3ZAXBYrNDdf3?=
 =?iso-8859-1?Q?KC6nz7x/T+OOgUbrOk9n2MinGovoJ2qEiJhg7jZq2Ya5WBjGGPYiUgINNg?=
 =?iso-8859-1?Q?lW/n0ntYyqdu3jtsTgL3Ld9F4iFs2aPmDbgiDrp5UtHlQQX015PUPc4M3V?=
 =?iso-8859-1?Q?JPoXyB7uf503jMSvsunytQt156wDbpxEHTy8IzKwCcj5o2swAvaRk3NXJC?=
 =?iso-8859-1?Q?ru+4+J4gH3GTo9zucKJRiSe/ZRsDfZSSJ5iSADcG7w/r5jHI91mvcO5uuw?=
 =?iso-8859-1?Q?ICCMDyNMJXf0s5pNEXOmuwvn333mGWXGnjk4SgaTQYCXre0JK6ZSEMTO1N?=
 =?iso-8859-1?Q?WYpsx1mV6T/S7JrkxyAXlaBAuzIDzL/3AQT1iuOEKNGBDOzsJjjoM7TXJd?=
 =?iso-8859-1?Q?Bucmhr/dbAHTjH7xrCwBxjlaxKOTv0RtfvH+cpoZlBGJyWidNt/2fZaGUC?=
 =?iso-8859-1?Q?+YRlpmLFDhspq76QNb2JHqRnpQDDq8uLnmZ3US42IBobYBE/eXTJ2xvNOS?=
 =?iso-8859-1?Q?nt1cLc4BLfmYZP7tFW7w9rEpW2UcoXDlI3cZADsGjaKVbfSZb48v50GJnm?=
 =?iso-8859-1?Q?kViaxAXanyCVFGTODvULJdzmZEOl/DMHUT70AXtZouo9qBAj6cwf8sJw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313db298-8d3f-4d39-cdbb-08da679e95ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:41.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUdyzVK9BvuZp+3jJ6ki5HRRScGR5ZcWC7XQ/NkjVcWR4u6YIERrq8AmlbxMrK1487OBGP2bc+gDTnRx8QoTkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=922
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: 96hSs_j9cRPyBE6xOHEsfr3pWbqtP2xa
X-Proofpoint-ORIG-GUID: 96hSs_j9cRPyBE6xOHEsfr3pWbqtP2xa
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

This rather specialised walk can use the VMA iterator.  If this proves to
be too slow, we can write a custom routine to find the two largest gaps,
but it will be somewhat complicated, so let's see if we need it first.

Update the kunit test case to use the maple tree.  This also fixes an
issue with the kunit testcase not adding the last VMA to the list.

Link: https://lkml.kernel.org/r/20220504011215.661968-1-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-16-Liam.Howlett@orac=
le.com
Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/vaddr-test.h | 36 ++++++++++-------------------
 mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
 2 files changed, 39 insertions(+), 50 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index d4f55f349100..bce37c487540 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -14,33 +14,19 @@
=20
 #include <kunit/test.h>
=20
-static void __link_vmas(struct vm_area_struct *vmas, ssize_t nr_vmas)
+static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas=
,
+			ssize_t nr_vmas)
 {
-	int i, j;
-	unsigned long largest_gap, gap;
+	int i;
+	MA_STATE(mas, mt, 0, 0);
=20
 	if (!nr_vmas)
 		return;
=20
-	for (i =3D 0; i < nr_vmas - 1; i++) {
-		vmas[i].vm_next =3D &vmas[i + 1];
-
-		vmas[i].vm_rb.rb_left =3D NULL;
-		vmas[i].vm_rb.rb_right =3D &vmas[i + 1].vm_rb;
-
-		largest_gap =3D 0;
-		for (j =3D i; j < nr_vmas; j++) {
-			if (j =3D=3D 0)
-				continue;
-			gap =3D vmas[j].vm_start - vmas[j - 1].vm_end;
-			if (gap > largest_gap)
-				largest_gap =3D gap;
-		}
-		vmas[i].rb_subtree_gap =3D largest_gap;
-	}
-	vmas[i].vm_next =3D NULL;
-	vmas[i].vm_rb.rb_right =3D NULL;
-	vmas[i].rb_subtree_gap =3D 0;
+	mas_lock(&mas);
+	for (i =3D 0; i < nr_vmas; i++)
+		vma_mas_store(&vmas[i], &mas);
+	mas_unlock(&mas);
 }
=20
 /*
@@ -72,6 +58,7 @@ static void __link_vmas(struct vm_area_struct *vmas, ssiz=
e_t nr_vmas)
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
+	static struct mm_struct mm;
 	struct damon_addr_range regions[3] =3D {0,};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] =3D {
@@ -83,9 +70,10 @@ static void damon_test_three_regions_in_vmas(struct kuni=
t *test)
 		(struct vm_area_struct) {.vm_start =3D 307, .vm_end =3D 330},
 	};
=20
-	__link_vmas(vmas, 6);
+	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
+	__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
=20
-	__damon_va_three_regions(&vmas[0], regions);
+	__damon_va_three_regions(&mm, regions);
=20
 	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
 	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6dca95..d24148a8149f 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -113,37 +113,38 @@ static unsigned long sz_range(struct damon_addr_range=
 *r)
  *
  * Returns 0 if success, or negative error code otherwise.
  */
-static int __damon_va_three_regions(struct vm_area_struct *vma,
+static int __damon_va_three_regions(struct mm_struct *mm,
 				       struct damon_addr_range regions[3])
 {
-	struct damon_addr_range gap =3D {0}, first_gap =3D {0}, second_gap =3D {0=
};
-	struct vm_area_struct *last_vma =3D NULL;
-	unsigned long start =3D 0;
-	struct rb_root rbroot;
-
-	/* Find two biggest gaps so that first_gap > second_gap > others */
-	for (; vma; vma =3D vma->vm_next) {
-		if (!last_vma) {
-			start =3D vma->vm_start;
-			goto next;
-		}
+	struct damon_addr_range first_gap =3D {0}, second_gap =3D {0};
+	VMA_ITERATOR(vmi, mm, 0);
+	struct vm_area_struct *vma, *prev =3D NULL;
+	unsigned long start;
=20
-		if (vma->rb_subtree_gap <=3D sz_range(&second_gap)) {
-			rbroot.rb_node =3D &vma->vm_rb;
-			vma =3D rb_entry(rb_last(&rbroot),
-					struct vm_area_struct, vm_rb);
+	/*
+	 * Find the two biggest gaps so that first_gap > second_gap > others.
+	 * If this is too slow, it can be optimised to examine the maple
+	 * tree gaps.
+	 */
+	for_each_vma(vmi, vma) {
+		unsigned long gap;
+
+		if (!prev) {
+			start =3D vma->vm_start;
 			goto next;
 		}
-
-		gap.start =3D last_vma->vm_end;
-		gap.end =3D vma->vm_start;
-		if (sz_range(&gap) > sz_range(&second_gap)) {
-			swap(gap, second_gap);
-			if (sz_range(&second_gap) > sz_range(&first_gap))
-				swap(second_gap, first_gap);
+		gap =3D vma->vm_start - prev->vm_end;
+
+		if (gap > sz_range(&first_gap)) {
+			second_gap =3D first_gap;
+			first_gap.start =3D prev->vm_end;
+			first_gap.end =3D vma->vm_start;
+		} else if (gap > sz_range(&second_gap)) {
+			second_gap.start =3D prev->vm_end;
+			second_gap.end =3D vma->vm_start;
 		}
 next:
-		last_vma =3D vma;
+		prev =3D vma;
 	}
=20
 	if (!sz_range(&second_gap) || !sz_range(&first_gap))
@@ -159,7 +160,7 @@ static int __damon_va_three_regions(struct vm_area_stru=
ct *vma,
 	regions[1].start =3D ALIGN(first_gap.end, DAMON_MIN_REGION);
 	regions[1].end =3D ALIGN(second_gap.start, DAMON_MIN_REGION);
 	regions[2].start =3D ALIGN(second_gap.end, DAMON_MIN_REGION);
-	regions[2].end =3D ALIGN(last_vma->vm_end, DAMON_MIN_REGION);
+	regions[2].end =3D ALIGN(prev->vm_end, DAMON_MIN_REGION);
=20
 	return 0;
 }
@@ -180,7 +181,7 @@ static int damon_va_three_regions(struct damon_target *=
t,
 		return -EINVAL;
=20
 	mmap_read_lock(mm);
-	rc =3D __damon_va_three_regions(mm->mmap, regions);
+	rc =3D __damon_va_three_regions(mm, regions);
 	mmap_read_unlock(mm);
=20
 	mmput(mm);
--=20
2.35.1
