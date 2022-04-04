Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0274F172A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351141AbiDDOjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377905AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A973F327
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dj3Y8024447;
        Mon, 4 Apr 2022 14:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=84hax6mvk9Md7wySU4X6RSgmc6vy9R60SxQyVlEFJ2A=;
 b=ttpfd9em1ngsW7bZYlb3IzQLqZfNIAknoOno0Hc+lGUm6ABGQfjl5B6Q8UyUIUH4j7SG
 aJogm2qcFUV/01yLHFsdAL7j4aQ2/nXxPYfXix6ttaghzwCkJlzOCSmk9msyceNkipT3
 SOR7goaWpC5akLpxrPRC47gnM6+QuqAlf3tMgYZME0AVrcRlgFNEePc1LlDpGRwTMgV/
 ewWEJDGsHE2LpVPXlvUcKMNu0/Zr14fs4HKajXW6QDlERIZ7D7zCnREuMgN0f62f4TFz
 YdFvMtJjKCas/FaaPN4TlTatCx3VySXs2gTRNUyvuhDJYGaind5ILK1Jam1cnOki+2HW ZA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGQE3028988;
        Mon, 4 Apr 2022 14:35:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c8h2-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQKf/uY0FJsn2csMse8gVbVv6pW7zTrczAHHmNzsz5Ic58igEQHwMEyfcJOg3gkOsTobMs1XTRFuBPHR9mVl3DqB73QotA9GwD/s4QApbwODqUmCzh0Vos2ZOvSCHhZ3jJW5QhZkDVuiCOLWJzCkJjli1s91FbEvzHy4fVfJ2zk5Ks6J3AECvV9IUdhAj0Cv7eIwv8BxxLk4fVEQNWx1vnvPQWgwcE4taN0lMrRKghmFki31as0Rxmlu21mf8iQDKypTn2sqh55MXsbz1x00F6Uzki2Y4cbvaOV//0+3TtQW4flBvJjnbJ7b0iDCjjr+3FyPQrEN0OQWrJtd5eGqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84hax6mvk9Md7wySU4X6RSgmc6vy9R60SxQyVlEFJ2A=;
 b=jGD0h/iVb3M2Fajs6KKoxR0DUibvZ+UJi74N31CSg/E1aYQarxmV1RBSLd1KmKbr/Xrq15ad0U3ZEDHezkO/A8T0px1VwCukFDbPgL8c+D6E1ps7QlC+oC2uuoqPZgKHkvf0rHRz/pNb1lOo5MlMH3674yvIiM0QN8dMpiOLlvLKHHNQq8Idwvzd6ArgWf/+tsbAP0ZlticHqKno0wVtIWQYNIm7Xt0Euch6OiFeQ+2eCl76rJoAFE+3yIaee8z8sGJRFbHWrMcgkIlPXBnjEj7pet9DovKAbZprbrbB+1nuSx9v3of6zDnSzROJdzYPN7NEpFwQehkXqIpuJtsEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84hax6mvk9Md7wySU4X6RSgmc6vy9R60SxQyVlEFJ2A=;
 b=LuX8X7sWSecLETkZiZElENi0IjMdqxauLZ8X6WCnHTac4YjZ4tjFXxz1V9VK04zjPXrXFOWoDL9SO60apOHImMKYgd8OkfFLsopatIg563hLUFJ5N8CcLugy93loNL+7YXaP6fxIKCrirCTnYDQhDCEIhx17zv0xyrXUZ5xV1DQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 23/70] mm/khugepaged: Optimize collapse_pte_mapped_thp() by
 using vma_lookup()
