Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BCB4F173A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378081AbiDDOk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377964AbiDDOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8656F3F8A2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DpPEa024458;
        Mon, 4 Apr 2022 14:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yXtmxFbJJpdY0mYnW/lp/tj7LUoC5+SXK0Jyy9F9Dc0=;
 b=S5OeP6V/IlKQmkg6zDt4d+Duiq0gdpIgSgDk0YzAztNy5o1fZVtl3xxvH0t72Jl8lEak
 YQ71yuoqNA3/1bMdAcaxqbpgReTAbOSSFkBX279/6P7o4Zu2kSdCcZepi5FqpPSjWliz
 VTf0efRct5tTjA9Nlldo7mOm4fHU/EOnydMFxfUuAl0XmOF6eJKlbwxzckXhaHlB+ypF
 b2YzEviCfjoGsfYJZ2w1c8AOlw2TBzs31YWKhuU6UyPNNiD4gP9jEt5r9vLde2JtzyWA
 M2MqW05nnLt+0KctIYcJXSpwg7MrSlInCWt8YjFxPsIPMK3rtYrPn52r1Nj4GR4JCOlo ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcG6027665;
        Mon, 4 Apr 2022 14:36:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOUNrqebfunwFBNWQyCN7U1cuo0H1gK9TsKezDFJdvk+qlv3zrGagyJ6jk15Visws3u6ckJvZZz7ekKCuFL2sNOkaRHqwn/N5Mj5sz3rBaMYOAG6PzZm3FX0Rfg0j33cwlOP7DTvBo3jj2+uPpckgKWe3vZlOX0qZz/LdIlDODSZ/Jg8NVOsGHiRxxeWBvlAjSgKrcanoR2uksGs3HjHn035i/BtS3m2+SNrogloImNYwaC9AihBjMJK7o275tZ+2Ms/EgVhjYzrw+0rvGfiPphcvbZh55xRe6W11qWw0H5xKyQqU9ddjBwNwcs/vLytF4OAc1yFlK8kc+Ixh30/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXtmxFbJJpdY0mYnW/lp/tj7LUoC5+SXK0Jyy9F9Dc0=;
 b=hJF/2+P3nHt6ESKqe1tAZ1WpRtczBO3O/DLz+KVySVreoiOEOnrS8ML0WiokWQLw5dlLRpSVFsx9KSTpOLi0LFpEwvOhU4a/B69l2DmsSFV+f87d6zdA7/0vNMIZF15aKMQt4HRxNDDv9P8KMM4SmG0EpkHS1LdHPjOD9EyHIxNmAjEzTNdsGqIY9wsFI0o8UDDpTpw2unJkDYcJLmU2yHvtbsNrC7sPUO+sn65hNJqout0Fj5eXoi2yRmIb3mSsDjMPAf2XLnsZZEAPNyRG3i/as+TzhpwXwFAJT25LdH8hO+O6E8Bw9q3AhOMsW3HNFUEuW5vWeqdKxkSJgeOzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXtmxFbJJpdY0mYnW/lp/tj7LUoC5+SXK0Jyy9F9Dc0=;
 b=HCNw0H9jel4C6rOrRp+tQAuf26DPOOei6/QkGTFnf764/nclrlGxwyrLTU7hvfQhfWXsALMrGOOUZMidXPP4kcj4pKtfNry2jr528k5lXkJZ0FcqDxbt1IIYPSA4I6Z8xe5HcmzoK6Nw1mkIjmTX1DfoSPGmhDLnScl8NfHkYmc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 30/70] mm/mmap: Reorganize munmap to use maple states
