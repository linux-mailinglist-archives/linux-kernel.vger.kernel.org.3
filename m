Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E600515F82
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243661AbiD3RWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiD3RWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:22:42 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB82B5BE46;
        Sat, 30 Apr 2022 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1651339126;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=H9264hq9+6/fXid3WHSsuBSCm11RWKueGs+ohy0GjKc=;
    b=lwKxzY/3SlHFre6dhUwvjABYZctKxDn/ZT2lJ37JvhTAlp4n+i5yb12kyaK+WzBPGW
    eJdhAXjUSN1zhG4PqECGy4HHGDaH4wN2VfK9OMPZYUR6k97tSuC+HduP2m2Gvp09/+Z1
    Httt9EpLA8Ca+5QAH391DQGtLHX2TzrEOIBf3PezpSfaBQs14j3n+nZLbe2LPPE263jn
    E1FX0u/0lvxLRkk0BuUgm0raCkQVw7/Pm/6MhVGLeS62uHD/pmWAoRTKzobMQXNuhkYj
    sknYyO8I6WVfSwJNH0Uu7xn/Csb20BtTkKpcw+CC79Kt++pVYMILEOIscRcwJ7tGnIH0
    movQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDOsdZY="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy3UHIjMdB
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 30 Apr 2022 19:18:45 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: kernel panic with v5.18-rc1 on OpenPandora (only)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAK8P3a3EFfF0gr5kFkboRfJifrY-D+NgHFekBfSePWuY2c8PMA@mail.gmail.com>
Date:   Sat, 30 Apr 2022 19:18:45 +0200
Cc:     Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11504A17-6B50-4D6C-A9E1-CA943C157C93@goldelico.com>
References: <FA654A0D-29B7-4B6B-B613-73598A92ADA8@goldelico.com>
 <YmkBAsa+fKlp/GcV@atomide.com>
 <CAK8P3a3N9WBWC_ECB0pSRHUCT4iz=tdT+Dt9Cyd5Wh3qEaVqqA@mail.gmail.com>
 <4CE23DC3-B3E5-45C1-91F3-B88E5444AE7C@goldelico.com>
 <CAK8P3a3EFfF0gr5kFkboRfJifrY-D+NgHFekBfSePWuY2c8PMA@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> Am 30.04.2022 um 17:36 schrieb Arnd Bergmann <arnd@arndb.de>:
>=20
> On Sat, Apr 30, 2022 at 3:16 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>> Am 27.04.2022 um 11:37 schrieb Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Apr 27, 2022 at 10:38 AM Tony Lindgren <tony@atomide.com> =
wrote:
>>=20
>>> You said that it still crashes without the wl1251
>>> driver, so I assume
>>> there is at least one more related bug. If you get a different call
>>> chain without the
>>> driver, or with the kmalloc() call, can you post that as well?
>>=20
>> For some time it did disappear but reported  e.g.
>>=20
>> [   29.457946] omap_hsmmc 480ad000.mmc: found wl1251
>> [   29.516174] wl1251: ERROR unsupported chip id: 0xdb0aea56
>=20
> That does point to invalid DMA addresses.

Ok.

