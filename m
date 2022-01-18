Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF33492B65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiARQh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:37:59 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37001 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243422AbiARQh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:37:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 428473201E15;
        Tue, 18 Jan 2022 11:37:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 18 Jan 2022 11:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        date:from:to:cc:subject:message-id:mime-version:content-type; s=
        fm2; bh=kzKWvA76ooSej4gfgZrClUbuWFVSATNe1t3ug/kwcIc=; b=GgQY8eJY
        uy3NX8u1L1bo9DAgUvfgQS05c6ZiE2WAxFbGBOOzQbAOesh8NQJNmB/k9NRXpEFe
        i7sdZhrUkAh8GS+6ByqGJ3vv0+nQZq7udBFqLj6y8J+TZtWUiR3IylZ6j3uha2XJ
        6szR4UWawG1o0bskl3nx+PXIfzlboK+A9/tLQrvSYYQVUH1QU1wyzQ0HSvIeuRcN
        IhtPxTStfKublEfbWtho4HL7zUxPIQWy+f1rHP+YytHbg2+VYXsI1r7JPmZftvmI
        2xkZInSXu7BSX8SGTOEEagNpcj6pQDHWK8ukmuwAFDaqgtTuXa91VE8qAf7nEqvM
        1kNo8Tc673rfRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=kzKWvA76ooSej4gfgZrClUbuWFVSA
        TNe1t3ug/kwcIc=; b=EQ5DbdWQJGkc7FvnlOjn2xEp36NvK+370Vm7J0COQTk/Q
        fGIOU+BnARLbmB9KWc8HWKWyu3Vb0c4VQuQoz7Pa+49s/Qph5nweeOR3tYKcik3i
        nmEOdfSt5+38aOAmNEnaYfAq3gidX1VFow4JwBxCtrGq3Bgy0goBca7tUjKOKfa+
        NBUuOsx3/vqzoFOhhKPaPMU6UU3z+geshU5KKRrMbGJu+u8TCUJIf3mdcDRAR08c
        2SiHtDtf/bW1AGv4KYF3VECgVXVQSB3kx79XYDC8HfJ6OD82qMYFE5dqRfdxiFaP
        SM5uiwSJxGsIrwbMFZ6Q8ztJQzvx7VOJHBc93V0UA==
X-ME-Sender: <xms:5OzmYWGk-Hf0ihdRQ83gGTehT0N37oq5gfRw4g7xmpa4IsQAFG6iTA>
    <xme:5OzmYXU_72f1zTGeMzk4OOK2JVzxNaaLyvrj3gmL9ClMJZWSLNi2wjQhLz5hZbb5r
    j7qVXx40ntslEC_rA>
X-ME-Received: <xmr:5OzmYQJ7HSEs-FEZd2YAjxm3KJh62QNqfzny175ZR7FDGUwA959e4U2tW9_Vk5HS177HRu2dOb6PVh2nWzeHnDtFgNnRjXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesghdtreertddtvdenucfhrhhomheptehlhihsshgrucft
    ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepueeghfdvte
    eifeekhfekgfehkedvgfegudehtedttdelvddvjeetffelffeigfdtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhihlhhishhssegvvhgvrd
    hqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:5OzmYQGYzPzFW5eYnjM9_rVHpwP8RnqqwHHiPxr8L968Vvx5OXq73w>
    <xmx:5OzmYcVi3a58nb605aDXqJrpfUnBC8WukRa2L34g8yn6U0o-X6JqPA>
    <xmx:5OzmYTOogr_pUfQbd3294ROiv9jbFPLTdlKuupy7l03rwSONfhGyOg>
    <xmx:5OzmYXdCRFsMl2au2oJDAshu3S65Dpt8BbTVj8B-17kwbZ30270MVA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jan 2022 11:37:56 -0500 (EST)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 671448E27; Tue, 18 Jan 2022 16:37:54 +0000 (UTC)
Date:   Tue, 18 Jan 2022 16:37:54 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Null pointer dereference in cros-ec-typec
Message-ID: <20220118163754.nfy53mfjpazgw2a2@eve>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yiyer7cksutrzs6v"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yiyer7cksutrzs6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My distribution recently enabled the Chrome OS EC Type C control driver
in its kernel builds.  On my Google Pixelbook i7 (eve), the driver reports
a null pointer dereference at boot.  From what I can tell, this happens
because typec->ec is set to NULL in cros_typec_probe.  Other drivers,
like cros-usbpd-notify, appear to be set up to handle this case.  As a
result of this bug, I'm no longer able to reboot my computer, because
udevd hangs while trying to do something with the device whose driver
isn't working.

Here's the full Oops.  I was able to reproduce the issue with every
kernel I tried, from 5.10 to mainline.

cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chrome EC device pointer.
input: Intel Virtual Buttons as /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/INT33D6:00/input/input14
BUG: kernel NULL pointer dereference, address: 00000000000000d8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 1 PID: 561 Comm: systemd-udevd Not tainted 5.15.12 #4
Hardware name: Google Eve/Eve, BIOS MrChromebox-4.14 08/06/2021
RIP: 0010:__mutex_lock+0x59/0x8c0
Code: 53 48 89 cb 48 83 ec 70 89 75 9c be 3d 02 00 00 4c 89 45 90 e8 18 47 33 ff e8 e3 e2 ff ff 44 8b 35 a4 85 e8 02 45 85 f6 75 0a <4d> 3b 6d 68 0f 85 bf 07 00 00 65 ff 05 b6 5b 23 75 ff 75 90 4d 8d
RSP: 0018:ffffb44580a4bb50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8bf91320 RDI: ffff922cbba50e20
RBP: ffffb44580a4bbf0 R08: 0000000000000000 R09: ffff922c5bac8140
R10: ffffb44580a4bc10 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000070 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f55338d6b40(0000) GS:ffff922fae200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000d8 CR3: 000000011bbb2006 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? fs_reclaim_acquire+0x4d/0xd0
 ? lock_is_held_type+0xaa/0x120
 ? cros_ec_cmd_xfer_status+0x1f/0x110
 ? lock_is_held_type+0xaa/0x120
 ? cros_ec_cmd_xfer_status+0x1f/0x110
 cros_ec_cmd_xfer_status+0x1f/0x110
 cros_typec_ec_command+0x91/0x1c0 [cros_ec_typec]
 cros_typec_probe+0x7f/0x5a8 [cros_ec_typec]
 platform_probe+0x3f/0x90
 really_probe+0x1f5/0x3f0
 __driver_probe_device+0xfe/0x180
 driver_probe_device+0x1e/0x90
 __driver_attach+0xc4/0x1d0
 ? __device_attach_driver+0xe0/0xe0
 ? __device_attach_driver+0xe0/0xe0
 bus_for_each_dev+0x67/0x90
 bus_add_driver+0x12e/0x1f0
 driver_register+0x8f/0xe0
 ? 0xffffffffc04ec000
 do_one_initcall+0x67/0x320
 ? rcu_read_lock_sched_held+0x3f/0x80
 ? trace_kmalloc+0x38/0xe0
 ? kmem_cache_alloc_trace+0x17c/0x2b0
 do_init_module+0x5c/0x270
 __do_sys_finit_module+0x95/0xe0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f55344b1f3d
Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bb ee 0e 00 f7 d8 64 89 01 48
RSP: 002b:00007fff187f1388 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055a53acbe6e0 RCX: 00007f55344b1f3d
RDX: 0000000000000000 RSI: 00007f553461732c RDI: 000000000000000e
RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
R10: 000000000000000e R11: 0000000000000246 R12: 00007f553461732c
R13: 000055a53ad94010 R14: 0000000000000007 R15: 000055a53ad95690
 </TASK>
Modules linked in: fjes(+) cros_ec_typec(+) typec intel_vbtn(+) cros_usbpd_notify sparse_keymap soc_button_array int3403_thermal int340x_thermal_zone int3400_thermal acpi_thermal_rel cros_kbd_led_backlight zram ip_tables i915 hid_multitouch i2c_algo_bit ttm crct10dif_pclmul crc32_pclmul crc32c_intel drm_kms_helper nvme ghash_clmulni_intel sdhci_pci cqhci cec nvme_core sdhci serio_raw drm mmc_core i2c_hid_acpi i2c_hid video pinctrl_sunrisepoint fuse
CR2: 00000000000000d8
---[ end trace 4a12c4896d70352b ]---

--yiyer7cksutrzs6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmHm7N4ACgkQ+dvtSFmy
ccBrCRAAmF6grJVOlZ4n9mQigbLYWA6rDFpnSWa0H+Ua9Qd0y6XzFb3HY4MpybeV
vE7plrNxpwDRddtFZqEbcl0OWcbwTA/Vmlt+16bMd92+LxL83PeSk4fMNhhnVBdw
zQv4cfNnukPJ+M/PDwLpZRY+5mHRcc4Mzol7nAZ0R8ej2iBWPwMe/JCEZh3i7zNw
quUntxfpSaT7+A0YQch8mUBgcLyc13kfMEd/NVn8MTYoZG50yScE3DSQzx7eeGTI
x0Yqm3DtBVIF3qvjrYChrou3a7smO1sNFVARJOW2jxuR5Rl79Mp0wylpxYMUyZbI
Hz3u/skfxvrcqdKxNwxnJgk7ugTlL1zcEuc+Elmj4D65I04NI0qzTTUAsEfKjWpV
tona9Q3T5d1BGQQJc3uZmIa+fyd9wMQwKDAjMnmbueMc0Wg8aHcRfy41kVVRN1k8
ik9oVKLx2X9hN8VxFgraA8QQTAX0FiscpzEpLoCzmvMfn7yfW1SZTAy9U0NqmRxg
kdJ9atSwaOF3CLLEOnxJ9UmVJsNGn7f19Az41PuaxarlfdJu4W0MDC2Wmllc/V+m
nB1YHMwIZURpe0f1McOJhkU1+sBpyEVt4zcvX8OtjPpJzvlmYkVNIm9uR4voYrKE
0SlsYM3gmI6K+Qb0LnMhT1oEE+oxDbpwx/gU/J+dp9Xbxb69NOc=
=5hiC
-----END PGP SIGNATURE-----

--yiyer7cksutrzs6v--
