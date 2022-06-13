Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0357454A1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiFMWGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiFMWG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:06:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FEB2BB02
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:06:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdPde004107;
        Mon, 13 Jun 2022 22:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rAuHnYn60m9mg4RNOdl75QDZoQIy4nVQkrOTtPufOes=;
 b=yokKmYSbBQYGD9hOT7+Oy39BYVoI5hfBxYMB7SGy9GsZsH9HY6f+TA3S84iNBFwIU+7l
 71N/XL6MMJh9cVo8HdndBiOIHK7yehAp5eN32eqXm+GJCcl6NciHUybDOWZ7EB/TFF/1
 aWlcfykva/AB49o8/JvpQ1J1jM6tBFQwjmynQIDH6vgyK0DR2ZwQki1tSHRqJw9AFSwR
 89TVfG3lYk9PlaD92+1utsP7a2jNGRtDlFIMBo9p0mVrp/0td4WMlRgV8PUXS6TBEi8v
 IisQWFYjQyzXEMziAPVeoIQ2yG036TXPFuWl1+8o5vqDwJ92g9pOPXIZRCH3VnAQGudH yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2mavv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:06:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DM4Ysf034944;
        Mon, 13 Jun 2022 22:06:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpdhugbyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hahiQulVo03NwbKi+vBaQMnwlbG5nMHweaOAoB6rMuZ+e+NJh4tSMa55ilI/xt7cL/a+Hs2du9kA6dQ2xWA9Vo5sYK2fHKybnhc2PeRieTBPROkEejbAd95bYGS1c8Vqvfn89oGP82la9DelvS3HWMg+hx6EzZMC03s/BcmsD0wLmjx7biuqtpj/m/lht8dB/jt0wHzOwvgsS1Rc6T85LVakzYOXXplGXYX92kM/3y4tMNzEkUpwX3pGTr6saYkJjasK61YilXYiCBr6/HXYRhzvaNDEwdiaDi8M1yX1Ag6WDYQkXolfZjt7Phnyts5v9+dAso3U6xdKilIm2cJDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAuHnYn60m9mg4RNOdl75QDZoQIy4nVQkrOTtPufOes=;
 b=Lw6TdMbF0UNQ6lSUumiEUNCon46gfTknGO89HOhJ95tE/P602dXveywyMYCtKlov9UDIpMLKIrIKOPvzTFu9daC55LjCTrlV/XhpVozJiM1C5nDhhfmAmIobrZogW9OTdhTL/ZbtyhOh9ODG3ljReiVG4DIBwF1Pv2uaA9QF9umIgnj3tY2sfc0gM0SOP+yxkBOxGpipiwC+eaxu0R1ZNHF5G+y16X9wiqPzWTEazrytT4l7/uTL7agXFeEcOq0qjyhoROsv5C5Rc5eAqlgZboXxquhNP+ufcD8emujeMbYX/6viLCoSmQtXFfuXnPkbijTTlPtzBASVTKOBU3BhBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAuHnYn60m9mg4RNOdl75QDZoQIy4nVQkrOTtPufOes=;
 b=Pizo1bU1ScXOdxD56Di07BhNNuuYOYc3qO4xUBRoAlaVCyZx10doFaakMTWOp69ZFXB8y3s1e6GID4A4D3xGdsfvVNm+u310t38iZmbnWceGKEpCrEv+To9ta3SWvjx7KG2x5N7iSvTByFbRFZ2i317C5Jo5CrmlOqrrW66KmYU=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 22:00:01 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4d84:324a:aeaf:8f2b]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4d84:324a:aeaf:8f2b%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 22:00:01 +0000
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
In-Reply-To: <20220613142609.3e4be0f2f45671341450232d@linux-foundation.org>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
 <20220613142609.3e4be0f2f45671341450232d@linux-foundation.org>
