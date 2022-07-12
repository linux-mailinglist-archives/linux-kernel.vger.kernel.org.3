Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2885724F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiGLTLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiGLTIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:08:42 -0400
X-Greylist: delayed 1316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 11:51:53 PDT
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED92FFD51E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:51:53 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CGbRIk007554;
        Tue, 12 Jul 2022 18:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=ehb5XCYqY+pZEauaqF1ecrIIObDd7GgKfwaG3s/iNLM=;
 b=p3CIS8wm4AbldIW4KfkDwtClj9fCq6A2LdVQ3kpyW4i/lbUIEe3i3GQCGvh7S+ZiVues
 70vEuOhDPmePcT3gUxw81wr6edtTFnOGaxHrYSd6WGjve0MGlrdQAYFrhSg9r0eHmzld
 VldmpY/op2zEXNQGzYpuQr1U71+N7cqEpCeJ+KEBSk68lIOuVzeHGUAuiGxSCtEATaf+
 Rpgs43InA9jP5q8hYe3YQhPvi8X1G5TprfOmgI/YNqc5mvzGN0x9RSPl6bVq8P2CLs21
 Lye6x0cye22YgKl65SakEn6wf2KpbmGy01O4m05aS084pWgx9ZBj/NOY32hcbgmOsnMI XA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3h6xw5jqap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 18:29:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQFrJXHogKoM2rACGEr2hfOy992+28JDJp0nRC1FJzx57Azok/3fKWoRI+GhwHpQYOZ3giWAd+BJlAC6DSfiZ6WB0uT3ZnizJX28Do+vtcC4PFbc7JkoRrUqmAOb8R6NOP/LBDfWgC1GkvPmAE+dEevrqJORDqqniHae7qJACuGpfc6KKa1iF//Yzup1BfIkQdOwCQrnFiclizrCdzUIBshOK3T7J9LVN71XD8Cujl+BgxhxLtTk8Uyjfw6Q5Rn0AeQ65AxH3ba+7VAIJFTUTqaw8Nhfw9jlWYS+F8o4txWdbURrHPo907DS3Q1CnEUonkwP9HRnQQ0kTGEHQ6pZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehb5XCYqY+pZEauaqF1ecrIIObDd7GgKfwaG3s/iNLM=;
 b=ZSiig83KRUevMSix/qLJo0LY2Uzm4N6EeeldRyDkO7c//kMnP+4mlEgNXm9zxD2PgWX7/b1q7CLW47HTQdCG69xCeQ773NXJwQWqopCUkV943UnPhQHRRw99EmpthSEeV/WNgrYANvLeUCySKEzZpwZhCyriyEGM54ZAxXAOiV5bmcw4yYJAJ84S7h0twu5nKs/np2OE4zZEODvS99wTo9GensysFi08B1zq0ifMTpfuNI3JmqCkxNfPxNMtAejKMvcacJO784z1XpF9zMb2kEFsfYWtLZ75lFaqwUPsHWQQ2bu1oIfCF1bRGRqsa85KS3vLcKOOA0d/+FQGigj6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 18:29:17 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::45e5:975f:214a:f0d6]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::45e5:975f:214a:f0d6%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 18:29:17 +0000
Date:   Tue, 12 Jul 2022 14:29:14 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     John Keeping <john@metanate.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3] sched/core: Always flush pending blk_plug
Message-ID: <20220712182914.GK1723@windriver.com>
References: <20220708162702.1758865-1-john@metanate.com>
 <20220710010136.2510-1-hdanton@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710010136.2510-1-hdanton@sina.com>
