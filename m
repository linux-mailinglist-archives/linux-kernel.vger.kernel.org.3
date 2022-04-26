Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182CA510162
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352156AbiDZPLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352083AbiDZPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A63158F53
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxD8011324;
        Tue, 26 Apr 2022 15:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=h3Ms/12Gbt4y0rVLFx+f+g4wA/cJ/I2AJUkj8AqbHTM=;
 b=lijQ60kLAzuyaRMiVCk7/RF3wv8LTF1xH+S6pja8dfcu37AV/q2gpC6eebQJ/kpSDaxL
 4dqLoOHLTBwRKCklKFWWtDcOj+UkAhWQ9DjRE8bRlD3Q/Nl85ljwsyHkUrzHjlaCo7qo
 vKvuU7yQqGZJidDvJmZ/Zt+Gqn7W3Z20Mxv5KPszyWLWzaNV2tve+NRwUgY5nsDWFdP4
 5bR51ImyoopIUQ0HSuGWG0XXKAx1FX48WM13eG4Qv/VptXGWqGp+U788fh5wn1OKUiz5
 PV6ZKhrNaUoVkH0TPAxOEn+lfX0MmeVMyol0snevv0uIbNuYeRo+mw6wMj7qUrkZzmNw gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4ef7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Uo5037883;
        Tue, 26 Apr 2022 15:07:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkugm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFysbTx9iGjNj1PBBveiz5N5zQuA/EzVS6536A0283HYyj5KPQr0EYYn/oUlXqRDct554GjQFO55pA7ou1jg2s0sx5pRNKiufyRuNc9GftlBpRdxUPCrk6+k17ucJSHedOyDYU37UttahDyIXzbRwAghsUWefEX1BJ9GgO8Fu9DRuXLQ/NaKKzO/14TwKMoIG4NS7Ra1YJ8+kPwi7ndukxWIfIVoNNF4JEnaiGdgxrgsZDZ+w+K7V00bGedNpkzrrHSgWwewLG2VPdxK+lnNzzu7c/YxPglfrxPRAZQabtV7s4koCYC0VJ4LfkXEL8UmzkZiJKqoZRVZxg0FBiFczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3Ms/12Gbt4y0rVLFx+f+g4wA/cJ/I2AJUkj8AqbHTM=;
 b=Ko0163fwZGkAKWtR7ma0YtVTrw9UdrCWBv2NR6w3D6qnjQ0D8t7ik0UZwds0+qS2OGun1K5HYK16Iu6O01FJeYcXhKCZ+TxH1Zs2GauT/E7KZQr3labvcMcaayOPYIUmKy2sSxElTd26zAId2CP8uEDa2h1N8hzatTOYz9wJAxM1LEMeqLBlxhwp3eGuyOLzBcrLr8dWScK2shwIkTes6dlTMpCx1C0aVIYGTMAlEeaz7i0fPykBWz1qaaMrcHaQWaZ9w1Hf4vlDYhlsBwV4sPksm6UORHyr8FpCJOWaSHQjeq4ksgCdWCx6BCyVDDXsAzkq/8c/upWEmbQSCXzRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Ms/12Gbt4y0rVLFx+f+g4wA/cJ/I2AJUkj8AqbHTM=;
 b=gm0AZ0E1r6lHIAZVxI4Vf9w/OoMCv88SAaqx4Ie5rvrPUGJx8LqRKCMqW+2GGb0AfFGHccLIfPf2hQaKUvaBfP9w8GPr9CBdxPaXgqCzLukfolXatnUWKGZJaUFiWo9r0LgkzqQM5GHLM/u56n+vNuIWZIOGNAMDGXiAjpRptXU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 41/70] coredump: remove vma linked list walk
