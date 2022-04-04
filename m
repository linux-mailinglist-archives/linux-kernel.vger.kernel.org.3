Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68EF4F1719
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377629AbiDDOhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377571AbiDDOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463713F319
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dk3NP014690;
        Mon, 4 Apr 2022 14:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/c754KXiEPrdPETNdJXjcY9dkL6yEGwzOgJAAhVu6dM=;
 b=TEj2zno1UC0OLaKRcLPiZU3AnX9D2BPH5R4yFfT4YupEYlSNgMv3pw05Q/XH/ESNei9l
 0n8ERyGdVXJyiacFAeerpDFCeb6R9kRRf6X8U6qhwAvK6lYP1D/KHXoQ5YHGdxAEo3MG
 cSdjjLzY4RBjUOMy4VQAfePet3ePZq9QsUNa06D/8d2ydfmAS+s6HXNCx2W04xDKUrL8
 JcQpc7krgu+Ly7iCEeak47kilOhKzOAgTLTnFb2myKItl5mYAYruIqQQAFgLH33h5OQz
 Uc6Qsj4D9dWSIRveApr5gEG9a9d62WH1m3mzQyVkwCeTyE50lNVKUOHZsF8BlzqdNQj1 9g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGjlM012809;
        Mon, 4 Apr 2022 14:35:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2h2f1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQVWZrtTnGhbj5J89Z7Xq1vM0f2VsPjcayWgGRi7HgCSNhqVFAfROnDdEKWJTenBY7xeqhhPwXy6CJ4kRSnvlCDi1fML2IQFPwpcSUgXybo/2gNsD1meCLipJRYawGuPePsdxj0677g+aWlC/GLKeX6/ZGmr/EEPkIWHV4XmH872onI81IyQSq+2b+R5yUgXhxZGhw8R6vVfd7SokRgxwKEl0j5Y5NEHceYYxje/p1IpZG0NpWdBx4Q4cTJWz4O8lmmX0zx2Jevavqtjku/3CH8/6Kcd2FHn+RjgnWvrVqrUJ9wLWfVmBO7yRQWmQOf1u55KawRKfJbZMP3S8ukCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c754KXiEPrdPETNdJXjcY9dkL6yEGwzOgJAAhVu6dM=;
 b=mKrxlxfWo7g1bWKwKBR7yC2SqQS1mhnBI8isvYu1NOXxx9TmAh6SY92qx6gEaic0q/16A5UBMhejt+heDXDjj3gMlNxv6BBcXrczKDM1EzW+wBAaN9rYjFJTxX0oTVUKBvy1JpKyAbgvXkXXa0Uu/89NnxDA9ZqyMd7kJxM9dW/LlsmdawYHVQ+5FoWg0F3Cm7gteE+DVILcKENjlPuqIH6WNQLPgtg2phcdK2LSu4nLd3yPuCzRjyl7th8fWLvUX2o37s0GGlErFNh3jHseZNJNzul36X5lIpB3/AUjvzCNWCdf8Wt803XVAM6xswJhjjvzMP+UhAEZdxlNDb7eaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c754KXiEPrdPETNdJXjcY9dkL6yEGwzOgJAAhVu6dM=;
 b=v7eKNYaqzOdVpShBtXUb88u8zodHN+kxeyU2AKB2sYc61gwcrNNrAXkAs8y9lrk06wHuYlu4yI1tmT+hmAIeeOEcfhTF/5msAchG6e1yuA2/nd7S2q2DhpWVdzeOu9sfJIlXrpgt7hcyTA4ADGxc7+J8p5OazsTNkPjzk2/YxGk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3881.namprd10.prod.outlook.com (2603:10b6:5:1fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:35:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 01/70] radix tree test suite: Add pr_err define
