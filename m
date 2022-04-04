Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171654F1730
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378029AbiDDOjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377789AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460413F310
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DmF4r000752;
        Mon, 4 Apr 2022 14:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WmW8hzCLIr2GzstbmfOIVaXPPjdXWDi+IRAzPBCRg2o=;
 b=ULSuCMMAcvv0LKkl1/aLAVIBkEaWPUcPeSE705wCBWxSHXYGa9O5FqDGjvxiby+IRmeB
 J+Kzr/azUqWe8GrN6N2GW3lFIrQrLhU847ShNk5NFGrtDSysFm/ERV7vYjXhNeEk5NHX
 Rw1L6mns+lgZnKI1XmdT2D+bGjaxjoFU6tsYGl0DP3qXgq2xUC+U9xtYH4W3yhy5MnKT
 BpU2NUbv9i8CNbqrBMVhQiP0oRwfsB5GpWkqj42HIoiGrb+f6GB7mtdr9LyRT9hixOt9
 ow2hzAPjnHaboKvsSxWs53kFq4BeauNXDVlhFd2RfJ0jhfOcbvre7S3S+2zyJb3UPhkD /w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3skbjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaSa034390;
        Mon, 4 Apr 2022 14:35:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mh4q-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMQyX2cM8U1YrQbgPefKUopjcsnlAAt6WoYJlmWhq8dhWkWfpszVm9dxlxQ7I4lHUx1mML7rg42pkEY7iNqGP7cQKZY52bU1uz/Ib0bIitdt6BNQV/4Rq/VlrTEtrIUt2DdCpLwy6l4wecb8KrnPxjKXUIbo4B+R2f8yQ8G7ayDKb/ckfY3QKJg3L+ETk6Z8mAFE79MUk1tZ+JMx+z/Dunq0PrdsAHf6obpMiOA3ApoSqxz2PgeycRHditBhmTkHnVKk44/qFUa/QWDByr0XxPkjuyMdlrLGwvWZy6Tj9b40LkOvF/Ly8qFE86O0PllouQh4FGxxf/tqbgjPIn24gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmW8hzCLIr2GzstbmfOIVaXPPjdXWDi+IRAzPBCRg2o=;
 b=j8kuo5ZDE5DzhGUyOS+OHp87tFsWxYqj89H6ve5B9cpOQ84mnhps0uNCc9d0lSe4dWG9q6RT6vqa1ckkzIYQCS3Uf5Sy8WbAspeqydem4mXVxMz+QFqKvmTadh3EJN5ibtkXyClpNY+obW1sEHimTe8Hk+0y5GTaAPa1aisJXWpF9030Q87BxTPr2FTUOGzs6RL1KOV3llZMlgR0O9CWiDel6ChXlwQJlSzsjZhTXQBoCr/ztw7m/tElN4Ac4wSxFIV873BRa4XgiZU2jaYSvb4vX/EHB4KpbRtU/TruVYtvu2Ko739WW4FfbMxKnPlBPB/hnRrky1PfThpAe6ipmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmW8hzCLIr2GzstbmfOIVaXPPjdXWDi+IRAzPBCRg2o=;
 b=tCx8wUueHbwuuEhWO8YPH62uyWUtAXK8scBtgyIAk3T3HJ/Ljv57DyhPRCfmF5N0U/fOl+ty4DxH7s0EqPk5NOJVrwchTh+srYGXaITFNnnHLPacWxmuWyQMI2NAOZuf2kkKNuPrSdn1WAME3B/2ooPToOERiBQPmj9u7J7rbbs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 16/70] kernel/fork: Use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v7 16/70] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYSDFBD3iOuY3ZJkmWjJIIt3ziJQ==
