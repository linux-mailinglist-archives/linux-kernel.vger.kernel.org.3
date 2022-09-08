Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959725B13CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIHFBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHFBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:01:46 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860AB1B83;
        Wed,  7 Sep 2022 22:01:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0776E3200940;
        Thu,  8 Sep 2022 01:01:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Sep 2022 01:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rieck.me; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662613299; x=
        1662699699; bh=TogMmUmClj5qpvvj7LH7110KZK4ERIzVhP+QQAecSVo=; b=V
        RjoZjUkKxrXsc5P5R8m05d4R7b5JqBRXrKWfZSP7JQgXodlHqcwdUBFhiiT8dmOu
        0Lp+yOMeSBjUe+PoBf11hiGcHr0BCaNqI1h/RqtlmCdR4zyvjIjQQSXGmAdG8BA2
        A01Fr/FZ/7r+oP30pqPJgIb/SJJhQf2wGnVFW996mEAROFiBLs/6u8OqZexU0yXF
        qEit4PPeXijlsrikJzayjxok2C5rB/vgXelPtsxR8bV//FiTGB6Swqn1Z/6WVPJI
        bPa5U7Briz7VBwXjQiavRl7bLXBJ67ypK2JrRH+2cEQ1g+xm0kt8GHo4B4MOMyds
        OtALIoInGX+0k2LB0mujg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662613299; x=
        1662699699; bh=TogMmUmClj5qpvvj7LH7110KZK4ERIzVhP+QQAecSVo=; b=r
        BFSQ7+ZJNzpQxPhrNoae9p3FRWmBbUzTUSPD0vs5gdtgND833zYXMJy1bjW0+14H
        ydYGWnihIsmExYvDgx0nxx0DgaaQ+laKND/hlPiu429wUPWDmR5IR1fpkz3rtOmp
        kL/ZF+xcqLDRjNY3evxTDRW9FvY9iQJyBGNnZ9O8z8ad3AxFlg/ouxKFs8Wn6pYX
        mPsT3BoV085WVZjhCIyIYH1JVKfEGI7GEQn4xiqfI/v2l8eLrp0g1VjTZ1dabt3q
        HhKcwgQ7tBHEB0DRy1ZsQeQFQMha7Q7qqucG0ox+vm1QUTdYtg+tfq0XCTI+jGMt
        ux8Zc1RfmL3qJVu9bI0qA==
X-ME-Sender: <xms:MncZY4Y_-zCpQVo4QT6aqYBIsJpYkC2EhVyjLPydy1rMhZwWs9xmNA>
    <xme:MncZYzaMiqHh51QI6xzNYYA-uknFqx_Z5yBMOlMW9MkR8ueITX1Nqnac8C-AtreC7
    Nj9_qojk7MAgZlw>
X-ME-Received: <xmr:MncZYy-PHk8CW7EvD7nm3KCk3SPfYxWDaNhe22YfC3XsFl3p1jtbBznARik6O0vKU3zX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtuddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkjghfgggtgfesmhfureertddtjeenucfhrhhomhepuegrshht
    ihgrnhcutfhivggtkhcuoegsrghsthhirghnsehrihgvtghkrdhmvgeqnecuggftrfgrth
    htvghrnhepledvffelvedtkeeukeeivdevhfefkedukedtleeuffehheeuhfevtdekfeet
    ffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    grshhtihgrnhesrhhivggtkhdrmhgv
X-ME-Proxy: <xmx:M3cZYyqd3ioBydyVdU8aKT2snw6XQbREOYeIvUQh6d0VKqKdZIfAYA>
    <xmx:M3cZYzpr-MxjBZKdBXdqnfeRQoFca9QGFEF9c7LWXxuF7dyldcxBOQ>
    <xmx:M3cZYwRgehwQDzL5aRMb0zqJooH9otov5zsg8nXibWu3ji4JPk472g>
    <xmx:M3cZYxhOuYAx6gqQpGUXRI_FBbFg2cVh7d6Y9GXoSzVP9HIVt8WHqw>
