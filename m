Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2974F1735
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377978AbiDDOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377989AbiDDOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2215E3F887
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DpNEF014737;
        Mon, 4 Apr 2022 14:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rTMkow0d7Ov7Pa3q9o+CIvRRZsUyXUIs4fXzveyIiAQ=;
 b=WaJbQiVqHRKyq+CVPA1NdiS21cHhiRDYCwTol/Sy4dlTm+atT1/SIrf+qPzfiBevh5tI
 dMbVj8Tet/1GN/+oZ683cdawsGI78ii9y9vBglBJg0cKbyg3Nr+fD4Z0k7W19Sz7hnHj
 2kCaxeOZ5b9uA7kd2F0wy6JMsdVM5HM7j1jZqap9SCsjb5EwHsCRxF/zT+e0/72XqdIS
 dAHlsoxh+3dL7rc5XXjpYTNVrtsyjOLjYsRBuOtXmxDUZt9ylHeW4KnV6sxTaqucqAYO
 y4aZDj0gPIkfsd+fyTe+lNVYdW6s7GrnPrVoUho8eDrtwIVrZApGMAlv8FA3nW9xywoZ 1w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcG8027665;
        Mon, 4 Apr 2022 14:36:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnNtiUbv5RHHIS67wTNx6p+0VOUqyJyopkuAET600OojgEN8V6lqZaT6sv8e/H/wHUh5CrbolGMVl2OinheYOOfm13IKcoGdoR7q8OsFaCPXFkKOmKF3oMtVHkHJALIbRm1few/chXLS6b4mEO9IKY7ty+Tp3XIKf9Knl4zUEfBm+i9LlSdsb4SGsaof5LiHyNhimy+YPYt7ppivuckoEykKz4a6CICRLph0yaTD+wJLNy71uux0GqWzmS9n47KLye1FYMr5Mw60LZgq6mEeqgDE3Kar02WgBPzFAZcqj7xVXt+rxKon0N48ejfxFaCNDp37HWMvXI0dWFW1MPjnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTMkow0d7Ov7Pa3q9o+CIvRRZsUyXUIs4fXzveyIiAQ=;
 b=OHh8S6JTLs2m0RefNF+5nM0Gr/hyhEMEWwUcM1ca2ZbbBiljBW7QZzd+qmuv27oK7aX/whKVpQYtwVsPfAVytuwZy1pYnZ+ae5k3FwrPfXO2TyK6cYgueNyHlXtzHgPX+nWqYKlp88+habIVGvm7q/NDgVNGZcukKAoPbEjhm+k94YUn+86nEfxWt7fdRxWI6FL5wS/F9u70rk8uA/urnhYVNuH2CAt31GLNqjp6ZMl06dPmwr/zXomVxS3xQux3mT6NoSxd83ByvYnmw8nYhRM++kd1+uqGL6G6hBg342CQRUBf7SMNXplDfTjsoVH13SV4+8mNhsYBOgMHlEp7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTMkow0d7Ov7Pa3q9o+CIvRRZsUyXUIs4fXzveyIiAQ=;
 b=rX/t5UNRTeKpPGwAod6+8MrtJ8mmmT9QIGQNaGDTzwTP1XZZ7Ky1oF373rs/7SuCzVMsRwUJe/EomeB8nEjtIgPwhhDXQSiK3vmRSJ5pwES+vZlM93s1hVTxNuxH11wLCgCyP9LS85GUByJpyXhhhyg4ubMN9NzPzirlgTLdQi0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 32/70] arm64: Remove mmap linked list from vdso
