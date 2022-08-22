Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C859C257
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiHVPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbiHVPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904C43C16D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkSsK022999;
        Mon, 22 Aug 2022 15:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YZEj8uKtj7x8DCtjy9/uf+S5MMFOo691+RgbPTCKqHE=;
 b=J75tYDJl8hqWUMngU7E/1qArYIQ7e64+THAI1zyVb6f+s57xBTGuaKiY45EtPL2RgKsE
 4wJoFDv/VsfN7qeaVI01HxStESt1NOdFfNYNM1X49q1o7PCTTBl/vN/zzBheMPNwIwAG
 zVb8lyKrRv2HvRYTeiifTmNY5wuqsqh99DCjo/Z86VCNLcDxgqDnMVNxypO3kx1v7XYM
 O4ZPyPxUbMU6KX3Zo67WRFH4limSb4VDR1sKeK+3jmxtxrndV5NHT5C9gu2/qSP0qAmF
 50p8H6Z5nTQvlxlGkq69HLccaZA513+4miEzlOmIkFFoidPfk6F6m/Q8hOIh15hv5zNK Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NTg031804;
        Mon, 22 Aug 2022 15:06:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd38wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndMWfXurBgqx0JSxBqKrwscVNcvzsOkxCaBpVVy2CxitifARpmnSs3HCZ/jcHHjRufYl3VQgEMUIgU4AqJUKwQ64Zt+aNVIeqTn0XD1A33mnyJL72TuieTu4DuS4PoRjyseheET9bfzMFJstYcmLGmk0yd/7SA6bkpcGKUA9YOnInj7YFXJu4xXLNT3At91uIDvIgRhhZ6yw+plQ1ZAWdfwaAkW0UE7J/VhUCX23FcZChlf47X4WfbRgRgcaqIStubHCbrQ2QzWoI91Uj/+gHKMd5qDmJv5vZ8eTWlI3yhFfi03nTC7HpXIVPDhiHRPuF92YnzzRraPsSLcse4sr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZEj8uKtj7x8DCtjy9/uf+S5MMFOo691+RgbPTCKqHE=;
 b=DppTIum61bM6lmtrvj71aGklE187Csvroxu3PR0883fvGvR9+SnzLgLKuORONfswNXVZCA7BwPAWeaIcUG8LbIEU2q7uv2k9nbGpv4+il4GxvANl3RQvAFXQ+KEyfL6Hp7MQqrBC33EXkSw5ayhbEGbr5BvPx+Eh8OQERz9M9zqaFFc3GwzjMEYSUe5XfkaYHfDnTUTE0kz4CgrRmfcHi2GKxrY1rO2s5U1bIA3XFtHt7TunEYTcmHbiI74Q0QXwZeYS45OKc967LbM8cVQYXYp1+yo+96mgqdjuXx4RgsF8662E3dKJqDx+Oxi1cvRlJh49AgmeAlF8JVNJTMMtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZEj8uKtj7x8DCtjy9/uf+S5MMFOo691+RgbPTCKqHE=;
 b=gE6pBEebj9oG4kcq3jVQMPHP9rUdBknm6cd+0c9BmIJtBbBN0FWGIIcEHjHQD7AZ9ddMbfFMSb3cUlQcJvxD68SSEZw6Jb+rC+1odn0tfhMHng/JcLz3nT4DEHKF1ItEepvvERLK7Ege0xtjRpNymJMMzVSE9QfSpNB9xDmyuKk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Mon, 22 Aug
 2022 15:06:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 34/70] s390: remove vma linked list walks