Feedback-ID: ie53945e4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Sep 2022 01:01:37 -0400 (EDT)
From:   Bastian Rieck <bastian@rieck.me>
To:     linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, grzegorz.alibozek@gmail.com,
        andrew.co@free.fr, meven29@gmail.com, pchernik@gmail.com,
        jorge.cep.mart@gmail.com, danielmorgan@disroot.org,
        bernie@codewiz.org, saipavanchitta1998@gmail.com,
        rubin@starset.net, maniette@gmail.com, nate@kde.org
Subject: Re: [RFC PATCH 0/2] usb: typec: ucsi: Check connection on resume
Date:   Thu, 08 Sep 2022 07:01:34 +0200
Message-ID: <27257661.hdJqBvvX10@nimue>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAABGdBTUEAALGPC/xhBQAAAAFz UkdCAK7OHOkAAAAVUExURdnY2d3d3vDDp8KYgoJnXK3K7i8gH0swGw4AAAH1SURBVDjLZVTNcpsw EJbopGfAk3uRPD4z2g1njDY6J2nVB0hUvf8jdFcIDO36Z8R+/n5WCCt1qLbt9uJLLe+WP52WegDl t+XF7fbAYIWV40bmdHoHpK2Vboy19ijVCqNVjXHGOFB6Z2hxV8pIAcCBUfpNASzAvWYurhtBKKM+ xVXOVApWk9r/VhkWsQY+Ab1ozSeGKPX9IFJj9y+wuuO8xlonX4GhAPf/pIbCoHtbclUA9jlo1sdU gOiNQY8FODB8ttlZwinRrFqZpAIZAHNGgACj2hicyn7hd/q8hQkDEah2l1qsN+7zthg7EYWitQJ2 4rzLlb8shSPDlLh2kTmC3EWt6x5a01/MFYcBKLnivgIXyydhsK5nqTTyIdgYjWUhgyAeNGoxqXMI I+UkQJIJOr0B4G6UyRkkkvPU7nfQ8dRAxKmEsKdigLhCcEhqO7V1e/11uExXj/PaPwB82MBWQO1S Cr44F6CneXsuNpMkDAbCvD5Le2X2NSFRSGdzxYHAZk6W3tSppuQxFGA+A5hTyIkov8ZT/wlClj6F eAbiB+8SJYbOwFNcQDaF8DXGg3uM0VuheM/L+Gi/x/hTjichxAdSlr+8PLKAL+WqqEUh/I58W4F3 Kz7H0nhjW1mGP9HwX4B9EVXpvKuyiinmuWl+rA7CeP4L2hiGKBFny1gAAAAASUVORK5CYII=
In-Reply-To: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
References: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2200929.ftShZd65HK"
Content-Transfer-Encoding: 7Bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2200929.ftShZd65HK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dear Heikki,

> I'm sending these as an RFC first because I'm not done testing.
>=20
> I made a small modification to my original proposal (in the bug
> report). Now also connection during suspend should be covered.
>=20
> I would appreciate if you guys could test these again. If
> everything works, and the bug is fixed, let me know, and I'll add
> your Tested-by tags to the patches.
>

Thanks so much for these changes=E2=80=94that's awesome! I have just finish=
ed=20
testing this against 5.19.7 (Arch Linux) with a Lenovo X1 (Gen 9).

I am very happy to see that, as far as I can tell, the issue=20
disappeared completely!

However, I am receiving additional warnings via `journalctl` that I=20
did not receive before; I have attached this trace as an additional=20
log file. Nothing in there seems critical and I can confirm that the=20
system continues to operate normally. I merely wanted to provide you=20
with this additional information in case it is of relevance.

Please let me know if there's anything else I can do here; I really=20
appreciate the time you spent on this!

All the best,
  Bastian
--nextPart2200929.ftShZd65HK
Content-Disposition: attachment; filename="trace.log"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-log; charset="UTF-8"; name="trace.log"

ep 08 06:41:34 nimue kernel: ------------[ cut here ]------------
Sep 08 06:41:34 nimue kernel: WARNING: CPU: 0 PID: 448 at kernel/module/mai=
n.c:849 module_put+0x8f/0xa0
Sep 08 06:41:34 nimue kernel: Modules linked in: r8153_ecm cdc_ether usbnet=
 r8152 mii typec_displayport rfcomm snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_hda_dsp_common snd_soc_hdac_hdmi snd_sof_probes snd_hda_codec_hdmi s=
