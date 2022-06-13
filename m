Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFBE54A22F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbiFMWmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbiFMWmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:42:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE70931207
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:42:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJda2u017692;
        Mon, 13 Jun 2022 22:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=vLF3thUbn0K1YhRgtyl393hcuNQ98uyjzOFg6cgyLPY=;
 b=LSYxVheeEiOxBI3Ew9nMCEbuwP5hHD7v5LI3Ubpio0fuCMcHhQVh3CR2tXxkEK4WVfoO
 /EorvmZGXaLnZW005oQcJ1VX6jcg6yKdC8OGfwlciZjVS2i+iZj4jDdVbUbmjLvkaz1F
 EOwhmKi2GiaV/LOKeTt5g+8cOc9MXZYaBCi7E0AlJiaXRld1QlKfdcvuQXvSjUN1NhVa
 2CurK3JDPgAOdyRoMUu+ZBhRFYDT3/Y1aACcl3QXVqsxt1Q4oSqpKLlvaHmuGj8JmeGz
 nRoAcATWzq/n+yNVQX0sLWPSAzWfrdOOz+wfSdyEzR8iJvpF08UKoCDhoMIcxaO2Qf/h Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcmap2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:41:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DMfCUN015394;
        Mon, 13 Jun 2022 22:41:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpe88r11y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:41:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja1vaE/iZJzd+DMqrSyqIMh1L3TfdZ5b226Fckh8eTRn/izHOrrsf2Uj+ZlAefDn36OeXGM5PmNMT0bkym4P+kCqmoonOIioJTBWMGZddx2JGFIUjJwJKq7wDFcSBrydb++VjCui1tmSX5hAkiQEhCn8ZcHOVK6VvPYkhX1w9C+5djKA11qZUWf4OEDT1JT2u7eHzvRR9hNID6bIA+KaZu7rFZg2nZ5ObY/aj6fAzeYOzXYU1EumlRAoc2zwUCV8gjeQocYxy8DKTfft1EfAQnXHG0WyzCk65tgMfyduPSZeURegpao16NGJqOrL5+ZxOVCU2qXD5nCl1tnYgY1s2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLF3thUbn0K1YhRgtyl393hcuNQ98uyjzOFg6cgyLPY=;
 b=fJ2wWInPm6QvWe51J+Y4BsG8tJ3Yqo+T83Qz/eZqVuAfWBMRxx+kvYGytPdyv4qA38HhqGs6oT4ljvn7rUm+6WPjWlr/SBpoz0iusKk01zEXf62S0LwYaFBNZHobcj5UOVjd17eVdJdJUlwEhYGYMqmomsrDEX+dUBCUy4tPoSMZQavlTyrEtRT0aRD/2IpCdWa1KnhUdk8qFe92hu8yLt+HyEkq5VF5ZJXWEefm+fLHgtnznpsITy+BBdUIpAAYINk+uxo1dMr5ooA46KDuQVsC4pzBmkRTvheXRxqyoEF7ToxiZOLZ5oZQcKsaMWWIDjsQf+5LkFDEZ8H0nlmfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLF3thUbn0K1YhRgtyl393hcuNQ98uyjzOFg6cgyLPY=;
 b=W58FZ9vmoPEQ7FC+JGOQfld56uIcdUw3SFIlwClaI3EE3rny9icEwD+RqXbGZltXiSQEn3Gplm5NkqZWg7RLGOSt1C/7Z3I6FUDDcgfnK6BdDK6L+xzQ+eWXiQ8TCgAuLiHCDWqo/SEMcgd6MesWXjm93sGopNO3HorFc2IDyz0=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BN6PR10MB1700.namprd10.prod.outlook.com (2603:10b6:405:8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 22:33:38 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4d84:324a:aeaf:8f2b]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4d84:324a:aeaf:8f2b%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 22:33:38 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
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
In-Reply-To: <20220613151422.e2173f14909b9149fec8e0a6@linux-foundation.org>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
 <20220613142609.3e4be0f2f45671341450232d@linux-foundation.org>
 <87edzsrzqn.fsf@oracle.com>
 <20220613151422.e2173f14909b9149fec8e0a6@linux-foundation.org>
