Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2098C4F1756
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378403AbiDDOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378017AbiDDOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:41:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD9403E0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DpFrQ006418;
        Mon, 4 Apr 2022 14:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rKZ/CLZXoDoQ0F3e5nAUn27R7xtiWxUWK31ya5rJ5N4=;
 b=ir18We5iJMo/SnCpqZ759WNC/X60tp2mf8jc54JQb1Efi/8daK5Iua68HgzCOIHqmnfd
 lckpLVdS27Vak0JXgfdT2aQyjCLxUDcYSjqNzt2S/W7OjBcDpSnsWwq46x/PlahysdiY
 gNyXPaj2sKCnL9XBrcRbySwwBLFAkNIi4pyRhq+fid7tm9q5sTSQYYNp5XxVbAQ9laLN
 DRCUaFU/8q5J4mVtKX+CDq/i2BICOl4lsJvhEc+m1UoT3hwgZN7Wvp3PVg8tevmGcLYJ
 Axru1phdYnYgi9paIsQqA4L1JeEqHcEX6QP6DnJIdem33XiatHRFd5QDbpsRQnTfHgeq Hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGceY027671;
        Mon, 4 Apr 2022 14:36:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czXEERZn6MYOA9xhs5VZlbZRM6EB5hqX+Ggloi91k78jm6MT7tOBJfVI+GlhwdLoYtgoRZU7byYChjz4SM4AKNFab0d0ebmAUhracolqQciztvZKWLZgZlPklGpc8j85jjuwif76VDic+2HFnL0+mnbp6GMR1QRq+kviq71uqXFmbJsBshCcNB7ttxbNrMEf/mHYYpRW6YHGhJM3OnilBI+CgvMx3oLLb7QHH0vqBH07Yl3fV6QK+xUyJ75wxly/giXkRaHxRmHVHPdqfa+bWuhb3vrLDKzXaXqFVhLtqQBTjuJAVy+ZjqKsdk1aPXiC5MwS+kFu1gpKYRkzrXuQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKZ/CLZXoDoQ0F3e5nAUn27R7xtiWxUWK31ya5rJ5N4=;
 b=J8jD61RfSsSjq0KR3yyrVJ6vwsd6LiY3LgxLCaocp01zNP/2Osi1epSHs1ybeRnxl8tletWS+ZPFdb5txqvZAa5mqj6aHS58rhqmtaqTfnegIR82h+VngoGLXEfBmD5aiyYBCpJqsI7dosaAXNPrPh5YRpEvB8KGcL8tm+f0G/2qqv0w6tiGc8vn28MnMLKQrxb6cedatdNW+LRKV+CCd6JHWGXEBB9eeOVvJ6s4GIVBwp5UWphHTy1bS1HNSDIg14+FI7UcChxbP+sneTWn6iiAdBWD2s5HMo2IOnoYPlADcBl7TBmR2CBTGW+JhEKND/i7agtiC32xqhwgn9MAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKZ/CLZXoDoQ0F3e5nAUn27R7xtiWxUWK31ya5rJ5N4=;
 b=AGQ971eCNPhEuejZZvpCjwiPXARgFeFS89BF5QqVXXxHAJk03QUlDFlaiCVa72ZiOlvpYkB5af8WEHJT8/T5OquH9CcCYT7DBHmuFS5pNPHW+l9k/WfhgbBimfevz2CpqLCajirc2CKJ5ICE1wW392dyKqVC9z/UGNu+8ZrELnY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 47/70] acct: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v7 47/70] acct: Use VMA iterator instead of linked list
