Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8246502C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354921AbiDOPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiDOPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:19:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF7EBE9C9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:16:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23FAgMo4003034;
        Fri, 15 Apr 2022 15:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=i7I0VU+wIZEzwx/lMxKjpYPJRQlL4cBBcCwhs8niFBY=;
 b=SHDAdNiNqW76eSoJI9qm5AMJBKeA9JZf8DVljwYfhjCEEqgJZumkOQCaimcLZ64yirFI
 YglhlzQbzy2TqOpCDC9tIMSPeIiVXp6aChWvDzwHLPyO8G12HqiVdGdHFcoTXjwkNoaz
 0ZT7n+i+X4yP48liNxYLI7TmlLW/7DqZlbqEJPrMF4puxgIWlrI68m0iHcGygVjII3Rb
 FRmPylQOp1TGS2qTirPmkq6zmA2BCoL2cZU6CV1buqA3xvc7b759TpdmTFUdLptmheU7
 cx1irmGmKS8AUx7ocoabO+kiq2k/ED/EzD4/z/vSTMvyiDGtmEBs3GXZW8V8VlY8zFhJ yA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2qcbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:16:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FFBrvM037646;
        Fri, 15 Apr 2022 15:16:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k694nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:16:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmz3i+2SLthZtNnaM0GRJFkqrLhql19J124343fIe5eYnKk64e12FrcPuT5UrrWp0Q1Ydoz61QZHpalEoDLTtuT1SwoljmBhLxD8UsywVtn4W910e5tvryh/1VAPMxkrQhL+ooXXFgjZ+imP8CPOodgAyGyP6bMC/SLI6B4xQVhI5GQegsTU9XhKzSR9yedZIVRmNVXRHUSJT6kYHmU45hNPRvMPhJg8vYc7akJ2RYD8iKpf7KS+Hpi02qmucsQbg9bS377mg98CADSTcIs+ThTRQf3tba7ijX0bL55K8U2CYfYgRQf5L9hCIT8bs+qb2x7Pwf3JOXKWDZlqlhmNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7I0VU+wIZEzwx/lMxKjpYPJRQlL4cBBcCwhs8niFBY=;
 b=JeugThgY4AAHmxsaxzFiYCW9IQFd1nnMz4aPQugqmrXYfoCYOL2e6UovCPEpK3Hzwq+YwrbXSmrYNonLhuSwK0nq06tdC88MeGcZ5AGCvGypwlbfXs7GRiIHDAe0GRvlQaM7QNrb5Yg0qL2KD/yD4be/iQE3BBQYdkbaU8L5aM4M93ROoRNYfjAGp4JDsmKLKKpfS9+K5eXgF814DBebBR+0uGSZmwDBT60KbxQRU0vokrStJhYmELJyanKNDCt4iX5a2vtsbREassKzQ7CQtzQMGLwue6VLmJ1YcHwxy76PpIRsuN1ZZoMoyFQr3MBw479lfd2upZlQwFrBhz+DlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7I0VU+wIZEzwx/lMxKjpYPJRQlL4cBBcCwhs8niFBY=;
 b=p1PfVInk7v56tj++SK7gsdDVhkybFU/pIUsvDpNZMvjJSX4+9uCO5lHDaT4MAcbg4DvA9W/mVTVANb40o6RYOfG0/hlT/hYNVLzt9f7aUzS6/cP8dK/epLoD38t7DMCrHw9o37U4vevJGzpgItHxrnjQtLUjwVmTTETjAorPDEQ=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH7PR10MB5854.namprd10.prod.outlook.com (2603:10b6:510:127::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 15:16:24 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::1ccb:ce96:8c51:478c]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::1ccb:ce96:8c51:478c%6]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 15:16:24 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: [PATCH 0/2] x86: Check return values for early memory/IO remap calls
