Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D472E4F1779
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378254AbiDDOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378172AbiDDOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:42:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9DF40A2B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:37:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DkvEL005378;
        Mon, 4 Apr 2022 14:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GN9GCGfDykaBPsZEUw20bgyR3EanvMKmRduZeFWibxY=;
 b=lAs7+LGiURYimGT/kPJhTXltJ53UkYBS5wmWKF8BhP8iwejkp470Zw+fQ1j9LZMDdEJZ
 VKKNIZUHc/oWu1z8zaqwUMnlYy8TzxwCXjs1HF37wfWH1CLQNFeRwOxSrqfzFu//yab9
 1gsaQGjISpaydA71HP8lfDidaBfR65EEfnEbc4+ODQKGmxSgu+6aFB0u8gUil+KUNHc9
 95VcQzKK6EdhkZu9O4rVbRYKYuV1OxtqBQc4S5cTPczIUCInMKu6m0QMohuBwF7uBYfB
 ghIZJWWpBXIciwOK+spyNoI/Uyqgk2DW2bd7uJtIvTu5+xlFRMdtVVPsHSc5Xn5a+ABt aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92ud56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EajoZ011889;
        Mon, 4 Apr 2022 14:37:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gw9p-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwQo5sNvGB5q1CShmlvs6WRn9syag4qekc8tOvrGEWSPNeVJhQZtzALMBlBdGFA5xB86S3gZ58m78xWO1wW/GDdOyNQgRvV9SCdVh8nc8UgXHYgpYzaeUAuJ+Nb9IQaFJgO3KqO6kf1ghnXvQrSUVsJw6VMwTwnJHAvZx2dPBdZjpB4BlSgUAzjGjbsunwrJHIWjXyP0yeAfM9Efhz+BJxBvrChvCGoltFY2/sheTAszjf2FfC8EZn7HJV4tAkGn1tGMnJz1ddhJaCBwOD9XzEdIMYXFYJiZO5twL0JnNQxsOsaXr0d2xX3meTuAHzUVFs1OuTDzIpHfC1Mx1aFlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN9GCGfDykaBPsZEUw20bgyR3EanvMKmRduZeFWibxY=;
 b=QZ6/GguF7+bziRWsW590LlUvmTorIbVRzOpNtpahOIunTmQLSO6Gq5tWekEZXjNWW4tST7godmuIEcBazoEt80O2OS2x3VuHeJf2NjBbVt+VFpYdwv+Q6YKy+oEHUfI0qVICwL/3RtYBs+vdmaDnDEl/GGrIKU79MZKs/3OaZcOkIAYxfKW15QzbqTgaEwgC5JeUd4LGB09+lEndXo6ruOWp7nkYazuH67t90araAU+n+tcZEQSadGzChCa/bjMqR8Gpb2jUbYWRVwRSt5YRnYPIwjuJX5NfQymUEvyy8AfZ34SM7fGx/vLv0rxlezeDeAorA0rlnHFdVtirZ47qwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN9GCGfDykaBPsZEUw20bgyR3EanvMKmRduZeFWibxY=;
 b=dTcIvxMkm9Tj71bfBWctb2ngNOK0N8tpaxCMU1iU2dL7xkpCJ530yZsCMlJsR+OZPiRO72EPem0JOPzCR/PlafdtBz2dp1W+iayxLgvRVbOb5lJzlCcNsCsgd4PxtjK8uri7NJomIzGi+Licwg9EvyQXR9kv8Q6Y0f5OHWnB4Gc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:37:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:37:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 65/70] i915: Use the VMA iterator