Thread-Index: AQHYSDFIGKibiMh/dEyuXl9iqRXMmw==
Date:   Mon, 4 Apr 2022 14:35:51 +0000
Message-ID: <20220404143501.2016403-48-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d0b0fe4-a3ce-4eeb-f5d9-08da16487ff4
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329BC107757ABD917A5C323FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZcu7Cc4qnvNB8KCd6Z58letv/e57nfbKGqTvJg8ZQOgxb/UHFmcNIoWaMy8sjejqpNvjwt9Xz2+IOKGCTIpVxOAlgoCmmULRDDXJDs2URe3duKe/9HcuZNxgLTVmiMqdLuJ34qShmrHI/q7Vd2Sy/VyJLPGo5QrNUH9j+4boZdARGfmCeX3EUJZcADpVbcmA0p+jX0KtmOrxVIiahwX2XOISnf2SrZ36Hcj+me9cBDMsEayo64P1rILDUZckRCsVbXHaUfh2o4NQeYzCGWMeEFXbB4+w6ads9zkTfGc3cFBPpKidcwj5DBAcGcqIXtoJNnDNBMtdRsRm5PeaUo3rPe2ibfsoCj1M8ly1W4gMHf7BCbBEgmqqsUJec4ECy4wqKiaY0ZDUGfxCBIZNNqaQ9eiat+QUvfZcqxth7sbvISqzbFfzRzelpUOaVNQZENZjUNg+ZgI0Prq43honQQr/mBXysmlQJNBIQKv7ya+xlPfRMqOTGIoW2zHyu4h9w7FDTS7PaaNIEK/PNce0Hvu+Jndm9npeZo7mDzAND6x0NAAnq1++aQZlos/KNWclZMHN75Dy1tt2lrcz+v5Oya9H5+pH2kDbAXrHtHc38Q5rlTyJtjvUn/P41KrKQ+9q80gBPS9zKs+KEpU4K5bWPoUMHpY7SFGN861JU+zfn/FjO4xBmORdBr7NKIzUuD5faCReo6Zzmmnmn2TYT9DHjIUPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(4744005)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zW9VRF8z9w7qwvLESJV01fS1VPphJq+aY3d/2U/IPs5LSLNAhnBQ9y1fSY?=
 =?iso-8859-1?Q?oOALxED8Q07uHVw+rAGO2vPgxTYdBFdRMy21FDnP8NAmYv/lz9452sPdGD?=
 =?iso-8859-1?Q?592CtWldgYiVCHTOyndC960HTEChl6/gu0q776rWRgW3FDdUJ7eG3uP0Pf?=
 =?iso-8859-1?Q?F0n1wc71kwPtuc79wFJt8AnqArLSfpsmtAD+FwJlDn3XZ12g/Mhmzg6lfv?=
 =?iso-8859-1?Q?nr+anGcPdaUjve+qZKctAQb2vd8iy1r+50o07mbZAIp0840j6U4axSeML3?=
 =?iso-8859-1?Q?LqVXHDD93VKQwR7pF3s5dARnFGz7F0UbA6S0wujSU3yHfHFLwOY+NdPW6n?=
 =?iso-8859-1?Q?YAw2V5b9b0UHjiylqzvUTSqV2PGTsBcvC1ZTZiYk55iIGGr5sQ77uTb29l?=
 =?iso-8859-1?Q?+1GXOMEkPv9vkLFP4NJWK8hJKY6yOcz7KRB8eR78krrK7QPVlSHI/vxBHS?=
 =?iso-8859-1?Q?IrgnmbUA0rV7t/4R4q0ZyzNK4PFKNtWc3c7re8E/8MsFnTSfrn8PR9l/O4?=
 =?iso-8859-1?Q?kp8UXBC3noa+SvveROWte/eVvLXjIhDOwuVWtz/4hxZBLpJTttaBN9EYtK?=
 =?iso-8859-1?Q?rrQR1MZlngUiOEiBFciFOYe8u/9a+Apw+F3HAcCip3+F1JdxmN2ZzoB3mC?=
 =?iso-8859-1?Q?Iqia9RwlQH+q8eWzsO4rT3RXWxaY+qEUMVE7RZVlW2Lyshy6BZHhzU27HA?=
 =?iso-8859-1?Q?Y/IuaXz2k+EVXNa56D8hukGqe1HDbCwLXVIHdHy7Pa8eqotltQjNEIdBWd?=
 =?iso-8859-1?Q?1GJGDBWQHYs6oVaKeXqcn3Cr/kUWyfsyUPwnBOI4voJxA6mS2m4zjuHHsR?=
 =?iso-8859-1?Q?4C0bKZdvHN3G6rC7ww29q+WjFg2Jt0fTI29iSKNpvgZ51/DdvSaLfbyqpE?=
 =?iso-8859-1?Q?SGE2Cm1YRWuu88xmxa0bbTD9fqyeW2ka3ewJ+2lGAz7MVsPMUcWXR4Mqcp?=
 =?iso-8859-1?Q?cyGSuZ17+7jsxKP15Mg/1usBKfjAPWbzWcl2w8QJSBVzzIvGoo8IiWOkQB?=
 =?iso-8859-1?Q?LKoC+w3Kc8N9DLKm18CAYztcyGWjYyzxmcpTcQAKbvWCkoxxSmeJa8zLRX?=
 =?iso-8859-1?Q?6hFKrfaF38aHoLpOsZMRwU4fP+3ppTcIWyGixC47yGOwO8+tLi1qRuKO5Q?=
 =?iso-8859-1?Q?r2GjKRP5r41DdDShuKpaMWoWaPARGIq5fP30S5br7O9bZbW3jLP8qrqXpZ?=
 =?iso-8859-1?Q?/wYdovIBwHSvliU2YDmiE15NxFtw+ZQmOXCSWOhVuVDuqEOJ3Z6anuw/rw?=
 =?iso-8859-1?Q?z2jWVj2BZ/CFFu9yS52HnAA0OyZFCgtG60om0nCvkpzm4YY1nMh0wmDg2d?=
 =?iso-8859-1?Q?IRBAltAOHVWH3zrAkCzDsfKGwT/aoWWFrasKJHQHchs4P2uGI5Ju6otP2n?=
 =?iso-8859-1?Q?0rdCiF3gIkR490fW/SptHd0i4/XmRLJZn5e5q4VEI9raC12u22WSbkki1p?=
 =?iso-8859-1?Q?PdXtY5IfCDfSF5Lx/DQoY3c+LL5FxQeaBr1ysXTLXl03hIR+iV3RxhB5OL?=
 =?iso-8859-1?Q?sOh9fxDb7l3GEnjnijztno8xudbOTfsjXA2SrYEQ3CbT7juVG/T2f9egoz?=
 =?iso-8859-1?Q?wylMrpj5ZlLMYqUhPYsjGX76z5fKzg/5oSiKilYM9lzwYgGWzA8TSYEj23?=
 =?iso-8859-1?Q?oC4Zfu1u+B5EegPo9KihhVH6yYGcuQmS1cnMjTSD+lm07qJBEtxuErGHnd?=
 =?iso-8859-1?Q?jgQbTOdnzjk39TJtK8o9UdZEn7qiTXySK5bKZg4QI8fr7wGTrR0ymusATr?=
 =?iso-8859-1?Q?xRM2mpMWSsEMB0teUtXxxqDGYqtpBV7dhFAVSprCq8VIdDK3ObgizJjBM6?=
 =?iso-8859-1?Q?Cb8H6J+GO8FsVtS57exXIl7/+LG8dW8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0b0fe4-a3ce-4eeb-f5d9-08da16487ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:51.6118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s443HOKIO/zQCF7UqWXS4RW2YNazG3pFyS+16Nwbq4y7BP48e+XRnlMYpwECL1BCxPtdFQHc57n8DYZj5FbrxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: fgLsAiU3iXZAWs0wvnzC3z52edOC9_t-
X-Proofpoint-ORIG-GUID: fgLsAiU3iXZAWs0wvnzC3z52edOC9_t-
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

The VMA iterator is faster than the linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/acct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 3df53cf1dcd5..2e7bf8d41f04 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -535,15 +535,14 @@ void acct_collect(long exitcode, int group_dead)
 	unsigned long vsize =3D 0;
=20
 	if (group_dead && current->mm) {
+		struct mm_struct *mm =3D current->mm;
+		VMA_ITERATOR(vmi, mm, 0);
 		struct vm_area_struct *vma;
=20
-		mmap_read_lock(current->mm);
-		vma =3D current->mm->mmap;
-		while (vma) {
+		mmap_read_lock(mm);
+		for_each_vma(vmi, vma)
 			vsize +=3D vma->vm_end - vma->vm_start;
-			vma =3D vma->vm_next;
-		}
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 	}
=20
 	spin_lock_irq(&current->sighand->siglock);
--=20
2.34.1
