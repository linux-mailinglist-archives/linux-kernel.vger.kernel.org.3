Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A968F5B201C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiIHOGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiIHOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:05:48 -0400
Received: from sonic306-24.consmr.mail.ne1.yahoo.com (sonic306-24.consmr.mail.ne1.yahoo.com [66.163.189.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA746583F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1662645944; bh=R0HVWfmcfSD2qA8XuKX397R6A74NFE8oCdlMYg1utyA=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=R/xOhKYDfeW/6rlwU11dMJYfxDvVO8GzTLw3bKKLOteGBr84/oIA5XML+80BT4+rr48hjjJTdCVgB9T7eZrVN0DP/uJ7D/KrV79LA1N5XGGzKHjKfM1VnVKdaEtD5gLTzopjgm+scOYAk7gTyAdPQ5nAV96mg1BblzkbjYDKEkQ=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662645944; bh=nJQoEooc2Uo1v/95sZeNevEymmfgNabWPcQVPUhIfZG=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=IrqAX6uYIopu3Uvne7HoHVFvItkDosgbeGjpJloH1rFVOzcaXMROoTVd7op935jVY398lSQj7rGVwFlQJqo7mWsbEI++0UF4tAnAJHAyUA6NzH0C2hzjalvKOFRhNhtbwSL+qel1W5kc1+n1SFLEUBqhOrhsINkaakBePaMBkZtpbf9npgslA/L3MEyvvQ2hJq8Dvn0bVcz/LZKzyVY84oduKfNBXUiEO6je2wkauPK+QHFLOWh0c7m9ONXwp4G46SfghkDsqMZiPzV1x9dNgbYBWtSRt9qVrFqfDIH/lX9fK+cVrRlAYAKhNE9hSJNzTW5d9R7ZhyfmXE4nOH0mrw==
X-YMail-OSG: cOuASgYVM1kHSRY4S80E4UYZ74RkU2PVIphrTDCxr5BSmbrJ70b7LAuKj.iwZDx
 tXn__kUILqCX8dDJKB83KNPS2M_mUv_rUd0izrVxhVrH6lLI91EvWyI.u_w2NzPO3BWRAB1JEGwz
 2JeH8etadwp7frZDR0s1885lwFLA6PdFlb84AKTc1_9.aGUFoxfpumES6QaBpY_edGJ7MqDYo4bj
 nD7.FkvQ2ijsRt_d6mA2yvsRDqMXYkqkhPJvrc_m1uGmJbsd7jf473tvms7xZA60kbnQDf3FbfKN
 mC06OHg8sXGSFtah3HTwhU1VFXfIXV7aCtkW8MEZ7a.dIaqqVZtFVA4SYckXlLYIPBuv0Uxf2jOc
 TvJUH6lPMQx5_KIvK84ggxzBhAXsY3_tgSZRjIZ7fl5l0I1.438cpH4HSIfS_6Gi4oekP2azOghb
 4YKIyyFguiu9c1KLoI9Rdoj3m8jGq7eRGIeK1S2mYhPxg2VuHS0L06njVla2afn2_ZSGOdvpHI3D
 8aI9sYvJmvlUoOnzOKbl3_k8IvA9QiNbsVAalSykXbYhFsA3g1mlSbq3.OG_iQlnPYTaAIofEyOk
 _I8BAf_2NWWZbXjgjIXs0My6imhCHsCLC1udpjsEol5WZ2yON20JZoLWxD0.mA_S4TgmDEx5CtRz
 scwKAwk.ITXR7InWxCJDG9ealhXT1GJVbeqU5ZNVTioZHilIEKzCz3DbsO.a94fhgK4VLzbMq.r4
 Gl_pv5VOSQZqG3boxGTUaiuC1fUBWX7FrxD7RPxRJgJnV.Surp1WJrHSplVb5o5mk.wIk6v.N_73
 BtRm4rKFTrcUthV_7LJI8Y3K8HOy5SK2Pbs8fXU6AezOf7PcWJ2APRClcT1Mad04mCM3TrUYwWzd
 FrUlVkPEaq81OvUGyI9HOtimDTK3zcYzPZAclgcmzvW8zuoUrBi1EW_NX36fy_bf1gFQYX7SViC5
 K85stv7SibNX834cUK.mYBV3zWnZXzOKl1RJDs1GBeGLbqIk4I1lKYPS5u030n9GnNKin4tdGIJq
 TXOWQXxbjarMvuSLd6VulRziF8yAUFerLyl53BeiLA6iVN_0l_EoEJ5MXT_93tmNBmTgOWmKihJl
 DKhNX_xTWz_RyngiEAmo0VYwzEWxfEvfTQOGNMcX9YZR6jDCQJMQDWToWk8bQmS8MekvE7c.kfOG
 4NCFXn3C4EYV7L3dOixJGKna9olR0WNYfs1.DIT.4X9KMugjtQHEeHECZTY8wF.AV.csfxGws5ZD
 qzKH9BGUohDRyHfSyUpgZb4GBWUBWFrWYU1HruI9N8GjaqdTHJDXgtpNTq5LQkvLdNjMD8..mVvo
 mkq1zYKK.glHP1lgo2X863Zon95ubyAp7WMnSsjWV_spodIlRRZXV59p0DcXhEw1Dj71LDRHUdT3
 SxdhWO8f0J1utYAAaSR9OPSbsWdo.A5WS25vnChczdk99kolJCF.zKQ3ZwHAxmTAHx.kTaIRZKrl
 ruU_rRXUkO6gT1VfS0kV5wplplhGnbiSliLAQdpe_yCLl_eYAfdHX5zFeUc1tYlDQlDyYEVEii73
 ZQONjgk8IFDGfYc7qdQgTnz0HFOo2iXTnBUtaJ.7lYBW04fnUe4O_oSBUkYC3kJQETZXp5ifFw8m
 wa_T2EbQibnku2cwU_wKuuq6ae7huKSPjd2qNWGas_OgSnOo0ofPCGtTPusoc2O2cp1SFKTK5T_y
 T1jxBgaZaN2x7L955TkiiGDaen7r2Cw5ex88bKHGU3YArvkwh9U_IE5ASASuPm5slVmDBxEas4iI
 JUW.iSpq2eb9HrqMKtEk.rIVlG92cAGcktviXf8mXrNCJiX1nFL2seQKeP4VNAq3trxUCaffUmMh
 cM05O_LLLbxp5uNwLcGmlINL6BcmoWAXGhexXeiJPKjnPTq0EQ5sZe2uBYoE9GUUHBzJipTBSmq6
 UCNqgEWDFsp393_VozqdlJYk6zXrMIWdgzB.qK7hSyugtINLwUcV93YjUfjlPXHQpgJqYOUf.qwL
 89DRt_CaRFPOYUgupzrWzFtkXbk3MymWZY5AOgGrFhx31kXqC_wL8b9Esee8bDq9bOeo3tT2VP0l
 7OPhJ4gxSwJjG5UCPYJx5ZdnwXikOzqQOdEoUDgzuJgSdzPEDNum5m4nLdN_Jpx8rrnXipV69jrs
 WkjmihSUWoZrW8yrmGtFwq_YC8OdyzT6XtWlRx69Fi_9vQ6vgiakljruRxNJkrFPPfET8rw1M1Sx
 siFBA
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Sep 2022 14:05:44 +0000
Received: by hermes--production-bf1-64b498bbdd-tl26t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f8c988ade6d28de5d6b27cd5cdc2f8e2;
          Thu, 08 Sep 2022 14:05:41 +0000 (UTC)
Date:   Thu, 08 Sep 2022 10:05:34 -0400
From:   Steven J Abner <pheonix.sja@att.net>
Subject: amdgpu/drm boot blackout
To:     linux-kernel@vger.kernel.org
Message-Id: <AT9WHR.3Z1T3VI9A2AQ3@att.net>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <AT9WHR.3Z1T3VI9A2AQ3.ref@att.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On boot up display has high probability of being NULL, but OS runs.
Hopefully enough to trace?

Linux version 5.18.19 (steven@steven-ryzen) (gcc (Ubuntu 
9.4.0-1ubuntu1~20.04.1) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) 
#1 SMP PREEMPT_DYNAMIC Tue Sep 6 10:58:17 EDT 2022
  note: not a ubuntu .config, building specific to AMD 2400g, actual 
OS: elementary
ASRock Fatal1ty B450 Gaming-ITX/ac
AGESA PinnaclePI-AM4_1.0.0.4 afraid to update to AGESA to 1.0.0.6 
'cause not on windows, nor have windows
microcode: CPUx: patch_level=0x0810100b

  normal dmesg stuff, missing from journalctl:
ccp 0000:38:00.2: ccp enabled
ccp 0000:38:00.2: enabling device (0000 -> 0002)
ccp 0000:38:00.2: psp: unable to access the device: you might be 
running a broken BIOS.
  NOTE: broken BIOS a normal message according to AMD forum thread, 
left for developers

  after,which dmesg journalctl have: [drm] reserve 0x400000 from 
0xf47fc00000 for PSP TMR

  probable crash point next drm/amdgpu:
  normal dmesg stuff, missing from journalctl:
amdgpu 0000:38:00.0: amdgpu: RAS: optional ras ta ucode is not available
amdgpu 0000:38:00.0: amdgpu: RAP: optional rap ta ucode is not available
amdgpu 0000:38:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is 
not available
  NOTE: according to internet searches, above not supported on raven 
cpus

    intro to all blackouts:
Sep 08 08:18:37 steven-ryzen kernel: [drm] psp gfx command 
SETUP_TMR(0x5) failed and response status is (0x0)
Sep 08 08:18:37 steven-ryzen kernel: [drm:psp_hw_start.cold [amdgpu]] 
*ERROR* PSP load tmr failed!
Sep 08 08:18:37 steven-ryzen kernel: [drm:psp_hw_init [amdgpu]] *ERROR* 
PSP firmware loading failed
Sep 08 08:18:37 steven-ryzen kernel: [drm:amdgpu_device_fw_loading 
[amdgpu]] *ERROR* hw_init of IP block <psp> failed -22
Sep 08 08:18:37 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
amdgpu_device_ip_init failed
Sep 08 08:18:37 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: Fatal 
error during GPU init
Sep 08 08:18:37 steven-ryzen kernel: amdgpu 0000:38:00.0: amdgpu: 
amdgpu: finishing device.
Sep 08 08:18:37 steven-ryzen kernel: amdgpu: probe of 0000:38:00.0 
failed with error -22
Sep 08 08:18:37 steven-ryzen kernel: BUG: kernel NULL pointer 
dereference, address: 0000000000000090
Sep 08 08:18:37 steven-ryzen kernel: #PF: supervisor write access in 
kernel mode
Sep 08 08:18:37 steven-ryzen kernel: #PF: error_code(0x0002) - 
not-present page
Sep 08 08:18:37 steven-ryzen kernel: PGD 0 P4D 0
Sep 08 08:18:37 steven-ryzen kernel: Oops: 0002 [#1] PREEMPT SMP NOPTI
    followed by slightly different:
Sep 08 06:56:39 steven-ryzen kernel: CPU: 4 PID: 128 Comm: 
systemd-udevd Not tainted 5.18.19 #1
Sep 08 06:56:39 steven-ryzen kernel: Hardware name: To Be Filled By 
O.E.M. To Be Filled By O.E.M./B450 Gaming-ITX/ac, BIOS P1.30 11/08/2018
Sep 08 06:56:39 steven-ryzen kernel: RIP: 0010:drm_sched_fini+0x7a/0xa0 
[gpu_sched]
Sep 08 06:56:39 steven-ryzen kernel: Code: 01 00 00 e8 98 6d bb e3 c6 
85 8c 01 00 00 00 5b 5d 41 5c 41 5d e9 a6 2c 55 e4 4c 89 e7 e8 ee 25 24 
e4 48 8b 03 48 39 d8 74 0f <c6> 80 90 00 00 00 01 48 8b 00 48 39 d8 75 
f1 4c 89 e7 e8 ff 21 24
Sep 08 06:56:39 steven-ryzen kernel: RSP: 0018:ffffb3e880493978 EFLAGS: 
00010213
Sep 08 06:56:39 steven-ryzen kernel: RAX: 0000000000000000 RBX: 
ffff91560ace9768 RCX: 0000000080400033
Sep 08 06:56:39 steven-ryzen kernel: RDX: 0000000000000001 RSI: 
ffff91560b868468 RDI: ffff91560ace9758
Sep 08 06:56:39 steven-ryzen kernel: RBP: ffff91560ace96c0 R08: 
ffff91560ace0014 R09: 0000000000000001
Sep 08 06:56:39 steven-ryzen kernel: R10: 000000000000001b R11: 
ffff9156006a9b60 R12: ffff91560ace9758
Sep 08 06:56:39 steven-ryzen kernel: R13: ffff91560ace96c8 R14: 
ffff91560ace6400 R15: ffff915600af9b48
Sep 08 06:56:39 steven-ryzen kernel: FS: 00007f2689dc8880(0000) 
GS:ffff915698b00000(0000) knlGS:0000000000000000
Sep 08 06:56:39 steven-ryzen kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Sep 08 06:56:39 steven-ryzen kernel: CR2: 0000000000000090 CR3: 
0000000101834000 CR4: 00000000003506e0
Sep 08 06:56:39 steven-ryzen kernel: Call Trace:
Sep 08 06:56:39 steven-ryzen kernel: <TASK>
Sep 08 06:56:39 steven-ryzen kernel: 
amdgpu_fence_driver_sw_fini+0xbf/0xd0 [amdgpu]
Sep 08 06:56:39 steven-ryzen kernel: amdgpu_device_fini_sw+0x22/0x300 
[amdgpu]
Sep 08 06:56:39 steven-ryzen kernel: amdgpu_driver_release_kms+0xd/0x30 
[amdgpu]
Sep 08 06:56:39 steven-ryzen kernel: drm_dev_release+0x1e/0x40 [drm]
Sep 08 06:56:39 steven-ryzen kernel: release_nodes+0x29/0x50
Sep 08 06:56:39 steven-ryzen kernel: devres_release_all+0x86/0xc0
Sep 08 06:56:39 steven-ryzen kernel: device_unbind_cleanup+0x9/0x70
Sep 08 06:56:39 steven-ryzen kernel: really_probe+0xee/0x210
Sep 08 06:56:39 steven-ryzen kernel: __driver_probe_device+0x6d/0xd0
Sep 08 06:56:39 steven-ryzen kernel: driver_probe_device+0x19/0xa0
Sep 08 06:56:39 steven-ryzen kernel: __driver_attach+0x5a/0xe0
Sep 08 06:56:39 steven-ryzen kernel: ? __device_attach_driver+0xa0/0xa0
Sep 08 06:56:39 steven-ryzen kernel: bus_for_each_dev+0x73/0xc0
Sep 08 06:56:39 steven-ryzen kernel: bus_add_driver+0x17c/0x1d0
Sep 08 06:56:39 steven-ryzen kernel: driver_register+0x67/0xc0
Sep 08 06:56:39 steven-ryzen kernel: ? 0xffffffffc0aa4000
Sep 08 06:56:39 steven-ryzen kernel: do_one_initcall+0x47/0x1a0
Sep 08 06:56:39 steven-ryzen kernel: ? kmem_cache_alloc+0x32/0x3b0
Sep 08 06:56:39 steven-ryzen kernel: do_init_module+0x41/0x1e0
Sep 08 06:56:39 steven-ryzen kernel: load_module+0x2597/0x2850
Sep 08 06:56:39 steven-ryzen kernel: ? __do_sys_finit_module+0xa6/0x100
Sep 08 06:56:39 steven-ryzen kernel: __do_sys_finit_module+0xa6/0x100
Sep 08 06:56:39 steven-ryzen kernel: do_syscall_64+0x5c/0x90
Sep 08 06:56:39 steven-ryzen kernel: ? 
syscall_exit_to_user_mode+0x1d/0x40
Sep 08 06:56:39 steven-ryzen kernel: ? do_syscall_64+0x69/0x90
Sep 08 06:56:39 steven-ryzen kernel: ? 
syscall_exit_to_user_mode+0x1d/0x40
Sep 08 06:56:39 steven-ryzen kernel: ? do_syscall_64+0x69/0x90
Sep 08 06:56:39 steven-ryzen kernel: ? 
syscall_exit_to_user_mode+0x1d/0x40
Sep 08 06:56:39 steven-ryzen kernel: ? do_syscall_64+0x69/0x90
Sep 08 06:56:39 steven-ryzen kernel: ? do_syscall_64+0x69/0x90
Sep 08 06:56:39 steven-ryzen kernel: ? do_syscall_64+0x69/0x90
Sep 08 06:56:39 steven-ryzen kernel: 
entry_SYSCALL_64_after_hwframe+0x49/0xb3
Sep 08 06:56:39 steven-ryzen kernel: RIP: 0033:0x7f268a3f273d
Sep 08 06:56:39 steven-ryzen kernel: Code: 00 c3 66 2e 0f 1f 84 00 00 
00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 
89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 23 37 
0d 00 f7 d8 64 89 01 48
Sep 08 06:56:39 steven-ryzen kernel: RSP: 002b:00007ffc1422a078 EFLAGS: 
00000246 ORIG_RAX: 0000000000000139
Sep 08 06:56:39 steven-ryzen kernel: RAX: ffffffffffffffda RBX: 
0000557a5aff83f0 RCX: 00007f268a3f273d
Sep 08 06:56:39 steven-ryzen kernel: RDX: 0000000000000000 RSI: 
00007f268a2d2ded RDI: 0000000000000015
Sep 08 06:56:39 steven-ryzen kernel: RBP: 0000000000020000 R08: 
0000000000000000 R09: 0000000000000000
Sep 08 06:56:39 steven-ryzen kernel: R10: 0000000000000015 R11: 
0000000000000246 R12: 00007f268a2d2ded
Sep 08 06:56:39 steven-ryzen kernel: R13: 0000000000000000 R14: 
0000557a5aff76d0 R15: 0000557a5aff83f0
Sep 08 06:56:39 steven-ryzen kernel: </TASK>
Sep 08 06:56:39 steven-ryzen kernel: Modules linked in: hid_generic 
usbhid hid uas usb_storage amdgpu(+) drm_ttm_helper ttm mfd_core 
gpu_sched drm_dp_helper drm_kms_helper drm xhci_pci igb i2c_piix4 
drm_panel_orientation_quirks xhci_hcd nvme cec ptp nvme_core rc_core 
pps_core usbcore i2c_algo_bit usb_common gpio_amdpt gpio_generic
Sep 08 06:56:39 steven-ryzen kernel: CR2: 0000000000000090
Sep 08 06:56:39 steven-ryzen kernel: ---[ end trace 0000000000000000 
]---
Sep 08 06:56:39 steven-ryzen kernel: RIP: 0010:drm_sched_fini+0x7a/0xa0 
[gpu_sched]
Sep 08 06:56:39 steven-ryzen kernel: Code: 01 00 00 e8 98 6d bb e3 c6 
85 8c 01 00 00 00 5b 5d 41 5c 41 5d e9 a6 2c 55 e4 4c 89 e7 e8 ee 25 24 
e4 48 8b 03 48 39 d8 74 0f <c6> 80 90 00 00 00 01 48 8b 00 48 39 d8 75 
f1 4c 89 e7 e8 ff 21 24
Sep 08 06:56:39 steven-ryzen kernel: RSP: 0018:ffffb3e880493978 EFLAGS: 
00010213
Sep 08 06:56:39 steven-ryzen kernel: RAX: 0000000000000000 RBX: 
ffff91560ace9768 RCX: 0000000080400033
Sep 08 06:56:39 steven-ryzen kernel: RDX: 0000000000000001 RSI: 
ffff91560b868468 RDI: ffff91560ace9758
Sep 08 06:56:39 steven-ryzen kernel: RBP: ffff91560ace96c0 R08: 
ffff91560ace0014 R09: 0000000000000001
Sep 08 06:56:39 steven-ryzen kernel: R10: 000000000000001b R11: 
ffff9156006a9b60 R12: ffff91560ace9758
Sep 08 06:56:39 steven-ryzen kernel: R13: ffff91560ace96c8 R14: 
ffff91560ace6400 R15: ffff915600af9b48
Sep 08 06:56:39 steven-ryzen kernel: FS: 00007f2689dc8880(0000) 
GS:ffff915698b00000(0000) knlGS:0000000000000000
Sep 08 06:56:39 steven-ryzen kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Sep 08 06:56:39 steven-ryzen kernel: CR2: 0000000000000090 CR3: 
0000000101834000 CR4: 00000000003506e0

do have more if needed, and doesn't seem hard to recreate:
./Documents/reboot-jctl
steven@steven-ryzen:~$ sudo journalctl -b -1 > ./Documents/jctl-1
steven@steven-ryzen:~$ sudo journalctl -b -2 > ./Documents/jctl-2
steven@steven-ryzen:~$ sudo journalctl -b -3 > ./Documents/jctl-3
steven@steven-ryzen:~$ sudo journalctl -b -4 > ./Documents/jctl-4
steven@steven-ryzen:~$ sudo journalctl -b -5 > ./Documents/jctl-5
steven@steven-ryzen:~$ sudo journalctl -b -6 > ./Documents/jctl-6
steven@steven-ryzen:~$ sudo journalctl -b -7 > ./Documents/jctl-7

Also, I don't think this occurs during ubuntu mainline builds.

Steve


