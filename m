Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6FB51C85B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383956AbiEESu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384046AbiEESus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D8DDA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:47:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245IOvGk026114;
        Thu, 5 May 2022 18:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+/D92orwRZwm+Pk8rNy86Zf/Ee4EOg9Ccfh8zWD7IDk=;
 b=EU14p3MYT4KPhuwyxuQwEGm7IroEPloZqRrOy44xUXB5uf/qRKJt/WJIG+xRr2xceZw0
 gc3bB3qBq5VO5YcfexNdiGih/xD96MWy3L/+C5TXahTa0szTlL+E+5ipaxPXPbh9HxQA
 dF6QGMZ2nEUlWP6oYQjnIEwjGNA6wZNKsIDOHoyYajnNkMm+XLZUoeWiMcjEiPYdaAYd
 jjbCgGD5cicqDlcVODRDabJv0Q5iZtLHDb3qVqggw3KxVlileB4qZg9Vh0eQhNNnT6Kr
 D9g/947XKwRxu4disDXMGvzkf9mE5CMoEvIIuZTYhQOAiFGofpoGsC5LUoJo0vJniAO/ GA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhcc098-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245Iisjb004616;
        Thu, 5 May 2022 18:46:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj522fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okiu2XKJZaC+7/824Q/Jidtyu6K+J6SaUSwGTfObT+h/IDT5X0c09oGNFwQs8gAwoPaibeWhwfZm+4xg+ksBzKq+4uVLS2+bnbCY9PlbU2ZR1ELKXTwyT543ZQu/7lS7c7gMl7UpjaZSPTTdhed2dXf/lFTVYMcJPXUY3QMPxq9TIwR8nKEa3smEtqMEpxDulzXxZvK5ovYjrR5WdHckzsAhvmnJygiGVcj3A/1hcXET+HicxrS50A5JDUger+RnqrhBMYgOeCREfYr0I0gjefwX5+FWK4ZAk+SsVRNVPOAzqa4Hm6Rc6U3luLbQgGlQ6Fj9o/xq43AkMuUCCsgvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/D92orwRZwm+Pk8rNy86Zf/Ee4EOg9Ccfh8zWD7IDk=;
 b=EBQWm2gjsE4W9ZMXguv7U/Frd8tYlOjcAfAH5UsHwUN2FZkKKom+fsoCgyjMaTdzey0xaMrl0nWDOMF+vYM9cVGTg3JnASpk3ZMPRMgpwXfYqgwkSBrhsSehxHSlEFes0yJkJ0lKmJoXqCu6xyloZsu3kVgyGGQSD9fm0HgjoOjSsTo4KF8ynvDOqpDO9KC/8NykrK1R8aUrj1HcVLeagsTpslZ6US4OPkY1thXNdlrcNoR0wzfIF43g3dURPlMtAFnSFv9+2N41nPX7aKjOB+9IrLHng8je1f5JwZinTfGnMjub84XHQO3lHwTtWgQO4w6BFCjdHUxAmCvI3odYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/D92orwRZwm+Pk8rNy86Zf/Ee4EOg9Ccfh8zWD7IDk=;
 b=K4na8dFvhyzH6q5A6eBRKYwJzJYLg3IB4n78lDpXuetIrZZyIUjJNgI/L4fc59YjAX1zzoHqokDInTk1o7oxHGhu0aEIGxRi5jeLjHpwodnONk3QdwP28n3y2YXTOBJqns09+mB/yJdVBSSkW0MfUKh0+QELt2HkUCYxM742Lv0=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BN6PR10MB1875.namprd10.prod.outlook.com (2603:10b6:404:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 18:46:34 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 18:46:34 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v8 4/7] kexec: exclude elfcorehdr from the segment digest
