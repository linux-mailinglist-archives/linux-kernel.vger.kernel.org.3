Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260525AF514
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiIFTzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiIFTwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAAB861F5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Icnpx010465;
        Tue, 6 Sep 2022 19:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nLZ3xMzQHr59ccxknbMYzX58SjTeajxRSJ3ZUX9X0eA=;
 b=JBcf6lNU3v8JQdRWNrWAR1unmM6dNI0K3zjwriuXgD4LHmQXcVcrbgJxIhBnrPaeiMYk
 Qk3O4BeQnUY4lkOwgV4PIuqUr7Vj0Uu+9OXqy0vU5hUaztCWOazEzqpbn5z0xh2L/YmE
 84K2esFfmuxFBKNqikTvQ3iXqj29YEo00bT+JHyhBoCStbURGWTgJdt8dc7tinCV+ufr
 jQwBjy4vAmypwv+CWCu2pKVaYHAJw86blopS78CPWt4nEdrxABb61w6rOSa3ZHGsJRlE
 Ec/n0EzauaApPisUjwNBhvbH6rKjW75Qw34UfcCTkkncY4HzeolqdimdeMVSN4N8zlh5 tA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhspxe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H893a031227;
        Tue, 6 Sep 2022 19:50:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ajqe-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkhXlNAZvyAqXh+pk4EQ92of32wTsublMCRKPuYSqX9LzbtfPMBU6ZcnoonG3kwcFkLj+Mtoru2i0urAZrIQs1qHFB8aiTiTbXvHQ0wyim4pPlwa5F3JzM+iSWogdrIT/iH6z2O+86VC1fecmYpEPPPf4W1bs8wTkESY+zfloPvsyPIPorCY/PoYBNI1iAWUTwAn7WXwrsUNMepTouT3a1KG17W9tg8RjACMCYVW+6jQ6O8LGNgSkN4i4CXRqYp4A7UUiFWQRDT9qcD+G6L9CXGgyxGV/+V1k+a3sRnGU3wseLO2pcK5EudZVXZ5gvifEqAMiz451XImKCPSgla6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLZ3xMzQHr59ccxknbMYzX58SjTeajxRSJ3ZUX9X0eA=;
 b=YdW/f570rTsu42FS8Du5tgdIEp6cEi7SpxsjVW/SQ3wlF4h+d5XahO3ewjvJC5VjrbePpIfJU6o9mTrLHOwSVWMKwWF/44Ytqq4h3fua5LADTavtIqGDgwlH8UgMB9SmTRdBqlAQkTcOJ2nfTPEk5g6mahEKU1U0LeZQTb7I3oCKX6IPuxSF3YnlaL7s88/dXVsNWPAZB+Lwo6ZeRWgdLxbYMKYeajPoFZ5s3KAI/ccyS85NJD+s/+yuvS9NRtTBq7M2Vd0SVRrJgBsmZYUN16qlbVkRekI5l1uT6XG9jcTiUGToDv8PivQFL5mw3OJ6X3olYhS9ybxHQxgjBV935Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLZ3xMzQHr59ccxknbMYzX58SjTeajxRSJ3ZUX9X0eA=;
 b=T8DiXrjQkl4pUhTDvrxLzMIXva1ckzsEdYFQFgqKUBYrAwrMWjYg1ce2ltlu3Ak1mjdX9OTWCHdIahceJn7ZS62CrPtWwRJQFbJayhAI0aHNA2nIYTijUVR+Yexbmr7RTnZRN+RDVyBaKOgflP9F7Nkivi3BRAOxprYvX/AbSts=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:50:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:50:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>, Yu Zhao <yuzhao@google.com>
