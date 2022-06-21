Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B12553C14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355020AbiFUUza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354978AbiFUUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:52:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDB12FE4D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ29q3004726;
        Tue, 21 Jun 2022 20:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E3LaFNFjSTFGIUaWWmeX0eU2be67L5mG+cNs7hICbvc=;
 b=ZUv1vwE8EIGzQmupOq9IeW4lpVtcrXS6GLd/MzA025zk7/xVfw/TPfwbtzbTBjV9Ztx0
 W91aAXhJIPYzdvAwc56trOqdV8N9Tohbzt7fGLsnajLJLuRGmV2XWu608s32A6dMvlOl
 iKet8OStuH+TWKpySBnHLEb0py77AgY24BoJCCfgdn2Xn5icc0Ap91XOmywUh4gIoEId
 UEg7MPpGN54Ue+4ZakpeG9bbJ0vGbDtfo/DiFeroLCWprcfKkZ50GkhLMzauGiU8MZTa
 DvDy9XVHlrvsUA+DK5sbtgmUKhWBCd07FU8ytPnnGBvnQFC5U2iRmdF9TRyuNYsO3KSD 2Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKebw8031773;
        Tue, 21 Jun 2022 20:47:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9ujy2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln9JB0gZ2xxbaOVc9Tv9odrhd1RTymMA+njpX0UMSF7ueDXTisa+uPPuJpQB4Wkcmg7Sp4U2bbwfsL4EHlI38qNXoZIEdkv92PB2wnOf9c0T8s9BdXMfz63qbPFF+LQ6z+vKSTysRNPKG7Ys289idYwu7RXZal4gV66HNJkwj/qa0P+x6Lm5ebyg0GF8wHnykNboTl9Gz6GG2tr0s1Ga8sFHSfhKTUXRi1OXxIhnhhLaX2QZf6OCGkwgGiBDzQjSDm/qOTB+laqZofaOW61xOyyefi4TcJWx4iIMUMWN3K7iZ5olRRmODzqd4DzdwLV9RHXva7vlq3Fh4ui0IhlvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3LaFNFjSTFGIUaWWmeX0eU2be67L5mG+cNs7hICbvc=;
 b=jsR3Mv1ZfEdC8VoEpCHPbAik6GUu5q/1xnthNN2+j7qweGYcWBqObwusAcYO2UmTMqyq3glGpQnJEJYlagZY//NN7hEzQHnDSXGI+BvcIhyHJzxS0wnm9JGHxmLW0bFx67d7DauSr0I7xqMI/9iU9+EeV6/0QvEJqjzHk1s7xZ9Q2tbeiMfWB5p5bmwd5nham3/uoM9nfT4XQl7m7hnyp2BqUoQtNRMn3xHK4qQ179NC1eiS2XSh1wpsYwCfkDUqO7U/d3AqNnQRP5BtAI+oGOJUZ8B+XSAxhrMlx1UpQiOaSz5RVKGj13ZHgtajTKAE6K64ZasuIRldPRpMR+s4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3LaFNFjSTFGIUaWWmeX0eU2be67L5mG+cNs7hICbvc=;
 b=mN0OPjW8xMTSmOoQggMbZjtUHzKVN5/he9bH70mkngM7YvwU6iYYy40/hUMS+3Wfz2BJ7g37tZmnfRGIznVdS2o6gMQdCmocsiAu4PYr7YS52BuCJ1VtHUDXnzOSC7o9L7tIzsuZZugq4gIfWUwJ1U1K7Kwg9IMKTyqB4J1CIsQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v10 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYhbAOZgjVglI2jUexMTygqqrSIg==
