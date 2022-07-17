Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF9577372
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiGQCw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiGQCwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:52:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BAD25E8D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:48:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ99CZ024361;
        Sun, 17 Jul 2022 02:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hBPbWbi5Cx8yH1RInecAiNIHWj2X2AUkX/qhUIYGxkM=;
 b=paxNwKkMBgWA54WNMkJqHXVE4cjMSM26ygMqlVg/ZcTrpJBzOimu478PbUC0Xp0KCR8R
 oTCMTZNVTbDG+2VonrgHoANR4LxQQHJjPKX40v2FIsYDHRPAEBg0A1FhM9RXYiYhGxvc
 A3NAkimcZXWXD2wUYjR1TmAqCSBL71NRlCv2yEOiqoS3XURisr/hBE7Kf1ral3ly2cJo
 OqRVuBg+cpQuQVwJ+MfJJATn8i5exeffsamXVM4QxldSKNCAZrvZpDmqa0CMregHYfc3
 OzK/3m5FIVPp61OpfxroF0Qyl64Ba5sV5uw8Aerz1xBUuuZfsNaLdTssuayF3S2l+Pz/ cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvt8xe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMXgIi021817;
        Sun, 17 Jul 2022 02:48:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k1n7ky-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEqbaQNvujTJkSNjQ3FiCwzbuQvfwjPqWebOLUKjZpJQuB+aucDHY2s+/rBt90bIL0wRT+KFz+Ni4UqOaPkub4LF8PJpfiB/6E95v4pm+VorvSzKts0MqixbmRtaj6/J+6CjRN9gR/PVrns0RjnofyuvPMGB1eRlSqhubSXsDqsN+JZTrMjCZMWxOEHoky7yF5R2mB/D4my0DC2MnCWfVUru4NJIbrpott6xvNO0iCaw092LvVc/FyJEKDqOCzTkTaKsNEPzhVLGHqjqwah1PQq+X4PE5g4PU87Hv9nXhVo1V0+wUD0O35bbZ8V6nxsI/beYSxyclMPJNevK62SjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBPbWbi5Cx8yH1RInecAiNIHWj2X2AUkX/qhUIYGxkM=;
 b=Zwmm37/5gV1dVR1YSeSzRcTbcitET9vZON/iF8lb1Zr2V6BMb0bnBBESYnuSMQ2mTledl+KxO1V5KFq15Mamqe4Uo3uEW8OeR1K1m84GM9miDu+7aVQfY+87sKst4cgomR14ea7cIyhJZ0EKt9/SG8Vfp3pmDboLVwFi2zYH7kmFGADXSY4wLMvdzJog34AgAjWg9KXzufBon4rRirxJp0t8Xuhw4LjtYsEo5wOJbsxsxYBJFOZVZcpjMyxJiDeC1od2Tdzv3GUEdoUH6uCdh63p6tUgZwlLzsK3b7iCFldoivbwH9iUN8pdQyPoV7deOr/QJk+WnHOkF2aG0ikLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBPbWbi5Cx8yH1RInecAiNIHWj2X2AUkX/qhUIYGxkM=;
 b=Hsk+x8n3A2NMYxE1k+y7QWWDzHRKZVYl4AMF6XbYaKrqmBdwPidR4ro5/NahnM846KEvuz/2KdxRjFZXAwsDaG3qy7OvDjv/d/yaBSHFan3VSPN03OzyivLyE7fLbMs/cr7jJHZzo+oSlWhIv33J/crOOIo79UJb+k40D5lxPMA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:48:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:48:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 66/69] riscv: use vma iterator for vdso
