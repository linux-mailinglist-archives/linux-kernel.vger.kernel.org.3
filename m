Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9759C24E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiHVPKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiHVPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A06E3E74E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirdO017906;
        Mon, 22 Aug 2022 15:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3hDrgWw64krmwOZ9CGNTNU8ncpPArqhEbIpns5c0g5M=;
 b=0aadtVuvvTJJvzZjMeBORtYF7sDaIVoUZ5wvuDMjDWrsT/mB5yvV6aEhfTnnNK86X/YS
 5L22ji1pDjfzy+9KGwqKDq3FK34+FZSPqYMrKvsylaW0zm2E7Ba6Xtu4bGja8nzFyxn4
 CC2qtmLiGlmZxA2daSGWMq8O6Mkk9OkmD+oNW9Namltpj7JyziXH8GWj0YbgfEnh0DGV
 OteHYnGDNNkzzYxvc74B9LAvRmbzyaIewmMEMbDjxbXn0ENVjGfxzIbvZqBDUPpkrDaP
 teRZ6FgT/KCB6QQykd+MeiTL9yQP0e/A87UcQRDF3XLy8gIaP8s1EDKptYcQ6pKo2ktn VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt046s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NTh031804;
        Mon, 22 Aug 2022 15:06:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd38wp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRCLvx1a9dS9GlCvRhC1NgzmGGFmx4Ym1QQcsAah2pGteT6nEEfjL2R5/5hOV/EIRgtvvksDAmg8FcaRLF+aU+OZ8FVs0UHzPdEBtPHZmCEhbyUZD5Iq9JMIjJtbqP2sD0vcLH1aniT9YnGUT4+s4V4DZtYMDX1P8ikcT+0K6TKsRPrXQwlKTFcj0zA6n5dPwcj7s/f4EGV4spXlZNgR0juWegvUVJ/mbOm3a1W2nPGz9DQfQinhaGeo6hfXZAgD8vpO8bhWF6Nuhe2yUM+Q6rgXK/Dp4ozEgzpQqBQ4jlIi+/bFI1jxqSPdDqaiDmaHBXAB0zUtpiRWxEmjYsU1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hDrgWw64krmwOZ9CGNTNU8ncpPArqhEbIpns5c0g5M=;
 b=VUJBNqqpH0J/ZzGEseel5azYThl2vnc6GcKsW01DHIGNTn5Jw1zyJ0Ym4hOFjVnuS+FYN3+ikj/qFaEgxZXXi92o3R231ZhcAomzuytgbFyq2gXwSKzaGC/cAYWTmfoqpQlik0MNzwwZWSYZ64cgSLSVnG/4G5nBQKWtwo2FhqamA5Dq1seUTRoLGaX716/0Uy5PgZigzQ5hqKc8tenhX7nnhVoohTqjB8jDxNKL8XhaAqIWsCdljd0Dgc6VI6EIzhvTqKofVG8tmk6v8DlbUNlpfOvKZIu6zp88Kah0FRcJ/qmG5C6kYZafgjguE9wfuWPStxPbS9heU2N1dpXIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hDrgWw64krmwOZ9CGNTNU8ncpPArqhEbIpns5c0g5M=;
 b=A11sGSVeX8NWXRg69sZHA/4sdeVkEez1hohDE1f3BcEFNQijSnl2ja02uDUEyb6Uku8+7Lxe7D0x+g+D7lYQnpnLD8sdjkwqPc03GCdf2ZvAm1R1RVYB1luR2ozq+C+EHRYBtraaqjhSZSlSQMo/YXCPbWX6MwizEvpjsPqUA2g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Mon, 22 Aug
 2022 15:06:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 35/70] x86: remove vma linked list walks
