Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60222510163
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352215AbiDZPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352080AbiDZPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEBE158F8A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT1N3015475;
        Tue, 26 Apr 2022 15:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uX4ZsfCGZj+gIvcVwqm3WvkSUlhnHyrP5tURnL9YYnw=;
 b=lOFJ038haFNIRfnIapsomzSLvK3b8QfbN0nWndyEGxyiW/ddpoRz3pCdlzj8PlpPoVbN
 diA3fxzy3B83I2H+vtRJlN2d2pE3FZPl4ycjc/Gluidtt+W1HDRtnTPxQt+EyrNclcgy
 KUSzyXScRsElWFyqZ5d5+SmhLh7CgpkOLMJ62DVARzSSD+JEelAwje2z6iHu4laiEGD/
 ibJ1SyUgbRt18RLHRt4wRIIbDiWDXHj0SqjTQ38FEYYeb8CyvPBOuYvZbauLHw6pgQCr
 vtCpb9XPowgwhY1/caXxBMYB2N9ydldJ7IJChYxu6ECA8WsR3cFgMXFt1HlzlInj32z+ uA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF554q019202;
        Tue, 26 Apr 2022 15:07:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3feud-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2TbEtFO8z9JF9AnkR5e5i4vjKpwKrWnOIZrDxOEGB+COE4cpqboLb05FZWC8hU/WHjew3bIWWVaHQhQhtI0TmSVqLP8BNlAjWoYH3ZOrT8GakULd2C+0F/4OoYbAGE3JND05sdYbxy2vYJRuog7zuIRA3mNQ/43OG6OnN7prUi+uu0zVo35MRaHf/8oz8ZBQDugopTFuZTEmE1ZYSbMUGT9i7lBHU8IgB7pVWYuJwvTDXF2UY3r2KZGZAYtLygSCW2qddWs8zFXGLkUD+2HvtgdDTjw9JyjOa9GtLsjLf4IPmgLHV7CdbLYGtcyWyyi1TSJvxQrYaij0GA6azLJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX4ZsfCGZj+gIvcVwqm3WvkSUlhnHyrP5tURnL9YYnw=;
 b=WwxYo7fh5/SPdLcCrGVr4ZG8Mb7foCFLWab652K+cS8vcnXUcyPoHs8201rpSyTJHV5h5xniPX0X4OIX9zvcE0TrDSdth+wJtgCJ5wag1qH3eC2e5lV1j8Ctnb1jo8Qe/oj4JdGAJAlTJGvqWASLFbi5/A1w0Wrnv/Viu6iR2WN5HacrWVcEOy2fjTzOQYgBJuISxJ8dUgwUFGoB7d+ob9iz7zwiCUxRD7jTkUpAHs4WhGioPMYdHq3qGSMuwbkPOZFsMF8wg0UbjTmEBssGSsj/VSLZRwai3TuCYCZID+brHM0D0+JE6csqDI6ON7e21c4pkvRgU4ZPC7P4UqxlRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX4ZsfCGZj+gIvcVwqm3WvkSUlhnHyrP5tURnL9YYnw=;
 b=b165rXC3LbxQ3dH7KCL8liNFhPwlfaqJmxSHVtrL6ryuNCsOtl3EG2o5Jy246S2vXvkgruDOzO1VvB9LaeCshnyRLrYlyHcOSeZDYuRU3OwW7Q5qDQcBaLtWo3U2REKJCMioIiDWJKWZ+gFqlvRTbFQQgNHaGoMOM+KLEl/T8Vo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 37/70] xtensa: remove vma linked list walks
