Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DED59C265
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiHVPMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbiHVPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8073FA2B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirIT017918;
        Mon, 22 Aug 2022 15:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1gGgnmnzZTiH4CWqaOQaOlKOGm6COOZTpG7+W4yswJA=;
 b=fVaT8Vo1GdLAXV+1q//mlx0zee/dUROnQ2pkz10DBDDVsE3DVSjoZ/gBnhd5P8fcf1bE
 3BMxUweGWxVwVNIICfZYlrF3wVM/D0ziy8YOXtsoJ2bFdfFhdEAsfleAhMb1mWmAY0hn
 2m0meFq86mIwFTA8IIUZ+krxcvQHHgr6YzUahhimX3ZEB0nQBLo5H1sI2/jXLgiAwur2
 MFeksZYhkyVu/jy+aAeBAWmmcZgtlYbibUifz59cNTgF68yLAt1AO1Mq9OGiJNX+HbA5
 PBB9hauACiv6xGVloR+KdfPo4YIIMV+MZDfPt/IunFf88ULrFud8lpzcLJudTgtvc7cz jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt04dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4MWl035318;
        Mon, 22 Aug 2022 15:07:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1u2en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVyhnyD8ScJSNz9yaOwO09F9tmW1XcmnnVWJ+tIo0BJX17i2wwcMl/wmA0UQRG0yexCFyb8/1xtiCD+hg5MBXd+by3dENgoAyVgP1xulqPRNqXO7J2Qe0rCJSs2wbiqxPuJJr31+OGWocRrzDmZDISOiaYvYw1EBcZVaMYBDhaLsxt1ZdxX0wlaKgbcfCG15hmggJjH4c/mxi/SIFstar9ge3EAmvueHEhU5H/EdUHhaZkIs2TdL7Tn7zpj90ibENV8+j/oxOqMFI7emzTFD41H9seG9gyRC9qZ+7lssIihkH4KJg5JO4g1zX4dVj/6FMiwTdTqcGHvuAayM9ypmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gGgnmnzZTiH4CWqaOQaOlKOGm6COOZTpG7+W4yswJA=;
 b=lgtcWntYQvdYhug0IJGxlWrHPWkcVUFCGLRcexgjJstDO4/q+Za/gqTLpg/iAahSxRWv6u+GOyhB4MM3e1c25t2ymHKv5G8cTisNtb4MuHB7hebUTf5Zkx5VMxxKo+jwjb7MaEzmG0bvzgbvoVbW4uu+/7gYKQsgyQBo1CO4RYuYYRufFia9c7IHiHt6X5pts2Xj//uszYJJbOXj/WLGitLArj+W7FIDjrXusBMsjxxxebZpge0AFH300v0AOAkjbq4EAxDlLHrHzFw2TKi/Fj3NXORgLHTn4ExETg3x2rox/FvycRNYEbVZN2mMnqHDnXiAG5falsmQvQxgrhUzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gGgnmnzZTiH4CWqaOQaOlKOGm6COOZTpG7+W4yswJA=;
 b=Ai+rYuS/x/jhFL8mQIQr4KKrV02Zed2BgymH7OddxIBprOiRyOOlA5oJ3gTQeZKEohIuHQV/EW259XPshNgklDIeU5/FziEJFPuz2p4F2CkLvMsz/Nzr6ngAkv/x8eyKA3weIxibefDP0aj6XrkJA3+8ecbjtn2sJVuMCah+a/c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 15:07:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:07:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 64/70] i915: use the VMA iterator
