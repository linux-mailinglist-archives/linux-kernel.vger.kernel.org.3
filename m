Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1718A48C8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348372AbiALRAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:00:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10892 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343508AbiALRAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:00:05 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CGxK6j031716;
        Wed, 12 Jan 2022 16:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=B0G52I/SlxvYeMuG4dQlJbJJDygjOoodlOpP8NNH8lc=;
 b=vaha237nfaQl4TERbZEpJba9a68cuhEAaS7pgdrryXeZngWbqLwaHHUISawHuDPWoE8O
 YXHQWYxhM1L6xQ8E3NnQoTM+H6oE8ZSahEEo84mo+6w1rEgCcw5AD6xSvaEcVYPz56sN
 F93E6uzIgs5QdSvjMJfi/99i4NomUV9bc/u2YCGbhXlzi2gYa5jyvPHMeG0fNRED5ksF
 KQt/HCWPOA0lDNASkC+SpEiMbNKYPFTCUMATah75B6YOMmaXH+xm6LoSJQl66alMS6Zv
 OMoETuadZC1GhnWUXuX1FSNb+hgCbSVy0sbJdKaLwCAwirVh0IBI81vcRMyngh/ghB6j Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9ewva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 16:59:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20CGkC8F068798;
        Wed, 12 Jan 2022 16:59:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 3deyr06rvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 16:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxAOxx9PL1PdW+ioWphnaFVlbYlOSLpoS4xS6JJJwU1SA59MsxRVanABivfoCPBwpmUUTQ8Rqs1rrIeOK1W0Q+iJZbF0RX8Fd7Coy975abnJPTrOI5W0IgK5VWkzBeST8AB1/crFa9iYTg4KbWBOLiyENrjVEzdShZEtrcLPkkRGpH8FbnyWHOa4wxZQl+XwodGB3Qx5TPX1yoCYQ20bjPE+qOYrRLtJ10ODtFRAYrjZ66MeTe5OCXibNAxZs4AtoKmkv3NDDzzNOJbRam7dLXYi6mqACD59hteGqus99LKXyjdxMBCYVTE/9ZYfz4qnCOR3hWF0Nw70RYomLB1Vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0G52I/SlxvYeMuG4dQlJbJJDygjOoodlOpP8NNH8lc=;
 b=ApFtvRqV/P9EhG3BOzckxnbHLwqDz/Z9n+dzfcoiRzeIcgwMXAumlJRF8FDMUyXc/l8AMrulKiD8pyZb1DHsYZLbE2QsKh69xxxclQ17VJ1ZqlnlgayCGnvx6SpiaWH/GjLDFZnVbL7sTz1kPSwVjZeuNCakj9RFa+ORdJfC8H5LrSxNEe71HI1r/L4MJ7XXWdw4eAN3eyn5WaVqDUaEKuTr6NSWXvjQPwTXDNIpcXljvrI4C+P/Pmh52TsHMJfoBL1Dsll+K7yMk45LOAfVg1AnHtZ2xqiZD/tu4XTJaDdWg85e7iFIhaX06KEhuyqUNXAybNIDvehhKgH5rKsbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0G52I/SlxvYeMuG4dQlJbJJDygjOoodlOpP8NNH8lc=;
 b=di317b7lB5SuZ4TE1cEtdDMSubPL+D7gcTqk1QESKGcY8KES+rbUTBk08GcuUHzvQ/EKdgnFcMaNa7x+ap0qrcgIWAZEQ3P5PE7U3z7OsdRLEE2JEZNNlI3Ge4OD6Hb/CVMyICu14fVm4iAn7rFo3I0EJZ602GiZ4XTn655Rcjk=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2973.namprd10.prod.outlook.com (2603:10b6:805:d5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 12 Jan
 2022 16:59:50 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::4dfd:8b95:8698:6e1]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::4dfd:8b95:8698:6e1%4]) with mapi id 15.20.4888.009; Wed, 12 Jan 2022
 16:59:50 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PING PATCH v7] kallsyms: new /proc/kallmodsyms with builtin
 modules
References: <20211216201919.234994-1-nick.alcock@oracle.com>
        <Yd8CDJA0dy0VaXrB@bombadil.infradead.org>
Emacs:  the prosecution rests its case.
Date:   Wed, 12 Jan 2022 16:59:45 +0000
In-Reply-To: <Yd8CDJA0dy0VaXrB@bombadil.infradead.org> (Luis Chamberlain's
        message of "Wed, 12 Jan 2022 08:30:04 -0800")
