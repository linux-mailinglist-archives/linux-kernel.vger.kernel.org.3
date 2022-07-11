Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1115C570D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiGKWst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKWsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:48:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096B248EB9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:48:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BMYGww007080;
        Mon, 11 Jul 2022 22:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=9UB/2J/v40pbawPt7R0V/G/YfOcTN5OZt8pqEo9PzjE=;
 b=Il5E6Mlu98+WdIdkYYuhlWqqhvYWokt7cjBpf2sEJMtWq0e6mN9LoX97ttUgDFtDpZIW
 7uHhfSR9cGT9w8DgaN3lOgPclPg4yc7eAPsELR9hPyWQCgAwgtnFXwMbOLwsp20Ltc2B
 3i+3cvbzBiDSMLnz7CwnzBdx5+bv5w1L6aW5NPrfT8lWboVZAgh9EEh2FdO++Ciyt7gC
 j7TaS1T1n/uIxuvJxnTeYNPyaZ96SRXeQi6H/9fqyfHxjrEsjEJJBgk0hVyOfPJ9m97O
 nanieD5LveTDH84YHV1BCOVao16txUulNhqscsB/lZf1tJvy2LzHi8CTwh/6bW/rH5ma og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sc4y9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 22:47:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BMk9xi032608;
        Mon, 11 Jul 2022 22:47:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70430p4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 22:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLS/nq5XGyEmRAFfTmxsEzkOUvKL/TDiRBG+UwUMvtT36JwLlB7E6RRH5ctHL8COyVCA5/fvY7yRmkc4KJy7L3OyjL943MNWo7JObzk9dbItuI5fdEUzyriAH1CH5JlVo24F87CxvMYc3zj01zS9eU+c9ynt0fTt0w60jSYz674g8rzoddfFl+oULWE7qJT/fSs3vHhRICLFff9m/NEKrKEH1eCOG6JzSUzWgDcRSMtUp4CIpIcec6QXhEOPckSquOq2o9eIZuVOBGVHzPKZE938ICZ1x+UH69+lBoT5uj7hePVQRCS5mKLD5GbQTvxSJovqib0xnppra+vHXbshkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UB/2J/v40pbawPt7R0V/G/YfOcTN5OZt8pqEo9PzjE=;
 b=BAo9/cuGwwKl4Sf6gxoPvwEhV+fhL55X+W/D/001ynw/fQs+TaNLmNWe7vbS9kb8Adjcj/RTYdZ+FyoHtt8l67AQQv1iEZJVoUGraBUKNo/1/Ts7YHdSN2nrJ0OXqkxSX22gQLD9pyjId8RWmYJHehv6uE3wtvKP2GTB7deMYLsNrxSMo0GxHpyhlwV9PsCHQs27odjDBKUKZrmwvtko7ZBi10OE6NNSQ1tRoIZJs46Fj+WQQxj0oPOmvq9OqAIwB+TY0zH9V+dbzYwjIhxKb6imS7NexsMJ2bARA0sFP2gKT8VpKgcAlwWY3gdEveZeyUFkbQxm02pVDncccRX0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UB/2J/v40pbawPt7R0V/G/YfOcTN5OZt8pqEo9PzjE=;
 b=r4GZFMKzXOSaqnfWHZkat+j4Q/g496ajTbFwOXN0rb7P52fAq8jEITeIPLb0qbQSnNXyrVRTEMbxQtSjvWwNYp5odfcao2zlK9Rv+HtQ6PWfh5zcljBgdrtubekJD6a5wezU4BzYxTFVNkAseWOzsF0vOudtC9YkL4S3Q2tus0o=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by BL0PR10MB2964.namprd10.prod.outlook.com (2603:10b6:208:79::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Mon, 11 Jul
 2022 22:47:11 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::2913:8783:edc2:af11]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::2913:8783:edc2:af11%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 22:47:11 +0000
