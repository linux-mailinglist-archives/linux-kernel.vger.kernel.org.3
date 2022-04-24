Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFA450D0F9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbiDXKDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiDXKDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:03:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674671AF3C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:00:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so24322063ejd.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=P55Y/SJVnoSby1N/Db7XNppOHoY1N8oo0R/mys09XlE=;
        b=aFKZYKYH/om1ozRoRafE2N8A/rHdONJKhjY4XSq15BNKTDtw1DMUdQEPWYcaIRupTV
         5sU85mk0RNjD8yOR9iES6tPiDZZu2fgqonjiSz/wEZ+H5utpjeqBdYAjSZuWWpAwe/4S
         Zlnm2kyA8R7sdzfRq7nHnwVhYSOnWx5s5eBHVJC2vK1LNlQgVHVHIQvBmSQjeHLFtmtk
         QFEJkBarSnNuZ4sT0D4NUuL35quue9T99ACzBfwmCzRkBJ3sJ37CrK3+Cv4qkBsiiwcP
         6Ee5OnR5GtqLDE6Ef7/sNqYnLKU5UCRz4XsV58Nf4O4b9zZdtFZjMCy9HDqJbm9EKZJ3
         Wjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=P55Y/SJVnoSby1N/Db7XNppOHoY1N8oo0R/mys09XlE=;
        b=4jpI7FXl1AIz6UEZLLvUSvz1qiVzNdCjGw1jPRKbsLF1rhKvtz7nBcykKlA0Mxib1j
         xgP+QQnmX5fz06prNwb2F58KVhmgwzknYcGps+erwZfPMYnDr4gbMYzPZNoyNUCSL16y
         SOy4e3nNrhDJFPKgkzrYI63ZlRQdQv1ZQaejglyiFvsw4ArN+DENuSyzpmhuX4987DR/
         SVBrHoxYpENxDRPIlHoTenWUNixzWhVFle3CZj5e4ynBc9g+d6n3hZUVeXZ6KcGkyeme
         jeurQSJJ9D2Z6dariC4hmGuEftmh92JyvefiPscqSNj4D0atFZ3rogjQlarNev/1Ziru
         bJ+Q==
X-Gm-Message-State: AOAM530sQBSCA+jYbXnylSUteIiOQ6rs/xkxImaORihRgKX+vviXnTSH
        LjX/XJN9m5MLon3K/jeDtc0=
X-Google-Smtp-Source: ABdhPJyHEXIoYphZBWhHML6h2C7h+n9hdxRFZDPGt8nt1Ae+ZJW3eHWhQ9rgf4Ku7jAIvebQOCiI3g==
X-Received: by 2002:a17:906:9c82:b0:6e1:1d6c:914c with SMTP id fj2-20020a1709069c8200b006e11d6c914cmr11140797ejc.769.1650794413855;
        Sun, 24 Apr 2022 03:00:13 -0700 (PDT)
