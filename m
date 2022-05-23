Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E92B531B45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241467AbiEWS1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245497AbiEWS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:27:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1F1B0D0A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:02:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NHE1E0005485;
        Mon, 23 May 2022 18:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=qS+eAq3+c4pMrMKjoUTidEUfoR/bJiJmXX3pF672aw0=;
 b=wLhz2FoAxkDkEqstjGLevPtxMqU4DV8pxQeTi4frORyxpLcL7XG/lZldc3/vb9KE/rqF
 7DHjyxhz3wuqtOFYUhHtWKg2p8yvLWKjRU6B+Oj/paYwdPkXnZb+KMHbnV0O5yruruWf
 9Ko+xxy2dFbJ+sNveFYROPHn0UAj5dyRd5octJeka60QKQ24NQ+paGR6tzdM+25UEwGB
 f7QMtwdFWGOTd9/VkRyGGqJNxzUlv5Uw4AsPZqCPOZykPbaKsvXDX7c9KoZaAghkyfrk
 y6T3NHFGTjm9aEIj47ep3OtXtjno/2a6TlYz0aEGfK5LGCFAqbHPMxa9sjFafJeLGXgP PA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pgbm7q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 18:01:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NI0eBk035804;
        Mon, 23 May 2022 18:01:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1u1bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 18:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDOnAjbrworMXEC2t667OxoCOwm9rsmhXsxoI26+71MyawXKQQGwCuNagGyxdV7WGBXK0M5Fg/8n8d4e/RJAV8luxHLZgRxNMSguKKVZz72ENJtbFlEj7hJ9PBjA5Nhrp1LCVvayqlGsS76rcDsiuvjwPOwGSvVdFA0lfUs8/lUsFtnRYd/DR/i9ua4w+6oHlIRurjiAxu4urh0+kX/WEU4f0W+oRR+LtoRmSqoWCyMCJQeersUiE80kH+5dSMT8/96e49ImDjVlmotUUS1iSxZ5kn/ld//diTzVouC2iXUwa3XUAJuxlpzIhz3/dAiHbRKboDc2qIvKieK2+5XkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS+eAq3+c4pMrMKjoUTidEUfoR/bJiJmXX3pF672aw0=;
 b=YRoCs48MzrSd1S/+ZvdzWnzmEhnww6vka61AZsORWc1UuibFo9XZxBaERh4IvKxRSq4+8mxP+Mo7b1Rky3meHHIKdTBla6wzYmm96Bb1fP1BfnxXpPORukoQFMckQVRYk6SyDVN8E/IDjFLK+0E8QYwzVRMEQTROGHaCeIt0T2VI4wwHgLygRo7Xw+A5UdT0HP4ldx53Spu7xdUuJsAkpseIItvKWxQLzw0OfknsedqPAF8jqiyOh7ekWlcYTQf2gpVwhqoAGgPG+d+khE4E5G8zZ1RtaurcDee5HxS33n29nHN5LgRimso+YSTkJWvQB072csrCXJed2i5aaR5yMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS+eAq3+c4pMrMKjoUTidEUfoR/bJiJmXX3pF672aw0=;
 b=RmZSbX+jVzlNqz7Y85Kb0A7BY/6jiosyOMjMCyapJ9vmOSWKX+UQ//7WBlwtLjFFTtLGx4JV8PIQyaF6uFyUgWsuzIBJMuDGdFHo3IrsbultWhJDBZtPPiCZBKg/vSCfajXYFv2b4S+eMyyMm2KFl6Vbtwj3+6L6dZNgTjphZQM=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB2987.namprd10.prod.outlook.com (2603:10b6:5:66::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Mon, 23 May
 2022 18:00:57 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c%8]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 18:00:57 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        akpm@linux-foundation.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        David Vernet <void@manifault.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 0/2] Expose kallsyms data in vmcoreinfo note
In-Reply-To: <YoTIMEPAxLF9t2eo@MiWiFi-R3L-srv>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
 <YoTIMEPAxLF9t2eo@MiWiFi-R3L-srv>
