Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF76759C209
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiHVPFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiHVPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A21F2AE14
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkbm6022045;
        Mon, 22 Aug 2022 15:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Vc06A6FvYPmm4Ixdd5cKWXG7/qrG7cnWtdr6MKGQ95A=;
 b=FwLvhY8SeJrtIzaCKVsOyFoxRMPoAQztVkOV8qjCevu4Xim2OEA4Eub6C2/z5NiMSPOH
 heZgmg35MsoUsRdTXqVlpfJnS+UNtrPTY4M2L4YLZjSRv+sbIoGipDh7MiEhe6q449eS
 /GCqRxIos57sgEqR5EqBlx3M6XbAMwvaqyvYNTZ320P26VH0Yzg3XlmI7ETZUp2pMwrW
 IB02PVJM2dzxe3DSPynStm0H6jPz7UwypjGfnhaYcxqQ3hGjjVo9T1BC1lbhbbI60lzB
 /6v6DvSB3XR/HUnrr1Sl4LPnr1lH3Olz8n7aQU7dBylXFZrB3VCJSyHlNarIhWUROqXb 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Ok5035558;
        Mon, 22 Aug 2022 15:03:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1tv5j-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3eA4bNUiOgoNpv+jouaMavpCmb4i167tPP9HJJVLUX5OjONXwEyVt4dSoM4guY2oE4OiFbbON0PoICfJWicF7Ysm6+8zl7hZmrWpe5BM43qjnZcuQbJP01rWdLKVqf+BPSi1fv+Gl8gDNw+it4KbCFXk2HkRgOTq2myY60z4Wa1KIHbTh7lXbuxKyn1u1vb7GrG+3f2kkSIjBaAuCsZ4XILaslU/O1gDKlJFx8Onzv41dGTXhuwwc8yZcmyohthYfPjB8+5vLMxCePqZLwpEZ0UEViIpBLYWn8cXbeXZYhml4o1QT9MQVg7JF4EW//kisK/ZEnpGu4LeZ/Ca0+ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc06A6FvYPmm4Ixdd5cKWXG7/qrG7cnWtdr6MKGQ95A=;
 b=lTnKJIgoC8rMNIbgk+A3ypQ/unfjEIoAXqDc5loUpUVXdi+4M/473cYyxTQcJSUjXbafHrnR8OZJ6R8+57Y2IJFtUcSzkiVkkacrvsVVSMh0C6gJDrqOgFoPEuUGu3emozNzKDoP2B5TjOHSE4uzNfZqVVrRxmtQNT1Ff//UmAGdDk/tJks9Ai7m0JAeGXLCvd6U4gX8PaTJveE/VYYeE/GJ95D8sTWN4BhpS01xKNhJnIyqcaMUXF65k0Tqbh+07Ks2ddkFdD6I1L9DsXT7DzceRnfTIXKkAVrOoB2v3p5CzQ/x6KkpSDipmH7dmwmUz51M+2fd1j3/BufB6Fi/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc06A6FvYPmm4Ixdd5cKWXG7/qrG7cnWtdr6MKGQ95A=;
 b=pf3MUuQ2QFaj3+ZIRz63dPQ+YMBZaU/JIjnkLOJwFWk49uAUIM9x3rKR2E5jDsHW+Go0bjvBDIBcIQqYgYK4JhqeBtXxek9sCLir5b1lx/jOHItPn65VrGAJ+PTcgqTL1rrUaDQIePbBS1O/YlXgGbenHTDSN+zSY7mwYifw8DE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:03:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:03:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v13 10/70] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v13 10/70] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYtjhEHxcmbGvBzECjHa4oIETwhQ==
