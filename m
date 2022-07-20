Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F5157ADE9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbiGTCSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241129AbiGTCSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342695D5A6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0JPuf031784;
        Wed, 20 Jul 2022 02:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vq8RH40TsT9FQipIUvGj8/ajFSJ9oSCPJkoNaK7jglQ=;
 b=xKyhYt6TnfVzjerx+fm0J1PSWWm5B1ATE5nU/MZFT7/pSIr2C0A84Dn6XUtlVO/jZYN2
 PHHQCWoEcS7PqsfuerSgy/Gcxq9mVsIa7e1MHVm6F2UOwX9WVgLqbuXF8XS1GeQOnnk/
 u5voRhsZZWeqwWov2w8WiCkwfn8MuND1Lw3RsBv2uNvaaX1acfUV9S2i6zXHSMlqx9oo
 lOX52pHOyqstjz+Ak8I9NoR+IDc84IOt6rMdwuver4U6C00U2pYw3hmerKNt5ex0QdOX
 oNxd2QUGd4BUwbece27zbvuNRmhoUmfwZWxaxprSSD+16xnfg6fN6YWAQ0MdUFUZIpLc 8Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLL1022321;
        Wed, 20 Jul 2022 02:17:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMmuAfGncVNoQkkJpkEAZOMptBXQ2o7TY/RypJa73FjZ3ev0tkN5OUgZiKVJ2wVOrXwjNqs7MZCCr1wTV1rLpBYZ3cZWT+c3FQoCzon/Uqo1N8gnQ5HsFjfD0ah8ARrvmNDZwVINKD0pP73h3EJTlvHn4VAUCGnuMlFTTmJQ4Yx/7ols5a7cCT+7CSUTrJuXRfrTUcLUQoYSC3Op2RoRLyGSITqYgLaB9wDqsx80dS3SBi4s42ZCChozFXXkkvxcAANB1b6cqp0p9gJamZA7sd2tFogMzt6znZ6I/lFs0YSncBgS/IRgJsYyZC706LSC9WZlyhuwZ+s2Qijgpw4PhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq8RH40TsT9FQipIUvGj8/ajFSJ9oSCPJkoNaK7jglQ=;
 b=JHjN4DLKLdlQAT5+IFUIeNjzPlXSo0Km+ZJRtuDrK7DDcBvqtuVhTEa8iIbeC8gLB4lzzKquvnq/4cIikrBwbJxyQ9iJgUj/086zw3mho49HODuT99P7mPmIXtwvPcUQur3TMS8LJNH+PfVO/xcYek2DWUPu4hHSsinVSPlfrXMtpmJzSrJvhtDhxx2MacYHG/IajhX+UI8kfGPULIBbt6k1WXT646ReGDhpoPdbQWDYaF3V9A7togeuo0iqiX1GAZLSZ+DBSDzI9EyQTxYctceLfLnFXnIBcYc8mfnSKOiAbEh4F4WJQnGr6wT84uDLzuDaLKHLfy9kA5t78j9hUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq8RH40TsT9FQipIUvGj8/ajFSJ9oSCPJkoNaK7jglQ=;
 b=hE4Bmp2Kd+ID8Jral0peOa1LKpTYtYMk3AmjCifK8N4fALocm5XoELel3LYbbftuTy9wsFbr3iw8bUPEs0ZVpQk5bCjZTX8Gpuyf9coqzw7ZsJt0taJa9o8YOMdVHkPbV6uwHnsZi+v4ew/hjkr88cstFFpfCc+MDrtZ6jQVDDo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 14/69] kernel/fork: use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v12 14/69] kernel/fork: use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYm97nvYlFhXxQ2kKBr2bVDaTmgg==
