Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C93553BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354692AbiFUUs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354391AbiFUUrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EF32E9F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ5hUU018658;
        Tue, 21 Jun 2022 20:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E9PH8ugndb1t1Apmn7jcXIng+5uduvnditYhWOvhSqs=;
 b=e7g407DmsF/e3VdORhJ8Xvv4HY5upYHoo33YyX9c9lv6ZT5evz5QtXbr/bP0iIfWfory
 DGHek28VmSp1vgL2kE4egOQpsFT0Fnf5S10hCT+bJ+Pjqch/GdsHU8c1UXqsg8vOrquA
 s9CpxiqyZYQ0gspcea6CJ4zHu+Eb4s4JcUoVTRhLijJHPtCa6tmlyt8jF0SX0Z4dRow/
 NXLveE5SB3Lx4F+eZDAHHmJw28Ak6124pPU4GXnd1P+Fkbk5klaO3wGbYAkb7QVnjb+Q
 KPetFRCpJGmqECD5yjAn646ZTEeo4+xuKDDrEvWF2GxSnXFaw4t7bkaLZcauO3eY5Zvq qA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhW027847;
        Tue, 21 Jun 2022 20:47:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp0s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUPmI46X0cZmxk4ToGu5yhWcza5x9La3lKIyW+ZK6Fu7wZXFsfzlf3E6xlKGQNq5OqLo4UkoL4FHvWhEMqMatPdm4dXAIdRyUbuoHnfSXiLRfLBcemjH8l36R+miH570ujzBF7Q7OZmOFnk3DMhfhQFrU9VLqkRMwXS567gJdn/uGQh/zKsPkSiTNnNmKnt5Yq85262TJ8wyRks6q6tQQnQ4L4Y3je33nz5sy2O0kZgL02/UN1fPIYTk/EKMVhVU0l9VuW0HYJ7rXXVsZXNMZnN4Ie7MNdMSIiKaWbRS8LF6qgAiwrv7f8M4Pm/I6soZxsX4OmHZ35CYQkHonrML0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9PH8ugndb1t1Apmn7jcXIng+5uduvnditYhWOvhSqs=;
 b=WQgG/85k3H97u8P3vYBYExRpgL2FaZdU7EtuZWt7JGbn5GjuVWDsF/X7YRvsklw8AE8tGoGggDYiCcnVngItSdvTFA1Y/DXE9aA89yDXyKZRCGQfVDET7HYW32DbIfwXYu8hF9mz87ES7l4Uw2/qUEs7C1J0SLRQuRYFyOLmHsYJg21f99vV0/Z7vBahfgU4MErurP4aA7zTOkwaMh7NK7SDg1WiFTu+bs6hL3dPnufPvBHD6a4HsbSm9TxcvxXdOM908Iw9K9ZsQUj8jOsT6DzSa83nS1myUf4VUuiv5ERE4joP3g6qVtZ2F+LrKfiFYIQH1DJjDBlu9NEqbl+j3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9PH8ugndb1t1Apmn7jcXIng+5uduvnditYhWOvhSqs=;
 b=j6Jh4+kWBCt2BHqbQWxiC0ySRODVqlgT2bUszw0KQydrNGaTBY+hXDUZPuIrynVQYzkvWEVNcOsu5AH58ovsqXCNfOKZp9dLHR+YUrd1zDIdkGnFeWAOOmybgSnsbAmWRezdm1liG9OU+Er1w4SVpxdkBANmA5xSlN3W9MpXZaY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 13/69] mm/mmap: use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v10 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYhbALqTBpFGf5+k+LdWHoM0UZLQ==
