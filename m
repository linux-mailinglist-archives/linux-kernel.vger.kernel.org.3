Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBAF59C266
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiHVPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbiHVPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA23ECE1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkUt9022008;
        Mon, 22 Aug 2022 15:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wyalKh797xvHrt0qBZcmItmpSg/yJyiwBv0++1LzgZY=;
 b=lhgLdVHb/W9AgiiOc/KLygLyxDv9EU6OzJPDqccHCP1o621nxGivdKnvpTsuLBBe3H1y
 Zr1NZ9qcHjwg50xuSqf7SwnDFqdNW3bA4Vw7wP4IhI2hml4kFsaFSMcUxmHXzAFgaS2c
 fI6/hEQx9LXr6A9o2QOdLvW8I5e9j4lV5ctDwVSezhBqTo4PXjEpY6Gifdco8S5vhdNS
 Q52dVVnSAwnF+qK+sjVNsj0eqOgEbdvBR5HjQKoy2buK43FEKzBw3CyNV0n37XgGkBKv
 scf4bNyKpwGnoztSjoD7NhG51S2V3rtnlku/oA8DRPJX5jPEth1VEoe7xZ7xVHSoK1/W /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NdT035436;
        Mon, 22 Aug 2022 15:06:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1u1em-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0VAoLbD/FbAVf2ldTwZXiRb3HAzzbK3IAPdSGAkGh84yZIYp44uUwndJUgPDyoOyAy0f2RHSgL3jZL6I9S6+RV4Ksyhm6mDJ+iFWrWci0Y/0OXCc9S6edmPST1Ax9MPVx+Q1unh+myKG3qlB4zX0Olx1GP1hs52pSeiQ0SNVo+zOj66JtCd6/DuB1vpCCbdjydwh/b+Tgs9lThw9ULIwtjqRDs8XJpQIbk+9eiY3jh3fAPQ/K4hhPBs1lvhJK1v74Z3o3OgrPQTWUdASQyARdtNw+qd9BYkku08sC+It+mihWfgJrzMazxs0A6pFTW2cfzhV3t5c2PZSjzdUEDEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyalKh797xvHrt0qBZcmItmpSg/yJyiwBv0++1LzgZY=;
 b=nSo5gVSmMB4KWsSAu2b/Kql4zP7tSgQZAj4OKuiXROLLgAOezABHSp69gbmDnzojWLB0D+hIxHZVL4Q1KrDH2a7tXGUniJ47gOfcA1jWUq9OhY2thal9niKuURybOBMoR7+hZAbZ/DoocjqxbBTIKNmikLnMa+l9LqCD//K+G60AzEVinDMGPNEJedN17BoHKcAI9u0+ri4CUBYW0081lEaO/7noZPbkEwL/0z+j1xPaquj10pXQCjkkKLx0TbrdFr0LjIn6yhoX4Zvxkn716+MplPki3qDdQ/9CrFERB/KrnhQjJ3Wxra//dn5dr7UT5UXwOccxYWq7jDjmeZ0qUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyalKh797xvHrt0qBZcmItmpSg/yJyiwBv0++1LzgZY=;
 b=uzHps4l8tMz8esvP0rxghiMnxFfEFLmb4rBHtAaX37qoWvSsSlXwRmUJx1EMVmSAF9wIV078DjtTHvFnIEZozZZOkfFAnNB0t7+BPx5cLHP0Rxvhxv327pWtSj53nKBVjsGySiu+SML6sJYM3fs7LofJLVztFG9/ROHiRZ3PfC8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 58/70] mm/mprotect: use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v13 58/70] mm/mprotect: use maple tree navigation instead
 of vma linked list