Thread-Topic: [PATCH v13 34/70] s390: remove vma linked list walks
Thread-Index: AQHYtji5Wb6NpXAvq0G/1X93t3Gdsw==
Date:   Mon, 22 Aug 2022 15:06:14 +0000
Message-ID: <20220822150128.1562046-35-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 964129c9-6e60-420d-3f6d-08da844fdbba
x-ms-traffictypediagnostic: SJ1PR10MB5931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KG7lTGpGOYwZh+771AZho9G5Wl9v2LZyz9pBFE4Tca9jGHfFzN/HWosHcSokC7inr1ce80KlH3UwUp87jGgJOjSVGbwAlMqs7nH7LN5+CB2eZnDBEQTL/+KY/7XO7lgRNOXDzvqTpzdqXfW6bjIxkXAbeadIZpamrDEgMlTlZo1YQI5M76EJRDTVdepN5owUnD68086UkdERVarj35vg5CkRqSfBIW6YJeExEPeEu2y43h1FZM1WSRzS4NZHSsrQTXQPuXU1kUtJKWWnT2a2EGYnl7CnVAVJnpLeos1pTmIQR3Nk6+/m7TEdUcmkNJuq5l2DicvU4eSjmHTvyacZBdM/esLLpb+sCqcKpTfY0OmIFkUyowm0nwlGkBUw0qtGElyDsuqMo19fI2iim+gvgaM/ord1TcYpU8eUyzS2O7PlkOvvtm6PkdnnRBgBUdV/qqdGIGd4Xn3n/Umfr/wMImI6+oyTUArObl6sAOODaU1cfg2ITKS+vopgX19KIV4HZ6AOyPpq63yWcf2FVm1XHvD6Ufm2zeRlORrj/HERrzazw463pC6wmkZZiCrvWIYb9XDR25bBNy8OV1Gpfi17WRFHrSE2X2d4PlQY6afwZ+E1NmTK8NrlSSmy3SIX2mQ1SXMCY5CkdZ9Fgyv/KvueLl8ZzL95+UubekA4Neaimlt+MALbkJZl9f8Px9hclT2DEDisH7+bKCOzHKHiu9CJGX7pCwp2zufdBCLEiy+SD2ih4EvvyR1rVeRlndKrgVBIyUr4Ew9HZoK6/xImfvmcxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(110136005)(83380400001)(6506007)(54906003)(6512007)(36756003)(6486002)(26005)(5660300002)(478600001)(41300700001)(1076003)(186003)(66946007)(66556008)(66446008)(44832011)(4326008)(64756008)(86362001)(2906002)(8676002)(71200400001)(66476007)(38070700005)(2616005)(76116006)(122000001)(316002)(8936002)(91956017)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5g5mCAXLyAk9rgn8RZ4mM5m2szhbVczMuIryGHxuTjpB8y5kArEppmvmup?=
 =?iso-8859-1?Q?xWsi0i8o4Azv1/oJ4QEEZjQY0HSjxRxfzlFNDXKC81P1gpHEXLP4c1hqSY?=
 =?iso-8859-1?Q?r4Xd5Pe0YDKwkhJb0Y+YNe2+CFzGhb28CavtyHgWkTZ44VMwLR/6m1HCig?=
 =?iso-8859-1?Q?zZXo518JkEooGlCBoA80aRjKZNFoxiyEgCEdbzdcTKNZVaYu5LzIbD3IsW?=
 =?iso-8859-1?Q?4i45kjIvGt08qS6hztxnp7TmmP9YH+RKk9KhwtZK2oLEzYeTg706x58e1E?=
 =?iso-8859-1?Q?6g4h1bi2b2mKfWNjzP2MTjkxFvb+qXOX+fEncXI8KIDmKPDKZoPLEuwl/9?=
 =?iso-8859-1?Q?Lfrd5sYiIzvBiZIvLxknog05GC9DWXQ/EEkmbNyiN5sphCJPlnv1AiCUoM?=
 =?iso-8859-1?Q?uSDb/eCQXOGZp6uKhRDpceTYZIjTtzloPr13ZnQ++zZ2IXp0nb+xUDiUsA?=
 =?iso-8859-1?Q?WHBpd9/ShweDCJztyZ/YWLzt75DJr6T7VGrvdt562JU851vm1bG41/+pbi?=
 =?iso-8859-1?Q?3bP/cRT0WZo4whVQ9RbrjYbQzIoeLpAYj0q3RvameOYfyQ4kQW9Dlwz+AO?=
 =?iso-8859-1?Q?ARpswlet6DCOg8LPb8hVrxbPMRoKaCFT2eHjUB9IuCPnv7FIa1MmxDAdsV?=
 =?iso-8859-1?Q?3OEKFrBO4GXNA4OGM4inpEaPWhR/Zpn5M04SNQZAe0H4Efpad1QNqq5yaw?=
 =?iso-8859-1?Q?AA7oZmMo8OokS1oSgmFSW495O0MMdY/LTQ8OVfED+kwCB/5dZzY7eOIs5a?=
 =?iso-8859-1?Q?ZKCFzFGaIUDpR9cr5xGssC8ecyvMLZ39SMeadMY2b0XkoyHuZrDfK/CrhE?=
 =?iso-8859-1?Q?lg/vD/SxHEZIMoecQ3eoFdv8uW3wZbnR53pP55h3AxDfXLbbaugcAuCQRu?=
 =?iso-8859-1?Q?PsbGlo7/CqAx1LePbO8k+c57m0CYYp1CEX3237JTSHN+2yn+waiiOJcv+t?=
 =?iso-8859-1?Q?A+PRG7dR9C7GG0rZOX4tAKbhMh9zj9O6duA3vY7/TqNzQHfyNYLdyz2puu?=
 =?iso-8859-1?Q?f+K0rQ/1huWKqyyxqwt/YHkVhjOmQAHyd/np+LSueF1NqiWWxPuE2IXKVx?=
 =?iso-8859-1?Q?/gqntacHFjlh9WmkKHL6VDcsh727k4KpiDy2OUnvNdqiLeAOFXFoJFSAxd?=
 =?iso-8859-1?Q?Q1TeXsIHuN/8Fl3SpFiFVuRvTEBorY9HXsBJvYnMzPs/5/wlrOwcgqvMjl?=
 =?iso-8859-1?Q?k/cWk/LdOU6852zGlHio1aLLtyZAJxv5dKYsAq47fpUYEN0vzRQe+xI4Ez?=
 =?iso-8859-1?Q?vXf0iL5gTxmVbMJ9vc4cA3ibGPFMmrFMvpRKaXgGswV4ITkpfe9wnn2cTP?=
 =?iso-8859-1?Q?FZajvuOD+jKiCPmMfJjQVcvhYGyhfdaxoXmLMQjTcX+zOdLebijyqw7xx5?=
 =?iso-8859-1?Q?3uvXY7/lN3SAR15OWP4xcmKFOR5Tu62/dwAC4fAA6l43X+Cjc+g9P6qoiK?=
 =?iso-8859-1?Q?zn2qfnOIyyvuweuUnuxMVf3P5/Ug4VwlXZf9wVFv1MHNo0IhkRfMkbSYSY?=
 =?iso-8859-1?Q?4cZ+zTc5Lp7JdR2hYHL5ILTe7vwRmxqJvFMv7wzUCqcNgySKZblvlE5AUm?=
 =?iso-8859-1?Q?j+uhsNR/aPeWc6NABykbR5kwYJ981DA4f+qPAvNuwqF3rkHUASxouj/Fpv?=
 =?iso-8859-1?Q?PixLWAo2tGFGn24oD85EBBXCDpWbXoAC9lgqIrFyxixBV8VFe8O2ImAw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964129c9-6e60-420d-3f6d-08da844fdbba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:14.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdoHRNlUlK4k21ZdrQqP536rrkLsaGPFPcqRfTMLLffb/lOlJnmvm2Hp0kuR6BiI+mvxyZZVba44LUF3Pdftcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: u3fOGSzH3rBS3t-1O7uGvkdQqsJsEQA6
X-Proofpoint-GUID: u3fOGSzH3rBS3t-1O7uGvkdQqsJsEQA6
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/s390/kernel/vdso.c | 3 ++-
 arch/s390/mm/gmap.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 5075cde77b29..535099f2736d 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -69,10 +69,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
a_struct *vma)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 62758cb5872f..02d15c8dc92e 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2515,8 +2515,9 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2584,8 +2585,9 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.35.1
