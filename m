Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35B751018A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352204AbiDZPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352090AbiDZPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BEF158F8F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxDE011324;
        Tue, 26 Apr 2022 15:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FwD8a1o6nwEO01Vins4B+QxL+ZppCReDL0bbuP2AzS4=;
 b=P27Vqx+Fl/kIWIy4q+RiKpDaiFhX6Sjy8mtmH8C57XZgx03bvTwwAVrfNIsYno4i5K97
 YwB43R/apZQwhpPxKr9JVg8lF8SITYeLu5xOrYdm2CsrrySnxO50xjA2arMQRllDSbIR
 HHkgSJJseYAVN4IUTTYBLypwsxm5VJur7luyu9Hom7XBHDSF8+YScR91BwzwioxZ4s3f
 UR1VJu8C+nlH+LA/PHtSp9/eCau8uAWioows7nVriDGLibV/pPl692hS8WmenqVrQioE
 Gxrzkoy+w7chxKXOETKFMxXuWkQhwOa8aJ1ykqSIu7E3hcaW8zTEDti/vxzyDNqjveRM cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4ef8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6USb037884;
        Tue, 26 Apr 2022 15:07:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkuq9-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwSFqiyfukH7lx8kGV/ZpechV/Mc8MC3Lo5wxfmrDewjUEWgPBRyXx1hP7qWA0WfOYYSb+6MqKxrds1QykPoApdOCE/6mcq/t4N4NKzIxR4umToYAKsHVJsLh19n8ZDyUhPGpmyH0wgmu3H7uS7EeuRaZudYYj/xvyMOlmwT/2Ng7Qco7kFzMurgI6sF0m0mEqKuFqR752+aaU94tAtEX6UjzpEM9gVG/8+W5gnoRX9akrBlYk2sm0d0jH9ksIdyCMhZhPPqWipoyv9N9sFJKwUly3EakpxrW02wbsrwRPSEdKxFQXwt+axe4BzY2Bif7zHUsnSDDPDULNFdygGXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwD8a1o6nwEO01Vins4B+QxL+ZppCReDL0bbuP2AzS4=;
 b=NveX/B5sB10/iOtkg8TOd95l/G7e4uEBYRVnvOGJ+mBQR9ncDOro0gZrvr9020XdaCIKpmBnkthXvH8RhFv70l85zvHccmVwGrrt+Bc1FZ/yI0pCiWhKkksCZG7U/bEg1O5wD3tEqA9fzIuJ7eGa41BlG6npb5kai85p+3hnM4XxDA2gcmsz5tgwGWT3K8OE3o/QwJjRGMcbnkWGBD5ojfld3ALMdnHwpnharxRN8WuC9z5PoAUyZiL1qWwebAzMOzfsBUvAejkIH0ecEYfg28CJeGQIqIUl2RK0RlLuRolgf4ilfsTduhEAGuR/2v920BQCZD2N/MkPIfIfIgteEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwD8a1o6nwEO01Vins4B+QxL+ZppCReDL0bbuP2AzS4=;
 b=gcjCjMCY/A9BuKDvdC3k7qDlBOdNqDdDT0c78RlQxq7/hjDYacpo9ACyKcgItCDJRWxu1NG+AQGz3TdE2v8LW5+KvSfpSYXRwqzuoXFaRYHFZ2TaVOOLHO+BCSDzT/hGtlSXOipq5hs0e8xLJk8SkExsVbNkBJbdmyGUHw6f380=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:07:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 58/70] mm/mlock: use vma iterator and instead of vma linked
 list
Thread-Topic: [PATCH v8 58/70] mm/mlock: use vma iterator and instead of vma
 linked list
