Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818164900AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiAQEFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:05:42 -0500
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:35041
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234174AbiAQEFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:05:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7Qdy+BZ1oagdQzJXrTQRYmWliWjb5PFA35tcaj9NHxkoMFQ4Pm+6/pc8rsNI/Uq5AjG1AZRy5BFwo7zJtQjxDMug8yccK5ssH244toTUrS0JBkGeVCt8QzWQD/L7VKkvRUuXMR6r2frEA3KOfzYN0DBaSqaG+w7Nowv3lKcSrAgSDr4w/105d/Xt9DJbNcRf50U0dbOf09KwRDyyw5woy5kDUlHUQRAExEieZNjdHb90mf4tA/hLwP1HnmUppScM3hEV7Ne+rO3P9tKaTQMo2GjsZuRNT4z6XvtyuUVtchz4AgApauthb6NiRc5waPeVZ9T1FHM90Zoci/s0/bzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQsFnSJTJMTF4FYKyrWfZ7jjNKlc0GWcbqOvlclL3zE=;
 b=S6hmxU5m7cfeg6QtZjAem1FDFelouEr5whH57/ww/eK1Gkb/xVg2ynkzbqxxDLNemLvdGUJqh/VAi2UYUdqGu2aV1ExeUenhehm7jWZUH1kLwKTBOznHl2sX2m7KBou102evLuHdh9vz/bvrBmX1DIuKau10FxAZX5zHSoBOwZ2UiQ63MUR7o0iPjYRIOiTzKbA6eoq0l4KQJvXNPTfseoCVHoZdL1NNSW5rTehLHu4NaXaH7Fb22BCqq2fY5AosORHVXUru8DXXkJuEEgsgcE0L9QyMB6EZi18AM40cHEJ+8ehXFh1W57FNBT1UPu0t++seYOHtNPYvHXxg+QhmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQsFnSJTJMTF4FYKyrWfZ7jjNKlc0GWcbqOvlclL3zE=;
 b=JWlM61jD3s2fKMLx28GwQ4DWAQsBgWDgqsH8mrGmcwxvk9aLlvHBAmM8uhmTUWJHVlra5F+fA6morLVWJUWNX7RILBZHKBylVKfMiv/rtbIu1YfE3u6LLnSnZ2HfPFD6cZ51rRNy4iL1TwJylaVUVEeJ+99wE/f5qIQKGlF++28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Mon, 17 Jan 2022 04:05:39 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 04:05:39 +0000
