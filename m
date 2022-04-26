Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9551018D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbiDZPPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352040AbiDZPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546E0157DE5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxgo032179;
        Tue, 26 Apr 2022 15:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yGiEGbr4dYY6w8+6ZuX1QbDOcn5rtxDqoGYU2RDVGh8=;
 b=NGAFzezgqBudox+rmOX4rftK4ZCnmky53DDJLDRtufC4/i6qWDmeXSUz2wu28tB5AKqr
 Xy4/eQ+MVZC6jwKWFxedD2hClWBD7tI8Hi4aJa98tviYrS6227+KWPoFqioRYNZW/A+p
 CbJbLV9QBH3R3XpO0tGp04EY9cqamYMQWJutlwysLbpXZbJjPbPrL6a/r02SGN4rQWSK
 wJ1zdGA88GVVfKKCR7QbpPGsK0rUAHQ0Yp7TToaDoYNz7FMbfYWBD4b76np3Igjnrtaz
 rjzQTkm5GpN7qbnzuh5NmYZT8FJGZz1d2nR0+rQlhgwu32hsFNP7oVxAShQWNiFN1t2d dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx50a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6VmM037916;
        Tue, 26 Apr 2022 15:06:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mss6SlJZbPl0xkbwO2ymC/AItt2lDCm4KYzEaCYkinVeg+w3wPJ74951lO3b6hGWbzo3Et6IkTGLZQrtFDrRN/NqtiyAyCNu7vwUmE0F5ReEz3JplrH8qKd1ZZ6ESUsWYlBsOFzvthooGnZvVMz1xFbAch31FgWXS2lKk77+pQzOsQ+EaZkobZsuPkszlFmCIopiWHZwM+u2hU2xHwxkckf+B1b0M7S9GijPXB707fTsVYov9tM//QtCVyAb1ipW2lAW/pgeXaknGM8SFq/wtptiuo5sYvp8qDWRD96UBRHrO3A6A2oAtcmBF0/0qA3IbJoKluydQT+5j9Kn2XkLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGiEGbr4dYY6w8+6ZuX1QbDOcn5rtxDqoGYU2RDVGh8=;
 b=YMVpVEIlNYsyHnkcJTxqv3cQ/UOR65H/gvdc5zQYNOF9S166hJLUUsXENOH3KKZoLhOD3wKDNo/y/04KlysC08bphifq2ToP05GPHkmTcde/nUh0FtXCMCU7KZZrINSouL2gUZq+AAIZuaDHIoa/canVFRT43q7wmSBEXbEqiY06KkGbfMVVqRrng6Ls+Et4QBqlFTo7u9Llr8aqczxCKp6mr6msHlQ+uAp+IA906EmZ4FwvatzbrK9e4qUTqnwf4mPUFrpk8WIaiR9Kjk/qAJwQmr1GvR+WmNV1HILdPINlVE+jA26TjokyEmXQT7u5EQ1P8hltskXqjA+b9PXveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGiEGbr4dYY6w8+6ZuX1QbDOcn5rtxDqoGYU2RDVGh8=;
 b=I6tt5OoxKLGaWww7DBEzhQPLP4g2CCkgLTo/bXU1ZYslW16/6jWA8JpgXjALiR/CbTMG8DyUW0U4rOCp/kZ7l6k0+NokwgX+psp2/nOOS3UcZHm0md0/gg7Wvj3OuoF65BqirqvgzRP5//mW0pelJhgyFsfhrIqsU7u2yNGwS3A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:06:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 29/70] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v8 29/70] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYWX86jXNsW7jkMkaYhkX/h6YZQg==
