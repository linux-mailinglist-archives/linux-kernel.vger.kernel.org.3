Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7101F592790
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiHOBg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHOBg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:36:56 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B85FD32
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:36:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 315B032002E8;
        Sun, 14 Aug 2022 21:36:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 14 Aug 2022 21:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660527413; x=
        1660613813; bh=kiOeJpL8nUIEiVlyVYw+CfFsCChGYv9U1T4vOwCPVC4=; b=Q
        AA/3v7b0hWbqvykLINn8Nf+izaVrhhS7foEEWg33VmDq4H3wTYf/vZcvocsZHHs4
        5UYzIQn9JBAuTBYhNp/fQzSVSTmcGT4cLh8u7UT+YXeyPX5wfkIA0r0V+bh98mk+
        UmtSPxI3uchu8/euD+k1vx1DszFaXpSEaEO/8IxRzrozQRfzIWJVYBxChwSCWpL8
        4p5Hbi+/JqcNvuG0m7VQ7DBJCVO/wC5gNpS1d1moWcDRQDIuBjrquNjmMQ+zNe1C
        c+ykBxGVNN5ZbobybTNXJdkibykyJTd2/yYa+4q55LjV6cVefgxRsOotu8Yw7T4e
        YIUf9/CS67kCT1VSNzvFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660527413; x=
        1660613813; bh=kiOeJpL8nUIEiVlyVYw+CfFsCChGYv9U1T4vOwCPVC4=; b=4
        dZG1+E9xPyUMjfKZNWBSbyC+WJFe5KSOMyiycTlvqiMoFVjw9SgDVD/5RS/XE+1+
        pci3m1r11eN0rYX2qSLZHwypLqs75jtefrmDBywLbq6VetGywcVrdFflzMFoBnlR
        fNSH3wTdF22MUK/fG74ofl3UQbFY3AEfyeTh4vnFW67HpS0JFcP1wOVxJi5oERxj
        hOurfljr1ahWxU6JyRsdB0a9s7PhC6xNwToZRnBeJ627qL3l0uBzC+slYgHo5YR0
        Ih+rdsC45niYYANGmF+cAPASBpgsnqeezkQsK/UVSuCKv0i7Hq9AaRvVJ14h/SJy
        OeRLGPCY/K+gs7Diq666w==
X-ME-Sender: <xms:NaP5YpQcpGjg_P0dKQUzl6KxFH4U-aWS6GqymyKmy7BKrCW3OTrPSQ>
    <xme:NaP5Yiw_8_fjFIjGoFDNtJkZFE5YU-bCrFNYSgU4-l8s2S14hySl2diaIh5Aexx1p
    UjNlKxXj3Bd71F17g>
X-ME-Received: <xmr:NaP5Yu3FQ3m0oJdHQt97KQ7s1Z4mTb0AlZKfiKzBvQZymmaXvLV5by6FwX9rSPjQUpw_TEYF2v0l6YwXmZpvZ3y4FwSKMFfShSFpdLH7HCQ0AdPzJ4lg4pxnwskn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpefhieetgfelveettdffjeevudejkeejudfgtdevffejledvtdefkeeg
    gfejhffggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:NaP5YhCgDcfmLyKZXULk9gv-QdJinji4GRKFUL0b5WB_26dHHhMrIw>
    <xmx:NaP5YihLn6nrV-fS9B2Pm2eOEM9XR6Mo1GyQckFcBNLCvl8q5g8QaA>
    <xmx:NaP5YlqMH9BRIPxoy9xdzNatC7WQMmRkgE-SwMg-3f9SKoOigE2cDg>
    <xmx:NaP5YkYUwKhAHlIlkdUnG1T1zsrqBdbHGCYzi-udiAijNmn1GVG4dA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 21:36:53 -0400 (EDT)
Date:   Sun, 14 Aug 2022 18:36:51 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-08-14 19:04:22 -0600, Jens Axboe wrote:
> I took a quick look and added more SCSI bits to my vm images, but
> haven't been able to hit it.

Didn't immediately hit anything locally in a vm either...


> Sounds like Andres is already bisecting this, so I guess we'll be wiser
> soon enough.

I started bisecting the network issue, as it occurred first, and who knows
what else it could affect. Will bisect the other range after.

Due to the serial console issue mentioned upthread it's pretty slow
going. Each iteration I create a new gcp snapshot and vm. Adds like ~10min.
Doesn't help if intermediary steps don't boot with different symptoms and
another doesn't immediately build...

Some of the symptoms could be related to the issue in this thread, hence
listing them here