Date:   Mon, 22 Aug 2022 15:02:58 +0000
Message-ID: <20220822150128.1562046-11-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f84e806-108b-4d27-d9a9-08da844f7129
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T4McbNxDQiBJuHuABL4IkZ9z4e/Z02fg9Wu5/B/DdURm2wKiJNTbOsqetnJeC/KcKZEZWRWjyt0akZiU26r7u1A7YqJvpSRA0yVaQNFEU+4lm5u4TbLlV4hEVjwK3oj/H/AXjhHqTBLvdOTmOWwms4MV5evIekN0cJ4aOu9YrawJKatoVJOSgup006R7oxZUCOaEQp49EcUj9Ohr5NHCoiwEPwEX0EWZ3HF5W6JbJsIn7kRwlGHlbsH+EzGpnAUcdfsHTjzwf6FVJ8MxGobnK9ylU9iII+ec1pC+9MZy6cApcO/56KLbB6dHSFxa9PH+/GtBokMhaOdZu0h1o7IalUFNNhHms88VHyQ427/IJLizIuPYtAPobyEr7v27nGQhblfOHsHHl42ilMm2fxS/iX0n5O1YeO0NdJ0YxesDbiY5g5GZ2GD2Q6kqaZqcOmgDGuyhu003WMtF9jVj1D2L11wyK76vShcDLm5EKXiikxGIdyQwX0rUTA9/HieNWpNSIcFPlnLNHu46qAoO6sV3e/0RM3uFJJBezy9CnzCZKM6nRvZLKpxdITgd5539WttI7GsYPgjCxZBUcrb98j0zjOxM0fxqNd7fSzBQSiYQne0YOIoRI+ZmA/PwVPnR7Lfs7uL/iCmmh4hNlHOvI4SjetSuHPyN399PSFimKLwycnQ8KlNWiYvFMXKWwY7WayttXTQEjOQrwSW6JrgGeC9SbjCF1Z3EcMlPkDJG6j5l2iK9a22VQBsNpGrlyGpSRS8gLMZx5yOSm1srIYK3DWiLrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(54906003)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yHMuLZLSky6+QA3y0MYkpn0Bw9PbGdczzNe/otVPuJ4DC05ui5sc1CFONr?=
 =?iso-8859-1?Q?IFvMGC/J6iOV88nfpvt7PYLxx6LPhzl85sMVGNqBox/ydKntRUv8wtj2BN?=
 =?iso-8859-1?Q?4jPfQx17o3WZDgtMTsOewq8fRW6Xy91eQlURiuVmpr4LJfovfxHivU/W5/?=
 =?iso-8859-1?Q?MMIEynI2pbfJokBbVOq0wEDTn7D9TCLPZuwYtj5ClPK+iQv740vhT2UrE1?=
 =?iso-8859-1?Q?Lv4qMCoc1bfqyD7XP+/1I8rt9JLbjCNS0usg1stH6W9MYDDDOwhFHUIbrm?=
 =?iso-8859-1?Q?fxePIsljQ09QkSFxuScMcUEOcVvNnEyQvRjjfDB8bKB9DU4bZM5SsR4eVL?=
 =?iso-8859-1?Q?7mkA0DzhHAycfhUpLZFJzrBX2bSkXzG08GeW1dyRqI0cQprcM2tp0EKF7z?=
 =?iso-8859-1?Q?biNLuuLyUsQ1dsq+evgGTnOxqUwZXv4mvKEmLSE+4LhJZvOzsCzqxWvxH8?=
 =?iso-8859-1?Q?bGsY//ymd5+Xj/Zq4xvR/o8dp0P0lSTU1IE7tyi26uYRS5UlIyFwE7BgGP?=
 =?iso-8859-1?Q?hbABSGqirQM1OaCLAC6bwA3gP/v+iHk+m3IFqhK6DFcXCdBK9UlapjvMwo?=
 =?iso-8859-1?Q?IyFjFojbuppz5P04cmK434zAAI4TmuFepfTHlnqWpQ10s9x0hd9nW5iLlc?=
 =?iso-8859-1?Q?To1+D3XXbu2vVK+diiB2NbvJDvS25KWKzOrEC5JGOgKJ7kq/2nKcor8PUQ?=
 =?iso-8859-1?Q?mHxLG28tXDA+XQTbQdt1ABqJ5FxI0SkyUOjCzeFNZd5OZ7MzBoJWdnQm4o?=
 =?iso-8859-1?Q?zNdKhQDXC7U9j5/ROo2MPPYBPxdcSpKcoW7E0hDa5xX0ERECwXePjiS370?=
 =?iso-8859-1?Q?D8oULFtcJLeehZN4oU4SqiAzUo5nfp1P42nEOU3D/wRc8wRl0TNQy+gye7?=
 =?iso-8859-1?Q?8pldnARpbqbtYfsQ82C7KbG3/MksL7Et4unbtejO2EtLHdZs4qp4p//K+X?=
 =?iso-8859-1?Q?/D8m+ohSwJ7vAwPYhC4TeDSXO0JMjoxgVo6KEVcIza6M5RGkir8ER5TGFc?=
 =?iso-8859-1?Q?cyRs02tljS+yg05wHKH08YRGU6nkI3jYZDqqqSbTJdfxIc+VXV2AcFV/qh?=
 =?iso-8859-1?Q?PDOt0KTAWXTV1TTsUOfh74C29/zJoMNm5i8b8IcNpba6jRob8izwEZEg5o?=
 =?iso-8859-1?Q?NLwVnX5IeHntnMMgpr+FiJmh5VqkNhJ/FA9EUqEx1PV9ujOCmiDkC7NHmp?=
 =?iso-8859-1?Q?eUCGcm6KbY3h28yNL6h5Cn34kbaA6TKRnChRBlbQlCjrNnhGO6W+mGd0ZF?=
 =?iso-8859-1?Q?IiHfpoO5eOzyyXEK7jiOU6rUJH7X1i2LCdrGWj3Dl/er0NgW855R96pJli?=
 =?iso-8859-1?Q?wczgDCv7helqXkbp7T2L66kAJKGJ2I5D8B5Dej7VAOb1GEzu/jhfd7ZjAl?=
 =?iso-8859-1?Q?6uCR4c+Rpcs8QiGHSHb9tRU87TQDYh6M3olNE35NSTmdnL1EI7GDtDiz2T?=
 =?iso-8859-1?Q?T++KWv7hzcNG03um1dpNPwYRmlQCkKG3DJNuPh1GWqoHGVFxeejezRgSzg?=
 =?iso-8859-1?Q?7jEiZ7mnbgIMQaSZRVTlKz6NDKzdf39EiN3uzOnwVz/m2TBYMun3ucZ2jv?=
 =?iso-8859-1?Q?oEXfhlVDKxFkw8rWxMH3LWmG6XX7veeWgQsSIUjl79Xvv4GLdRHssihwQ/?=
 =?iso-8859-1?Q?jefnAOKj/ItQ/pGcgKictTLIlDvLV8JDzV/8AWkWuQLYxa21lJORcGjA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f84e806-108b-4d27-d9a9-08da844f7129
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:02:58.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQplAZO0rR+17+ZGlY1vFHomBJdycNbQRy1r4wDHyFOnKpjbOELDNnkJuYRrXBivmQ4zUiM6F1BNmw8csONBQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-GUID: CS0ZLHTViSESKrdDSz2GZox142z3XWU_
X-Proofpoint-ORIG-GUID: CS0ZLHTViSESKrdDSz2GZox142z3XWU_
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

This simplifies the implementation and is faster than using the linked
list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/mmap.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 20718645d82f..f1b07751a1e4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -629,29 +629,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long =
start, unsigned long len,
=20
 	return 0;
 }
+
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
-	unsigned long nr_pages =3D 0;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
+	unsigned long nr_pages =3D 0;
=20
-	/* Find first overlapping mapping */
-	vma =3D find_vma_intersection(mm, addr, end);
-	if (!vma)
-		return 0;
-
-	nr_pages =3D (min(end, vma->vm_end) -
-		max(addr, vma->vm_start)) >> PAGE_SHIFT;
-
-	/* Iterate over the rest of the overlaps */
-	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
-		unsigned long overlap_len;
-
-		if (vma->vm_start > end)
-			break;
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long vm_start =3D max(addr, vma->vm_start);
+		unsigned long vm_end =3D min(end, vma->vm_end);
=20
-		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
-		nr_pages +=3D overlap_len >> PAGE_SHIFT;
+		nr_pages +=3D PHYS_PFN(vm_end - vm_start);
 	}
=20
 	return nr_pages;
--=20
2.35.1