X-ClientProxiedBy: YQBPR0101CA0172.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::15) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9c5522d-94a5-42e5-598d-08da64346dd9
X-MS-TrafficTypeDiagnostic: BL1PR11MB5256:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NQr335pGWiKMMGOf9fPAY/F4QTZ2jZ6zZjuQm7ASJNLEL9oXrrdLud9ZMYG3FnBvIPNm7unWKuWMdWh/hsTr2iz4EXrGs6WhJ/G96E7jTS6k73hhr9uFOPwCFWyLqKGjYIFGHMOK2QM96oBt3zjN89RQLwLXS9rbsZzeb5Lr5EOkodYosBgPvXsiR/XqlKvgPtzwMwcUpIO4hZHEcemXR/JyYBYcLuVGiXxEfhmAvCcy5iXNMw3qkSEvT3B15nzberTlAyAhagRfRdsHRskLwPylmGCNnYhoKye++Tr0o9vJwJ41Lm0TDdXv/hn5LGwv2KhJ4v86ZfyAS7U2+XJdc8rYPFNqX8CZKy/TznhHTN38o9d6u9yt8dXwrl3uStJxhev1sXRI/8vzQZWCEAToBVdDWS1Q6IYXR9T6fHoAOPnrzEShQHLTJJj9YwxlJguaCKFTSIIQQQ0+WIkIyinuATOPZuztjRim6UuBs/fCQ0/iboTC222GrfNGBEUAQL65MUB8BVKaWuJZnvRCBE29q+y2nqzKffx7xDfGWGVqcmLsGjycEQ0jj4z0F6ISSSzaVj3yEHB6x8P6YAIxELhqcNauOEOcZtC5HCyojohDXpqgiftfifVYjEnbcHEuclCQB1SSjuZNeE1ATQ1b10cibPy/VeZYeQt4VBdkfbCISzqsmpj5QAsjsAuzondBcegNPYt48isnEOeuAEJYpMa40jjAuFUADOkDuUVnP70YLljoUPIqJS1RhhHD4yNKQKcwPWgibty/k8OnxTMe7dKbQwAHTQwcTCjrsj9PV4uL2vNVCj4VggamZmAZIaaxHE7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(8936002)(5660300002)(44832011)(26005)(6506007)(83380400001)(2906002)(6512007)(38100700002)(316002)(86362001)(8676002)(478600001)(33656002)(54906003)(6916009)(6486002)(66946007)(66476007)(66556008)(186003)(1076003)(38350700002)(41300700001)(6666004)(4326008)(36756003)(52116002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CqfKringyqxs2/lS0VA8Md4zJgBY0MLc6LmLOmtTNNoKXAwN5KVgh0g5zEWq?=
 =?us-ascii?Q?zRBRTmDPStIhaGxa+KUJuwiEegCHJomAGHjvJckhle2JDL6dlDWzPWfgCZ9Q?=
 =?us-ascii?Q?vz7LcyDjIQo+vO+M7XJCCelsHz44cRFBNZE/OGq28WvoL1+PfaDrrhC4QUnS?=
 =?us-ascii?Q?UeqcXuaULpylbkMAbIdH0AB7nmB8z68mdcjZEA7K/Sh7Qdt7ocVimouyVXJe?=
 =?us-ascii?Q?V4Had3X6OBRs9Pef9ERVa8So5HP4Y8L+5KKK9XlWIe4I1vRPPB+zJcJx4Tko?=
 =?us-ascii?Q?OpW8NEB7uyKvqiB7aZECwypxC/CDu4qjynvxaXFuHWTuIMGBOlopB9jMlI3w?=
 =?us-ascii?Q?tnbPNklR/CErEDh5yN0YSoZe/zzLSHPQyk/N/1OXJvfbmhHVgp1GTSlVUyhu?=
 =?us-ascii?Q?KXd/wzZwsjgxIv9SAjJOiQvcyGnRjCuz6o5gEuDtxdAVTouPHM4LLF58DiwG?=
 =?us-ascii?Q?x723WJ+L30NKgfhfsMqndvkSfVkOlNSvA9DptJoAgx6K88ibou4Gr9r8mqdL?=
 =?us-ascii?Q?xuUMHTQEbVTOpjppBDX/FDFxWy//EQpxKTJSXejgR1VCZUSSl0srGmlWGSyc?=
 =?us-ascii?Q?R7v+0YTXP31gAgpJ0u+Lj0kAUKVnGBtkmzmT7mhj1mLjhQEAYOsq1C73pj7e?=
 =?us-ascii?Q?ne1leSKj/khPp1zrV0nuNjFadC15+o3Uu3Lv30doN+ib68EARgaq9yva0M9R?=
 =?us-ascii?Q?TkOayQ/NMRLEId/TYFR4c/ck01ECpVciFUDjtOwFzlHbao/c4b7ppsspaxMt?=
 =?us-ascii?Q?53KMKz2ZN6dF8tZ3hdPmImTekVjicuoQIGzFBjchUKJahMcl6yLtyPfp1uEN?=
 =?us-ascii?Q?4BOlNfToSKwrfWirwrAloLCMceP0US95ztXXyxybFCorttpGxTy807ak4Ntr?=
 =?us-ascii?Q?RSPCjH8IzK0vtcj56zJUo8C/ZHbbrYFiCJWMnrtTTO9uXSOcWtNUkMxH7JUR?=
 =?us-ascii?Q?+lFJvxkfiUMgCexel4EyuL3lprTfQFayA/tpVmMEWzK4uJ2E/ZhN3IeGMvDd?=
 =?us-ascii?Q?/xKAeCO2GkuXJaadHs57zzci/eyXhw+WCaeWHtu0o31k7SpqxABb8IjYIN2P?=
 =?us-ascii?Q?DitUQjJxasVeC5gqwN92fxWSRin6b/ljTPz2rrYr4Lkl4x+ewuwEgYC7eNlg?=
 =?us-ascii?Q?DzHUiyliYVGv/Apbd0AzXK7urg7rr6GOGEndf9ivgxvMhLCagnJ9p0wlaYQk?=
 =?us-ascii?Q?nITg8XCox2iOvvrNsYk7/P9fvUaYbn+smyfmj+y/l2cSRmlMhTFbDyRLpCy0?=
 =?us-ascii?Q?XiGW0HC/usGvmQKiQ39/JPl8Tm7QiGDSIw1KcUGkVn9qLtC/OhSVmXD4iNUm?=
 =?us-ascii?Q?K5rejZbM32JXDQGGfJlUoEpR1rxW4sJx1Pq8xu/kKiMzpQ793jpxrNIn72qb?=
 =?us-ascii?Q?AcD6NwLJi3tlGujbh4UPZKOWI/r6CGHrnVUoaFmBTVZir3/KzLXa0ZvX6Xkm?=
 =?us-ascii?Q?/jjraErTPls1P0icpqoTMb1A3Pdk4jIyEYbM+uyfMDKK83/qFknfI/76WY7H?=
 =?us-ascii?Q?Kgnjc4q2Mwk1LSRwx/FH5W8kUDDNH/vAL4uo9f8OJa87QgNwKYN5iQX7lOCp?=
 =?us-ascii?Q?PlSK0+CXzIF+PcvfR3+WIPZ4JPrGGxsLYLOIWwcMSNWwK30jbQ6My1a8yr/T?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c5522d-94a5-42e5-598d-08da64346dd9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 18:29:17.2883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArSFz0z8PtuGDfn4K0NzOiFlhZRDgVgkXeYlxcgZALv7P9L0SyjEtazfV71dp8ZJk+fgSxdYiCerrD9jDjstYfneIbzYJHBIYD3LglQiDY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5256
X-Proofpoint-ORIG-GUID: SK-S883T6PVlS3ydO_6psTxpumTBLFin
X-Proofpoint-GUID: SK-S883T6PVlS3ydO_6psTxpumTBLFin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_12,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=554 clxscore=1011
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH v3] sched/core: Always flush pending blk_plug] On 10/07/2022 (Sun 09:01) Hillf Danton wrote:

