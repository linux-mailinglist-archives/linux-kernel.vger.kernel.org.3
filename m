Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50B25AF4C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiIFTts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiIFTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509389D124
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id93p019957;
        Tue, 6 Sep 2022 19:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=bbBPokVL0KnY8tLfXR+/cyjITdPAKtHqx3bsfoE+vfgK0e3PtWq4BJPt2LeqmSHXbOU0
 T9idCd8z4kJ2CsF6DvzluMpTCXGJPx6cOF3y7IudJlGABsxvQWOk8hXYXaf34NpCG9w4
 WvqDYEFW5AiXBnCwdoZQF38gdy0jyCQBL2st3FXMTP5IIrOKctNqEsVHXqdmIOA8ILes
 P0Ay+8QHQVJ95npgyps8sRu8OFafbFZEV4V4WWbD7S1C4UtYRaOZQjujtdNk77lukeZB
 0ajXozyZ/01Fazo9Sho8qy04Yps9Px2XsMDS4gntOYlEcgZZnntb6z2++yzi0b3o/Ula Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wc027549;
        Tue, 6 Sep 2022 19:48:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmxpycuT9JPoJ/QybLrUaJJM4gahyLcaLig23GUu7fMpGLOdQVIvQlqrbrnTzXFGcZG5GqxEmKwK/FvEg69ZXE6VgCh/+BHZ7CP78kQ79nyF3ac9d75j9lA1dw+NI0OVO60y6ddCxWNZBiPY+4D5f17tGOhLgudwTuxV3ywiVD8BLjRxdBiOy/HtwVIUsuoryEUdKVbRaQr7RYJ4s/aoVopVF25ktyd0iHXUQAIzgH3t9SIYB/uRm+h9KXFdPsamryU4wI1Wk9H5TmOu4kLi8cdWF9gIcf+oqwKoXvYi3oy5TJN9hAU04FgXDyyOGzzB+xZfuGKJEUzpf+R004Yxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=G5WVGh36vEKioLsTLE6BK4Y1L/1n0/whUbFsUivIhK9tbn9IK0WJjwWfQKRwK99B4V7EHO6cZJv1wA2Ld/YoJJV9r81n4g48uBCVwW/ECNxkl/wLwV2twgc9UysKMOdkbyo8pqawzzdKw5MXfvPo+INOMeVxJ+Yt2v8JuqBng5uV9ZO2IdLX/9jd13DdU27rgdNQo1yxRDHWDVDoEydNN9oZf/Kh+BGiYWhkalLIvhFWLXmU8PaIVdu8VL2/AHIFzIPYglZ0Xn2kjHJ7IwBVKbIG6uaSYd6OtRRdbmgWcaMgyQEeL1U+J95iZr6bTrFC/3i03AkfCD7KJvXWC3QcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=OLQQRa+C/S8hUGuaPOh2vPJ01J94pfl2Pkx1Ycf1w6AIxh/WxlIDvSG1dN6JxSDrv5E5FdcC+vr5KrFbMy5JOZTODP4n0skzzTKNNz1lyoUizM9J1r5O0XyWN9wryhk/3QzkBlRfSS+TARudHddLpMNl5hP3FDffcnskHONWnL0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 19/70] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v14 19/70] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHYwimvPXJ2ekWwQ0i+gFYplSYHWQ==