nd_hda_codec_realtek snd_hda_codec_generic snd_soc_dmic snd_sof_pci_intel_t=
gl snd_sof_intel_hda_common soundwire_intel soundwire_generic_allocation cc=
m soundwire_cadence snd_sof_intel_hda algif_aead snd_sof_pci snd_sof_xtensa=
_dsp des_generic libdes snd_sof ecb snd_sof_utils algif_skcipher snd_soc_hd=
ac_hda snd_hda_ext_core snd_soc_acpi_intel_match cmac snd_soc_acpi soundwir=
e_bus md4 algif_hash bnep snd_soc_core af_alg snd_compress joydev mousedev =
intel_tcc_cooling iwlmvm ac97_bus x86_pkg_temp_thermal snd_pcm_dmaengine in=
tel_powerclamp coretemp hid_multitouch mac80211 snd_hda_intel iTCO_wdt pmt_=
telemetry intel_pmc_bxt snd_intel_dspcfg kvm_intel spi_nor snd_intel_sdw_ac=
pi libarc4 iTCO_vendor_support mtd mei_hdcp mei_pxp intel_rapl_msr pmt_clas=
s think_lmi snd_hda_codec iwlwifi
Sep 08 06:41:34 nimue kernel:  firmware_attributes_class wmi_bmof kvm snd_h=
da_core irqbypass intel_cstate intel_uncore pcspkr uvcvideo psmouse iwlmei =
snd_hwdep vfat i2c_i801 spi_intel_pci videobuf2_vmalloc fat snd_pcm btusb s=
pi_intel i2c_smbus videobuf2_memops intel_lpss_pci btrtl snd_timer btbcm me=
i_me cfg80211 intel_lpss videobuf2_v4l2 btintel idma64 videobuf2_common btm=
tk mei videodev mc bluetooth processor_thermal_device_pci_legacy processor_=
thermal_device processor_thermal_rfim ecdh_generic processor_thermal_mbox c=
rc16 thunderbolt intel_vsec thinkpad_acpi processor_thermal_rapl ucsi_acpi =
intel_rapl_common ledtrig_audio typec_ucsi platform_profile igen6_edac inte=
l_soc_dts_iosf typec rfkill roles snd wmi soundcore int3403_thermal soc_but=
ton_array int340x_thermal_zone i2c_hid_acpi i2c_hid essiv authenc mac_hid i=
ntel_hid int3400_thermal acpi_pad sparse_keymap acpi_thermal_rel acpi_tad p=
kcs8_key_parser crypto_user fuse bpf_preload ip_tables x_tables btrfs blake=
2b_generic libcrc32c crc32c_generic xor
Sep 08 06:41:34 nimue kernel:  raid6_pq dm_crypt cbc encrypted_keys trusted=
 asn1_encoder tee tpm rng_core dm_mod serio_raw crct10dif_pclmul atkbd crc3=
2_pclmul crc32c_intel libps2 ghash_clmulni_intel vivaldi_fmap nvme aesni_in=
tel crypto_simd cryptd nvme_core xhci_pci xhci_pci_renesas i8042 serio i915=
 intel_gtt drm_buddy video drm_display_helper cec ttm
Sep 08 06:41:34 nimue kernel: Unloaded tainted modules: pcc_cpufreq():1 acp=
i_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufre=
q():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acp=
i_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufre=
q():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc=
_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq(=
):1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_=
cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq()=
:1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_c=
pufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 fjes():1 fjes()=
:1 acpi_cpufreq():1 asus_ec_sensors():1 pcc_cpufreq():1 acpi_cpufreq():1 fj=
es():1 pcc_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 a=
cpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 fjes():1 acpi_cpufreq():1
Sep 08 06:41:34 nimue kernel:  asus_ec_sensors():1 acpi_cpufreq():1 fjes():=
1 pcc_cpufreq():1 fjes():1 acpi_cpufreq():1
Sep 08 06:41:34 nimue kernel: CPU: 0 PID: 448 Comm: kworker/0:2 Tainted: G =
       W         5.19.7-arch1-1-ucsi-patch #1 7e4375cb15cb2751a8ce700399419=
