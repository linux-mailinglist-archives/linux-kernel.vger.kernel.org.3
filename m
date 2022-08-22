Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB959C25F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiHVPKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiHVPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B285D3E76D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEphqZ016577;
        Mon, 22 Aug 2022 15:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ngf70k76kRpRObHjvGvMUliwq0ETt1cTVrTppxrchEY=;
 b=pBRQHdLwmLWNKLGXxJwrsbL+11Vmyl5DMar6AKVtimbslOMbPErIzD1dZpK9zUAdk3uk
 RtayBgyIsd+NXCjpuc71U6Nrj4Zunpu07qR/Q+EZ1GtLQoHllmLSoy5P7190/moOV3kX
 FltsCmslge21s47G2xx2nlM6Ty52wLbqHkRFjnoDQC2o35poAlSiFBqwo+TKeMBbOLks
 LlTVZHI8CWpPEZtw8w1viCn4A5Pj7FTOqdVemsSJSHCH0Qc18Kr/+UE4YGQCLy0zrng5
 jdDs4lr3i/5oFtePH24bwslmRcCU3M0Kna7K83pZy9d1wC1Xq0XwwNfwfJx3SmlGCq1o 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nab031868;
        Mon, 22 Aug 2022 15:06:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsfKkaOnZFpkZMOZYmiIn4LMsGGkfTz0sKpfICClgcStTt+H8seCr0itNWYgfge6NxW+r8/WHDhmoAmz/KKsGIGbX/ln7uGLrCc6I2wHpgOR7VgVGBy/KP9okodL8jW2AqCN5b6bpZNo5TyaiSBL/tjMHdyuP+9pbF1rIB+C7/7xiRZGIcoxA4OOqQTNs06LZvkdo96UXjiJ9F8uGFVneFlhCbi5Tia9wGCfq+aNkyfYVmuUm8PHJ46/CYCYRXkIGbM3eEv9Rk4LqpFaElAiLv2UMyJ+JLgsrn8EKdrfa1rdeZIrFMlHhwQY/TourD2z+DhKSSZX1RqOsGZQRh9zhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ngf70k76kRpRObHjvGvMUliwq0ETt1cTVrTppxrchEY=;
 b=cXl1edtt21rkTGnIKCzTOPb0VCpAqcV/zXnT6W5rkkWwAIw3q/7BTRcJd3HTL5dk6ZMcvLThOX6VBfcO51O+hjUjicse6Aaks3Wpt7vePoiIB7rHCFQDIH4g8YdSQBjAuNZo0jwP/ns6RULLlnShJLw6oyKXcXf7xIMTa0NftmHfET0zt/WOX9CeeiYUTSukDlrscW1NnBjnUzPD3FsFAh/gi1cgFU3MNvPQAOi4qfL3tfewEXZW2+YPWoFZp1nkVaXdgZeLS0UlfkNVbGBdMjl4oYvil55jPKW3pEUQt+WT0/iGP4+mcOY4phNmnt4Cv7wlriDJxKXCP/U3Ot6wFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngf70k76kRpRObHjvGvMUliwq0ETt1cTVrTppxrchEY=;
 b=D646UGegXKMvsgaBWeD0W5tSK8zyPqs4BKFHnrdEsKGfpLJ5TR8QiXKPDeP95EWVPw7opWJumvvBZnOgExL6fVRgG9+WBBmy3+1+pgWQ2CQ4ytQ7tn6gzmWS6L3CnGbPJW/0NAqQLUEfZCFFWVJOTlm1ZGQg3sBMhVihBdRsOBo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 43/70] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v13 43/70] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Index: AQHYtji/m5mzimtmq0eu1ZrHTOCI6Q==