Thread-Topic: [PATCH v7 23/70] mm/khugepaged: Optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHYSDFCY4Rchysn4UiP5Wn66Nyo6w==
Date:   Mon, 4 Apr 2022 14:35:42 +0000
Message-ID: <20220404143501.2016403-24-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e596867-3227-4ec2-e772-08da16486763
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812A2BC66AEE8B81CFA6AD4FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hiFctBNh6cOJCW6tWFce0PgHAWGt0KSZgu4L3Sa50SAtNmRzbxDzmH2poOGNZTbFb9lRrDCMfnkevv71XJQUlYMw65bx8q6qUFnZ8cJdPm2z10Tca9RoBhg65TMDjJp/W14GB5ZJ1daBmg3mB1xAP9NmNJ/8/Z5bNJ1JtP+fpR298Di5FKIXIws+uYjOd95QPheZOSBfWTeh9+6gY/EPsMGyHxchz79jQWRyCz81Yxpu8VFJRjLLNT/z9iN0RPF24PYtN/k+2RTce0/xJqDcAPViq3f1Q9PHakQrVfkqAdz+DwPUzLM93oj2h97lQIzo7FVC117VPk5z/hDg2fgXHNoJqQcJOBJXq6AXhA2awjb0Ayay/ieW/GlbGsbSNPB41K5/G43zY4cd4zxCo8AMgwT+rZtGbO4I+Bavw5nuyGbV2nq4Kl2XmMjL87le16Hs5I5jvlk71J4sBJXRc4sCcMD34WHLCMltQbah5Jk2nqABF6s/XwgqeIEpeLEVmqEHb7YTUuqDorCbDGcLdDsWVj6jEoQEpXDn/UwAAc53vHnbHIDoGUdINNi1lmj0JqeKUJBLXk3r6hobq/g12dPaguDJgDBDBOMgTvAalvoMZ1mE61ECqUMJH0XU2++5WlH58/LzJJUuTKv3wA4qKLQmJvFl61gC3qyRwIs9NgauUXWRz7Ima/sm/bpQlu6TjD6Jdnc2Jfd+rfrEFrKu/2Ze3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(4744005)(6486002)(8936002)(1076003)(44832011)(83380400001)(6666004)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hNmeu9kZIwWkbfnQoHpuCmzc7b4PfhH8O76T8a+nIjszIwEjmtgliGGPxr?=
 =?iso-8859-1?Q?6ibFhBCoJcE61X9w8NZk4PBbriMmhgCbaRP61rPrD2YUTJLcUtyIrfjkie?=
 =?iso-8859-1?Q?AW3x2OrMm9wOITAguod0cWzeLV1BSFtQYvWtsM3DoGvsUeMgJP6iZI+1KU?=
 =?iso-8859-1?Q?HKhw5B3Y7hiiaoBGEEIU1XXZ+Wm982aDhWDA2p+MKFu9B9p5miz6unLji9?=
 =?iso-8859-1?Q?CkkY1cSFYbq21ZFlxsDFNIZD+OBWt8vMJVsm2vQM1uIu3BSg/w0gfUA2LN?=
 =?iso-8859-1?Q?64tJRHkTsKEJWFRaCAxPPc8wXpeumt3hhvUdHyKR/jGNi+P43NUc2OwCC3?=
 =?iso-8859-1?Q?B6c7QuLfgHCSTRr1TPGEIxyMzBep4+7t7esErtU+7EgRW0z1b2htonLVxF?=
 =?iso-8859-1?Q?0r/1gSD1z4/W385HKPkSGiqFasxZC2wqatddETVfhbcibVgD7JbPnuycZ6?=
 =?iso-8859-1?Q?bIsrlg4lWRWC8t63sBJc2ChQKWk6qssKKGonn3P7mHW/64rUjiZtkiQ/XI?=
 =?iso-8859-1?Q?wLAZcGzL1l95FiXc4TlcGIRz4eaDkK/BWe5KNPgsRWkNPSsLUjgWcbnbg0?=
 =?iso-8859-1?Q?SBcMSy6HWhwt3uKW36pbDz3nUBB0SckmLtEz9qhqGI0iTH+19R0YceP1bb?=
 =?iso-8859-1?Q?pyDILfm3uWbc46HiGCGKXgNmM/PD/0J+qlJKTAvK7x7UHgxaII8jRKHwwa?=
 =?iso-8859-1?Q?LSJKdpm3gzryz7ZibmR3AdlbJlzD8G1iOzGgYHyO5YNcx8ZnVp235lBJm3?=
 =?iso-8859-1?Q?nHA99GEWq09yjsiMWtFEkB4CSTUJruL9W5JxZGcVixCJ7sEbwipL09MaCa?=
 =?iso-8859-1?Q?PECDR6PUCqSWW2uJ6JuNCzRs8RE9ykIiNR3llM9FABk81kEPcIYDGzmYIF?=
 =?iso-8859-1?Q?+GDEi3ug09rCak7lFfwqb/IPBlMjgRyehN3VNlptwC40nPzeJNhR/Safie?=
 =?iso-8859-1?Q?gXoaDpCpOANfBA7YbfRAf51HG/x56CevixLcFqRBfcmg+jAlMIW8ORhJNX?=
 =?iso-8859-1?Q?laDNFwnZpeTU5jI9FnptE1plOnxvj8MX1kzk2d4RA9uRcX/D/V/nMXI7bP?=
 =?iso-8859-1?Q?m5PowTKKc31FyYp9v4896IWKSnUQDJJPi5YVBhr3Ia4dDBaDqXzcaswVp/?=
 =?iso-8859-1?Q?2STncEA6SERxhICFxBNx0ckfcd4hsBHwm1ppFAmSjn2+3lmKn3f++Ols9Q?=
 =?iso-8859-1?Q?uYr2Y5455vqYPUF+gl7wnRNvk98EBlj9UVeGDrlC+DVOaOgtb/cQt1YDFk?=
 =?iso-8859-1?Q?TpEDiAQLrB7G7hVfLFdgLSJ5RMFCt6utlwF4VsrQ1QAFrZ40XfNoTq1wm2?=
 =?iso-8859-1?Q?a59Of1+ydbOokDhB6HVMWgMtIhoSvTFrXUSeSlEVFzOtTZZAyUciR0xvzP?=
 =?iso-8859-1?Q?57YfcaMO+PrK4IvkPs3wuF6NcKteCmb9eIo2hiqJYzvzLvdiV0Gjp/MNpR?=
 =?iso-8859-1?Q?UY9MSpcPvdBSCCxYaal4kVmxHJFLXAhJesw5kOJ234hYfh6MmKeGoLIASF?=
 =?iso-8859-1?Q?RZ+hU8S+7UEO10ICc/thLgbwT3EU1dQBlKWtEOZnWMDU7/ngxCVNTdLMg9?=
 =?iso-8859-1?Q?D3v4SRHVHBn6NCEi3sLlHAZ7bDpWxyuG+ex1T+PCerF2TPGxnHCkVS0ceU?=
 =?iso-8859-1?Q?rleIu2ZWS8BKyMkpy/nQJAUpNA5zS7u4Lk+sdE4xVTskgWkh96lepjv1Tz?=
 =?iso-8859-1?Q?lBrRNnqVR3g/b0+mKytnrqkITb3+hMN8F1SQZiew+G0dJCABY+PKCPv6gJ?=
 =?iso-8859-1?Q?U9OCPy2JX2khUUxq/yscLNDxiry5lyc2HYWKVqyI8X4dfuYz5o3Clu9MN4?=
 =?iso-8859-1?Q?1ZTfrQTSIGhQVBUExVcSXLixsdqiqQY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e596867-3227-4ec2-e772-08da16486763
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:42.1124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQL2Z8/79rGZCevjgfICCQ92/23oQwsptP2bAv9XQZOqlDa/Qo6MBeFQ5CkFn3pdT8xorQYKWRgN+7gLaLwNIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=852
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: voIpbhXiT4PVhOkfhPTsJM0T3yyWInra
X-Proofpoint-GUID: voIpbhXiT4PVhOkfhPTsJM0T3yyWInra
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() will walk the vma tree once and not continue to look for
the next vma.  Since the exact vma is checked below, this is a more
optimal way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a4e5eaf3eb01..d0c39b4a78fd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1435,7 +1435,7 @@ static void collapse_and_free_pmd(struct mm_struct *m=
m, struct vm_area_struct *v
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd;
--=20
2.34.1