>=20
>> (value did change a little randomly), but just before sending out =
this mail I tried
>> again (now with v5.18-rc4) and got this log (with wl1251 driver fixed =
as below):
>>=20
>> [   31.069580] 1ec0: 00000000 c11198c0 c103226c 0000001a 00000000 =
c017d654 c1032200 c37c0a40
>> [   31.078155] 1ee0: 00000000 c1032200 c103226c c1032218 e0001f84 =
c0c77370 c37c0a40 c0def3c0
>> [   31.086761] 1f00: c0d02080 c017d78c c1032200 c103226c c1032218 =
c017d7f0 c1032200 c103226c
>> [   31.095336] 1f20: c1032218 c0181ee0 e0001f50 00000000 ffffffff =
c017cf6c e0001f50 c08b4d7c
>> [   31.103942] 1f40: c01013c4 600f0113 ffffffff c0100bec c37c0a40 =
c0c7e6c0 00000000 1ed15000
>> [   31.112548] 1f60: c0c7e6c0 c0c7e6c0 00000040 c0d02d00 c0c77370 =
c37c0a40 c0def3c0 c0d02080
>> [   31.121154] 1f80: c0c7d850 e0001fa0 c0101390 c01013c4 600f0113 =
ffffffff 00000051 c0101390
>> [   31.129730] 1fa0: e01b9e94 c37c0a40 c37c0a40 00400000 0000000a =
ffff96d9 c1037850 c0c7e6c0
>> [   31.138336] 1fc0: c0d02d00 c0c7e6c0 c37c0a40 c37c0a40 600f0113 =
ffffffff e01b9e94 c37c0a40
>> [   31.146911] 1fe0: c37c0a40 e01b9f60 e01b9e58 c0137314 c0158434 =
c013740c c0158434 c04c9c6c
>> [   31.155517]  omap3_l3_app_irq from =
__handle_irq_event_percpu+0xb0/0x1dc
>> [   31.162475]  __handle_irq_event_percpu from =
handle_irq_event_percpu+0xc/0x38
>> [   31.169891]  handle_irq_event_percpu from =
handle_irq_event+0x38/0x5c
>> [   31.176605]  handle_irq_event from handle_level_irq+0x7c/0xb4
>> [   31.182647]  handle_level_irq from handle_irq_desc+0x1c/0x2c
>> [   31.188629]  handle_irq_desc from =
generic_handle_arch_irq+0x28/0x3c
>> [   31.195220]  generic_handle_arch_irq from __irq_svc+0x8c/0xcc
>> [   31.201263] Exception stack(0xe0001f50 to 0xe0001f98)
>> [   31.206604] 1f40:                                     c37c0a40 =
c0c7e6c0 00000000 1ed15000
>> [   31.215179] 1f60: c0c7e6c0 c0c7e6c0 00000040 c0d02d00 c0c77370 =
c37c0a40 c0def3c0 c0d02080
>> [   31.223785] 1f80: c0c7d850 e0001fa0 c0101390 c01013c4 600f0113 =
ffffffff
>> [   31.230743]  __irq_svc from __do_softirq+0x84/0x304
>> [   31.235870]  __do_softirq from __irq_exit_rcu+0x8c/0xd4
>> [   31.241363]  __irq_exit_rcu from irq_exit+0x8/0x10
>> [   31.246429]  irq_exit from call_with_stack+0x18/0x20
>> [   31.251647]  call_with_stack from __irq_svc+0x98/0xcc
>> [   31.256988] Exception stack(0xe01b9e60 to 0xe01b9ea8)
>> [   31.262298] 9e60: df993a40 c37c0a40 00000000 00000001 df993a40 =
c3245000 c133c2c0 00000002
>> [   31.270904] 9e80: c37c0a40 00000000 e01b9f60 e01b9edc e01b9ee0 =
e01b9eb0 c08ba55c c0158434
>> [   31.279479] 9ea0: 600f0113 ffffffff
>> [   31.283172]  __irq_svc from finish_task_switch+0x12c/0x1ec
>> [   31.288940]  finish_task_switch from __schedule+0x3cc/0x558
>> [   31.294799]  __schedule from schedule+0x70/0xc0
>> [   31.299591]  schedule from do_work_pending+0x30/0x3dc
>> [   31.304901]  do_work_pending from slow_work_pending+0xc/0x20
>> [   31.310852] Exception stack(0xe01b9fb0 to 0xe01b9ff8)
>> [   31.316192] 9fa0:                                     00002cf8 =
00000000 50000000 b6f99000
>> [   31.324768] 9fc0: b6f9bcfc b6f9bcf8 00000000 00000000 00000010 =
00000000 00001e94 00000000
>> [   31.333374] 9fe0: b6f9bcf8 bea66f80 b6f9bcfc 004bfc6a 40070030 =
ffffffff
>> [   31.340332] Code: e0000002 e0011003 e1901001 0a000002 (e7f001f2)
>> [   31.346740] ---[ end trace 0000000000000000 ]---
>=20
>=20
> I suppose this could be anywhere then. The backtrace seems to point
> to re-enabling interupts in do_work_pending, so something probably
> accessed DMA memory asynchronously.

Yes. I now (or still) sometimes see the same omap l3 irq issue when =
plugging in/out the USB/OTG
cable. Not with a kernel panic, but in the same driver omap_l3_smx.c.
This happens even if the wl1251 driver is removed.

