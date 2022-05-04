Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87B51934C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiEDBTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245084AbiEDBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9143495
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LNHVB032436;
        Wed, 4 May 2022 01:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WJKkltNtV8GzaLTuCKaT9alazXtwdBT0TYx4uDuGVzw=;
 b=phhyfenfxxYFGEwlyJuZHHO34JLsgvXZQAw8pZM5ExEX2hz8ZgMastGzEan1u3DYx/tn
 kFdwRhNG7GyVBzTmwU6kxALzXLwX0398bBYWEd3t0k5TXI6XlpiT7wsqPcrfjEW5fHqN
 V61xwEs43sIwjlhAswqV5qZibSyWabBpdqR3uoq9Pab6mA8F9pSqj8bnpLnhh0CE9MIs
 AKGmvs4WJA09jhuggBZisvP2VBO93NdhZ8R5XC+Q6HFMx7oIyEhJbUXqzW3pHBAkQBCD
 hi6qcOGUGpofREFhwo1+kTxv759h8Lwtijf1pUGwJ043ixElSO8dc4L3RBhPTfRU/LHq lA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apy07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441Ato8020100;
        Wed, 4 May 2022 01:14:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922he-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmEYZ10zHg/vEanCeme/cnospLfNUqQkSFMF4rKbRgG7d9WLdR6Jv+wDmyUJgbphfo03AVNL6Oh14uop6owkKm+z44inWLxiHHZPBlGQGWK8YBuwTeQVB3ty7aa55Jw2ANnaaQQHERZMXf9Q6eYEFNyti83hEIwYt2NHfmIpDraqhlHzUybchWpWOt5hwFFg0lvhAEYSrD8l4EUlnZzaLNtgLJQRgOmwcY7wkqkvgiMTEwi6+bGsgmV7G+Sqlc8s61dpX3ncISDnpraqT27ZGwlftCbk2GsqyphsxWgsI2Ki0L74PUVba7iEvqbbvjNZHjKO1LSfGYT1/3VTsDrBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJKkltNtV8GzaLTuCKaT9alazXtwdBT0TYx4uDuGVzw=;
 b=V22LsbxEpVOYCVBE1kMNqmDySYnKW0oCxZfU8r7XxAagfrmrmEQ8ElMkBePhr6DRlYO1fkvXArJzhAYUdwOwcOHzbnUOZf7WrG0m4gRIt93b6hD+kIvn9sPb9hzJ9IIQNaQcxp+BSQm9kwUxdaropWRtKYR1pX4LyZY7gVrp8oZa7GpN7eJSKbgPROrnjFeP6v83758JhTWTefICQELO/BltNk1XW+KakUpW15cdgm1Wq8Djjm9ArZRGdTUJyfGmEUHunu5B3NwmTs/Aum13IFBI6VpFhf1368XW4Ysvo6uMYyFTZQZiiVYdgoYdMtvRYwKmpl89RzkB7RClXG1Aiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJKkltNtV8GzaLTuCKaT9alazXtwdBT0TYx4uDuGVzw=;
 b=jt93NzyfiUoPoLeMSucbuIXXPztAyJm3yby11upGTNfHAexCN+tvFAOmsikFmLJlUAnWoqWwG24NRrVtVPJlOxemtQYp5WwUjm5Gt3qQDnQUPe2Qjq1bHKQXHPzDZ2m3vWELUsoBwT3abYCTa+hwrx5FZg1jn9bOewf4aGmltlU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:13:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 35/69] x86: remove vma linked list walks