Thread-Topic: [PATCH v8 41/70] coredump: remove vma linked list walk
Thread-Index: AQHYWX89no02ecDITEic1wGuIEEgng==
Date:   Tue, 26 Apr 2022 15:06:43 +0000
Message-ID: <20220426150616.3937571-42-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5683935d-7ec6-402f-23a5-08da279674a5
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB29290FF4D51BBF4C80DDB94CFDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYYfiVa/gKSMrwJ3VGsiy1KYhmSTyXkLedHU799YVpwxNgeGajEAp9sW+dO5JDXCfj0meK7C2Jsrb7XNM3w9yfmch0vhGBG3/z1CCs6zvK5mK/SPK3SaLDfe67LjmjYlyf2HFecQtbLKzJDKU+AfdrFy9U+hbsFPCi27sTu97zXDQVW3M2Qj7VYej/V8pAdfef2/jb9ZD2xBIo+I92JJDM5sy5Owmowu+7Mcd8e6mzh6f1lpdqxYIQRVenX4R85RbtEAnICkDtEbcgLMmo26IagFZ1n3VJ86gZIlzvqY/ofwGhH5hQQ/tSwdX+HqHfIFbuYf/+KUhpJGHZUqe13QBXeC5UL44pmfi5uTQbR4AIkQe0BmQidZjqFFcG2YfTEh0NV/MMhW1sdxd9yG+PwBW0Q41mRZbUp5BH6lTMwixACfJVAq96ohrnEDxZxILYIubZxihDw5UwTGnQqMrUFJwlvnVtntxvumXtUaMcxNU0LCNKbt9M0w/xtNk+TSRZcSCMuTtuu1OrqdVbTQpvHCaV/PM+3LM9TCurOeKqF3RsABgC/qdQ+nWgWMaazaTzL9C3q91/FXEIy1HtjU8OwthEM1vPpYpKE7jfsjcBtxSSidpRvxrCaUtWlw/VicpEwuz/1IktsC/AvLOBKjFJSC/CFNBMOR+Mgu04e8xNgJ2fboK9RqCPoVINv6xr7HHDPVDwMGH/xL1miMdr6t6MuZVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OydtNs9VwFXovD8M2GXM7X7dLMNc1Rbk3ApUjSrDd6Epe4Jni/gyvM3gMF?=
 =?iso-8859-1?Q?nUFeTx7ywLuT6p5fHBdMfDCvx1lubtn81svwMFDADbrcxopNYWvDCiTFHF?=
 =?iso-8859-1?Q?ktMvSw/UjzRi907exrMDp7rKpiakN1YTDudhUbDByXqOPKk9fjC7CjI8Gq?=
 =?iso-8859-1?Q?GYtbt7Wk00by/CwS4bU79VWee4IV8AMCYWGY419T2BnAHZrghmxZqa1Hdn?=
 =?iso-8859-1?Q?fGY++lTiL4ZjXIYVT2Eqml4zHIXDMAWpcUgsHPxhD0UYAUnEQU4mKqYz1T?=
 =?iso-8859-1?Q?LqSdOXZ3MwPCXgXK8D+iDhxDuaDJE3iwqftSXFmtcihA0HFGskTIQxKkNN?=
 =?iso-8859-1?Q?mVWnfKVxIRZ5WMEuYdgnJ808hv7aiPSP3tmZdE/FZpal8EmscBj8j1nLP+?=
 =?iso-8859-1?Q?rH2TRJDQd+X7RoMBaOJpyZUCt4T1UDT6iAAv+LKSnfDbaKMV0mc1oZLBpe?=
 =?iso-8859-1?Q?r2IlDwGr7Xj92sTKDQOiZ9CwH5WFUJp+SyNB7vx835hhOB3VsI4kDTLEDr?=
 =?iso-8859-1?Q?8b5a/xYF8cF6n1Sgr0x/V1GP4CcG1ws28MrLttVNvW+6Dq1ghNPjfzsPUc?=
 =?iso-8859-1?Q?Wo+HRo4KZjsTHW4CzzWCjhFuYPI/BA1rgwCwiAsAmXg7D8FfEzaBqUy6fm?=
 =?iso-8859-1?Q?yn9biURbTllxLwQHw4JpAht6SLUMxPmwdayvHyagAoSFfmRSXcDAmyrIVf?=
 =?iso-8859-1?Q?F8sIniZFsH8AC3RIMxiRaD6mQb/qeC8slOFCB9mH9nBtg5zjNETQjKStCX?=
 =?iso-8859-1?Q?OSe+F4zufNLzaoHv6Isx9vvLnKVwvRJuVSV0OD32tFwpLqyq3DIfgy8Tkg?=
 =?iso-8859-1?Q?v0dRcYz6LsWxz5IOLA6pWgqTGMLmt+gHXOG1LPleysJOVHq+ZRF58vmpBo?=
 =?iso-8859-1?Q?9BoU7PPxeiz6mqLHm+IVfAIMgyHrgE2d+kNve6BRweln4IT1cjJtAvaCx5?=
 =?iso-8859-1?Q?CZBoyCmi90h3tXVlB/R0hB7uICK7UCrM5qsOBAMSs9j9b9sLV7x6DwIkzP?=
 =?iso-8859-1?Q?IZ3NgPouz8K0iMGtwwENOUfaNGehQpJaLdgzsRVCW8LsPgEyVlSLABRlNF?=
 =?iso-8859-1?Q?Ni2hzRvEqSd/M1Izc+sWeN7hSSRK7ujN4o08e05Pcwa9jMwWilbEKtZ8Ig?=
 =?iso-8859-1?Q?tStaWyrBv/AXE4JSdjxoB3X+YBTHJJlJz8JMwn4QM15qvEzYbyWe0k8V38?=
 =?iso-8859-1?Q?FNHhR8kc8A2VBqRic3C4jKasngy+cmp1WFpUb1TCI2VP9q6C8wkgQ152af?=
 =?iso-8859-1?Q?2hEd9GT5xtLpCYTR35KKY0ZiB8XY5Jzu+LmBa9hCy7D8UyDIMlAcCNBsV9?=
 =?iso-8859-1?Q?aNKPAD1JbJ6IG1/gB8dLMq8Nv8uitUXVCWkSXT80gDii8tmoRgXt5onTo9?=
 =?iso-8859-1?Q?bk1MSU6Jh+xnV7PagpgZDWXeG/E4oJrQBbQoycWmCtZ4+jm17lY/tOiz9V?=
 =?iso-8859-1?Q?KfAK98vy6g3/JjY/kzG9+pgFXi3d29TiSvyHJcZPY38fmMqLDr9wtWvYNk?=
 =?iso-8859-1?Q?fXZUr+ePFXwBg7w8sUKSYJ2Qu3WB2Cq0/WCK1jJYtQKXG9ascEmqqRo2p8?=
 =?iso-8859-1?Q?2Q47Yi5OSeKH0ewup/j+lYoRxsTVR9SoowxC5uYIr0iMIJhA0U5qwH9pe3?=
 =?iso-8859-1?Q?6qlRzPayDmY5HLTcG8EMnAxAFVLczORSBd/3663YToFRWeBK8Jfy58ssMY?=
 =?iso-8859-1?Q?T6Sp1SdwTSk1pBfQpdNtLJ7fVF+wG7ubhRpqo0yYHjxHpTFI0JpRPSYiwC?=
 =?iso-8859-1?Q?xTcLOBYHLuMxq3EmiOQy/pupaTowHkCE5MF5N47U4qFJAOjNz5m5ROSfKR?=
 =?iso-8859-1?Q?ucno6lq/rrO6FcyRgColJY6AfwU3FGk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5683935d-7ec6-402f-23a5-08da279674a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:43.0521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFs1OOkvi9H459zAr+Uk8gLVSA8N9qTuTnFSfuZaXBDwGPCy2PV3JSMNEcz1sM9+FqiRlUT5Orz17B8cxPXzww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: kqYKTjj7IZX_nRCQp5jGQF7XAx7TFHes