root@letux:~# [ 1010.707519] In-band Error seen by USB_OTG  at address 0
[ 1010.713195] ------------[ cut here ]------------
[ 1010.718109] WARNING: CPU: 0 PID: 1860 at =
drivers/bus/omap_l3_smx.c:152 omap3_l3_app_irq+0xdc/0x120
[ 1010.727691] Modules linked in: pvrsrvkm_omap3_sgx530_121 =
snd_soc_pcm1773 snd_soc_omap3pandora leds_gpio pandora_bl =
display_connector snd_soc_omap_mcbsp snd_soc_ti_sdma omap_sham omap3_isp =
usb_f_ecm videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 =
videobuf2_common v4l2_fwnode v4l2_async videodev bq27xxx_battery_hdq mc =
g_ether usb_f_rndis u_ether libcomposite configfs omap_aes_driver =
crypto_engine omap_crypto omap_hdq omap2430 panel_tpo_td043mtea1 ads7846 =
phy_twl4030_usb musb_hdrc twl4030_pwrbutton twl4030_madc twl4030_charger =
snd_soc_twl4030 industrialio twl4030_keypad bq27xxx_battery_i2c =
bq27xxx_battery pandora_nub ehci_omap omapdrm drm_kms_helper syscopyarea =
sysfillrect cfg80211 sysimgblt fb_sys_fops drm =
drm_panel_orientation_quirks cec ip_tables x_tables ipv6 autofs4
[ 1010.801666] CPU: 0 PID: 1860 Comm: kworker/0:5 Not tainted =
5.18.0-rc4-letux+ #9499
[ 1010.809753] Hardware name: Generic OMAP3 (Flattened Device Tree)
[ 1010.816131] Workqueue: events omap_musb_mailbox_work [omap2430]
[ 1010.822570]  unwind_backtrace from show_stack+0x10/0x14
[ 1010.828186]  show_stack from dump_stack_lvl+0x40/0x4c
[ 1010.833648]  dump_stack_lvl from __warn+0xb0/0x168
[ 1010.838806]  __warn from warn_slowpath_fmt+0x70/0x9c
[ 1010.844146]  warn_slowpath_fmt from omap3_l3_app_irq+0xdc/0x120
[ 1010.850494]  omap3_l3_app_irq from =
__handle_irq_event_percpu+0xb0/0x1dc
[ 1010.857574]  __handle_irq_event_percpu from =
handle_irq_event_percpu+0xc/0x38
[ 1010.865081]  handle_irq_event_percpu from handle_irq_event+0x38/0x5c
[ 1010.871887]  handle_irq_event from handle_level_irq+0x7c/0xb4
[ 1010.878051]  handle_level_irq from handle_irq_desc+0x1c/0x2c
[ 1010.884124]  handle_irq_desc from generic_handle_arch_irq+0x28/0x3c
[ 1010.890838]  generic_handle_arch_irq from call_with_stack+0x18/0x20
[ 1010.897552]  call_with_stack from __irq_svc+0x98/0xcc
[ 1010.902954] Exception stack(0xe0135de8 to 0xe0135e30)
[ 1010.908355] 5de0:                   fa0ab000 0000040c 00000001 =
00000000 c3708040 c36882c0
[ 1010.917083] 5e00: 00000000 c1247094 e0135e8c 00000000 c1247094 =
c1115094 00000000 e0135e38
[ 1010.925781] 5e20: bf1b6548 bf1b6550 60070013 ffffffff
[ 1010.931152]  __irq_svc from omap2430_runtime_resume+0x58/0x94 =
[omap2430]
[ 1010.938354]  omap2430_runtime_resume [omap2430] from =
__rpm_callback+0x3c/0x11c
[ 1010.946105]  __rpm_callback from rpm_callback+0x2c/0x54
[ 1010.951721]  rpm_callback from rpm_resume+0x3d4/0x4e0
[ 1010.957122]  rpm_resume from rpm_resume+0x37c/0x4e0
[ 1010.962341]  rpm_resume from __pm_runtime_resume+0x38/0x50
[ 1010.968200]  __pm_runtime_resume from =
omap_musb_set_mailbox+0x1c/0x14c [omap2430]
[ 1010.976226]  omap_musb_set_mailbox [omap2430] from =
process_one_work+0x1ac/0x2e8
[ 1010.984069]  process_one_work from worker_thread+0x21c/0x2cc
[ 1010.990112]  worker_thread from kthread+0xf0/0xfc
[ 1010.995208]  kthread from ret_from_fork+0x14/0x2c
[ 1011.000244] Exception stack(0xe0135fb0 to 0xe0135ff8)
[ 1011.005645] 5fa0:                                     00000000 =
00000000 00000000 00000000
[ 1011.014343] 5fc0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
[ 1011.023040] 5fe0: 00000000 00000000 00000000 00000000 00000013 =
00000000
[ 1011.030059] ---[ end trace 0000000000000000 ]---