Date:   Tue, 26 Apr 2022 15:06:38 +0000
Message-ID: <20220426150616.3937571-30-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 738be3a9-1fc5-471e-0584-08da27965d0c
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2377075EE82A8C280789BB7AFDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S1htEzuVwxH4oJQGxAOpvmpSFJLNa3hFH7u6QPeGX0rJVrCLFO9188LKj/b8b8F2cuiWVXMbF1I2LZ8DaYaqtt97AhJtwQGsq5KZgjDqDMLbWCBeV7qKzyGnjpvirW0OXZwKFFQgjas3GUlZflX1uBUV8oYoyTWtg3ta1BaXMrISJjdMW4ZqHHNlyc2Yc6C9k+TuvfdqR2IwA6XPRPQzW5yJGsGw+aQyHSeQY8A6fZxrOF4zZgok4HdzTW6DbKI7U+6t9DNxJGh6m17JvuE1Qnw2zX3DQy+UlfE+Kbao9RQ8NQogB2A4+PM2dVE8LaaWPYg3hAgeC1YQRkD1j/6XcgQBSZhphvdvVF83LWS4rzc4xBRvb2fneisxo5ZNTJU4bggmuG17zmqZaxPIs+zPDnh7s9oRUlXRnaewHQeUzVT7JREcT7mzlcdE6CsA9ytiW5wyUZsTSPbinaS8cdR9hwg5+ME6u0EyO3a4OYZ6RlCsS0hSoPT43BwSN98ItbNaRK3hm0rtA1FC817NoCwpszxo1xobeGqNeWac0PpQNDQkPPyl1Q6/zbUJw4VPJKdz/1wJjNsovGhAbYKMs07c148umUUYmTLg0iHPS9CHkVsz388fMQnG6iDcvysqDnzrR7S9xBxfHlC6XIn8KbLICx+Jh0v+p0iILcUlQjVdkUG5jh3NU0CqD1gjO2h6z8UhXD3rHV3IOudPC39pC/ussA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(30864003)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9fAsDJA/dgg4NKsEMPi06UyVfp4vl/mk8Cz49dHZSmPtvaFYHT2Q2gpQ94?=
 =?iso-8859-1?Q?9PUqx0BdMAuKlHc6+/hAHkD+KPcyyo82LPfB0Vc14hiGY6CKA21gTk3Phq?=
 =?iso-8859-1?Q?Xx0qznFGxjPp4H5CPs4ZfCv6pMDBU2XOe3vP79fM5QUW2MR9xJJNE9aVst?=
 =?iso-8859-1?Q?zEXGzWLlBYUDFdBbj2zvEQNJJQKvB0Y8Rz6r+/Gezbf6dlv2KR8UIlFI97?=
 =?iso-8859-1?Q?Vk0fNw978pubi20z8I/bvX2wiDKFF6aPKckRR2X4mctRgfj5pUxzi3yWH/?=
 =?iso-8859-1?Q?NEsMtB7ddjEAbZtFLhix23qAWzOPPSrRIIagYxFz/G0BgpqCZ9DUeObUpT?=
 =?iso-8859-1?Q?+2g067bOJwEulImDm0r60QRtNjatOA5bauIkhpUjAcNbc0s+ObDN99RkRW?=
 =?iso-8859-1?Q?EzDg+4M/2yRPTnt2ircNDsNTYb5prZidjJteg4ah/AoCwW8zXK5u2EXqNU?=
 =?iso-8859-1?Q?hw1XFxjs48Oir/70GgwKsF+dK1zAVybnB++cP9cZ/LSDBO3lFVn0gtwh95?=
 =?iso-8859-1?Q?jzfETQOIlboVgr7oq3F6WtS3Kh19hA4CZqTaPMCTY/6JHn202NnmUbbibg?=
 =?iso-8859-1?Q?SluS8MRtRPecuGbFjC3pQjoafmZhfkwoVfSjuWH3LFIPRuY0sgjr56kXXP?=
 =?iso-8859-1?Q?6uZc62PbaXf2aljNksUazZPNIBc/UJnLxndVsd1J/x4B//+sFhQD0rDRAt?=
 =?iso-8859-1?Q?ZCqORGPSTxw3EPx5RzSuo+fss7Ha2DHCY4w5at9G3qkSQJKderyI+d2I8f?=
 =?iso-8859-1?Q?CuokXaUGIylCLZoKEZBl22kFtk9yzSOoX+l/m+L7oEdgnE8g/+UfZemGEa?=
 =?iso-8859-1?Q?T5PcgD1PZGvyyRv61aX5fD6mVNyTdBOtSqRYtH/XDd7nPKZ7ZBpi9DYbcp?=
 =?iso-8859-1?Q?I0LR1qPU7YenrViKKX5kviCtscoYOcBa7/k/UH7oBMCSEyoje/dEjF5CVr?=
 =?iso-8859-1?Q?qv4ycHVMCgmDMH/goFibUwsGBHvhFIIhMMtzPadyBGHEZ6KGmx7UPK1rRN?=
 =?iso-8859-1?Q?jZ0CS3AjRHMjRuQlO8n177z1Qt577Bq8WWAFz4kznCEr3zCU8huAUOzh67?=
 =?iso-8859-1?Q?pYk+hNf45sC5o56AXC5sKJ9dafRa8y8Ev6yc3CYQgPXtJmZrwZGnjaVXEp?=
 =?iso-8859-1?Q?TGFxV9CbbCEinlZxLz2ayoIzov8mrrVdY3SdkHZnGOmIIjn1Ozf1JKM3LY?=
 =?iso-8859-1?Q?bHTE/7mzfjRrL80yT86ztS6v/GI3UMw5PnRP9x/NkIh1Gpsrdsc0ooaQzw?=
 =?iso-8859-1?Q?bV1rRkYTrQ46n2MN/Wqa729+LToKTXwS4TlNC20BS/aEmbmJmTuwod470f?=
 =?iso-8859-1?Q?njIUldHe8Tnrsv2JJIzuGzoa073MNdWWHaO5oidnqC0GVVPQIoMOMWx6gm?=
 =?iso-8859-1?Q?6SKGKp1HQ0G406LU23j448YUpFbSg6E+hEI1SRRqStFt2PdnG6Z30hkpZ8?=
 =?iso-8859-1?Q?r6YX84o1zAQ+y0JsdgPrxzOQDw0/cPg5cO3Tuca7gUw5DB46ktAiQnSrey?=
 =?iso-8859-1?Q?UDTE8AzG2ahQG1cLkoa3KXeFDg60bttBKJmE3K2aH4xb/6FK0VotjbGGpR?=
 =?iso-8859-1?Q?K4jjaBJyeGA0XRsP/d+rBSvRy1XjHjQ8whLSbaO42HHQjOxhNr+xMPCDta?=
 =?iso-8859-1?Q?Vgcj+Y1Oeyof8s/TUDyHBxnyozhUNwoK0VseIV3LUk8/1HxanLzFNstebo?=
 =?iso-8859-1?Q?+Ci2iPbaNrzoJHMEnKi0qjy69G6e3pX71ZmyOqBRdMF+/kHhx85xQkW31k?=
 =?iso-8859-1?Q?gWgu4jRicidIPq1SUGZaZuLfQ0Gezlt756B5W5f50XBOII8R92xH7K29Zv?=
 =?iso-8859-1?Q?OX6mQdJfgaPBDGz0nNLln9bP/uZi1d4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738be3a9-1fc5-471e-0584-08da27965d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:38.0524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jp8Ebm+xxMpZVi7zozYm2JOaCuZ8zelTsVrVVdhqBZrWjU/Fbrowl3PWQd94KB1qRpQRzBrTwpQyH7SGlKvaKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: nQA003_EsFVQafyVmxhD5RcWYz0OQm18