Subject: [PATCH v14 67/70] mm/vmscan: Use vma iterator instead of vm_next
Thread-Topic: [PATCH v14 67/70] mm/vmscan: Use vma iterator instead of vm_next
Thread-Index: AQHYwim41qFX4NT4hEKplpVufplZ2A==
Date:   Tue, 6 Sep 2022 19:49:05 +0000
Message-ID: <20220906194824.2110408-68-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdd895f2-6b0d-4f6e-743a-08da90410a96
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTqYiNlnrue3YfBYYKDrpwHQD2qPyf94KdsOteMlAdJQpuWIgBY0IdG1pPuXfYP/LQJ9ieEZ390754u1++BQKEUWlDUFQpN2eUKjJgxYbCTu7Q+UNdvOFiK9DwUcPmMFpDcP0aCLi5iALo1CYqVRYUCLrcLgRl1tY6bhaJth6TRYM3c1FpFqNB/1zfvsRJkTz+Jfe5Yrflg+/eNjvxp5IRtnkYpB1A1aWmCpCN+9uFuBYNGhXO5yPQP/DKnsKsyzpD4Ni7RSR2koh14jcH21p5gMLjmqp+xFsuwp6r1M+vmixcz0tUqjSts2nfEhfNTVwdvmP1wEkDbkXE7nE7IZ8tyrQ5FmP5HXTzexqs6tyl5HyhIMBV+Epj6fTGWaFtM7eNPDHtbIZsS7zWe7ac3AY9GOYw4hojiQMRcq7C4CRpQ2+f1q8rPy5j/JpcKPmtzDA72xKw1Toxew51x7y7KDCC4iy9rQ+x3pTp0iPuguQ24V7mfZBlKVWnCsPAuXVg0+QcdCWFEX6Jvy4qvevCugfmR3ClyQbhK0JwSzuGuYln1Suv8LCMBXDYNIBLhGxThpGJSWzFfk71wgh/o5TGFAkV1UII7aRVWMRET5umzafeXSUAiRtVLDzk/xuu0l5UpwscmTstd0XnzmuqwE1tQT8B+KEVplVHdLEPEZ4ewFRdqyf1OJ2A1NEsAVNL7WMrefPLkjhMGS7UseWqxH8p0BKYzO8XkVQm6Ou5tdpKhxibU8/FCAqjv67lNu+cumgl51CLBXWhaV6lpUJmFjlrAeSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N1PNTIz8jmNMneehaFYp6n1SyWaOIl3Z918KT7LFt7vB8NaX+8A1GiSfYH?=
 =?iso-8859-1?Q?yQNHw47WrKtJmM2WC9hcGbwW4dnbmAMgomnMzUWbQDFn5a8kwi73WVXNBa?=
 =?iso-8859-1?Q?9i+Jey6YBnDHMCHArTCBYwDkzc4oghIQnkk8u4148dFqEKcxKv3VOJbChM?=
 =?iso-8859-1?Q?LOu08pmXmN/T/e7Nx2qZ/eLTl8KNf6cNeRgKQFDXuPHKbKm1GoXJnGXWmT?=
 =?iso-8859-1?Q?a2pidmX5gK1+TlazCjzDHwZz2i7nTfCBLGQ35DaOscQN44H5qZ9XskGtkJ?=
 =?iso-8859-1?Q?ls4o3nV99FTW1bdmO819Y3PSGTjgE9iqYiAtKFQK7tUzM700nySngcZZ3p?=
 =?iso-8859-1?Q?qErUTgEKiXYwZG6MCE+yXSm+JCPy06/tTBsBi22AEiJ1Z7Vj8hz1e+M+Yt?=
 =?iso-8859-1?Q?8itgy5noGEeLXX5Yi8Em0e2OyCOWw7vpnDRGBvi8unC295IZ8j9rNavWnr?=
 =?iso-8859-1?Q?c8Op5eVqP9vPPjkPtzcOUhu9pZk8r+GsVwSKSBlu72IJX4d+kngm+fifX8?=
 =?iso-8859-1?Q?qLSvk/gn09lStzgk3PGPUxkrBks6y9oUjKswGWj7UOWBk/EFWaUFIYmoIX?=
 =?iso-8859-1?Q?AM2E5hvXR0GLALJN0gzG/Od2MX/Lht7aBti/SjDmsIfipsuLg2sbIfQw81?=
 =?iso-8859-1?Q?cALATYS8Y9k83aPf0r9MbEnHNBvBGiTJelgCygGVnXDNHvAxkfzlgho7Ts?=
 =?iso-8859-1?Q?6zj0zr/juVTRm6g/Wsgx56S62jWwpsrhABiMezLidg7pPMbyL8qX2K+/DI?=
 =?iso-8859-1?Q?VuOKiuwcV9TQ3m/fBT4SJ51z1mIhGTNYSdpV6AZZ+qPtiqxL0z7bmgyck5?=
 =?iso-8859-1?Q?SZkY60W5maiEoKiUJD8glqbeS6an7kSl7LBF4JZs7V60hC0TiZKsM65Far?=
 =?iso-8859-1?Q?SHz5TeMqAKqrz+dDJRn06AZWRGYkFuG1n/TKhFZwyo4man+pjVRrsSdwAK?=
 =?iso-8859-1?Q?arhKpO5Dh78Tio4UL79BNVquZlv8Lk5Oo2fP95dyWJCsb4cek8nVzyjU0T?=
 =?iso-8859-1?Q?DyWz1i3eSF1or3GSXdOu/nXqVJZ+Qz/iXFesq2hHD59OQ/Fr+7WUmD2i4g?=
 =?iso-8859-1?Q?oYVLqZZRCW86ECaRi5Ja2Qu3dJMAImcnyCRdbwwGZdqf5/iBBA2d0onFkD?=
 =?iso-8859-1?Q?KUc4haWrXv9AdORNTWRsUEblUczJUDI7AIIiTJyLzv0iafLwzxDdTEpAmd?=
 =?iso-8859-1?Q?OEW1ms8eISIsUsNwc66oZDYWeuNeXCgZhv/DL5J8NwrPpq6NbRagkVzOLn?=
 =?iso-8859-1?Q?mMVTxQSzKBKMQLz6IKS6ONYLf8XUnHf0hJqxoVpEjHl+sRKtOA1M3+LseY?=
 =?iso-8859-1?Q?i/eM9uZYRy6+9o0JxkpWrxrNYlh5VxJ0bEKkPsYg/X0vdk16e24HsjLItm?=
 =?iso-8859-1?Q?trqrLUmOIZdVzBaxoC9b6ePDAEvNxGwnnKHsm/Qdjv8I6zRulCxVTxo22N?=
 =?iso-8859-1?Q?ZNBFt8xj7EdwXaTuBhJEBge4bFaCiI9VediP+7PlTJv2JG4TUxzjQ5kSGu?=
 =?iso-8859-1?Q?d7UENwACTODSMy4cIlm/YsRK1Lu7bMDO0djtEb7pOhP5Eq0vG3u1NQAELn?=
 =?iso-8859-1?Q?bGUpkqOlao1iakYvLAoqNfg+LCFR4vc7jUgEaSrHd4hJmxoo2EffLNLH3F?=
 =?iso-8859-1?Q?zMNx28E/YL3oNg/EYoPCictlZE1ZGZfWKLvLykr4hPgWU1AcroPx6kmA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd895f2-6b0d-4f6e-743a-08da90410a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:05.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSz6drjQfUAVCug8QC4imBH5JahiQLy/CpdOPsm4i4cUTSBLuhzqNqv43JqtBKIZ8u3CA2QiDDNcknNwZ14TvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: gRj83YDVLxnljyXvAsQ8ioUcZdHMRnMd