Thread-Topic: [PATCH v8 37/70] xtensa: remove vma linked list walks
Thread-Index: AQHYWX88qjOGbQsrTUOLxbmgJcApUQ==
Date:   Tue, 26 Apr 2022 15:06:41 +0000
Message-ID: <20220426150616.3937571-38-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d6e9813-dafa-483f-9d8c-08da27967333
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929733162DC977201C9E86DFDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mv+OBab2F8QWhJmm0qFQwe5lwbPHlsLWV8dpUd5XEahw1Ldin2CIYZR0DFySMXK1kl85DBHWdqEaZee/4mxPXmoa4E6o64Ys7Y5NmV9xmtK5Yfom31OF+T7o6lYTozy3K3RA0b2G+iRHsAaaH9CQifxxTi6VvpXu/vzg5BJEu3oK4yTlbAoF0gfaI1KSmkUa85IQNNeeJbPe6VX88jGm8gsnOHFN4t3vcA9z+wLO977AdPh5CsC0ckNiSrJxkLf2HvUxdy+5IxmQCQTGe6+9EXULTZ7+QoulXijq5I2VHiR5gNAsb8K7hosG/NmyuHoLhrQuB/nSBngad9FRX40I5trzjQEGaOSdY/MGyBhVvIw+ZtTE60zStpYWBj71jRADHWVf+PPbF+KZbQEIJyTu05boHeUXnGn6U/yM0MY4LAjNySzDFCE3pYR4093cSU2mUExCVLOWS7dmMuGOMb1WzRoiP/mXXqHpWndLi+qp6H4O/q55GXLRKYd5esCy+MetS6B04ysGiviSKmhY/pxYCeNjRcdwzbktK3vmZeWe0jI6cngD7ObZDWo+5aEoIiMQBYLzL1rz/2qv0gcMgAUILORkZmrHz5dLJX9/CuK/9V7g/Ix2Cijo+WyO7VpSqO4J1WyTiSgtkJBM6UCdeDZCQ2u2GPEYwxZuPfnWj959xzHS+mwxwoXzyadWaBco2Zcb1FmIspJoiNIgieh91XyAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wH90MlxGVgKO1rZl2xYsG+JAxORpz6B38qArQICwAvkrh3VPm1XW00hyIk?=
 =?iso-8859-1?Q?LVflZ0fQX+niVGRJ7bY9ip1W3oJUFU6yyaOGx0zywLo3I9UDQE7A1tu7KK?=
 =?iso-8859-1?Q?1PTVL8ZW0piiDX4xiZRa974XocSaunl71ODOkUCOVRqi5RjGzK5p9/+aU3?=
 =?iso-8859-1?Q?YEbUksOMjP3/zW9dZ/cZaCsfTDvJgP8tVyUfpBZgm9ahHnWjpnfuwUESwW?=
 =?iso-8859-1?Q?QvDrC/7va1EKeMtF9gXVKioCGLi60TvHoKWHLWJ3x5uRF8aIBaX1ZDdi18?=
 =?iso-8859-1?Q?E8kJ9B4mHNqkHh2zKfU0cTPugUyy2Eq/RX/6EHvuW49QKkaU/k7JC7Ae7G?=
 =?iso-8859-1?Q?xaDY/teEjb8FO9NmH4/Zt4aXmTmlvegP/AYtlguNzKFV+ciB5E58eZUdDO?=
 =?iso-8859-1?Q?IRH+4ZvDLerm4EievyKqJpAz8POUw7vu37qwQQrq4wUzyemy8bGfWYNg9T?=
 =?iso-8859-1?Q?of6fn9pnRgQuWTpmyi4Xb+H6NQaFPO4zS/4yoSbo7egjeJQoLp0KRAc2ui?=
 =?iso-8859-1?Q?f39NSBE/fXpVmlaN3vzNOvzOio0gqBngvByZ+CuU96VFOfk+AnNptikBuw?=
 =?iso-8859-1?Q?J2NErXSHlRSGlO6BmofVbna8XrYuo6DB7M55LfAbUAX1KjHlHp9c/qaBTP?=
 =?iso-8859-1?Q?QOIyFEX3GihrxnCLYKIS/lh0D5APDzM0u2QjfqJne28tPBc1UKGQCLluZB?=
 =?iso-8859-1?Q?DaC57RYddv3oDIzZGEd4w6EWTbvMXzX0YW4BdOeIHeBlN9rmW0pPle2KnX?=
 =?iso-8859-1?Q?41IEeP8EyvuBSHyHHOGUdtk+dnWQFre0AiWX0lVjFBotoCom2msxp/ucP6?=
 =?iso-8859-1?Q?GsbB4Jx/yJO2JoZE1I+OosC4293KBotY8JtwP1fR+TxJ8jr1pi7Gm+SXUp?=
 =?iso-8859-1?Q?RLrx8q0fM445niimnbHNhqQJgqIREd/WiL4BAy7lmaPIU7fGtAWIghIR15?=
 =?iso-8859-1?Q?S6OiCRRsBdEy9gQ1e9iX0SoNCm+cdK3qOzdJX1InKbcXtVcTA0li/ugVTV?=
 =?iso-8859-1?Q?MLhWbLyZ0LfvWXaYB/slSjn43Dq0ydF2a89j0ymW6oaziDe/szl6ZBYqIe?=
 =?iso-8859-1?Q?CSKBX0LAjNDPN8/aLCWkcFJTW4MwDuobOsxMn+eO9Rf9Tuda37GieKZdvm?=
 =?iso-8859-1?Q?bAOMlzhtTIr8zsdOKy3rXjJB5geCxgsRHI5G7WQeF6r98mp9gwBE2jSkOO?=
 =?iso-8859-1?Q?ifIQ61+DJVY28kR4eHL6Mkf8y4GNxCvbPnVU6BbaHSKiUyCTiKt9xxKmmH?=
 =?iso-8859-1?Q?xSIbBHg7D6bAKbRkP2ZxLmVZyepSTcLB1fLc3ePzV9r1GDvQ2CmXmeMaaU?=
 =?iso-8859-1?Q?yI+kFZqmovO9iG6s8OBPKuN1VPW6m4UoWK8jPYSTWp39w7ufIReqL1vzF8?=
 =?iso-8859-1?Q?aKNMPDJlEx/asp2Pt4P86jvJYr6LJpUBuNC3PMojaQuseHfbNNd1G1PEbu?=
 =?iso-8859-1?Q?lF0zz+4zQ9xe5MjTpOGJoc6hY1uZvzrFlNiMxFjR8UsqFYqlIocNw9GXXV?=
 =?iso-8859-1?Q?3nscA84bKNQ4l0Qct1XuTRra5blsg/xmx+S+n0mU9DkLaSHf80CvPV3FXS?=
 =?iso-8859-1?Q?fa6AKwYcL0waFXBM2qEbzqfyba9rTaK/LXt5Jxt9GyHX98Hmy7IbDnIGYG?=
 =?iso-8859-1?Q?jao+eaNy/dzb0qcBKxhrbUnwnc1VRke7JS/k0a5mQbjJ52zS71ZQPaSkek?=
 =?iso-8859-1?Q?cfuXSgivVL4PYY+LgHux4iHuTaKo/A3aLjPkuyrzmkWCbFaOA2OXPPenZ5?=
 =?iso-8859-1?Q?s08xRvxZtFgofxOQGWwhBU15xRo9lMz6uBcUKciqW8iu8k8l229dkaqDyo?=
 =?iso-8859-1?Q?jyfHdu9PIJQCkTeqXCi1HGtB4RepbN0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6e9813-dafa-483f-9d8c-08da27967333
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:41.5834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95clm5xs+xxDSPYpAFWjVTMgmu8mf1D/DeKO/wMvvNRZxJ17Sj3CtgTL2DsDFZpXUI/jo4dZdW7VmNrqO4F//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: 2d63exJd2nfp3sDqvqnNkHIrEq_StWvu
X-Proofpoint-GUID: 2d63exJd2nfp3sDqvqnNkHIrEq_StWvu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.  Since VMA can no longer be NULL in the
loop, then deal with out-of-memory outside the loop.  This means a
slightly longer run time in the failure case (-ENOMEM) - it will run to
the end of the VMAs before erroring instead of in the middle of the loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/xtensa/kernel/syscall.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..b3c2450d6f23 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	struct vma_iterator vmi;
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,15 +80,20 @@ unsigned long arch_get_unmapped_area(struct file *filp,=
 unsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <=3D vm_start_gap(vmm))
-			return addr;
+	vma_iter_init(&vmi, current->mm, addr);
+	for_each_vma(vmi, vmm) {
+		/* At this point:  (addr < vmm->vm_end). */
+		if (addr + len <=3D vm_start_gap(vmm))
+			break;
+
 		addr =3D vmm->vm_end;
 		if (flags & MAP_SHARED)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
 	}
+
+	if (TASK_SIZE - len < addr)
+		return -ENOMEM;
+
+	return addr;
 }
 #endif
--=20
2.35.1
