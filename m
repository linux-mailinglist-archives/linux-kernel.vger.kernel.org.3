Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA77510196
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbiDZPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352165AbiDZPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43261161E93
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:08:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxi3032179;
        Tue, 26 Apr 2022 15:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+JQyACM6PEGC4qhy246qLQ3omRU4Z0eoglWR42xI5g8=;
 b=lxRUzXnShv5oLMnTiwI0f6RsiQ0EL3l9h256Ohj3FcODF3MSb1yZm6tcs1G7iV/FuySJ
 rfUIrRC9/1npd8LdLgwQ7eabDQkwhHO2xBUBqBa/bTnMey93KwwwtH6V5kV8vuih95U1
 y+T1Yybd2lm0iaXNT8y8ugnpD1XJnb1WIxM2ZqwW0+P9X7MC34culk61DgB8r+FohaJY
 LEP0yBU5XUmfbNG3EtJPWgwZKWF7jtJtvwlsaIBC7yzkfAyArBJV7Hq77nSHd6NVg8+H
 lB1QiRjL3nPBq+hh9LoIBIaFzSZZyFW3hgZMXVMO5KvQlA4hGzKR3coKOmumkX/r0ocz oQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx57n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF56kV019265;
        Tue, 26 Apr 2022 15:08:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3ffs4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPdfdvtw1g2jCVB96oz4jyP/aLjHhaXUWfK5SQZljXe5e4EUiSnmw3YaZ602siNvg+6xML2YQsHH+FM0Raa8ilwEVk+h5+qV2myjxyJdEvyO28jX0qqIn4uHzLLnuxJP9QLxfZUX4+YUoZieVzyZHvO19r8KSqZJqhJrLxpNAVejIQgVg9zefx6o9LcbCo+aE/g7lE+L2aiHvvUOTwsMHmGk92infrw20mSmaCyB5lz1Z0Xx6skP5X2BA3AyvZsn4eHCpWG6ZiIVcTJ0ieeyQwRVNLIRiDJ7gbIVVeax1LbMPIG9HxxQiH//jn/dhZHYVRc5i+/8R896XPfEn7rTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JQyACM6PEGC4qhy246qLQ3omRU4Z0eoglWR42xI5g8=;
 b=Yq5QzfKhaCz9P9oedKQqrVkMN9MrRCCHE3LENGEW9YLUrtmbaUTXL0Y/Ofq4wzaF0q6nkVHIJB7U0RMMoNr3qol3OWoJ60QlIEyHZFgn/qa7E/QVYwYVPEytmL3Dz/tDuKl17pWPywYqCYziQJ5h7rhpc70ini3/LTy7tr6axVeZjsL4t7lLFVtCsw74r01qGgFdtNe76Ww/NQDCiUBZfCvmFN9DfvzRwqo2Szar6vT1/aWUFTaA4aM/y9H/K1WQG1ha5DTyuHLAZCIJbzXtNGh+O9GE6y8yqnWqO6LgIbSHPdgdc/WchyKEzmjIJcp0590L/rMr1XYpHvf71U/hkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JQyACM6PEGC4qhy246qLQ3omRU4Z0eoglWR42xI5g8=;
 b=b/rl5yshRtbbDf9ZjNumouL9iJOOewQf9vTdqsGznMvxMdTbyqqPk6mT9cxJd6CEbXGUyHMbpT+shDAZsuM4ZZapx8ZyIokWAje53sqvdXa91mRGxk/UN4yXgvbuT0MAspxIw6xXIB2zC6J8J2lI9+DPV0aC9fRPEYU707Pc5jk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB4925.namprd10.prod.outlook.com (2603:10b6:5:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:08:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:08:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 67/70] riscv: use vma iterator for vdso