Thread-Topic: [PATCH v7 01/70] radix tree test suite: Add pr_err define
Thread-Index: AQHYSDE6llUXTs4woUihXI9zr2YMlA==
Date:   Mon, 4 Apr 2022 14:35:27 +0000
Message-ID: <20220404143501.2016403-2-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 722f412c-5716-4339-bb7a-08da16485cc3
x-ms-traffictypediagnostic: DM6PR10MB3881:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3881EC71E0B9426EBD987B53FDE59@DM6PR10MB3881.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wnwt/Ec+o1QP3T442saNbeCQ4sGc07WIYlH170qHYZH6suZnNrgvyWk1tdDjw/rkTswBu+55QnJBJPVSpv1Dciv/PZTpO1pAqyL+r8si4dVtFuMnsTHk7oXciR9paOt5AJXA2EwNyOVa2Lrz9VkW3TjY3gWKZLE1vnit9Xfq6v0a66+Hk8vwwXEMn+lN6m3tKCZ8eBGqCdpBo7dRekw+phOUOndFtPWa/vYEnD8GDWy9dJ/8aiCFcN6KsEq32BviFYqhJUwxFZg9RYNvgepFZLzlqHcAoME5KLp2+iiwlEY0Yn96PlYIRw706+EK+QUzPbwQvbpUBPmTr5ckoZSR1GJycWlTO5a8qvin/0o7wjyNDoZVfjcOhiZtb4xfHLEyMhsKrUlBWQf5Bp+6RkqzL6R6Y4Tn8Pb4CRBaC/zwKCUI+Dwywmoz89vn24cWpFYMdtsM8DL28dxps7HQMu6Bqf8B68Ti9sOsRyuO/zRQahZ4XZ0O76oFOWRCT/pmhRrhyyGqqRFeqNZF+W/skyi/IPCoHPzwSan55iSHEZIj2us9nCTHPj6GFJFfcayjWa+TgW2TgNRY0AuP6cKrFkzHvo1K+ZZ3+rR3F0vbDvZbKNamCJqntpZBEmbt88r1eYXUG+cniP4B33QMH6ZoCRAJMNhjvHlMV4341WjPI8uefqdp0FXeRcZD3dFhQbdWWfMv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(316002)(2906002)(6512007)(36756003)(38100700002)(38070700005)(186003)(5660300002)(76116006)(66446008)(66556008)(6506007)(44832011)(2616005)(1076003)(6486002)(508600001)(66946007)(64756008)(4744005)(66476007)(8676002)(71200400001)(91956017)(26005)(8936002)(110136005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pMEfLMuJaiqo8mTwFbAyeEB+59S58oAO6nCRjVAsjQqM+Iag2VUj8OhziN?=
 =?iso-8859-1?Q?1bq2lFUwGm6TYwLkh/5yxH+YwlyBqMbw2hBvj/O5av8LV3kWk/pQJbJ4et?=
 =?iso-8859-1?Q?zdbup9GanvzgKjMfsVTe3blylZliVTIAvqIoF4rvD3PHOopIFfdiJ0idlV?=
 =?iso-8859-1?Q?cy8IKeAsIaH+XmtGk4L8SbDBxrcOIWXqwBf4ug/GH1UfhPz0bBiWy2pJRG?=
 =?iso-8859-1?Q?lquc1dUDc8aUWa2WflJv4Q1RJLeE58b3gaZ59O++BkIFeWd8pxKXUfONt8?=
 =?iso-8859-1?Q?cXvwpnaX9VXHrk36ZT7axAev1TNOsUikPETxaCXxlFOk5nECF80LdT4vjX?=
 =?iso-8859-1?Q?dquC75W9z9mhh+pv0nuC//6Fn0y6Kqr5Bams9zTBzsGxByzu88iXR3/Mlq?=
 =?iso-8859-1?Q?VCDOr695VjqdHxq4TBf6lJ0sR/lW99XZqWWNw8ZcyQinNa928GJaNdQWFB?=
 =?iso-8859-1?Q?vWulkl127fC1fdLKE66cE/oD2542xVhGjqA6OhlLoHT9ojQBrrmLOoeD+s?=
 =?iso-8859-1?Q?q+TeFfInOk5mtthiJm4RFt2FnBYZN0+4aHCDvgVosphH6+5kK0RtJIy/1a?=
 =?iso-8859-1?Q?2Hop5xeUjo5+47gigLgqUIjgqRf5nvink593vTYrTIWsZ9Judr6NLHVXXA?=
 =?iso-8859-1?Q?PB4i8pIAuVV2X3WdRLakZ2YaTmtN290CUqCFez0+QSO6Rfmi/0N61IS8bx?=
 =?iso-8859-1?Q?J/ZOweb5aUq6N2su1itpzL1qQp72vyK2dfEtmPKVjJjjsZNe1ZlyedwY4O?=
 =?iso-8859-1?Q?yZgqwRLFAt9Arjem1xZJO3wtvRSDkxxOFChH32QWLJMQXDjLvJAf3ixLkv?=
 =?iso-8859-1?Q?XUcvdDLSHMsEzJ0ARx55H1aMmm971ndvPcXP+jW2KI9aCh9GrdKyxCJDc5?=
 =?iso-8859-1?Q?1UCCWhQWKon9TWmq51XrviW4TQ61HvyC63hvWkNBiOCTtnTOT0xBw5xrgV?=
 =?iso-8859-1?Q?Q5qa9shMO3+3ktnqb8zip+qjuJ6KToZ3I0sVNJrmc+44eXHPyD0bRKP3MV?=
 =?iso-8859-1?Q?ZArcbUWViywXkY6Ec41/2Vcf0bD5ZQdnAM+Id+wn/NgBoEDpp4HIhykVY3?=
 =?iso-8859-1?Q?Upu8vyMG4t1ZliZ2EVHyWPfHphpszha7mm9kYjLG09KoP+RtD+0SjVP3R9?=
 =?iso-8859-1?Q?tNTvT5zZZwNLfECKElJhAkZVK2rhY573p91H3sI3uShURo1BfiXIrg6ccF?=
 =?iso-8859-1?Q?Et9gbNSDUeJIFSAP4Jf86xFy7jrmT4BR+BUxVEs6YClzx7SJK6Oz8F7m70?=
 =?iso-8859-1?Q?N2JDFzE2Z0CtmXHaHTxA/SzGdltd0IaxdBmLQOJj5bSOWFquHTQMhYEMHN?=
 =?iso-8859-1?Q?cYP2UghhGg+FJqRej3Qwvmv6Ge2iKniVi0imYFaWNTWRa/TO0FNa8tMtpe?=
 =?iso-8859-1?Q?3PydXlFRKAzKbf/2zM/6cCDc05cNwW4O/UI1+2RhZ8C3cnuaA8TlTj+D/I?=
 =?iso-8859-1?Q?0T3gpzBcDl/xJclIotwgH4lTz8z7kTkRR0UwPpmKAWvcJjjWvSfZcTQvoq?=
 =?iso-8859-1?Q?/9v2uOraQpTLIvbQnqJ4qN5CD07UX+d4dE+XEypnmmFp7sZ+TNxKpbCvzn?=
 =?iso-8859-1?Q?dJtFZl/p1mIpNYerSr9UwtwvPQk/FBc1NpCjGBmiNSRMl0WIAt3UAe3y+q?=
 =?iso-8859-1?Q?SC2Cfj8DESxVaMLqaE8MpRcjioKYEwHDUb6FmtX7dYvx+iOtccEPFYVit3?=
 =?iso-8859-1?Q?7kPhAoWiPmSvSbgKn9sg63weB6dcxVcrwsPkgFw5VP9cFCTmZsIjb3L+Gn?=
 =?iso-8859-1?Q?/bEtGWpSu8TzNqaHAflmgPNW5jLzaTqxwX3xnpjQknP2SuMz3IeYFITt06?=
 =?iso-8859-1?Q?vkjr9Fz2c8ZZ0cR96WJbtIiGcJb+rtE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722f412c-5716-4339-bb7a-08da16485cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:27.4571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iV6BiKxcMzb3BXBWHYVS+hY5AX67GcSAfU4xgZ5GyAjcBf2Wl+3waqy5GXDPAMbUxF/rL37vKP8rKcfwhoicBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3881
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040082
X-Proofpoint-GUID: Sqmek0ZZCBrEZz_wMhCFdnfpOv_LcW7B
X-Proofpoint-ORIG-GUID: Sqmek0ZZCBrEZz_wMhCFdnfpOv_LcW7B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

define pr_err to printk

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.34.1