Thread-Topic: [PATCH v13 64/70] i915: use the VMA iterator
Thread-Index: AQHYtjjDWgfgbSHc2U6pwSHNa70o4Q==
Date:   Mon, 22 Aug 2022 15:06:32 +0000
Message-ID: <20220822150128.1562046-65-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e98a07c3-ddfd-4a89-367c-08da844ffb02
x-ms-traffictypediagnostic: SJ0PR10MB4512:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JnEd4qg+WzkTodOhA/Wquk5gMv1dHo0F2N+p6IPaXh6/tC3RHya9tRketK/nV4vk5uZacYMMsDst8IQuf+pd6V11I7cY9eaFO1JmULxfweiUoXBwLrj3qR/3C3v5mgllS6CyFiw8RGtRDVnj5oYXKQ6nfEMIB3AYK1IH+lO+KAd5wxbQYNhAp3cvWFRQN/s3cNeKCkYWXUGzbjWR/CiNn+qXCplUyD6nzxxo/3vPg8F7If+wM5+QqAKW+SprlLlUQ6adwA7ecYAo/MsuoQBQSvZkkkK3u4yo3u8DCb3zJge/eTnP47E0hazLIFz5fcG35D96UyknOEQeLNEv1x5D0/MDoS0vF7Azecn4eBSlenK1Hku0ODwYZVGmnoovl1mFzFWiZ3bmAuZvmlwajJgycb0/8dv0czdNl3GJFuRcA1fbck3TDCQNjeb0x0koWn9fdbhBb5PT4M9qwA1i1VLvEWdFbF0irdkoAAFcDdnDenfawgYCLwqDi5fMcYnGdjXVMKPkdsHng2lMrszM8yLhwBkB4Op5L+eM0D5eiHXe4yFbRGt2svHbN7SpgGAyrLJwPTs+5Z1y+53CY/T1rtqU7JRgxmxip7V85QNm+qFKTGxEjwVp6t6A0EyZfTWea0GNr9D1udjisZGRMIMp4zfupJD26Cbcb9ssqNU9Hw6FMHHV54xvtfDt4r36yWu3qI0IqKXMy0E6wD6R3HalmKcsaBDKmFV13BVFdmcpAlO5JFh+eqCDTY/grxDGhx7/oDQ7AX7Dx3CIWj/F+K4hgFQn5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(376002)(346002)(2906002)(38100700002)(86362001)(38070700005)(478600001)(6486002)(186003)(41300700001)(1076003)(2616005)(6666004)(26005)(6506007)(71200400001)(6512007)(83380400001)(5660300002)(8936002)(122000001)(44832011)(4326008)(54906003)(110136005)(91956017)(316002)(76116006)(8676002)(66946007)(66446008)(66476007)(66556008)(64756008)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zGG2/xzkt+uz4aTJE2+FqfwwX2of0Be8ypO/THPd1Pa+dm2wYXwCqHy6I/?=
 =?iso-8859-1?Q?fgEi7Nn/VkUzoB/wtRPKf5s5jN5zgH4ufGZ+AUdqSwPGMsIjS6DJnMv2/L?=
 =?iso-8859-1?Q?WM9xi642Riq6W7dcNAXdJdtZjUemKDcPbNY9ojje4YNrfn/O1CUDwM0484?=
 =?iso-8859-1?Q?bPjnktPFy+VjYR46RToQHESkkqwHO50XTWNYYFK5b7dghURukJ9XgSM/1n?=
 =?iso-8859-1?Q?tlBej4ZwZxsKNB/r2snJVvWEg+GnIFj2YVPYaYRCHNFxlWByjnh6KJm27I?=
 =?iso-8859-1?Q?TeI2I639UfRSFv/r3fDMG+zeh5b6ZNRGrOF3vEh3QkAjIyjYuj8aVWCNFi?=
 =?iso-8859-1?Q?0TMpALoaZceBm9uim3F2GtYTvDtJ/BMDpdUmQvqhBCIghViIQl0qzgsqcj?=
 =?iso-8859-1?Q?cV42Nic+IVsL3E96IJ6LhTbhm4EY8RpUaoV/dOO4Vse2tGh9zFnA2kZT4j?=
 =?iso-8859-1?Q?oet+I5R2RT/ktaZ22Derf3lFcURylJOA7yMc03vMSONW3NUGyBYFQwpeg5?=
 =?iso-8859-1?Q?yg2vG65XU6Le+Z4bZ5Vx6uJ4ho2QnbMA1MYB5hMIwMfb5ie2SW/pFZPZ2t?=
 =?iso-8859-1?Q?xQZdm6j85ROWKAU0Wyo/Cogl0zN3K/WT1UQiCiEAZKe/0njxjz9tmxI99i?=
 =?iso-8859-1?Q?MnK51WdSgR67IXNU4bwwK1RLbc27GpA1Pdq+pQQ5utXgTLbQBLkkJ9cYAw?=
 =?iso-8859-1?Q?5zfEYmnvMWhdS4QR0BYm7ksEQv77BoH9B8AQwIupgLUdZ/NwxUlo6Tm0fC?=
 =?iso-8859-1?Q?k0ZHzQ0WzdYZ3Ny4tKjWf+4awrSRoxKlmhoOt6l/U67GNgc9BdlaFLXu7L?=
 =?iso-8859-1?Q?OAZuj6KQLLKXVJ1ZtXE6X2GIJzq+IuVR0phrpyGsacFFwXbfonYDSgeply?=
 =?iso-8859-1?Q?I9qy+xeFd3VbOO3BcI3Q/ssTezKQM92IAFlLOBUx3aD4k6rTkc7GPEwY+c?=
 =?iso-8859-1?Q?WoVxtk1WfbNekCGxZIaP7Cgz48LMod9TmnUrQBVfPoc/k/yMSuhs+ALAql?=
 =?iso-8859-1?Q?qX1T1CgShBG6yz9Uqe+nKpUy87m0i9+3yxq9MlGowbsuNyeaDNP1YZicb4?=
 =?iso-8859-1?Q?+3qmKncHcHXDJC1Fb6KtFqSqHiy/S6gMibSXt38i0Gp5sdihJrxqpZyZgm?=
 =?iso-8859-1?Q?+hK4QcLarwD8eyKbNJVmukgJjGXLXA+K/w7WVlvR+PwGM0vfB8NsiHlhqH?=
 =?iso-8859-1?Q?un4EL04nio0YtTYi+BeGu7oLjrRNPVtc48TYtR50TuS83iFzHmG7WkQw9x?=
 =?iso-8859-1?Q?x3TqmqSfm3LQKfFFWvybCMLWcP/AckjTjEs1axceTLq5ODlXDw4Ergjuc9?=
 =?iso-8859-1?Q?emclyw4yXLKWc62SrsioFAMJOt2tpyYehShZ+KFQDyzu0AKoa2xcSeg9Ug?=
 =?iso-8859-1?Q?0QGTAppy5jDVfrzSkffdqAp/rlEXxthlb0ba6gJOqxv8/NNwVA/AsehetA?=
 =?iso-8859-1?Q?lkwCtur4VQS1gFOcqIJGwGdBcpvd+E4osNO53vlPbji9T9Zskwj4/iqJNa?=
 =?iso-8859-1?Q?ylStdOimrdV6HVDgAu8yF95A6z9fqQAbZ3i1ZTcVN2g9KwcOlLftV05D9L?=
 =?iso-8859-1?Q?2SOcmt0QSoWtZClq2jYtf9QArWj5aW6DhBpHFvRNUk2Tp3qZ/U2QYhLEOK?=
 =?iso-8859-1?Q?8rPfxzP7IZFG0HPWzYFcZmT1gelcmAQfr5Ofr7aE3BwI57n6w40qO7+Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98a07c3-ddfd-4a89-367c-08da844ffb02
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:32.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lF9wuqE19gTY/AYZP5c1r2xViCJYVYleRUXnYAWNbiIAtcczFgPsZQcwBaDc8hIRYiS3YfD/2Jx/T87seFv2tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: -EEI6ffCMAD1mx3z0oIRpc-c6ny43lCo
X-Proofpoint-GUID: -EEI6ffCMAD1mx3z0oIRpc-c6ny43lCo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Replace the linked list in probe_range() with the VMA iterator.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 8423df021b71..d4398948f016 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -426,12 +426,11 @@ static const struct drm_i915_gem_object_ops i915_gem_=
userptr_ops =3D {
 static int
 probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
 {
-	const unsigned long end =3D addr + len;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
-	int ret =3D -EFAULT;
=20
 	mmap_read_lock(mm);
-	for (vma =3D find_vma(mm, addr); vma; vma =3D vma->vm_next) {
+	for_each_vma_range(vmi, vma, addr + len) {
 		/* Check for holes, note that we also update the addr below */
 		if (vma->vm_start > addr)
 			break;
@@ -439,16 +438,13 @@ probe_range(struct mm_struct *mm, unsigned long addr,=
 unsigned long len)
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 			break;
=20
-		if (vma->vm_end >=3D end) {
-			ret =3D 0;
-			break;
-		}
-
 		addr =3D vma->vm_end;
 	}
 	mmap_read_unlock(mm);
=20
-	return ret;
+	if (vma)
+		return -EFAULT;
+	return 0;
 }
=20
 /*
--=20
2.35.1