a34bed37fc9d (skipped):
[    3.128807] systemd[1]: Hostname set to <debian>.
[    3.240524] general protection fault, probably for non-canonical address 0xffff003800000800: 0000 [#1] PREEMPT SMP PTI
[    3.242591] CPU: 1 PID: 194 Comm: systemd-rc-loca Not tainted 5.19.0-bisect3-00075-ga34bed37fc9d #2
[    3.244337] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
[    3.246262] RIP: 0010:kmem_cache_alloc+0xc2/0x3f0
[    3.247272] Code: 6c a1 d4 57 48 8b 50 08 48 83 78 10 00 4c 8b 20 0f 84 d3 02 00 00 4d 85 e4 0f 84 ca 02 00 00 8b 45 28 48 8b 7d 00 48 8d 4a 40 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 bb 8b 45 28
[    3.247275] RSP: 0018:ffffbb538032bdd0 EFLAGS: 00010286
[    3.247278] RAX: 0000000000000800 RBX: 0000000000000cc0 RCX: 0000000000286101
[    3.247280] RDX: 00000000002860c1 RSI: 0000000000000cc0 RDI: 000000000002f9a0
[    3.247282] RBP: ffffa43c4011e100 R08: 0000000000000000 R09: 0000000000000000
[    3.247283] R10: 0000000000000000 R11: 0000000000000000 R12: ffff003800000000
[    3.247285] R13: 0000000000000000 R14: 0000000000000cc0 R15: ffffffffa82f80d6
[    3.247290] FS:  00007f4036169940(0000) GS:ffffa43d77d00000(0000) knlGS:0000000000000000
[    3.247292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.247294] CR2: 00007f40370015e2 CR3: 000000010032e004 CR4: 00000000003706e0
[    3.247296] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.247297] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.247298] Call Trace:
[    3.247301]  <TASK>
[    3.247304]  getname_flags.part.0+0x26/0x1c0
[    3.267827]  user_path_at_empty+0x1b/0x50
[    3.269300]  user_statfs+0x4f/0xd0
[    3.270092]  __do_sys_statfs+0x35/0x70
[    3.270836]  do_syscall_64+0x37/0x90
[    3.271499]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[    3.272612] RIP: 0033:0x7f4036cb93a7
[    3.273360] Code: ff ff ff ff c3 66 0f 1f 44 00 00 48 8b 05 61 8a 0f 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 89 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 39 8a 0f 00 f7 d8 64 89 02 b8
[    3.277027] RSP: 002b:00007ffff2133a18 EFLAGS: 00000286 ORIG_RAX: 0000000000000089
[    3.278410] RAX: ffffffffffffffda RBX: 00007f40370015e2 RCX: 00007f4036cb93a7
[    3.279980] RDX: 00007f403616a360 RSI: 00007ffff2133a20 RDI: 00007f403701b2e5
[    3.281688] RBP: 00007ffff2133a20 R08: 0000000000000000 R09: 00007f40370d8aa0
[    3.283211] R10: 00007f40370d5518 R11: 0000000000000286 R12: 00007ffff2133d08
[    3.284602] R13: 00007ffff2133b70 R14: 0000000000000000 R15: 00007f4037107020
[    3.286087]  </TASK>
[    3.286672] Modules linked in:
[    3.287490] ---[ end trace 0000000000000000 ]---

repeats across boots


6b60b9c008e5, doesn't build without warnings (circumvented by CONFIG_WERROR=n):
drivers/virtio/virtio_ring.c:1118:12: error: ‘virtqueue_resize_split’ defined but not used [-Werror=unused-function]
 1118 | static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
      |            ^~~~~~~~~~~~~~~~~~~~~~


6e33fa094f1f, first attempt didn't boot with below oops. Second boot showed
the network issue.

