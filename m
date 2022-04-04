Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283604F1723
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377924AbiDDOih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377761AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE973F31C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Do9YN012570;
        Mon, 4 Apr 2022 14:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J+jT96TKlCtmqeniZSwdR8sCXWf/tQzph0sg4wIUlIs=;
 b=Z33FVLu9l0PJyxmfBESMRnlBYpDhvTyCiNF84J0gfCqAoSR5n9FLqofmRsrF2BJ3A4jT
 4foV4/nuBeXFvOMVJWrqs92Cw+L/YYYtyM5OP6rbDoNEdV6krueh9fViNUalZ2b3UirH
 xcxeN6YMrGoQ6+iY5UlIYoGsp6iIhsiYyONstUnEF9fXfJOeyjTSVszWK27Jmg5VKbMo
 7jPHqH9kbMf0EWHCHQahxZgUdNpjh2Hrbfl26jC54771Iz8NaOF1qqFWPl3M7n/kywRv
 29Zg8HENMl14zUJHealK7MeovJsmEFykXNMH25aJ5OLC9Z0Vji7WkRJzIIm3QOTK/Fde fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaSW034390;
        Mon, 4 Apr 2022 14:35:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mh4q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgSrobi+pLn3e0Maj8sdoGmQwGTYttKs7xJqI2BJpAAdKaMULMVvf2MRbwvIVY9nuxAXpD+70yJai3o2/WIlT78kmYxoM09Y5QHZSOwPjWXlVYF3+eXw+ku0wGaqvQ99nY8iJezjuswWArTqAqaBvtRh3flraE2zOf6cXAM3hnCJDoNSmWP7J2y81bLY1iuGpCORLJTmjCbugTaLgD7MshaXj7iyFZakMJsAB0t8dO9RnCAXv75hXhmX8jKUeuM1YQLJ4Sg6VZTGWfjf+zEYYLc6oP80CWVZHHn9PpQnfMAukyV5nQd5YiK3X86wf6d3mP7KElfzKu7jmo35IvOK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+jT96TKlCtmqeniZSwdR8sCXWf/tQzph0sg4wIUlIs=;
 b=GLKD9ubUF/FCzkHqKEGk0lRGQIcduitaJWHwwIkxyovgGCL6zL2nPYsk7CsZSs0/7NsxuWK0sbHLjUMcb905ZlamAs3JAAueYH7fNSpzmaeXDkW2mhlgwM2isoGqZT4papHHMGp1M0Gl8WGYlDyIyKeWQYCHhgkBb6pYrhpV81R9HsDE/PukkpunzQDCQM49t0XI414R25tMA1Z1G9nN5W7+rD3FhR//CA3cKRnrIToIGga2cM3S6gTVwr7gwiG8Tc2TtUg2ucoaKm4F1x2MTW11qj4JFknaOnvdGfbVdQKvjR5/SA2Eu2nj1fXrMP9Q9pPpte5mQkajPF/t7rHuDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+jT96TKlCtmqeniZSwdR8sCXWf/tQzph0sg4wIUlIs=;
 b=uTEWQ37XUb1edvIleRz1TW/zaNkOyD+mjKlYlOJ5SjHHuRKdL3gFGufGfZ1l0WRLyqTPQcNAWSi1+EZLSf+uk4eD+t350Zpb0Py68YqZEkSOG/LVkIF/FqIHpxPWsQm4xJnseHZa9XpTq87ol+0Rh3pQJ7oaP3ktlRCGgvyQVRA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 11/70] arch/arm64: Remove the merge workaround for
 VMA_ITERATOR
Thread-Topic: [PATCH v7 11/70] arch/arm64: Remove the merge workaround for
 VMA_ITERATOR
