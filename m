Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FD55101A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352035AbiDZPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351983AbiDZPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F3415570F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDStXl032115;
        Tue, 26 Apr 2022 15:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ze0gkn/JO/xr8II+hcUvTkidGnBB5r8uXy3ryvON8XU=;
 b=UK1xcokT9T/ACM36gwJar08QNFe6gpCxCP577NN/mBpQ3CLTMMFLlgitnVduPmRfTbEZ
 2SQdtVE+NCvs4vaqxEnRwL4Iq1RE7H7p+kQbJtBtpa9RwAn/2pllqYmNr7MpO/9O5LEP
 NZIy+mdrhvaBF24GkRM1ttreRfu+i3D89+Y16eE1urq2WRJW1Ovavqv/gQjGTtDI+VoP
 iMCq0OFW20+jnd/PEbJpYuYC4oLkqtJtmR1EU02btfBP6EkOi84oWYcQvya3VmtKcodT
 Fkw12ncrT3PkkekspArwKInBewvQIBz7O1e0VFrYYlcJJNaorQZM5DGZJdbRW5vKWHj0 Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx4ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Urr037859;
        Tue, 26 Apr 2022 15:06:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvOMh5Rwft0ts27vSSQiCgc6pDKfEhOVKTn9fQgqO9DkFeb6WqvYzne0XLpdj+3G4/eik1ZTFViwjEjzmd3dEdeVUpivEZYe5/scJkcDutIRz+D/xT/+Vlrn36JpSfJ6o1ZfQUwGRNi/cZf/RlK1d0ZPMbJuWQp8uustr0CGETyJnUwptPemXyhUjq3yGItb3lmaqdLAQ5IybUjYiSgEv1N2ebVv26zducHvwNbuby2eoOL+IOX9JeCiuFOEYK2wjy+mB1lUm/FEPEnW+nUGIZzSR0+tIzlvVSVrM8p2fBNDkwmE1B6mEqxumSbi2cs50PO5NuzU8DiJR/prBaj7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze0gkn/JO/xr8II+hcUvTkidGnBB5r8uXy3ryvON8XU=;
 b=IrrjGwiuOYB0KAFBtAGDfXV1RLKf45mcaE2U3uWWSz0t/iARS5ZMXOZmmL8nXeKt7mW6BMbtpkCpjZFWY5Q/0V5+tKRrzirD7neXxRcAkzeza6aXmV7GUfhI+0r3IwCn+Cdnzxbafc8Q4GbecyqzGeExN48L54qukGefil0D3np4jgi4Nue6LmWYSM4KCSY1daUVDASsLTtmY7/aOuX893bVBZxlRVG1gPLn76mcYAADm/csL3nk1YQSuuE7QS3kEfvuka25qafQcJygXD3jhgJ3LpuPH45aigqX9MywXxsd4HPSh1uAdSGAVkg/Va/nxJLVW9puR0Zrtfm4huHQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze0gkn/JO/xr8II+hcUvTkidGnBB5r8uXy3ryvON8XU=;
 b=UmYFA+qXWpclej/hOec+sSC2e2D/RLq2dJatxF8UBnOwxqYdw9hihXexPInQ8g3gfFkFfySzmx1bbQmR9lP9HV2lQ1fNXf8H8xff7O9xICOl+ICGjXZ8tGIUvuOqiRFv7czC0jD/6zX85Ce4m8njdia0PZqRonDiunRerFuv80s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 14/70] mm/mmap: use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v8 14/70] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYWX82BdSPqLJis0W/Nr2RIaQbMA==
