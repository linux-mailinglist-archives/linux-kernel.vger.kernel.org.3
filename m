Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CD5AF4C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIFTuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIFTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB369A2AA9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYjH029914;
        Tue, 6 Sep 2022 19:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hY4W08chqmno14+nsxPj/JYEv2oPnC2CarvE0pbBu/A=;
 b=jHhqG1u3fVLypFrQ9HLOdg6gSUZ/BDkNJmhrecQL6yDJFgRf3f6SQ7I6Kgua4tJmPsU5
 Cq0UyvkYrBQDTHAO3lHTcktRpznI/N9OCFKCheQRWMn8+hKveJnU0y4GyMMgLQow73Yf
 Id14+shbhKjkbBwS0GZe6OPQAhSjUnoK62XEwb0/PuOKIVB3vk/M4V3kyIh9Uaf4Mqx+
 Ze4avMMCRg5S+6q+DQ1r8nrtiALsApH38b+3AIWpk6kGHEKgfp3YXb/Ho6gWKoyUnHOl
 doKfAe3CIwDSOdPTjIvuNjts6FdDPLUGG/TNGvXO48w2BcZ7MD2iyk7iCfK4tpSjzQ69 Gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wf027549;
        Tue, 6 Sep 2022 19:49:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZEgYfjO1e41wNZumTwUNJ4bzxwDKOujrt27VukwHat1LxYAvEo0/7Ka7pW/0n6NPr5lxHRmVJzjK0NgRVNbd1maBxjvmJpMVXel09nGmweuSLb3L1hG505v29YDbcl/IA3lzW621oghVW7gZEL9rJiwpb8Xk3yRsiLC5qjzV/nX1BnineCkIxLB6idWTvh6L15tu5b9wW6i7xGL7c2N+F5emYu9l53o+otWH/rkYVfhcbcU2KoKjyvWJp2sScK06vHCyOjUToIC+vKRPBUMRl6t3opFG/+o4RiETQDIZmcm+BahRRiq7lXf89QUg6P/zOq4O8V8bR6Y4TTZhhJXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY4W08chqmno14+nsxPj/JYEv2oPnC2CarvE0pbBu/A=;
 b=TSMDe37pHp9FQcDlqh46Z8eDW8pBTss9djMhc6OSX3ZWxQVW8Ndfw76h8b5E78VV64ROmXu/T9HJ9m/8O0Pf0OLQQ5QBkfJMSulGR0B8j+Qzt+nTgUx9r4hFUrRKe2D3rD158QLSHrYIm6TCqKDwUv8/3+3izhz3DPm/MWvKmhZ8qUGk1CgRtH0uBBarWjFPvNXE2yhWJU4yU6dR0I91KBCw8nibuYbD0PkqMTkiJa1bPgKHCEicx/FrLjbqquF4SN2cJf5YTEfXT8QByad0UNkQ2XOstDdt/+z7OKRroj6yyIDK3Td9qqX0dIovK/G0r9Yk1n5EQqN4t1Z3R8mZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY4W08chqmno14+nsxPj/JYEv2oPnC2CarvE0pbBu/A=;
 b=scCjyIeljhHt4StV8RpGzXgECiAYzp+B6jjyBPFxzgE+tnQ2V3C8X9d33mpeJfZQvqMEEqkW1grmZUe77HLOaJrUmC0YLO6djJInTjSZRwOALhw5r8C1g1ylRIlGHh5evKKQeCiVaXjcWjyyoOY81zZQ+/6OfFU4RJTpaSB4j+U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 22/70] mm/mmap: change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v14 22/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYwimvZemd0dO0KEG3okXxkMowbg==
