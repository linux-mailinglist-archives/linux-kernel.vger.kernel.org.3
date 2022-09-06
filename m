Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92B95AF4C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiIFTty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIFTt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E29C2DC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id90a024660;
        Tue, 6 Sep 2022 19:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1kNb/4PZSO1OENQH4kGsfc+HhKZTvRmam3cOhRQymGI=;
 b=JW0Y46thckma2oK/Mkt58X4oaxsmeDmOxfRjoQHIwwJbKHzrVK4rqdT5kBVDQzi4+I7c
 E1FVWAOMCqcM426gjLqTm3kGQH1HkotyFCbaP6UEHMbEGTQpt/BjvV+rJnrpoSnCWt/Q
 OG4XuOA/JBR3veMxnD11fCm3YGIM9cp0OR4aCUBWy/ZnBSaHyVFPj2uO9G5ueMjINYQI
 6HAekXFWTiAvQ7CLGg6J7RYDOn+HvSTzfDzf6LtugFHVrgpMj/nRuxP9XtSbotMIwWon
 M83dF6ykUCmXwxUM7qTIuu7aVhQazVMg0/KaIQDMdPn7vHnhU5YUVsFAu32IJY84K3ub Zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H8KXO023727;
        Tue, 6 Sep 2022 19:48:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kr9w-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P09A1TF1jdzf8iQA9xRmC/3cCTmun+zTgP39a2XVDLjjMQmcDFqJi075R3lY3t390+IOQXsJOz1zGvV+boFm9uxE6AAJi4Lgx1177Ldtr56knd3bgLFGcVNJSF6b+Om5kIQcIlAqsfQSIOHghIIUnhF0v8s9GM+VdSZEU8HPqT+0IgS8cAkqGpjcHL+AgwT1gmeiI0ZQ+GIG7yZBWTjFyPPDHgBWzVDei5jZjeXvLcr8409dqt3AMM2r5afEOJa7kovvBia0L9N6YyuHg/a/OBv8gQnvqnQem2c97uPjtewK+qH8wooekFQ0WEN8fJato0KVtdP12jL1O592xswjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kNb/4PZSO1OENQH4kGsfc+HhKZTvRmam3cOhRQymGI=;
 b=QGfA82rUqqYqwKflM1i5bgzeAbiOPHSLFIoRxy5E+Gzvn4aeftjSTaB71TBDZOxZZE67pA77Oi8cRQI/OlXLBU6K2CKSK/XZjH5FNFW0DuGi8a/ggJPUg7yGO4KNTIVuzWsLWewCe0h59jVN9gv8xgVyrGdddic52goRGSWk7fSzpO17m3sYtqtW5nbDWQNWSIXSl15e5zajFuzjny95JJI5IL1/MkkTxgi63nGoOTEJbLLWMmQqQEju42KO2K2YtjyFwPogyMN4IYx7Hi2WYQxXzsV9wc+rZ7sXBo27vZvwoZm/HDflUZNAQQt4nOPCZSE8b+80a/NR8/f3PcEtYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kNb/4PZSO1OENQH4kGsfc+HhKZTvRmam3cOhRQymGI=;
 b=VKvqhCumxj0kNzZfKmm9jyYoJnZK6DxKiORWwYZY6nPMBnltiB4SX+16RzWAzhzX5qFCa1B2Vf3keEr6ONTpkT0RR4VJ/CukTdemZk4ptVmIPn4Nc7Nun8PzbfpztyBLzzDxuaWGjTcurjMWUbTxloLDG62CQazpWCF6rWaWCLc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 13/70] mm/mmap: use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v14 13/70] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYwimtLbyER+H6PEKtTt7v4ylJSg==