Date:   Mon, 22 Aug 2022 15:06:25 +0000
Message-ID: <20220822150128.1562046-44-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 897e1438-579d-418b-8def-08da844fe321
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pP+SDxtkOULcuYVpns6mntc/WxA9qwZf+o0EoqvmafPr0NR+mfVVvwt/tcZRj3kOGky/N3iPKcGBKdNlCDQSN33KafL2fj00ZE1AlXrytKHuxC0LxrvrS2LOh35FRHuhGjwPNy5eTN7ar8abDCb86aqnqEaPhR4vs0igbTy+B7xelfUkt6K0cOzQ0MpfCnAAkAmoQ1/qrWHiXTNiOcvWcC1fWNgi73iR6Aof3g7dbDIlm08Y1xP6ufXg5iBzLjC9Fe7W23SIlofspAVYdv/+D1jL0fyqujYiCZZjoM7C1HL/JEDhuy3hV9Ll2E1iUpmEfMSbCMOOII8R7HxYWLIAELAjTrgOUjNjyY6e+tiZPSOKlkExS22Ab2o6kd6dEANZWzKQz6AZE6+y58v8OAWavGAgHA7FLoI2uYLw2xc5dgIEbZ+9mKhUebgOgbquClo3Op0T3NpYSQnTsBidof9bp9Sc3t9q8qfP8K/Hg69HEmxdK74y5zRbmYBW/b5qwFmu7N9OKHGQDll40n3Bdh+L5bImT66D9Vsi4dPr9vcbhCEd5d7Ge0xVUvQ9kmL2SosFTtAgCih+xgLC79sqfkCMW2c055tWYcXqQwuQOSRpB7MLEB05j4N30QIsSS8rXm2Hn4q8KHLveAmdgcMoBJRRwcmELor1+bfb8CFCUH5rYYFIr4dhnxA57VWzym5C8xMuWyVWJ/7swYGlf4PIR0sfT5mhW/whocntfebBxyH3uUHvd6QWd4gsmuhC4H4tPcf2OORhQELG4JdsJ8Zx2CH4og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(107886003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x+xy7aFS4EHXUM2qojcFCX5MNVIRQL9TVaC44XQeu3IlEcHc1Um4M/qgBp?=
 =?iso-8859-1?Q?EXOvr3SE6qSJJzvYeMBqGmwxazo3jj5vP+YQ29Bmn3gk8rGAqWWu37WLAq?=
 =?iso-8859-1?Q?+cPVCwF47AN8CayKjxKu4lg/WoUKVHCa5DO9wnEj7/NcFixjvsmKIMwMC8?=
 =?iso-8859-1?Q?RF0rwuvwAfiQxmzpGECQS3Tqj1nnPToVm/3aou2mnS1S40G6iJ1u3m2Ge5?=
 =?iso-8859-1?Q?cICQg9UYU8ow7k48xeCu5/dq9B1kz/HOS+BCh9GQHr4qDK6pum9A26sWQA?=
 =?iso-8859-1?Q?xwQO89y9eIC2gjfq7TMfcEuzcLHlTGpyWbLUy3e+OBnlYYLwAkFv5sQph1?=
 =?iso-8859-1?Q?pmL9EqQ1tAzlgUbla6C4czIJVpGvI5BCeFfK7fH1k42X3KPHOXUMCTjO+E?=
 =?iso-8859-1?Q?u5cSp58aj+iIblA+vviZe9QDj9abiE7Z+yHbOck5CejFJIfmhYYnO4JWwt?=
 =?iso-8859-1?Q?Pu2SKcsiylgNemSAO2dB3hWeSwh3aolq7/QcDEhLEgvTrUAd7gW2minNhD?=
 =?iso-8859-1?Q?h/b46ARxwm9q536NQq4k64JswSYZfrnx3TvDn4xTgMAjh3yNw5dvL2OKy4?=
 =?iso-8859-1?Q?knYEVM+/5QFF/X282iZBgHDKZwQkkJjRdWRVcB5ydffUolhQF9VMpKaKtG?=
 =?iso-8859-1?Q?/DlE812R0nrcgYGhZsuFOxE1JgAtIX7oUi8lg9415VF43/OW0dyOxdIdU7?=
 =?iso-8859-1?Q?C3E+xJUCYDGcMYgpQH/9dPki2KP7KpWJBVdLHg20VtzlG3A2+/XcKLYlzs?=
 =?iso-8859-1?Q?53+Age7t5b8Wa3eICUrRLY8dv7sMRYIXwdt/6+wa+fQIjcJM8cm53L3xwb?=
 =?iso-8859-1?Q?dSm1QURtaw9h0z1tCf1H36sjDC9Dgh1Eua0Tys9WuFIEGuhpm2q2NdUFEN?=
 =?iso-8859-1?Q?qUgTlIca1R9Fs9N0p6wVzt+KbJSqEnSil3qR0kE4Cwuo8mXofm7BBqLXHD?=
 =?iso-8859-1?Q?FgqT2Aayi0tZF8ohf7GiWIEywqV5Vv18YhYKwfgtyY4h/OFG3sK04UoK+/?=
 =?iso-8859-1?Q?ML+rfia34D7AxLw3VeML6U2qTPsv7uDY7vScv7HqZwDAOhHcyjplkMW9i5?=
 =?iso-8859-1?Q?SinBXUbiZnht0dzb6/AM/xaakjp9wCh3L4+7MfzWVQhn9BIqGz0OADUYmh?=
 =?iso-8859-1?Q?Ngx7yPb9rdycAoXbEYc9wzRk7sRCvB9R6MO17yO9QtlP+IZikxNOOoaShR?=
 =?iso-8859-1?Q?Ahn8QMyif7u8iroxi9l8ss7LicCT92YXYN4igfwMfzd+T2NxgJXz0Gpqvm?=
 =?iso-8859-1?Q?49Xgx/fQzQBVitTMLr2J7iXoF56i7uYMDgN72CAH5l78rvXRnsufZppBuY?=
 =?iso-8859-1?Q?LEQcjTc5m4Z9Clem9LfKs2FjZKIhBUStY/TRdstPenwra/vPlRHaeV0Dao?=
 =?iso-8859-1?Q?HpIcvXc4WPk1hzlzJeXgGkpLZDDkpOHGgNaBhZcd4j3piabM0ppNTc9kAM?=
 =?iso-8859-1?Q?V+MWyIsfyO1ZgDSjP9sRMCL4T6+KKGidDr59eqiKSbLSGixkLXprGq3+bc?=
 =?iso-8859-1?Q?dzlmbrj7oQIomO1pZxJgloyyiNGxExo/4IalPimCzq3oJlLE6UnYEMDY3Y?=
 =?iso-8859-1?Q?PDGZmkQrGJtRjwkV+qr9mnsW0Ij+sN0eUG4ZVW/zSb/iBJHjQN5Pam6DI2?=
 =?iso-8859-1?Q?4l/dfopTrl+AXoryzYFA43QGqB2IdwNUz1OFuuCIHrCQdvelTphBWgsw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897e1438-579d-418b-8def-08da844fe321
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:26.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8vZKg7Anw5fHfVUaGj5CUdAPfIDU7pyoHMGj+pvGtEprN1IYyUfhQlw99IhjYoRfdoIv6ybU1/gtaQTxn59Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: lPC9tCxAgUcy7jdkNKI_9E1hZD5rO8FM
X-Proofpoint-GUID: lPC9tCxAgUcy7jdkNKI_9E1hZD5rO8FM
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

Remove references to mm_struct linked list and highest_vm_end for when
they are removed

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/internal.h |  2 +-
 fs/proc/task_mmu.c | 73 ++++++++++++++++++++++++++--------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..f03000764ce5 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -285,7 +285,7 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 #ifdef CONFIG_MMU
-	struct vm_area_struct *tail_vma;
+	struct vma_iterator iter;
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9f70bc1c2766..8b4f3073f8f5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -123,12 +123,26 @@ static void release_task_mempolicy(struct proc_maps_p=
rivate *priv)
 }
 #endif
