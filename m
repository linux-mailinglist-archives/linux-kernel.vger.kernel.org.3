Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF875AF4DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiIFTyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiIFTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB2627D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IcnUf010456;
        Tue, 6 Sep 2022 19:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aeWJGutHEioyp/piHvtO0qcYtzSzW5CKA7bJJ8QE+1Q=;
 b=T4m3TbOQ5H4ix7j8JK1UkSx3SG416xo0sFQg1NLGDJUXpTcvPDJBM/IeNpTbHTbzinFg
 F8hkVQdQzTdCw0FI48bOAeHvPDajBgaoDWg/mlCJp4p8AL8L1q6g9+BX92TRQv5DPQm0
 JxYAPFRUWkankTTwx8+i4hooYDpvRNg3m6TpL3V8exRCV9zfJum0NKwi/PmtAb1ndyVq
 vNqEOUaGVJ6KoSTcoqbWMRwQYBwp2oVyvskNIuKHUnSzYPWDaSwcRSzZK+EaXCy6vEL4
 rdqaCxZtt5Iq5I9SND/nmjiCh/9kXCOxvwmjdwUt+YWFkZK7cAyZu2Qw9L5dVszKLZl2 mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhspxcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67R031251;
        Tue, 6 Sep 2022 19:49:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVl7HuKmlxlThN6lPk+Wk/oLdjG2h5WsV99r6mkx58k2p0M/J8102G+QbWdfZ2W+0JgPw9exvEtzOstDcrH+wiB63B/k9eFpikb/Fi9W8vsfRcf91UzH3xMoMXVeLht3b9zqZ0Rwo2CS5gOmKnVLYp4AMTuQ9yaj6tZ7GUORIsROos8/P7svjM++qsxoe0cEYXQr0XvsTicVigLUG8KWhrm4sOAsVLlUlzML+MSLDfSvhWXa/E4z7pyGllB1loNPmfB4ylGAfQK+QmU2oDuAJRjHX0N0TAx0E5lkYNSLBLcXDzL9M6O9vWXL2YsncWw0IpCmzlGqkhPBkmoYm6HZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeWJGutHEioyp/piHvtO0qcYtzSzW5CKA7bJJ8QE+1Q=;
 b=oKxaqDA30YMzXztSMD8io9eY63+VyR+gvNt5RBeJkSGSt85v6BKHBkcATQzA3qbbJTK6LmQB1JaEpfAo/wzjcm9k5TLGBvDq4zM/zHkUBI9nEMtKihIKF62DXXRG47cEKGZ0HViXipuzCrof0JCai6k+DCkcll1ncKvyC5UAkzz6JRxqbvxRmtsluw4bx2rJjrZ9PmHXy/Z/9OajYPUGNdPXG/KTXv5fxvjteGs3Bl9khZzT1T6V26EVjK/c0sQQ+ia06OOI5vjKCxyFVvI2RiE9kvDr6ZBr5eBkIZAsXF38nyWPe8xizvOr8ii3YKLKG/NSF6O2AUR2DMeYlIfVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeWJGutHEioyp/piHvtO0qcYtzSzW5CKA7bJJ8QE+1Q=;
 b=Wl0+bd4SRzddTGLhLNM5cOP90jYkdil90tT66Y+aIp6LAIh52WIPI021Uv5ikeDb3Exl5nYP8pOmay6FGErKnImc0s4/Gb/MirOwqr8TAOptLoVKexPd7QdG5xS6+3tys+TeFDcxE21gts5te6QeEM3wAA0+E+GOm9niZJRhEbQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 52/70] mm/khugepaged: stop using vma linked list
