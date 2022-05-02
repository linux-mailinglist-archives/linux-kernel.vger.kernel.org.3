Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533D75178D3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358542AbiEBVMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiEBVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:12:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFDDBC32;
        Mon,  2 May 2022 14:08:49 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MUD7D-1nM1Kt3pRb-00RGrv; Mon, 02 May 2022 23:03:45 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f7c424c66cso161902457b3.1;
        Mon, 02 May 2022 14:03:43 -0700 (PDT)
X-Gm-Message-State: AOAM532nk+fjKBblBr5KOBMlJG8zhtCoFIjmhOB+tG1CTVFQyTS6WonI
        hhYJjX49doIz9jpaHy+qjov5Hoa6/Wa989TvUvI=
X-Google-Smtp-Source: ABdhPJxEvI0WTai1d3ZR4KU3iW8w7Gb+IOi/NcLSYY9Kzki6UUTmpSHsKHSdyZ16RsjoU/k3UwknsKUnnDH1BVJBWs0=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr13273488ywk.209.1651525422593; Mon, 02
 May 2022 14:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net>
 <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net> <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net> <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
 <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
 <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net> <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
 <b13783aa-9225-d52a-3800-c97ad772688b@roeck-us.net> <CAK8P3a3S5OjkKq_u5FpnwzYv+0+typya6Z4MzTez5ZH+do00xQ@mail.gmail.com>
 <CAK8P3a3jiqf_zpBsZyvAb5ZtkwDa7KkqExqDAdpY_pYqkr_NgQ@mail.gmail.com>
 <4dcdbfe2-9edf-320b-d123-3b62c8b5e28e@roeck-us.net> <CAK8P3a0ogn1wgPBDHkT=Fb8ufA+y8Ax1Qov2-vRXfC08QqnrQA@mail.gmail.com>
 <c001d58e-9a78-6338-a533-d0f215b3dfd1@roeck-us.net>
In-Reply-To: <c001d58e-9a78-6338-a533-d0f215b3dfd1@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 2 May 2022 23:03:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1X3YH0RqqmqgqFAaY94yreD-PfY-pvyMf+xU3nGeqvsg@mail.gmail.com>
Message-ID: <CAK8P3a1X3YH0RqqmqgqFAaY94yreD-PfY-pvyMf+xU3nGeqvsg@mail.gmail.com>
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/joxRaMGePOF01MqV1QGoIoZWu3WwV1HQObDeZSXbv+T/lBO/Rv
 EJECBT2RUm6qvSkBRo7Br4Ri8l1QKVcJ4ANXIpAVZFPPL8jrl5j2ovnfIW2GkDgf8ow29gK
 VTpIVJTZYpPdQfnctLOdBaWssicqmi5BtQB2YcyBud1PekF7Qq2tfakDXPfweccQM1ycW/R
 PdaOJE29usJKTbFThWI0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ap0WPyLi164=:+0AQX6UBn9LqGpi++LE7vV
 al9wtPgFUvMWY4SJdTHMceJ8vZfXTHJrTj/hswM893TIoIQOBpS13iPKKlDOtOcBVE+ZdDEWF
 SQ1KNV0WKqjR3Lf+IjxjXZxv++YhnQ5hbc2XuNOTDQTwxz3fol609HrPykfBUoTl/VZ3jRzhH
 xpPDChtue47vuHi2cNcttsZg1IifmF/neyMOj8io7ICStuvyS/LM+mKnDOV4uk+EVbbud8flr
 a5c6L7oxklcl/dq8G1DWeyuVQXqeDBg0aedL5yIiDR7kY7YEXZNaXd/G7GTBIF25UBwdKu7lN
 tk6bkD7n3OVI7FnC6eC6hHOb3EHXX3KiGMSHbEZ08C3MNsqRXhv9oTrcmMCAkwwmfLPCDORTe
 COK/hoT/orJU9QVMNH5fJpYjOM+Mol2uC8KEnsyd78hRk7WCjeQ1uli/Hi4P0Rn3C/qPJdfRi
 UfvjOz2cKojlO/+DwscaZNe63pG1ox2YVKyZ5ws+5/MmARiGFabchPX87l6Y8vsIutSd5pDLJ
 OWfrSFcP/TMr/Bgip1Jv6NWTtJwiwpXKWn9MiIIqQxrIY/pT5vcmZYRcE3q7Cgy7W3AfSpmqQ
 Na7D+rAV+Ra50lDz7H8xEz02EwVCzoCdY21BbPj1wQhRiyZNmK6PlHKsVUqJlDj8FKeKjU7jF
 vZprx8GdmTy8NF07D41xZhIW9ZZ/TQVKA0XT/i+Z0N89JSa6RjrM6uFP7gq+qalzrHvWpRqpu
 wg8VboU8hnLIY/ZYEdnLJRN/cKu8OFrHu0wJpOfU7BqW62ciZFZg8mclO1RBqCyqD7aK6hZE3
 GwIU3CvO/MmBbfMWIYknOj+dSvhYy9r7Xkdvmr9W7hdd8qA4vw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 10:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 5/2/22 12:21, Arnd Bergmann wrote:
