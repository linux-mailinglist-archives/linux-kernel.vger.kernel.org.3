Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4464F1737
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357941AbiDDOkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377975AbiDDOjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E53F8AC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dk3Ns014690;
        Mon, 4 Apr 2022 14:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MmGflBQkJQ09wytC2Zwalav3W8P+NhN/2lNqTYtMJv8=;
 b=b8XxoEr7Oj9vU1x/5fuPC+8wdG1HVNHvrdj9h60/alo3BIIr/wwkIuyz6u65ZdayBycU
 fAywPWoFe2vboayIre8MJyf6XIIChogYXOcG1FyugJUusRaGLsodsAtDzm9VJNb+UDnz
 JDkx0z/0+eQ1DbboVW5CYoNm1aOVF6SroWkSI+STsk2RAEovqQO8u40mwVMymRkXT5pG
 zbScdlmzsnSrgjRTp/pdqa0rBZK37rtiPtLheXP3u4vDSU5lqySpn3L3+pEic1Gks3Y/
 YY1c4LVpFU6aFib60Nnrqw1miNO5spXB5E8JDMjQsdAbHAgzvjlNWOK/WBULg1qyXhU8 HQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcGD027665;
        Mon, 4 Apr 2022 14:36:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJIV7cSZhX09efVVhwO76p3f46ddkbueW23syli/OyqO9BCpri8GN/LjdDyEvU0gnrMfemE4CKDoS+Z5k2MDH76omyTcuLIgAT7yUv9rGfG9+QLqvAawdhpiVf+2AFEvM31+ZmCNFwZpHCURpupBB83gG6NMeME/yLOwXAAg6goLdoYbJTATBR3E/Z9GYw81Ftrg9sr0tUNAPZRHuMWvP/mBtLQ31mMsPaSbIj0wl3IXzSsuxn4W1SXFvFDBSHIUXB/MKqII0BnfK8KjaGChtXqzA4dpMrBP+bm8YoFrfVoEGY7eQDEeWm2NLf4Pz8dGBw6HaOXqXXTrD20NlC985Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmGflBQkJQ09wytC2Zwalav3W8P+NhN/2lNqTYtMJv8=;
 b=exAd2m/t+SiWuQKpPgBSEk4JFRheo1MEn7FuIncGwjomslP2sRBW7qOSpkQhDdxzAMkvRi77v87KPfjqsAMgB05r8XE8KrcewpY/cVJziNvVqbmdnA4YdEuDtpVYlO3Fui2U+mRQ510yYhufh9zrAxsgZTxwmjsfrsMHHsLzZXKsl3ahV/QywLMnVTr52omoyNAwSbKrHhrYp475+oGGbrbjb4KRcDKUgVgjretn1ARE7sUvSqbz8Lk+NgxYPaBsdY6tf2iVJoSB6umGqBOvHZjAX4ZS6cKbNYf41wjP5wxFEg0PIY3oen7lpeZUfZvq+I4S2ksoqqkkLIifteRt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmGflBQkJQ09wytC2Zwalav3W8P+NhN/2lNqTYtMJv8=;
 b=j3ZQbExT3lpYjfMj/7UQ0BRd5NHC+dNaf60oxOka2bq77ZA4zLR4pRAQyEUcyZRuO8Az7waw38YW/myj9bwMGN3yvmFFJHGobgm48lVk/osePmHxiwMrgrWp9gT7BPavLwOchvmA2sT+lfvHTtn+yUDKHqYTLgcK/acpjFfWFtw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 36/70] x86: Remove vma linked list walks