Thread-Topic: [PATCH v7 30/70] mm/mmap: Reorganize munmap to use maple states
Thread-Index: AQHYSDFEtkVsWEjSZk2VjUF7LvB76g==
Date:   Mon, 4 Apr 2022 14:35:45 +0000
Message-ID: <20220404143501.2016403-31-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc2e88eb-b7c8-4c9a-c9c9-08da16487b64
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1381ABFBC65A34A454C947B2FDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKHjaiiOpKfPbwujSB6R8nIYgcPgCmZ/3TlF8ppXgzZ1eH4ga0ddgLTzntTvpuoqV8LnKZtW9Y6szTtXBnNDULFQ7BQvhEGV/tWQeGPm1gU96AW8/Zlu46XPq8r/ohn1D1PZ2I3IdN+5raz71dMbhv7xvfnEDcphKWj1pmkmCJoepHEsKYqMJB8CmXEmB1/Qq5XF7adZkw5DG1S9SeqMwzOEz1W/eQdEeCB6+1oU/acjgW458HC3E1e9BOwOUdDQoo/EH3ixxycbqngWSJdJVuWlOUScv16O9AYBEr5ZR/zUXlcFRRGQZ9lqA0Cm6hQABLutaOtmURMXmfQWTumkAb08PX5NJ3RLcAQrIiBA587tfzFzY9Hq2DAePG02rTiwht62E+MyBHgnQc2T7thA/YvxNPAdfdRycUChLeAw64PsZb7gYYApIZmg2bNYvoC/GWKbCxCjfOSC+V80ESv6yX6MarXFyEtL65ngbzGRVkPSUOOKo7LX29bkkk6EV0zyHe88iTH/ywt7Dynm6D3y6ilm9gUTcynOIegBo9JXT0rh5rGAucVOwyEDgIh39RmObhrf4rWIPdT3sDe0Di5p5Tt4s19Yxpbk2fHP/JuXoe8mcDcgMXPxbCXx0fWWNc3kwonQes4CGcY5iUHGsiJb7BO6MZ4LTm5hAMg6khX5vaT+tPsvM+8F7Z1xUVuDkzrgsnfq1RdglJL4Wx085YBNSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(30864003)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8xJB4lX7Ik7r7LFKNiFZW6sGUVZFKTlS47eUg7b86kbT5KpozU8nit4KuJ?=
 =?iso-8859-1?Q?JqioX1t4KbsecVkiTBvhqZQs195c0Fu6sMBRpUc9l3pBY8tteINBgc1YtL?=
 =?iso-8859-1?Q?Eukkay7rsflVPLBUmiA/vZcn0kudhNGylFB2ScwXOFLd26dY7g0uyuiORh?=
 =?iso-8859-1?Q?/ENVgcPMFXmYjQKmSsxyG0avF2aKfLWcwQY11W32DqhiCVkWM4MkTTijMU?=
 =?iso-8859-1?Q?Jw7QL6oYC/yqmDrkSlYtItTcdOmvt9rbEVR5S6I0fu3lg8LeVSWJYAGWFV?=
 =?iso-8859-1?Q?mJfg0D3gq/TBV/aZjUMORxWNq4RlhmrvcdGyNaa/zWE5r1QxZ9fiQc2sUS?=
 =?iso-8859-1?Q?GTRiKNuTRlSv+eQyh3DbFFJ2icAneGJfhOQKyKFAkB5SaoUUe3Mx7mlgNP?=
 =?iso-8859-1?Q?H7HHHstOnperm/1ioiHZO3EKU0lEKVqdN8kQo7kSYf6n+K4RQDV955YePS?=
 =?iso-8859-1?Q?FPuoieLsKIREDr4O63dcvrRm+XmUqCFOAVh1HB/D0wo9xMySN0LKObBroM?=
 =?iso-8859-1?Q?7Nig/In6ATPuZwq03iMm26NQXbqM4fNz/lehshyqDpyUwVS9gJkRQW/zFm?=
 =?iso-8859-1?Q?ebr0YyGI1J6oyUgi3z2Q+NfdkR0TarraIcEpvLEso/4Hot9hB5HIFm/XBf?=
 =?iso-8859-1?Q?XTtbM6MT71BK7mKsA1Dn7s4L8IR9OwyHwLsdoqsTmBAJHVmCk2CQXMUJDE?=
 =?iso-8859-1?Q?rJm9ibsc7CO6IEMqAlLTAwQyRhuAIgL2r6WXXB3D7sMRKZ+Bvno6O8ZJok?=
 =?iso-8859-1?Q?svBePd6Zvngm9hbEsZlkJvpF22Ol2pdJsEIz8rmYelw+647Rt51aFzrlNA?=
 =?iso-8859-1?Q?t9ePUI7k1/RdzTHkiGmAWOgOnedGP9bJubKhv2zrAc6J5Qbx1SqF+blZNr?=
 =?iso-8859-1?Q?OsO9j2kb64PLcCkEHiLpv/QLNIjHAd3FE9lSJT9t/u/yY6fXe73tlmD+os?=
 =?iso-8859-1?Q?sNmpyVGFz88wcNzwHocuRIA2optRsEHoPnzZ7WSk15DCUf7wK9+a6ARWgv?=
 =?iso-8859-1?Q?30azDhIXuwTr5cKhwqmNk4Z6WWb0rR3j66DFOzSJc0hCs3mbUWL53n9Qv9?=
 =?iso-8859-1?Q?G2QkRDn3eVMqdyFG3ybfsikHu6470oGyAoQdNsAHk76zVl114UFbx3xPJv?=
 =?iso-8859-1?Q?mRSp+LKCy201s8GGUbZxogbRt8uk9B7m/Krnd/tUGHCrZNcvCAiAal9SuB?=
 =?iso-8859-1?Q?u217ysw956OGkNmDzrE9xbwaoh5ilNIFYQA981dmYAPSQ7IARbuUoAOHV+?=
 =?iso-8859-1?Q?IlqJTAHtRyn5C2LWHrPaz9mJKLsYSUzoXSDhgLNPF0nQmNSvqmxj13E+9W?=
 =?iso-8859-1?Q?EFDiUdeXFCG6hbKSxtf0/WSEG7M0l+0O0DmN2M3JFGX0hdXVO69ews6iuQ?=
 =?iso-8859-1?Q?NTklBYHWgPZfL2/jMLKrZkF1MkQQWilHYUtKEJjuLYttHmOM8TKzNwZZ6e?=
 =?iso-8859-1?Q?EjfUKKkmWgGY4mGGgytVlyAeKx1xrZQL46Yu2o487uUUoBGaZQMxKRWgbf?=
 =?iso-8859-1?Q?4SwA1KOVX8PDWMccd5Vyp8K3MeKfU4ThhHaTJrNxAu6jA5VONTvws+gEnQ?=
 =?iso-8859-1?Q?5+iCrB6NTWtHeOGu2TEvQ350B+GT6oFhY9ZDZpUI6lK2AuMgzrx6kOKPmC?=
 =?iso-8859-1?Q?vbbmaRyeb8kFSlOtkKPjyF2Ng0Si0fKSKiBm1+KeUbdgSDVfwFAZTfjSUo?=
 =?iso-8859-1?Q?I7mG3o21Bg3Bpv0+tCqZ2pC9L0duC8KRCjtvPeclM/Mee0qsODBfpx836v?=
 =?iso-8859-1?Q?jwa7odv0/EBlCBWaSOrn7ARpJ45u62hYbPVFH04B1fdgW7VyYHU7+aB3fJ?=
 =?iso-8859-1?Q?kbLMfMsPh9V4pHbGRZlMgCp7vXeRwjw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2e88eb-b7c8-4c9a-c9c9-08da16487b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:45.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJfgyMHcw+p4/ObXQL9URBy8HkNzPpnVIMooO7ll/RCSDknZUgzGi8M1qWsc5HIhDeXWuCWydQcyVEJnvdYCZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: sh0GLx3uv9TNfvQ2SyRiujKq-D99Ew-1
