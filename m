Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03C15295CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350587AbiEQAF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350572AbiEQAFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:05:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B6540E6C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:05:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKrCFG027282;
        Tue, 17 May 2022 00:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LuZP4V+9aC9pJkT5NK7S2meR1jMHP1rzrcTCRxI+ElM=;
 b=0EYDqiCdB05pL8lAnxPAtADNJ/xIz3D3y8JAlR39Up9l1AHkN8u9jSM4BNQelXqENSY8
 g3R8QENwGaHUNhGv2GPeO/TI0c31qnpuB+1fsBGnyuIFA/r9fr6M902zAtdFkRzqG1Dc
 efwuGfXlqFJGodtOPVSP8fCrhVQb9VzsIiORuub+buZP507Op2vFg8FqkrqJxFoeQWtI
 mnyJEYEJQUHIzUOV/tdVVUqrwn97QiB2IWI3Amsx8Pvu60ePvbXAjLDq0/oM72kussMl
 iRCEQlNxECgl0lguCeji8tjcbqPdhWeSjfynX7tX/uQ6VLPcJqpZHo4k4AleowAfE7/T xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371vt9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 00:05:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GNxvMu017092;
        Tue, 17 May 2022 00:05:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v2dfgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 00:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XobnPw4g3vK3jDA0+cEYFMiZAjUdsw5cPw0obg5sWZL7XxIHYkmJIEej4YKwvgdpjXuMZl0H8BvIgbpzenYpxv4uqL7olXi/sgmEGP6EoRWXKt3sWYMw+jQReNT41XF1HuAzfIMfDTmpsxF3VhcJ4EDdzryrwVAaFXxRC+wEJQtsX4Lfz2vMjm4rdh/r5QUlNb1Wtp/8jGJZSCb2sfeUelUmcb7VHRnm63pYsVfxTOEa4WT6/tV5UbO84hjGSl/x8DeZS/exi9oxx19MjGapx2wit9LEuNAGYiaqHtSiLUN8YdnJMrhmPf2yNORXMAXqRBc52FgU/Yi2v18+SRJDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuZP4V+9aC9pJkT5NK7S2meR1jMHP1rzrcTCRxI+ElM=;
 b=nRz9ZwKhUlYEvNNb1br0G06kl/ioXMWvfLFN5B2HLadFA6I0+pUPgQJnWWSq50DSQX4aeEautSo112HdIaAfqolUx3TsEuiLyqv9t0qpJ6Mh4eBBDVEs/oOoT4S/7L+C0bQPHXXcgx8fqyaqKEtX+hn2AzLuMVN92QfcZoKEf9rpWPVRuwpEQyJJDjr8qhvu5CIvsQwL9ct2zh6WnyDIOr3wv2KiMV7dQXear+zgdFM28yaYPt5lsqNwXkhMau71Ry7Thn7ALOOunJnAImRyihFT8MbftMbwGrc3MimDVUuPjnugdIwa1uJUaF5y4k7bR7mNq91qbZ5sG8UYftLRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuZP4V+9aC9pJkT5NK7S2meR1jMHP1rzrcTCRxI+ElM=;
 b=ioebWqH2CowqZNAtcW3Dfy0vxovUqWsHJlOEsKmbsOH/0+uRjsHD7nqYY0BNlMWjq52gE2jzF/Pg4rmsI9SPgWe7vKjbMdgJvT0v5qBBTwsuiAmmFDF5941xCLU9VH8vHIyeSoQI9yLx2l4VwddC2HPAmAY9cUKsuEL0b5kEUU4=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SJ0PR10MB4783.namprd10.prod.outlook.com (2603:10b6:a03:2d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 00:05:10 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 00:05:10 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        David Vernet <void@manifault.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH 0/2] Expose kallsyms data in vmcoreinfo note