From:   Libo Chen <libo.chen@oracle.com>
To:     peterz@infradead.org, vincent.guittot@linaro.org, mgorman@suse.de,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: [PATCH] sched/fair: no sync wakeup from interrupt context
Date:   Mon, 11 Jul 2022 15:47:04 -0700
Message-Id: <20220711224704.1672831-1-libo.chen@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:a03:54::43) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f69fad82-6d86-4077-690b-08da638f4ade
X-MS-TrafficTypeDiagnostic: BL0PR10MB2964:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ErkswWhl1m82Tdn4snlc3jBX/5G5lroPSqAyEJK13IMxrn2LNWQsFYM9OkxNJqdzIJ46jnL8emlHRydqr3RLV03j9ysIJbQecCLmF2wI4eG96WpS7lcy4nougbTh5HFFrfdkgaeHnVafdqbtuflrgjGUSSP+IQ+E7FX/Yev7H3VAhcqdG5fZeD03oHHKMYYHNvOO8nJef8rPhylp9+TEaiiWs6hWAOsbfZXxyTmcs/KYOYXSFlE+JUNmUnHl60V4r6RWnJBJxAmmuGOd+Ad1hvoDblCBfG9Z1OQ+hYeLQEpqiVztNswhdSXRc+ZI+/Zj2srdJB4Jcn8fTfHzTHWJkaCa2Qqheq8Jyk1X3OwUKz4jCtMcA2UZ8ui2nloXLO2rCblWB6/E+ab3TIgnYBYCOHy98iIC8q640AuhGwME5jw6MSENY5X7sirGELEpSEjxk2mCXDFCEScg+kA5U5Fsutg8bwdDQ/3qZGJ7uHLIawKaKCY4JbfqTv0Ej/1vOfNqKqx4RpvLYsw5lLhagGD2ntXGsBaRS+ZTmrVeR8k6GpNd3qmEKzWu1zBEBnyKgy3QXq2OE7N+Lgh939iCDEUgG6O/znY3d+bs0JP6l6ZwGlhgHTwedox2VpoCrbw5FRiwQDcVCcozhcMF+fFHXj5rhl4/b77h7zadNwtkznYEpb/bRBIXPkWaq/MeUz7AV7LaDMjnvIHkanjh3X8Ub5FljJnYr1UvC2nOt4v3u9EHpyQHAAyHxygmDdzX/2zxypDjQbZQehdUPUzVKfGmxLsmaTBFWdMEZI9tO6FdkCwworxZEwm26abY6QYwmQ/W/VDtsBynusHFFA6jeEJwsWEAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(346002)(376002)(396003)(26005)(186003)(6506007)(1076003)(38350700002)(52116002)(6512007)(38100700002)(86362001)(2616005)(4326008)(66946007)(8676002)(36756003)(83380400001)(44832011)(316002)(966005)(6486002)(8936002)(478600001)(66476007)(2906002)(66556008)(40140700001)(41300700001)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+GaIEyeAHsd7+Gp9SXZ8e/ygVUQFxFI0l28gaQ9ZsKGKBDoi/jqezJ86yL4i?=
 =?us-ascii?Q?QJYXrk34TIMNU9tmRwfMnXmk+uODrE6FdMOu3ZE2uMUoJd0qFHXTLE7k3+XZ?=
 =?us-ascii?Q?9qnTjfYgNPSBdCsUiTnKYHXEogehq0j+QHpzJjKnfD/vL+8FKEGD2JzuZ4b4?=
 =?us-ascii?Q?wrCk3tuvP/F/NWZ9NZGR4/8Mpy77blW5whM3lItCHDdpug/B4MaAFb5OQ06E?=
 =?us-ascii?Q?Onhk2Yk4FHzAgKWkls82NgcACLwupqgnrQ2j3fjfb5KJePUTaNGhrP92T14A?=
 =?us-ascii?Q?yozjdqfx9RaPdp10nktdoDe/Or12IdeS/mDlKP9++BYo2HDC0dOCliLtw8E7?=
 =?us-ascii?Q?USwMce0ZiFLoqDYVcyiaPLDYMGsCG8HYN1B+1ibSNbFoBZAAY8LBZcNu6Ovq?=
 =?us-ascii?Q?bXXcmy19QCdH7oYx5YaNKQkksTQrT+n+9VRa1Zt8OAUmQJ27Q9tM2KSPAfQ3?=
 =?us-ascii?Q?EDvnIjKt0kj+6AI9Ybdp7WXVJ+VgN3W7O5eftxKBV9YHMTSaYEV9NiMhJpml?=
 =?us-ascii?Q?hATE8a6F9smSaQiNTn3YiQF3nY7++8TfeWFNvIDHW7m1vyxC1u7tybTthJRq?=
 =?us-ascii?Q?rZJKxzz4v9R0Tf4+nf8o7hK8OYKp5wH/xiNsLKqM16mx2yXP0Ta5N8rZ6JPh?=
 =?us-ascii?Q?t4eT4qRg4v33dw3UANsyJn17KkfKL62Afy8lbxbz0LkPFI1yumlxM8Hr4jF9?=
 =?us-ascii?Q?qyN/qr/rYRR2CDl32AaD9vs/uA6kqdKFj0m2KS7XTXwGUHS3RyTzFg0RpTQv?=
 =?us-ascii?Q?uSniM5NdDZSw+dPt0/BMBrNLTJHNXEgHPN9yszAgXdQ8jQVKO45Nsz4RZ9Bg?=
 =?us-ascii?Q?mpQhPQPAoFSSMAJaCC7kbWCpubwLdHxNfUaV7p08zfMsdEbEXT8N+bLAvHvy?=
 =?us-ascii?Q?br2sAiN0uT9PAl7I4Kad4fusuwAoThZtHWShm/0Th5Zs+1MbEAUy4LTpxkwu?=
 =?us-ascii?Q?Qnzil0vMsSRu58z/inl9E7e6/+1UeJUs3ErEKrEo/7m97VyHtf9Ek4Sjv0tY?=
 =?us-ascii?Q?8QWJwXDelGEbyS4zQaT5QCROGLz7L7Znk/Mk8SXDwBCM5YcaPOIXtQRL0D1f?=
 =?us-ascii?Q?CEaJ6H7s9xIHEgQ7dUhxuu2JFxLY2ttdMI6gQ2roeIRG19zP4vLuzzwldArI?=
 =?us-ascii?Q?bOli9TNgh16a4hRx/8fPkDxewYGzXu/qVEQcKQP54BqQDqqcyEwzBB6WP4Wu?=
 =?us-ascii?Q?efjXQkFTC8zKaMU9WWtnHoetPWXzd3HuOvU3ys5mG8nO6fUN5hwHIOKY3SnE?=
 =?us-ascii?Q?PHsdrIzC9tty5CHfG5m+FT/rhplu0KRmlzk23GAcv9op8wx+/UhwfhXKNTsC?=
 =?us-ascii?Q?cKXxadfGKYLfxYkgXggUPlbUqk/Vvd6JJXZXpsssWgW9mW3RxHfRYGP1xDhk?=
 =?us-ascii?Q?802iIHBVoGDI27v7CJsGf3o2+QgCiQidJLLgsT+ctoPjyn+ZcEOqyXCjsRNu?=
 =?us-ascii?Q?26LqtpC4sr2jwZZsrSmhwhx//aVBB3lg0V67DCiCgQxOSHGDIjhZJVCv5+2y?=
 =?us-ascii?Q?cCrEqpkYXR13RG1SEYL4MUkVcCACsHISfka12nng6tWMG+TrvbOm6OSRgJoX?=
 =?us-ascii?Q?HUo2Fa5q3FAGika/k0rkraSFjABveSITeV5hgiiV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69fad82-6d86-4077-690b-08da638f4ade
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 22:47:11.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kKCy+Lh8uY+m0IUXLr2kModOH+9mJ1NcbIrcofQLk3dywCjo2oYyezg1e5ZKykeKUN6k+fLSyfKHda05eUcFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2964
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_25:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110092
X-Proofpoint-GUID: Au8asF5-xmBfJ6vv_h6duXBQrI5FTdsC
X-Proofpoint-ORIG-GUID: Au8asF5-xmBfJ6vv_h6duXBQrI5FTdsC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Barry Song first pointed out that replacing sync wakeup with regular wakeup
seems to reduce overeager wakeup pulling and shows noticeable performance
improvement.[1]