Date:   Tue, 6 Sep 2022 19:48:50 +0000
Message-ID: <20220906194824.2110408-23-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f9d2bd2-62be-4a41-d30b-08da9040d6b9
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4hGV+zLHr/L4lgyp4LsQ4R7Qke6lI6Z5foMyjCDHNM09crSX1597+QGjus0PKM2+BrYL5KDu32NfTQ0twiPmfPqtfu6/EEq0ig5EAZIMlx29heQWwqYmRQn8BiQaQTA2nlDOP4hfRSR1YzrMokz+E48DinhE9Rg+L7J4O/xfv97I8TqkFOijVCr3eYk7rWY9M0IceItcR/Q5jZBboQsDXMuYT7HgoijZJfi4YLTfuhjbyZDBjhf8+knfk5sdz3ssYm9o06JDHQD3tRPllwyNyaLMwXHWlwOTwRSbOTQf4HRL1RdFkJAi0p31NMcCsnlug6Z1PIKaIdu04O4F0LXc2qe8dOywwaYu1na+a38qKEbvVl+yB8Gm6ddswNkVne9GUR6c+qdGQdXm6zJLcqHQFzVSwutWuJUTcj/+JHpvAXJQsjB5Jz2Jvqg56U7e3YoQ56uZ4SqW7NZbqCjYPvPYUo8knrxFM7pl+7u42SNOtdEjAMTtxUBTP0aejrgr+IA6vtRupGamRVaIdwUpem5VuwWdiVbOdFIsM+CCWccPN7oc0U7Nm5clzVq+jz0lijLH6TrE5NtBN89t355W+QhNi/QqLybQH4e9VSze/N8sr2iYJoVVoJBVB0jY2suEqTOp5vSrs+iAn1kuMjCQ3CnMn+afYclHNsGkr9ji1EtvKpj3rpKPfcOhQiQ5p+lqtdlTKDgIVALzHgXCHHrlUq5MrWUdJo5zwzrTUeoO3pHwFLUXRdzN9Dh/ZT/EdorexJ3wwDQxLeJ7vuVWBuiLMrp9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(107886003)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(30864003)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ry1iWkukPtrQ2IcHAwd65Lqrxl8XvPoe6cWK4fvxmJakfPj1JqiOkfOfos?=
 =?iso-8859-1?Q?cXOA2fYkVi9Rl6+voQ4bUFJ61PRiZjPY/1hUI7wXo9BaaaWyw4esGRYoGM?=
 =?iso-8859-1?Q?BiJ08KqSa8ahJJ7EAzZILE1DieJzg7WP2z5MEzU8TmFsTMz0Z4UsxfWYy/?=
 =?iso-8859-1?Q?O2B//8FVz4VMTXni0uLpsooQAmVGEBgk5Clewb9/CdfAu5ztfinqDsijcc?=
 =?iso-8859-1?Q?Al9A31ovPIxCXWcj+E1FZ6SAgXKnI87rCEFQc584pZaD+1HKnrYGLAbtwt?=
 =?iso-8859-1?Q?RnQnykCvb0vjJcAjxDC1qs9QHv5Ae88csm2R00qmQg5BtquzjLKmy2kvUm?=
 =?iso-8859-1?Q?YktLDehvZfge1m2uon7peIPTPipA59uqWBWO838vdurVpUChbtgwDDTHXu?=
 =?iso-8859-1?Q?ipdRoPBN8Yiv3Pl0c0FYSZHyMINhReyRSapYaV3WXfqg07dQ60ghqZYLmy?=
 =?iso-8859-1?Q?lyxc0JBpLYCS3e/SXiMxC9iLQtVL+7GTze096XnblO3a4a/NFl+G9QlqZ2?=
 =?iso-8859-1?Q?2KF2vCLq0y426VDhGSCBaDXCCAko8WULo1Pcx/ultbErwtVNpq1S9GYBNq?=
 =?iso-8859-1?Q?6/ZhTwiiZRQ7HUzRmp4XkBhsWqkEuFzeYHHEKOBV/ves3GD0WknE//HTnt?=
 =?iso-8859-1?Q?lrn6p6d4BD4tkK6U+mq49SCzX3VKWRS8AJXwaxHw/Fcqu/k6j2bnQxCouC?=
 =?iso-8859-1?Q?aNDmhAIbrc6rFPhfh8AoSnM9Jp5XpcckRz2ok5wX6AeP8Oe283RJe7jlJ5?=
 =?iso-8859-1?Q?ZZ2YogTeff5zvIzyRF9N+35zpg2IcT6gVG/ZK5/wB8dTQADyADN1luL8qy?=
 =?iso-8859-1?Q?4s9LCDbJLDSAudxqZgMN/S2YXx4u68/nr0jkZq2zDwXaTY/EYfBvQTGSuX?=
 =?iso-8859-1?Q?0yuQ+NL+HE3A/oiWSHZUeFQ9Wzi+ERJRlrUOBKGP6LS5cD9L15HxzbwS7B?=
 =?iso-8859-1?Q?kXdkvtQ+GFuckrCKFLVNa1OCigb7U7RIyy9OQIeRwVJVFTRwBg+Ea0XGWU?=
 =?iso-8859-1?Q?ataG8rvxJ33WAY67RbCKKIL6CRyFPDRoUDDeApmkoHoQT9pezYcwPvbwtc?=
 =?iso-8859-1?Q?e1NYGEQCCx1FgIHWXWyCKs3B/A0j+FSNAP//FCT4jkhVN/ITrVJ82ldAuY?=
 =?iso-8859-1?Q?ujOuildmZUuR105jfRt+6H3JkgTBsZ8i2JV/T/hSSlaDR9pEsMB1n1W+j3?=
 =?iso-8859-1?Q?eS+h0TUVpTNKK4JE24VGIpFa6A9/3o7cM87SXtP1DU3L7e4Xn1wmL8XIhn?=
 =?iso-8859-1?Q?6+FfkSZPyYYpqUnGqkK1pKmx4zFhD+T88MVxldwJwDvfv4xeSe9RHnIQhd?=
 =?iso-8859-1?Q?7ifZheBP2EHTXEqdZlO/DHG6EZYQ235WuJxCFxG7VlhSNIUgCrliJXOYnU?=
 =?iso-8859-1?Q?LoGeVp7HseYnY5o5WEOH73I5fh1aNGRbFtQsZvW5gDz0//2o6Q9QYTsDX1?=
 =?iso-8859-1?Q?1DJAwe+RfAKhEbTGKBaRYoPYC0SANAc7qnVNRHNCKUmMgsGz14YFMPM41e?=
 =?iso-8859-1?Q?EyzS3SHfL3JZlwQYLrR0Lop7KWKK/fIiBRstEErm/3C6BzVpdazMa5HTn3?=
 =?iso-8859-1?Q?v9n2ZfSu89l5G6K4D05VCKpKOaCzjXlZ7VPDXHrs0NcshIYnIUKbFNcDjg?=
 =?iso-8859-1?Q?hfEvNoXMS8zLXD8uT3RD372SF04LFTJrHVUjrwJuFqXJdJut32QNhDqA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9d2bd2-62be-4a41-d30b-08da9040d6b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:50.5379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwwtaoDlPz+tj4gGPgHAjvUP+F/QcNWuDl16BKB7EZaNCkZk44V4i2Etw/vXDiPTmVxUW6nJVRqzIdT1l4/yew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: Y5Kfta8rEyFRdtCe5tCLv_fj9HNuzGZx
