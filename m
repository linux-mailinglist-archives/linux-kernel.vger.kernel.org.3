Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8888E57955E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbiGSIlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiGSIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:40:59 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E2DB1F6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:40:58 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so30252466fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SjTMYyNdBeUu7iomKZchO0cdHcESp1feqssx2cB1fms=;
        b=73FS09WA3/I7Q5DJHVJdYGp21QdQ/EcCS2t02L8sMAMb5r4K+NbYLj6EKD2qO+E04n
         +Es7yB8DjJCJ/445YlF46KW9w108Y/KR0xllDNsmgUmd6vbzlVeqnhVmWsX6MFHZ7PUN
         nQhsQLT81guwsIFf72u8nMG5Kmb7MudZNWNhxKGUSz9NrjlawyjETh8swwMNMNsSLMvz
         VgOB9AUpfuPjBi+qIx9aOCq/jDGsZeD+13vs4JTSgKpn/NVuAKlu/q/WtmB1ZtYr1Si9
         5YALk5mdUYNtsT100hDNm+d+GoNTbP9iAzFNWeehUWRHx8bPFyBKfcRp7ZKIF3Uu+uT0
         ekbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SjTMYyNdBeUu7iomKZchO0cdHcESp1feqssx2cB1fms=;
        b=WqsfZuSyvMvx1w/hI5GRfXGjkk/JkfWMO3cRlPNSVDzF3yoy+GCsBlAFAmMF5+FQV+
         OdE4eHkBXCB8LWTfu3EVICije1Yd/GRRvAL1Kl+GKtXtyR+t46ezGDNb61jrjzJjsYv9
         TzNlOmac2ZbMqnMTn2jQsZKeWz21NIbsn6tiO8NygoJOxHUPfHqLESNFoOS0az95TNnZ
         ndenn90Q2rAymBFJ7UTXih83S+QuFXV0W2DYYCLtKVfQlIpLubWdxDDhe22bpGjOu5fF
         ak7ZtBUvQQbUpFp4sByDS+boHQt1EsgTKuhoF3HCz+cLdSfy/er7rhN5eBhtzYxLSH3A
         3x+Q==
X-Gm-Message-State: AJIora/MNfH6/qmtVsO64VAve0jCqwX4hGc6Iv8mbhsOHpYWouPPO32d
        Ff25UumeywLrltkVbHPyuI0fb7fCyVzyHkr1qZBU1Aul1zj9NQ==
X-Google-Smtp-Source: AGRyM1tsVwlXGy0aUgRSYFGzXhmchcLKINd9UasySXdc4KsjpivFEr+j9ktcFKrrWQQQg71eQZ/+XTkGC+OS/qdZRik=
X-Received: by 2002:a05:6870:c10b:b0:10d:1992:f249 with SMTP id
 f11-20020a056870c10b00b0010d1992f249mr10553048oad.256.1658220057827; Tue, 19
 Jul 2022 01:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPRrUoNtO4J8H8aLWRCGGZkwHqtOZV9Edamd2pXVB0ooA@mail.gmail.com>
 <DM5PR12MB24695F88092ADF033A2522E6F18F9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24695F88092ADF033A2522E6F18F9@DM5PR12MB2469.namprd12.prod.outlook.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 19 Jul 2022 09:40:46 +0100
Message-ID: <CAHbf0-GssD3jP4ZjVQeP1Bgu+uHE3OXAEWLeZJA5VdWHzqbBjQ@mail.gmail.com>
Subject: Re: Command "clinfo" causes BUG: kernel NULL pointer dereference,
 address: 0000000000000008 on driver amdgpu
To:     "Chen, Guchun" <Guchun.Chen@amd.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was told that this patch replaces the patch you mentioned
https://patchwork.freedesktop.org/series/106078/ and it the one
that'll hopefully land in Linus's tree