Date:   Mon, 13 Jun 2022 15:33:19 -0700
Message-ID: <87bkuwry6o.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::29) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e530a24-994e-405c-6e75-08da4d8cc28f
X-MS-TrafficTypeDiagnostic: BN6PR10MB1700:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1700F3C50C8B6B06C6EA9BF3DBAB9@BN6PR10MB1700.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3M55ggHpkvl4kzq+qo4dMP/o//5kqps/CDuazRgthk9iQfVAK76jJ9r2fx6+LAyuDzmgM58dTO4MAT3ljgRNh1J9vCJB3K/hJ6t/8xp0g4APbMjowGL2oh83UKNSTHQuEvxEgg537TGgPoFfibUjGmcCD8WePzHu1C4O3cQakfdL3Z8tx0BdQc9slds36yabqKUfr/Zo6v4wWDi9sfsrcKE9wVSDv7qZoVq3Z/4/CO85LCPG/RUVsu3kRvS//9Zftn1wv5yCvN7NQuQbUFf7DdWjMBnTZ/YJ6Ry6nlflOM/xm16i1ct0MPjv2MNLZ6hXVk7EAcbIDLAU3D/ksDlmjOf3PdAuHgTrkWr3lxFtZGd4ZxceH/oHB6Nd/VWJKydiSV4n/sBjBqu4E9u2dbreA1jmkcHJm1chiocyj8N0mjnav9QrKKmca2DfNXrGPIejXFkE7OZBzywgQRlHkj2sqK1o6ZSywxzyVm+c9iY6XBKCoclygtjqs2fS/uEwtSumKJODoam4xOHI+Pd8V7rgvwVAGFOxMLo3QlpnUxHzQ8kyHbr0fjmzZ8CK2KNrBDrqeMoQbFyfFvHuC7A1Td248EqI8lPRlK1U/8ZqSejuC+uIk8rSBvuwZQA1VoP7jW5yIhmUAV1IiONKC42yG07ZAY0ZlLLWlUMAUpupEmD/ZjriMyE7BK+/2Qja0qu1yU48t59nO9GdXnINXmfP3NQgSlkvVtF9v0RGc/7EHv2ZVp9M8fxyvJ5RUuETIpMh09NlhrhY9EnZ+oCsZV98RLIhZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6506007)(26005)(2906002)(7416002)(6916009)(36756003)(316002)(6666004)(38100700002)(186003)(6512007)(8936002)(86362001)(4326008)(8676002)(66946007)(66556008)(66476007)(6486002)(966005)(54906003)(2616005)(508600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IySL1i3xkNC1C94iZqnl/ydC4NUAvVHaBicmAz6nFSLDDNoLs3v1Kn+HJ1X+?=
 =?us-ascii?Q?vtFErhCgGv3ktpcZS/4uqZenW1vnWCGz/GA2Mdb7esvyWZgC6Dlg4yOao4Xb?=
 =?us-ascii?Q?Y/J6QIiQsDxNtJogSn9bUctUvCL6e38TwINK0H+CquwiyrOuxoGNeDMwtYXy?=
 =?us-ascii?Q?L+FCmdCM/YBQ6wtfC09dMzibJWOpCCgx0SQKeloSP075bdgHBiagHug51qKz?=
 =?us-ascii?Q?uQ/SYazBZ47c0yBRXAiL/0trKp4SF51YkKVPBbw924AJW1Hz3d/CCfG5ZJTE?=
 =?us-ascii?Q?Ut70reowIFGmav14VDjjjlHPuVbjzLQiZlhsvIqcYJGtEmBIDASQ+Ahq5c3n?=
 =?us-ascii?Q?hIkdRvPrJzoxO4zcP9mgJ+x+Jkz4wWNL0hTIquS7ClGR3tNbSiUJU+bPGj5S?=
 =?us-ascii?Q?n+pz5OiZa7jrSOD6Y+GrQq9Pc9Ob4wuJzG8YEmY4Zw5UR3p/ys0mj59ec4DI?=
 =?us-ascii?Q?aICOs8WcoB70gupyglgdq79NiTXpglpuVzVe4PAkfCusPuiE/5Urt/f7ux4E?=
 =?us-ascii?Q?RgDK5dzn8Ku0nJrXE8J5UpvUjD0itCTxWHsTz9noLMKD1wdG0fPjoGz04drC?=
 =?us-ascii?Q?BMA7ryORjOBLgFe6bauwqgQJNC5sFtkQ9Q7VFP+r+jHWMrU7G/6J4PY3aj3/?=
 =?us-ascii?Q?Tmw0A1Aum6FH8GF+a9FjNJNPwfujFhtWZFLLwNb6hqEIWw9zjILYnN5IVodo?=
 =?us-ascii?Q?P/2CqYKU78VRoPpTxwewWTAd8+suur6nJWj7MHE/fA2w8ocE4Ztf3gdY08aB?=
 =?us-ascii?Q?0NBSGrcVR0I3CCgbeBQ/1JW//xPLlBxdoKv8xtzMwxfWrAGszvXag0s2Rvv9?=
 =?us-ascii?Q?j/MquLinLGE7Snjnln24WIKvkAdoNw/QB3I1t4W5JSoYsfW6TH9TGMAKBQDR?=
 =?us-ascii?Q?HGwNHdz5nnQq/TsitAD9mQOEOMzRAKHdJMOUHyd2eRUzcr9VdYULKJnRWy0c?=
 =?us-ascii?Q?4GOAqnGWjqOHylOrCkM6rvBLx/PI5wNh2mSCzEMktTWxRV+zT5DEWlgQ4Z73?=
 =?us-ascii?Q?cFNikFAVogrX/FziXnGFTC2/O6IrQW44zlG9S4f//pIdrrt0mTPyLfcbSkF3?=
 =?us-ascii?Q?NS0Z4aQB7Q0a3ESuqbm+OhvlEO8astSKwGpe3u+JhAjW1YqmqM/OqVy5Tkpw?=
 =?us-ascii?Q?XkE7EOSK04fSDqDlDy8chKvItdtbLBf6bJawR15sI6S+XJ9VkeMQS5MMiZJb?=
 =?us-ascii?Q?Ia9Skflsw9uORyJl7opMwcTkiNi/+Z6onja7ZjCP5NCNglJ+0h/ZfmgjdVVH?=
 =?us-ascii?Q?U6Z/xdGjx+R+atxG7LDFYIbxcZLVWGRTY8iRnXuw3Gr0zq2s55lvqtsrMTNp?=
 =?us-ascii?Q?QQPOMU812C7l9bDDw5+r0P3+s0CmcZ1eMSYmIsBxm+oXVTFlHNEMsTDDN1w1?=
 =?us-ascii?Q?47z6cRBM8yUufA51YBKUsVTHC8bR0dyL2Nf7fj5eEBJNxDCu1jj//JtpbDCx?=
 =?us-ascii?Q?2OUj9BawR7E1/6sbbnZUzZxWJdTfTgH9AcSmCplabD7yhvvTRzZFRNTNzslR?=
 =?us-ascii?Q?Isc9Gep2GaodOZE1wErMXJzi7bnFqAtJ1oZP63k8RvB+yewzlVi7XdkNYKwu?=
 =?us-ascii?Q?OrL5+vUqI1oXiMnwW1X/ivCdtBMUsQZeUQXDVWewLhJGfby9R0SeXR8PrxQq?=
 =?us-ascii?Q?5vnohHGmK/MBcKNfQEGH4IavDU367MEA2uy/5kD9k0/pAocnxHcJUaozwrAA?=
 =?us-ascii?Q?npOuwh25RbJpql71NdxJ2XGI41i+5+aeJdlkO6v6Su+6c1jsFpAKSamPzzPy?=
 =?us-ascii?Q?M/G+mlo8tftX+pcyYnT3WZyz11g4TKo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e530a24-994e-405c-6e75-08da4d8cc28f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:33:38.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ/nSPx8vDV2hBGgmIQAIhq8jGQyl9AVHN5iDaix7dFIVTi1mg739nzb9jWAtrH20Zjdif6BkkkqeGCoSQPtzQ9ZFoQGXz9ts+cbeac/z7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1700
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130087
X-Proofpoint-ORIG-GUID: 6bFxqgDKLeBQcg2rQpCfQUP2WYZdbF-l
X-Proofpoint-GUID: 6bFxqgDKLeBQcg2rQpCfQUP2WYZdbF-l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:
> On Mon, 13 Jun 2022 14:59:44 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
>> >> Related discussion around the BTF side of this:
>> >> https://lore.kernel.org/bpf/586a6288-704a-f7a7-b256-e18a675927df@oracle.com/T/#u
>> >> 
>> >> Some work-in-progress branches using this feature:
>> >> https://github.com/brenns10/dwarves/tree/remove_percpu_restriction_1
>> >> https://github.com/brenns10/drgn/tree/kallsyms_plus_btf
>> >
>> > What's the story on using gdb with this?
>> 
>> There is no story with GDB as of yet. I was already familiar with the
>> code of drgn when I started down this path, so that's what I used. Drgn
>> happens to have a very extensible type system which made it quite simple
>> to do. I'd love to see support for doing this with GDB, and might look
>> into the feasibility of it, but it's not on my roadmap right now.
>
> Naive question - could some standalone tool take this kallsyms-based
> info, combine it with a core image and create a minimally-dwarfified
> file which any debugger can munch on?

I'm not too familiar with the guts of DWARF, so honestly my guess may
not be any better than yours.

One thing that strikes me is that DWARF is typically included in an ELF
section, whereas x86_64 kernels are typically a bzImage, so I'm not
entirely sure how you'd get back an ELF file suitable to stick the DWARF
into. And from there, I really have no guess about the DWARF.

I will say that Compact Type Format (CTF) [1] is rather similar to BTF
in scope, and it already has support in the GNU Binutils. I'd imagine
that there's much more of a fighting chance of converting BTF to CTF and
getting GDB to use that instead.

[1] https://lwn.net/Articles/795384/

Stephen