X-Proofpoint-GUID: Y5Kfta8rEyFRdtCe5tCLv_fj9HNuzGZx
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

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to split
or coalesce.  This avoids unnecessary allocations/frees of maple tree
nodes and VMAs.

Move some limit & flag verifications out of the do_brk_flags() function to
use only relevant checks in the code path of bkr() and vm_brk_flags().

Set the vma to check if it can expand in vm_brk_flags() if extra criteria
are met.

Drop userfaultfd from do_brk_flags() path and only use it in
vm_brk_flags() path since that is the only place a munmap will happen.

Add a wraper for munmap for the brk case called do_brk_munmap().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 237 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 177 insertions(+), 60 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 52a774e70e5b..0baa2ca5b0bf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -147,17 +147,40 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+/*
+ * check_brk_limits() - Use platform specific check of range & verify mloc=
k
+ * limits.
+ * @addr: The address to check
+ * @len: The size of increase.
+ *
+ * Return: 0 on success.
+ */
+static int check_brk_limits(unsigned long addr, unsigned long len)
+{
+	unsigned long mapped_addr;
+
+	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
+	if (IS_ERR_VALUE(mapped_addr))
+		return mapped_addr;
+
+	return mlock_future_check(current->mm, current->mm->def_flags, len);
+}
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -199,35 +222,52 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
=20
 	/*
 	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
+	 * do_brk_munmap() may downgrade mmap_lock to read.
 	 */
 	if (brk <=3D mm->brk) {
 		int ret;
=20
+		/* Search one past newbrk */
+		mas_set(&mas, newbrk);
+		brkvma =3D mas_find(&mas, oldbrk);
+		BUG_ON(brkvma =3D=3D NULL);
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
+			goto success;
+		} else if (!ret)
+			goto success;
+
+		mm->brk =3D origbrk;
+		goto out;
 	}
