Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D4059C24F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbiHVPMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbiHVPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993FF3C8CC
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirIV017918;
        Mon, 22 Aug 2022 15:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DnuoxfeIpEnynqSrZiqFz+nP4sU0sL15CbiT3Yr1NnU=;
 b=aXqX42lrbRixPQPtqmY0pbFswPfpXYxaIkxy2MdkbBtIjiC6CdEajofkkC5UspEkc4jd
 bnRtXOZKa3g+6rEHDecwUmR+3+n9TtLOFS5oBVmiWyxxSwXOCSdfmbIzYpnzwgpPkPEK
 YCbGrtysXK10zPrio142XaPRKmidAx+XU3gESrbGeHgrNinGHm9ZjPcP5Blcgl4m/IAy
 wgV6wA04dt4YR+Z/nCX9aOsM8ukZlfCQAzkd2lGxvbklZj3WL1FaSYIZI7xEC0OZVTTl
 QWd2yhFJrm8+5XtHNEVCMWD79l/DrCVYNQLGGQVX5W28hwaZAqvaOItxAfgJ3Rqd+mIk TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt04e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4OFX005069;
        Mon, 22 Aug 2022 15:07:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn3u1uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTEBqm3U9olzlgCf2REe8c+4A8VFc2sGd4HTYkOniBsqki9jVmBNC2v9fJn0f6f7MNl/T1FdBMarXdZxFhiBN08V7jX1C/jlGs/6C95wrk9kA5f3aglTDoTXodsCyktduiB6jP9jGxPxxDZsOnkivG0A4bkbzdS6Xe//SBsp2NsmRiBphXGiuao0sWYkduey7+nE1VLC4Wt88RtTU7Ge73AFwD6vCFQf6DcDDbS3cxswzkLLcxneoPmNZi7rNbWupdxkF9RlnucYCz3wNvosmZTWr5EVacveCJ9+kyt8Znmoqm2mkQhOLAxpmCKGr0S3xdNNz9i7yIyh12TD/mUKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnuoxfeIpEnynqSrZiqFz+nP4sU0sL15CbiT3Yr1NnU=;
 b=KucAb6LA9UJThjHlxKEeH3mFxLqNG3VI8+Tccc9TmJDiwfSZnysk5SxZ11Jtyl86T1pR+HwT8uiF3ZfQ472Ig73SbDdfsGSTU2Wj1sZMz0x63wwCRaH/MT1KZPY6UIm3JcYVNb1GKnauxmm7JVvf1qGOsImmu9kgojOzxWw/5DEkunJXwM2Ku6nLPb8NfgA71dReyxwq8G0131vOcnHM5Vox3htynTN7Khkz3WfWV9aUv8D/o7CwI9IJ6R6mHeNARLQdWbK7B8pHzS7LeXEYPbV+9/N0o6AME3t6bc+Th7ERsm0R8CzgepoK0NJnuuzgtJiggYGxVXXQsbzx5+JLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnuoxfeIpEnynqSrZiqFz+nP4sU0sL15CbiT3Yr1NnU=;
 b=u+jJP0HjPvgQSKRXc3DHgm6whXc8tyhCWZfg296S0IxtyN1H3ew7sDTrf/tf4uTcifupSkRG978z2vuf6t0Jxfwy5xUWAScQm1rhlLk5iSHqigHcWEuzJIc+FWo/sUCnN2Cwl6FFwJ1trIuBJqGb0AN2Kl62pixCi6IqG8Ug0lQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 15:07:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:07:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 69/70] mm/mmap: drop range_has_overlap() function