X-Proofpoint-GUID: nQA003_EsFVQafyVmxhD5RcWYz0OQm18
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that have
not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of the
range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are removed from the linked list and the mm mlock count is
updated at the same time.  Followed by a single tree operation of
overwriting the area in with a NULL.  Finally, the detached list is
unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to avoid
extra work of aligning pre-aligned callers which are known to be safe,
avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

vm_brk_flags() can just call the do_mas_munmap() as it checks for
intersecting VMAs directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 219 +++++++++++++++++++++++++++++----------------
 mm/mremap.c        |  17 ++--
 3 files changed, 153 insertions(+), 88 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6bb43774a707..110587299681 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2717,8 +2717,9 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+			 unsigned long start, size_t len, struct list_head *uf,
+			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index 61cedf250958..9f3a2192748b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2352,46 +2352,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vm=
a,
-	struct vm_area_struct *prev, unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mt_szero(mm, vma->vm_start, end);
-	do {
-		if (vma->vm_flags & VM_LOCKED)
-			mm->locked_vm -=3D vma_pages(vma);
-		mm->map_count--;
-		tail_vma =3D vma;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point =3D vma;
-	if (vma)
-		vma->vm_prev =3D prev;
-	else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next =3D NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2471,35 +2431,47 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
- */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static inline int
+unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
+	     unsigned long limit)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
+	struct mm_struct *mm =3D start->vm_mm;
+	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
+	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
+		if (tmp->vm_flags & VM_LOCKED)
+			mm->locked_vm -=3D vma_pages(tmp);
=20
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
-		return -EINVAL;
+		tmp =3D tmp->vm_next;
+	}
=20
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
+	return count;
+}
=20
-	/* Find the first overlapping VMA where start < vma->vm_end */
-	vma =3D find_vma_intersection(mm, start, end);
-	if (!vma)
-		return 0;
-	prev =3D vma->vm_prev;
+/*
+ * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
+ *
+ * If @downgrade is true, check return code for potential release of the l=
ock.
+ */
+static int
+do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool downgrade)
+{
+	struct vm_area_struct *prev, *last;
 	/* we have start < vma->vm_end  */
=20
+	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2522,16 +2494,29 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		if (error)
 			return error;
 		prev =3D vma;
+		vma =3D __vma_next(mm, prev);
+		mas->index =3D start;
+		mas_reset(mas);
+	} else {
+		prev =3D vma->vm_prev;
 	}