X-Proofpoint-ORIG-GUID: gRj83YDVLxnljyXvAsQ8ioUcZdHMRnMd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the vma iterator in in get_next_vma() instead of the linked list.

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/vmscan.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 340b8a624f57..bb3256d07a43 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3776,23 +3776,14 @@ static bool get_next_vma(unsigned long mask, unsign=
ed long size, struct mm_walk
 {
 	unsigned long start =3D round_up(*vm_end, size);
 	unsigned long end =3D (start | ~mask) + 1;
+	VMA_ITERATOR(vmi, args->mm, start);
=20
 	VM_WARN_ON_ONCE(mask & size);
 	VM_WARN_ON_ONCE((start & mask) !=3D (*vm_start & mask));
=20
-	while (args->vma) {
-		if (start >=3D args->vma->vm_end) {
-			args->vma =3D args->vma->vm_next;
+	for_each_vma_range(vmi, args->vma, end) {
+		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
 			continue;
-		}
-
-		if (end && end <=3D args->vma->vm_start)
-			return false;
-
-		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
-			args->vma =3D args->vma->vm_next;
-			continue;
-		}
=20
 		*vm_start =3D max(start, args->vma->vm_start);
 		*vm_end =3D min(end - 1, args->vma->vm_end - 1) + 1;
--=20
2.35.1