On Tue, 19 Jul 2022 at 03:33, Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> Patch https://patchwork.freedesktop.org/series/106024/ should fix this.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mikhai=
l Gavrilov
> Sent: Tuesday, July 19, 2022 7:50 AM
> To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Linux List Kernel Maili=
ng <linux-kernel@vger.kernel.org>; Christian K=C3=B6nig <ckoenig.leichtzume=
rken@gmail.com>
> Subject: Command "clinfo" causes BUG: kernel NULL pointer dereference, ad=
dress: 0000000000000008 on driver amdgpu
>
> Hi guys I continue testing 5.19 rc7 and found the bug.
> Command "clinfo" causes BUG: kernel NULL pointer dereference, address:
> 0000000000000008 on driver amdgpu.
>
> Here is trace:
> [ 1320.203332] BUG: kernel NULL pointer dereference, address: 00000000000=
00008 [ 1320.203338] #PF: supervisor read access in kernel mode [ 1320.2033=
40] #PF: error_code(0x0000) - not-present page [ 1320.203341] PGD 0 P4D 0 [=
 1320.203344] Oops: 0000 [#1] PREEMPT SMP NOPTI [ 1320.203346] CPU: 5 PID: =
1226 Comm: kworker/5:2 Tainted: G W L
> -------- --- 5.19.0-0.rc7.53.fc37.x86_64+debug #1 [ 1320.203348] Hardware=
 name: System manufacturer System Product Name/ROG STRIX X570-I GAMING, BIO=
S 4403 04/27/2022 [ 1320.203350] Workqueue: events delayed_fput [ 1320.2033=
54] RIP: 0010:dma_resv_add_fence+0x5a/0x2d0
> [ 1320.203358] Code: 85 c0 0f 84 43 02 00 00 8d 50 01 09 c2 0f 88 47
> 02 00 00 8b 15 73 10 99 01 49 8d 45 70 48 89 44 24 10 85 d2 0f 85 05
> 02 00 00 <49> 8b 44 24 08 48 3d 80 93 53 97 0f 84 06 01 00 00 48 3d 20
> 93 53
> [ 1320.203360] RSP: 0018:ffffaf4cc1adfc68 EFLAGS: 00010246 [ 1320.203362]=
 RAX: ffff976660408208 RBX: ffff975f545f2000 RCX: 0000000000000000 [ 1320.2=
03363] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff976660408198 [ =
1320.203364] RBP: ffff976806f6e800 R08: 0000000000000000 R09: 0000000000000=
000 [ 1320.203366] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000=
000000000 [ 1320.203367] R13: ffff976660408198 R14: ffff975f545f2000 R15: f=
fff976660408198 [ 1320.203368] FS: 0000000000000000(0000) GS:ffff976de12000=
00(0000)
> knlGS:0000000000000000
> [ 1320.203370] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 1320.20=
3371] CR2: 0000000000000008 CR3: 00000007fb31c000 CR4: 0000000000350ee0 [ 1=
320.203372] Call Trace:
> [ 1320.203374] <TASK>
> [ 1320.203378] amdgpu_amdkfd_gpuvm_destroy_cb+0x5d/0x1e0 [amdgpu] [ 1320.=
203516] amdgpu_vm_fini+0x2f/0x4e0 [amdgpu] [ 1320.203625] ? mutex_destroy+0=
x21/0x50 [ 1320.203629] amdgpu_driver_postclose_kms+0x1da/0x2b0 [amdgpu] [ =
1320.203734] drm_file_free.part.0+0x20d/0x260 [ 1320.203738] drm_release+0x=
6a/0x120 [ 1320.203741] __fput+0xab/0x270 [ 1320.203743] delayed_fput+0x1f/=
0x30 [ 1320.203745] process_one_work+0x2a0/0x600 [ 1320.203749] worker_thre=
ad+0x4f/0x3a0 [ 1320.203751] ? process_one_work+0x600/0x600 [ 1320.203753] =
kthread+0xf5/0x120 [ 1320.203755] ? kthread_complete_and_exit+0x20/0x20
> [ 1320.203758] ret_from_fork+0x22/0x30
> [ 1320.203764] </TASK>
>
> Full kernel log is here:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpaste=
bin.com%2FEeKh2LEr&amp;data=3D05%7C01%7Cguchun.chen%40amd.com%7C06749e19d65=
b418748dc08da6918435f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63793785=
0184140997%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dx1%2FR7m9Vy2XwkXKXsm=
EOeaAyv44ZKNsU4caZJOOSIvY%3D&amp;reserved=3D0
>
> And one hour later after a lot of messages "BUG: workqueue lockup" GPU co=
mpletely hung.
>
> I will be glad to test patches that fix this bug.
>
> --
> Best Regards,
> Mike Gavrilov.
