Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6224FFB97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiDMQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbiDMQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:45:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0C67D05
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:43:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DFNba1003034;
        Wed, 13 Apr 2022 16:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=o+Dqt0zbsENuTCOkZXMb7UtSXXrlQOB3YFbgnmTe+Lk=;
 b=ZxGnVYbAtH8I3JFcu6E3ksGbX37G1ZdcFH+9/S9ohbvnEZ9QT7fF97EMCNYRaGqWkwV0
 X0GQJeAYyhCv9foMYMY8GukS6Gp/1FTHDWNJ0Md3dRBENvtLEpkoQeJYxzRRV9FPCK9W
 OIhIMxNGHBxr7u8Yzp3Ksv0QXkyPmahx/1sLHIMvHneVJjZRLU/UUt5bmqn+Qp1djYcr
 SY+VL/iBdCPi9cryzlhhb7lU5B1FfRKbFgg27ahvg2brFFvkE1j22N6kvybDXddMfDk6
 krHCP+Wseg1ulH2p/V052LAhZZasFB81Cv0s6qvbqp+CQoTh+wd5blbVP6hY1ahLGTlG pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2jjdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DGPTw5020992;
        Wed, 13 Apr 2022 16:43:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k4k9gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpD3cv5gR8C5kYpRQz6VvVX2WErQWpHYJws+uTzqEiczxl08dJpFsAYrd+7yzpfIkB5aUxbKXokSwhrSvikxe/wU0sOXi2s+DPCsRJMiU7gSx7hISUfpLX8SdsejSLbR/rDQcU7ju9JdFijsZill2Hnnz0RtPzW9Uv/zu7z/G7hAODZKRPXZNLnIuckE0oMJf5o+UopLp4t7UqP1EXwioDlgVm+BE1kt9ATw/eDmn20MYo7dmUedLCFcZ/yfvuqylvy/2jzcmUsxVleGHm90ntD8V6VLyvNee3+wXbEquwpKrVjTWWKok95NRNj5T4+GpR3q2/BBbdWxHujjhW0fHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+Dqt0zbsENuTCOkZXMb7UtSXXrlQOB3YFbgnmTe+Lk=;
 b=OvAor+9+Ft2e61FvIDkuF2it4m2/fcd5DJ90lHDUtiXReNWOfZv8zVgcxW44X3s7Fv0oTjWKU7EP3DOMAylgpaRy19eyGkqaN6dvhTVeFRCNIPlZiXfdbSpqSgQHyYwTevb6hGKPriQ0gCJuMWYCoIYUyfMe5YF/Z9CsgD86NNPlZZlQiem8Fcsdd1hyvNsv5/SOFaKWsF9Cle2gJGZF6to2EKpM5fAMUZOYUKax4hluTiojEHhEBlkEHhVAkHaL29okP0wAeh7eSt5210kO5OD4Iws5e9/1KxxA8im7rktDIXbCGIH/Kdo4cKsFoHlsU4iFgDxhwMf3lc3Rh2kXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+Dqt0zbsENuTCOkZXMb7UtSXXrlQOB3YFbgnmTe+Lk=;
 b=YvxXND7c9AgXBvzt6aezBXi74b6uBipw0Lo0t8b61OKBqmo9O05dWOfCYc4e+OCkeD00OFYJuVu2PsP8W0d5oyAiqZVxRhbpLK1S+36rhSBpssJZ8TVQXa0l7ZcQSBU8p0/Ebk7Y3YHPzq8L9+5rYQpFppyVGA7UssUgjPGgi8c=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB3562.namprd10.prod.outlook.com (2603:10b6:5:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:43:05 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:43:05 +0000
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
Subject: [PATCH v7 5/8] kexec: exclude elfcorehdr from the segment digest
Date:   Wed, 13 Apr 2022 12:42:34 -0400
Message-Id: <20220413164237.20845-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220413164237.20845-1-eric.devolder@oracle.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3f385f5-d613-41bc-d3df-08da1d6caf0c
X-MS-TrafficTypeDiagnostic: DM6PR10MB3562:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3562F3C663B76316876EEA1D97EC9@DM6PR10MB3562.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7JdV5NM8GhejDV9ra738nhdBe8RElRqu7MpocfFEMGt/oh+mhG0rpMY86XqdKT3hIt1IkYRWgjiLbgVzBdVYN3PgaJ9LjdM56w6Q4YMQ3e6wW5Jvl6L3mJexCeAQALt7L6s1DvHhD77kkcuzEN7vDsPXh9EPnQAn1nV6ic+KAo4/ZzYvQ0d66/lbybL3Q1s5vd7qlJs0O5kqqgUPQS2+XZLDW1EWQm5amS3WhBAbM4LhQlhMQC35NXDAQsWhOlGO7Higc5q0j9HeQSUNJJy4yGB4VENNQ3dVnVUQiwKOGRzXKvFDPk6AYEb7fDuoj7hLubcxTd1XHa3h3xTEPd+B4G6DA0w+lRS41ial0fCL7gGpwQ+OUGf+qXyqXIBPgpSx6X30oSsOIGykhg+EnyNA0mlHtkYsNxeHWJtlDGwsm/bouDbySMEEOgT06IpjzpL6MGZ3/bMgzayhoOQh4u7aPqewjJKi2aqnxTcx/r9raSEU/Bhi5c4vb2EPYu45kUvn/kJyZm8yMPqW5c9qyqXJKZQGo2qGgsBh1DcA+bu22uqyzcqdsmjnb+iSwWMJR6N3WF7qtjvI1nCeI4VZIKxIcQpky8TFntzYWl8c5LemRoYOQByp+bfQu92o09Ix991fHh/jqoXQiPCOCiYZYZAvyWjWY0sCT+l9ahIavmeB3tGYZxj7ululV0WU1VGnb9wF8ZYwjJSu62nKkeqoGXmwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(86362001)(66476007)(66946007)(1076003)(66556008)(8676002)(8936002)(7416002)(52116002)(2906002)(6512007)(38100700002)(38350700002)(6666004)(6506007)(508600001)(316002)(5660300002)(2616005)(107886003)(36756003)(186003)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rur7qfEt8WF/5wwIyZHgUrsxirlS4267apwSVDdiq1hkte1EZpu1vL1U5z4H?=
 =?us-ascii?Q?ZtcEnLSq3/4WAiNdn/fYb5I9Tr/Okvj5douFjXhZRN0ka9kD/mQ7MeUn6Jn0?=
 =?us-ascii?Q?Me1EX4873vIZ3BXDVvfkn5//G2tcBIFVKOrp/K47F54J/FpXAhZoWLgx5R+X?=
 =?us-ascii?Q?bJRtKJ1kv2e7UIcvNpfhdabPFOofNoPn3CVy1p7WzxpBIAskbP8VZCneOSUD?=
 =?us-ascii?Q?sBOxhH6QQ/4TYO1Zu5WGsH1iMz/SQfumTaaOkpB+5blW+n7QSPDsBMpu0cfC?=
 =?us-ascii?Q?D1AuAUNCnHTW9EfSnmGLJwxE+SjhpqjQAbgUDPq3KnJ165vcak4XJnEWXQc9?=
 =?us-ascii?Q?2HU/p65ItqcO70Yhei4d/9M3Bu5B95770qHqS3dO9JZjAjpgIM9D74JxkvEv?=
 =?us-ascii?Q?DPshAmsNyuaopdakCnIO5Nt3Vm4vvbONoW3LtjJH1ovVcj9ZLnui6HDNIJKR?=
 =?us-ascii?Q?OGK8OYVucYjYwK4E9S6YiM095pM7j0dGWf+mrI20RgBS0aKGvMj/3cB2dJy5?=
 =?us-ascii?Q?kThq0K6O7j3lJ9eseQXt4c2X+doDWpNmdtmnHAk7SL0khIHJqB8nQz3d7Dxj?=
 =?us-ascii?Q?HAZj7BAK2mHCI5+I1wRkWFfXYQJ0nGzs5VW2a+Ir7GqdoOYuObUV2nzudYRb?=
 =?us-ascii?Q?R9FfloHUBv5PW9zmtKTlVpqX+K4rwLDLSV+2IoG1QQNRZiCo7x1oNz22hZpA?=
 =?us-ascii?Q?q2LPVGq2APBxu65ohVSMr1YFfeqI3bTU/IymvhMxVjNah8KHtU/lXX6Tfv/D?=
 =?us-ascii?Q?8XkKsdnkRhOLi69DkBRwauGBjeqLoUrVNYGNawsiVP5ONeu+RInGPD1QHEJJ?=
 =?us-ascii?Q?XfzcO9zy9gUeF7w88aow3n+XmhkWvLV4vopqWjXGii97TzMsYOlTDRGReVyR?=
 =?us-ascii?Q?iUBCev42B5WkiGSfo5wRqUtpm6ZgyhEt+GCxUymZl7hi8bH3jL2PGRlpKfF5?=
 =?us-ascii?Q?1i4e45zPLxYWmnQMQPhoimziVvuB6eedVDtQXoy+9f0gz5/1qHGszjj22Zcn?=
 =?us-ascii?Q?1+RBEpEv/NIvr8hDejYXJrAu51PFn9S07yL3OKjoaTRLWeidj6Y6nm2HuSH6?=
 =?us-ascii?Q?J9G2GcSY4nm1N8JEnzGuALpqadacODionjCkFz+CPmOeiZ2fkGJCRTo5xp8n?=
 =?us-ascii?Q?di0V8/HfAgw3nmtvuR3X3l0O0Dn4x8u7IxoqvtHgTFx1PJo/wRrGB5OB+6gJ?=
 =?us-ascii?Q?6K3NfVy2VY7VXLVMAktmFvfb9ljRWklSnBNt6EMVFZZGAXC3OMr+wM1vIOJA?=
 =?us-ascii?Q?uZ2fPLGB8XrXB7MRWaQjQkkfDZHnxNGHwVbsn2QfRT2I+dIgCEICx64/MkIB?=
 =?us-ascii?Q?Z9LjOritVsYsVZOGjchWlFnAiYVVcXaym1RNoxYwuKc1B5SCFYmgodPIeON5?=
 =?us-ascii?Q?ZqCBY5azqlssmmsQuoudVXVDB5ozYN05aIdCcwHiXsYX0QDqE/4tU3u9RFAu?=
 =?us-ascii?Q?H0YBs16hnXCAluCuQcAQLEErEXDYkJO26nr3E+9JiJ/dmEc+K1BwdSCzGYoU?=
 =?us-ascii?Q?KwiiOmPdXbnFIuwnKgCHDAWSjzm29hJHRdCf+wt7cEUSsqzZzud7SNxZwBrW?=
 =?us-ascii?Q?B2du8Ro4OfZMwdFB9LxMjBKjKOhJEgEyAqwFBJaUM0VVyP9QHPZ/VP3fyCWT?=
 =?us-ascii?Q?RXA+dB0GRpUvgaSAD3eXwTN0V3bm5eCbM4mItlro6+96V11awsE+c9HL8z5H?=
 =?us-ascii?Q?GJoDl4lfCAbVB/ZUMkPLvFpyLHmgCUzMu8yS2PmZrCh2LqR9zKC9kdSg1lUZ?=
 =?us-ascii?Q?H+Gbnx38pniJI6xgrT/i1mglVxozDYc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f385f5-d613-41bc-d3df-08da1d6caf0c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:43:05.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGdi8mB6N20u7f8u5X/TIsC5/VbN89hmvkiOnPR7QNgpVRyXKyT7Df33uRaw09dj4ME9cetgGIPhVa75SOOKxzPb0VTj+a3XLFrYUi2RnAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3562
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130085
X-Proofpoint-ORIG-GUID: i_7tCSfxVxUN08wDk0cIHZtmseFi0xtV
X-Proofpoint-GUID: i_7tCSfxVxUN08wDk0cIHZtmseFi0xtV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 801d0d0a5012..94a459209111 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
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