Date:   Thu,  5 May 2022 14:46:00 -0400
Message-Id: <20220505184603.1548-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505184603.1548-1-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0384934-cf90-47b6-3c3d-08da2ec79403
X-MS-TrafficTypeDiagnostic: BN6PR10MB1875:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1875D849D05C028C4D65A07D97C29@BN6PR10MB1875.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odOD2EiZgpYZqebxnnFzbRa+RozFXt9Y5ahVD/NQVqT3zm655eoAR2emB4s/kYoLHs+d1f0BWLP0Nf8Y3ioA3rBupO+O3arD8FB+AK2c3GAQaTzexV3gI894be2ip6pvFpiLhRonq/vBQsBD+Fdvh754bANz2NDjJlk9s3Y4LvxRUeC6+ZiQd1T7ViU5cXFJSZc7peIoBGwI2HWTMbsTBO8WPU3R3aGiJ1HjUWIfqyf+MQKiWjgWCKoLrw4MD8CxqnErf+etiBRoj3gZcfV0JdxHz92LV1/Q48r+UuOQvjeJbsjCFpgyZ6aIHMel/jlOMfgk8O2tqzdLkp7aTeCxrVUENS1fTEXXvRYnTc30W2w5Yv3Qim+P+YG4nbYyIqhu9M3hjd5nkgDLNTTex2u1cKkoZzSTQi9x4tVTbnqMEttYBEQ/ad30PNj4Ivb7rzSxh6auyaGvhizRTlXhRcRcMmGxsM3Oh1QePMmBvU9KjNhC8mZ0P1oGbjydu70XUtXfJiLzUd2Xqgf7kzjrkV4RkFcIDYOE8t3CJNx3dpOK/wxCEN/7vtgQQTE5r58qxg0AAGxxrLURUV2ThtKplYRYDnmEtEXH2/lqK3qeDgX7if0i2bTxaxZFH7YrqLCJJ5KUpmfBfnnuNHQ0KIih4s4CAjW2HpF/CHZjKvF1849W7GV9yQV2tiO4BYWRwqd04Qh/9vi7hQGkCc8OFSXxz+3slA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(52116002)(26005)(66946007)(4326008)(66556008)(66476007)(6506007)(8676002)(5660300002)(6666004)(86362001)(2906002)(38100700002)(316002)(7416002)(36756003)(38350700002)(8936002)(186003)(2616005)(1076003)(508600001)(6486002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EZtl9Fa+8d/0Ib5CGfu3WYNFhgZCIyTMHmP6RHsFkfcKT6BKs9YP7YdBWslf?=
 =?us-ascii?Q?OWZ73EaLfF6oOBGk/KB+VBXForoJo4qU9Dr4+CuBj79332ir/cFuwac3nahN?=
 =?us-ascii?Q?ASa2uqh3GBW9RDBZ59aOIqrV0Qwjnlu4H6oQOcBaeFX9THs4k2tK7m4nIIUt?=
 =?us-ascii?Q?zRL9l9QAb4vH2uidsHVWiiaELnaIMUg6HUS/nGBibuZ7SGu/tEmjgG+NuYXH?=
 =?us-ascii?Q?jDiioAgIrgMUowD+W+S/rwgNb1f7HR6nc6+PWMUSeeFhb2DQeSjNr3sLZ1EY?=
 =?us-ascii?Q?N5EHXBzkIoBX6iLZ2AcEi3Np19rrfWe5oyuPN2ur2EKJrO97U1bXl1EQM378?=
 =?us-ascii?Q?OuJ/G6bakE2+6iF09z5DUGVhwbiMoQEfM0yT1oie6vbvakj66bUx20ubipHI?=
 =?us-ascii?Q?4Adf58ylni84mfQ+YTGFjvgcfTmJ7r3Fnm2kStmePQVOD5iLm5CsVlNA+m1n?=
 =?us-ascii?Q?bTruuXuHQMN3Y/jd31KcygrnJaGjmW3LgJCTfc1SHtTGx3BbHQZ4cQcBfQxe?=
 =?us-ascii?Q?9FontDjRiwDq5Bs+Vu/LMjMQi8KAfImHw2SNwmjsRYqt6N5nFodOEy9pv3sk?=
 =?us-ascii?Q?Yx3jLvg2bkwKhuaNkBEJgmd+A5fKx2niYR1u+gQG87tkqKuJdsq+JJbCwOsW?=
 =?us-ascii?Q?rP0KLmaV6yLVzcx5dKldK+KkC3B1kQ4rdT+HJMuJ8M++hxgqaGBTAjsMTCeg?=
 =?us-ascii?Q?KM4Np//7pgSciIT2h9S2Xikq7qGROqjnqIoPHjbgqNwrBfSclzjpl4k2KeE1?=
 =?us-ascii?Q?xWqftBXpte2BNmP1leA3c3ctQ1qy5KpHvPHXySZRU/z4I+I7POmx9ubYUgKS?=
 =?us-ascii?Q?xrBk9lOiMQN2Nwad8rXlxS2uDr0/uMjw58YrXqh36XwWrv7DFl6X3mDnwvVi?=
 =?us-ascii?Q?Jc8IKXPbH3/6VN4llT3wMNkGG/YG0nwVhFhgSLcEHdDp11335CBKmr7WfXU+?=
 =?us-ascii?Q?gLp9OM7tD8la6CwWX+jhlSVgsNu+5Tn078Y8H1NRPCNqgV3DQIvfFP6wu2v3?=
 =?us-ascii?Q?gMI3k8RpK8plUEr66dhk09Da90lzfiqg8MW1c3+QmITXgo5Vjr/vSH58QagL?=
 =?us-ascii?Q?XHnc/aMi3WZ8HRQo8CSVpsETDjOlMNrmuXB+Ucs7fwC5ZoFmI0n7Z7qAQ0Wu?=
 =?us-ascii?Q?A9g6sbCBMtfdNqMeKS0KLwlJnBrGr+/xC4mgvyjLn99wOp+HewWxp0jFA5Xe?=
 =?us-ascii?Q?sKhUKyfoCK2AkYHSHkkPkGYjvwRJnUi1ijwVZlIWEnAsdp7J6wGZQbc3Ae3A?=
 =?us-ascii?Q?mUmyvHd9oyxHRejfGciue8u+X5E45jOL5Fy3SlzK073Ya0eL9+1BCe/IG/1e?=
 =?us-ascii?Q?zgBdCvQ0IFRw5nwb0jNQoCyeG8JBZY2m2HE/qNfjjrXp7RJTTlx7INqx8+v3?=
 =?us-ascii?Q?/+kQUTT2MDE1yJXq2DPB4NBcvG09mLbEBERWJlYnQ1GCoKPyNMmWnsDdmjA3?=
 =?us-ascii?Q?/dGudiW8L0nFzQwSB89cqE+uWdH7VCZ+9Lov6ckEVaWgfpUJSVOqzxq5tz8W?=
 =?us-ascii?Q?IV6N6CnIKHScNKwdDj8cOj6C+wsjwefv1cKqckRqZG53J0qTJ8KkJ4LmjVLb?=
 =?us-ascii?Q?pXKPyj+L3v/pLuzQRsP7NvfFFKS+hrF1vZoXlakcL6sVq0FfVHpL+QhE+V+n?=
 =?us-ascii?Q?ptRcziip/YWe3Em/HOP2Ze33MTAP2v9FIZ8XZ/uVD18mvjWINNGQa1y07Mz4?=
 =?us-ascii?Q?wAEAUIOFMb58zL2Rmk4QDZP6aAuaCAscjYnUmXv7nFHOcnBEiiaz9pnH5zXd?=
 =?us-ascii?Q?s7ZgjfgCqW5TsO+qDKNMIpZnpy+YfUA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0384934-cf90-47b6-3c3d-08da2ec79403
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:46:34.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5CdYUaThYw9iX5J120cGzq/ReflBJeqXiEejn+UrGjOB8v9dX+6LjUiI27v3/eBT0NiXQxF80Hyr3JT+O++rIzlwha7BsgMeBL/AoynX+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1875
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_08:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050126
X-Proofpoint-GUID: TJJj677YlsLtBr7NbVmcZ-UjWAVzLqcj
X-Proofpoint-ORIG-GUID: TJJj677YlsLtBr7NbVmcZ-UjWAVzLqcj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

Since hotplug events cause changes to the elfcorehdr, purgatory
integrity checking fails (at crash time, and no kdump created).
As a result, this change explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits changes to the elfcorehdr in response to hotplug events,
without having to also reload purgatory due to the change to the
digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 801d0d0a5012..aacdf93c3507 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+		/* This segment excluded to allow future changes via hotplug */
+		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.27.0