Date:   Mon, 13 Jun 2022 14:59:44 -0700
Message-ID: <87edzsrzqn.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0016.namprd04.prod.outlook.com
 (2603:10b6:803:21::26) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2b41c45-b724-4c72-4695-08da4d881082
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2975EC4483C98C9C8D832B92DBAB9@SN6PR10MB2975.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUTOROqGw25KOqDasg1zr4zKwJN2yqoQeW0Pz0ASNol9R6E7Mo08CpNH2jvCDm62Lb8NtXupSIrETpUHY900l5phqUMgwSBFhs4QkyIYuUmBp71K8/cZxcXH1yAiJUKvFy8pqnhQr5Sc1GoGeNRcxSkeSsA8m16JeHwDPyJUsoNK6T6o2ItSZzKxtnsdSqOXvYLoiRdHvAyZyb0YUQn0F6jkJRPYUDuTECOeW/qy/ZklijvX+pjLkexW57qK6OsZUjdpK0m9xM3b63t+mtbzneNf4KWEYdKsLaOCDa+1OUCljkOWMGAQukKtIrT3695tolPGSjUQhiZT7DledFula67oVk7FplU2PsLfcMIrpIX7HRJaJaOEETG14U93scYymQOoZuzd4CunUfFHrssHoqnuNtztRdS+MrGqTmqtPcrQofJvK+Vw7ID1fDBO5YQpRYEnPVRgShdrjwZKiL2VOmvxMqWenSO4TmYwl/dCD5xrWcssvZTL2tlq7+PDXLh139bJlRYEPakYSRvqILa33z680peboZjz7+1B1jYmhMv49QTKMhQY1RnLKh9cThSvGse9bgrRXbc/mUn5MzyB35QRFdX6xCwa+im//JeAyoQa81ygXRi8HIJ9TTDRoWvgM8GQIDKYhL2GjZcjUhz99LPH61l+/SNJCAekilmvwXk1uy5wM19AND8nMRk5od0FxlYFKopZrt79SKlo1rGjY6LI+J4THE1BNlo6WRZ4i+iOo97/cE/pwRCjx+3rtJNPQbJmIV/el5FUjDQj6aKCcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6506007)(6666004)(66946007)(8936002)(6916009)(2906002)(6486002)(316002)(6512007)(26005)(38100700002)(966005)(54906003)(508600001)(5660300002)(7416002)(2616005)(36756003)(186003)(4326008)(83380400001)(8676002)(66476007)(86362001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tUSgBJrEljWxtU6U61QG6sBOTh/dkz/1X0KIVakxMS5v6diZEAWZLXoLsgVX?=
 =?us-ascii?Q?JObs67iQUNxFG6kAcG0hQt/OSz0bP9hnEXlzOUqLRB1OAespRnNkaKY7dBly?=
 =?us-ascii?Q?ucV3kANUqTkOJXaGYPfgIUnPLawU087dOqVbWLsFqZVwK52em18eEiV2Kn5A?=
 =?us-ascii?Q?Jb5ciuTH2xPI+KGWad783MxLJG6LkqrQx25TkDuKQ9FPMjJc9brBU6+W43vJ?=
 =?us-ascii?Q?NLEmUylMmq+eHl3NLXwFbpT9c51H5Ca1T+Y0Atug0Mdln9FUbYvn5DQs+g6D?=
 =?us-ascii?Q?0vMOGJZ/44yE8CCcZ8IHKZqtoyHQRUfkDGQZSd44LtVxlyL/DYa6/1/cwOOE?=
 =?us-ascii?Q?yvTiYmqR5VMYbtJAs/jIZlFiAqB8Pp/YSKmw3TibCQsUr8ue3VIACKT8xswg?=
 =?us-ascii?Q?5GNxGZUffiVbllpeKdzfeEHhQdTOmz9sWuNqUWI8Z+U1C7T+5zod/lhPYhEj?=
 =?us-ascii?Q?ggNfTdu7Zhd+09JxS6lPZAdYrPh4CURD4Sd8UMATDYs54LzNZ6+4Tbni2K4U?=
 =?us-ascii?Q?bFjihlAioqQYa4ENxDEde1MZLJLWhpNvO/MPzUsmgRxq9sRXBUoTDMHsuSic?=
 =?us-ascii?Q?Fo6kc7LqeeFCvUEnPYIrU5jAEdva4MVCubzkCfrUvGd7AugF8RO6v2GBoK31?=
 =?us-ascii?Q?HzFxiD2GY60KBOzygWon62BuZ6HVLSzfV2biSCdH4Fv2D+d1KP0QWIgmFWH8?=
 =?us-ascii?Q?sYD1b0cktK/wUHe8eSr5dti3TE7jGT3KTQ3RBsKzQRnazEQ9fP98GRlgEU3t?=
 =?us-ascii?Q?eRscPMP2ns9RZ37GTHNXnbiq+8b/i/1eUadslNF3MjoY1lDQpw0a8WI5BU+k?=
 =?us-ascii?Q?QfX+bxnjJiH+XvP26D5kjrbXeyi68uarMJsMFSeBD2r1hXfr8HMu44Y3uq6H?=
 =?us-ascii?Q?h9BiKQbuqV4mI7ROMw7njRbD0oNpNlUh4PjnWxags4/E01UBYk9XXY2qNgc7?=
 =?us-ascii?Q?PAsn0saL7rF4fd0UH+/3QgQvBQ24DZAiv/j9eafIi5CBINVFUhyGFOCpGN0c?=
 =?us-ascii?Q?2TjxB+1lsgsadFPya3M0keeYj+iA5Lg6mxlHhqkipwf0NAgtRRQ+OBGaqr1r?=
 =?us-ascii?Q?frzpT5/PMAfH5Qvruq5BraPavUWx57/K5bEg0OzZvbrBVYNIdfANWAB0j0eZ?=
 =?us-ascii?Q?wwQay2/ao/7O4u6LcBfDVXSbmPHtkMLg9lHraHQqhaXPCWcUloj++Jx3Z2qQ?=
 =?us-ascii?Q?GxEL9/xFcHW/39Mah62xJSs/JeT0dlHANBbcHqbuzD6c1A6zQoVDCgREffZn?=
 =?us-ascii?Q?zOZfzfVD6/F9YwNXBKR+RAYl5gvh6RGI+ToAQIGWai9z/va9uf6jJ6YEen60?=
 =?us-ascii?Q?mw7ai3yAaitjC/RLi9U4ihOSEZzDpRKkSMay8TlfDne9tMtqKIs3ADeF9x54?=
 =?us-ascii?Q?pQS/5wPsy35Oj4uvhAaBzjGODr94dYtI2Rkf+bWY9h8LZlFZq521QKxbR4CN?=
 =?us-ascii?Q?92lyfdZHL/Da1ExI77L0t6D5vqVQS5U7iPkflVfMMy+25u2X47epzvh2oCKx?=
 =?us-ascii?Q?X6IbNbGHf6JPFT6k7bWG+vyM9QqIDwjkmr9K4HZ0fVTEYAqj6EnXf0h3ZpOZ?=
 =?us-ascii?Q?ekaLZUycQBXWWMU8FQ/T6iITBKP08zak+/HMc3prAd0YVQjQGCE7Rc3bW97P?=
 =?us-ascii?Q?Zr9TEYneq/V07Qg0NvRCiP/+Aest5MJ9WrwXTpTIrE5KUU9FhkJCeNDdNuN4?=
 =?us-ascii?Q?lfNIf51tqeqTRVkfJ60iV4+TLz3WbzN75YJW2wVoQlRtE0cPeJUZlKQdpJYp?=
 =?us-ascii?Q?FcE/e5zt2M5JTPLvI6AR0faj4vmEb1s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b41c45-b724-4c72-4695-08da4d881082
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:00:01.5929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlYjkvI5+3gs0tmfp1RKqoLVi+LOs0qxYiTWjLaEwsH29hDZqrG44r/JH5S/5URLnr3j98FZb53+9D8/adGdJY0Nw6fkJY5ASoTQNV//mq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2975
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130086
X-Proofpoint-GUID: hMRV-kFWFo7kDfVEw_KBx-EBIMhTEj7g
X-Proofpoint-ORIG-GUID: hMRV-kFWFo7kDfVEw_KBx-EBIMhTEj7g
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
> On Mon, 16 May 2022 17:05:06 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
>
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
>
> Am trying to understand the value of all of this.  Can you explain
> further why carrying the dwarf info is problematic?  How problematic
> are these large files?