Date:   Mon, 4 Apr 2022 14:35:39 +0000
Message-ID: <20220404143501.2016403-17-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5491106a-f1b2-4c92-5c9c-08da16486506
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812BDA75CAAB96108B4D4C5FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZq0NqdimlsVxt2NzV1ppRMBHSuhRSTyDn9wzukw9Er6Uk+Kj3QdwMteSSmTFsrDmdLyhn5Dh4GeDggQIWkxKHZdvuW33BqItMxt+c7w6kJMZ82ahegNarDRnJ/WcFzAH/9lMarxi0c2EEhbn0Oai8uGqKNuZ6bfyhAHx1URM8EOrhbuj03eSLERc8U41xqigEbOWHqGFb9fgAFON+0LIJ5QODZQORFohNyGZdda3BYQ8uVU8ajFQWkVOcvPrPSQ1kfYzxXjFEWUZZQe1BVqwuuFN2wKnLHCWRgkBFjYvFuvQJe8BfNssLJ1GykXEz9ho8DZ+YwO6gdPewOncICGrsB63EpbxoTnJd8ZmPYhsXYZyErHLpix6bzb7Ohk2w+jhVTZi/Hh2NWg40OMbtzMlvu8YWChrmXQFhbLfk8j1LTdugIP81qw8XH9K6qzLW5ggx6wgiWcVn7kAeM8gn1Nb5L/2C/Ifnt5VfkxqEQ69ovM1tummWwnsyVrVxpT5c0qh/XrQPd4AndxhPtd1dVFjz30k42khNlf9kvwZrFV3R0T3o/FYuR0ihAZ1gLpPrVdKKtTDCpejtfYxXJYKy7SPi3T1e2UcyjZiLdz0OU+kLVEHGQKXghRJiqyJOpW8qiydCINbCrVwSiB56rfCM6+ln9qKpp6VWkgeosuh05LiR+HvDo/QtlMclu5MjxMB45xU5HNGnPJslHS+XW2th118w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1eyvkIUkW85IJcdF2n6R4UD1qhUizRjo1D67xbWN71ItS3mfUlvNX/53ic?=
 =?iso-8859-1?Q?gs5dZltzizk7ch68y9Yl/hMip5FYt7TPRiz0wy5dGZ4M4wwInAFM28oUrT?=
 =?iso-8859-1?Q?7Anje7BpkW97FBzfJ1dnc7o5KKHW0FIWPT9KWQtW5ZEK3eY7BYF2ZZ6nKw?=
 =?iso-8859-1?Q?x/3Av9E+x9hBCgqyVWMds1yJuTfN2dff78vpNcXvso2fGZQiBiMtpe1g5Z?=
 =?iso-8859-1?Q?6I1hu00VTOx6vcUzc4l9pAtZRjlcxUZM6JMQvQqkmPLgYi8r+oH/DOwsy7?=
 =?iso-8859-1?Q?XQemfQIRrMoau/8CVpL/jlO58bm9pFyRWkoePwZSSHkocWUFVBq/Z6fB8M?=
 =?iso-8859-1?Q?5WUQa/5z4inSGEA1yY2j+5sNHdtW7uFlOHdrIJlA7z6dkFWZ7OSZTa1Q9N?=
 =?iso-8859-1?Q?WU+xmpKDQRWqQ8qf0QV390Vkrd1hwov6ugmibOipIi4xVtdoguwVFFK8q3?=
 =?iso-8859-1?Q?5mJr3COO2/OT9giANExy6iPA+XhdQsoc1qOxVVYaioRwvKIplKzhV1VCtm?=
 =?iso-8859-1?Q?WmrRWndBHPVqflG2zveJT5l+NZf6nAxD7cbqjeGRqhc1GPYtBZ4qDzKc48?=
 =?iso-8859-1?Q?FT0MpntbijhaQqefCtJftnV/WAaJZd5wEwCktl04IxfGCCijcTwABj0ysg?=
 =?iso-8859-1?Q?sluRz4EsqQXZrzgmB1BYK2A7gqTqOAupfgcvHXA164Lae5wnNIXBI/XjDN?=
 =?iso-8859-1?Q?xM/vFQmADVk4WkySFQ8F+VOHQxQrFlPS/0JzmiW4NFDlpC5Tmw1F3bcuAt?=
 =?iso-8859-1?Q?MtE8WkIdQtlfMpqZ1XBq1Jnf55zHnj/JofG0PeoFZAWP9YQDKqfIBJCFjs?=
 =?iso-8859-1?Q?SPln8Y1kk3ci5FkqHi9I+CXnITZd/0CX/A2rZw9hPqanDsXiCGUs/ueJye?=
 =?iso-8859-1?Q?rbS+LAXyXVGPxKZTijsBVwCAkhEnXr46tbbNfZ0oR12xcbu/sWJUC27iBC?=
 =?iso-8859-1?Q?xAC3v5Qo+xgCM3z8jPSpb1BvcPX24uqe8LYP8pxFCAdq1c2SKoMGLWzbgG?=
 =?iso-8859-1?Q?WwFR5/M6i2XrdfMexFcE5ZsciZ0Kk1i9ucmr/bJoWbDJhelO9DTU8AR3bL?=
 =?iso-8859-1?Q?1PQS2zUgJwTX5U00xyXW9kHbgxvwpgn7Je5APXQWQz9JrK8/LPZacRUP6z?=
 =?iso-8859-1?Q?jSXIW6ZeqvqvwRRDbAaa7MlYUJTd4C6kXAYD8Iae047wkQS/5h4o7HqAem?=
 =?iso-8859-1?Q?Oq0iX1J1c4FaFGvUz9qj2X1gEKPBizXFdZC4O11dKExktVAxmKuwNG6q7N?=
 =?iso-8859-1?Q?26ARyef7JFGXf4SkO0bH0DElZ4glXX7BCrrrnmrGsqlOL4u3p3KjxqmB+D?=
 =?iso-8859-1?Q?YiwFDqzUWjp8RkDWHSvnrD0DAaItEpbm3YaSG6fHr6IbzuH7jViUYaT9K0?=
 =?iso-8859-1?Q?h6/T1BQx2TcEGdgbceUWXqO9LYEUhH+LMwpQD6h58GXgXpXFK0KsQV4lLU?=
 =?iso-8859-1?Q?2E+wOA9ZCnBazUyzLjcOiZybyKFQwmoQoFrryGOkTZNg3HJMlM59h5IzRr?=
 =?iso-8859-1?Q?x6erWaM+YZCxrOHQgbJmhZdM78U0W+eQgh3oCM0Aay06fCUlbylz/MgBap?=
 =?iso-8859-1?Q?HY+BqR2JJGYngytEzTRVGaWspSqAfGexg9dqDGmZT+9xCpqtP3Pbd5qDgo?=
 =?iso-8859-1?Q?VsgQgubNz9jHqHBmqgr5oaXiS2h9A9f75Tp6Jlf8DjBm7zDxortFZSHWjy?=
 =?iso-8859-1?Q?bCqOm8Rsm1tmq8NPBizxFCc+pRoduEsl6DUJr6PVOvHo0hElcsJ+DTujrv?=
 =?iso-8859-1?Q?UyQogEqYD/DtBjDPMghoJpfsq/QqQ2LTS9ScQwFw5v0CvKqWn4ftLAF5nk?=
 =?iso-8859-1?Q?Qo8X5ZfUYjz0trMY7C+IJ5zrGdThuTA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5491106a-f1b2-4c92-5c9c-08da16486506
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:39.2063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrQx2pVb/ZwEk2KRb35VNJrFrMZSicMFsLw+1zAe2cb1w8UDYn0jnn6sBUdBfKt6kXX8gRnYR5XqEU/B3Vo1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=986 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: xSYCS7k5nEPS3tmwTMSy6SCIGqjsnJK6
X-Proofpoint-GUID: xSYCS7k5nEPS3tmwTMSy6SCIGqjsnJK6
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

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator and switch to
the maple tree advanced API to avoid multiple walks of the tree during
insert operations.  Unexport the now-unused vma_store() function.