Thread-Topic: [PATCH v13 35/70] x86: remove vma linked list walks
Thread-Index: AQHYtji6yK3zROAHp0+KBXUHJAPK2g==
Date:   Mon, 22 Aug 2022 15:06:16 +0000
Message-ID: <20220822150128.1562046-36-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8007260-45c6-4b4c-a6ad-08da844fdca8
x-ms-traffictypediagnostic: SJ1PR10MB5931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MxZOTBQD1RKyZzQaEDTJNAHaMWU8dpXxTEYpnKWCHgthoSu5Yc81k4FMnYq8xpy+vMlyKTDBCKryhO+6yq1EkeHsGYFV3dtFqFZ9HwOQSxZ1TfIQH+dRefnD+lbe+6/DElFVft+Tho6xsJWqgSrmpGShrFm+HxpEyMvJqasIuPN8ywaMSI2ZbK/l1AxRcSy99QwBqyTFFWzEVyPpLF3kmfKOwWMtAqj8K6shwLEpfIZAk8UosFtVvZUJlYh2/J9hA37ekcIaMi5J56+IyxTyqsrr32H/RLiW3UjZwgSbYQb9QrP3UCcjGnrbxFj2J0+VuHjDiq+WUGSiXFXfd2jDijNK3sXqPKL5vegnyXt+yD5BCzHO6s+mtfi0DDNBMQfAKdyMe5MJ2gyCHZ/UAyreMdezPSEfIi8Yc2GMNNACOa5MsrUTJvVwoZqyPhq8BQ4bB2ju6M7hEF1QqFOcRI/139Egt29mixeUFmb2muQXTJ+umCt6akIqF53/fbwwfWY3beZBLp+JyjqZx4l07kyoLlcDX5PCSpX1AaoIVMvaI/WqZGL2VuJxcqvqRwTEVZFTpgV2tRKxKcsQpyLlfHRsrnlYhBvbMdtMgNxaCVfJtVdj3XEc/ka/u/QPPie5aUra3aaril6tD6ebtWW8spuliERw+e9YSWMYQRBxLn4TVNDt3zrGs7d1XVKUafQv4DN3dWO+cuOlDlNR4DiDfAXtrk9WbuR6MXNpwenjV3SpJxi9mdjtgH5pGJduJ1/slpiz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(110136005)(83380400001)(6506007)(54906003)(6512007)(36756003)(6486002)(26005)(5660300002)(478600001)(41300700001)(1076003)(186003)(66946007)(66556008)(66446008)(44832011)(4326008)(64756008)(86362001)(2906002)(8676002)(71200400001)(66476007)(38070700005)(2616005)(76116006)(122000001)(316002)(8936002)(91956017)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9XK84wgT3jT69lZ5XZxeaoD9eVbvmQoMUez6CJuIkSbrBx73prrGRIV5+4?=
 =?iso-8859-1?Q?p1uRTSG18V2GMG4jDs9beZxBSfIhkEHHEfsaPZMhTVW+aNuH6YSicQ4VrZ?=
 =?iso-8859-1?Q?Mp9Y28pUr0JyGgL1GQtpakSjP287/NJYZ/t4URmopeQw2t3oUTshh4sC+F?=
 =?iso-8859-1?Q?gcWqofqkjInkb9vkagTSiyocr/XvBqD/sVlYPx7XN929a8e424eU7Mxktq?=
 =?iso-8859-1?Q?m3YNNrNMMVHI6qEeQZ7km7G5hEEkZYufKCn1/FMjVHwbWxOiPpR/l2pUJs?=
 =?iso-8859-1?Q?GgOXRwPfcAsYZE/1iavat4/WZ1+2htwRIoCgVWalxafefLItOV8BFCSFPD?=
 =?iso-8859-1?Q?eqT25V6KcEi2Xg6pYTHaw7PNHzOHITXOtDU9A8mKc8w6m4GABPKyEBsNyp?=
 =?iso-8859-1?Q?l7ZxKX/HKdkU/Sn6g+iAI1eO7ExIazlBAnESHso7b66fTnWO3TLegSAgsU?=
 =?iso-8859-1?Q?rJZCT3keIqe/BxO9v02ttay7eYNUrABg07u7IUdwwU352BtV460vaF1d/m?=
 =?iso-8859-1?Q?UDzf0W5ulKVm06XPnmdBf9sV4B9gS+kw+4BxKc1+bM6EZ7z3JpjlArU4le?=
 =?iso-8859-1?Q?9J0PxR2XT0SeoF4QgbFIICgY2BA1Rr5Nl41J7os+cpFu9vYS5ASFP9Ofjq?=
 =?iso-8859-1?Q?ghsqWHLkr+HJ0l92SRVaq+cw5uFKLfZYYNsPBpzc8pxDAibz+OV3GVAHbw?=
 =?iso-8859-1?Q?lBLyEntYOrizXVQwaZ/KPvvmAbvz9Xa7aUUfyVLyfHNCjTRYFrpw3vGr4v?=
 =?iso-8859-1?Q?uwTUYE+CdTY4cjn9uQp9ZFqMj2nUSrXdJRfFIEnxKuFE9O50/BWGlL9AmF?=
 =?iso-8859-1?Q?faA6qHlokAnCfq26qGVZiFiRp631Yi8QDLg7nqu9ZHw/hPuoR3RihCsDFK?=
 =?iso-8859-1?Q?r1gYY+TW5zRVJLwft64cimfPp2aUx4ErQWjiNjrRFa7s3L4dLAQD4qK18z?=
 =?iso-8859-1?Q?Tz/+I8Db4fvn6N4DiSaDuYwVryIGhPcRbeZPtYbUq17Xbd+ZUYeel+Ae/8?=
 =?iso-8859-1?Q?lo42iaZ0GQ/5uNDDcxjnW6VhJd+FjvIGne0qOpHzD7FqzJj70PbSGPPXKB?=
 =?iso-8859-1?Q?0dkg54gynA/EKk37vs9I5h6KuQBpiCcMiFbPE8cEysiqYftZrwXHoXZeYN?=
 =?iso-8859-1?Q?rfzKhDYDHjJwXkYeAcLcNZVuXVeFEdcvCxaXztoa6sR0SttTs9/3si1I/5?=
 =?iso-8859-1?Q?QlpOFR+XKOZQvCW0v3ZTQl4cHsHk0bP+5EJhoRLK1r+pXPLgsVlJPZTiJr?=
 =?iso-8859-1?Q?g+G0yH3PeLMEoMQkY+Lgog4UITludI+pGJVEL+kLxjt3XUW3F9lfLfbyQ/?=
 =?iso-8859-1?Q?bH0ptvwRe5zkl8JJLpDUu035z7i8dND94RSqWEaGJYNJ/v5vpt7nLByRV4?=
 =?iso-8859-1?Q?WvHa/rvcsjZ89TTmBluzkbJIC6AqAruqaYaWDA7WOtDGquQ0XXTy6nk6RE?=
 =?iso-8859-1?Q?hiJTd2Kq9Y+Uq3qbHnXlV+e0hb83k8cdiwC670nCP6LwgMQgj0aSk7ISEW?=
 =?iso-8859-1?Q?wAJ2bxoCn6X5WzSpevbo3PwQn9TkSCoq7QXfLupGA1Mcc+dOhwOfoG7p4O?=
 =?iso-8859-1?Q?D6RT2nW1u+QweGN5iiJ9v/u7rj2aiV82io2HxAfG8nFvz1kp4109GZqBZh?=
 =?iso-8859-1?Q?2Q1VaWzs1WnMJzVo3Vc4wTj/EpkBlQoUYGS2y9JCGttf+PuGmmDkP3mw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8007260-45c6-4b4c-a6ad-08da844fdca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:16.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujF5M8ib1NgErkiHbD5A7J75SfVVRrZQGVUvXRIJldIWyoTQy24PAgF9P+M4GMgvp9+xDbOwK2YY/Jr/k3hu+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: QqO0kEgpCvsA_juBRjAlmeENKWr5d9rx
X-Proofpoint-GUID: QqO0kEgpCvsA_juBRjAlmeENKWr5d9rx
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
 arch/x86/entry/vdso/vma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 1000d457c332..6292b960037b 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -127,17 +127,17 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_mapping))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
 #else
@@ -354,6 +354,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
 	/*
@@ -363,7 +364,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
 	 */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
 			mmap_write_unlock(mm);
--=20
2.35.1