X-Proofpoint-GUID: sh0GLx3uv9TNfvQ2SyRiujKq-D99Ew-1
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

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that
have not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of
the range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are removed from the linked list and the mm mlock count is
updated at the same time.  Followed by a single tree operation of
overwriting the area in with a NULL.  Finally, the detached list is
unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to
avoid extra work of aligning pre-aligned callers which are known to be
safe, avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

vm_brk_flags() can just call the do_mas_munmap() as it checks for
intersecting VMAs directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 223 ++++++++++++++++++++++++++++-----------------
 mm/mremap.c        |  17 ++--
 3 files changed, 154 insertions(+), 91 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7e39bdb5769b..34226adf6b51 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2715,8 +2715,9 @@ extern unsigned long mmap_region(struct file *file, u=
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
index 5a72c9dc46a6..6770b8a54ce4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2323,46 +2323,6 @@ static void unmap_region(struct mm_struct *mm,
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
@@ -2442,35 +2402,47 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
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
@@ -2493,16 +2465,29 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
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
@@ -2515,15 +2500,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
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
@@ -2533,10 +2549,59 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
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
@@ -2570,7 +2635,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2774,11 +2839,12 @@ static int __vm_munmap(unsigned long start, size_t =
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
@@ -2913,10 +2979,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
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
@@ -2945,10 +3008,8 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	}
=20
 	unmap_pages =3D vma_pages(&unmap);
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm -=3D unmap_pages;
-		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
-	}
=20
 	mmap_write_downgrade(mm);
 	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
@@ -3092,9 +3153,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
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
index 9d76da79594d..beb86e6455be 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -978,20 +978,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
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
2.34.1