Thread-Topic: [PATCH v13 69/70] mm/mmap: drop range_has_overlap() function
Thread-Index: AQHYtjjEuOJoMnJ3w0eZDgjtXj6MiA==
Date:   Mon, 22 Aug 2022 15:06:34 +0000
Message-ID: <20220822150128.1562046-70-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12b5e183-ecad-48cc-c984-08da844ffce3
x-ms-traffictypediagnostic: SJ0PR10MB4512:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b41QR/MrcFla05Xaydj6SAvffsOaccn+/8wt8QzoPATewPcNlUEebMW8A5s4qbvB9kOZ9M6aZpHdUtdQPZDIDJC6j8FmtHHOMPF44EJKSqIRYCANyHS1Ko3QVJYtKgpI+kynwsqE8mVfTzgbb0RmjMweezD6yErZ7AgxeMQAfJflR870kk8XTgQyHYILh2Tqsv+xUgGQClsoEvn+uq+uv6/GNVsKh80Xosw5EQ4RJSyQGy6k0LSc2qiJv23VCE9EHpbpp2c7JVTekfF0r9Er1QNHkXIS+jWvn8FRjfj6NjnM/ao33yZnJuHxDMJPz/kx+OFLDp0EU6cvrILpkW9G0qyyLfP6t6akwddXqXdO20akAFHWVJmvonnmYpvxIoqNCUCpo8ioC7AdV1axQ5TUlmjUeKeLCj7v+ovAbwhTG0k2cclA7QJGt9CvwAmBXDwLOa/GOaUGOS3ygS5IMV7cBBDQn9LdDKUc5V/w2+yslfD/Zz8x6uo59rjtM8r89YPHCFed9UMa+guaZ0zJDWDK6Jf94CA53fun9EcczjOF3QPCMgdCaeAT/o4msRGuemJ5G509VkHt6v60glM/1sd2hgJRR0b1PIjwZXbx9mLW9Nnz2T/g8gpyqtWDm7oDtvp/xy19xHYP+iRPbqfbeFDyJgg8UVE+SGWIrvtHo7K22v1EyaJMVjabbQFf7MGdgqAsNgV6aEhHgO5bekoPVqN36OhW8qcxAXqlVZfucR8EVziu/3DH9/HzBT+7v7ALY8VZqh8a7u23MVWmnl/rLBXDnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(376002)(346002)(2906002)(38100700002)(86362001)(38070700005)(478600001)(6486002)(186003)(41300700001)(1076003)(2616005)(6666004)(26005)(6506007)(71200400001)(6512007)(83380400001)(5660300002)(8936002)(122000001)(44832011)(4326008)(54906003)(110136005)(91956017)(316002)(76116006)(8676002)(66946007)(66446008)(66476007)(66556008)(64756008)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?twXKDv3N7IdJ+llAPY7uEbGqwiDOje3sulUFGIqXEd4f/EoQ3MqYWGj696?=
 =?iso-8859-1?Q?8fYVfdCegoemfjYA7U6qiGSKuOmW/yrBhhoggrWzNVwkJ7BQQjjjI9H5Q3?=
 =?iso-8859-1?Q?keCkjMjZX+mah8DWj7Zod8YphZM6Wv11PkhKjhGvZ0dt1iQk6C1McvvD42?=
 =?iso-8859-1?Q?vMSVKpK7xSZWLw7iyOl+YR0AHIU6HpSyljFyb6uLrckU2hM/xEZ+NYYhRJ?=
 =?iso-8859-1?Q?5y3UTI1ZbThnxrMrfNVgq1fwvh39wTkDLJam0JeWgZ6ybJaapjy1o2zbsj?=
 =?iso-8859-1?Q?nWeVc5bD++v4lfTDP3wjrj+BWqlbp8SSbkFRhLSgmr/a9/TE53NiLuJuH9?=
 =?iso-8859-1?Q?MSlIj9tmcP8C7+2pKI28mTKh1eCrSuc3lNDBOzIEm2K3pshHcdNIxb5tvI?=
 =?iso-8859-1?Q?1pXxZGMjEKqvyU77pMj5Qxlo8/eTcYZ8S/vQMnyrP8gZsk+FKY/1ue+F/o?=
 =?iso-8859-1?Q?xwio/oMM/FwE6E4fSzqK6k7+CKFe5LGAHhOJkm1JvzEKuxrrITi3CU16DQ?=
 =?iso-8859-1?Q?P/CcMoRE1HAfu9+0vAZAMfAfowb4rhQJk+ir3q8MRpYxD0V4RmGMdKn6fk?=
 =?iso-8859-1?Q?33rynX7rQDI77XPt8QKUliCjfSXk2BfjTn7FOpShny6n66hQegOcRpsKOF?=
 =?iso-8859-1?Q?vpd61obQ1y3wPDn+8pcdsNVeZNzrDZNiRJsQJ1S0YdyA4no6OrnBb0Gu1a?=
 =?iso-8859-1?Q?AfJ+J8ug5NS7Wpl5UqQBWji3CCvbyvs3t+BT+NB+08/iEiLX0CudbRwAKk?=
 =?iso-8859-1?Q?/2YikS+DR3SyoaPbRCYEQFgsdboa1FM79ZSp35w2trMoyTjjOWFs5T5/Rt?=
 =?iso-8859-1?Q?6gqtZjFv+5ai9DnnvhpD2w+Pcwd/lIsH+1tNmxI7LTcJp925apLnxuRyvq?=
 =?iso-8859-1?Q?NDpjeXwW24wcHiDhdGnKI1fi5yh86eklnm5X5iWSKzbrsUHHB1MSpqc8sx?=
 =?iso-8859-1?Q?N9+JIcRLSXJPALgvXfXHgOeJXNnwjwF0cKIdFqXQJajlqet6uDgaT/eHyp?=
 =?iso-8859-1?Q?5xZhHfMyjLEyHMtI4FaO4grw+xEVPdqlBq/eIr2JJrv0q+isSXIkk03oy7?=
 =?iso-8859-1?Q?O9XoRUKi+UmB8fkffFcBdQQPlI8cF0KtSG1Y2otmLNCg1OPGn9YGFbSk+C?=
 =?iso-8859-1?Q?Xx0smpuUXuk0tkNNA+vbT2tBcZoAk6WYSyJjyE/CYRDcJBLuqdhmyIqiTh?=
 =?iso-8859-1?Q?vNQLgCASwOnAW+hB8WqNHMnc0mOkvXsOsD/8/j7eEMCb2oD5PUbgA3OP21?=
 =?iso-8859-1?Q?+mRSRf2lVHiwApjfEZUXhswZgbzGf14JLKs9qE/Al20kVYE6CMkLMn99AB?=
 =?iso-8859-1?Q?jqDYM0HvMhABlNRFnma4dfCk5qWOTfeprchugS1P8Jx2nzVtzoFSE1tU+V?=
 =?iso-8859-1?Q?eVQd8nRibTFSEQ/CuZ/t+MVOdUshVExswsEKHg3+VCmz7e+E7rzjut5Zjs?=
 =?iso-8859-1?Q?ibS+5XybqpPuqTDgdYo0cw1ETP19K1cg3xZ8I5ffgfk3ZAgNZljnWNaEQJ?=
 =?iso-8859-1?Q?G7PY5/OHjTluV1VSummXqEt4fQcV7nbPvkphoPuPYs0hc4/U1GbVGDsJap?=
 =?iso-8859-1?Q?53RmpDR8QqZHP2hL5GFeyOJJ38UvKiIp5AjXa55N1rXL1ePnWeeJ8p5suB?=
 =?iso-8859-1?Q?kVisqKEXZfk1XK3rJglx/Xc5cVCzKTJ2mVtBxUe6ywd/N9ZHt8GYBcvg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b5e183-ecad-48cc-c984-08da844ffce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:34.1595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZYHD2iF1iBFqOgc8zlFvozp+J1cEq6igTqqlSJqRysSsd7inLv/2Q+VYTXv6Exv5Ay0iCzFqaeren/GlkemUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: btMP6SQiU5HA-CDa4lhb9_S7UlxA0R2f
X-Proofpoint-GUID: btMP6SQiU5HA-CDa4lhb9_S7UlxA0R2f
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

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4441f7ed197a..5070af64b99d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -390,30 +390,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -3178,11 +3154,10 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
 	unsigned long charged =3D vma_pages(vma);
=20
=20
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.35.1