Date:   Mon, 23 May 2022 11:00:55 -0700
Message-ID: <878rqs163s.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:a03:60::23) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 549f65b0-227d-4a31-4a80-08da3ce63015
X-MS-TrafficTypeDiagnostic: DM6PR10MB2987:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2987F7C681A13811BD7F7269DBD49@DM6PR10MB2987.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2l8Q0sq3LagFq/AxxGmABgYm6J4kcTPFugHad5JO1vqHKOpltFA7QhJqBNNB6p8owsZG2K/4LoyM1C3qrpGIwfgHhTEA4DKgDrhgfAFQtTgH/jlzgUwWRPP4mkIu4E8D2opKoiODB5sGqR6nTr2pKBEWE1FLh9I8PWgG6jFmIPLGCypfBKQeVCJ+nUaQq/lfF/echGD85YjgXAh7jYGuvGWQyRWUTU1BLryP+YKgHSFloRPrfy0ND9fEcN3/HuEYchEzP9x7kPSFKcHK19+3PZzsp2UxgwmCMk/xgtHymLCJ1rIJb9GfBV96HSx0Obvi9goaNra+rPFiZAD6oWh5SDv0QlXNyeFlQB8AtuVTeCooaL5rf/keLdxlL4SK6uMCqwI+kDWMu7CmCXX2WZ67JgWTEyTYYssqVZpj/eb7vRhe3KfYMWX7OtBtTTFiCtoqfx+pHhb48lRAXC/X44LKMqjZURLEByXylvacJ2qaRj60/ysgbEttufSQw9K3P0dnPKTZyY5Mc1LKE8nnrZjkhSzjoyOYXsJ284+TTdFk5o+zsLsS90hBXF/V2zXEPWiF3utTESu7YUq+cJ6R1c2uX8D0SkZ6E4Zw7FdoKne4YBMW6wIJdA52+EUAKQaSD43n1wmPtzxRjBmGV4A3kG0KxNB90hRHuzmOiNxD8n1r0uRg7j/Bpg3FPOeL85UElUrpbSwihfKmialGSWhihC7ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(83380400001)(508600001)(316002)(186003)(2906002)(6486002)(38350700002)(38100700002)(7416002)(26005)(6512007)(8676002)(6506007)(6916009)(8936002)(5660300002)(52116002)(4326008)(54906003)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zEMbj1rol3TqUBCfsD3wZ/EWqS8rR/pOp3UqrYwdtfdBAVww7CgRPqUSm4fF?=
 =?us-ascii?Q?vYLvMZjSVsUGT6RusXhL4vh92iNY+k2YDGP/5LAbhzdX82eViMwbDcwryZE3?=
 =?us-ascii?Q?DxA+PmfErsfjsQLUCeb5Cij7CSsOBWFqykQmN3tGLZWPQYljRz991uwQAa90?=
 =?us-ascii?Q?GK947P5M6Vzoi99YPHkijwZxIS0x/b8tmV1/gouNToA2yW+39TLR6kMRXmm2?=
 =?us-ascii?Q?N5Xtzt2TPmZWr2srTQWwgnJqx1a5FxrBY+XKafhODSW+NTmvHS8iplHrzL7T?=
 =?us-ascii?Q?Hhi03J9Ux8LWAi14ldRbuSx9dWOMKVouOlHT21eDFa+5wkuqRBYeJ5VeuBjg?=
 =?us-ascii?Q?M3p4wbITpRp1VYVq7XEfGzRxaPDKWRQmkIGY088r+plCDPeMvOzCUWx8VlTe?=
 =?us-ascii?Q?D6QncH8yKO1aO1dyXIRh8IpLAtOsGtuaMFTicEg4qgKbkz5MGs/2DiyqtIaI?=
 =?us-ascii?Q?OVUSEZvP9I/zw9fQffg9441wXfx/89hqA7kxJLMk4Z6I5py55GkY2OBiqXkb?=
 =?us-ascii?Q?Ig6a5Sf03asu3mTGwJXnd+dIHL61G8+8Tn23C1GaAOMKfDqsu8u074oSQMkP?=
 =?us-ascii?Q?4c4MtpepZHygGqJxikoLCBFWUKQCw46rHnbD4C0VDvGjiPi+pneOMPlhpvUQ?=
 =?us-ascii?Q?ksUKp57Qexjigb0KN9xKP+81BCfR6Z47uSsf51slgcqepTIk9dICAzMccwGh?=
 =?us-ascii?Q?L3qrXWcdlxWLwV+ACiiK8Fka2TCOe2Ju0OHvluFS0XrGAtzUjiLSzI8rsSfE?=
 =?us-ascii?Q?sL+QZhYDS9fWups3VLxG16g0qSQvdLxpwFJLj9f2amKphioCV2wcUq1W8SR5?=
 =?us-ascii?Q?RkOg4gvnA6A3Cj4aqhhlZ28zS2E5VIPe8Q1apn5URk3tKALNruvSPAgP/Ezw?=
 =?us-ascii?Q?Atz2B1OTdHN7CCpvWZIm0s9ZFTJyuHrnmp+kaFYfgqOTbvXY78Zjn0Y0XLv7?=
 =?us-ascii?Q?/aU4aE7eHmzNNYbC8+YpcqGE4oR330qP7vwmA9G+j1EPHQmBGAEiggn0BrHw?=
 =?us-ascii?Q?UNlvsmde6i7sm1R9u3JThyc8pI7Q1aWdvGpTb4DHP/9bTWDaUq/sIEgBIX2/?=
 =?us-ascii?Q?b8vk3s6Kt176zL9qsJEsFm0gj2l7wdnFeh5Egv2+zwrcPjbKnab/00yZoXJc?=
 =?us-ascii?Q?BUFzJUEhfKxUn/AVVFVfqhn3FcU645Ad0DafutRU/wzv1DvM7FnyPJYLxL1Z?=
 =?us-ascii?Q?+k/GkrS0lPu25j9wyPc/FTbpt4J6+OvuvThS0pSgFpoLhgxiPeIrGrixlMAY?=
 =?us-ascii?Q?rQwEIosQVe2GjqKyJzLJZSWcJJ2mx72QLs0S/IB5xpNEJFMxyQM0V6IFREfk?=
 =?us-ascii?Q?isEX0Gn+bZjFg/Sk3E+0Gi7qMhEizS3mNUL/RJfes6nkjfEAXYxOqktmwXWv?=
 =?us-ascii?Q?AMTTG3FixvsruU+r/bCDVSO2cggjKvdLcjOcGDwV5ktiAbxzfcIBOUMJtUcm?=
 =?us-ascii?Q?LJ49KCuMocwmLEyqECLSnEQG0YyZbZA8JacfEiXoNzWFpnJI4do2lPWRQcl7?=
 =?us-ascii?Q?3nomKX5eUxgewxIWDYPTorvvrptfhuMBbGywY46ZmoQyeUqC6buM4XhRlTxf?=
 =?us-ascii?Q?8hShJrvJ4BfEQxKCTK+W0+1S3B5Z3GTI+GX2nfOl1daXSP8fEvC6k06P9KdI?=
 =?us-ascii?Q?6KfAd4k5WEP9gvNREP+bm1Xaa9HVXWe4NkNOju+lX63yrnZ1MJxLUVgG1q5F?=
 =?us-ascii?Q?xwA46GmH2CjPV4/6dL6XxtHwum4OUTC1gKuLB4jL+RKabbkibTi+DrXxrUsc?=
 =?us-ascii?Q?4cT1mpZWYYpYThoQiO0a6PCXoT99Vlw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549f65b0-227d-4a31-4a80-08da3ce63015
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 18:00:57.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZy2gPd3ufjKYnm3vKITdTotC9Sl1bIa0qRtZ6NQa5KBimVafKjQkaMRSrSZaxlHrcbd+9Xb5tcXgq2GxlNnXKV1kRpIlrKZqfzcrtyoREw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2987
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_07:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=727 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230102
X-Proofpoint-ORIG-GUID: SaL7w5T4TTy9ucPjoJ8StLRLAPN622um
X-Proofpoint-GUID: SaL7w5T4TTy9ucPjoJ8StLRLAPN622um
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:
> On 05/16/22 at 05:05pm, Stephen Brennan wrote:
>> The kernel can be configured to contain a lot of introspection or
>> debugging information built-in, such as ORC for unwinding stack traces,
>> BTF for type information, and of course kallsyms. Debuggers could use
>> this information to navigate a core dump or live system, but they need
>> to be able to find it.
>> 
>> This patch series adds the necessary symbols into vmcoreinfo, which
>> would allow a debugger to find and interpret the kallsyms table. Using
>> the kallsyms data, the debugger can then lookup any symbol, allowing it
>> to find ORC, BTF, or any other useful data.
>> 
>> This would allow a live kernel, or core dump, to be debugged without
>> any DWARF debuginfo. This is useful for many cases: the debuginfo may
>> not have been generated, or you may not want to deploy the large files
>> everywhere you need them.
>> 
>> I've demonstrated a proof of concept for this at LSF/MM+BPF during a
>> lighting talk. Using a work-in-progress branch of the drgn debugger, and
>> an extended set of BTF generated by a patched version of dwarves, I've
>> been able to open a core dump without any DWARF info and do basic tasks
>> such as enumerating slab caches, block devices, tasks, and doing
>> backtraces. I hope this series can be a first step toward a new
>> possibility of "DWARFless debugging".
>
> Thanks. Seems no reason to reject, even though I haven't tried drgn.
> And hope it has no security issue, e.g info leakage, at least I don't
> see it has. So,
>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks Baoquan! I don't believe we have any worries regarding security,
since the kallsyms data itself is already available to root via
/proc/kallsyms, and core dumps should already be treated as highly
sensitive data by anybody handling them.

Do you know which tree this patch will go through?

Thanks,
Stephen