[    5.809314] BUG: unable to handle page fault for address: ffffa17537d00038
[    5.810318] #PF: supervisor read access in kernel mode
[    5.811040] #PF: error_code(0x0000) - not-present page
[    5.811820] PGD 100013067 P4D 100013067 PUD 0
[    5.812479] Oops: 0000 [#1] PREEMPT SMP PTI
[    5.813089] CPU: 1 PID: 1 Comm: systemd Not tainted 5.19.0-bisect6-00059-g6e33fa094f1f #6
[    5.814215] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
[    5.815473] RIP: 0010:cgroup_rstat_updated+0x1d/0xc0
[    5.816294] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41 54 48 c7 c2 64 e6 01 00 55 48 63 ee 48 8b 0c ed a0 58 58 a1 53 48 8b 87 08 03 00 00 <48> 83 7c 01 38 00 74 09 5b 5d 41 5c c3 cc cc cc cc 4c 8d 24 11 48
[    5.818885] RSP: 0018:ffff97f30001fb80 EFLAGS: 00010092
[    5.819885] RAX: 00000fff00000000 RBX: 0000000000000001 RCX: ffff917637d00000
[    5.820913] RDX: 000000000001e664 RSI: 0000000000000001 RDI: ffff917503463800
[    5.821957] RBP: 0000000000000001 R08: ffffffffa2056600 R09: 0000000000000000
[    5.822935] R10: ffffffffa2057e20 R11: 0000000000000003 R12: ffff9175035fa000
[    5.824071] R13: 0000000000000cc0 R14: ffff9175035fa000 R15: 0000000000000001
[    5.825223] FS:  00007f0541dfe940(0000) GS:ffff917637d00000(0000) knlGS:0000000000000000
[    5.826428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.827293] CR2: ffffa17537d00038 CR3: 0000000100324001 CR4: 00000000003706e0
[    5.828315] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.829350] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.830313] Call Trace:
[    5.830670]  <TASK>
[    5.830986]  __mod_memcg_state+0x3c/0xa0
[    5.831576]  memcg_account_kmem+0x19/0x60
[    5.832159]  obj_cgroup_charge+0xc6/0x190
[    5.832780]  ? alloc_inode+0x54/0xc0
[    5.833296]  kmem_cache_alloc_lru+0xba/0x500
[    5.833901]  alloc_inode+0x54/0xc0
[    5.834381]  iget_locked+0xdc/0x200
[    5.834876]  kernfs_get_inode+0x13/0x110
[    5.835423]  kernfs_iop_lookup+0x6f/0xd0
[    5.835973]  path_openat+0x715/0x1250
[    5.836487]  ? path_lookupat+0x92/0x190
[    5.837035]  do_filp_open+0xaa/0x150
[    5.837538]  do_sys_openat2+0xaa/0x160
[    5.838065]  __x64_sys_openat+0x65/0x90
[    5.838602]  do_syscall_64+0x37/0x90
[    5.839108]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[    5.839802] RIP: 0033:0x7f05429637d7
[    5.840305] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 54 24 28 64 48 2b 14 25
[    5.843341] RSP: 002b:00007ffe006571f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[    5.844355] RAX: ffffffffffffffda RBX: 000055bacd0216f0 RCX: 00007f05429637d7
[    5.845579] RDX: 0000000000080241 RSI: 000055bacd12dd00 RDI: 00000000ffffff9c
[    5.846580] RBP: 000055bacd12dd00 R08: 0000000000000004 R09: 0000000000000001
[    5.847974] R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
[    5.848963] R13: 000055bacd0216f0 R14: 0000000000000001 R15: 0000000000000001
[    5.849987]  </TASK>
[    5.850308] Modules linked in:
[    5.850782] CR2: ffffa17537d00038
[    5.851297] ---[ end trace 0000000000000000 ]---