=20
-	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
+	if (check_brk_limits(oldbrk, newbrk - oldbrk))
+		goto out;
+
+	/*
+	 * Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area
+	 */
+	mas_set(&mas, oldbrk);
+	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -2762,38 +2802,55 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
-	int error;
-	unsigned long mapped_addr;
-	validate_mm_mt(mm);
-
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) !=3D 0)
-		return -EINVAL;
-	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
-
-	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
-	if (IS_ERR_VALUE(mapped_addr))
-		return mapped_addr;
+	struct mm_struct *mm =3D vma->vm_mm;
+	int ret;
=20
-	error =3D mlock_future_check(mm, mm->def_flags, len);
-	if (error)
-		return error;
+	arch_unmap(mm, newbrk, oldbrk);
+	ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+	validate_mm_mt(mm);
+	return ret;
+}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
+ */
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *prev =3D NULL;
=20
-	/* Check against address space limits *after* clearing old maps... */
+	validate_mm_mt(mm);
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2803,30 +2860,54 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
-
 	/*
-	 * create a vma struct for an anonymous mapping
+	 * Expand the existing vma if possible; Note that singular lists do not
+	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+	if (vma &&
+	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
+	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+		mas->index =3D vma->vm_start;
+		mas->last =3D addr + len - 1;
+		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		if (vma->anon_vma) {
+			anon_vma_lock_write(vma->anon_vma);
+			anon_vma_interval_tree_pre_update_vma(vma);
+		}
+		vma->vm_end =3D addr + len;
+		vma->vm_flags |=3D VM_SOFTDIRTY;
+		if (mas_store_gfp(mas, vma, GFP_KERNEL))
+			goto mas_expand_failed;
+
+		if (vma->anon_vma) {
+			anon_vma_interval_tree_post_update_vma(vma);
+			anon_vma_unlock_write(vma->anon_vma);
+		}
+		khugepaged_enter_vma(vma, flags);
+		goto out;
 	}
+	prev =3D vma;
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma_link(mm, vma, prev))
-		goto no_vma_link;
+	mas_set_range(mas, vma->vm_start, addr + len - 1);
+	if (mas_store_gfp(mas, vma, GFP_KERNEL))
+		goto mas_store_fail;
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
=20
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2837,18 +2918,29 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	validate_mm_mt(mm);
 	return 0;
=20
-no_vma_link:
+mas_store_fail:
 	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+
+mas_expand_failed:
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
 	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2859,13 +2951,38 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	/* Until we need other flags, refuse anything except VM_EXEC. */
+	if ((flags & (~VM_EXEC)) !=3D 0)
+		return -EINVAL;
+
+	ret =3D check_brk_limits(addr, len);
+	if (ret)
+		goto limits_failed;
+
+	if (find_vma_intersection(mm, addr, addr + len))
+		ret =3D do_munmap(mm, addr, len, &uf);
+
+	if (ret)
+		goto munmap_failed;
+
+	vma =3D mas_prev(&mas, 0);
+	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
+	    !can_vma_merge_after(vma, flags, NULL, NULL,
+				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
+		vma =3D NULL;
+
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
+
+munmap_failed:
+limits_failed:
+	mmap_write_unlock(mm);
+	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
=20
--=20
2.35.1