Date:   Wed, 20 Jul 2022 02:17:48 +0000
Message-ID: <20220720021727.17018-15-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65aff63c-6166-4252-f492-08da69f60bb3
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kh98/cIj6hBGN0o6xyNRVhAhyCA3yt3ifXRIXOvL93YK8Cu8ZuOMFPORes8+jJHN8afMJCgkaoG5NQrLDbgO3rJF4Epk6ZKKIGdTqCN46mnpM2LSvvgSE7hrNkYjg03y+xZZhhpQS9Mk0Te41ukXLV9zAivvslTMogTjhUaFwqCdWZEH6r17YHhx8KxD19OTBmeBSvhnMmTC6sv41fVUZoEUrebjwsl71d0X/hZWC/lU0GDkkkPIlZnXVmo5oJtf0BxHHk5NdmsnuPaoNSVjnv3ihxv253oxS42GYLNC3BJpTvQkV4sDrjG9qt80a4bJtFnyBBrlx5xTi/6rZ9D/ZUvIVAZEAmhLo+1dUSVT8hF/Eh+eCdCj61o7ZM64ppIidNn5lWiww/HZM15AQgrY+d0qUQLRnMG4L2svcMBYYvAPy/yN0J7xxyQH4/91K/rARjMSiFmdVMjt3oax+Lno0Vb8DcldF8e9PLAJ4RKwbtzxw82H0tu3eH514SkJ2YA5JB3Uf/PKLQzJlbgXBn0Np6gvquhXoUzGMvYVH529565rMu4AWdtcGwYniBaEsBUc2hgybRIh/t4tDNJ5n6OIij1RJcV3gz8FAl2jYi6jGMW7Qpc9Yj082hzqsDcjGZjdJZbwahryWJ3MlgDw1/8CUOBmgeqBcFwQT4KNSPR5U4Wfxg6AnO1VUuZEhDzjjCMwMoqM/Yj/xBN4kymGaLvXee1j3NxncuzVd5gN4c1LGGLT3YZ92nHSoM7dp76/AF8m0uicNn0IZbcp7SZPtnrOYPCHsdWDN+koAUefoIMauiiUlUKhI3TuiUIo1FbV8vqbFDnC8fR3nd/KkCCR6wpBcvcWXOC67ee/vnR99CmxKEy8Sh7CKMeB567b2BKTfzqF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HN+3hN+UdaDcEV79zgBz0KZMwQrMeRwwy89SJC66hOuk0IF2xTMMpr5lGh?=
 =?iso-8859-1?Q?saWlJKRuDdS3gWcHMG8k2dpLHY5mXvE0XTtwzb6u00mkzOoZAykedKVuvG?=
 =?iso-8859-1?Q?nt92qnttTlaNJLNW9cPs+r/12BocwkmA1Bq4JX8Q7UwFIbZOYVBTTQS6N+?=
 =?iso-8859-1?Q?Fh6JWH5HDwN+F8rR9zR7qzQa76mxqefsxGPCXK0tIsMCKl47CBK3sO4qe7?=
 =?iso-8859-1?Q?zwZx+TAs/hQU7jil4tp7ph8wmLgodaavFJb7J7M/WubK8md2/wUM80g6rc?=
 =?iso-8859-1?Q?EYnjuze4HcDpWYVyQppKF2P7X/ooRuGeAAdetYR97pzC9UdBlIoWErRHK+?=
 =?iso-8859-1?Q?w+6CHszoPXRyEWePKAHusof/L5b0JDApYbcDFUA2jMOs5h1buhwddv4FSe?=
 =?iso-8859-1?Q?hoMpUtUZ5uh+ZrY3hCSsVMs1xTybjXZ7cMb1eIw1SeIVp7d+AtFWmu5D7u?=
 =?iso-8859-1?Q?CxBVJgS4x3iAAJvv+3K67xfdFkET7FPB1dRgtRpamwcHymHfjL+JIz21nE?=
 =?iso-8859-1?Q?4cxvFTj2WPqSywaDgbjOlLI7jLG2o0nAWnpEPu6bVMiLk/4k4j8XOrDKi4?=
 =?iso-8859-1?Q?k62M0/0eb9PuBuxtE/lRhjSM37hyb4YpAwNzUfez5aw06QKJ1h3AJ266pK?=
 =?iso-8859-1?Q?RhTmXUBcSOmc5WUPADdecJvWnMyiW3UN0IIeZjGwRUUYkPGEdmRtElSORD?=
 =?iso-8859-1?Q?TZ5XmRb3EIrZCmxloLS6COQ8/e6JIbfZUKk+ItxZo/J8UtVfwQLG+FEtUq?=
 =?iso-8859-1?Q?1qH8Wf4BtE8vtg1vW9XMJDKQs3t6l67LhLjLu4sbk+0pKhZI8QLT+O+qSe?=
 =?iso-8859-1?Q?uncu/9fNAN0aLnRr5wH6MWFqrJAJbCO9Ynk+nminTTBfu1cZ+v/r9rk2qq?=
 =?iso-8859-1?Q?x/AU/xBr6z231dCULzCUQ0WsR81eif/KwWY7HcCcWQxf/7uUeZ5oLqT5s9?=
 =?iso-8859-1?Q?5Q6RB3MKfdtnWPG5Ny6wWOF44Vx++COUkJxBLhwTJzaeVO8lra8O2UAJd1?=
 =?iso-8859-1?Q?TrqI4OZIWWsRAJ8sTmHRUySSkjommt0m+17OIUm/pKgaXsEtf+uzQpsQbJ?=
 =?iso-8859-1?Q?VZHfxSUXKSQPFsGA5IauWPBJen8G0I7xlQajoz02ic6lVuaUic5le7Xby5?=
 =?iso-8859-1?Q?B7Itsh2UYJNiW29jdxpAzXpEzc2TQVNPdHyDW45mc/YFnstvUeKgyPJ1Bu?=
 =?iso-8859-1?Q?1gv3hcBi+gLE1aSwqYfGkbA748zTUqGM64y6gxdcQvbNibvmXBr9wFhbdW?=
 =?iso-8859-1?Q?hOLmu8WoJ3/Ew93tx716u8BDjrENvKMQ1Cmj60ZkNPOI7aX807JhoFIA4h?=
 =?iso-8859-1?Q?UXa7WJpix8QEVmpCptuuQgIii9eiVTRwl2xxtapCOFQmHRyzgDs3jfAwcE?=
 =?iso-8859-1?Q?SyX1TjHOzdQi0FVAucyXmVg32wUeZu/g36rwA7QgvBjulBVAfKxz1G6xnH?=
 =?iso-8859-1?Q?91eEsshWLjXTv+uH55V86EaEmH3dkuZscwNz46EmfslyncUGlVtmlXKMNf?=
 =?iso-8859-1?Q?GToBySEh4WwR4FMAxYlOpOPXp3I/hiW50EISxWl9hhg4RNCC2ZaHX0G/oF?=
 =?iso-8859-1?Q?dvhXvgEG/Neac/Ynkuc70va2HCXiJVeWyYiPbK2SWbpef+uBZI+XMWY6Fr?=
 =?iso-8859-1?Q?caPGmqDzj3LriWGzUIg8j8C82cCgWajf+JCFAA4Ps1imB4EPhvhTaM2g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65aff63c-6166-4252-f492-08da69f60bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:48.1656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1siv1yF9v4I2U/tXD3EnnTl7MLjscnio/Nr1fWLy4JjfRjXc3zEaUvaCxgAcneOJORQpxdMwWiOAuBdjFUBCqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: HDpwpXU-6mt7hCzlyK-9r2VZcgNeEtj3
X-Proofpoint-ORIG-GUID: HDpwpXU-6mt7hCzlyK-9r2VZcgNeEtj3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator and switch to the
maple tree advanced API to avoid multiple walks of the tree during insert
operations.  Unexport the now-unused vma_store() function.

For performance reasons we bulk allocate the maple tree nodes.  The node
calculations are done internally to the tree and use the VMA count and
assume the worst-case node requirements.  The VM_DONT_COPY flag does not
allow for the most efficient copy method of the tree and so a bulk loading
algorithm is used.

Link: https://lkml.kernel.org/r/20220504010716.661115-16-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-15-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h |  2 --
 kernel/fork.c      | 10 ++++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dee609fe5c1f..60045508a518 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2613,8 +2613,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* mmap.c */
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/kernel/fork.c b/kernel/fork.c
index 1840da0732f6..f575a3bead0e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -583,8 +583,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge =3D 0;
 	LIST_HEAD(uf);
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	uprobe_start_dup_mmap();
@@ -620,7 +621,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
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
--=20
2.35.1