d2870882116
Sep 08 06:41:34 nimue kernel: Hardware name: LENOVO 20XXS33A00/20XXS33A00, =
BIOS N32ET75W (1.51 ) 12/02/2021
Sep 08 06:41:34 nimue kernel: Workqueue: events ucsi_handle_connector_chang=
e [typec_ucsi]
Sep 08 06:41:34 nimue kernel: RIP: 0010:module_put+0x8f/0xa0
Sep 08 06:41:34 nimue kernel: Code: 0f 48 8b 40 08 48 89 fe 48 89 c7 e8 8b =
fa ff ff 65 ff 0d 84 05 0e 61 75 b4 e8 45 40 ec ff eb ad e8 22 40 ec ff c3 =
cc cc cc cc <0f> 0b eb 99 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e f=
a 55
Sep 08 06:41:34 nimue kernel: RSP: 0018:ffffb61000487d18 EFLAGS: 00010297
Sep 08 06:41:34 nimue kernel: RAX: 0000000000000000 RBX: ffff8db49cf5b008 R=
CX: 0000000000000000
Sep 08 06:41:34 nimue kernel: RDX: 00000000ffffffff RSI: 0000000000000000 R=
DI: ffffffffc08bb180
Sep 08 06:41:34 nimue kernel: RBP: 0000000000000000 R08: ffff8db480401758 R=
09: ffffffffa0a51fb0
Sep 08 06:41:34 nimue kernel: R10: 0000000000000000 R11: 0000000000000000 R=
12: ffffffffc08bb018
Sep 08 06:41:34 nimue kernel: R13: ffff8db49cf5b088 R14: 0000000000000080 R=
15: ffff8db484364388
Sep 08 06:41:34 nimue kernel: FS:  0000000000000000(0000) GS:ffff8dbbbf6000=
00(0000) knlGS:0000000000000000
Sep 08 06:41:34 nimue kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
Sep 08 06:41:34 nimue kernel: CR2: 00007f2ef985a000 CR3: 00000003d7210001 C=
R4: 0000000000f70ef0
Sep 08 06:41:34 nimue kernel: PKRU: 55555554
Sep 08 06:41:34 nimue kernel: Call Trace:
Sep 08 06:41:34 nimue kernel:  <TASK>
Sep 08 06:41:34 nimue kernel:  typec_altmode_update_active+0x6f/0x110 [type=
c 4340e8e184497847e0034f471886b5beb7adb48f]
Sep 08 06:41:34 nimue kernel:  typec_remove+0xf0/0x110 [typec 4340e8e184497=
847e0034f471886b5beb7adb48f]
Sep 08 06:41:34 nimue kernel:  device_release_driver_internal+0x1b6/0x230
Sep 08 06:41:34 nimue kernel:  bus_remove_device+0xdc/0x150
Sep 08 06:41:34 nimue kernel:  device_del+0x18f/0x410
Sep 08 06:41:34 nimue kernel:  device_unregister+0x17/0x60
Sep 08 06:41:34 nimue kernel:  ucsi_unregister_altmodes+0x41/0xa0 [typec_uc=
si 91402ff21fa7795a95552024a8006e70bdb35a49]
Sep 08 06:41:34 nimue kernel:  ucsi_handle_connector_change+0x219/0x2a0 [ty=
pec_ucsi 91402ff21fa7795a95552024a8006e70bdb35a49]
Sep 08 06:41:34 nimue kernel:  ? kfree+0x2e5/0x300
Sep 08 06:41:34 nimue kernel:  process_one_work+0x1c4/0x380
Sep 08 06:41:34 nimue kernel:  worker_thread+0x51/0x390
Sep 08 06:41:34 nimue kernel:  ? rescuer_thread+0x3b0/0x3b0
Sep 08 06:41:34 nimue kernel:  kthread+0xdb/0x110
Sep 08 06:41:34 nimue kernel:  ? kthread_complete_and_exit+0x20/0x20
Sep 08 06:41:34 nimue kernel:  ret_from_fork+0x1f/0x30
Sep 08 06:41:34 nimue kernel:  </TASK>
Sep 08 06:41:34 nimue kernel: ---[ end trace 0000000000000000 ]---


--nextPart2200929.ftShZd65HK--