Thread-Topic: [PATCH v7 65/70] i915: Use the VMA iterator
Thread-Index: AQHYSDFMlocLh9ylLUeM4gJOFTV4lw==
Date:   Mon, 4 Apr 2022 14:35:57 +0000
Message-ID: <20220404143501.2016403-66-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b80bf1c-3672-4605-72c5-08da164897ce
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB57422CD789B5EFD607FD0C06FDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 032W/09ItP4LW0PwSYpX1k7KIDUx0OGMnj6Db5CJzuGrsNz0A5N82NX5mHdomcwlzRzXlIs3gJdw+tCf9EUb/w5V0ur/tNCv5GKWXLH2VMT7ZRT7Lq8AXjvi6Af2nmpKiaN/rCK9FmpwZnaowcgIdm84K8Htj0COug8rGQo+jW+IA9PL2taVftr/5nxehBkdiy8VOF4gAz6cR9U1Dc5qZoyLDlxxxgT5RZ6BUNxASV7Dv9b5xNw/kzMMj6uALXme1xrfECGwttRaCjniogjc/XGS6EnPgOwotKYpzkzp6SLS+rNUC9T/uvMHq9KVCUk1d4eqNN0m9IzS1+b3Hs5CqZeAatCu4AuNi/a5uztPZ6h8+7ODKuk8rWRu8aiwgYZ4FgwipTvrO+6Ss56D8M4Tih5diXQpD3D3ljoib8W63j8vhD1bIPUuJT4+64acimxtVMtYKb3kjxYpNJct9HUq6oMpm6S7W1hsL542YGrFsU6UMhwet84Xt4vHfsB0dl8+5kl/eJ8Z/yvGawHHOoSZ+wSTcQLxJ7vgMqkBo3AVTMY56fhS76pkqq4r9qRjzQ1pn+SG/yAHBIFjZwfNXFQ8qEsbgzCMRQYAIwRUX31E66d+W7WwNb9vUAexN/GSNQJk//0TeC9xJjoisBgj++H0rXBhpIPj8CrvGT2ZbBBdY4mdnfwC7VuaQcDLat225uS7U0xMdqcmg8dK0GFOs4josA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cRyhomcLRxJDSDbAm+kWt56XPoek9mYb8m3umjRV73scinCfB7aphMhiu/?=
 =?iso-8859-1?Q?fo8Tv2eFli5knxk5aK/XXu6ZBOlkDXCuqlDGEpqlfShl2vv8pMai97WemX?=
 =?iso-8859-1?Q?qxXkrX5Rnc6Sglj8lxPTpNspxvB8bg/tamxDmVqhMAhCmrZM37ipYJ6kKX?=
 =?iso-8859-1?Q?HORKr/Pq/ucN4EGbxqteM647PipEyCz+Zyx6J3Z21xiUv/AhWSQLZPtlKc?=
 =?iso-8859-1?Q?kn4AdyaJWi8ewuwx3We/9CKRpa3HdjD1/7aSSSil48X00BmcucYehK6Yza?=
 =?iso-8859-1?Q?NKNlBd5S3DUY4xOgsFCsnUBOIFeC9KbRWVkF10d6Kd8eX6z88041sIQxgk?=
 =?iso-8859-1?Q?VWsrKDKKdmKUMJPqtLtDkYi0FZXpTslUWd99A7MffzG6ay2zk9G+Enozhs?=
 =?iso-8859-1?Q?JJXwya73v1jiw/hwDt/z/s8vsE35OvyE6ptoY6iIkgTvVRkGzchE9mLhts?=
 =?iso-8859-1?Q?Ex3l09KAI5vXsENF2p/AJDWO+dWv6jBn6OcxcOCXT3SAxCacl0pPdCbNqP?=
 =?iso-8859-1?Q?T/lv6x+gVjIXcoya7saQgQn+fYzR3so5W590RpSGGK0p2ByBzSyRfLIvHe?=
 =?iso-8859-1?Q?zu21yy4AwOIDWtcHCDnV5uliNhUW5Ju96F7sZn/aMsHFjNbjcfHazVP2kq?=
 =?iso-8859-1?Q?Xq7OodYqqn+NSnBFj/rYXhx3sWUyf2KMEFyTXogCFHT01ZsWJoyxcA8coB?=
 =?iso-8859-1?Q?Hgxn4TkDUjqOowKxEFg9xR1o3bwaQTVDQV4RYgqO4LOhSJjggfS9z9AUb/?=
 =?iso-8859-1?Q?r1zOMAmaH+g+8rIRgQd4xIGhYyToFcQ1dY6SqAbZCWXhtJACypcM+HCxuK?=
 =?iso-8859-1?Q?DuRR5aM08YeVf/VT9FclK1zk3T5jSbRtxIZuWu0p/3NHxY/l8cGG3QHNrg?=
 =?iso-8859-1?Q?T6G+UBR4Edh7P9zW9Hcb0RdPMO/mKVzZvy/1ruOAD4kl8+5l9+ezjMWL9K?=
 =?iso-8859-1?Q?O8swZ4MNQ0eyUB1QDCIsTxuKLzcxyWPMYK2NeOTYC4Khv6jy3oCu/5sWW6?=
 =?iso-8859-1?Q?hCdvJdNoQbFaKmzkiAuqpGRtahuibd8IKLPWUEvwY0TieozTkeU6EQl/Ip?=
 =?iso-8859-1?Q?pFHl0+VcflRmym6zt1gkVmSaOwE76ftjVdppKNAdr09cd4Be7k1Bfn3qnO?=
 =?iso-8859-1?Q?daXI+5UR+YykqdOItyFkNPql7/zmZdbXcbY79gzBMz3gmCe6Wl1DVNg8tF?=
 =?iso-8859-1?Q?6Jctg0bBZlfzMDmpDyrnKRv9VfPpwqIn8QXoPBxBSykkTeRHg0DGeqPmU1?=
 =?iso-8859-1?Q?2PSOxunS2uJkxVIyEiWUJq8jnBrLFv5dpmCtbUfnOFa42Hrx4imGtA/TA/?=
 =?iso-8859-1?Q?wg8Tlis6WyvqX4fO6XbC7H2XVBDx5LrznGSgGCZ+ed40YAgI24L/MaMK+L?=
 =?iso-8859-1?Q?5QaJScjQ4yc2tdlwoXJZM6yhQ+L+oXw4Zzhwcpyiu4NvZc7DaufYOBQ9T0?=
 =?iso-8859-1?Q?L4K1WZG5Na+fZRTL2l0NI3kMVuWTD6pY2BlZxPJxvzcqWfNJB6OS2dWfua?=
 =?iso-8859-1?Q?eqgHJJgwpzY9lXidXM+xicdP0I7Us7DLz0zYeWyX2kN7IzVNmRbpQ/NX/v?=
 =?iso-8859-1?Q?GQfl/oQC9KMEUJ1W0RPIw9XHSYMf9LyNjsJTl4MRejbIXPM356jmc5p7Mw?=
 =?iso-8859-1?Q?nvSeTST3stiwU7z24LJgVsvyKAQLCITnI/QDCyxWIrF29KR2wiVosXPCmC?=
 =?iso-8859-1?Q?/3QmMJPABmtP4jCt9+sw8njOiq32ubPXtWZlUA5alh20mEO17homk6L5nP?=
 =?iso-8859-1?Q?mhuV+zE950RXCdhsWXLuoGE09/lMApdomYNdHeYZWEMwjZqDN74xWKD0fW?=
 =?iso-8859-1?Q?dg4Fh8Uthfyonaxa7vjuG9w/WAGNq6I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b80bf1c-3672-4605-72c5-08da164897ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:57.7520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W20Zb6I9y+d/sAoAf7SmT5DB8LnEOqJgDVhHv+vpkzs3E2uyRgs/FsfcYIxsywHP9eppc4ZUqaQ04kZqbwUCqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: IYuI6PFBHYoFBIevr4HnzlMOtDW7yz4r
X-Proofpoint-GUID: IYuI6PFBHYoFBIevr4HnzlMOtDW7yz4r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 6d1a71d6404c..e20ee4b611fd 100644
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
2.34.1