Thread-Index: AQHYWX9BzRB7r/YYCUCDKD1qzZvhgw==
Date:   Tue, 26 Apr 2022 15:06:49 +0000
Message-ID: <20220426150616.3937571-59-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ff8cd64-d0e4-4fcb-52bf-08da27967ddd
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2377A5A5AF2A3C39CD529826FDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9k9VsCRN6i+iLRajmDcquncn4Cf/jsKYB466qJ7LBIVnyLMIuvUwGfcXMbF6m5Ti7lEo9plmL9qtKP9I+OH0x74qmmDkdiy+8Ql9dai5z+4U4B7evckEYnn2OaEw/amvBGa7HF7e1AwTCR0vgXF4ch672aGks9qi11tjPuTT5G/buSsV3VE34snXf0zL14lqd2tdqvyVWu8YQpxB/pAZl0rFaCajcyORHuUaodOGJfqAJzbelZFjfEi1dAmL7phukKAIoSZ8nblmVE9H1PnnCYp/rufk9dFIMnUKsMVKXpcbBYlP4jv3NBHlrTLuJPH1Sak1tJ6pSJX7KF2st8zuT8R3r9GS+wLJehu0+FiohiQVq23RUCna2+0F6/MGO9HqkNMrsKLjauhbrApsOoWOjzALeak8fyzOIfqkMrqaq/MR4RBiTEJmqOc8cO8Cp+m098f78+nEG09ABqJaNcCPQvyRewMo62SjM9lb+aa/CC7v0R31PK+k9iKHTUiIH43ZXwY9LxFTNKvW2E1XYChb4lUN+EtnXSzZK11EV8HdtyHDNTWaalowY05wArn9REynsvwJS6WNl+30oiQPqQ5wVHhFYz9aqBKO1aeCVwKtEJaQWLDmB3hqsjU3chpIBId/qLm3mj5R8/MMywNW6AgFk/cSB7kigrSxqYY15akFUDqriV0z4Db7HkXTEYAM8JnK1ta8vNWttjYwsv4woJC4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/ZNVC6pjoV1OsNisDrgIDE2bl71ez+TWxUXjDR65Th5ewWJp02dp4UgxXF?=
 =?iso-8859-1?Q?u9oVHc7CUxeIS6zDhDiBsNZgAqoWZdBIYK1lzgBLDpdm81NpFb/YO2y142?=
 =?iso-8859-1?Q?B9PggihJpIA0m4Z1Cvar6qhjm4EBTEme32y4YZS5Ro1nCOccH4TvBwAUEp?=
 =?iso-8859-1?Q?LQGXVew4Y3b0srumglhESyhz5V7NkEFqwvWvPTIWUOqO+hBJ12d0C3nhIW?=
 =?iso-8859-1?Q?aQKcTyXWq7yZOIOpRaxp6XWlsv41mk8e5A6cwYzrFOq6bI2Lxk3a1ukS/c?=
 =?iso-8859-1?Q?ePtUENJ9mAEYngkiVPcSu6QKA5MbAD8GWa283DShjMdl3Xv9pxAuUQWDlw?=
 =?iso-8859-1?Q?ctzM8NxvaGxZf/h68XXhl2YY42mNXwMBbAUGdwmhIFd9Fce3pykM9nxOgO?=
 =?iso-8859-1?Q?ny20ec4C47X+L6aqaLiRXu+zajXhC3GCJiCktKkXrdnN/As81dqWs1Er3E?=
 =?iso-8859-1?Q?44chbs3yI/aI6x+F8m1LVMdY1ugFjjRsDeXJ3Py5XEVnw8zjd0nlo5a1qI?=
 =?iso-8859-1?Q?bXxigK1FsMqtMEKdPpqZHLbtHatWWnuYPau7GnVSuFOUiCo8UcR+Dz5aLs?=
 =?iso-8859-1?Q?oZ+2eWgZflJv9bew8JI0TU+KXb1AkD7htKw5+qxe6YpfyKCTYoeYmYaXh5?=
 =?iso-8859-1?Q?xL4ZLn7PnbB5BZ+POCTEobPxV3Nnqmh5NSdZxcUNWkNvY4h2DxM4nwQe9X?=
 =?iso-8859-1?Q?a6qPZ9KISLMNWi5KMPr5N5frLN0/pstz/mPunD3YK7GpbDL5WtgneyuBi1?=
 =?iso-8859-1?Q?NpozqueKkxpTRR4xZ4nIOcBzLSVbgR3FwjnLBNOjvTXasFTbMOqYDfyKF7?=
 =?iso-8859-1?Q?9Wjhl/Kdk97QfSQdK/yNBtwEFacnr2Lig7xqG9sd7lE5jXIgbShHNyyd1M?=
 =?iso-8859-1?Q?Hhr4LbrC3uAL5WjwNV58tTUojycaXnl//i4Y7F1TAabv+dAEEB6WG5JuqN?=
 =?iso-8859-1?Q?V2nXU2cNWOpNNJ+QTqf2AfbTCHhypZCGzOHkBu0ZiqFSQabWr6HW8WB5h3?=
 =?iso-8859-1?Q?KCM1qKlN/zbPLtpmJZUZ8jH6CiY2pZFyfA0M09t8Iap0jW3w+SfB1qReCm?=
 =?iso-8859-1?Q?RkwPRqqMiONgCN5vJAd+19EEPhcteQYKEQ3rUbXicBgSXAs1NKM+J2Yc6S?=
 =?iso-8859-1?Q?mW5C12z0P0/TuStFXy3G4ApB9jBP1EZqvt2JDf5cfwHSKAD9uQgTrNvGVf?=
 =?iso-8859-1?Q?2vC0Xbzj81EoBIVZVayyvU26hKczsQuUXxOvl7aTObESCfHtBkyaYUblfl?=
 =?iso-8859-1?Q?gl6Zzs3nb3oMtAsNYZ5Yl6g0zyNu/pZZg6iw9XJ9HMBPB2ljZz/sgqrS1Y?=
 =?iso-8859-1?Q?Yfrn538olkEUMymJ65Lu5sIWDSaCkjKkoRk2QRtHER0N3ZfB2VqRnaEG8P?=
 =?iso-8859-1?Q?ASMJ3KdersHSjKp4AgN8Hqfaer7uSPYq44Gi3AyH3BmRwSojyEIA3RGgGX?=
 =?iso-8859-1?Q?1ceyKw1E94E8JEdKKNvRPrizYjNQfkBM9CFcfEPYe8nIDE9l+I0JqTDZ6S?=
 =?iso-8859-1?Q?NvCFkngUHEaI1CYN4plygmpz3/RIIBgqdvrV3+xp18W4nKVlKrbqOfUhfA?=
 =?iso-8859-1?Q?e2mF64MqdHSszSvlLLOvIrIECwTG0E/XabCdUFeuhd4p+fq1aXRPkwfRMb?=
 =?iso-8859-1?Q?4DkDRrIJfxDBhvnR76v9ypWsWCIqqPwUEVERdkWBjlcLPMscc82vlFy3N2?=
 =?iso-8859-1?Q?nuUKYvHHK8p1nFY3HlIyhuZZyaV1vIv0QQUpSpadQGI5uOX/NCQ5+thnDb?=
 =?iso-8859-1?Q?bAKYnQttoreHryPd8IdJsWPIvbVYYG8xwhVu6kVL8L2iZZT4a7GilcMGjf?=
 =?iso-8859-1?Q?YfmuaKv1o/NeC0hIkiu8KhQ7QwxPXdU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff8cd64-d0e4-4fcb-52bf-08da27967ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:49.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeyM8UZzarTfQoc60gQIgyXOHtHuqLJxbVqc7XfD38EQePYadicaPwBdTS3hmA9l30S4WsJQ61lLesV2h6cP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: gsMFwA4iEP_Wzz9U1Gy9u02VsIUOf6zT