Thread-Index: AQHYSDE/UzI7JBk3bkikM7bPEMSazw==
Date:   Mon, 4 Apr 2022 14:35:36 +0000
Message-ID: <20220404143501.2016403-12-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f5b23ce-28ea-4cd5-15ec-08da16486352
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812EEE104C363E04211F1E8FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHNxPkJYwBy2LZWua5OdngbbEpGmZoj5rw1jae0OsqHwKiNALi628t/tN/Zg/KpTMSGSnqHVvR6hgT/uOHdh+sXRgyl3iB5WuVgVZZ4QFGJgW3wBc9fCHHXnTCTXoH+WUAFlmOtjgpYLdB5w4gQQZ0YsQcrZMoq5Nzl3Hs4vOFQr9KNKlQdj9vw91VWQO8GfVf8UYKPd8rQiIjo5+Cr/FK0HNbTGFqTNU6SQpeky3hlrl2qIL4Ndb6VM/NnIcPDvJ5/hIgoH9FLYGR73WWabI7pPHAdUsa07pzSLbk62fp5baYQyZ9xd2NDYIKmv61E30DqsZ8dMrGqz5UFAf4zzvaev5yVxa9EXGHzFUqTKaTFQpTR+qYwFjzC5MZfzsl3+6ih+7dGFuNsBMdjnnvIcWkcInNYLcf2Kq51grtgprUn2VYPQMy5gx1GUui2hqw6+B7pcWDspNA1O9faGzCT6g4vvXhpyRtC/19UbY7sThNyyiO2o36Cn5BJkf7XYIRPCDxnveTnHCPcwisC70RiSdsbKUg42zWES8DjPXiAJwc7lXbwFDqn1hACVTXrOdDhbLCSxFxoCrDqUwO5KbW2yF67utCeQUCK+iBVIOewoFF58f4WCcHKGZD3kPStvTV9PQ6NIcocs1pR+tTrly+FNEseyeAmsMI+oC5rggmSiWz4F/Vb/9/4/j7yicAm8BXpDv/lxyFL/Fa6l6+oI0VX+KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(4744005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Kj4MmIY55Tf+6YA/sO4dgTFzBWARXMJqJLSmsz+bDje6OUKHk++gauP4/e?=
 =?iso-8859-1?Q?p7IGkzuZINQrv9VJAR+75KAr24N1QMZRGxrzhB64wFPfpKLSipkCT4GRR8?=
 =?iso-8859-1?Q?UjXWDNpuQEOaf2S0bF1c0KcO0Ej8rU8frMjayrWLG+fLnKpz0vQqHTP7YZ?=
 =?iso-8859-1?Q?yBxJJbpmrsVWqbHayK1pGxNEekNskA4mcbnJ2wMN0TYKrbbid01cMAJR5+?=
 =?iso-8859-1?Q?28GGM12X4UOKfRFmluJeHF56tW7xOCammZkB1yWOFwQ2Z9HlIYZ5WLgy58?=
 =?iso-8859-1?Q?keXLBl/cjTSQAIu/aX7mQ3OPNdQ3/eCFCS3+AK4xIQAWooZ0IIVH9ZQ72p?=
 =?iso-8859-1?Q?Op64mJDZl77Jw1ioCltMa31xRI7wSHXCbbg6cnv2e35MHTUe+37qNrrxG/?=
 =?iso-8859-1?Q?CxH9OIQncJS6VG4o827PqvpnQT4GnNbs+PLpLePh/ejz3EuUVtBVbS+OTM?=
 =?iso-8859-1?Q?2S8J2I3o+X/xnBn2fE73onjiZxH0+ShnOKod5YMVpv/mBDljt+iCtmQr/Q?=
 =?iso-8859-1?Q?nBKCHU/oSD7zj10GOUj4M/PxIZJpP5ZssnbvQBPvX+yO9CXTQBGNQUvr0i?=
 =?iso-8859-1?Q?glYV32qACA5nTCi651ckJQ307SpdoP2K7GV7TmcI3oAKrFwipLJB9K3brx?=
 =?iso-8859-1?Q?NsBJR+OoQvYB+EKNIvT46bV4/xjl+QvdLyuqw/beuMrnI6+KsLSxoj7wE6?=
 =?iso-8859-1?Q?8RUEw+CIbGBVKcV1alWGYvIOsxm0La0I/MKUF/QJaOS7XBoybGljsJu8PC?=
 =?iso-8859-1?Q?UgTAM4dfXnBWu9HYuJLFc/ltXGdWb7vnJfpIzfeCsUH4/Ujl1sX6kVugPp?=
 =?iso-8859-1?Q?66r81mtOFGJGKvJqsck1Z/0ZodQN5mZ0VgZOLW5pQJMSls+AQjUJX5eRma?=
 =?iso-8859-1?Q?UC1sbcFsKQ48878JhOzf/9y8cZz0PNraXLB1dtF8Myg0gyAGaTUn03+kZr?=
 =?iso-8859-1?Q?npTx1/lBisCibZ9J872Ipj2d89fbAgQBXOWh2+OjmDnJMEOyPyPZPRuIXm?=
 =?iso-8859-1?Q?gXwSWzrL3eASn3Tnkle4JwZd/inp7Wtj6UyFggxLQmopf+Kouh/cqR+hsZ?=
 =?iso-8859-1?Q?rnxA0PGTn10nmuGwg8OpfsnlPTVlQyPafgvXh/FPN+/HgbGaEMkFuOoNLw?=
 =?iso-8859-1?Q?l3I7tYmqVmIuCS0GQtczWUbI1n3DcwK9bFlU2BYdP5EN/bM7vt7F9t6ExP?=
 =?iso-8859-1?Q?D4oSDXPjGWOnBocvFbpolA372cPx7oBxYlN6iXec68dWKoNbDeeEfGRLzG?=
 =?iso-8859-1?Q?uNjpTsFW/tOoRVgyutpmn5PHCzwI1Tf6N537S83dJle7Gu1jwItHUD0ll5?=
 =?iso-8859-1?Q?9TYuugejLq019g/b5ryw4zyBV7TJY+eooMeRyVkznJBBMyTX0ijpvu927P?=
 =?iso-8859-1?Q?BQ+vkCP1lWZv8oy5tzoNBUl5u23yHlG9xGn4Mt7C+VkilhHFpbutIAZbwR?=
 =?iso-8859-1?Q?I5S+zpPLuGPEwllgBDQdrqe2++ZpOv/Vq90g1mkzxJ1VmEz4MviHrRz9pm?=
 =?iso-8859-1?Q?UnyhKgICV66S+Qw+i/IJ+3R4WZ7a6SHyxjsKxcjdVu9p6ryYesRaN7ae7I?=
 =?iso-8859-1?Q?AvCsUAKs/Kk5BgOV7yG0DqrSVhTKaEs5RDrnMVExeN1ukGkeNfKWzYYTzM?=
 =?iso-8859-1?Q?5z3uEDOz5f38xx9aU29T3PFP653cj7BLDi2P1YCj9VbIvC6Wr3W2f2Rtsj?=
 =?iso-8859-1?Q?9Javra1tni5ykSmEYnb5J60MGUplDii1ipfPL86ssb+7Vbu6qVDN5or47a?=
 =?iso-8859-1?Q?Z/z44815Nnf7voz+vFlVWJd9ZfloLB6HmFRLi1UycJRSnI1Ac7W9/4tN21?=
 =?iso-8859-1?Q?AqU5vIP7+8GNzrz9or5ZTxmJSmwgWis=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5b23ce-28ea-4cd5-15ec-08da16486352
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:36.9096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbpX4jdXtTpypzzD9l/hp+l19UD48qBoctqRbw/E33xb+lbFnNf9/E7c6Dkgw0r0/fhJTDp3xyUo+Wn18tKQlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: x46fPJZZUFsoYdd7Ug5M4F8pcgkj33o7
X-Proofpoint-GUID: x46fPJZZUFsoYdd7Ug5M4F8pcgkj33o7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the vma iterator is in the kernel, remove the workaround.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/arm64/kernel/elfcore.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 3ed39c61a510..930a0bc4cac4 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -8,13 +8,6 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
=20
-#ifndef VMA_ITERATOR
-#define VMA_ITERATOR(name, mm, addr)	\
-	struct mm_struct *name =3D mm
-#define for_each_vma(vmi, vma)		\
-	for (vma =3D vmi->mmap; vma; vma =3D vma->vm_next)
-#endif
-
 #define for_each_mte_vma(vmi, vma)					\
 	if (system_supports_mte())					\
 		for_each_vma(vmi, vma)					\
--=20
2.34.1