X-Proofpoint-ORIG-GUID: kqYKTjj7IZX_nRCQp5jGQF7XAx7TFHes
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the Maple Tree iterator instead.  This is too complicated for the VMA
iterator to handle, so let's open-code it for now.  If this turns out to
be a common pattern, we can migrate it to common code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..3a0022c1ca36 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1072,30 +1072,20 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
-					struct vm_area_struct *gate_vma)
-{
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
-
-	if (ret)
-		return ret;
-	return gate_vma;
-}
-
 /*
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret;
-
-	ret =3D this_vma->vm_next;
-	if (ret)
-		return ret;
-	if (this_vma =3D=3D gate_vma)
+	if (gate_vma && (vma =3D=3D gate_vma))
 		return NULL;
+
+	vma =3D mas_next(mas, ULONG_MAX);
+	if (vma)
+		return vma;
 	return gate_vma;
 }
=20
@@ -1119,9 +1109,10 @@ static void free_vma_snapshot(struct coredump_params=
 *cprm)
  */
 static bool dump_vma_snapshot(struct coredump_params *cprm)
 {
-	struct vm_area_struct *vma, *gate_vma;
+	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	int i;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int i =3D 0;
=20
 	/*
 	 * Once the stack expansion code is fixed to not change VMA bounds
@@ -1141,8 +1132,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		return false;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
 		m->start =3D vma->vm_start;
@@ -1150,10 +1140,10 @@ static bool dump_vma_snapshot(struct coredump_param=
s *cprm)
 		m->flags =3D vma->vm_flags;
 		m->dump_size =3D vma_dump_size(vma, cprm->mm_flags);
 		m->pgoff =3D vma->vm_pgoff;
-
 		m->file =3D vma->vm_file;
 		if (m->file)
 			get_file(m->file);
+		i++;
 	}
=20
 	mmap_write_unlock(mm);
--=20
2.35.1
