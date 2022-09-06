Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA225AF4DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiIFTv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiIFTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5B311823
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYZP029954;
        Tue, 6 Sep 2022 19:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MEDgPXAlWlOPyvOGiJ9pmE6UnmPGJxkZid7GIoDqjgE=;
 b=ZBNbpvhuC9661RDqt/Sks1IVdS6R393NmLumut5JNR/IB8tOqMoVnhgoYbD0t9TyU7dw
 z2wwCLq+ZczV+xjkXWueWRZNI/OaB2075srM4lL+sGHxZt7Pf6khAVdD6cqrNPyclvpK
 lvjqc9Cg8H7JqTwPu6i5DGw8MIjymAyeLkUaVpUBHkO52u5UHDitQ1SN193o0TAyseW4
 w1EIzVKX3AhQxhIxN7kayxtpg/DEUGa1OAlzEjHqycG8RCarbKD+4j5Gh+mimm9hy1xU
 CzWxnLs54FrWvtgaD0foH/SFPG4SB0QS8Gi1nvcv1Idmh+Ko3I943BHThooioq8ye9q5 ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wZ027549;
        Tue, 6 Sep 2022 19:48:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRS7CU41lPHlgBTXB9a6py6g/5mt4PPotNXwd4cMRu7oqUAM0c7zgu1oDJc9qgNHcjCMUiQgKXoB6/AOsr5TWxKnQuFyRpow3yIN1UHIZVNPSN0RIcA0Wd7H3WUhl0yGgXugdtduw5mdHmfTDp0QlrpC6Vh74WwVw/ThKcWDOdwn362V9q9p4W9pCP8l/q6cxzz3Cj2p1K+KTT4lNvM04G35zjlMED37poMyVU4+Rf7l2nUA1uLBWcN5xVZsvKuB29QfR0YyWjLO4B7EhvqD5wS8qnxEOJorWNMcGfbI8KMJGNa8VHQm9kr2Ch+0c/QXOC3qgSna6pP4IveQw8lngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEDgPXAlWlOPyvOGiJ9pmE6UnmPGJxkZid7GIoDqjgE=;
 b=BSX8hV+Hpb/48Bf2Hs7qe9rfG6sRg5az8TUWaO3GWi7i2TE4YsrKomOYAHUvHiktDaNrfmw8Hm9lKp9uu2fb0UOENPKtJYQ4im/nFpv5kR3SHGhFtMSGFpLTkVu/MOEMC2ryGa/covM2U3VVjIx6qYCaMqgV8u60A/l/o78edVomAVUuiAqGkDvOZYBWA0Jnf/b+SwCIXd2zRbulmNfvrt9LZx91Y0H0B31AvjXEree6RWM7dKTeQGh3LfDf56DkKATjnKcylvKBvdp3xiywLcx8s7cx9U7U7408C2TcJPVVFamJc+9AC7lPs3FjnW7MgkgomEpgJV88RNZjKBIEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEDgPXAlWlOPyvOGiJ9pmE6UnmPGJxkZid7GIoDqjgE=;
 b=p+8SlVw9al3GVcidYLPEEFmi1pqGA2/sqNcWcK/IyrEQyc+P/G37EexmXEnTiajbB6/7kNuZoq7LRPByiZDmRNF9cDiv23QFpRp8TWpn5r8zHcYLqZW6l4GjklWNh5+nAZMipI6UsWgnkrLhFAax+lKFscJewLHjVw3uubYX5JA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 16/70] proc: remove VMA rbtree use from nommu