This patch argues that allowing sync for wakeups from interrupt context
is a bug and fixing it can improve performance even when irq/softirq is
evenly spread out.

For wakeups from ISR, the waking CPU is just the CPU of ISR and the so-called
waker can be any random task that happens to be running on that CPU when the
interrupt comes in. This is completely different from other wakups where the
task running on the waking CPU is the actual waker. For example, two tasks
communicate through a pipe or mutiple tasks access the same critical section,
etc. This difference is important because with sync we assume the waker will
get off the runqueue and go to sleep immedately after the wakeup. The
assumption is built into wake_affine() where it discounts the waker's presence
from the runqueue when sync is true. The random waker from interrupts bears no
relation to the wakee and don't usually go to sleep immediately afterwards
unless wakeup granularity is reached. Plus the scheduler no longer enforces the
preepmtion of waker for sync wakeup as it used to before
patch f2e74eeac03ffb7 ("sched: Remove WAKEUP_SYNC feature"). Enforcing sync
wakeup preemption for wakeups from interrupt contexts doesn't seem to be
appropriate too but at least sync wakeup will do what it's supposed to do.

Add a check to make sure that sync can only be set when in_task() is true. If
a wakeup is from interrupt context, sync flag will be 0 because in_task()
returns 0.

Tested in two scenarios: wakeups from 1) task contexts, expected to see no
performance changes; 2) interrupt contexts, expected to see better performance
under low/medium load and no regression under heavy load.

