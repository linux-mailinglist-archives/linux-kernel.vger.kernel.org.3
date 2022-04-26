Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE694510174
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348856AbiDZPMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351902AbiDZPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA24158F55
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT4aZ025790;
        Tue, 26 Apr 2022 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YvYKZFkmEp7R/Sbh3AKR0og+DeSGBXFT+ifrCOl2hIo=;
 b=imuUxp3LQBnxZaZEzK72xRCRjcroP13kG0P4WIFMfpqcVWwPqWIiqNM3xGp03toMoISx
 e8e1Uc70uOl+ipfpuGVHjcpSNDsdsIeJXjjgTV42GX06NqnEuUa2/sPjpoSqQLp8lBaE
 TtlWORmO1pNZF/8IblrvaeTRpYc2QfOUTMt9DFoCRHHVY/d3jO0864b1vFBYKkBnP5Af
 ixfVZbMPHIoPEb65BXnPNE3lOxqbAgL9FXMfvk+Fl/ObeU5DOTuhzAuLHB8T9ZfQ8Vpo
 xYK32Nugz4cwg4JhV/u8vB2v8B+fHtZ2lc2fi4/unKrASt2UC+llNEN0aEdP/661MwVA XQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mpdc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6UNs037819;
        Tue, 26 Apr 2022 15:06:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av5ILd/mUrvAFHM6k0DjJM6v+g9Sv87CzcxpmzPuE2NdiLNJFiIajWwlmyy0v/nH4pYWKXk6XhoEJdgbBSsdyIc3wI013ZD6eKau9lBxctU99MaARmyFVVdl8H8WxQgxcNP06I77gPlovltw/CJ6g72FQp3sOKU2WSDzDSaLcWaNdWMZx5CrFJr1BzXRGJgnUGtj06TZpFN0XHYAslHTwwt2lFugo9vKgpZZq3gYrEilPqr+Y0QR2+sxY3tuT8Jl6P5EvkZCewgBRf87layKVm2FdPbaEREoDp32rsiHzd0HQDsHTx3HJdOZeruntXwPmIRfeZJu1bus/Oqf26I46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvYKZFkmEp7R/Sbh3AKR0og+DeSGBXFT+ifrCOl2hIo=;
 b=EW755CYTo8/Wl8X7h96Fh72KjXjGh+uetsgQQ5jrODQeYFHrPWRlrpSK6eCxtZwesUWc4cU5BRnqGMC5Ml32Zo0L9BLIvdtnWZ2AupUsuGgbLretFiwPTUhkK0gZvU91Iq4hHOxLFaGithcNfUzeJ/woFeGkhBg99z7SkSiL+knJXc7qP13blKTOyrsinS9CTy1dHRgW/67mhO0a9qSIJkpPOc47V3mrDH1em8T8kCJd896gvmXH82Nq8NWOKr+ZCR5r+h9IBpDOto/muZaH3uEnZR32xi7FYd5nzDmsjFcAefDitMw6pWzb4nfKZJSoEL16ea5aZfThD++ZY5//oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvYKZFkmEp7R/Sbh3AKR0og+DeSGBXFT+ifrCOl2hIo=;
 b=Z7gThy8yPfdB2/VOlPza0MDMd+28dolI/5vYfDVSqa8X1XpPvrxTYqViYrgP3bj7lmIUN21Ss7clis+f8dWI5fQr5h1QfEHtokYXPE1sonCax2ZrwcSW2M6Lbu9jS318WiQ6T6PzE0J5Ok25+LzNmZw2rrVM6SyrukzdPvBob7E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 21/70] mm: optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v8 21/70] mm: optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHYWX84Xi+HkNwJy0mcKIpKd/G7uQ==