> >
>
> To boot from initrd:
>
> qemu-system-arm -M z2 -kernel \
>       arch/arm/boot/zImage -no-reboot -initrd \
>       rootfs-armv5.cpio --append \
>       "panic=-1 slub_debug=FZPUA rdinit=/sbin/init console=ttyS0" -nographic \
>       -monitor null -serial stdio
>
> where rootfs-armv5.cpio is from my repository at github.com.
>
> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/rootfs-armv5.cpio.gz
>

Ok, that works here with any configuration, I don't see a regression.
Could this be a problem with the size increase? The machine only has
32MB of RAM, so it's possible that the multiplatform-enabled kernel
with DT support etc pushes it over the edge, especially with an initramfs.

My configuration is clearly a bit different from yours, so I tried giving it
a larger initramfs file, which randomly crashes elsewhere for me:

[    0.648659] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 38,
base_baud = 928571) is a UART1
[    0.697984] kworker/u2:0 invoked oom-killer:
gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
[    0.698278] CPU: 0 PID: 7 Comm: kworker/u2:0 Not tainted
5.18.0-rc1-00109-gee927ad51300-dirty #52
[    0.698382] Hardware name: Zipit Z2
[    0.698520] Workqueue: events_unbound async_run_entry_fn
[    0.699063]  unwind_backtrace from show_stack+0x18/0x1c
[    0.699148]  show_stack from dump_header+0x68/0x254
[    0.699186]  dump_header from out_of_memory+0x474/0x4f0
[    0.699208]  out_of_memory from __alloc_pages+0xa0c/0xb84
[    0.699227]  __alloc_pages from shmem_getpage_gfp.constprop.0+0x270/0x9e0
[    0.699247]  shmem_getpage_gfp.constprop.0 from
generic_perform_write+0xd8/0x210
[    0.699268]  generic_perform_write from __generic_file_write_iter+0x130/0x198
[    0.699286]  __generic_file_write_iter from generic_file_write_iter+0x64/0xd0
[    0.699302]  generic_file_write_iter from __kernel_write+0x114/0x2b0
[    0.699321]  __kernel_write from kernel_write+0x68/0x194
[    0.699337]  kernel_write from xwrite+0x3c/0x78
[    0.699363]  xwrite from do_copy+0xc0/0x11c
[    0.699381]  do_copy from write_buffer+0x2c/0x44
[    0.699397]  write_buffer from flush_buffer+0x3c/0xa0
[    0.699413]  flush_buffer from __gunzip+0x2a4/0x364
[    0.699434]  __gunzip from gunzip+0x2c/0x34
[    0.699449]  gunzip from unpack_to_rootfs+0x19c/0x304
[    0.699465]  unpack_to_rootfs from do_populate_rootfs+0x6c/0x1dc
[    0.699483]  do_populate_rootfs from async_run_entry_fn+0x44/0x1a0
[    0.699502]  async_run_entry_fn from process_one_work+0x1e8/0x544
[    0.699520]  process_one_work from worker_thread+0x34/0x578
[    0.699579]  worker_thread from kthread+0xdc/0x114
[    0.699599]  kthread from ret_from_fork+0x14/0x2c
[    0.699651] Exception stack(0xc2821fb0 to 0xc2821ff8)
[    0.699711] 1fa0:                                     00000000
00000000 00000000 00000000
[    0.699731] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    0.699744] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.699801] Mem-Info:
[    0.699889] active_anon:90 inactive_anon:674 isolated_anon:0
[    0.699889]  active_file:0 inactive_file:0 isolated_file:0
[    0.699889]  unevictable:0 dirty:0 writeback:0
[    0.699889]  slab_reclaimable:0 slab_unreclaimable:1691
[    0.699889]  mapped:0 shmem:771 pagetables:0 bounce:0
[    0.699889]  kernel_misc_reclaimable:0
[    0.699889]  free:207 free_pcp:37 free_cma:0
[    0.699986] Node 0 active_anon:360kB inactive_anon:2696kB
active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:3084kB
writeback_tmp:0kB kernel_stack:192kB pagetables:0kB all_unreclaimable?
yes
[    0.700116] Normal free:828kB boost:1024kB min:1464kB low:1572kB
high:1680kB reserved_highatomic:0KB active_anon:360kB
inactive_anon:2696kB active_file:0kB inactive_file:0kB unevictable:0kB
writepending:0kB present:32768kB managed:12232kB mlocked:0kB
bounce:0kB free_pcp:148kB local_pcp:148kB free_cma:0kB
[    0.700177] lowmem_reserve[]: 0 0
[    0.700247] Normal: 3*4kB (UM) 2*8kB (UM) 2*16kB (M) 0*32kB 0*64kB
0*128kB 1*256kB (M) 1*512kB (M) 0*1024kB = 828kB

       Arnd