Date:   Tue, 21 Jun 2022 20:47:01 +0000
Message-ID: <20220621204632.3370049-29-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f567f90-dc23-4679-76a2-08da53c737c3
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4025BC616DA4F0E19C6F4568FDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PKQyHpERV+Vv5cMpI8mMnLIJ4zrFINo/VsuFv9CfR7hqDBrm7UqiH8vsRrINb78SPAh05VFp/9fY9oVaeqRfFTylQDYWNQUURvMIO8qZCQWPXyAC/YXdNnn5EZM4xXf93II61kFOtP6t6hhukelVNDZRRUyIDdRkhqxCdtfu0E2qsp8MwC8IdtbXxMJfhiCEVta9VQyBfQXUa99eNk6XuzVHA6YOzsNk8CGM1OFqhScn7iwoq6/ki70j4Jb7ZkFUSsCHFQqz/ffiYNGosnlTLGkYe2THzdGk3GAx+I+LN8Hd3MKr2OLn6Tk6+DESR/q56Wls1q04VTCkLbCW8+37MqxBk9EQ7GLjPdipaEiInhb4Ug3OlF9nd71y2Spi/V8hcYkAuZt5DKSfyKrEpXilWo0lWLVsE4o74TgDQOlCXziVHKVsUlstJ4dpeHR5czw8WzgIYxYp0mww+tSby/qhr9gVimSa8Rws42HKJyL10a8UrTd6nQjfTRnnmAU5fznh8LetPdshoY1xF6AAyA2ybeCtYqOI92IcNJFz+BL6ZVcWAuJThqh9lKDOTEnkyzYUB8E42HLKcCmDtrTKNUhDUvr6au+OkZXs1x08pS+wDBV5nrCVZJMs+JCoHn9eNkV8UM+Qw9IM1QfzNLIi/HM4mzS7CYuHkbQ2jVWRPSYLe8Ng69lRogd02kc/mcFDRSxh183kfV05JWhR6uH0OTh7hFYPwBv5uTm6VX5idYDeTFpsQTVpsoCNpeHdmOClYrNjDDwr3NN8h8wnn8tTscHrVQt7GEwhy9c4q8RgEFzms40=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(30864003)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ykSY5/Q67R4EEIMpgCfp4mxTvAZflbPMsHy+xF0RClyWpZUEMe0/lTjzl5?=
 =?iso-8859-1?Q?WtT7by3bL+vaV3meJJajio4m6FHoKNukG6TWROyl+Bfc+Pc79Fy54lOej5?=
 =?iso-8859-1?Q?LIKvz952vFz41C6Z5l1Pbw50oBKTuW5RTAOo/gbjI+8Gtd21v1IY4V2PPz?=
 =?iso-8859-1?Q?GbzMYqiXNZ3aU6MmduwLHPdoEWHm3qbUWSmp9FVZLytmdR/hqSdwBXPbVK?=
 =?iso-8859-1?Q?//K3bjpNA7n6fxm+AGe7giYUuVvv30FtH3JVFctXJyQaQB+7pDWivmjeec?=
 =?iso-8859-1?Q?VUETNKt9kyqpqBU9e0PlenBiEu/4BCvFbr4g9jvBPwUqo5UChsC31x5E/G?=
 =?iso-8859-1?Q?XxmxKydyd5jTrS7j7CcZx/MHxiGjb88lB+9IZo8Zv7ZrflEIIREPP3FLQa?=
 =?iso-8859-1?Q?zr09rRXudAAxKaXQXu8tuTRwHSkHT9fdihLEcAWf0U5+k/JQi1K59R0FgA?=
 =?iso-8859-1?Q?XYn57fR6tIaXBxylkT71mIqDrk3POe9NMS1sIi5fjbdQLSCM9N7j/7b04F?=
 =?iso-8859-1?Q?OXWanp5x32jB00krqdYe2oA4NBGWWlaDOwVFry9ygvK+90iuOJrF4IRsKS?=
 =?iso-8859-1?Q?ijr5mhuq9QWzhSRRDPqaUkS+y+0j3Hrr70pib2geDboA8KKM5GHWVeqUdH?=
 =?iso-8859-1?Q?JsDqWYzxwQ2Psm7rznnMxrE5oRrHB3Jja1b3dz9e2o03HfXfCA3BwxPtcf?=
 =?iso-8859-1?Q?wzoBw6fGhdKSlBkkpW7ui790EcgKd0K1JkyMoaWbYYbBjwtnZ8yVPWhbdF?=
 =?iso-8859-1?Q?q1xsu6DlZU8UYZVND+b1EAbYUyrBH2RiFA9QV8jKIEKzqkBWy/uUAOIEAU?=
 =?iso-8859-1?Q?VEoVGpI6KRWAjmTwhwGQhGgVStdCxtyv+Kw7NLv+Ewj8is7I8bir7FERnX?=
 =?iso-8859-1?Q?xix4q6X4n12qvziouvU8auaecFNOyYXKi+D9kE4yMVE3yELQIzVMu5hKlC?=
 =?iso-8859-1?Q?DK/kJsjVeurWRKDxj/WD2Cn+C2tvrw2NrIHGTBOcKVjyAOJoykd9UgDYvU?=
 =?iso-8859-1?Q?kwPejTkksCisNulmCjBIJLMy3hT9y3TAs4u4rxpkxMSuoVoMcnzT0Kjcmw?=
 =?iso-8859-1?Q?DtWejQGijRUadvUwa9R7KsQZTWdT9yYrN/TuPBU2/S7tfPFZY5W8tzfqKn?=
 =?iso-8859-1?Q?id6uC5O2sdRJeNY+HRZ0dIXVzPVFteR+PlguQiBukQHh4pP0g9jgDK/j2r?=
 =?iso-8859-1?Q?lSkx2BU5+CjUmtdkpmnBqNvLyIcDW4Wk5f9JLLnFOZFPFAGug2qCO5mi27?=
 =?iso-8859-1?Q?Yua8+FfFkU5sDUNhHRez0NbTIjqmBpIRGZcCrerF3qBVIv+8YwzvatSbyF?=
 =?iso-8859-1?Q?uCYKydQTHIAszynn1TdmYOqS0YaeHL790vZflN3iUfvY2i/pFvyoXm33BK?=
 =?iso-8859-1?Q?TvB56aJRtStbVV8IGPXq/C7xg/aKQtzeoBSX20c4Lhxfy1mnpImeWcLfop?=
 =?iso-8859-1?Q?H0v7+VvkEGEnJ0LslFmiLE1/O02WR5uSlN9I8mkySWejPQR9FFBsYXmaaM?=
 =?iso-8859-1?Q?x9w6mQhNmEyqkm390gfyaNM1f55hW2p5crlX4S3CI4HArFdNvagFOenu4v?=
 =?iso-8859-1?Q?SbZizIdO79wgTBFxj2CoxHIGO2aY3K1QIzD2gR85PrCCj9/BVyu/DkJh4Z?=
 =?iso-8859-1?Q?ZmH7s7caSXN9u8d6R11ptj5bxp0OKhO098OQ1PYZtxif6ad98RxfFbYZfi?=
 =?iso-8859-1?Q?gejIjyNsG2Nf2+AP4hhYbJrLjeflO6zfUsd+sP0dit6292s+rx+rP6Ct34?=
 =?iso-8859-1?Q?KqbnMKYmpVouaD1apJl+dwYybyLcfOnmp+mbGwjJKKhZDjLY0LJ3vS5zSJ?=
 =?iso-8859-1?Q?NyiGKyrPzpJlCazHSTzmB52/Li40Tpw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f567f90-dc23-4679-76a2-08da53c737c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:01.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7cVP20WUiLgY7RvuTamTWuSilJZ3DCG3tlpKEm5nVVYV+gCN66UrWIxB9jlbfQxR9C2gaccaFdpeuU7P1AaOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: KPrCld3fHLBhe8p0CIev6b_o3HByNCZo