Thread-Topic: [PATCH v14 16/70] proc: remove VMA rbtree use from nommu
Thread-Index: AQHYwimuoWHBy3ySy0CvrO5Nh+4BGA==
Date:   Tue, 6 Sep 2022 19:48:48 +0000
Message-ID: <20220906194824.2110408-17-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1df7a09f-f427-4de4-cd8d-08da9040d4a3
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IbmnntXI/oq0dWEOsM+64Ki7rCRjdQ+LIPxW8sNlWyIyf6Wk5Vn18JALld4+XIj2XlIIu+mehRqxLLR+u68YPAaF0j7eXOcPn6ZUW2dFRg2TCKeyGWvXSgM6BD3e6pR1MB2h552ThB35zbtZAQr/2BM14iQ7xbQuQsSpDrpYQLZSnI8kxrHG/0Gx1KZsT3VcVJ72U9iIF5UTHzT53bpM6MbHbr5K0g7ejbtUtnAfXICik8xvNG96KYyBntE8jm5QoamUE0isiUc1JPTcCGqguyfKs+1aEbovLIg6183mUmdIycBr/MASbw9QotWFYZOdRuBH1wDUi5BarYLW/QTqfQelgS9r/7vc3gbbYmAgn30ugYO9VwNeMh7kOGiaHoOhf5vmZVgrnISBgeWg9YQlce/EIQ1YlFKwlOfOr6U1dic3e3Mj2ql+N+IAzLmkWTHe5xEdmAqVOAg/SndGpX29q5AsUWB+LrUkuJGSCkpJsX0cQL8iEvmwRHEFuPX5j4zY3dEsQvgxDKVZhp5kDcZqDzqavuz7V91o/0xSR/VtNU5tTwamyjH9DBgzdY7qNuwvSa9WSzCYf0FJCfRVImGKNesIASTuqBvuiM5k6wIDR/RIlMbJ8wEBPYGYciKp34ihvPzkCA57rCS/FZbbsKNS21/EzvCIM2zlz1B6z9jr9IwO8IeoK38w9JP9/4yn6YBMsuzVxiNw5FK8g7YTmf9rJzq6262XQHnZkJTBSxfU+djLqc34sfj3TEEsABCTYgHWv9+WydwopkPP2pf24aFdDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(54906003)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BrLORqdM7D7iDtoBeoW3ZU1czRmH7jktBdcoc5QUa4fVbzq0vDrdEDUnpc?=
 =?iso-8859-1?Q?5nadT3btAMBUeTp7hmmYIbk0TBKb0/kw1dEoTgtlfEDPMAODTRjdG69Pyx?=
 =?iso-8859-1?Q?XwyCOHwPiZde6nXDiRS8CxD0F9Onxu+xa9F7bh7iwI64C35jFWY0BVLN7H?=
 =?iso-8859-1?Q?FawK9mypsaoJkEtD0UvIZeY3yOo6z7apOWObax2e/BH1XXcXYmgPKPglHv?=
 =?iso-8859-1?Q?21XivAHy2LVTMUriA9it3mzEs0Az6fZZ3R7ZZc+wbq6z1QhBjLUZPoEK8h?=
 =?iso-8859-1?Q?FUfwjhBu9h8avgElrcARE1Zhipn/HRU2y15lUo+ciCpV9BBJAdsWDA/MDo?=
 =?iso-8859-1?Q?DWnOgJ6XjqImogdf7gIp8PWxcOpVvFQrw4Em2OZUOCK29YJ3erniHrQSEk?=
 =?iso-8859-1?Q?0KPQqAFmJoo378EGp6xnKlAFfqN9T9JYb5dglDVBJhCjNymdAqwBrZ5dID?=
 =?iso-8859-1?Q?uHIsNfbkV/bg8/tuxlqlVh8t6n5GDszfqB6/JO3TmgSreJBAnQdjlb7Hq2?=
 =?iso-8859-1?Q?U0jnAmdHPUZO0cmzgnp25ohVzmcWbbc7TROgvI3c1J8/6scklIAUuM8nfn?=
 =?iso-8859-1?Q?eS2Ib2n6WXusgmVcXF+NGgOQYhAJmsjm54VOAAoyN5lxAFWLDtVYvRObRM?=
 =?iso-8859-1?Q?ugZ+797iXgKYVDKHIeoRoIM8TTTbY1ne1MhnAUCs0R0C6Rv8kzmCmHvc5E?=
 =?iso-8859-1?Q?kIcNXzPKRt1GXPs1Q9JDT8PP/6D3wE23aigQhdj7vJjMTxRkOj8zqkX4Re?=
 =?iso-8859-1?Q?9tcLdVIQXIqGbZxCmFogxo5HL5qRP/4rUhVAF/MTtFzYGeMHiQy36EdAoo?=
 =?iso-8859-1?Q?/3Kz0FLtvCy9jUpwczz0kLVbIg6XQRBgoYJt44KMzR6DyCjoqO4MX8qq0u?=
 =?iso-8859-1?Q?6NYei4x4zvTCU6BY1wC8UUk4QolqWXedA5FeNl2OsIEyj8jwzda7udQjop?=
 =?iso-8859-1?Q?pZbeBS8Jj/7ggOvVN7+3gqNX8nHGCkPKbdVwpBOhnCCtavAdvti07lHE2q?=
 =?iso-8859-1?Q?fQekO+425oZmCJK7jzwqEUduXo/YVP9hA2ROmNn8L8HHm31Hb97W2bP6d1?=
 =?iso-8859-1?Q?XRnYVOPnpmONru1QfO+0EBZf9Z0gIwxTQvokYTxPfjN9CNNeuPLg44kHHp?=
 =?iso-8859-1?Q?MHLIz702Pkg+gg5TcmqcghYxsuM43BouwzbcY6mRN6OuhBoqKkr7mLTkun?=
 =?iso-8859-1?Q?Y42iSbnNb7SbuD74Frk9dKDXzymuZuS7At6GCjg/6vAV/lhTcR2JhpgtA1?=
 =?iso-8859-1?Q?ZQo9ymN/PHZG6s22z+vrKVshsTqgFZFSUH6MVtuq6nB4PWL1xR3DXh5jnB?=
 =?iso-8859-1?Q?bvLbWzq48eXg5bRJ1Nj2s4sxQ/2h9pFFmAxF2R2MnOVT475M4ChwY1tPgm?=
 =?iso-8859-1?Q?I10+SfuRBoRXTNZsXOqZ+e8PIkmTKE3NVf90j2De+QsH78keX7zSY/tNDp?=
 =?iso-8859-1?Q?re7DkXmYvX7V/YYfkpua0QJgfHcfoNofE0Gw953x0BYvrwgvSzZBsJb/eY?=
 =?iso-8859-1?Q?Vkp2JuWmLQoNDAQHa91V31Mr8WizjEyvGHMnzGMjx5g8ISjMP13yFA7PIA?=
 =?iso-8859-1?Q?KLHhEnMe6HcCwCzbvVKyzxnbAVwf1j9oCcHX5+fKu5pMaqqVSpnulmGJ5y?=
 =?iso-8859-1?Q?ntApl1CI2EzCR3mHrOVmQ3nFqzPN7QVd0Kha0jeJoxLknmrcObkbVV8g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df7a09f-f427-4de4-cd8d-08da9040d4a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:48.5380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSh79hJwSSF/JvNoYdDJgp+Q4rXSq52tVQ6X6SQqSpW3WSQyeSR9tFXB3fDxFi0JQHs9Re66uIaYWLqadz+KGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: cmPzsaxQaOsL1F1wo4CmFgtwouiMycga