> Looks like a ABBA deadlock that should be fed to lockdep, given what was
> blocking flusher (pid 213).

[,,,]

> Make lock_buffer have mutex_lock() semantics in attempt to catch the
> deadlock above.
> 
> Only for thoughts now.

Thanks for the test patch - I'm keeping it as a reference for future
use.

So, preempt-rt issues an early lockdep splat at partition probe bootup,
both with and without the original v3 patch from this thread.

Of course then I figured I'd try the debug patch on vanilla v5.19-rc3
and we get pretty much the same lockdep complaint.


   sd 1:0:0:0: Attached scsi generic sg1 type 0
   sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
   scsi 2:0:0:0: CD-ROM            HL-DT-ST DVD-ROM DH30N    A101 PQ: 0 ANSI: 5

   =====================================
   WARNING: bad unlock balance detected!
   5.19.0-rc3-dirty #2 Not tainted
   -------------------------------------
   swapper/2/0 is trying to release lock (buffer_head_lock) at:
   [<ffffffffbc494a6b>] end_buffer_async_read+0x5b/0x180
   but there are no more locks to release!
   
   other info that might help us debug this:
   1 lock held by swapper/2/0:
    #0: ffff8bee27744080 (&ret->b_uptodate_lock){....}-{2:2}, at: end_buffer_async_read+0x47/0x180
   
   stack backtrace:
   CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.19.0-rc3-dirty #2
   Hardware name: Dell Inc. Precision WorkStation T5500  /0D883F, BIOS A16 05/28/2013
   Call Trace:
    <IRQ>
    dump_stack_lvl+0x40/0x5c
    lock_release+0x245/0x3f0
    unlock_buffer+0x15/0x30
    end_buffer_async_read+0x5b/0x180
    end_bio_bh_io_sync+0x1e/0x40
    blk_update_request+0x9a/0x470
    scsi_end_request+0x27/0x190
    scsi_io_completion+0x3c/0x580
    blk_complete_reqs+0x39/0x50
    __do_softirq+0x11d/0x344
    irq_exit_rcu+0xa9/0xc0
    common_interrupt+0xa5/0xc0
    </IRQ>
    <TASK>
    asm_common_interrupt+0x27/0x40
   RIP: 0010:cpuidle_enter_state+0x12d/0x3f0
   Code: 49 43 0f 84 b7 02 00 00 31 ff e8 fe 1c 74 ff 45 84 ff 74 12 9c 58 f6 c4 02 0f 85 8e 02 00 00 31 ff e8 97 95 7a ff fb 45 85 f6 <0f> 88 12 01 00 00 49 63 d6 4c 2b 24 24 48 8d 04 52 48 8d 04 82 49
   RSP: 0000:ffffa2890013fe90 EFLAGS: 00000206
   RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000002
   RDX: 0000000080000002 RSI: ffffffffbd78d911 RDI: 00000000ffffffff
   RBP: ffff8bee2739a400 R08: 0000000000000000 R09: 00000000001faf40
   R10: ffffa2890013fdc8 R11: 0000000000000000 R12: 00000000a7b149d6
   R13: ffffffffbdbee3a0 R14: 0000000000000003 R15: 0000000000000001
    cpuidle_enter+0x24/0x40
    do_idle+0x1e3/0x230
    cpu_startup_entry+0x14/0x20
    start_secondary+0xe8/0xf0
    secondary_startup_64_no_verify+0xe0/0xeb
    </TASK>
    sda: sda1 sda2 sda3
   sd 0:0:0:0: [sda] Attached SCSI disk
    sdb: sdb1 sdb2
   sd 1:0:0:0: [sdb] Attached SCSI disk

Not quite sure what to make of that.

Paul.
--