Date:   Mon, 16 May 2022 17:05:06 -0700
Message-Id: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b0214f9-40ba-4093-07aa-08da3798e855
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4783:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4783FAAE4F65AFA210D8F7E1DBCE9@SJ0PR10MB4783.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXJ1C+IvXOpfLvTYdEp9AnXq5iM0SsbQHFjFJTZjO8ZNPTR0Q11mE93t3b625J/wtsCFa7uJynH12S132qtLLj7GHx65wiP2glcMohECVYmGKo1Lrqef18GG6MK2HQ4exKSyE9Dt/KLEyEv7UconYXa0CGgVIiVdAX202OLrOj79DlhWh+6rYVksNCbL7neb8M5cQAUQHRj2QusVlN0IV7BbPZQnw2j8Osaz3bdcrYB/R/oJj+6N1uHguujX7GterrHIwL7oFCRYnC46flVpFhfAXUjBkm5jX/SXVPDm+SO2HtAbLXVfeZMMbIlFas1FAE1NQjrBX4H5HNdV2ZkDSsFVYUufwF/MfY+JBo6B5Hk5Ha8kEChmVue07v+3+mRjFAb+loZH7KdLctkV78niERAqKB8haDvdPHigVkJhhoMN5Hc7gRINpSATyWPyPZyP9CFWlgZxamexmHA2RzV83pjJkm+gTIgGbdpyY/wxI8o7I8OTcOtS9STdT7iSZqz/YltlYvBWbCdjDMxN4M8Yg3PVaa+0XhNCy5oM64Mgdua7mc/jEfSD3Xm8TwuzBcq5a4FcCd+btLQ4VyFF3REksnz5U1Hye0HLE+AdqJojwokeE9VCE8HsNPmD9BkQtA5NFWbw3fBEAknWsyaNA3RkfGNFWJEMQ9sE6Era9om763loFTbdGxynt0hl+kTWRF6Nb6DmcqwnWCqY5rSqRTLAC0oWLVPEmJyhy1tolPldG4wo7vz+PYb40M1nPcA9EHgMTwnBT4PjeiaDytEEY4oEv4oldYRAu0l1LDWXUCqrwCX/FnYWLQvOHH1BhNJSplq0M4xvTvitz3Jgkaa+VZjSwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(4326008)(66556008)(8676002)(66476007)(66946007)(86362001)(966005)(6486002)(508600001)(8936002)(1076003)(186003)(6916009)(38100700002)(38350700002)(5660300002)(52116002)(7416002)(2906002)(54906003)(6666004)(316002)(2616005)(6512007)(36756003)(83380400001)(103116003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKHEWosWBkSbMDRrO9oONiBEuX42tjDrTI8fzjNFK+BYuJumtw2vW2KarNH9?=
 =?us-ascii?Q?hFiG5aT5/i+3gvRx1cg4wTmSMLy/xV9nLrmn7mdAtaSTDsIvyN7t3CYmIV6S?=
 =?us-ascii?Q?xwUrtYLBp1w5Od4W0rPQD69/iotRKuw8j3kvn8OLpzR8QuvwBsqXJ9RY5kta?=
 =?us-ascii?Q?334cldXaXBvKU3Kx/wqba/7V6wfKV3JWBVHpL0B2k/iXtI+//w4WfHN0vMeg?=
 =?us-ascii?Q?ZjghVZN0BNVS3h9y4og5N+I+6jYYlwhAf6M1hFWi0EWnrFDHbrUl4SfN5ZQg?=
 =?us-ascii?Q?jwZR2sqHp3ZpvDNtT6YoRgmRbJ/JNOHVTpHKa0o0nh1vMK9/Fn+GLGLM0jnV?=
 =?us-ascii?Q?ejxlA7EcCOzQyi8wMqXa2PhqhWrFQyeZGo/sEz6bNWJVQ0gITe1T9FsFKPxC?=
 =?us-ascii?Q?KNp3bPcKrB5gIVEjDpGLn1N3SZyJFGO2qQMPmnG+j7jRIFUkZVkniT/l4T2C?=
 =?us-ascii?Q?2uFaL9zNykl+UImQh8qhJMVGEjFUoUDVpXATvE2orjhuzdEKMKwfQTTRDKSW?=
 =?us-ascii?Q?j2ZGILhpqAFdxB5EKL9Yrq7nZEOIkqXpc1n0W9Ac7CqFBvcg+cavaJdMI6Rs?=
 =?us-ascii?Q?fmwLWmkoRc+Nj+YulvEymFGsSmL1kdv67bU5nD08Eqr1+0DQXBtKW7zySZII?=
 =?us-ascii?Q?aJhFb8ENwMFuKmlcUsnD1f23TTOp8jEU+CdYesPU+mIyN5xMO7HpJX+KKdb8?=
 =?us-ascii?Q?55JflgRDmYJ2HY0Xm3b6n3a333iFjXZonUuPqpyRCOkLpqI/J3dK3IVZ5yWX?=
 =?us-ascii?Q?N4g2k3PHkW18bIPaNLAYBSy8CwxJir4ZqCjvTF3dugNOfnuw16us/7yFDA9/?=
 =?us-ascii?Q?ZL+PUgZdR2INE1tPJJ1KG2duaVb+OeT2ZWwf+9qtfVTNnhRQR4h1U0tmLc1w?=
 =?us-ascii?Q?Q++It+RcMdFHco1uYkAjAJNi8nfRSfsE3AEKLdibdyqCKxLpy/TZb5y9sr+c?=
 =?us-ascii?Q?0c+/fwXfZokug3cK3PXAEbq36myVLwMt+sLw9AG728LoFUYUTRGPDThusB5h?=
 =?us-ascii?Q?+rw2tM2DudVfL+G24TjRnPSCbRXakGj1vBHLBcdCGNo/LAUsiAlsYIvbhoZ0?=
 =?us-ascii?Q?E/okeDwgK56gbVVAdIRyybuMtetR7sms51uumn5KO3WnM1FDuyl0aJyC/6HX?=
 =?us-ascii?Q?6QiaSqL0x/h88JBpEtDFK2+V+8U+i/7Jr/K/zVA3twtGtELQYKeZ63g/TbyL?=
 =?us-ascii?Q?Up3+YEg+8E4sIch7G0BeiQyTTZw9yhMHxJ56l1ybOGZpeplfxh1AnosfcC6e?=
 =?us-ascii?Q?U50z1XRaL8z9Co9APYa81t+8yT2OPK1J3XJKAc4D7l5xDJQpzttItNKWU4mi?=
 =?us-ascii?Q?jq285qml/eosn1u1s1yQuoH3qynOYneq1IoioNBBr7LPROwbk1qbtZJynBrp?=
 =?us-ascii?Q?t2UYWGsgwE8S6nkgR8Pji4HQTuy71xByacsROBkmh6J+CwPZxRQQnWfBqyG1?=
 =?us-ascii?Q?3w+eNWqqI1oOai7GA9w2wqljC1gMekOCnhL0OdqU+pNqG+jksSJHixhkmgYO?=
 =?us-ascii?Q?vfKaecbYErkwYAD4F/Bauroo02dG6Bn6zeqsvmt+NBbNzpJOs3I9PmIoxMHB?=
 =?us-ascii?Q?1egwDLuP/1xPtDbIyUrfU+4kIVp5WV5q5NbJZO+GaS33s5qBBY6SNnVhyGti?=
 =?us-ascii?Q?c0Ttj4R5IArMlE2iOCDssCS/Tay0WY014Q54YbfEj8rg2zcLleyBTHGLRzoD?=
 =?us-ascii?Q?j1gHvf+1Wcwd/Vo1SQXShNFh9LyMgGpybOC7RJalAI7nL/l3CcMGCiKjuILX?=
 =?us-ascii?Q?K6zEiABmjO9zolF8s8MfNHJ0KVRXgH8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0214f9-40ba-4093-07aa-08da3798e855
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 00:05:10.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y03QpWcx8XS2EkGVraAy80hMJDg47PDA+j3QXrZcy+FxlyS/xQH2gMKYvnf+IZq9ntGRv/qeDeX8+IXg3ndQ9CBaVOC6vLUllWQzB3aA0qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4783
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_16:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=703 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160132
X-Proofpoint-GUID: tYKDuQbW1ulR9BIURudeZkLj4FKCT7r6
X-Proofpoint-ORIG-GUID: tYKDuQbW1ulR9BIURudeZkLj4FKCT7r6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel can be configured to contain a lot of introspection or
debugging information built-in, such as ORC for unwinding stack traces,
BTF for type information, and of course kallsyms. Debuggers could use
this information to navigate a core dump or live system, but they need
to be able to find it.

This patch series adds the necessary symbols into vmcoreinfo, which
would allow a debugger to find and interpret the kallsyms table. Using
the kallsyms data, the debugger can then lookup any symbol, allowing it
to find ORC, BTF, or any other useful data.

This would allow a live kernel, or core dump, to be debugged without
any DWARF debuginfo. This is useful for many cases: the debuginfo may
not have been generated, or you may not want to deploy the large files
everywhere you need them.

I've demonstrated a proof of concept for this at LSF/MM+BPF during a
lighting talk. Using a work-in-progress branch of the drgn debugger, and
an extended set of BTF generated by a patched version of dwarves, I've
been able to open a core dump without any DWARF info and do basic tasks
such as enumerating slab caches, block devices, tasks, and doing
backtraces. I hope this series can be a first step toward a new
possibility of "DWARFless debugging".

Related discussion around the BTF side of this:
https://lore.kernel.org/bpf/586a6288-704a-f7a7-b256-e18a675927df@oracle.com/T/#u

Some work-in-progress branches using this feature:
https://github.com/brenns10/dwarves/tree/remove_percpu_restriction_1
https://github.com/brenns10/drgn/tree/kallsyms_plus_btf

Stephen Brennan (2):
  kallsyms: Move declarations to internal header
  vmcoreinfo: Include kallsyms symbols

 kernel/crash_core.c        | 14 ++++++++++++++
 kernel/kallsyms.c          | 23 +----------------------
 kernel/kallsyms_internal.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 22 deletions(-)
 create mode 100644 kernel/kallsyms_internal.h

-- 
2.30.2