Thread-Index: AQHYtjjCkqw9gd/s70yV945B+ch+Rg==
Date:   Mon, 22 Aug 2022 15:06:30 +0000
Message-ID: <20220822150128.1562046-59-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 213d2e44-0a30-486f-5e73-08da844fe752
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D4+bzsisjIhLIVi49MkXEyma8qgrpFFr1VoKug62qB05jYktyx3/t9vmY/ZOvIB2ST2FvB7x1WVckx71VJn4MNZIa0U3Mj2OGAJOH0O1xi9wODMqjuQ9WMX5QfJpzARedkAPWlDxBrYM2VYdeC9lXSYlN1IIt/YZrEN8ZAVE/febfTCRs51tFdsfKcm1N5vA2DdAKvqkF94uHQWsLQhrvOEE4vYnPSLA+aKajBL2+8FgOEzomJJxS12QmuMHYfvsDBDV5JC0K+wBOtPJaMpgCqPTjmO0bU4gplT+3EssexUMUihWq0Y8HI9wBcxIesZTvLshmth1/EJj3cGx+zyA0E3X3fU7yS0M3M+rcUFVhVETLlipG8slmcKsi1yUbVJx7gi5NRO9cF82NqfDjQAtTf259SSwNaLO/6QZbJd0WpOGIHqp7/WGB4gQrgzL5VvCnazEZppfjpDt+rGcGMm0gerdALP+XgQig9DaqbmtllThNemQKvOXVGfvkXCTN+XRot0Q6h88XKR93ccOkWea0NUtYVeeNhMOEcw2pT7GRPuubMenu8kho0icABy/vduRTNXPDIWhYCbRGwpRyUki31PJsLYPfGupeKmzF+QUJl1yj5SWpK14yAEmMrMDqLCS8J5utmodmqSiFzSRITbMwQfu3cTL1xiXRD5Zyh8/vi9bC/GJpi2Cc6s9uaiQafIBHnJY2M7P7+xIfoOKYtoDZ/Go1XDOYh6vBUFt5B9onrapRvOzLLUq+d8/RViG6OMWIprBITkPGr5Aq6UMuL7eRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lZs5AnrkgFt0pEemIBEoN1D7xZ4yKeWbM+TWY61xcYI3jr63ExoYuACepJ?=
 =?iso-8859-1?Q?UUfbmzt5rihvjeaOgWubNmz9iSy/T7qnbKiyOSP85E+JROai92P2IjfuBX?=
 =?iso-8859-1?Q?P3bzgrSqe8uHVJjW8yZFKIzDaNnvAKYIPsjjwauwNV80C8438yoqOJhhn3?=
 =?iso-8859-1?Q?x7DuFIPXsWjI9ZMqedum7UhAnL7C5rI/OfMk7sBX9vZ5riMkHh/IQOXq4q?=
 =?iso-8859-1?Q?BC9CanasMa+Z9kPFL+dNmQpokb8MhzLENKrx9gkqL3uaOuhyzFajVGfrUf?=
 =?iso-8859-1?Q?YKzxDj27yW+TsRQna5xWz6fFNv5d9mBWo9GK1s3fXU6daUBNsjrXGihEYf?=
 =?iso-8859-1?Q?5K5fKrBTcLJhlbWv06kjMhtCfI2RiUY1aolpt6ImmrQjOt2dOjUuyrvK9j?=
 =?iso-8859-1?Q?NrdOGmEcKHH/ageQJdYva5G7unQ3TPnisZEDQvo30ML1romlGCSRdrf5Io?=
 =?iso-8859-1?Q?pEG5AaTFm+ramlOiVwpQGigPxg2iPIbIRzmidrczHraqrks3jZ2gPLCL/e?=
 =?iso-8859-1?Q?EKxJLR6T/ccYGn0hUwH6UE2ofTMeonK6+ItxZLb3OiZWaDJOIk6rhd+w8r?=
 =?iso-8859-1?Q?N6y80ED34o+NpNURFgb/BawppL8RbCp4zWoRT+/vczqpXelFAjOfaBu2I8?=
 =?iso-8859-1?Q?6epcElgQsPAcZa6i31Nwkw5tP0f1Xuf5czHOHJsRaJQxGjKpwxApr7DC3a?=
 =?iso-8859-1?Q?UCD2v9UZlEkqRmg+XZFETB/1RITMr/+0uK6C2zwrrbr7kUu11oGEmbFZx8?=
 =?iso-8859-1?Q?OxKW9z3Se8LWu7mcZbApSzNa+1FseSB6XpkoBywXSYZjQVSPeZER4p1pwb?=
 =?iso-8859-1?Q?+nmOc/a0GzcAqKhFZvS7dvAwbFLplFz9FUCi55wuv5lTcTM6aA8StwGki8?=
 =?iso-8859-1?Q?7qYHSjqSnuBo+omFwO4MACquvZDd7ITNgxwuuWM/KbchMpq6zc6PyRM3NI?=
 =?iso-8859-1?Q?UmIx477N+Ox4Gbk7D/j2CUtd9chSt43373FlEjqHRAI/Ym4K8U1JLGF4/u?=
 =?iso-8859-1?Q?x6ceRWTbyJOPCsSVak3qWt0YXFVz35axZ0Z3jYmcVyKXv1fExJHBjGi/xi?=
 =?iso-8859-1?Q?dBmuf62cLmzvLurxv8u9+sqqFTBPaMPdzH2+44yykPls+Ci+pMOBwQhRwd?=
 =?iso-8859-1?Q?C768xqzHKFywCTDJ5eO4OgVjtssdFeuwqO9RLge/n9aiuz3ndX6fcQOnBi?=
 =?iso-8859-1?Q?qm2GkAnnFo3K9q0AMIXFvQr2DvNiTVKJAqH9tzEMgoSrvfbeRx0nw6uYJo?=
 =?iso-8859-1?Q?UKCeNTSTtVNqmygLa/Uk5tdn5YmuvBVsQCPDxm65hIkgTtIlzBP3q8mlPP?=
 =?iso-8859-1?Q?VZO6UMx0UI3PmcfHV0Su0KC8Myur+GFY6G0urGc8QaD1dbCTBnbRKY4+ZK?=
 =?iso-8859-1?Q?uuNTEhna6mjNIF280OfbmzEMO8ayjOW8c9cdRcNLKm5G9VTA06OaY4q4Bw?=
 =?iso-8859-1?Q?IlVJ4DHFReP3BL1O2Wmmcorw2aZyoJkvQKpLYvclKOH5lAkIqnj0WwA19R?=
 =?iso-8859-1?Q?9oryO+ad16EI1Huk1yetvSHPbT1EcZ2uBvdz3FkBaouQnf4uTCcUyVRowC?=
 =?iso-8859-1?Q?moCg0v2q8nSqGTialYkCafdTD6uou0wO+F8vv4QIs4ssEa3uGZL5SY5RWv?=
 =?iso-8859-1?Q?/O4Zvwpnow+Cbhok07PrF52xHc0e61PLmcIqvx16vM75WQQ1cdUmoiVw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213d2e44-0a30-486f-5e73-08da844fe752
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:30.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzmq0SW1Lkb1E+qeWFg8GLhzrZc9X++11Xesp0Xy9tU2N9dJer9ENH1GSiHfmmcJIQLhgRd8e22507iNzooEdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-GUID: 8216mKPr939Dhy9jtSPO0hnmKe3vBF9t
X-Proofpoint-ORIG-GUID: 8216mKPr939Dhy9jtSPO0hnmKe3vBF9t
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 3a4de77161e9..5bb37e639bfa 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -674,6 +674,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -705,7 +706,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -731,7 +732,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	tlb_gather_mmu(&tlb, current->mm);
 	for (nstart =3D start ; ; ) {
@@ -794,7 +795,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
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
