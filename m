Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C66D5AF50E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIFTyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIFTvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:51:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8156515FE8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdAfc020044;
        Tue, 6 Sep 2022 19:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/kkB3OBPhAHjZioHgreLIOcyAlFTdoXPk78BZCDRW78=;
 b=hnEUZGW9+zQoptBwPMvp2idMhsI+rl/uPyn0Bx56d/5ZSebkWTH0G9FOCtOA8VW29LCS
 gKTYXe2xZoV1Icr0XR+dgXDgV/UDfLm/6qkL0BFmWDKIHe9nCzedDqF2yg1V/fq7on2B
 hnCklHWuGAn2GLwJaEgu7QxaRZG+TJR6IrSbyOLnwRi0v9vWwO7OL61DGud7Cc+b7dNI
 LfNdxTSY06HVJaGwG5IK+SEld+OTt+AX/mfbj3vBT4VzkExh1VJ1Pc6Q3SV9mCiTDxqF
 ccyIBw/DrSvwXB6EVSa8MlmvB24lOIKELbqUyJpntp3gwiIOxqePDQr+34VPpbXrDbo7 DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67Y031251;
        Tue, 6 Sep 2022 19:49:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmgNSKRRLS/39a5TzUmIPjtyZyj5BbsbxdxC6wUzv7hVVb2m4V/QJ+ultZxr10ky/3G8GnvATkToOcROwfGisJafm71QmbkPzafcnXdYPiW/z31cbZn/UsBI/ZtWRvlL0kp7ux234YbsiEzjAkZYpcnqmynyVLVWPHhJae/KhGXh4Rug6m84uRaGq4fHEFDTkyoLXSIvOSJwP2b+sdR6XnmDRRdULeWyt/af68pmtBZS1fdpD5wQ8yT+9Wqz3m79bcDn3ZbX6F+nJE2zXFRluhs1LPZR6Kk5BMN5SYavIXqcz+qxi9Fs1ckbigzh3HOZN8jxQUUFx5G1oNRzpGyH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kkB3OBPhAHjZioHgreLIOcyAlFTdoXPk78BZCDRW78=;
 b=GpxC+YM4LnYMN4xwPQdi2NeIb986FNhIM4WNkCDc0Kqwcuh6VudIbq1KDxd/bbWxLUs5xRtmvY26L3I3ypglCRarZCSjS4mV6XgF14k4dvDgvo5H+w879rUEQhooibnsk0m/wW3XSMQU6sYbMQBuVaa6QIp63DKl9wShCxTw+gfpniRmHT0kHIAd+pzKJnfBwLAwNiRafqzMQ4ivn/K7oZG9FBc5GogGtKrU2easNPHWSUFPfX8ImwPXKlWSbxuD+a9Uz0Bwkva+vyl5pGBgx9TnfjvaSgL+7hf+Hk96gWWtAsj3AeGPejTn8RxlNFWIHj+cwnr5fttFPD4dmHP2vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kkB3OBPhAHjZioHgreLIOcyAlFTdoXPk78BZCDRW78=;
 b=LRKWXwCvpwLTHKsT+uNtHQuXQHRarOkEgOkm++dC67lcZ6g8ddFdjbKYNzz9fgjfIWY2xxni2fuEaR0UGj+XGAwbcqGFx8iTk2WaDYPhpuo/Kn5vt7Pcby+S8cXeFz4FQT2QwbwCKZLRfhN5YSG6TUza1r8keWV4OHmJjJYRqps=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 59/70] mm/mremap: use vma_find_intersection() instead of
 vma linked list
Thread-Topic: [PATCH v14 59/70] mm/mremap: use vma_find_intersection() instead
 of vma linked list