X-Proofpoint-ORIG-GUID: gsMFwA4iEP_Wzz9U1Gy9u02VsIUOf6zT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Handle overflow checking in count_mm_mlocked_page_nr() differently.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mlock.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 716caf851043..d8549b3dcb59 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -471,6 +471,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -479,13 +480,14 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
 	if (start > vma->vm_start)
 		prev =3D vma;
+	else
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -505,7 +507,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(prev->vm_mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -526,24 +528,23 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	unsigned long end;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
-		if (start >=3D vma->vm_end)
-			continue;
-		if (start + len <=3D  vma->vm_start)
-			break;
+	/* Don't overflow past ULONG_MAX */
+	if (unlikely(ULONG_MAX - len < start))
+		end =3D ULONG_MAX;
+	else
+		end =3D start + len;
+	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_flags & VM_LOCKED) {
 			if (start > vma->vm_start)
 				count -=3D (start - vma->vm_start);
-			if (start + len < vma->vm_end) {
-				count +=3D start + len - vma->vm_start;
+			if (end < vma->vm_end) {
+				count +=3D end - vma->vm_start;
 				break;
 			}
 			count +=3D vma->vm_end - vma->vm_start;
@@ -659,6 +660,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
+	VMA_ITERATOR(vmi, current->mm, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -679,7 +681,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	for_each_vma(vmi, vma) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
--=20
2.35.1