Thread-Topic: [PATCH v7 32/70] arm64: Remove mmap linked list from vdso
Thread-Index: AQHYSDFFPlw8L6udXkinfxRLQ7dQmQ==
Date:   Mon, 4 Apr 2022 14:35:45 +0000
Message-ID: <20220404143501.2016403-33-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5aa1d5f-31b1-4ce6-5d9e-08da16487bfd
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB13810EFBBA6EBBF5D7CF540EFDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +EBj5qVvqNoVXAjpKmiSxt3gMnzawZvujQTXZekpV5nD40kQEy2Ue4I5Z4ROVwCRaOjWPCXQNnA6KSwlxGU0MRjDu+b5/MTyq60pJ/CfLq5CzW8TuhKVF7OyDjEWHcv90d38gx4/EDXwA+2aazCXbqb2XbI0oLYV/sXdSw0oMpulVmd/lKtJZT1KoIgjKaVjBjDkDcsnUW//ODJ/27WbS++6PCXKtmGim+g/kgzjqgYcnyIZUC6n1sxtjFTRGAlrU2C/9FGfCIDvFz72bWp+x/82rwaXQjewphX2EydwjkGpIcFtfLZtTxdaaJcdYbRtvq23zEShe4TlJNy9Qg2+S86eqVkq61/Aw5CsEvf2WqtZ1c0DtZr7pbBKvp/rToj5C/QyV8tSNDGOON6i3rKFiq1BlmxMUJCZ0UFcCPikJuN9rgTYrf7f/Gr6j9umiAL51vq8ItCSPStY2rmwOLYNd76/yLsPUX0VnYhYlmk1JGNjiH87qYkFROa0r0rS9lql+iTjQJYJZz+oElRUvfGXY49stZjQ3gA/3WeF+YrncXzeHd/TpNZkEYzd3aE91MU7nSZu+P9Or1GCp/GKeQXhICidff7mimQbojPzi4bPMUFccsOBNnksmQODnrz9BNACXLzJ801Iphb7I/OEbCfmBK3j8RdnEEbUElfEN7v3H0A8RhGI/D6AkmHreBNCLAyu3X6FKjjSrtMDgtUrsMdtNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(4744005)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8VWNDrCrKdQUb4Pt8al0/79B0tYXfucFLhcwyr0zAV5QCsc7//C8TDjTba?=
 =?iso-8859-1?Q?DfitNpt6HXNozvmVe0XV6r58yfSbbQM/+i0lmlw2RHzsUeJHX2Dy4q/Jyj?=
 =?iso-8859-1?Q?BgcMYj1oS/WBSzJ89O0+qtZlAl01Ayfwz0xJAPVXfLYJr8FTPokyM7u//g?=
 =?iso-8859-1?Q?EX3DaCd1HW4a+2XvigyoPWmPOT9KtEqhCpDI3dUW+lI9+ZRSuHjuwUMk01?=
 =?iso-8859-1?Q?4c4fQfnN6thvGczkT1xrteGJvgJjpjS08aa9Y6p/D1n2HRFhnwxR7LKDJM?=
 =?iso-8859-1?Q?hqXMdBo+T5q+NRSXN7GkIUJQgbaUGQo9/qHg4KqwS2MlmZK0NZn12gRvk6?=
 =?iso-8859-1?Q?sQzKvXysUUqUI9hW8/KoaPrChg+sP6HEEvlYtp8+6KJilDpuIVAnVm0927?=
 =?iso-8859-1?Q?N4o1PZAeXwLMrxSnX8MBiYyd255gVo5/FGOaLlMJLprsKxUdBnLv3pAIuv?=
 =?iso-8859-1?Q?uwGU6Kopzq4vhYFnvAUNh6nH8v+1OH4hBj6a+y52KvBBAuEds8ux8U6JNC?=
 =?iso-8859-1?Q?YWSozwybnfhGjd3Bmp3FSNyT3O+1UyAqYsTHSPWg6jXVtZIni08vb+AfqY?=
 =?iso-8859-1?Q?Oh67ZR6CGL9yvXxB+G5aYIIhezOGEYL79ggqyDXCfFwgKWDTWpBj3gdAma?=
 =?iso-8859-1?Q?/+Pk0HW/yaec3YAuf/Y8HHeqTQxLqiXOxvWFyRvUJohTl0XnTMzn+LMQgk?=
 =?iso-8859-1?Q?jxj7yqsTx1OL2aK4SFRYJrxTeFsVJ43l/3AVhWA6hZc3lKGCwmSVVmFbO8?=
 =?iso-8859-1?Q?3jwDuq4FiCYVvj+OlW/r9SmG0vx01RE5tuJaG7M6EoJWAuhnyfvTWo44Ep?=
 =?iso-8859-1?Q?asunqzKGcsHUc/jCJ3RF7Vmcv5TEvVObhLc/HH/ZoTC3eLZvOUMBh7GY6E?=
 =?iso-8859-1?Q?v0pJeTnPRc/FvQMvAFxZq2cT3nVUDxqCxZO3AR15yfG0erwVgQ1VxBGeRj?=
 =?iso-8859-1?Q?7zo8r2rh6mYke1FuTUSQfidHnKZcSC4GEb3n7TyFYAYhZfrhevxh1crjhs?=
 =?iso-8859-1?Q?VZuXtciyTvDZMDjnZXStXFZxENRJYNft298CDaNwafjv9D0WudXmCu//Uq?=
 =?iso-8859-1?Q?UadZQt2tZGtChrrkF4KPQT1b8cJZqMIqh/fpkX9XGcKYtFrK2Q1Y8eK7sT?=
 =?iso-8859-1?Q?g3RJ+nin4pVq/thmuRkuKiNlCeOYr+uQ9bhQxvflb/PFjKWWcNicR6qE3P?=
 =?iso-8859-1?Q?ue0gj+JuT+LpghAxP7Gv+bLMQmVAKV4q4x0Q6mQt9ZEUDHEcTP7Qg55Eof?=
 =?iso-8859-1?Q?Kcx4GSVPKe8v4kLBhW5frYYQgu4vwayNJe4+KDJWMDnu9xzM4SzZqnyElE?=
 =?iso-8859-1?Q?Tw5gF1yFOTiAxZNu9zilMfsaLII0idG8G6U8utljJGJqYct2af5MV+PJhp?=
 =?iso-8859-1?Q?mNFDouvyyGzPyZukFk+t0emEuhlJqekHLjjJ3s1fgF2zfpAd0Qvpjru8pS?=
 =?iso-8859-1?Q?kMxZWCXuE+Q2MjaT4OFSlcZQFj06Pc6pAXD88qfGNu1oPSwLyrlJnfWZsL?=
 =?iso-8859-1?Q?1+XU0Q6IPslG1SEc5mAYsSDiX9QU46ilHMFj9NXOAIv0np7QQpuQe6WGWJ?=
 =?iso-8859-1?Q?gE/CCLG1PeODvAPTI/4gezvGU5zoQ06bJGreKTUM+ypIbDsrnjdfrpAi73?=
 =?iso-8859-1?Q?AUMxygLV9IkcORuTmbfc+WVI2i8lodryluNUZvpz+gf96ZOucvylBM4mqM?=
 =?iso-8859-1?Q?jRYEtFAE/Unixuf6FRI5MWqXVyPO41iORcK5OlBs1oK/gsLwxX1Q+sgQ9s?=
 =?iso-8859-1?Q?gSbq1bhhiNHdkjYnKKPlzVboexGbZgFjcnobRGAbX8poOBxUiBwGJ7vTrM?=
 =?iso-8859-1?Q?hZWlgIPOsFsWHlYzS31S6vQtMqxd/0k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5aa1d5f-31b1-4ce6-5d9e-08da16487bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:45.9246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53XkMKWeqEwnPxPBJ1BkJz+S+nIB/4haUbzOTYxtjRUV3Jq19l+3k/7K/4hW+PfWtr9EBmObWfwaB6q6RYPlFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: dLr90QHHYOAFfPQIooZ3EtUj1Cb7MQ4B
X-Proofpoint-ORIG-GUID: dLr90QHHYOAFfPQIooZ3EtUj1Cb7MQ4B
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/arm64/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8388af62b99 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
--=20
2.34.1