Thread-Topic: [PATCH v7 36/70] x86: Remove vma linked list walks
Thread-Index: AQHYSDFGy1ghshnlIUGBQ2YdOQ1oTw==
Date:   Mon, 4 Apr 2022 14:35:47 +0000
Message-ID: <20220404143501.2016403-37-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b89d1c0-6381-410c-ae3b-08da16487d16
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1381F3B85EFC67F0C48CB40CFDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CppfzPv9aNa9sr5SJupt76oIazX2Nz1BfKLdwMxXjqqasG+0/gJM3mdQd7C8wL60eTn5qWB6mLTYL9l368f/ibLr5jQ/d+XUB3yOmIKK16V9nOlCMX94b5Al8VhMKEt4ID+m9KP40iSnfkdueFmFsWSiIRBtT5dex5YUzhBcj+5m6YNME+50gzLmJrroXdbns+xd5qt6dUbSnjzuSM5gkP+xeTH8T7aTssuZbYMu9+uexZNGEi1LD1Uo4GqMXnlmPt+7JJeNLDLBWYKXNRQWqqeg25Wz7bJN/CSN58S9dMPaUEvuhMp1AbVjAg+WDx5sS51Bs5tXFOkp7p9br6cAM2kqGM4ulbcBuqVdZPwkwqw7NRAGy0nlvk6cGIunj5kyfFCbSqagFedflvc9UvrR1owpCV+IFVhReujMR/7G2bNREXUVbKo0oK9Rx8H3CsRv5uhpGv2qHDSLoiUZqOLJhwTGXW4DfeCppuQX2yrmhOzRMEFLN2lfKq6vidGqcFwLX2atMtxiUGGVmEx/Ri3wo/HX4/SgdQpSxcAh8WF6gnvoqm7w4i7zNONj+8xJacNYjZflT5GIe8SGh9AN5LvVjXH2wUwYPfYibcBMiiqejmr0C0zr3cHItokh22ogwvR0Bp+ijk72nIXTbExxwRblxmbevA3EDT42QSsMmI5Z3LgjAEPtjedYxhdgWHf8JPXtMklVsIHvPVHjXzEpBCcLxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2mmBQTz3WSp5uUqBIdl1w6jDSeyb3jWRqyfPnBh/zIagSMomzWiaX1CIm/?=
 =?iso-8859-1?Q?b9h2mJCLwwdGBxgrEroxwkP33DEMqybmqjH4RKiBZofGOUdFBDqtUT3dp9?=
 =?iso-8859-1?Q?Rv4c8KRF91e6bmxC78Q5YZMR9Xa/RGLg8uaimDYdc8dWrfbZMgTGb9BcbV?=
 =?iso-8859-1?Q?eXkmqDY5cNP/OXu1UG7S9jxrKQVS8xlfu462CCP/nMAx408f6fiABq8deU?=
 =?iso-8859-1?Q?3yy2xosTCceNljRGyRG/EMpXN6n6PW7fWST58F7wte37MHCzf4mum1ia3Z?=
 =?iso-8859-1?Q?/vvSm7B+Jtd1vFJ9WbgTIk+ovnWz9cIsplr5mkhE9XmUwrWO6z6K7CZmba?=
 =?iso-8859-1?Q?ZqlO6njyHiU/Q65DP5FrbG/447pN13rltkviB4Vrz3hy2Q+ZIp+h+IwV4h?=
 =?iso-8859-1?Q?obKt/dxIpjfaZtWtCHViwOBCLmeF+Qez8uFesA4gnS2i4G4DH3Sza7O3+M?=
 =?iso-8859-1?Q?BCrAPPERrUGJN994Z6uhF8DXjaBZa1JKVywpOylod2zin8qxNxA7wbnqym?=
 =?iso-8859-1?Q?O1r41ZHMh4FSmtdsclO4urk7uNJBXmDDsJLgu5AulIvacjvtaml8lda6J9?=
 =?iso-8859-1?Q?rck0AhlBLxqftFTKARKHydFIatdgZm+H1m2U55g1sDUucq0jhtL2pDvpW0?=
 =?iso-8859-1?Q?4ZCOEzKfMCwneRxom7wDB9ydjgkJ0nEwGwnsQ5BuRzPnwqgx+ctltDqdzE?=
 =?iso-8859-1?Q?BzzTCJhzWbhmgMR64YFHVOHWqRmbTJI/QEuN7alSgWuzZdpVNsQ49tR5Fs?=
 =?iso-8859-1?Q?skSSjQREKcsdtsupgYj1rDKaPRLbXId6bEy7U8QUP4E01TXYIPrO67bdu4?=
 =?iso-8859-1?Q?TIPhUXJI2cW9CLrpENBDK58Rkgra6lSfJ2AevRT4xYdnTpfzjDKNYgEx/A?=
 =?iso-8859-1?Q?8/xwAjmnPRFCTbxr/d9hlFaEZ/H+vJmNIzbxpd5KP8CQQtR/+ibE8/syYS?=
 =?iso-8859-1?Q?IaV5nHv+0rKTokMMdA4vGBFLt9kdwq49aEf5qcGZy5ZnW6LS/ubOwHWjyJ?=
 =?iso-8859-1?Q?/GwydUlMdCDp1AYM/GajeVjBGmY8JjYG5JwK57289c3u4M4BhXRfkvyBmH?=
 =?iso-8859-1?Q?QsTBP1Cq0CIBB21D9PVntTVP8x2zCfKcuee8YOLHjfhwFlbIYLns3rCjs7?=
 =?iso-8859-1?Q?oF2rHwis1q/cIxqmZ+rlATM2KJEqOy6P4wq9tZYqIILfNq/aTMe1/inuvx?=
 =?iso-8859-1?Q?/v+3nbHz5tcKNhofpQnv5EGpxVJVKF6eS5pllYxDvNiamUx1NvwxgH2GZF?=
 =?iso-8859-1?Q?42lqQH5Tao56CsA+rbB3jEQ6K5RjXbYNeEYEb/8c+KZIfCCAbueDTRFJP8?=
 =?iso-8859-1?Q?KdzDcv8pwlQPzqXqQEPyRipNEZMTMBsvSX+jSgjMMkvybWsHx4+jYzdEDx?=
 =?iso-8859-1?Q?pRV5o0/fNS6JxKge3zFlE8M/WE855/7QU8nBBfG3KcKxE21P+621xMIvlH?=
 =?iso-8859-1?Q?HqaGlldhnHtJ508/5NB881SxFkwpMu+rNpjgbYYv/WEKXk8YoLnP9dHgKb?=
 =?iso-8859-1?Q?DdFiS6UIyJ8dlhOeYj46ERTDkMgvjymZIRcB3BlPTH3Xmg1BQZNyCkvv4k?=
 =?iso-8859-1?Q?nLhkfvg3MEYkBgBLn7tlyW/YSmgw+3armVzeVZ15UMqsX/pZY0d6ek2B3P?=
 =?iso-8859-1?Q?MdRHHHRAjC9gIrZkOfxrSetwoUF7YbVGTmdVK45LpF1wuXy1fd03bGtYAP?=
 =?iso-8859-1?Q?LRhELd+GodRMrNsdR1DkMfJGIkcviSWVyluiVdBoFWpE/NQufr0lUN8MnB?=
 =?iso-8859-1?Q?iEvB9O1LJVLStApDsdDPRVMmZbsg6+jKrx1zaIW7mVqE+zBuVu3AMltb7F?=
 =?iso-8859-1?Q?AdaqawMezHL8GtrpB0veHlCbGLXPkho=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b89d1c0-6381-410c-ae3b-08da16487d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:47.4402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nXn6RraKqZ4uXKqsvzGncLYOZV8WL47iko0hQYA2xpcV9g8PrSvfOg0UUUB8eK0VknSrz+NTWM2EiPWDgNqhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: NHxPMxgMFmUaq98p4ABbGeNUrC12h9Tb
X-Proofpoint-ORIG-GUID: NHxPMxgMFmUaq98p4ABbGeNUrC12h9Tb
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
2.34.1