Thread-Topic: [PATCH v8 67/70] riscv: use vma iterator for vdso
Thread-Index: AQHYWX9DPFr7P1Y3RkG6EH/EARth6w==
Date:   Tue, 26 Apr 2022 15:06:52 +0000
Message-ID: <20220426150616.3937571-68-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11911345-bd12-46eb-6b6e-08da27969360
x-ms-traffictypediagnostic: DS7PR10MB4925:EE_
x-microsoft-antispam-prvs: <DS7PR10MB49252786D70CE59BDD11F138FDFB9@DS7PR10MB4925.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2YpmkuIG0LuS5MH/RkAK3dxuktTg+rTJoByLKL7DiOoApUjzvlL8IMbHAY0DaIUeRCaieqzgeFFczY2kJXvXvlXL6Krb7TRaB9soQ7UhWS5m5Wxy9ilsqHhYsPDvNvlB3osiauI7jTjQfem/PWJjMj76yvSSKg1Y1HBrMNnh+BJmhi6ZFsA7qsp7YPFclfSt7JjIrN+njrquxiETROvanVtq46JB8ytrs6JsDVDE2DFLcaXTMwZDK5EUdH9maw+yjkiOc6+kFyyAdT+zmUMkBscJQaYuc62r1z0N2rZXiLRCfn02zb0H3YVSHAzT3iLeOwVeGKank46s6wgjddKZahb3QInCEzu999QU8htXuT+5LMeBBstp2Qs2y3aHBfgoiJ/KXic7C0PDIP81Qxgp80CUxLsDX2iO/0KFvV7OLwMBSEf6iY3bAXK63/wk4vrB3n+sQVdR20O02KBP89reodb/FZlfhGt62On16noPp7d11VWMlnN11NWOQxupoizDBqE7uE2LrmoCn/Bmd771KzXfFYnl6KcY66cVeHMye2n1AIqLdePOtUz55Kajq1hLVMDNgNZ8pI0zt8DRe41wIEBSxM/Qh9MflQebS0UuBUSyPQhB5Ep/w0wjhC+4bYqZdaPVAtxL+rpmBzp/zBYRl+rh/ASQTYS9HhwgzCDBp3Q/KZdzQI3cnhGlpEe1hntEPZlJ3qlRhnlyBy+uvul4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6486002)(316002)(66556008)(508600001)(38070700005)(86362001)(8676002)(2616005)(6512007)(110136005)(71200400001)(76116006)(91956017)(66946007)(122000001)(6666004)(26005)(5660300002)(8936002)(6506007)(36756003)(83380400001)(4744005)(1076003)(2906002)(44832011)(186003)(66446008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dg4bgpLvux2GJ/FgWH5qsMmC4rNHRhKUfiCJLZeTiU7kg7K9SbEmdi3SNV?=
 =?iso-8859-1?Q?mQChpKizd7/bLL94UajKtJt9QA6mcpRUbUs/IZML5LOYqxsZQV9mfJ3TTq?=
 =?iso-8859-1?Q?USIn/q539z/ZekSqemx9ma7HiwfDG9uEpCwddUjyCEC+k2/TaMO/oQxXGL?=
 =?iso-8859-1?Q?KZBNtF/mnzzbs2MAxniMmYljLWSQxppGhTCYvCiCrdRIqgbyOkqOJUPp0m?=
 =?iso-8859-1?Q?QKHKWzTHzcCDhj+RavQ20sHiTzFm7eITh6P2/vM6ItwJQVzmNjYcqBgevi?=
 =?iso-8859-1?Q?grRvFxq8cDujvvci+4J3qPdZy8jbdlt+x7vrX92sEWWJkmOPP5mCY8Gn9A?=
 =?iso-8859-1?Q?a5ZHnCMHpLW/IzwWezd/FqBPkAF/ZSSTcQcEOnnAa0I5q4E4Y16huSy0xF?=
 =?iso-8859-1?Q?4+zEGz4kyku9UOmb9D2cx1v4/Ej3MsataIl6jBOzHSviJ0mkhiccbmm5vW?=
 =?iso-8859-1?Q?WPcKXzn+J0UpZDrlhv97Xi4bWywsW1l5Sgpzhg7VXQpHGKiwkBqrVKJ9Mm?=
 =?iso-8859-1?Q?5nJBL9MTFxLDzhbjn/X9pxiDMP+9y5isXmzbXPLa+v2kHwjpDgbXXujmwC?=
 =?iso-8859-1?Q?qCIRvWfS9d8Q7miOOZvc+1vYHE//fU2lfpC+uR+VTwJv1hZYBtQhQlfObf?=
 =?iso-8859-1?Q?x39wDH/OC8mV8DWJPHcVBiPAVI9mgMY+NtFvyG1vPGH9PfSM9J1SMHoV3O?=
 =?iso-8859-1?Q?m5ZMl9Ed5JQmmdj8+eSLAOWIwWrfL8XVdI0LekGlOvcylAs3kdzFa0yPZI?=
 =?iso-8859-1?Q?1zdhx36Rx4p09BYirhzWaYu5frj7SGSqJRTh2grpJdve1jPViu24ltnXJG?=
 =?iso-8859-1?Q?Oyxvnv2Mur26OvTLFUUtrJi8fYsVwoaWSkYWZE9Fg2M/yKGuD0nuKfRTE6?=
 =?iso-8859-1?Q?oM30uOhbn1F4BrxpPMrCCjd8i+t4kT8B95bkhb5z/HzAOyxNYqYlpanCaE?=
 =?iso-8859-1?Q?A6Y0euQvOatWUu0Mtob8uFZPSJVd3MOb634EfmSY42MYl9yfvPw+npsSqb?=
 =?iso-8859-1?Q?O4eGHA4ajTzp7M3DVrDuGmwZOT+sTWAgI0n5OKxh2tXEHkRK7lISX8zSwp?=
 =?iso-8859-1?Q?6QROyUmUaADBnQtN7qaIHII9iY6qzp7PO9lzKW+AZLapL95poYJYGZjVnt?=
 =?iso-8859-1?Q?0+4iKaC73ceR6XRuto4iHaIt9I3ffLbCFrKda3lW1ugTvI1QIcKn9SEAQi?=
 =?iso-8859-1?Q?Mpa3BPNk4rngb6HzHViBmm9p9Of1V6TQMlJ+c/FGyiO3Jl47GnBU6c3c34?=
 =?iso-8859-1?Q?ZBV7rnfOOb9O+NxCrC0+wNxhih85peoz+2+dEmgi8gKtLE6bGOgzHe8455?=
 =?iso-8859-1?Q?zls5pTYgtuF+FL37w0SLw421y8q5IF339PDC3o3PNh3j5QXFcTZG4vmw/M?=
 =?iso-8859-1?Q?dEADcl0AGK+rZg+kznapk1pkIqMMtpAWc4kGmjmKz8brM+OPpAjaFPEp9w?=
 =?iso-8859-1?Q?SM8VCLochHVWaEGhwSCDFLLQ+uP5QZ8m3rHvqKZtCuRcF6rOEXYQTBqRBh?=
 =?iso-8859-1?Q?QurUrh7tSNsTuIIwRkwg/qrpI1SmrMTD8WZHob8Jnv/8MAFO/rM55mvvkL?=
 =?iso-8859-1?Q?Q+W36VxPtcj3B8IYiHIwU5tx4MmTSjirRz6Vv1M922TdxVQcoTdZies8uG?=
 =?iso-8859-1?Q?9PQUZTYPSLZ7JmkNgW9IEff7lJN2EuNSa4xVzLussTC5Ysep42Ku15NFKu?=
 =?iso-8859-1?Q?3j5zxYZGWzeh+eoACI21qEByNXh/iHhtIIjRGUPjzC2EMAJzb+OUqS1wHf?=
 =?iso-8859-1?Q?FlPpg/S+izGK0lZB0SMXAZ0oXHjUeLu0xqAc7bRcPjq4usnLg2cmadxzEI?=
 =?iso-8859-1?Q?dA8EWmgHKbwG5bE0EfJv4EgjQaM8rbk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11911345-bd12-46eb-6b6e-08da27969360
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:52.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ci2Oqtt5x4zVCn9KHFXh7UGBel/3i8dIrU6h8/vdwkzqprN9wSl3h+BMBqK9jHUlmVvsJlBcnn6iF8s4GsnMYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=864
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: SxLiW5bHMvlfCruXSU-qf4_XnGCNoAuQ
X-Proofpoint-GUID: SxLiW5bHMvlfCruXSU-qf4_XnGCNoAuQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove the linked list use in favour of the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/riscv/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index a9436a65161a..20e2ae135fb9 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -116,10 +116,11 @@ int vdso_join_timens(struct task_struct *task, struct=
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
 		if (vma_is_special_mapping(vma, vdso_info.dm))
--=20
2.35.1