Thread-Topic: [PATCH v14 52/70] mm/khugepaged: stop using vma linked list
Thread-Index: AQHYwim1K/CTxQW7oUisVaEbVcXQew==
Date:   Tue, 6 Sep 2022 19:49:00 +0000
Message-ID: <20220906194824.2110408-53-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b64ec907-7703-4998-9a46-08da9040f3a6
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dtW10R3R4Gb4NHhFJswYDkEfca1iWmeVl+Kw70ynhmmgKIInz380ZDrtJgGFkVKh56zMTlkhOkcAng+B7rMyAv36Dq/pLQygQAHO+I9XxtBGNnzXdQrn00wZiLPO4TdOHwfCi3OEvRMzS4UOo5ZjCIkCI+BsKlRu1FXKUou3eOSfQ6n0TsCJkXNQxKoPaASu5oaXY1l4kww5G/hWOS9CYnONGL8PX2+7HqePVQp3S4blA7sFt+kL/Ru4IBXW1v89v9jIgfv0QHr1PyXZKK3/yOHcNHzdJC6XITts3I0s8FhsktvorLW5vlye3OgaZhx/wV08PM6eh2jhMDCwiJmfw8KvbqnqqRcePJx53JuJpLQx0GV2LgQLspkswKdhXF98bT1subDxch1ZDNqw93QkK7ifz4MX8YPlTcGGTO9qSr14EJiORUfEbgUwPDTZsiIwdcbGZYgqgqok/TsNc4rIgCwY2xxUgqgimqF/u6+y51txgFCOGRamfx3CtFl6TfMI4tI94xJU1s9ZadViJQ+mfmJATRruMpwIisiqoGIrSZTRL8oeaTB03dCsY+QHvXBE43wQPXsM5QiGKWbIypMqENTRG8Ojptm7ql4YOaXI29XRWAmID+gPNAIyCTi7bIGdfGTl3l06EAtrRNA4gC8ZAk+z8SmDsTyaS4uAC2+MakGbfMOUUySyLeuH8UX7pzl3t3FhVMbdQ6iVKPDTyPrJr6qd9wxnEyZLtPDRW0OG5tTbUNduz+rYScu8UOQADlZPi9wIHeSvYFK6qkOkkKveKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/a+PBfGSmWsBMoMdaCdaQB15iaVY8ZK/Fdb6mIX7M5k+OLTNyOyhtKrG8w?=
 =?iso-8859-1?Q?FXVqaLqgmMvJC54dnU2UTiiwvhfcEczHupJb5a/L2b2eo/yfxf+93aeOrP?=
 =?iso-8859-1?Q?aDerw5pO606tlWqFibaYb+6BptT1h3Mnr7edi63nYvKRei2ySw2jQeaP7i?=
 =?iso-8859-1?Q?YBrqqiq5ISX8OAP5Stg7Wn131uqIefUpclVN3q+iUS7OUP1LrRWOis+AFu?=
 =?iso-8859-1?Q?kPpkKPVmE1X/hPVcsbsfNAJ/j9/JFJEuIFD5s/QBd88oFm17hllqJlZmRi?=
 =?iso-8859-1?Q?4hJE5MFERnu0nArOKmUyA7sn/YI+QjeofvDGRi+ledPJNAk9fK9iTGCtwr?=
 =?iso-8859-1?Q?US+i58ArILd88TCYo3PcaZ5YDCjIGN8qjvNov/oIWoAv82Lak/TLHyWDmp?=
 =?iso-8859-1?Q?NEC4LblD6Llr54947v1MfBCX/9+iFEEmGDLkZ0pp78VUhD0D4TxkORRiCO?=
 =?iso-8859-1?Q?w9a7oFedt6gVAwaShp8DIVHx4xCfiWXvpKrg3NuMOji+lCr85/SFwvakbQ?=
 =?iso-8859-1?Q?d7NDZO56Gtd/7vvgx9wDnQ3hH93NTW5wxVXF7yapx9mVViGgY5PyzBKq/t?=
 =?iso-8859-1?Q?1WY2MwnLUASSM+lKPW74qsjfLi4Z9QlFZNDQXESmVnSufU/1uKR92Laxbw?=
 =?iso-8859-1?Q?07cnHkdGK73lS+UBcX5UEEwFbnaY52tVhw/PK9BgvH+tRtKerENQLDuAJk?=
 =?iso-8859-1?Q?wUKEQq3Lws47ZYHPuhY8e1M8RhZtX9i4Ei5RFUiUn6BxA14xCT+1aj8umO?=
 =?iso-8859-1?Q?29gUv+I2/91yEl94gYmZ0eonWKC9kJlme1NEjcpbuFrJRmQ10Yk7o12fW/?=
 =?iso-8859-1?Q?4HE6zxv68+zAfHOLc69MtQzNcUOJ4GEOZXoEx2VGeNnuh4ePNXSIB/a3Aq?=
 =?iso-8859-1?Q?P0RTsxUZtjD1Hmmekhc4hVBjTcNu8y/93OczPbU8cP9yyt5DPYbV91Q7E7?=
 =?iso-8859-1?Q?h+BJvDfUTvf24naEYB3JAje28yk5t/AEWEP5UQDlMSGRdOaNAbWbBNTzab?=
 =?iso-8859-1?Q?C/xNvhrUaRIC1irCyxJZ5T/4FgQg7/2GKI9hnrkomCLodeZ7U+5fiCKZ3J?=
 =?iso-8859-1?Q?KP4hkUSGhlpkDS1NKhvv0RDch9FVto3y1HrkVSw1Q0dpG/dwZBmEZD2Qao?=
 =?iso-8859-1?Q?CxPapg0KVti57OCN53jFPt8dkq9lOjb/2c1HLtTirGh5RtZ3dnWUpxOQEx?=
 =?iso-8859-1?Q?hESI9V5FT0/paEeROjraN0YSJhl8CLApvc3XJXLj+P4kkDTUGjAvIRka1t?=
 =?iso-8859-1?Q?j+9sFzpofcKlvusMIYpAc7BtFnNQqEW7k5mrXB1X5ycEpbHozLgsLXsCrl?=
 =?iso-8859-1?Q?C2yS1ueaWxFS8Mo+e8wAA5PD/SMFWEcdimQu5OQ250wbEIJypt9peFA3Wq?=
 =?iso-8859-1?Q?j02Z4j39ST0RaqEMz9ZuWBFN8+cOzp6mOcQ5WzHA2khkkrMbatT5tpdJ/w?=
 =?iso-8859-1?Q?0R3jSHIkK+oVWrClUiDDeh34Nm/D47Ph4/n3xyG2s1eifKcr0NxlhhusQb?=
 =?iso-8859-1?Q?qckE9GGDoLcBBCsrlVjs15j3F5uI+ocHd7SAV2ED6+gxSwSSI7XZlJKjhw?=
 =?iso-8859-1?Q?03NywG4u7xNBZqSWyO/GAGrTEgMRY4nFn2yZkOMCeAAWob4iaoQiDlpih1?=
 =?iso-8859-1?Q?zoim7ojKQyYb5ys2ke2Mtq3RN/qeM6zRGG2D+/OnVpBDIUE9JQTiHV+w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64ec907-7703-4998-9a46-08da9040f3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:00.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2Gu93mmMbBnLe2IQyXFeVM9BqsDi7lTwbXWJK5CIc8XVoX2xVLvUEThXzRxXgk9G0cAEnYVHw6kxhW5J7eeMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: XuyFw2I4Z3Jhmys2diMYL8hsLYtanGcr
X-Proofpoint-ORIG-GUID: XuyFw2I4Z3Jhmys2diMYL8hsLYtanGcr
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

Use vma iterator & find_vma() instead of vma linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/huge_memory.c | 4 ++--
 mm/khugepaged.c  | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 66bf4c7f716b..428c42bfd4c4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2339,11 +2339,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the next vma vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D find_vma(vma->vm_mm, vma->vm_end);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d3313b7a8fe5..126dc35276c4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2053,6 +2053,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned =
int pages, int *result,
 	__releases(&khugepaged_mm_lock)
 	__acquires(&khugepaged_mm_lock)
 {
+	struct vma_iterator vmi;
 	struct mm_slot *mm_slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
@@ -2081,11 +2082,13 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
 	vma =3D NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
-	if (likely(!hpage_collapse_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	if (unlikely(hpage_collapse_test_exit(mm)))
+		goto breakouterloop;
+
+	vma_iter_init(&vmi, mm, khugepaged_scan.address);
+	for_each_vma(vmi, vma) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.35.1
