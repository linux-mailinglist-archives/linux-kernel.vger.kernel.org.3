Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1CD59C222
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiHVPGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiHVPEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:04:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6383B95C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:04:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkP12022949;
        Mon, 22 Aug 2022 15:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pf05LVAdeYWH4Fp2Za7+spxg03QxKUFqdyIiG+twFtk=;
 b=ljUWIURqtweI9vn5UNtMw9OH7e8XnJTFc2hxqRlfTvVYA/NBCv2gKKlgfioautr8PTyX
 BnOyQjqbvk1xWgMyKT2C3U/6uQ3VJRRmdmHXZh/Gj/vTAaNkZTAjvPhsogjreMEV9yeD
 I06CnPww67govFCOXHxGxOEtClcvWDDvWOgpp2e//fiLbTzykcyMaPkNtLnrH/Wtc9DK
 RNCLYsILRrPFo1FuhAzR3svKdnKnxZ06uHdlIaVjr7CILZMHAW2OPyEpCv/iLT1VfkmS
 5gyIVBrdYTmVJU+VuvrEBDM/9md+d0KsnAcmQ7UnRmW9hmE27NeMLiYGvz6ktwyR8jKn sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:04:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4l7j025387;
        Mon, 22 Aug 2022 15:04:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn1u9j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/xPvAScHB3dIwAw2cK58U0zRtnUD3RnqxcKak/byNaPXvNw4x5R+z/q7ukojaBfdjvj0YnrDe9vGI8EshsBEY/foejVd6zocPXIFgKtxngX7c/tsZN0i9sbsV1x7jOHgrZ7J6ylF7f+NjykeQ7T8R4wnZVmY5vBLDjgo8rtcdU0L4w0vh+x9mE2jhKE5xFdgeKcHyIFG02YU76DDiFYtPdYcBambwELuY5JiwhPDpMT+typiwRJfZpSyL/cwaGJh2nvUaQWWLA/3nDQzAGOkYVCSwlQV9uHRjDrIzdznq0b16fUzoV39b2sZUzF0E/hzoFdReKZ2n3yw1yBww1+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf05LVAdeYWH4Fp2Za7+spxg03QxKUFqdyIiG+twFtk=;
 b=Z1acWtMENvx43XmGZl3ZAOe2QEW/FOv1wVC/GtrQPzMKK4ONIju+MRdZxOOSnvzwX1Y6ggs11seKtIZ6RnW4tdz9eKePlCpH8+lZAbMkDW5PQgCMSR2xWyH9BYb7PDFpjwesoqAS9jFrU3HyOz5M0/PfNsVeR0xcpvT71VmdXftmmJrQqQNt8loF3zBtv7pvgZdafJ/2yiwXd1jPvtrMrhrUa5QW9NuEgz1JrHPdZvkwsp4qNzMmz3/KMV/gPF0eDXL2vIjdCC1uG97glDNDm7uv5uD774lA9HEW6n//DCwrELVqKO/aZXcCUiUxSCPUYkx60E4KNibht/iswOfRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf05LVAdeYWH4Fp2Za7+spxg03QxKUFqdyIiG+twFtk=;
 b=MN0rJCDxJVnpe15zQQTd6jAhHUm2wOsXkxwi8Vdvrr+0B5koGclmzOEK4rRxTEvpGJ1jR0LbKTTZR3v2OatwW2z02schkJ5YFmZq5F3lbjKuP3Wad1yKt8hugJflk/o8Vj/YGYMHwJl6ApB+cYIqzG6MMb+0X/9thj7CxDVWoCI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5418.namprd10.prod.outlook.com (2603:10b6:510:e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 15:04:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:04:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 20/70] mm: optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v13 20/70] mm: optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHYtjh7Q2PLOQsldUi7nnS8KDjRkQ==