=20
+	if (vma->vm_end >=3D end)
+		last =3D vma;
+	else
+		last =3D find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last =3D find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		int error =3D __split_vma(mm, last, end, 1);
+
 		if (error)
 			return error;
+
+		if (vma =3D=3D last)
+			vma =3D __vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2544,15 +2529,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			return error;
 	}
=20
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
-		downgrade =3D false;
+	/*
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
+	 */
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
+
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	if (last->vm_next) {
+		last->vm_next->vm_prev =3D prev;
+		last->vm_next =3D NULL;
+	} else
+		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade =3D false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade =3D false;
+		else
+			mmap_write_downgrade(mm);
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2562,10 +2578,59 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 	return downgrade ? 1 : 0;
 }
=20
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
+ * mmap_sem
+ *
+ * This function takes a @mas that is either pointing to the previous VMA =
or set
+ * to MA_START and sets it up to remove the mapping(s).  The @len will be
+ * aligned and any arch_unmap work will be preformed.
+ *
+ * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+		return -EINVAL;
+
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2599,7 +2664,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2811,11 +2876,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D __do_munmap(mm, start, len, &uf, downgrade);
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2950,10 +3016,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	if (likely((vma->vm_end < oldbrk) ||
 		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
 		/* remove entire mapping(s) */
-		mas_set(mas, newbrk);
-		if (vma->vm_start !=3D newbrk)
-			mas_reset(mas); /* cause a re-walk for the first overlap. */
-		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 		goto munmap_full_vma;
 	}
=20
@@ -3129,9 +3192,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	if (find_vma_intersection(mm, addr, addr + len))
-		ret =3D do_munmap(mm, addr, len, &uf);
-
+	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index 98f50e633009..4495f69eccbe 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -975,20 +975,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
=20
-		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
-		if (retval < 0 && old_len !=3D new_len) {
-			ret =3D retval;
-			goto out;
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		} else if (retval =3D=3D 1)
+		if (retval =3D=3D 1) {
 			downgraded =3D true;
+		} else if (retval < 0 && old_len !=3D new_len) {
+			ret =3D retval;
+			goto out;
+		}
+
 		ret =3D addr;
 		goto out;
 	}
--=20
2.35.1