Date:   Mon, 17 Jan 2022 12:05:18 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: {standard input}:1381: Error: Insn slot not set in unwind record.
Message-ID: <YeTq/jbzDsqEcyNC@amd.com>
References: <202201151944.siKQX7w9-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201151944.siKQX7w9-lkp@intel.com>
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a2d630b-a9ce-44ef-a3b0-08d9d96e9f39
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5427442A104D53F2CCC292C3EC579@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2w4bwnBvSrPK9sIof2e5BK/3TpgWmZYKAr5p3QJo81v4oaJFte6//lkQuFwJmqySXR/4ymrNtvoTGk3oD3KOGxV4WpYUAXwSe4aaWIkHi05W1+vqELFsuNYWv9rJKkBqm+tEmiFwUWhmTcFgdclu+pQT9ESmmzQkTBrw1vaaZE6h0sZzirnaJytqWaV8H13UZLtN6e/mCD3bLnKfTvefut0AYTudU/GqJx0AZAjNNth88SI1F3MFQxeFhbKF1o09inm65UX9i+DmUPcRjrGH4FLM90meoOHTHp6HyldU0374zMao58k+7h5FjKGWo7ASsKkqgWZ1zTUFKhAyfNGdw52CzcWBDgLZtioTlP6iW/dI2Zar1o/xpMXlbFBMj7GXeeNAFv4LLKVwZUDvf6cVNuTLyt54H36ROR2Mn3OJ6nDUrBEAG7siQ0rYv/oTmKjfg/Z5HLZqt1iaMh3bebLNPnKiSHfaOlg0gBfxGfNH+ynu3EIvnxKFhlcaz/+wd6k//k0IANxR+tjXcf4uXmL4lhQIg7oHnwQD7/1qOUw12VnfenT5U+UlkXqhAlT441R6HdCrT7KHaCiLq0FdDcRr77/Zr3vn77xBRyu4HJxvHnTV0zD5rlf8Q3LkPRAgwbaV+/z74R3xt55Hb6qtBGVOLasB9RXgnf70fqDWMziKt6GOFY9pfLAM0qOu9EdwfD2WcWGcP/EUdMHN7vOfQqVzXK2JIWEQlqkkKt9bks+2PxGMo4wLBb0QmO0OGd0cMp3heUrc/HgjeSNtjOt6MegPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(6916009)(6506007)(2906002)(66556008)(45080400002)(5660300002)(38100700002)(966005)(6512007)(316002)(186003)(83380400001)(8676002)(54906003)(26005)(2616005)(6486002)(508600001)(8936002)(6666004)(86362001)(36756003)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6j46qigRGlOeF8bAtPNT76SSIWfHnOGMEpJVNTWyAY3Zpn+9cmBncjw+c21?=
 =?us-ascii?Q?FYTPUMX812RT3kzI5B57r5Wil31dYOf1GEktY/WxOHfePCP+DCNMCJntub4/?=
 =?us-ascii?Q?sHVi+xNKlYoOtnF68x+BjTn+3ZPYVAKukDKPpr4JiV8smsnfako7zbu7gCTj?=
 =?us-ascii?Q?V5zjviWvVGC2/V9P3wRLvDk1hNnBJ0Z2zbTEmuslnWajpAh9owZVrIhqpl2b?=
 =?us-ascii?Q?2vaN0fQZ4V3Pu7c5rIPPGxXZHsCzRWH3ilUAvxP4styDcTRN0EL+vSY+Jtcb?=
 =?us-ascii?Q?N/C4qkxDdqTR1aMsuY5u2w/9mba8NAq/nCUXFK3C68hdvTJhrjmv/HxiZs0U?=
 =?us-ascii?Q?yJTJCPiko6TkWLZo/m+ApC2whfDgNUCOoDSfnZFNtwSXWwmFEPkUE777z2ev?=
 =?us-ascii?Q?QDKQIAdxUqWOQ726legOaVlOTFCClJCqX3bXpLc5p3cPEBFWVtwMXM8n0N7H?=
 =?us-ascii?Q?lWjMHhvqJ6sulAmxk1nPu0x68G/Lbj6r+2J2lpDMbIdaOPLdxpS/laq8xC85?=
 =?us-ascii?Q?Lh6CaMvgmOZXb/aWswaX+gSDDU3wQ9x8ZqZLReEHXkACOG966jhzBwjUVWUz?=
 =?us-ascii?Q?nTUXGjO6F42+dnyPZIVcn5wLIcVZdTuWsDLpMVBpuMfkrB9Mon8gMUJbsUOE?=
 =?us-ascii?Q?JBugwinSabIH+j5dueKDsDwNgEWBxhQFFrQETAVZmsMs0EF8BR+4REgIheDt?=
 =?us-ascii?Q?eFiQf0e/7/ee9IoUCCbyfn8s+9vPpjOH9NgbwlfTKK2FJ3ApaVJpwgnoJQ4N?=
 =?us-ascii?Q?S+oLskpfi0rYoXOP9vzpgFba3YRKP+cq5nezcy3tGTxjO/dniwLDAuP8Emko?=
 =?us-ascii?Q?IDwrSECz1B70PUcQizt3uWsk8w0StXDIA3l9gw9ypwErCXLPPDBQPxMZf+Tn?=
 =?us-ascii?Q?kNdLxhgU/aLImFhjzjOKyjp2CGiEp/m0vXS1y8aSEqqng4zp5PX+aHwuDHwY?=
 =?us-ascii?Q?GvYz9AdZ8Rpnhgfv5H5ydINrDsVW8PdMS1UnmjrlwjNarASh89Pt2O753Jxq?=
 =?us-ascii?Q?zdYL786f2xmHBTaysQ4y89lKJHhWIzclEx0vTDoBgyQ4BoA8Mf7vS2r24S2l?=
 =?us-ascii?Q?uvDUJY3qr261InEhprusDVam7gbL6NzFKnDZIQQZJBrHuiXnXwIGSUuW1W18?=
 =?us-ascii?Q?F8dRCAEyBd+ET6J2syd3Ied9BjejODOlVHBUJA2s9IIAiMPOd+AUowakbNEP?=
 =?us-ascii?Q?/ZHfNs6CyqQEebWWPl0oGZ30OjuoXvOpCVt4EHI09y55HrEmzFS3kc2NbrSE?=
 =?us-ascii?Q?itHBzqXGe+C+OCgvSpub7DnUZhu0DWQaG8bRrGdXxhLzTkWy7EZ0k9I9I5Er?=
 =?us-ascii?Q?fYJRe6LFz6sgB0WdjJuuoGLWdprlUB9dudEMOftEw87JJZE/ppYdYYxqMa9S?=
 =?us-ascii?Q?P4ZNAkwj4357Ytf/uB82IfKtfw/H/ywgexjzNdgFp5udz/wS0zNohKdqXEVx?=
 =?us-ascii?Q?rPVwRGVkIvbGbC2emxmYCssjTnApebXcJIlqEKUIkr9DflGJdsDCc8gaiV74?=
 =?us-ascii?Q?O4yehGBW655+6FKtjvi0lLvbAVj85/LhimDdDWzX6+OlHMMHaQZsbwD49FlT?=
 =?us-ascii?Q?oWlgtBO1UZGg2Wfsa3E/HzVtv3RzVWuhNayfqITT2iSGiRZL30wcomrX21t/?=
 =?us-ascii?Q?Gcx4KfK6E08kG1P+83M1VBk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2d630b-a9ce-44ef-a3b0-08d9d96e9f39
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 04:05:39.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9N1K5m+ZYlpC75+it8CuWksdoxB/MScJX9bit3lS6ObLnuKILQpusbyzxNGF+pPehVnApI6schUHN/t88lQikw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 07:49:12PM +0800, kernel test robot wrote:
> tree:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cray.huang%40amd.com%7Ca6fd06fac8a94c62c77a08d9d81d26cc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637778441989299736%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=5x0UsKxXHUM8eaXf%2FfEJg5A7m4lq3IIJB5yVoH8wyWQ%3D&amp;reserved=0 master
> head:   a33f5c380c4bd3fa5278d690421b72052456d9fe
> commit: bf67014d6bda16a72deea11dbbff2a97c705ca92 drm/amdgpu: introduce new amdgpu_fence object to indicate the job embedded fence
> date:   4 weeks ago
> config: ia64-randconfig-r033-20220114 (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20220115%2F202201151944.siKQX7w9-lkp%40intel.com%2Fconfig&amp;data=04%7C01%7Cray.huang%40amd.com%7Ca6fd06fac8a94c62c77a08d9d81d26cc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637778441989299736%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=wvSyECxjF2Bq0hIolStzs%2FST9%2Bi9w8O4zNDQAxolvZI%3D&amp;reserved=0)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=04%7C01%7Cray.huang%40amd.com%7Ca6fd06fac8a94c62c77a08d9d81d26cc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637778441989299736%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=sBWm8b9YpATut%2F0F8%2FeM9nXxjHdXbZtNv7mXqFlOgEQ%3D&amp;reserved=0 -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3Dbf67014d6bda16a72deea11dbbff2a97c705ca92&amp;data=04%7C01%7Cray.huang%40amd.com%7Ca6fd06fac8a94c62c77a08d9d81d26cc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637778441989299736%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=CJWV4SC%2FhH%2BtzdIbrTN%2F4O7JJ8qRoZPUU5GPvwr3mMs%3D&amp;reserved=0
>         git remote add linus https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cray.huang%40amd.com%7Ca6fd06fac8a94c62c77a08d9d81d26cc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637778441989299736%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=5x0UsKxXHUM8eaXf%2FfEJg5A7m4lq3IIJB5yVoH8wyWQ%3D&amp;reserved=0
>         git fetch --no-tags linus master
>         git checkout bf67014d6bda16a72deea11dbbff2a97c705ca92
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/ia64/include/asm/pgtable.h:153,
>                     from include/linux/pgtable.h:6,
>                     from arch/ia64/include/asm/uaccess.h:40,
>                     from include/linux/uaccess.h:11,
>                     from include/linux/sched/task.h:11,
>                     from include/linux/sched/signal.h:9,
>                     from include/linux/rcuwait.h:6,
>                     from include/linux/percpu-rwsem.h:7,
>                     from include/linux/fs.h:33,
>                     from include/linux/seq_file.h:12,
>                     from drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:31:
>    arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
>    arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
>      127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
>          |                                                ^~~~~~~
>    {standard input}: Assembler messages:
> >> {standard input}:1381: Error: Insn slot not set in unwind record.
>    {standard input}:1381: Fatal error: Section switching in code is not supported.

Thanks, let me take a look.

Thanks,
Ray