Date:   Tue, 26 Apr 2022 15:06:31 +0000
Message-ID: <20220426150616.3937571-15-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4748a823-0907-4e69-3e95-08da27965989
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4679892AAAAD9307F5CC61CEFDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26J6IKylJgPEOdHEAt5mNRZDFRr8iq7bA84+OVzwc8gsIwMSYwhdSm6MXfokdq1zS7tzcyefp+23fEbypBbeCuHOgyRfQG4JDI0HYLwT2Lo+NS36sXiq7UTdXiDWLpNI70L3fQsuFf5R/IP7kobUu66u3OvYVj11AAjXDv4u8T7unEt7UkqfwpA1fD3Ov9htnCkw+IgRGiBXFlj/5Wfs9mcdpCIFCouI1IwkQoEKuNaz/xrTniyqQ8hJLfnGJXSfPgK86T3GujJ5mhHGp8D1KeYnhTcVOqMMop2wXvTHzr+xVc4dv/srNLlzOBYOi27PcadzstcqMHdpEGbvnzxL1KA7yI286XcXr/p1i9a1optZbK/stT0VnscNHZ8cogTRU5H3njdWbjMY4LWZvN6dhAFltYTVkx06GPCXCubkgj7dgfuP0Zc9XkgqM/cFqZE4th0dtLQgb667mSUkmcSmclLe5SQLhdn8nvb2ZaodGR9BtRe7j/GqCXt4OWYqzA1oZ8OWUi9mR5wxSVSpo24ftrvwe+wkDo3D29s9Ii52EBt/NTVhxdZhvGqw10SRoHgp7LBdPDZXvbW5Goff15xqubbZ4sIVh86Jxv4ftaURhmz2trzLx1FUxwsUxiVqAOWia/KVB5khnZwvs9xBeXKiCgbK7tVfWNFY/k4CLe8PKaNBxHWJSTQNPSH2e1uAeeN+Uf/ZV0tt1OWWqF0zxNO4WQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LyIR5UoDxowlPZiMP5/f4NepUYlJKGa+k/29dzx9yvcWTQUd+5BTHJVVry?=
 =?iso-8859-1?Q?b+C5OZpEe+eeJxsI4j+n++HN3D+bsKy4Pa5YxpD00swpjllNl11JGUH1Po?=
 =?iso-8859-1?Q?Qs+Z6NwORGJvkb6JHMk2Rg8CP7bHj+382aBK6M26uCNk3+tXGdVtcEv9/G?=
 =?iso-8859-1?Q?aqfmidQamVp7w69XF/2ELVMtGhJwjgtqRmDTzFsHTbNSYTfsCXc5ri264v?=
 =?iso-8859-1?Q?tUozjV6mE/xvol9SCIkDqrbB3gDRmdrbFjl/0I2UREA6LpN8rSk17uKhfv?=
 =?iso-8859-1?Q?iZJR2nYnTXQK90X1lKc2NvVYoJOXkFNZioOKXJ1xnKINBKqyVe0GSTjJdf?=
 =?iso-8859-1?Q?ufhRJ54b4NiUBKOfMSW52VPIAL7EG6rq2/Mp21mNmvjRySOuLm+z3r4oAq?=
 =?iso-8859-1?Q?6dXDT1SF72JFzTT1AmsvahxQ+0PrtLqk3B/4peFNoYYfp0AWkXW2LozV1B?=
 =?iso-8859-1?Q?V8W7q/BP8uSueIB9oBjjGujbgqhsfeADVpz4e+vMgbf34st2EuPWYiG03F?=
 =?iso-8859-1?Q?twoPAXI+vsP/GTwjNTzPitiEQ3PSK4Oz5Mm4IopkuTVXw4uI/Z0h4OiIgC?=
 =?iso-8859-1?Q?PemNseb4zYP6uyzzofxXYSMWV4OYublBTqFgs2eu63UL0RrC1p13ZCZLsF?=
 =?iso-8859-1?Q?772imHEbjWg19c4yMlDLHBOPf6MSSFML/wkTVScHh4rOUyQXnIsJv6dMNC?=
 =?iso-8859-1?Q?Hl2ISdSVWXScIksAWgZkviQO0xF/GVj7XQ+tj6JxPcwG1AeUOgK1rlke0t?=
 =?iso-8859-1?Q?fe/F1Y85n5gy5XI7s4AYv5r7BbRtsNwBYyCJ78MJ52Nl3JVoVqPkKvnTwz?=
 =?iso-8859-1?Q?hJzBGFeCS5gdeQaMmyhfZum+0JFdl4O9JDZtGRrdJWn5WPVlRCMX02g4nU?=
 =?iso-8859-1?Q?xmC2NJHqhxeN7gWw+Z95DrRYMBz9NP/AmZpoFKWv4U78D7hdXZZAP/UeeO?=
 =?iso-8859-1?Q?Je0eh/JPKxReLzp8Sxg4+zHWCRLiWgQk9N+qz/XJSai43pD8CJ9VFhcUHh?=
 =?iso-8859-1?Q?mwGZ2QslDUK8Kv1+kDaAfabsbazzPu0i5OOGi8fCzcEjLLfQeAjS/I+a0T?=
 =?iso-8859-1?Q?g/wgEU0r3l7AtmrGp7yHFAR+27U5h3Fli9s9RcbZT2ASstdyibXDltMk7A?=
 =?iso-8859-1?Q?/GKN9EgjktOMcgETnQejehf+ro168vD6iaWf8GYenevXnGDMbbfoEmnQmx?=
 =?iso-8859-1?Q?pwrmAP5lNr2ValKBhnwvKYBiw0TPTDjhW5nxXSDy+NoMOTXSBUTvQgGusA?=
 =?iso-8859-1?Q?FH802IBEF2bkMB7GXj7t0ofPMS6EZvI1YGZxhjxrilbJtAVeAMTpRuYnKL?=
 =?iso-8859-1?Q?1f/tG1vl4c6e3jnI1SJUcwRUGdtKgGFV9PN2j0XxsAVBtkDRCABV3a60FK?=
 =?iso-8859-1?Q?js0kPg89hYJXauSsHD+qOVy4lmq5Y4kHOBVC1mgLem5OxAIrtIYjl0GTj/?=
 =?iso-8859-1?Q?u7R36E0Vj6ula+Jn2pSQPKTywFZQer2WDRbJAaaAw3SFPlbb5UrrAROpqa?=
 =?iso-8859-1?Q?yABKV6c9y21Tf9rr3FFeE2Gcvd7ilFSdZdLnSnCHf+Tn28R24njHo2JlLl?=
 =?iso-8859-1?Q?O5acuKiGpZclv0v4/HEqnFxM6E4QRflcA4pt3bR3xkgebR68cmuQ66BW+I?=
 =?iso-8859-1?Q?Ktbb8LNuFYDwdaMM/m6ckpbREoWWpo07g5mLldpS5+Xbevqr2LvvXNLAe2?=
 =?iso-8859-1?Q?IQdXcA4eoEsW+qpR6l028VGusQVLKZh3IqEFypjoOqq2c4T6/lVOYrBqRe?=
 =?iso-8859-1?Q?Ww0RSefF0ESPjYkgLKx3s6RFWqulfQUpp7gAXCvhMgJ+/Mt6HxgNy59ZOO?=
 =?iso-8859-1?Q?WLZMFso7QxZXafey65W3xADZHd38qTk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4748a823-0907-4e69-3e95-08da27965989
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:31.5841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEntmub6oADIdHLswfoBD/JXMnal7EywhCUT84wG2wl62jaBZDX7/+1uQ3LT12VldHuxfOIZZPPK7S67ggfVuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: b0i7uP1W3__7Cf5E6T4C3btQBSnskpTa
X-Proofpoint-GUID: b0i7uP1W3__7Cf5E6T4C3btQBSnskpTa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code.

Add kernel documentation comment for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 253 +++++++-----------------------------------------------
 1 file changed, 32 insertions(+), 221 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dfb2b2ddee24..c496814f440c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2031,250 +2031,61 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-			   length);
-	gap =3D mas.index;
-	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
 		return -ENOMEM;
=20
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+	return gap;
 }
=20
+/* unmapped_area_topdown() Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from * @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	gap =3D mas.last + 1 - info->length;
-	gap -=3D (gap - info->align_offset) & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length))
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
=20
-			while (dv) {
-				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.35.1