For performance reasons we bulk allocate the maple tree nodes.  The node
calculations are done internally to the tree and use the VMA count and
assume the worst-case node requirements.  The VM_DONT_COPY flag does
not allow for the most efficient copy method of the tree and so a bulk
loading algorithm is used.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h |  2 --
 kernel/fork.c      | 24 ++++++++++++++++++------
 mm/mmap.c          |  2 +-
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ec21ab9b6fc7..2a54b8cfd551 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2608,8 +2608,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* mmap.c */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/kernel/fork.c b/kernel/fork.c
index c81993dff42c..6420b9500caf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -583,7 +583,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge =3D 0;
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	LIST_HEAD(uf);
=20
 	uprobe_start_dup_mmap();
@@ -617,7 +619,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -631,7 +638,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -697,7 +704,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_parent =3D &tmp->vm_rb;
=20
 		/* Link the vma into the MT */
-		vma_store(mm, tmp);
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -707,10 +716,13 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
+
 	}
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
+	mas_destroy(&mas);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -726,7 +738,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_nomem:
 	retval =3D -ENOMEM;
 	vm_unacct_memory(charge);
-	goto out;
+	goto loop_out;
 }
=20
 static inline int mm_alloc_pgd(struct mm_struct *mm)
diff --git a/mm/mmap.c b/mm/mmap.c
index 8e236030c0b5..a83b4f55b91c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -751,7 +751,7 @@ static inline void vma_mt_szero(struct mm_struct *mm, u=
nsigned long start,
  * @mm: The struct_mm
  * @vma: The vm_area_struct to store in the maple tree.
  */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma)
+static void vma_store(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
--=20
2.34.1