Use hackbench for scenario 1 and pgbench for scenarios 2 both from mmtests on
a 2-socket Xeon E5-2699v3 box with 256G memory in total. Running 5.18 kernel
with SELinux disabled. Scheduler/MM tunables are all default. Irqbalance
daemon is active.

Hackbench (config-scheduler-unbound)
=========
process-pipes:
                Baseline                Patched
Amean   1       0.4300  ( 0.00%)        0.4420  ( -2.79%)
Amean   4       0.8757  ( 0.00%)        0.8774  ( -0.20%)
Amean   7       1.3712  ( 0.00%)        1.3789  ( -0.56%)
Amean   12      2.3541  ( 0.00%)        2.3714  ( -0.73%)
Amean   21      4.2229  ( 0.00%)        4.2439  ( -0.50%)
Amean   30      5.9113  ( 0.00%)        5.9451  ( -0.57%)
Amean   48      9.3873  ( 0.00%)        9.4898  ( -1.09%)
Amean   79      15.9281 ( 0.00%)        16.1385 ( -1.32%)
Amean   110     22.0961 ( 0.00%)        22.3433 ( -1.12%)
Amean   141     28.2973 ( 0.00%)        28.6209 ( -1.14%)
Amean   172     34.4709 ( 0.00%)        34.9347 ( -1.35%)
Amean   203     40.7621 ( 0.00%)        41.2497 ( -1.20%)
Amean   234     47.0416 ( 0.00%)        47.6470 ( -1.29%)
Amean   265     53.3048 ( 0.00%)        54.1625 ( -1.61%)
Amean   288     58.0595 ( 0.00%)        58.8096 ( -1.29%)

process-sockets:
                Baseline                Patched
Amean   1       0.6776   ( 0.00%)       0.6611   ( 2.43%)
Amean   4       2.6183   ( 0.00%)       2.5769   ( 1.58%)
Amean   7       4.5662   ( 0.00%)       4.4801   ( 1.89%)
Amean   12      7.7638   ( 0.00%)       7.6201   ( 1.85%)
Amean   21      13.5335  ( 0.00%)       13.2915  ( 1.79%)
Amean   30      19.3369  ( 0.00%)       18.9811  ( 1.84%)
Amean   48      31.0724  ( 0.00%)       30.6015  ( 1.52%)
Amean   79      51.1881  ( 0.00%)       50.4251  ( 1.49%)
Amean   110     71.3399  ( 0.00%)       70.4578  ( 1.24%)
Amean   141     91.4675  ( 0.00%)       90.3769  ( 1.19%)
Amean   172     111.7463 ( 0.00%)       110.3947 ( 1.21%)
Amean   203     131.6927 ( 0.00%)       130.3270 ( 1.04%)
Amean   234     151.7459 ( 0.00%)       150.1320 ( 1.06%)
Amean   265     171.9101 ( 0.00%)       169.9751 ( 1.13%)
Amean   288     186.9231 ( 0.00%)       184.7706 ( 1.15%)

thread-pipes:
                Baseline                Patched