Received: from [192.168.0.151] (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id z3-20020a50cd03000000b00425d72fd0besm1228137edi.97.2022.04.24.03.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 03:00:13 -0700 (PDT)
Message-ID: <67e2d10b-7f0f-9c5a-ce31-376b83ffba9e@gmail.com>
Date:   Sun, 24 Apr 2022 12:00:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Solomon Tan <wjsota@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Straube <straube.linux@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Subject: [BUG] staging: r8188eu: KASAN: slab-out-of-bounds in rtw_cmd_thread
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks like
commit 0afaa121813e ("staging: r8188eu: use in-kernel ieee channel")
intoduced a. See KASAN output below.

That commit replaced the use of struct rtw_ieee80211_channel with struct
ieee80211_channel.

There are several calls to memcpy that used sizeof(struct 
rtw_ieee80211_channel)
and now use sizeof(struct ieee80211_channel) but the sizes of these two 
structures are not equal.

regards,
Michael

dmesg:

  ==================================================================
[  422.214237] BUG: KASAN: slab-out-of-bounds in 
rtw_cmd_thread+0x1e8/0x430 [r8188eu]
[  422.214277] Write of size 3600 at addr ffff8881e149d200 by task 
RTW_CMD_THREAD/2563

[  422.214289] CPU: 11 PID: 2563 Comm: RTW_CMD_THREAD Tainted: G 
C OE     5.18.0-rc2-staging+ #47 94e3ca73bebf5b7fec506721475e4fff2a023bb9
[  422.214301] Hardware name: Gigabyte Technology Co., Ltd. B550M 
S2H/B550M S2H, BIOS F15a 02/16/2022
[  422.214309] Call Trace:
[  422.214313]  <TASK>
[  422.214317]  dump_stack_lvl+0x45/0x5b
[  422.214327]  print_report.cold+0x5e/0x5dc
[  422.214335]  ? kasan_set_track+0x21/0x30
[  422.214342]  ? kasan_set_free_info+0x20/0x40
[  422.214349]  ? rtw_cmd_thread+0x1e8/0x430 [r8188eu 
91924fe1575bf49b9b37985ffde2c585d847446d]
[  422.214386]  kasan_report+0xab/0x120
[  422.214394]  ? rtw_cmd_thread+0x1e8/0x430 [r8188eu 
91924fe1575bf49b9b37985ffde2c585d847446d]
[  422.214430]  kasan_check_range+0xf6/0x1d0
[  422.214436]  memcpy+0x39/0x60
[  422.214442]  rtw_cmd_thread+0x1e8/0x430 [r8188eu 
91924fe1575bf49b9b37985ffde2c585d847446d]
[  422.214479]  ? rtw_setassocsta_cmdrsp_callback+0xd0/0xd0 [r8188eu 
91924fe1575bf49b9b37985ffde2c585d847446d]
[  422.214516]  kthread+0x15d/0x190
[  422.214523]  ? kthread_complete_and_exit+0x20/0x20
[  422.214531]  ret_from_fork+0x22/0x30
[  422.214540]  </TASK>

[  422.214546] Allocated by task 2522:
[  422.214551]  kasan_save_stack+0x1e/0x40
[  422.214555]  __kasan_kmalloc+0xa9/0xe0
[  422.214559]  rtw_init_cmd_priv+0xd6/0x1b0 [r8188eu]
[  422.214589]  rtw_init_drv_sw+0x21/0x370 [r8188eu]
[  422.214619]  rtw_drv_init+0x3a6/0x4f0 [r8188eu]
[  422.214649]  usb_probe_interface+0x155/0x340 [usbcore]
[  422.214705]  really_probe.part.0+0x11f/0x320
[  422.214709]  __driver_probe_device+0xe0/0x180
[  422.214712]  driver_probe_device+0x4d/0x170
[  422.214715]  __driver_attach+0x110/0x250
[  422.214718]  bus_for_each_dev+0xe7/0x140
[  422.214721]  bus_add_driver+0x25a/0x2b0
[  422.214723]  driver_register+0x10f/0x190
[  422.214726]  usb_register_driver+0x10e/0x1e0 [usbcore]
[  422.214780]  do_one_initcall+0x8a/0x2a0
[  422.214784]  do_init_module+0xe4/0x3b0
[  422.214787]  load_module+0x41c4/0x4650
[  422.214789]  __do_sys_finit_module+0x111/0x190
[  422.214791]  do_syscall_64+0x5c/0x80
[  422.214795]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[  422.214802] Last potentially related work creation:
[  422.214807]  kasan_save_stack+0x1e/0x40
[  422.214810]  __kasan_record_aux_stack+0xb1/0xc0
[  422.214813]  call_rcu+0xb5/0xfc0
[  422.214817]  netlink_release+0x791/0xa40
[  422.214820]  __sock_release+0x72/0x120
[  422.214824]  sock_close+0x11/0x20
[  422.214828]  __fput+0x10c/0x400
[  422.214831]  task_work_run+0x8b/0xc0
[  422.214834]  do_exit+0x5a4/0x10e0
[  422.214837]  do_group_exit+0x58/0x100
[  422.214840]  __x64_sys_exit_group+0x28/0x30
[  422.214843]  do_syscall_64+0x5c/0x80
[  422.214846]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[  422.214852] The buggy address belongs to the object at ffff8881e149d000
                 which belongs to the cache kmalloc-2k of size 2048
[  422.214862] The buggy address is located 512 bytes inside of
                 2048-byte region [ffff8881e149d000, ffff8881e149d800)

[  422.214874] The buggy address belongs to the physical page:
[  422.214879] page:000000003f187866 refcount:1 mapcount:0 
mapping:0000000000000000 index:0x0 pfn:0x1e1498
[  422.214883] head:000000003f187866 order:3 compound_mapcount:0 
compound_pincount:0
[  422.214885] flags: 
0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[  422.214891] raw: 0017ffffc0010200 ffffea0004f1ca00 dead000000000002 
ffff888100042f00
[  422.214894] raw: 0000000000000000 0000000000080008 00000001ffffffff 
0000000000000000
[  422.214896] page dumped because: kasan: bad access detected

[  422.214900] Memory state around the buggy address:
[  422.214905]  ffff8881e149d500: 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00
[  422.214914]  ffff8881e149d580: 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00
[  422.214921] >ffff8881e149d600: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  422.214927]                    ^
[  422.214932]  ffff8881e149d680: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  422.214939]  ffff8881e149d700: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[  422.214946] 
==================================================================