X-Proofpoint-GUID: cmPzsaxQaOsL1F1wo4CmFgtwouiMycga
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

These users of the rbtree should probably have been walks of the linked
list, but convert them to use walks of the maple tree.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/proc/task_nommu.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..2fd06f52b6a4 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -20,15 +20,13 @@
  */
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long bytes =3D 0, sbytes =3D 0, slack =3D 0, size;
-       =20
-	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
=20
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
 		bytes +=3D kobjsize(vma);
=20
 		region =3D vma->vm_region;
@@ -82,15 +80,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
=20
 unsigned long task_vsize(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
-	struct rb_node *p;
 	unsigned long vsize =3D 0;
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma)
 		vsize +=3D vma->vm_end - vma->vm_start;
-	}
 	mmap_read_unlock(mm);
 	return vsize;
 }
@@ -99,14 +95,13 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long size =3D kobjsize(mm);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma) {
 		size +=3D kobjsize(vma);
 		region =3D vma->vm_region;
 		if (region) {
@@ -190,17 +185,19 @@ static int nommu_vma_show(struct seq_file *m, struct =
vm_area_struct *vma)
  */
 static int show_map(struct seq_file *m, void *_p)
 {
-	struct rb_node *p =3D _p;
-
-	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
+	return nommu_vma_show(m, _p);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mm_struct *mm;
-	struct rb_node *p;
-	loff_t n =3D *pos;
+	struct vm_area_struct *vma;
+	unsigned long addr =3D *pos;
+
+	/* See m_next(). Zero at the start or after lseek. */
+	if (addr =3D=3D -1UL)
+		return NULL;
=20
 	/* pin the task and mm whilst we play with them */
 	priv->task =3D get_proc_task(priv->inode);
@@ -216,10 +213,10 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
=20
-	/* start from the Nth VMA */
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p))
-		if (n-- =3D=3D 0)
-			return p;
+	/* start the next element from addr */
+	vma =3D find_vma(mm, addr);
+	if (vma)
+		return vma;
=20
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -242,10 +239,10 @@ static void m_stop(struct seq_file *m, void *_vml)
=20
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
 {
-	struct rb_node *p =3D _p;
+	struct vm_area_struct *vma =3D _p;
=20
-	(*pos)++;
-	return p ? rb_next(p) : NULL;
+	*pos =3D vma->vm_end;
+	return find_vma(vma->vm_mm, vma->vm_end);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
--=20
2.35.1