Amean   1       0.4523  ( 0.00%)        0.4535  ( -0.28%)
Amean   4       0.9041  ( 0.00%)        0.9085  ( -0.48%)
Amean   7       1.4111  ( 0.00%)        1.4146  ( -0.25%)
Amean   12      2.3532  ( 0.00%)        2.3688  ( -0.66%)
Amean   21      4.1550  ( 0.00%)        4.1701  ( -0.36%)
Amean   30      6.1043  ( 0.00%)        6.2391  ( -2.21%)
Amean   48      10.2077 ( 0.00%)        10.3511 ( -1.40%)
Amean   79      16.7922 ( 0.00%)        17.0427 ( -1.49%)
Amean   110     23.3350 ( 0.00%)        23.6522 ( -1.36%)
Amean   141     29.6458 ( 0.00%)        30.2617 ( -2.08%)
Amean   172     35.8649 ( 0.00%)        36.4225 ( -1.55%)
Amean   203     42.4477 ( 0.00%)        42.8332 ( -0.91%)
Amean   234     48.7117 ( 0.00%)        49.4042 ( -1.42%)
Amean   265     54.9171 ( 0.00%)        55.6551 ( -1.34%)
Amean   288     59.5282 ( 0.00%)        60.2903 ( -1.28%)

thread-sockets:
                Baseline                Patched
Amean   1       0.6917   ( 0.00%)       0.6892   ( 0.37%)
Amean   4       2.6651   ( 0.00%)       2.6017   ( 2.38%)
Amean   7       4.6734   ( 0.00%)       4.5637   ( 2.35%)
Amean   12      8.0156   ( 0.00%)       7.8079   ( 2.59%)
Amean   21      14.0451  ( 0.00%)       13.6679  ( 2.69%)
Amean   30      20.0963  ( 0.00%)       19.5657  ( 2.64%)
Amean   48      32.4115  ( 0.00%)       31.6001  ( 2.50%)
Amean   79      53.1104  ( 0.00%)       51.8395  ( 2.39%)
Amean   110     74.0929  ( 0.00%)       72.4391  ( 2.23%)
Amean   141     95.1506  ( 0.00%)       93.0992  ( 2.16%)
Amean   172     116.1969 ( 0.00%)       113.8307 ( 2.04%)
Amean   203     137.4413 ( 0.00%)       134.5247 ( 2.12%)
Amean   234     158.5395 ( 0.00%)       155.2793 ( 2.06%)
Amean   265     179.7729 ( 0.00%)       176.1099 ( 2.04%)
Amean   288     195.5573 ( 0.00%)       191.3977 ( 2.13%)

Pgbench (config-db-pgbench-timed-ro-small)
=======
                Baseline            Patched
Hmean   1       68.54    ( 0.00%)   69.72    ( 1.71%)
Hmean   6       27725.78 ( 0.00%)   34119.11 ( 23.06%)
Hmean   12      55724.26 ( 0.00%)   63158.22 ( 13.34%)
Hmean   22      72806.26 ( 0.00%)   73389.98 ( 0.80%)
Hmean   30      79000.45 ( 0.00%)   75197.02 ( -4.81%)
Hmean   48      78180.16 ( 0.00%)   75074.09 ( -3.97%)
Hmean   80      75001.93 ( 0.00%)   70590.72 ( -5.88%)
Hmean   110     74812.25 ( 0.00%)   74128.57 ( -0.91%)
Hmean   142     74261.05 ( 0.00%)   72910.48 ( -1.82%)
Hmean   144     75375.35 ( 0.00%)   71295.72 ( -5.41%)

For hackbench, +-3% fluctuation is normal on this two-socket box, it's safe to
conclude that there are no performance differences for wakeups from task context.
For pgbench, after many runs, 10~30% gains are very consistent at lower
client counts (< #cores per socket). For higher client counts, both kernels are
very close, +-5% swings are quite common. Also NET_TX|RX softirq load
does spread out across both NUMA nodes in this test so there is no need to do
any explicit RPS/RFS.

[1]: https://lkml.org/lkml/2021/11/5/234

Signed-off-by: Libo Chen <libo.chen@oracle.com>
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..59b210d2cdb5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6704,7 +6704,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 {
-	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	/* Don't set sync for wakeup from irq/soft ctx */
+	int sync = in_task() && (wake_flags & WF_SYNC)
+		   && !(current->flags & PF_EXITING);
 	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
--
2.31.1