Date:   Fri, 15 Apr 2022 11:09:59 -0400
Message-Id: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 817d4da2-5736-4e23-77f4-08da1ef2e762
X-MS-TrafficTypeDiagnostic: PH7PR10MB5854:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB5854E1609496D4A220023AC6E6EE9@PH7PR10MB5854.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrQlhDu1rwPPXNHd7oXdv/oWiH0LpYMhJ18VPORZaNZO7nxZio3FZcJOoayWJsUxM3cwgAOWJ/ykJf2e5vJ4MIxUUDtG872EH+o+Dmmbzxkn5/DEQy45luHG5zHf+i8KF7lVMxCJ31UEwD6SYxIryr0/2fId/ZaBtwkJuq0G1kDhIgkkDPcbPInxaTkSHwSJLYdthehUECTQUx8qoruLgvDoMghjd2XRWOtjxoVXAAJL9PDLFUGteCKCYABqLConHoJ9GgZAKv8UEa8W7X4jHf/BsgcNL5sX+8L910I9skFDfMty3/LOXFfapMTLzlBPNXrgSShdZNXuNAIFWsShq78/psu1EEda3P0l8W15XWNci4FaUXz9Ia4EO9jLDEvq8HOivYVH5Qwlq9PESDSUqMbNexTwLV82GeRD/zUDSpw7g9+WRmFC7a5CicNDhdE66iR0llSVIWlmqjLGZGF/82wEix+//ZC+fJgxpSXumZp/08jQWeLe9n3SojhMLtpRk/dn84xt4T0y2PmsPNECz3EB4TR2TV8f6XfQKuZsmQaNUU5PXpo/iryB/j9ikiUzlEVlzRBOi5bAvph2U/xjd9fx5i0xIXW/sii+x5rNKBn/UwHPULBWlHHWXfGoYRUz7e7/Tx5VZVSK7f1ykO0mF9dAUM6x9mRWLAXR9vGlGP6WoUnx9kPPxnuFa7822ohxKAvlk3/pIlwLz9zFHAGseA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(52116002)(7416002)(6666004)(8936002)(508600001)(44832011)(86362001)(38350700002)(38100700002)(6486002)(2906002)(83380400001)(26005)(6512007)(36756003)(316002)(186003)(4326008)(8676002)(66556008)(66946007)(66476007)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJJ3/cFyHGxo7XPZO1FhAtPftWPRQ7qUPZMe816K/YRJ4Y8cYLjkkLVTRT9r?=
 =?us-ascii?Q?lB3GA00d+H0j0tY1FWB8tpUFp4F9YnTO45D9n+9I1L1s0q6JToek4b2cr7KX?=
 =?us-ascii?Q?XjepHNefVc8ZHd/lf7/L2qzr3GCNZJfmjBdRGseNTH2U+a7K0EgRFVx/quZB?=
 =?us-ascii?Q?lxjLqn8pfHpp1hha/vAvqfPI823LrEMbezXwylojJYpfgIe0+CesRkdwZOeE?=
 =?us-ascii?Q?2r/8e8dXes82tvh1A74iaxwA4cnkXB3Ni1uQfRQLk4QqD1KgvbWcqnJjfmt1?=
 =?us-ascii?Q?xtIIBag5fTRidLItPF6KqdhOdREc5CTMyU+bhLMGtR8cpKpP99LB8x2jBKfV?=
 =?us-ascii?Q?olRC6UtgkcvYnsHG8zLZxx3c/+0RqGLe8VjT4ELUJ5ZbJYozToS4JJpCIbgY?=
 =?us-ascii?Q?MRxNTjqY0p8gPuLz9q8+3zeJw/6jvDj33kasLrNCE/yHchfI/G8ESH2XslWV?=
 =?us-ascii?Q?X7p4N7nRX27Ug6QO6OkiOa8bRvKxNjFKiImjslPzJW47D2uNXGiZQuJiS/X6?=
 =?us-ascii?Q?9UFAX2EAcUZnqnTAlxceYMfUh0ur9efv/xJSkxSyuhJcpPYYc5yjyW+B7FlY?=
 =?us-ascii?Q?T6a3ioBtGgsbSkioiAmUMNiNwdgWWrtn32Ow35nz8JhlhMccMbpqhnc7s9GB?=
 =?us-ascii?Q?sNLm7vJg+Lj5mRI5VkMityIzgoLe1HzIT7UywJwlSUukj6W34CxvE9v1ySEv?=
 =?us-ascii?Q?5KK3pf7ktrE9WxaMGFT/wgsbl1oEL6sVd+evxy7k7GoiAfqlMh6LGYczGIEl?=
 =?us-ascii?Q?echjBTgrQmV+28fLDh2iqgSt8f1Zv7aM07ZJ8Y4sfc0n9qt7Zi+L5yAY/Ziq?=
 =?us-ascii?Q?N+fHQ3c+TChPEs1Zy/qZVFkqPfiesbS42iovcy7KU/x54UGM1gBKDeKF7pSv?=
 =?us-ascii?Q?EPsZUe3xjDh11phiTWnDQUHa8ZK/pbj+CFrzyzLCPbAT37o9kP1lykuWe2rg?=
 =?us-ascii?Q?kyoCkVe44ZUG9hkLZq6h3XPXpaUJtrWVmiW0rQKjilBZcUqPUNhm+slz4bpm?=
 =?us-ascii?Q?nhESG7i6NQwDR7WgwfhqOm981Icl2Yb5JvU1/4HQ7jZNxGHERlW2MoaGud7x?=
 =?us-ascii?Q?0l0OvZpluL42nKIigMvhY3K7Rgu1tS3/fZnwbxc2msnfLmGhbTn4KxU496AQ?=
 =?us-ascii?Q?MHNilCxZqkQzglZo6DJ8UOYX7c5SdWRyzaJAaUnlCRVckIFHdJRTogRrFaq1?=
 =?us-ascii?Q?UgKNnVE1YO3S0QAbD18FDIxKOLvJLd28+9gorcE7s6L7++AfZv2WquQrgKhg?=
 =?us-ascii?Q?l4i/qFODpJUYpAZc63WCcZlyAJH/e9j5miwvLlWQaOjk3o6NMgOdkENWnOCe?=
 =?us-ascii?Q?Su4aRVfZgytsLk1Ns8zaXGoIED6sIrmfUu0I8Lrs2t6wY682j5WdqOA7+AmL?=
 =?us-ascii?Q?mRaU6PSChOCOoTCwEM7yTMdNgShSOZC5QcbvA+4IiTVVk8sbAnockSaMlnJ2?=
 =?us-ascii?Q?esFfVPN6NT8KteVJwRmplxGYAV0Z9U0DtDamrMWaisN8nkILOMrz5x/m54rb?=
 =?us-ascii?Q?4csdWyqiekMyxkYRVlDBW+H7eGKEq5aca6rdgQhY6fNnX685qJ5nEaqJPRzz?=
 =?us-ascii?Q?flcZUy7eA2f13tdCJQit6O2HXhFARqzcLoXVJgmzm1vKOLc3a1gzd06pxSEi?=
 =?us-ascii?Q?lakRFJmA1f7OIjClLBsppxGA+WSVwByOfx8o1EHP72oqqlkqvRmuF2umRAzt?=
 =?us-ascii?Q?rfJ1g8e93/FIZmifPep+C6zXxpIfrS5lpjo1qWWZXZXP1LWHU7ogDm+1Glv8?=
 =?us-ascii?Q?taczJGM+nu3117+aGeCTgLiFeEtBPhQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817d4da2-5736-4e23-77f4-08da1ef2e762
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 15:16:24.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlRNzCxFpCaYihymZb948G1C1Eypaflei6f47bQgC0o9A+zuoVjaPJD+dR2IctR0M+uh8MrMjD8pr4MRJ+YVC37HS7kJ9czAUZqsPCFt+Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5854
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=384 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150090
X-Proofpoint-ORIG-GUID: JpPVLijBzvnCn-40zzPtSgzyelrECd4G
X-Proofpoint-GUID: JpPVLijBzvnCn-40zzPtSgzyelrECd4G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While sending an earlier patch set it was discovered that there are a
number of places in early x86 code were the functions early_memremap()
and early_ioremap() are called but the returned pointer is not checked
for NULL. Since NULL can be returned for a couple of reasons, the return
value should be checked for NULL.

This set fixes the places where the checks were missing. It was not always
clear what the best failure mode should be when NULL is detected. In modules
where other places tended to pr_warn or panic e.g., the same was done for
the checks. In other places it was based on how significantly fatal the
failure would end up being. The review process may point out places where
this should be changed.

Ross Philipson (2):
  x86: Check return values from early_memremap calls
  x86: Check return values from early_ioremap calls

 arch/x86/kernel/apic/x2apic_uv_x.c |  2 ++
 arch/x86/kernel/devicetree.c       | 10 ++++++++++
 arch/x86/kernel/e820.c             |  5 +++++
 arch/x86/kernel/early_printk.c     |  2 ++
 arch/x86/kernel/jailhouse.c        |  6 ++++++
 arch/x86/kernel/mpparse.c          | 23 +++++++++++++++++++++++
 arch/x86/kernel/setup.c            |  5 +++++
 arch/x86/kernel/vsmp_64.c          |  3 +++
 arch/x86/xen/enlighten_hvm.c       |  2 ++
 arch/x86/xen/mmu_pv.c              |  8 ++++++++
 arch/x86/xen/setup.c               |  2 ++
 11 files changed, 68 insertions(+)

-- 
1.8.3.1