Thread-Index: AQHYwim3wyAyTjaxeEuiwNsKsjCjXg==
Date:   Tue, 6 Sep 2022 19:49:03 +0000
Message-ID: <20220906194824.2110408-60-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b285c8ba-6417-4fb9-912c-08da9040f56b
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rXjfc3yUu7ww/OruZzAYqje9Tq4VldkyQQaV8fMl9u2MJEbYivoQ1KWrP7t81coPnuabFJfJWqJo1gEU8MP07G6uCGPtEB/DdIkHwykwPj53TNLFNDnJBOQSX9n1bOAsQXopIqWouset5wpIua7fvnjJaLsbrAwpVkk1YcVF56rJ1wLEaH0I1dvURs0xQyWYhbVgIrw6/Jz0gNTDTtQAZ4NiEF5C0I8nJ9wY2Uk/BwpKAfxDjvI1Hi37lQqxPHTp/boRPFu2a6xVS42CF3oieGS1Qnuuh7byZ65if5o/f1cFQrRkIwEEgG6UXGU48nc0Np6GbnBIqbpvNZazjET19Op4KKeTAZCnSoMO89f32E5cqcXhNxDCCcBkfstfQk8gkuAOe+iwBNCxX0FtSs6NITClOlStnBbciugfVCcRi7rdOElIb+a+DkxHuQGrJ/V40YRESVHoAENl8MiZbcE+aLrNXQmm/jLkhtLFZdNELOW4tzBbqsjphwMHSEUpJ0cuHhHsX4KIoLkFS/8xEksckJw6x02NQyN1lLX3C/zJOMJa5lYr/4EdtclhqZtB0IhE+YpTSfIrLo2kJce08tCm4Qfs40+Qwq/CZGTiGmNfqz+611f553DRtyTs3hDU31E4h+x/m0IuQ42ap0sMzAzJFdbY5AFPJfO3IY4oorF51GQIFy2V6AH7Un73ENTKxlPJVxHcyFJNCisikXKkOAYp8c8IAwlIQDqC+IjeSJGh6JGufXV5/X4PZ75WE/dfXGAbjt8qZpjyIxW6KsaqCwg4Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+IEdt5Wc/zg/+LlWsFSmdIZ6WatsiJN+gLrJwN2ZDx+RBJxMy+XKkHqoMm?=
 =?iso-8859-1?Q?R1N+QsjHoCE5HLvWXIWYW/NMYrSpYb21XP6nfwrE6506fxaHpqLtsmdLPt?=
 =?iso-8859-1?Q?ljT6ENTwvo6oMpRpffxU0NIZ9cQH71LaQfvsCldr+ujc5wV3tWAQn0bRgx?=
 =?iso-8859-1?Q?a7Pnfx0Q1xknGeBlj2xaMePD96dDnC8eN1g4mtngYnM7NI/h9FUlshI/7/?=
 =?iso-8859-1?Q?iRqHhNdRFulAgPGXK09UrKg+SaIOvF/lDzaslu9TyIU3WUhq/4ygFvkWgU?=
 =?iso-8859-1?Q?UE2JZD+23d1HMl9uSe37AhM3nMd28gE6r5EaibclJJV5do5Etq+a7wMt7O?=
 =?iso-8859-1?Q?kbgstMDu8bbU+xhY5i5xEJ2cL94MIGe1q588wUNLtYumhQx74XIVhAwJyh?=
 =?iso-8859-1?Q?GhYqIFqDmOskHD6BusOmnfxmAQKSJEMwCtiUOURVdLbIchrYYf3oiftUDx?=
 =?iso-8859-1?Q?ZCH4VYslO2MbB2YoJYeSFL4Lqz6RXPne7DWsq3X0TKxmtpUJ/LbALi2YGy?=
 =?iso-8859-1?Q?xh/drsIyVwpjkgj+zMIgUq1bM++3AeH5ra9CbecURJf097iTOqiGBBbcCO?=
 =?iso-8859-1?Q?XoECGuEJXAedlZ26Ty4cPMiKAYgJ4r8055vmx1w3uN7XaagswLt69TBynu?=
 =?iso-8859-1?Q?a4vrl+byu8S64q8GjGKfK9kEHc5YPt9wIUiGpqx0iAXsMSPT1ig/em/fCn?=
 =?iso-8859-1?Q?y0T1NEGnYrFW905Cz9BxAKjGxdHLSZf7m0C4ecANomuouqF/63ItOtkyEE?=
 =?iso-8859-1?Q?PUUTXwGedRNfblXLdzaFqrFUEjMb2pi0VX1WlKJrrYh2bNdNMdqjqJGaD+?=
 =?iso-8859-1?Q?mKM09422wR6sP0vOzmWiCjOkTDDJFeF5YmpzWXaY6fIGC/N6IT4eMMBIS0?=
 =?iso-8859-1?Q?OfwJlB3gHTaVBTwsGCWE+cImK2we4Kd44bLarmEWBC5s/8Aj5bldLe9A5I?=
 =?iso-8859-1?Q?iz3hoBBtSpcXpCOeTdmpQKa7Zu9BN7NaAwAJMfVp7v/KMVfY1ooXJ+u+yp?=
 =?iso-8859-1?Q?+09YDU2gg5Z1dMFSrqB9Mm/F9cCqasloVPGgS9k27p1ZYot8FzPe1qPXhK?=
 =?iso-8859-1?Q?WMr98eAoJD6rnUJN82OkifOw9E5t+MhtaXFEGv77HL1NLMaWHfE0wjwkYi?=
 =?iso-8859-1?Q?/t8+aFDgea43MyV5asI4hv+SYO6xXvCKGsR58pJvTArqJwEidxqB7wfHS5?=
 =?iso-8859-1?Q?GcuZYk7lzAeREgyGwptowqYmqd4NuRXXGb2wjLqrJNDcu0VSJe8oWpZFYA?=
 =?iso-8859-1?Q?PgLRVgcHg/NClyjgVTOZQX99T5U8UoGgbtrVdgn+vuMj8ARWxkIxlcIkP6?=
 =?iso-8859-1?Q?iU1HwZ1T27vLZ7geV3FrsoXk4S8euvsDjf7FoD9w52x/nKiVpe/9ONAYNt?=
 =?iso-8859-1?Q?uG76t5/TVngfk7hpzHRyyEPyODU6YYpcQUzP/xiFqx2js03JVpd0sx9LqT?=
 =?iso-8859-1?Q?Kuf7kwtdB4QhYKLtVxMxKot737wwaAtlM4EzqewU3SS0iX7McPYYWe3K3N?=
 =?iso-8859-1?Q?SAkPtpeg8bS8/dXKhdnX5ReEN8zU7yGWJE7Wa6mtc0al4B4s9DrNuaU5uI?=
 =?iso-8859-1?Q?W6zs0dYfLhvkEi8axJLtri//LIIdX0HD4B89Zg1vgi/daXsQS96jAQNLjr?=
 =?iso-8859-1?Q?mps1l/lE2Gwu+aAKUH8RSvtvxHdo8LOHa9w3gV0UR+lZcggCuU9KbZpA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b285c8ba-6417-4fb9-912c-08da9040f56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:03.1933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hR68Pwso7XhcPCjNJND/1ZZh56XJTtFp67eKq1c1GdgcqoA0lSXGiSt8FZsL1Q4onONUR1C9juRdHAPHa5ZceQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: cH4I01QaXhZ8w3uFF0HkKmlpQU9LaNJi
X-Proofpoint-ORIG-GUID: cH4I01QaXhZ8w3uFF0HkKmlpQU9LaNJi
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

Using the vma_find_intersection() call allows for cleaner code and
removes linked list users in preparation of the linked list removal.

Also remove one user of the linked list at the same time in favour of
find_vma().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e0fba9004246..8644ff278f02 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -716,7 +716,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -866,9 +866,10 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.35.1