>=20
>=20
>>=20
>> rm -rf =
lib/modules/5.18.0-rc4-letux+/kernel/drivers/net/wireless/ti/wl1251
>>=20
>> done on the SD card makes the problems go away.
>=20
> Good, so I guess that means there is another bug in wl1251 DMA =
handling,
> while everything else is fine.

It looks as if there are two bugs. One inside wl1251 and one outside. =
The latter
seems to be omap3530 or Pandora specific since I don't see it on dm3730 =
/ GTA04.
If I find time I'll try to reproduce the usb/otg issue on the oldest =
BeagleBoard.
Then we can find out if it is really an omap3530 issue or only =
OpenPandora specific.

>=20
>> diff --git a/drivers/net/wireless/ti/wl1251/io.c =
b/drivers/net/wireless/ti/wl1251/io.c
>> index 5ebe7958ed5c7..76aceecc281fb 100644
>> --- a/drivers/net/wireless/ti/wl1251/io.c
>> +++ b/drivers/net/wireless/ti/wl1251/io.c
>> @@ -121,7 +121,13 @@ void wl1251_set_partition(struct wl1251 *wl,
>>                          u32 mem_start, u32 mem_size,
>>                          u32 reg_start, u32 reg_size)
>> {
>> -       struct wl1251_partition partition[2];
>> +       struct wl1251_partition_set *partition;
>> +
>> +       partition =3D kmalloc(sizeof(*partition), GFP_KERNEL);
>> +       if (!partition) {
>> +               wl1251_error("can not set partition");
>> +               return;
>> +       }
>>=20
>>        wl1251_debug(DEBUG_SPI, "mem_start %08X mem_size %08X",
>>                     mem_start, mem_size);
>> @@ -164,10 +170,10 @@ void wl1251_set_partition(struct wl1251 *wl,
>>                             reg_start, reg_size);
>>        }
>>=20
>> -       partition[0].start =3D mem_start;
>> -       partition[0].size  =3D mem_size;
>> -       partition[1].start =3D reg_start;
>> -       partition[1].size  =3D reg_size;
>> +       partition->mem.start =3D mem_start;
>> +       partition->mem.size  =3D mem_size;
>> +       partition->reg.start =3D reg_start;
>> +       partition->reg.size  =3D reg_size;
>>=20
>>        wl->physical_mem_addr =3D mem_start;
>>        wl->physical_reg_addr =3D reg_start;
>> @@ -176,5 +182,7 @@ void wl1251_set_partition(struct wl1251 *wl,
>>        wl->virtual_reg_addr =3D mem_size;
>>=20
>>        wl->if_ops->write(wl, HW_ACCESS_PART0_SIZE_ADDR, partition,
>> -               sizeof(partition));
>> +               sizeof(*partition));
>> +
>=20
> Changing the type of the structure looks a bit odd, but it does seem
> like a valid transformation otherwise.

Well, the new struct has two substructs of the original type which
essentially changes from array size 2 to named substruct access.

The definition of the new struct wl1251_partition_set already exists
in the header since 2009 but was nowhere actively used.

>=20
> I see more callers of wl1251_mem_write() or wl1251_mem_read() with
> on-stack arguments in wl1251_tx_complete(), wl1251_event_wait(),
> and wl1251_event_handle(). Those will need the same kmalloc()
> change as your wl1251_set_partition() fix I think.

I had searched for ops->write() calls but didn't think about more =
indirect
calls... Yes, they likely need fixes as well. I'll test/add before I
submit any patch.

> If that's not enough, try enabling CONFIG_DMA_API_DEBUG
> to get an is_vmalloc_address() check on every DMA operation.

Ok.

BR and thanks,
Nikolaus