Date:   Mon, 22 Aug 2022 15:04:32 +0000
Message-ID: <20220822150128.1562046-21-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bc07ee2-d64b-411a-e35f-08da844f9e7c
x-ms-traffictypediagnostic: PH0PR10MB5418:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uw/BZw6DuCZ6WJtQX5yHwqjN/vsq71OuJWTY1H9oL/JtR3NtyxEeaTkgvE8Sq+OfQ1qqH3NtdqRMYLPZ+8qELFjtfVeMD+NNEcAAmrT7qnfyCP9DPx3cxFQb56f8Dq7C32mlPZ+DxfOAt26gasCkgju/mR8Sq1lFTe5tNgqYc4znzz3SJNlnf68Lel5vfRiu6Qcai8wwbYPKHluwj/4ddDtO0W36NqWhWnlY3fM14j1XJFuhLGJWrbS1q1FALTDSe3CtrhWvNjapsLjM7lT0lnx+KQy1K7/MaoIkCoWHKSHDOvWJhk7f5x0pP+2ZkIFglNwj0dfsSwMOwJWlCVvb6T2qE//nEcDFUTU3M/+1KNrjpUNxCJvJJULjI1AmV1YVg8zR3mjpym8hPty5iBME++sVGjHU2CFa48BCvF9R5hzIwCdhYJi13ovBaX8nyW+nPK7H73prygfooGbzt261++OG+B6evgBJlWjoT6B9c2xH1Umom2Zx5VHIDUh21FZHLBNSNo/cOkudipt8zwrveheCovlGuLro7WEPh2cJugtdbWu663G29zbseYn5QoTema28iintCtgxavTY5TrYIJQBJZ5x5H4iPMkePG9wUjj3jypWSu4d0ZnsM3YWKvG50Cokci/mAYt2Nc9ib+lCsFH2dNUh84BQemribXy6SMI1ROk8u7lFRh5lJZ/6nDUv2oEuwRTwwbNYcZ19JYr2+qL5v8sXSZbirLHMmFkPziXzqVqPvhMtd+iPkrvFt1/mU1xd+7/3r9WDGvzncxOELg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(136003)(346002)(366004)(83380400001)(6506007)(6512007)(2616005)(26005)(2906002)(1076003)(186003)(38070700005)(86362001)(8676002)(38100700002)(122000001)(6486002)(4744005)(76116006)(66946007)(41300700001)(44832011)(5660300002)(316002)(478600001)(36756003)(54906003)(110136005)(64756008)(66476007)(66556008)(66446008)(8936002)(4326008)(71200400001)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WJIL+PaYuvQE3T3MB9Wpk0Rc1VDGY6f3WExWVMxe5wVPZuiljjkxLt1m8s?=
 =?iso-8859-1?Q?U0SvdhBhQsLbqguOTZOt9NDslI3FnaLt+tN9vWq3vTSRje5FAx81sHANPs?=
 =?iso-8859-1?Q?ECwCC1SwMrxUbgZ9w6InCHPbXkTjTTqcbCYuJqdMUrWjnicUR4G4gRNIew?=
 =?iso-8859-1?Q?N5H4whTe+cw5/+mYNMKDTbY6efOjCrVYfziYVqR6qCqYxvngrO+MIp06S6?=
 =?iso-8859-1?Q?TXbP2xCBedD2V5gG7UlJsgG+QKudWKMzhl5xNkaPQRTDbnXYWEvYyuQDNd?=
 =?iso-8859-1?Q?tsQ6UHn+bEicILkyXkQQlzNDmoAjIDKnMr+PHgkQKvPiNOh5u9pexRW4Bb?=
 =?iso-8859-1?Q?p7EuClLHQURNTzL2JDbTdEFSh+zwrinICVLy6j8L1g6BzSjenYodmWEepj?=
 =?iso-8859-1?Q?638hhQkXFP0HF+l17fS+7kd+Qpy/PiDIwpzk/5y4vVhbjl8w5vCAel163c?=
 =?iso-8859-1?Q?iZQyQkpN/ICPTyeZi76YNOuSKaGHLy5XbAuGmrmT6UNpaS5Oz8A/7m3OLw?=
 =?iso-8859-1?Q?uxUSMIPML8RlXUF5zfZNApmFbg7ZVQ+lXdABZdFmBWDY23WXUTPzK5TF8n?=
 =?iso-8859-1?Q?KBQQPQOoeXw+B2z5i1HEo2rUHF718I6YJPXziOCOWyWqRTdNybIaehBh15?=
 =?iso-8859-1?Q?oxJ8kLvUFsTTehW5q8QJOS8UpLGs5aAtVbaMjSGdEYQYWMrb+XD+5IynFz?=
 =?iso-8859-1?Q?dLWg3+iqe7uhupDt48qnYHZOh1NH4JHCX4vKEZcNNsZZAveEMxLE9+YjUJ?=
 =?iso-8859-1?Q?AfiyAVy6nggHDHsg8x0IzQo3mEejLkA4oqXNEp/6AECdoBDHCM4ZB+K4Pb?=
 =?iso-8859-1?Q?AzstsxwVJhCI9YGaEOH05mz5s+/jX3tIC6EmZArZmelH6uEkzZNiYQAq8y?=
 =?iso-8859-1?Q?FlvMR8u4C2G4zfyUz/XEgg3gKUhZuVK05olQzFigyxaci8ypGd2yJZL6Ug?=
 =?iso-8859-1?Q?F2Seyi77fxjv1WJ/XTWzCaZNK1GR8OqiDL/9ak4v20XfWLbSGKdS0bLicD?=
 =?iso-8859-1?Q?y3oLlLhxXCi/ek2skSi559nwjmV4RARxjqP+DASTXn2yvt3UrLXhp8aVhI?=
 =?iso-8859-1?Q?fPBT8bZPHKdU0ycyaidL1pG08lw6XR17MZctMK57zLvPlrLv4CaR6a1HUe?=
 =?iso-8859-1?Q?OWS96j05Gj/ISHz8c+ivMQf8sUboS4dsBRnx/Vtg/juCqlrCKWpe8E2Vge?=
 =?iso-8859-1?Q?73/q5Wehpts1OUO94RmFsZ37nnxnzfyAPVaZZKWYTCHBVmx+tBoE2oPV/+?=
 =?iso-8859-1?Q?fzIP7zFcfyKL0dZDmKDwnQjGrfkE3nFSR46YsYzXa0KZiPb0+abBm5eO1A?=
 =?iso-8859-1?Q?fab0vvaMzI38H+Lj+q8JkFQ8BoTulRW5jRT5pjbRq61TuWc3n9MMkSP8fE?=
 =?iso-8859-1?Q?peyTtMeKWK2rtnSVDe9nZfT+AQfCRSnD0AUv0RenUxjVGKhlDGJnRnD5/G?=
 =?iso-8859-1?Q?Ak/WPoNheINZVLMtVhJAHiK64/GpgGZXvWSsjbJhuujhRhgd/tEjZSbxrs?=
 =?iso-8859-1?Q?lZAFEKpXrVHt0vTmjawVlg6R/1/7WuZnncyAxOD862fSK+jbDHtxo2rQkG?=
 =?iso-8859-1?Q?h52fRVsk7u2fYzG5G/SfH7CyLIPxzOtRNHpdDDS/7VP9mMs0SLe5lJPnRE?=
 =?iso-8859-1?Q?gQVvIOyBGzAtigYogsRwHC+/ZYjiSDKmyrVjOgSScWrE5AO85eoTAr9w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc07ee2-d64b-411a-e35f-08da844f9e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:04:32.2145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8PXpHroId8MX78TJIFs/RavzWuNWdJLMzPESi5VtDEEt7EaHs8gJbsJUdHbcz8uCNX9kv/JYCClEHdQJ7Sfow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=574 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: gKDJ3hKCXejpW7b6MBc3l0SPmn26qfBE
X-Proofpoint-GUID: gKDJ3hKCXejpW7b6MBc3l0SPmn26qfBE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_lookup() to walk the tree to the start value requested.  If the
vma at the start does not match, then the answer is NULL and there is no
need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 07fcf63f9b01..d53d236f7869 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2842,7 +2842,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.35.1
