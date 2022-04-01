Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A2C4EF9EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiDASfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351205AbiDASf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:35:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE21C34BB2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:33:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FwnWb017615;
        Fri, 1 Apr 2022 18:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=YxXZzc9NcifzyJJKkdbQviqwxZpGWXRW6ied8c1WuVQ=;
 b=hFYwbaXCBCN9Ey4OBlB9THdsWCdLp3tLJrKEkCt4/9IUxSOeWK5APkQyra4r0mqMUwUC
 +77JNC0ZJ/Ch6WPsqMUOzPwNx+KOy7Qa8sI8fd7XmbTd8wqrkkN6e4Mt13fY6eIUzjPd
 mndea/ipPCHtt9RkOjsbHUk5wk31kIRz7iyNee5wkXmZv6Drn42hRk/9ofXtCgZkiOZN
 1tOtsI7LycDbm2Ylo4BLgiYXhJP7PF9iLykGHZ/07cGANeefgbH1bUV1670TdSsxkQ0E
 k34rVTyygq0o0Qvz6ktRmIrUdMe8tonjHKrPLB1M82XlnqtO1oVugRGU9vIMQrCp3GXL +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1ucu00tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IBO9N011921;
        Fri, 1 Apr 2022 18:31:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s9690en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hz60ShID6mXawDT7T+8d8E2nZtQp7+/BPaB4cM1RlPYsOg4rXFAt4SK9rVp51D6/LrgPnbBLsSF3CideaXDUCEtC8Z1Z7YMd/gebH/l95OwkVg42hZaMFU7g50y7HMNqtgXMqrL4iaiG/rgbw0eb1f5JD7IWGtKLN5b3jLAfE2bmAyV42UBMrdM+dW1JZ9+HVjr/MMcjHeTkexmdvtl5p9YQdb3i2oO2FUPh20X78n5hs1TBlFNPIrw0Jo/8uR3hAyimy97HVpKgYh68n2pBUsapssXP3ZVV1ILYmr17CFodNil1ctcQL8xaSWRrRh+gGuDr2A/SC9WTY6vScLbrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxXZzc9NcifzyJJKkdbQviqwxZpGWXRW6ied8c1WuVQ=;
 b=L6zCyzgx+FfrI7+4XZJbTmCmpDDjxsK/2bzULZM/gmy86kbx44SHP6jsgVYP1mwXZKJe9oT/PbDfz2yLmZwE+i0wSt6pd/Fa0+AJb6r8sMPpY3E3FtdExtqnuLc6kzXG9zHeEcvCF0hVJ1boNDmzHWQWZawF/p6Py6COygytKdItKAKsxwbfpsK+evGgw/LnyCMwczaHuYwJFPeE3aBuOupEXPejrrp9EXx6m7Q4BX7r17L259Np2TgmdXmmCPFYj5csHG/nKwmZbJkFAQXYJkZBxNdQsTnryTCQAesFtNbvJB2Uy1TY5s2YbywtzAr8cIWXnSyfSwHtKO2dXyTwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxXZzc9NcifzyJJKkdbQviqwxZpGWXRW6ied8c1WuVQ=;
 b=QsMZpMIFDfv9GM1V5UktYFgvV13qQR+vaVOOaptOfRXaMWD1cUsvd1UuvVyJJ7VX+xv94RuONgz3mXxA0cUnqC4OHLuQ5z5iZ4Tasd58EDM5kiVr7ATQjagXMUxgiGuja3z+/eNDoEMw1ssIe8FSZWHX45uQqI/bSNdDorGLUZM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5502.namprd10.prod.outlook.com (2603:10b6:408:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 18:31:05 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:31:04 +0000
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
Subject: [PATCH v6 3/8] crash: prototype change for crash_prepare_elf64_headers
Date:   Fri,  1 Apr 2022 14:30:35 -0400
Message-Id: <20220401183040.1624-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220401183040.1624-1-eric.devolder@oracle.com>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0042.namprd07.prod.outlook.com
 (2603:10b6:803:2d::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 521b4647-0fe8-44d5-95da-08da140dc7e2
X-MS-TrafficTypeDiagnostic: BN0PR10MB5502:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB550271C5511C4F5766D7EF2897E09@BN0PR10MB5502.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxVABqPzyxKXiUtJktVFhYNZFd7dMBviU8BnVu9wchtoM4352pMS9SvCKSan1QU292YINO1VXkslVngKH+qly9QE9TrpoevsZN4XxeDwewGyV/+9+IVbQA2ZbAP0kb6lv0PaOSOl3TytuD1Tj4ySR5te8LNVAWaBPrmH79PoDp9HkHoyj73rHfp2uxa/DDOaAQV+VWyIJ7qPKX4MO6l//DWgp1+Cfm08Ui60k+EV2zu+Sf+dGvHyunbIrXEv5w88+nuiNLw9/dR2l5VMEHPJmUPmLkTFczeTMhnESMHmM9GPuQlPzXLNfBmn43qXlebViQzJwqxQV8e6o05EXZr2ThcpHb2VPia0hMymhgBTsF0ILG0NEXZx18daH1pKVKxM1myC3EPTR6U0YLszK2Vg0/lhec8iCUdSiB5abAjG0hbiIzLBMk0YffhWztUqpm7BpYuUAuSFs6kRNYFuNdgtH0AEkn4XfrEt0L0YSHdnfj0ahz58dAhPG5ksWinJ/lwYS2P7zU1HRqfDAwxNjYclQFCOVOIPGBY6YyVKeuJA8ZP0BIP8BjB0gntdtochNpxHaWBwIv4pXp/Xi1TCqRd86uwnYrwy8pQVWlaKyvKr2dlax5MKDHLVS8y6ALnu/vVivsk6lbeUCHc4U3Ja0GtFXMPrHdfwnqqWUcCRDWTskKEF0HGm3o7yrfR1oW9ra0ekHPeVUcaAF7eajHX4GIn70g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(6506007)(6512007)(7416002)(107886003)(26005)(2616005)(36756003)(508600001)(52116002)(1076003)(6486002)(186003)(5660300002)(4326008)(66946007)(86362001)(66476007)(66556008)(8676002)(83380400001)(38350700002)(8936002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SVWkSlDCdrxLSiyFc+DdkPpQLJda00idIiG8MGS7JtBSGBQSNu7dNASu0vyC?=
 =?us-ascii?Q?Chrjv1pvA4IYy+awVMRnQ2Pj19CH/n2qB79Ch1CJvEwzacKnqrohytKGnrxt?=
 =?us-ascii?Q?R/uXpggFhbNr/ACnZUeece/pUsXmvgM4eSuLffXuIEXTCbGFQmKiaRZgQuue?=
 =?us-ascii?Q?16y+KzlpOLaFhYxds1R+AwfXdUxJqjlC2dkkq306DNezEt6YvgzgNSW9191M?=
 =?us-ascii?Q?cJdWkj6AeOwRMMksUW+k0EGMhXvTvjdB4deUbRcWURlFqtO0g9Kda6QMPg9q?=
 =?us-ascii?Q?w+i2hFjft+dDwETPNT6IZhmAbm2pKfHI11MrnTg3ZXGlwwx2Qjn8WqidGKzg?=
 =?us-ascii?Q?i5oAH/XPjmitGwfyMheG8yKzZJ3l757oV1cYW1vM5kFm8p83O/pI4S9RPZF1?=
 =?us-ascii?Q?Nz2LOMncFWSie60qv+xDGRPfj4flGKEXhXntlRy2oDqjef62Ig/BBtv9RwB+?=
 =?us-ascii?Q?c7TZZZzgTvXsZFVgP8LeOZtQzdzbG7SoT/u6N+Q1IbugGXB21j43vbqiHRsx?=
 =?us-ascii?Q?zdb4u39hIZwO6OAMbIjnl2VGvS3asMbzHCnRHRXWTkwO8uycYu3NwSaPmJO+?=
 =?us-ascii?Q?IqnXBT5PzqGUzjznaxQPD/XSDBj7j2QdifwX+4ntq31nIBOZfvTrfAR0rT81?=
 =?us-ascii?Q?z2VyimL7ey5+SvTLzQVt4d3S9EGDYOOqj3X7NnGuZcdoaz5yS7UMpvDRteJv?=
 =?us-ascii?Q?LHo3WlBTB56hoeXjf+n1NOzK9IgcrNfAnh/74f+L5RSHCLcUjop5yd/S9gcy?=
 =?us-ascii?Q?KAiFlJO1NPI+IKbqlLHmP2jHrkTllly8CfFKdvsHWA8sglP9sk2XNZosCZQ+?=
 =?us-ascii?Q?gapmEdiuNOds/TlOhpnmYEzHqWKTK0asH1RHEWgQjwu5yKH2MH9uG/DTDXD6?=
 =?us-ascii?Q?wJRfZ1Uo25bLExUGmIS0Rc+0zzSlrBWYVo/rZOV8cADdMhTLZ8cD/ewu67kC?=
 =?us-ascii?Q?pOUXBkoba5MfTLrwLCEHaGAszp1KTfZGOzjYGgN3VN8DKXwIx0QqSFpCbiMf?=
 =?us-ascii?Q?EWSBqqPORBSdrJDQxwAyJQG50Ifi9oUNn8vuXLgAm2qGUsnhCTgfuvLPcZ0y?=
 =?us-ascii?Q?odnOIoBO0z+8OeYgh7KcjlvhXcneg57y7r3fkAlUWGpb4J5iec3exwf4HOr4?=
 =?us-ascii?Q?pKmUjPyuv7khv9cq3nZaPu+lOGI3te1Ic9Wsrd2sKQYmcETRBxZm3vSEVcgE?=
 =?us-ascii?Q?O/TlUoWWbK+/GKj80z67jw65hadav3Qg+/7/juURRaj7zAY9zJGGj11N+WLP?=
 =?us-ascii?Q?uyCzOrgmTB+NQNi4+gqlIIY/kDz3qCRKpDCGnFZs0InPVjawCiO7AXDvn2Hn?=
 =?us-ascii?Q?BlaFjOuQIPnE8Mpz+PFlvyNwm725/QqyTfPF+efS1yDfpFbnGGciQnb0xltx?=
 =?us-ascii?Q?W3mU9x4ZuyV6DuCYTcMQha9Pu5tlkHzNQMeHf1CDN/c4W6rwR0/EddLMmy9k?=
 =?us-ascii?Q?8wy2p6ElXD3YAfUEBtziGprLUMemxm5TVUthE2Mj++58VOqKaIR/7hQ6UspR?=
 =?us-ascii?Q?NUr4VpbwdaKVcbbRIVS5YQZE7tdOenPge42BPXpduUXFhYZhvQj8ptRssnu+?=
 =?us-ascii?Q?TNv11S2FyHhZq94oM5MOqxmske8f88GrRKU7kxkgmDJGiDiaHWgVFGRjY8+X?=
 =?us-ascii?Q?DPvAE1Je36ir8lIwZa/kl2I+LOfZJ9fu5YyZzvmjEk5O0QhhF5656KF1xJK7?=
 =?us-ascii?Q?fko4cy88uqLlgHwx6eYlqHxYcuJq0at2Cke0aC/nTPDqI/e1zHrPdLmqTWQu?=
 =?us-ascii?Q?wW92ajizN6gEL31jwons8RsQgGHzS6I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521b4647-0fe8-44d5-95da-08da140dc7e2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:31:04.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jiv7Tz1Xepaw1XE9vz6TMVgtVoV23ApxINhbcvhUwa6eRmydzBPFLY2My9uMHuzSmJ5dJNh500EtlMkjDOXcvHXvB0nnbvaskpRdDPv9b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5502
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010087
X-Proofpoint-ORIG-GUID: vzfPOf5-87HqRVTQUHINmE-SzZ1tWF5S
X-Proofpoint-GUID: vzfPOf5-87HqRVTQUHINmE-SzZ1tWF5S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers().

This is preparation for later patch, no functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/x86/kernel/crash.c                | 3 ++-
 include/linux/kexec.h                  | 5 +++--
 kernel/kexec_file.c                    | 4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 59c648d51848..7dbafb42ecf2 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -67,7 +67,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 
 	if (!ret)
-		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret =  crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 	kfree(cmem);
 	return ret;
@@ -96,7 +96,7 @@ int load_other_segments(struct kimage *image,
 
 	/* load elf core header */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out_err;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index b4981b651d9a..07da6bf1cf24 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -797,7 +797,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..9db41cce8d97 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem,
+				IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 58d1b58a971e..f93f2591fc1e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -227,8 +227,9 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+	struct crash_mem *mem, int kernel_map,
+	void **addr, unsigned long *sz);
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..801d0d0a5012 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1260,8 +1260,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+	int kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.27.0