Thread-Topic: [PATCH v11 66/69] riscv: use vma iterator for vdso
Thread-Index: AQHYmYd7DApmFi+umUCmAeHJ7fg3xg==
Date:   Sun, 17 Jul 2022 02:46:58 +0000
Message-ID: <20220717024615.2106835-67-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fec5ce68-7aaf-4ac8-043e-08da679ec6a3
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yz+XJyMzs0LeOUfZoigtmhNxkpHHn5DOMYRy+q1uTgWeyIxA1Khyz6MhIw23RdwcxS3fJgscoRAOn4hE0DI2UiRMzJWRtA37CNo0s9PSnNLoJPyAve3DThBiYNSZwVi13L3uNDBDV0Hs6gU5FRy3/JTn/5r2ZmxyA6sDudd9IZdIFg+kNi9W5j6R9qCY9g6k/vaqkOYUaO+lNd2sChLR/rltJSWdzJ+mTfwf7iQWAP/lrYPnd3Nwj0Vszy62+0s6fm+bzv1zlDLCrezsQf0dWUjG4v3PfO2fUgtNWhYhOO4M6TOh8uCAxVkl7FNPdWymsZHUwAU7TzjfrggFiAfR1u+8oVLlwKs/GQU3UpbM7sUH9bPmb4AigfxixH9MxtKoCjldLwHiTMlXQiM+BLtP1/5TvPvINgd+nsRkY+kCcNX34yQsTazuROI8/qdjBHn7bKAuM7/ftkk8eXUV8wTOGqGL4e0Rw6CdeUq4Goc6edyYY7V9bHn65RkGzsTPs2CIC7DXeVrSG62zzWHhwDudFvRZ6oke3a6A6ThL99+BByiAQy1lRiLgmmDotK6GDCjYR9ZdnvOVhi9a3mDtYlt7Mr+qxt9Dl2SY5oxwfsV042gpjTyYr2q70bazeL0u7b1D9xmh8KXQmdhMvCkTwccifuHSI1SMoSz+v40lasZMtXyfnkQB0jduXwNxeGHqqmfrNbgUWgF1daQmyPm2KpM5sASlCeJruZe2fW2zPKRafuZWj7z6Y9Lof05Gp+i3tt/PXyEm6Xa8zo3PikyHgPfPSA3vVInssPg+zQ8PGl2Ntnzbw80Mn96zhD0Tyb6dPySCWFktMcP89VfDyT21A4PmH2xBoEXlU359v5AEwaoyhEUSLkAxKL/lNIfDhQmmhq4y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PFYj3Oik8LMlW6JtyYIGM54kwLcsfG04vIom0FFLiSQ/zRvQugLgsw9jk2?=
 =?iso-8859-1?Q?8m0wsL7V6BYNOkCzYJ0bxAitFfZkTcAjKtHlX17l2rCTIILAJDNjzptcKR?=
 =?iso-8859-1?Q?hG/e10jW/oQNLzvtniyTgePKJvcJ5yULXOX5VG+UzQKe61W7aaCI+ckjAz?=
 =?iso-8859-1?Q?b2j3k8hYptNMKh0ADyUYWB8qWMByjMVoe3GexMBIKUpEnD9/QLSOnvDhBT?=
 =?iso-8859-1?Q?YGfcZUdPMMoLSQ+QZ4NBhjZZlzqZPnwRKWGGrwVJhiDBFEbeGOUg42K/UQ?=
 =?iso-8859-1?Q?M1Y7G8DHcEHgtXQmjjYuD1sgZIXohoSCYMfyEV4h+hsT5Ve2P+H5xewX0H?=
 =?iso-8859-1?Q?Gaysi1fQcbq8ZX6+W3pmRx/q1q9AOXRzGdY8fFcD2fkJoqhRjY1uR6lzoK?=
 =?iso-8859-1?Q?9nm6qipiopu6RtJbG9zKydnvyUct9/tbmyiUzRmw6KGhokRDQbCDWIGUUm?=
 =?iso-8859-1?Q?RrMunOXibSw3sspYeaUkK8/PcxrTBBQoJzB6nIQBiKe/yUspSH0x/MuMIL?=
 =?iso-8859-1?Q?35SfRGtuo2La8OFmQhsPNPg11/ewJk3MP1CPpOHLbo50FMdIxO0NC6g6nh?=
 =?iso-8859-1?Q?gXanXwV25WZolImSFaBBDwcvvHM7kGfJzwC+Pl4Ys2+hHdH+ApGfpa5etX?=
 =?iso-8859-1?Q?hJWQsVb8F3Td0qKhjkxLp8ubrO1qJgh2nhadPJxHkn0dg/NlMUwxv8onZU?=
 =?iso-8859-1?Q?tM6vluZHjmjV/C9T4qnxIAZWw7aZnCW7rawBUVAisDnRGUlDw+WnOEYqeN?=
 =?iso-8859-1?Q?h2TqiWeKaffO9vZW2x8y/WBWJmlKpPWFDfaXoJD08EWzKusWS5fP3az42u?=
 =?iso-8859-1?Q?S1J8crEk2hDTYVA043vP3ZfluAI2/hKXnN6ptWz0/7HSndT8LGrGe8SCSk?=
 =?iso-8859-1?Q?XjuhRRQtjayFtwDkU+gwWRaIrnS8+dKcDc5EOadlw+qFZB7Ew4FcoXFfKA?=
 =?iso-8859-1?Q?tVpZ2qE/3stuQq9QPeAPZOWNfBpHnvO0UFsWSRgwDYsy5cYwtLKFedUYX+?=
 =?iso-8859-1?Q?nJtOChZf7LRZOFwmJb0c7RCsLrgonP6yxYJtFWhJVPshR1sDeicF0aJKUf?=
 =?iso-8859-1?Q?goLbhnhcTsWX1OfZzsrYxU+3htMdL4oY5YWVOqmd1KdX/10sUdAna/PdfR?=
 =?iso-8859-1?Q?yrCwH885GYLkEVljrg1vlQsZg9G/VLZPnItuq/DcFQ8G83CKdxU8g2PR43?=
 =?iso-8859-1?Q?H1szAoXLW+XU1gkVFcteSKOu89AEB9k8xYne4qDgCP1VbJOsg0zx64DEyT?=
 =?iso-8859-1?Q?mGkPzsBbdhOiinO21BZNe5J/HDOxJMBl6zedYkNoxKcK8Sw071Mrmu1DlP?=
 =?iso-8859-1?Q?uimWsd44eevK5wnTRuZqJfjZTJhBacvMgGCVVA7c7XjdiynTAxD5iBCJcf?=
 =?iso-8859-1?Q?/6ctjZUMfRn+Fi+cdi8EpcRYFVfO+BQ0L0SJROZXF1gGGB43jOqfD8ZHhy?=
 =?iso-8859-1?Q?62iM9ybkeN/TIm1/aEKp5AtpUbglS+XH+E16vDjP1gOFCW6Ys6TPt/sEMi?=
 =?iso-8859-1?Q?IaCYq8d7jp+4itZ2ImXNbZDfU8fEU9w1Eav5neWf2h6LgPrbMQv3WmrbwP?=
 =?iso-8859-1?Q?3NwOFX0x9J9IkeyzfQgqfZZ26JQVRh20B1daAIWBHzt4bR56WdPAD8TvpC?=
 =?iso-8859-1?Q?AoilhytFrf7TXXbi6T59slonhRsh6owpY6Swv0o6WIGN5n6HkMYzioVg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec5ce68-7aaf-4ac8-043e-08da679ec6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:58.5051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7EhIgaqsiLS5LjAat0cX8QbHFfj9wcKFwQgWv5J5pzE0sTGYJ7mCyhMsEp7f4U3JAaaBEFMuh0JRG5yx5psmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=903 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-GUID: iZDpK6S2SXrWo9KkowrHXCxd76JGv4bu
X-Proofpoint-ORIG-GUID: iZDpK6S2SXrWo9KkowrHXCxd76JGv4bu
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

Remove the linked list use in favour of the vma iterator.

Link: https://lkml.kernel.org/r/20220504011345.662299-51-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-67-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/riscv/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 69b05b6c181b..692e7ae3dcb8 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -114,11 +114,12 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct __vdso_info *vdso_info =3D mm->context.vdso_info;
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info->dm))
--=20
2.35.1