Thread-Topic: [PATCH v9 35/69] x86: remove vma linked list walks
Thread-Index: AQHYX1Q6K/lI3nXkSkKPE0shCovy0g==
Date:   Wed, 4 May 2022 01:13:56 +0000
Message-ID: <20220504011345.662299-20-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 635a6839-58f8-4a71-a572-08da2d6b5d9b
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3728957AFE44AF8FCDE13395FDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CmN90IUQ21TSPl6VadPY3HW0K+5bYAJnt6k9Sfm9tZq8J8GkB+b++MCLHqLrVkp5ZWFLcoNgzXMJ6zGlO/sJf8agXcp3Y1XUj22FV7gTYckO5UH20Rx3vqRTZcRYRkQVhseOPPF4nMGxVFMWvo6GyrnsFziJpAyS/yU7BNahN0UtGS7vhqt/I/6G86IRxYAY/GU8Rj4M8xY4fZXUKx3UYGVMzqDnnO8jpCmB9zOY55qoxS9yU07mQIbdCooD7flhPFgOdvUKnYwOIzoUoPhj6xHpDCiHZkrvwEZTnSAOcNgznvvd91YvaMLz7Av6NRQbH6tVFMRgkAwe124UskVcq0pudqBq3QY5ErHT5ArqpP3lJOotkVyzoOdJ7D+RKstS3My9r4oQorHDz+tGBxyl1dw231KtN3oEj4eq84rr6G5D71YFaIxwJXJSBY14iiR6ZjxAYDhNb3j1sXJTFaACVVkPVHoSgSNzhb51oWN9+0OD2PwfhDZVJR40nkGVI6TrNyYP/9MIPrDTTSXul3R2x7FwwiB0y8s0qQdWaNHEUgZtPAIM8withBtqJbZYs5ydLp/7ye4eNhShqxdGcqwMGDGDJeU90lfMVLEMe70l2K2jzib5PFf8mzXmmcvv6BMnUsdiFt1LJRrO8F2Ey2bxnXEedlGiAY5WV1UAgqqsI6i6CtfR/7w6fLLq6sXVrUj+PoIhSROyvDJcuvJBozglXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bWZQMSi1A6Gtypvoxz/5y6byl4AiZ+RZ7tdwzGNW8cRRvJIcQiLB0E7Bmj?=
 =?iso-8859-1?Q?rTw/NOklUYJC2Qf6m8JU8NxbZjK+nu7IsqeTDqxJTdyQTZK3+fve3n4vtc?=
 =?iso-8859-1?Q?ZSaAqF6HS66cSOyMrmJY4aWFYz0RmwQ5PkemsM/+l1C3W+RDTa1OCfNBSX?=
 =?iso-8859-1?Q?hA4fueBr3rZwujMo8v7HHW/bicBBPJT724QgmuQw8J8PHh4aPkcg2n4ytf?=
 =?iso-8859-1?Q?2oHdgAtxeWYSCr5+BQuJL5l+93Zk+dP6kDl8yI9qO0C0mr76MkbQeifcuh?=
 =?iso-8859-1?Q?e8Cx0/Pg6upaLHYV2Wc1ohCLsnxDci0rY9EZv3nAf2mOtw0dkCaJpudBKP?=
 =?iso-8859-1?Q?wPgwuY/KDoNqGkqAOwJT85k9lzybQNQEwe3iFjzyCg+hLK7E9BxbvDf+9Q?=
 =?iso-8859-1?Q?z6DcyiJ9WpsDDjozq4PlF3W5KtCj6cJg7PdFi6vc0ZKOqibsFSAD1Ow1p5?=
 =?iso-8859-1?Q?aUTBSWHww81mBGcxDN/w7Oed8owKcAuHvWNE6r/Y1YDncMjLnKAYVL5DVf?=
 =?iso-8859-1?Q?1jgyVZWTqC5KnxxXXa6P5CwIG3Fn2YaBM6DI+4ET7rV173+Lvay860DsjN?=
 =?iso-8859-1?Q?1b/8ODB01kHoACOZn0zP/Dt9R7GrQ2VWzrEsm4HlTp1jKD5JMj7LOSCG9Q?=
 =?iso-8859-1?Q?FvMU+ZwXYlVYWGniiPEUE4ec7Sin6fOjyCK9z8fO05FVVadZLsuQFjlWlw?=
 =?iso-8859-1?Q?i7/MF2LsXqRDpUL8TlfcTnziTAvQ+QVZa+J1HOztb9Bq/A5iq/1msJVows?=
 =?iso-8859-1?Q?l4TJBvPXq6vo4NRqcA5OqUXMQ4luL/HYoS7fWaanKirbI7oneYdfcpxcOb?=
 =?iso-8859-1?Q?0nBsYkADp8fYrWhna65PRAkdvJV/OrSoVja4k4IDIf2Za0S/hrAaFYpIOB?=
 =?iso-8859-1?Q?6blHGsazkmMi8sEB1hMxKN/4aFG8/HQRelKsEJJpG/v0UlMzIrjFQts7qG?=
 =?iso-8859-1?Q?GS4xGzH1T0nzeotWPleHqavzu/xHs45YUNXGbXHW34hoTPIV+cFa4VHuGg?=
 =?iso-8859-1?Q?BLDdbuT/xR1Ji79S97lX0THsg8KSRR56B5J9kR5PiMPyhs81ACdb7bCYgh?=
 =?iso-8859-1?Q?7pDMrO2acEa/JSbnpGSWgsacDbQt5EhHETRSPCjZ5CWli2QOIP/ERR78MB?=
 =?iso-8859-1?Q?FeoxHug8/9zZeM8waEBC5hXWqV9PFcMRK+nhHanzyqzr9NN2bMR+Mmy+IW?=
 =?iso-8859-1?Q?j2ldqqKjMuyTAoPUxnwqi+rCjhkI3ZL3Vc54EBDsZkl5PjIzP5hfItMuV0?=
 =?iso-8859-1?Q?lWf43llkQctrbx/k5ddvE0J/Fi9TQMpXfwf/XP9S9voeen9VWU6tArArTB?=
 =?iso-8859-1?Q?Kn5PSvdDCRymfjxrEtNz+G67VKfHWQZvv2zTc18IcqDSCvHivroDzwTDPU?=
 =?iso-8859-1?Q?NEAUD7bnqFodzGfpjEt0zxGaOMMRTGx1u1Cfuc8mevy5n2ddg3Hdu0rz1T?=
 =?iso-8859-1?Q?rKteiJOxHy3yjZzUwQ9lErKvJVwzYZTzvGeNCLxoQtcAEHdqM373zM+1rp?=
 =?iso-8859-1?Q?DvkPcpz5tGc8PCY4pKVx/K8DJGBoOFWUgANP77NdBFeWGz2EXJr2mvPE2X?=
 =?iso-8859-1?Q?NIXMJ+eE8y24ICJCqph5DkRLSeo9Tbi5tMMDQRjWCREE8XKdVT4fb5rIHt?=
 =?iso-8859-1?Q?GBtxws6we/Cq3IyXvthHSMSljtepM2aKAipvaF7baahe1oBJTdb4m/DVKz?=
 =?iso-8859-1?Q?GhQbZT7jMLtD4ZjGEl3ENzbKPa49s3T8A5wpFjcCX3XgUvxtFnls2nCJ5s?=
 =?iso-8859-1?Q?TqUTccJ5rDKJq34gqXdQAYStAY/lQjhc+RMjprkhXdfJeFpBcr8DkwIp8T?=
 =?iso-8859-1?Q?9cuia8vNlzzsV2G5YIjJjfWtFkiaroM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635a6839-58f8-4a71-a572-08da2d6b5d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:56.3298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/WRgpDOOq67D/lbIZDVh3drXqgx04Co3KUmnrgjwpl8sSBKB48lthLms1f/LMMjTsyNZ4k8YsGElgqX8YnU0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: Ach_sudxJLWpCdwCjsro7n_ZnLKwXTAY
X-Proofpoint-ORIG-GUID: Ach_sudxJLWpCdwCjsro7n_ZnLKwXTAY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/x86/entry/vdso/vma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 235a5794296a..3883da001c62 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -127,17 +127,17 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_mapping))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
 #else
@@ -354,6 +354,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
 	/*
@@ -363,7 +364,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
 	 */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
 			mmap_write_unlock(mm);
--=20
2.35.1