Date:   Tue, 6 Sep 2022 19:48:47 +0000
Message-ID: <20220906194824.2110408-14-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2420fa9e-3717-4fa6-6491-08da9040d3d4
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+eJnihIb9a/hlL660LAqsP9z9gExhTz+lnWhNg81GOTgGKQZ9a7NDpxoh2Wt2HqMWZzXI8VicHSwrXZNsU0xXyzC7PJOeTNb+nkD6xeTDrZqEioKGgjb3ovANr8nGwWBKC3FXnwL66Mf8t/b6NNLcD4KrYfkJT7AFeBPAfsVe+HqEOqRVmzBzXbaSusuHYrhV7pnSiMZN/+ZUA3BywBYALQtcybRbQYyz/aq5Z+tcjs7Tae6X72wfnYI1EvBYoO+vhqoKutZ8A/FWxMHJESO0plgVMUHm7DyxYxbbDH4onBp0l8cyMFew9GTl97tKQHcIc0Drv+rklR4oJmzRoIjPln6CBWrnlqwmxrpqWkiPp+G03iuxpgegLugenRE4U3y48XeMbYbXkp29iPTAq7uX5KcveSh4oJCwY8hFD6Q4QTFFN1O44VKWzWWeiBiTLMAhat2vjEXafmuPYFb3x0phMVRJV9dlkZhN+mEkwgXiFjS+4H7gNld9YmXkfrLvK5aoN/ymT7fcu/kpvKz/x89m4fvNk9wKiebNn6+AV6m60Gtq2ZxyhiZoBDaJp8ilYW634zw2IC7z9ydXjaVmRF2zXElTlvgioUkoXIJHrPqf3oy0JzeiGijsH3uGiG3VXkRuSukgjt/cNBTqyTacoz+2bbueD/Mp/Rao+sUTWmfPzMUdVZn16MB5Lrgzx9m6Xzga5GNVZFKRCPCMQ0lZRNFN/HazhxaXI0rewfw6rhyAl8uY42D1ZXzj4OK5sDsPe3FwLEkXboVAxwyZlxm1vePw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(107886003)(86362001)(1076003)(110136005)(44832011)(71200400001)(6666004)(38070700005)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mUhIGx8VLSXbqCCeMBc8z+qFcGQeTaAUGDrLBgvXzrlJtYwjCxcaF/IAkU?=
 =?iso-8859-1?Q?tJGoJQMBp19ptnkT3dttVevpRXlBL8yUXHMF8EshEUxLZPteWLXBOIKTdD?=
 =?iso-8859-1?Q?g1vmuM8xK7V41LsdD7tGlIPsFYm76tQdKpH4pz8BLg8jRniUMGFsWcqaGO?=
 =?iso-8859-1?Q?LB5gheO+6a4fKvis3KdYhB8oetwlzq8xndCooCx+Ym6uJDQYTSSB+mcSAS?=
 =?iso-8859-1?Q?y4J0hIAg9HbckqDiRfBRDmSWp2p4VnvaEL2fcL2WxkxFvOE+1D2tSM+KSI?=
 =?iso-8859-1?Q?8TELH7tH8TRG16lE5tEwabP0QUXmnn/KT4VLgTjJANCLhW94nlclM0AMrq?=
 =?iso-8859-1?Q?e4qK9db+OEKM27K0xrNeTjEMqe1jyH4bqkd1h4E7wfDryjPT7OgXp5mCdk?=
 =?iso-8859-1?Q?lVB/JGqeYMAZn0gqgWnZF+QFHI/lofCsUjKcgDNKhs/P2aWysNFt1e1qXQ?=
 =?iso-8859-1?Q?t20E9AWhl5AwODV5Su4cwBybkRTq1brKTYHUJaQmAAkhctDkNvCliWUuEz?=
 =?iso-8859-1?Q?H8hiC0xv0Su93pkHZTRtTulwisP0x7i7mvk/ZD7lWQiDzZbvsQO+4R5w1u?=
 =?iso-8859-1?Q?GpX3CBAPiCTqlSTbg8iSm/71Ag2Hq5zGViOle+5ouS77jb1Y4tKu9eP65N?=
 =?iso-8859-1?Q?qkPrc3SakiJf6nmKFXZ3yp2e6H9MdlOSz9lBh6BsmyyOnM1icHH0tAwB0c?=
 =?iso-8859-1?Q?nJstjJF1GkLOMytMzCKqI4l8pImP+/MuL9FTVmtYjqRbxUn/q9NIq8C8vv?=
 =?iso-8859-1?Q?FaMqnI5ZxxNSiMXgVhNQPXjjWdJO+SvPia4QKf5Fi4O+WJ9VCPp8VEwjug?=
 =?iso-8859-1?Q?RIHBvZDac1pNklRA3xUwGTGB/NAqyeAPtTLft+pFWSsVASwChPJ16JpPL4?=
 =?iso-8859-1?Q?IclX1pN5e8nVDVoCcEjYceot76Wna+O8ECnaT6FVpknepPecEnjV/qxGy8?=
 =?iso-8859-1?Q?Brf/U5nQ2DyRjZdaEX+WxnqociP8WxVXjcKF7lA3IDobcxRQOBTENRuCD3?=
 =?iso-8859-1?Q?C5xhRsSpX4e7ZA2MMImfRIX03OS/rPiGOP6gJOZvCfLoiXoQQTySeYuogO?=
 =?iso-8859-1?Q?MhiNAdkATq1xyShrsWHhWJSAV09KsZSoXqZbUmgcIinpHanqgoXhAuKrY+?=
 =?iso-8859-1?Q?bCbwczdvmWWEEysi4+0MVL+VLTjHth2Xy7pmUxtqOoc0rPXaWbnYJruQt/?=
 =?iso-8859-1?Q?vYZHDikX3u/DxUPSzuRjasvrObuoL8invNXINPW8yH5qPpD+3o0pvU1x8b?=
 =?iso-8859-1?Q?jeQ5uAc7cS6M+A/ABi0LqracqBJ1edA5PyozVdSW5AHBuV2i+yW4N9zCJE?=
 =?iso-8859-1?Q?2QCAKXXfnK4wxPiyhJvPvqk1MPgC1POB/qnHo9d1xk7TJ7wAUiGyITKrWg?=
 =?iso-8859-1?Q?n1Bk5fKv3/AbQxltwpK00wNtNbtRoKPInWZpGiCjCQNkqRULjntXPiDVH2?=
 =?iso-8859-1?Q?ICiMrt8i14bhgOEKexmOXiu6RF49+iTPf+N1kEd5+ZXm0lstgFqdS/xYn2?=
 =?iso-8859-1?Q?KhRHslmYjYbeIakaLKueLCvi5sstQxieVceCqTgz8w3boPLRGJpYrTYrKD?=
 =?iso-8859-1?Q?GHx1bUZPBS0jcNXhsxU4NrwATlyU1AtIkY06DrQpEODM+zhXvsgqnOIUaD?=
 =?iso-8859-1?Q?E6XrrRLu+DIHbysCmH9mPetw2IxNTcB+pC9SPmE8+qv2jV0BVGbon1ow?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2420fa9e-3717-4fa6-6491-08da9040d3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:47.5694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pKLCE08GwEPd9l7c2mSzUnCTLWQRXkymuBW75WCrpbcM05hKObDzLXItzxy1hwzY/gCum22BFtH48D1d5HG+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: RpUFAyS5ejvRINjh3sv-00JbwTSFaO-3
X-Proofpoint-GUID: RpUFAyS5ejvRINjh3sv-00JbwTSFaO-3
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

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code.

Add kernel documentation comment for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 255 ++++++++----------------------------------------------
 1 file changed, 34 insertions(+), 221 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 948264cd39cd..68ee2958c0be 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2013,250 +2013,63 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/**
+ * unmapped_area() - Find an area between the low_limit and the high_limit=
 with
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
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
 		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
=20
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
-		return -ENOMEM;
-
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
+/**
+ * unmapped_area_topdown() - Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from @info. Note: current->mm is used for the search.
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
=20
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
-		pr_err("%s: %p Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %p (%p)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
-
-			while (dv) {
-				pr_err("vma %p %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
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