The primary value I see in this is that it unlocks data that's already
present in core dumps. Most distribution kernels already have
CONFIG_KALLSYMS_ALL, but you can't reliably find the symbol table in a
core dump without a change like this. Most distribution kernels already
have a fair amount of type information via BTF already built-in (though
as I mention below, there's a bit more that would be useful). So this
change can unlock that data, and make core dumps self-describing: you
can open one up at any time without extra debuginfo, and start reading
symbols and data values out of memory.

As far as the DWARF, I do find it unwieldy, we're talking about file
sizes ranging from 500 MiB to a 1 GiB or maybe a bit more. This isn't
huge for on-disk storage. But for things like OS images, it's pretty
hefty just for the off-chance that you need debugging.

A bigger concern than the size of the files is that, we frequently deal
with customers who, due to some sort of requirements, have a policy
against installing debuginfo packages on production machine. When they
inevitably ask folks like me to help debug the kernel on their "no
debuginfo" machines, I'd like to be able to just get my job done using
the info already there, rather than battling them over debuginfo.

There's also some corner cases. I've definitely taken a core dump on my
personal machine, only to find that the debuginfo had been deleted due
to a kernel package upgrade, so the core dump was useless. And some
distributions build kernels with no debuginfo packages. This can suit
all of those possibilities without undue overhead.

>> I've demonstrated a proof of concept for this at LSF/MM+BPF during a
>> lighting talk. Using a work-in-progress branch of the drgn debugger, and
>> an extended set of BTF generated by a patched version of dwarves, I've
>> been able to open a core dump without any DWARF info and do basic tasks
>> such as enumerating slab caches, block devices, tasks, and doing
>> backtraces. I hope this series can be a first step toward a new
>> possibility of "DWARFless debugging".
>> 
>> Related discussion around the BTF side of this:
>> https://lore.kernel.org/bpf/586a6288-704a-f7a7-b256-e18a675927df@oracle.com/T/#u
>> 
>> Some work-in-progress branches using this feature:
>> https://github.com/brenns10/dwarves/tree/remove_percpu_restriction_1
>> https://github.com/brenns10/drgn/tree/kallsyms_plus_btf
>
> What's the story on using gdb with this?

There is no story with GDB as of yet. I was already familiar with the
code of drgn when I started down this path, so that's what I used. Drgn
happens to have a very extensible type system which made it quite simple
to do. I'd love to see support for doing this with GDB, and might look
into the feasibility of it, but it's not on my roadmap right now.

That said, the drgn work is moving ahead nicely, much of this code has
moved from a "work-in-progress branch" to pull requests which are in
review. I have every intention of seeing those changes through.

Thanks for taking a look at this. I'm happy to answer more questions or
clarify anytihng you want.

Stephen