Date:   Tue, 6 Sep 2022 19:48:49 +0000
Message-ID: <20220906194824.2110408-20-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab812403-054f-4bb9-92ef-08da9040d5d2
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDEdDfx4GmsQyLKwXCPd+gk6D+j09XlaiC6wg0qDTXU2XLxbxwjk0l+8+3i61ijp6FItuyIQXHnqWZ07olMwhkZ/Y0nebYo0PTVmvsiJliwyHkumxXSrlxZG3kcFVUYVr8Dhze59zacVV5h78FRK82PloFqFgves9xOweRnnpKJjviLM966J1WWXNcZ8VH/nWffBA/74zT2ZPxcPFo/DCCEEdqWzLOFQaixJJESeRXlzDuzQHnRUaiBSbQHObZZokp3Xbo0HL9cBJ1ZWrMbm7/FVF7yihAbYX3ZLisDunYZ9pJ6eNj3Fke3KaGdcUqzEFkXYx5NkcSt6RU33PCixMDFmUAkJpMJjYvzIZFNOORBMdwGAwr9K1Cx8d3hou4+mJaVHJS6IHhCuVgRmxVAtvN6hTdtmijnVFR/a97r+m/oXrW5jxBJtd5whCRsgU8X18ZN9Kh54IKWX9QCZapMjgzWFZtBx0mTNAMmAdc8GAHK4VWUX+/sCQp7CiYezavhfaNK7LMYWzl2gRMtHQdh81ocAtWwv1zgjQ16C8dSZcqY3xY75QYSD2jtQy8xHu5PdKcbZrFaQe/XPGxldS7zoDts6inwGHxlaWx84R9+9AYW5TidNcd/7R71h7rJFrXWkXp9/Gayp3RP+iau/03Ctr+V6KUWOh2hgAVH62ki8qaLk35dwboqWvP6zR7twrewVcqYAFbITrCAv/ErFtK6DQ4PeMVb8UIO6kd3kaVhFwH0uCG4rMS92xZ1EsTnkV4Tw1e8BQ5OauAZppc8Lt8iqWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(6512007)(2906002)(26005)(6506007)(66446008)(4744005)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(54906003)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lQOPctBSGRGCOhAHMK+nvrMaoX/sODLubuN5s9F3ZoF1UH4TlDCGkezCEA?=
 =?iso-8859-1?Q?o3Rom+vZ+/GDUZ0nwVMz0RKOmbbyWUkPep3ORBOnCznot68REvL3O2Y+Mo?=
 =?iso-8859-1?Q?fX4x7YtfIoBLA1j00pBdYPsBnZF1hNJOLHLHkwwC3EowiZHJ6bWsDFqA2Q?=
 =?iso-8859-1?Q?3Pf2gOBT+Tr20+JUbwFIujVAX9CYwmI0z5g9NpqEAtmcW3D7YRgA9AInRl?=
 =?iso-8859-1?Q?WlB7UBkIxBnKzmSvN3wF/Cob/jI/TlVQYiYFtmHghZ4Sy42STFjwxZCZaM?=
 =?iso-8859-1?Q?0i67GRMoYgf4gnSTTPaQ+nPCafgbCKcOtCUQ1zvKoJUmj5rPps8+vuj6K9?=
 =?iso-8859-1?Q?z+rdFz4hef5xKjTbxnMOUM9KnUKoUgbcBDznUVnyrUFKp9MVR1x4gBFNXf?=
 =?iso-8859-1?Q?GXQijewkmt+dgppRPw8fG/NpL4StZUgFyd4cGMQZvG75fxma4C3UXgu3Wf?=
 =?iso-8859-1?Q?fMSZut+CFe8khn/89iQEeSDyYWjhiKpLU3w4OrB15obbLjGYB1DNI4hWMp?=
 =?iso-8859-1?Q?HdRp2TbCY+2CPCyAAWvh0WYnDLmFW3OsRa/rt4RbAQOCZ13AHrMLLtPjza?=
 =?iso-8859-1?Q?cxhVudnpOEG84nIjL2cx5FBthlxhGmt59xcYcC8Wc84UNBMhNJ+bxOVLXt?=
 =?iso-8859-1?Q?ydYB00DJLSUs//CvUwj0buU3a3qIAqqdrn+iq36M8jF1Ya1NZnSMZ6ah3H?=
 =?iso-8859-1?Q?h6nkg1fnp6vxfr9mdB5Zu2RG1MUVOQaxudWECVHPDW0q+zfqQy3yWrOwc1?=
 =?iso-8859-1?Q?eEP1z//Pufaad+VSeGtQlH0l7lwdlNhQAmtN5X4Gw9FolfhGp7EBrl+eiy?=
 =?iso-8859-1?Q?AT7JuSX6ROmXdSdkhI3NVZAgso79v3W93Q8MIXz3p1nPVL2Cpdcn1bvxbU?=
 =?iso-8859-1?Q?87GbjXow8lP7ZkTWw+NlRDzuXh0UeI4e4lWJ+Tdm3c5InLWPcrUpRp5pGy?=
 =?iso-8859-1?Q?ds6qWC5FkPYeXAwNL/12Wyi0oEMwlKXT+P5k27714w8oVCGd8wW3Yj4kUX?=
 =?iso-8859-1?Q?VYfnBLDT/9LvcYSmEXf+aaCBeXHJKLykWUckoShFDkmVNqAOaE7lh8wNaX?=
 =?iso-8859-1?Q?ocaPM6hO1t7pqyKRlCXrcoB8tzsoC5P70UBf9Xy6++6EH8seD9qf+DT4QI?=
 =?iso-8859-1?Q?NfYu2TJBvQ+aJnA428kmuZ7XVcyMuO35cJ6FKK73C4kF+WOcMTgr9R3hFa?=
 =?iso-8859-1?Q?stAVhFkJIHJo0sLQ7vlBntN9aNY59nSAKUFANz5mvP58C1+gFc9VwnwUPu?=
 =?iso-8859-1?Q?7VvdiLATa/sidaEzIFUpOCDKT8nsLNQxRRfT0W9d7mubNhsIYwdBf5YQaH?=
 =?iso-8859-1?Q?pCmm8iSfczzxCKoZGJtjsAQYTDh4eE50l2m/Lwmi0HAokjmhDZ5vaYJQg4?=
 =?iso-8859-1?Q?LXAxyfZqLKpJqGfAiBWKvc5HmgyPtb2M2k3zy8gn4lU2B8Ifs4qxqAK9Ls?=
 =?iso-8859-1?Q?8yUftJV3rnpeIR6oLACpPhBjwngKjA2jM8uvecqSN0u7dDlfsmJIFRRS+t?=
 =?iso-8859-1?Q?zKPNuEsqwc+lgj8TSZezgpoa1jCT3OtEYa1O0FyGjUm3XG5MYjlDmftZDs?=
 =?iso-8859-1?Q?xWzbTkZPHWLXbhbwun7VYlGkMoZHu57KWic/cvA2ofNkb6m6tNYEpHU1WA?=
 =?iso-8859-1?Q?luWPESZ41J3PB+BKstsG3Of+FiSDvhGFR3JbEjmBwDHaww71HsCHWxKQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab812403-054f-4bb9-92ef-08da9040d5d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:49.5223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QDN01K/2uR/oRBcgVDC4zOiG+1laFqISYguESTbL+Urmus0fl737DCzmTsfwB7v6j+CtV9vqz4Y4vhxlfiPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: nV21nMvvNLC6y0ALZHhMaoTfbV9SIolW
X-Proofpoint-ORIG-GUID: nV21nMvvNLC6y0ALZHhMaoTfbV9SIolW
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

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value since privcmd_ioctl_mmap() will exit
the loop if vm_start !=3D msg->va.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 3369734108af..ad17166b0ef6 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.35.1