[    5.852030] RIP: 0010:cgroup_rstat_updated+0x1d/0xc0
[    5.852805] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41 54 48 c7 c2 64 e6 01 00 55 48 63 ee 48 8b 0c ed a0 58 58 a1 53 48 8b 87 08 03 00 00 <48> 83 7c 01 38 00 74 09 5b 5d 41 5c c3 cc cc cc cc 4c 8d 24 11 48
[    5.855252] RSP: 0018:ffff97f30001fb80 EFLAGS: 00010092
[    5.855964] RAX: 00000fff00000000 RBX: 0000000000000001 RCX: ffff917637d00000
[    5.857004] RDX: 000000000001e664 RSI: 0000000000000001 RDI: ffff917503463800
[    5.857961] RBP: 0000000000000001 R08: ffffffffa2056600 R09: 0000000000000000
[    5.858953] R10: ffffffffa2057e20 R11: 0000000000000003 R12: ffff9175035fa000
[    5.859967] R13: 0000000000000cc0 R14: ffff9175035fa000 R15: 0000000000000001
[    5.860958] FS:  00007f0541dfe940(0000) GS:ffff917637d00000(0000) knlGS:0000000000000000
[    5.862043] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.862822] CR2: ffffa17537d00038 CR3: 0000000100324001 CR4: 00000000003706e0
[    5.863916] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.864896] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.865911] BUG: unable to handle page fault for address: ffffa17537d00000
[    5.866933] #PF: supervisor write access in kernel mode
[    5.867748] #PF: error_code(0x0002) - not-present page
[    5.868462] PGD 100013067 P4D 100013067 PUD 0
[    5.869078] Oops: 0002 [#2] PREEMPT SMP PTI
[    5.869681] CPU: 1 PID: 1 Comm: systemd Tainted: G      D           5.19.0-bisect6-00059-g6e33fa094f1f #6
[    5.870978] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
[    5.873226] RIP: 0010:__cgroup_account_cputime_field+0x3c/0x90
[    5.874086] Code: 53 e8 b8 99 f7 ff 49 8b 9c 24 08 03 00 00 e8 9b 5b 95 00 89 c0 48 03 1c c5 a0 58 58 a1 83 fd 01 76 3a 83 ed 02 83 fd 02 77 03 <4c> 01 2b e8 7c 5b 95 00 4c 89 e7 89 c6 e8 c2 fc ff ff bf 01 00 00
[    5.876610] RSP: 0018:ffff97f3000cce90 EFLAGS: 00010093
[    5.877501] RAX: 0000000000000001 RBX: ffffa17537d00000 RCX: 0000000080010001
[    5.878495] RDX: 0000000000000000 RSI: ffffffffa14ebec1 RDI: ffffffffa14f66a5
[    5.879453] RBP: 0000000000000000 R08: 0000000000010000 R09: 000000000000000b
[    5.880430] R10: 0000000000000022 R11: 00000000fffb9332 R12: ffff917503463800
[    5.881453] R13: 00000000000f177d R14: ffff917637d1e040 R15: ffff917637d1e540
[    5.883045] FS:  00007f0541dfe940(0000) GS:ffff917637d00000(0000) knlGS:0000000000000000
[    5.884195] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.884973] CR2: ffffa17537d00000 CR3: 0000000100324001 CR4: 00000000003706e0
[    5.886588] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.887577] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.888536] Call Trace:
[    5.888892]  <IRQ>
[    5.889193]  account_system_index_time+0x8c/0xa0
[    5.889833]  update_process_times+0x1f/0xb0
[    5.890416]  ? update_wall_time+0x7/0x20
[    5.890964]  tick_sched_handle+0x2f/0x40
[    5.891509]  tick_sched_timer+0x6a/0x80
[    5.892043]  ? tick_sched_do_timer+0x90/0x90
[    5.892634]  __hrtimer_run_queues+0x122/0x2c0
[    5.893331]  hrtimer_interrupt+0xf9/0x210
[    5.893979]  __sysvec_apic_timer_interrupt+0x77/0x160
[    5.894706]  sysvec_apic_timer_interrupt+0x85/0xb0
[    5.895387]  </IRQ>
[    5.895712]  <TASK>
[    5.896117]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[    5.897454] RIP: 0010:_raw_spin_unlock_irq+0x9/0x30
[    5.898124] Code: 05 9c 1e 34 5f 85 c0 74 05 c3 cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 c6 07 00 fb bf 01 00 00 00 <e8> 82 9f 61 ff 65 8b 05 6b 1e 34 5f 85 c0 74 05 c3 cc cc cc cc 0f
[    5.900937] RSP: 0018:ffff97f30001fee0 EFLAGS: 00000202
[    5.901729] RAX: ffff9175001c0000 RBX: ffff9175001f8000 RCX: 0000000000000000
[    5.902720] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000001
[    5.903676] RBP: 0000000000000000 R08: 00000000ffffdfff R09: 00000000ffffdfff
[    5.904677] R10: ffffffffa1856fa0 R11: ffffffffa1856fa0 R12: 0000000000000009
[    5.905692] R13: 0000000000000046 R14: 0000000000000000 R15: 0000000000000000
[    5.906826]  do_exit+0x5f/0xa70
[    5.907297]  make_task_dead+0x4c/0x50
[    5.907892]  rewind_stack_and_make_dead+0x17/0x17
[    5.908586] RIP: 0033:0x7f05429637d7
[    5.909167] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 54 24 28 64 48 2b 14 25
[    5.911947] RSP: 002b:00007ffe006571f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[    5.913130] RAX: ffffffffffffffda RBX: 000055bacd0216f0 RCX: 00007f05429637d7
[    5.914121] RDX: 0000000000080241 RSI: 000055bacd12dd00 RDI: 00000000ffffff9c
[    5.915078] RBP: 000055bacd12dd00 R08: 0000000000000004 R09: 0000000000000001
[    5.916039] R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
[    5.916997] R13: 000055bacd0216f0 R14: 0000000000000001 R15: 0000000000000001
[    5.917966]  </TASK>
[    5.918357] Modules linked in:
[    5.918792] CR2: ffffa17537d00000
[    5.919262] ---[ end trace 0000000000000000 ]---



Greetings,

Andres Freund