X-Proofpoint-ORIG-GUID: KPrCld3fHLBhe8p0CIev6b_o3HByNCZo
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

Link: https://lkml.kernel.org/r/20220504011345.662299-13-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 231 ++++++++++++++++++++++++++++-----------------
 mm/mremap.c        |  17 ++--
 3 files changed, 158 insertions(+), 95 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1b02988b6fc8..890459c69f74 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2723,8 +2723,9 @@ extern unsigned long mmap_region(struct file *file, u=
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
index 4e0eb2f25324..19d2ddbb9a97 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2395,47 +2395,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct ma_state *mas,
-	struct vm_area_struct *vma, struct vm_area_struct *prev,
-	unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mas_szero(mas, vma->vm_start, end);
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
@@ -2515,40 +2474,51 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
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
-	int error =3D -ENOMEM;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
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
+	int error =3D -ENOMEM;
+	/* we have start < vma->vm_end  */
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		return -ENOMEM;
-	prev =3D vma->vm_prev;
-	/* we have start < vma->vm_end  */
=20
+	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2569,17 +2539,31 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
 			goto split_failed;
+
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
 		error =3D __split_vma(mm, last, end, 1);
+
 		if (error)
 			goto split_failed;
+
+		if (vma =3D=3D last)
+			vma =3D __vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2592,16 +2576,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			goto userfaultfd_error;
 	}
=20
-	/* Detach vmas from rbtree */
-	if (!detach_vmas_to_be_unmapped(mm, &mas, vma, prev, end))
-		downgrade =3D false;
+	/*
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
+	 */
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_prealloc(mas, NULL);
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
+
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
@@ -2615,14 +2629,63 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 map_count_exceeded:
 split_failed:
 userfaultfd_error:
-	mas_destroy(&mas);
+	mas_destroy(mas);
 	return error;
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
@@ -2656,7 +2719,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2876,11 +2939,12 @@ static int __vm_munmap(unsigned long start, size_t =
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
@@ -3015,10 +3079,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
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
@@ -3199,9 +3260,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
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
index b522cd0259a0..e0fba9004246 100644
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