Date:   Tue, 26 Apr 2022 15:06:34 +0000
Message-ID: <20220426150616.3937571-22-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 548376a4-6b19-4615-c0b4-08da27965b38
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4679ABC083EB8BE3DD216BC3FDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5WwOx3xCBDSWcYEbnIAfLV2OpQhFjRnV/CP2CF+ilqvxNMgWqqaqHSt9omVcvjQmZlQZv7jIxyftMsOnfdA/DgsShAqy9LQmupJ8MGr2uD7mfNkOzDI7ZAhKRJpuMqZ/Ux1W+rsI9aHwTzRoAoEmm215Uq8EvAEMOXl1abvfAIQktM1d6nypjjA0uDrUVlYMkeO++i7QBZGXUVqHD+VxAEFNxs2o9MhXdJsPjLBaNR3IgRpZbTcLTGEzGucJlc0h9IRtjxAH9RYWMvXeaaldsXtN53BWRIAb19ufvU3lACviNvSyoSziJqlXXh7jjZuscp63VjOFjHNBuyPsquZfy9HuryK26kZ9NsjoFpHfZAV1MbRZsqauPtTQolUo9v8Tu3/RUDLRwzxOx2TfQ3OUEWZiqL+iYT8RnjueRTHz7hfm0CFAuhs7t0EM10eG4oMV+YMwgNpwd8EGJmIkhHsEeUY2nHmal5uJrTTIClCJM2cxy7rRFDLmbWOZZ4zw1auN7zHlr8lCYtXqieQPoOusjWm7XE4o8o57Qb81kCis8LcuYa3Sxm0VL/IWmwENa6aL/XmwuG3lgll0eDQVZkzu1A9rwfGUmGrIs9YuThKdPvZFIqeLL9N7R/Xrc37N5TRMHmlAP2ckMKhJLN+yhOwXaSm5xTJPn/wrD0CXgpBZlqTzGqZ/rTa6633OZATvq9QI7NHFGL3/W2Rf+y0bLlXrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(4744005)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gr53wK3Ex30ApZqsYHkf16VuhBPBLhYLRn1JAlnbxLHXxsI92VfWg8HBvG?=
 =?iso-8859-1?Q?KKgEcv6Fbgoe3ETY+lsvMfdURjpS/pFZ2NsM82EmGOYrNOmDIeRWx43sz3?=
 =?iso-8859-1?Q?JtoNTNuGlXIXm3mWEl/yl7R3oq8dhGZ2BkOU8yHHc2IzI8gzLh9jzYOGqj?=
 =?iso-8859-1?Q?0EVCceL7FFmhKdEdDsIS71UCCY9wpRCE7tDDNaglAzyeyqjEAIOODlPa15?=
 =?iso-8859-1?Q?K4oCqPgImRtYh6U8CvZPiZdYlBzHqUhPQSJLZXpYfKWwWzAIdzywvIXN3G?=
 =?iso-8859-1?Q?azE1KtuI266Bq6Ndn5x/Lrit5nAiju7L2/1SusHUCIe8uejybBSZuqkDoj?=
 =?iso-8859-1?Q?4sBuGQH9BJZGfM7u+zTc9c/PhlFDD0zXOrYwov0ffmIYfaKUf34vw1h6z6?=
 =?iso-8859-1?Q?U6ysgq5sM6S0UVFzXAHaQJbdAMlgtAJltAvZnjNGehTT6Y+dMC8eZzGghF?=
 =?iso-8859-1?Q?ZxyLf7SZc7s7SV2cvUmFVapNLx74X24sssNiCuUrppDqHDDANhlmeZ9joC?=
 =?iso-8859-1?Q?T02TWLP5BT1iKECcobgl1Ht8xJj5AfC0zB8PtZq8YNBXIqpxQaJ+x+prpC?=
 =?iso-8859-1?Q?0LTDx9rfs9l0la5T6KQVOTQ8rn/5jsMWxtXO/FlxhyALn0TeiJSML2ViU+?=
 =?iso-8859-1?Q?K48bReB4vcvmkgmVU13voMy+ISlcmGn/U4r7xswdRDuJS+we3z1X1HScbT?=
 =?iso-8859-1?Q?btmTruLSI9G0p8k8GKNEjkQ32eJrjlhkB9MQ7JjB8NFcoaJKzOY3xpHbg1?=
 =?iso-8859-1?Q?dpY7a39aQxEsMch5p3QygouO1+tBbMayKc5R1yvx5vrhNmG+O4t4sy9DsE?=
 =?iso-8859-1?Q?869dD3StNVgl/ebFZSqgSXoHDs1KtGiKq0QIDTs2Rn2BG7SN0zlKKTKbeM?=
 =?iso-8859-1?Q?HId6zLl5WypGfAyfB8mJqA3sGwL0Xi37HfNB1MUn84ByU0vFgBhnmpoqeg?=
 =?iso-8859-1?Q?XRZFW6WG46oz2wZBroWPBiE9K5xyDrfnDyYx0gs6+3soJxy1dqo0FpVdpr?=
 =?iso-8859-1?Q?EW+EqRryVDgprEVEUZ2k/jpo8bn6wPTqwA2H4hcos7/Zl/HL8lFELPopl5?=
 =?iso-8859-1?Q?j21DSjbOjGmBBhWr12ZrUl1vWuYskmZ2ZgTcIBb0X5abtTey9nSLgAY0gW?=
 =?iso-8859-1?Q?t7936oLnJv/s+o9ls27gkTrk2xhkpH2bVqnKjzNfuUGstsTtk/wNJgvWcF?=
 =?iso-8859-1?Q?1/aCaYKQiDbl5nVhxopupadwX8xZO8mg7hRPCmHBQeWwEBmEmJfYnKSO5w?=
 =?iso-8859-1?Q?UyHitGZOpr5d7ehGvaAHSVAADu1mWjdaDLdfc9pZ6F/T4WluzQzn7sY3D/?=
 =?iso-8859-1?Q?5zjv3Hcn1UGeyrzUI+TDV+lzG//zt7ByETV87x/ONemXB1pGJhCCt1Zuh6?=
 =?iso-8859-1?Q?SBOtUSt6Sdri9SmdX18K5DQ+QESG1wOad03rE9ebJnw4hVWzDbPRikgU+A?=
 =?iso-8859-1?Q?0zCNbxohKSFd3N+FiHWOOHVtYRK012Mre7yDTp8QPyFu9yGUYldAToH3jN?=
 =?iso-8859-1?Q?JG4dJw3kzWSZfFui/8K49UTQQotLmN1TRfFrpBQT4nTBQHa1qYrpQcqUeC?=
 =?iso-8859-1?Q?wgvA81dguvnIb93JgJHl3tsEEDCXFL7aylfk6q5shUwZMVVfgeeLNsxHwL?=
 =?iso-8859-1?Q?/SoHgW4YKBFk987iY9/YFionwHzDNESiwAZrZDxjYcS8WpTzaMQ76UMhng?=
 =?iso-8859-1?Q?ZsoKhnEldVdBxp7jbUdc5UkDaR7j6pD2MLegPy/P5SjMtCZzj1q3IzsnHs?=
 =?iso-8859-1?Q?dC6x+cRC9GrkIyl2khydiTUighXytcP0appaNFmeN54OBk2mTovZw3evAR?=
 =?iso-8859-1?Q?hw2ZnZ558Zr3KycZz2eu6iNLf8yKVew=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548376a4-6b19-4615-c0b4-08da27965b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:34.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPigJa/3ANdv8AOo6LzDwA1F9bUZrfAp4rfYP6c+yfIr2thTkCbG8lN7uqPlG2dQfaUe1khCcUIdqGm5ieJ5eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=616 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: 0elHCghqZOJ9ZixBeNSoqthJpWFfZrz-
X-Proofpoint-ORIG-GUID: 0elHCghqZOJ9ZixBeNSoqthJpWFfZrz-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_lookup() to walk the tree to the start value requested.  If the
vma at the start does not match, then the answer is NULL and there is no
need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8cafafaae5a1..02bd4390ca7b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2857,7 +2857,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.35.1