Message-ID: <878rvk7uv2.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::22) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d152cbb8-94bc-4220-5cbd-08d9d5ecf25e
X-MS-TrafficTypeDiagnostic: SN6PR10MB2973:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB29737430B75F21A7B1731D2D8B529@SN6PR10MB2973.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYly1P4n0imu94fmupuRU4lVIBF6Hl6Da+drxRh+OG5aBN3wGw2nd5Tz6eQwR21NhXzCLvEZ2EPwMa0zbOUeFh/RE31BIiV7Fw78frvlUyQTvIh2ID0INnQ4WPNgUiDp++wO/qpQjQfZ+NTRnP5GrA5cLmONQt7oLuAr6IHd9LDUMNz+7VRgzm26i8nCoRCD8koA2LtiPDYLjFVnKUd/pGiIq9GWY4aRTDKC+QPAHIb/XmB5kEJmuKxDBzH5zBM9nnmfeAbOoiVY7etnjziegrjjFjH38/8I59/i7q0InLPALANk1nI90jmk9M4DG+ZUpMjfEBiNDKDAmxJKsnoyIdoQsdeOtyqjwhCnYDF2lbe09Lse9EVHkiBhn7MjeT8ix8JNHFN9TaEXYb88px7tKS2LuA+VVRAzwpH0w2lQIlJXw/cDlKS3Dxcpg1W+srmqJDSmxEC9UGcrCOUXjaNMUKebGGoiIovGHvlQGPelx9alHQPRRNXrcTBEALLch3FXpk5lEfOXWGwwh6Ms/daFySmBK7AdYK2XQsx7Bb/nB2E7O9ORijQaHJXR8QXOzhBq7nLcYQzM/l+2trNkAMmp68ig4R66RWg7FpzlFVYB/nzy58BG1ArOXjKyUy4F/XtWG/FBZaW5f/R9L+NAJgMhRd57NGdxwbXnEruumGswmM+zKXBykmjLtz0IJvM07n0kjazs/TEpEXxLEYxsqQoLIhc1iKxPQucePG0e3MBQwAqRFhahp/96j3PP8djPIZLHHpePnCP8Cc2giBDd93UMKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(86362001)(36756003)(44832011)(508600001)(6486002)(2906002)(6506007)(107886003)(6916009)(52116002)(186003)(8936002)(38100700002)(316002)(9686003)(6666004)(6512007)(5660300002)(66476007)(83380400001)(66556008)(8676002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zheDk3MuhBmBZl93YVQV5mwa8M0C1LFWmMLc/ms2QXSky4GQTPMu9S52af9F?=
 =?us-ascii?Q?D8WSM1s/Zfg2HSXCnC3UU4byDn2wavJNDlWHhSmi2bl8AN79Jo+8EFHFwhkk?=
 =?us-ascii?Q?5aTGqR+x0JVs/4CCXDuMC/DvXQXhYB3Kk5fZxsobaD+ngq4gRTWK/HsDOI6G?=
 =?us-ascii?Q?Twnmx+A86gkE0B7vrIyUewwer6mEDmNVu2+vgCjihUKwyjHTzN0rwxTnpV6X?=
 =?us-ascii?Q?wQLbsqiVeQ9bphJCvPx9r2keQV00/UnrigiRxYEN3R4Y23qFIXSOxGkHCM0D?=
 =?us-ascii?Q?Dby4YjbGsifyA1KDTsXpBnPFyS1z5GfSCBVMFelCsB9uZtUAyuZJ7yJUrvu3?=
 =?us-ascii?Q?M87kDqEQKOnh783JNsaEcNNKIvCI7QJohpGb1iVt/RM2xFzd4sDl1UbmSYts?=
 =?us-ascii?Q?XZ14DcpEtS1Zkq1wJrzdK6+j0VLFcYOn5vVl70G5HcpYdHaMNRM19i47uCB7?=
 =?us-ascii?Q?LPtJzUmlyLgLahfiAjzRQh5isbNetp+ci4EvvVVhzq9kuZBIIptphOrgQRWj?=
 =?us-ascii?Q?9CbjIOOJHEJOsN/LWw1cMX+WOvgSUeH5wlg7CkVLjGK5EhqLG5V5JWAVbG3v?=
 =?us-ascii?Q?VYCJiTLmqN+Ggn7gRIhwYy7rpHUCpnxqT2AIW4tVKIILZ3hCU2w0v3RSgfzP?=
 =?us-ascii?Q?YoJwVf9XGBBvVn10PwH6U0EWxV3W6rS8mVany72KmcbnSiyEzkvecG+q4zcF?=
 =?us-ascii?Q?fuwb2FSxcK1HBA52SN5Iqi56YhNfwmS+Ih+8nCJiF+rSDM82qM5riOCfg1qL?=
 =?us-ascii?Q?ikdNHEYxqjFACj+7etIsCA5hAjUMC/tvcw9wu4yXSiBHM+hI22LBEjo+f7gO?=
 =?us-ascii?Q?t25PNbLQ5L5D07FUmrIWf9/mBLAW0tuisLfdGC7+PCd+sY7Wq9uj+kbwx9UG?=
 =?us-ascii?Q?8/aywuv7RcY4q12E8C8tHDDpjBqLEHnE8OUtEVeuqr91qxolrCE99sA080kb?=
 =?us-ascii?Q?oj+BanJ3BDFKz0h29KaSoodHjPMrm2q1Lxh3NT8jyZTI9XZEVaELH4H3BbBG?=
 =?us-ascii?Q?T27L2y8a1HMRVCTIXJKeV9jogayRDIQoHssu9QzZVSmCgbFJMeHBK+omvkvI?=
 =?us-ascii?Q?HyWOgOts3WLrNuR6D3bNniRnXnyppguTuMvpUWixum9vIGfNRiiUuBHeswmE?=
 =?us-ascii?Q?1rI3+bUlLwEoTsDIJGJ02SHcQsMNqnA5HRQ9FbUcudXHd54KB38Xqc3CM2jV?=
 =?us-ascii?Q?2v5LCstvhdYv2QGMqUuvBv73zgSP8LVHNCY5qUelt7M+mL7xQcw6y3iJf5ss?=
 =?us-ascii?Q?qDFzkuLhRS9fviLdnrLl79ZUWrEoOeXUMDGEXVP0jyXVgoSb8E/ZvT4o8CD/?=
 =?us-ascii?Q?Vd7RTriFNBMzEIVjP8Zk7Qn4c5kK/Fo5gjHEIH6uuEe6dlPa2Glz5KrC0xXl?=
 =?us-ascii?Q?mcNVj8P1HxnwDwUQBWI7u7HoKyi3XWEWcpoWIWnyy+ggrv2+ZBoZHjApIfAY?=
 =?us-ascii?Q?/HHjX9HmzZ0mTS6+B4gLTAedZEhtgHOX+jqHbUSU4cBM05YIhCb1hg/C99nv?=
 =?us-ascii?Q?nD0Sy7r+Bst8qk+NLjwl7BlwkIr5jqy67NiFuGQVsiI5c8QA5ia7gtWL6UEf?=
 =?us-ascii?Q?IUtbjvVGvt/O60P9SmTxEQ9ZACh+Oeet9Hf/PG6Rjf39UHAUsw3mI9HYbAun?=
 =?us-ascii?Q?KapO5cUu+O0vARcVUqoi4JDGjosy/vWVfNXr3xGo+rxP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d152cbb8-94bc-4220-5cbd-08d9d5ecf25e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 16:59:50.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRBraeWBjZAzU5Jw2wj8z01YdqTpB6GpoJxgangrVk5/a/aQomhU4/i/O6ZV+LPJDAHiJs8WklSFUW8Z3iXUKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2973
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120105
X-Proofpoint-GUID: MuRgxsoxDSwBNgj3h4Jq2YyC_zX8Bxad
X-Proofpoint-ORIG-GUID: MuRgxsoxDSwBNgj3h4Jq2YyC_zX8Bxad
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jan 2022, Luis Chamberlain stated:

> On Thu, Dec 16, 2021 at 08:19:12PM +0000, Nick Alcock wrote:
>> /proc/kallsyms is very useful for tracers and other tools that need to
>> map kernel symbols to addresses.
>> 
>> It would be useful
>
> It took me digging on archives to see to *who* this is useful to.
> The short answer seeme to be dtrace. Can you work on getting use
> of this for something (I don't know, maybe kernelshark?) that does
> not taint the kernel? Last I checked using dtrace on linux taints the
> kernel.

It hasn't tainted the kernel for at least four years :) v1 (with a
kernel module) has been GPLv2 since 2017; v2 is pure-BPF and has no
DTrace-specific kernel modules, just using some new things we have to
add to the kernel, most of which seem plausibly useful to others too
(kallmodsyms, waitfd pro tem until pidfd supports ptracers, and CTF).

This is not a DTrace-specific feature in any case: all my submissions
have noted that it seems likely to be useful to anyone who wants a
stable reference to modules that doesn't change whenever the kernel
config changes, which probably means most tracers with support for
kernel modules which implement anything like a programming language.

> Without valid upstream users I see no need to add more complexity to the
> kernel. And complexity added by tainting modules or not upstream modules

We don't need any of those any more :) Even CTF is now generated by GCC
(once GCC 12 is released) and deduplicated by GNU ld: the CTF patch will
be only a few hundred lines long once GCC 12 is out and I drop the
DWARF->CTF translator.

> Without a valid non-taining user being made very clear with a value-add,
> I will have to ignore this.

I hope this gives you a reason to not ignore it! Have some links:

DTrace v1 (maintenance mode, fairly hefty GPL kernel module, UPL
userspace; fully-functional including fbt, kernel side will shrink):

  https://github.com/oracle/dtrace-linux-kernel v1/5.15
  https://github.com/oracle/dtrace-utils 1.x-branch-dev

DTrace v2 based on BPF, in progress, some features still missing (UPL
userspace and a few GPL kernel patches, including this one: needs a BPF
cross-compiler, which is a new GCC 12 target):

  https://github.com/oracle/dtrace-linux-kernel v2/5.14.9
  https://github.com/oracle/dtrace-utils 2.0-branch

(I'm going to respin all of these kernel branches against 5.17-rc once
the merge window closes, and bring the things both kernel trees have in
common into sync. I'll drop you a line once that's done.)

Config-wise both of these need kernels with CONFIG_KALLMODSYMS,
CONFIG_WAITFD and CONFIG_CTF turned on, and a kernel built with a 'make
ctf' done after 'make', and the kernel source tree available when DTrace
proper is built.

-- 
NULL && (void)