Date:   Tue, 21 Jun 2022 20:46:55 +0000
Message-ID: <20220621204632.3370049-14-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c478e2aa-02c7-4918-4b91-08da53c731ea
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB3085E5CFC650BF240FB8CCBCFDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJMY1aU8BPY/m1kipDYVJvNFsO0d1M/QRpPnvsDwlMazGN6VJ5NxIhCF4J1zq17Yak0FFie3ok3/uFTKIfnRzkawbyiBIySog4PeV0NAwuP877i6E6idlJA67pAJVDIjo8+GhtIeUO6PpCCNhWePC3IG7U6Kqh5dIu8uXJKyEH88GRyV4aspdh9wJd9D38qJ8sse0Q3N19To+kzcHU/Gk85nGrP8G08bvWYqyrQ3nGfzVBSHvkTMjiGGZeZrLGWZBnHoWvpiphLzVjrS4To4XHkhvv6yQkVAv+sxAq40G5nhwsC1Qzsq2+JJ8pvcaKmleuu+J8D1E4dazvflKHd9goFABiLTKJ8bWZ7xOws4wpUS0ijSsPm+oduTOCHLS2QaReNBEI7zCcSEc9bYKP4Z10ssp1oot3snbmEZMK92xEkZxdGPVeb/7hlzLPfVgm6SzZm+6YSCQE2ElNUuJ5k17rZL0n17PM4YPZ2b0l+4qqGlJnuh5OZEcCGVW3Tch3CiS3uaKCYIVCXWs7PCbzUi9EBLaiG4RJ97tiLBcJzNEVpjjy/z2gZXNwBOj3+R+WV0IZ+qwNtKbDrquCfbzwvlhmGJ6mX3t1Yk6wZFOycbJYtGZ4ZWnZFAcC7JUeLDXhp+cpaO5Fb8oIMHuNAYaYFqNhZPhAbNtYDZp6ta1nNNRHj51WkSirUNKSQTSJgk0nJFcMLBXaDQP0ckHIZ1qz3Ak592vwSdsz01PY8ZvWTg3xVaAujKFmaSwdj/t8PuMYrrXs3N7uGlxQ4VDWTryF+pNV5tGcmJuAcw7qPqmmEe3TY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7pfreh3zYSH+2AzWRT3RSBZC3s4d8miDjb45gIJ3I+UiR/qm9xY3XO0xeu?=
 =?iso-8859-1?Q?vnMmbpLIH7SDQzkBSPVabP6Bj8IOc7XT5zOMiuOGtwQVLhCBtFaM58AgUF?=
 =?iso-8859-1?Q?pKiJieTBWFPLovyKujEUdXSOkWMrOIKMT2Oss8RYTDBKwAvgD2RmL/LuZn?=
 =?iso-8859-1?Q?/LBA86+wJgKvbO8/0fXBGNy3eJbDWr6FlfxB5jLSuuhr4H2Z3dahicPF94?=
 =?iso-8859-1?Q?C5j6sPJP6ZEdtXoLHFPNPDkKeezqOCYWj9A64rKK327Uve/MFH79MBMzsy?=
 =?iso-8859-1?Q?K8olSu2Fn0WIGBWVwHb7ZJG2aECz8Gai9GBSbMvLK6cyF/HLq35pH8Anaq?=
 =?iso-8859-1?Q?QDFzLt6BhT2oeShbNNwrRtNa3BbFPvnYxhwlC7M07G0cCsl+LRPhcqbYx5?=
 =?iso-8859-1?Q?F1gdDdHiyyrpRE3sG4kCqQYelQ4OS6GKn49ArvrNXa97WVCymY3HN2A/5/?=
 =?iso-8859-1?Q?V65jNMB7WDlmjG1qEp9TbYeyjO6XuDZK16ju+/YIzXrAcokv1sTJRNWgb3?=
 =?iso-8859-1?Q?I7U81id1Fbk9fZ64IJEClx/aQPxusBcd8kZaWFBAQrTp8rquySpYLf/Z9f?=
 =?iso-8859-1?Q?OwBdRpg9ptYfiIexyOdmrRZSf0N4cjl8l4rvboLlv5Q218Qi2VzHzjtMOj?=
 =?iso-8859-1?Q?RmJcqRq4Bd+mE15iVP8WJFcGY8yOyBGtVnhv6+tReyw3R/kWwOg0RMkN8Y?=
 =?iso-8859-1?Q?3Pqp4H1qlettyMnEBCwZgSZ5unAHTRNl8oqnDET7t1v4N+yoeHTsGJROS7?=
 =?iso-8859-1?Q?Ha9qEs5FD0cCXL2xxC1u6rFCVXeJo6lKlFY4NDnKBeO55h8CCW8RkRZcu4?=
 =?iso-8859-1?Q?fLTZN5DmOCCspEnCn6LKLEvF1wFSs0Ss5L7RAxF5ul0tZy5WHfyaPTwKPr?=
 =?iso-8859-1?Q?HgwUa4o0iKnPIJBMLWpEYJ/YOgv39/1KEeG8PLJp0GcnDmIyJR4V/dKj+W?=
 =?iso-8859-1?Q?Vahly9E8SstTTQ1Gwm70YaVs9m40PKzJjgC+KvkEE9ScCSJhp5rFg41EVr?=
 =?iso-8859-1?Q?8reDHf392xmA1ZOuWJ1Ba6lDYj9MZfSPWf9DrCF3ZRQnJH0mYmaybg4Eq9?=
 =?iso-8859-1?Q?05bXOAcG0/LnHt05z907yf9aEYGaH/GVGDEClnYLzlymH3glN7jVtTGti9?=
 =?iso-8859-1?Q?Rg1QZbc0HlpZqz90kf6POYZZMz8nKmdiTsEGFIhl8AsDxo7x4jp2vXlTfY?=
 =?iso-8859-1?Q?IIrbfljxGVtK3Cgkwtoi+nTXhWMtAyshAvJC7ZrHQ0mN+ZXmeXUXugnlEn?=
 =?iso-8859-1?Q?WCSIuUCVguw44PYc5r+DMKwT6+FLjkJJoLuTV2I6SsJSn/NsV+PY9Xryp7?=
 =?iso-8859-1?Q?kvm+jAhQdYzqsEzqPfdiV8mW51t3ouVZNJ/ES9lkVw1eeb9njR+ARTW3qn?=
 =?iso-8859-1?Q?lcI/ixKk6Pe/aMfWBfvx/jutPFFuyucq3lCpmjFfNoZgUBlytEsHRtJRds?=
 =?iso-8859-1?Q?DaaxZnZbKzYITnBi4aEzspWQ+uOP92nMpG6G1qp6A+3da9i3zQlXS3qFEB?=
 =?iso-8859-1?Q?GY0CwzMCFlwuoPJm+JyhXc/XYzPFFSil6rK2Ast0ekvHcfVfcEuZxzdKn4?=
 =?iso-8859-1?Q?6EbrS+lyRSC7zE/gzE0kIqSzyQFypjMx3z0A5kQWIQTHUn7W4PUWyWZ1Hh?=
 =?iso-8859-1?Q?wQ6FrmcpiIdeHTTTWFBoTMETJbwEYBTddDXP/YMnpUS3kVCbHwwrLwgVJZ?=
 =?iso-8859-1?Q?EWiilH5d7QajtM4XZ/V6pFS4mjrc4jHkxPov8PQNT5/7IdR/8jDHm6Yrtz?=
 =?iso-8859-1?Q?+fOoECGhoeNDxV3/0Cyn6q+SUIGlbA+dd2Z/91zsbKRKpwoSEE0yGxkrbW?=
 =?iso-8859-1?Q?EMNXPa7DHODXqJfNLt7fuePHVs73dWM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c478e2aa-02c7-4918-4b91-08da53c731ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:55.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fZA3d49yH/DwXs4p5+hCY6+1sSSxhrH0MHWCH6Y5jA4Aqd4LXZkd9Pm0Qwjld9ooRHqcsg3Kgk9SA5k9dtVDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: 1ZU1yVo16d8i6hj5BmaHR_35gKXZ7OF7
X-Proofpoint-GUID: 1ZU1yVo16d8i6hj5BmaHR_35gKXZ7OF7
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

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code.

Add kernel documentation comment for these functions.

Link: https://lkml.kernel.org/r/20220504010716.661115-15-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 253 +++++++-----------------------------------------------
 1 file changed, 32 insertions(+), 221 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 08845a0317bf..b91d22329418 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2053,250 +2053,61 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-			   length);
-	gap =3D mas.index;
-	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
 		return -ENOMEM;
=20
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+	return gap;
 }
=20
+/* unmapped_area_topdown() Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from * @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	gap =3D mas.last + 1 - info->length;
-	gap -=3D (gap - info->align_offset) & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length))
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
=20
-			while (dv) {
-				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.35.1