=20
+static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
+						loff_t *ppos)
+{
+	struct vm_area_struct *vma =3D vma_next(&priv->iter);
+
+	if (vma) {
+		*ppos =3D vma->vm_start;
+	} else {
+		*ppos =3D -2UL;
+		vma =3D get_gate_vma(priv->mm);
+	}
+
+	return vma;
+}
+
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	unsigned long last_addr =3D *ppos;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
=20
 	/* See m_next(). Zero at the start or after lseek. */
 	if (last_addr =3D=3D -1UL)
@@ -152,31 +166,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
 		return ERR_PTR(-EINTR);
 	}
=20
+	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
-	priv->tail_vma =3D get_gate_vma(mm);
-
-	vma =3D find_vma(mm, last_addr);
-	if (vma)
-		return vma;
+	if (last_addr =3D=3D -2UL)
+		return get_gate_vma(mm);
=20
-	return priv->tail_vma;
+	return proc_get_vma(priv, ppos);
 }
=20
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
-	struct proc_maps_private *priv =3D m->private;
-	struct vm_area_struct *next, *vma =3D v;
-
-	if (vma =3D=3D priv->tail_vma)
-		next =3D NULL;
-	else if (vma->vm_next)
-		next =3D vma->vm_next;
-	else
-		next =3D priv->tail_vma;
-
-	*ppos =3D next ? next->vm_start : -1UL;
-
-	return next;
+	if (*ppos =3D=3D -2UL) {
+		*ppos =3D -1UL;
+		return NULL;
+	}
+	return proc_get_vma(m->private, ppos);
 }
=20
 static void m_stop(struct seq_file *m, void *v)
@@ -876,16 +880,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mem_size_stats mss;
-	struct mm_struct *mm;
+	struct mm_struct *mm =3D priv->mm;
 	struct vm_area_struct *vma;
-	unsigned long last_vma_end =3D 0;
+	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
 		return -ESRCH;
=20
-	mm =3D priv->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		ret =3D -ESRCH;
 		goto out_put_task;
@@ -898,8 +902,13 @@ static int show_smaps_rollup(struct seq_file *m, void =
*v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
+	vma =3D mas_find(&mas, 0);
+
+	if (unlikely(!vma))
+		goto empty_set;
=20
-	for (vma =3D priv->mm->mmap; vma;) {
+	vma_start =3D vma->vm_start;
+	do {
 		smap_gather_stats(vma, &mss, 0);
 		last_vma_end =3D vma->vm_end;
=20
@@ -908,6 +917,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -951,7 +961,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -965,11 +975,10 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-		vma =3D vma->vm_next;
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
=20
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+empty_set:
+	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
=20
@@ -1262,6 +1271,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1281,7 +1291,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
@@ -1293,8 +1303,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
-				&cp);
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
--=20
2.35.1
