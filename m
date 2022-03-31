Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A1F4EE134
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbiCaTAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiCaTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:00:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37032364D4;
        Thu, 31 Mar 2022 11:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F6436187F;
        Thu, 31 Mar 2022 18:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95009C340ED;
        Thu, 31 Mar 2022 18:58:12 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.32-rt39
Date:   Thu, 31 Mar 2022 18:57:24 -0000
Message-ID: <164875304500.974121.18336996246209199283@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.32-rt39 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 40291aa6846edc6813885b33bcc837c61a58bf3b

Or to build 5.15.32-rt39 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.32.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.32-rt39.patch.xz


Enjoy!
Clark

Changes from v5.15.31-rt38:
---

Arnd Bergmann (3):
      uaccess: fix integer overflow on access_ok()
      m68k: fix access_ok for coldfire
      nds32: fix access_ok() checks in get/put_user

Brian Norris (1):
      Revert "ath: add support for special 0x0 regulatory domain"

Bryan O'Donoghue (1):
      wcn36xx: Differentiate wcn3660 from wcn3620

Clark Williams (2):
      Merge tag 'v5.15.32' into v5.15-rt
      Linux 5.15.32-rt39

Eric Dumazet (2):
      llc: fix netdevice reference leaks in llc_ui_bind()
      llc: only change llc->dev when bind() succeeds

Giacomo Guiduzzi (1):
      ALSA: pci: fix reading of swapped values from pcmreg in AC97 codec

Giovanni Cabiddu (1):
      crypto: qat - disable registration of algorithms

Greg Kroah-Hartman (1):
      Linux 5.15.32

Helmut Grohne (1):
      Bluetooth: btusb: Add another Realtek 8761BU

James Bottomley (1):
      tpm: use try_get_ops() in tpm-space.c

Jason Zheng (1):
      ALSA: hda/realtek: Add quirk for ASUS GA402

Jonathan Teh (1):
      ALSA: cmipci: Restore aux vol on suspend/resume

Jordy Zomer (1):
      nfc: st21nfca: Fix potential buffer overflows in EVT_TRANSACTION

Larry Finger (1):
      Bluetooth: btusb: Add one more Bluetooth part for the Realtek RTL8852AE

Lars-Peter Clausen (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on RODE NT-USB

Linus Lüssing (1):
      mac80211: fix potential double free on mesh join

Mark Cilissen (1):
      ACPI / x86: Work around broken XSDT on Advantech DAC-BJ01 board

Maximilian Luz (1):
      ACPI: battery: Add device HID and quirk for Microsoft Surface Go 3

Pablo Neira Ayuso (2):
      netfilter: nf_tables: initialize registers in nft_do_chain()
      netfilter: nf_tables: validate registers coming from userspace.

Paul E. McKenney (1):
      rcu: Don't deboost before reporting expedited quiescent state

Reza Jahanbakhshi (1):
      ALSA: usb-audio: add mapping for new Corsair Virtuoso SE

Roberto Sassu (1):
      drm/virtio: Ensure that objs is not NULL in virtio_gpu_array_put_free()

Stephane Graber (1):
      drivers: net: xgene: Fix regression in CRC stripping

Tadeusz Struk (2):
      net: ipv6: fix skb_over_panic in __ip6_append_data
      tpm: Fix error handling in async work

Takashi Iwai (7):
      ASoC: sti: Fix deadlock via snd_pcm_stop_xrun() call
      ALSA: oss: Fix PCM OSS buffer allocation overflow
      ALSA: pcm: Fix races among concurrent hw_params and hw_free calls
      ALSA: pcm: Fix races among concurrent read/write and buffer changes
      ALSA: pcm: Fix races among concurrent prepare and hw_params/hw_free calls
      ALSA: pcm: Fix races among concurrent prealloc proc writes
      ALSA: pcm: Add stream lock during PCM reset ioctl operations

Tim Crawford (2):
      ALSA: hda/realtek: Add quirk for Clevo NP70PNJ
      ALSA: hda/realtek: Add quirk for Clevo NP50PNJ

Werner Sembach (1):
      ACPI: video: Force backlight native for Clevo NL5xRU and NL5xNU

huangwenhui (1):
      ALSA: hda/realtek - Fix headset mic problem for a HP machine with alc671
---
Makefile                                         |  2 +-
 arch/csky/include/asm/uaccess.h                  |  7 +-
 arch/hexagon/include/asm/uaccess.h               | 18 ++---
 arch/m68k/include/asm/uaccess.h                  | 15 ++--
 arch/microblaze/include/asm/uaccess.h            | 19 +----
 arch/nds32/include/asm/uaccess.h                 | 22 ++++--
 arch/x86/kernel/acpi/boot.c                      | 24 ++++++
 drivers/acpi/battery.c                           | 12 +++
 drivers/acpi/video_detect.c                      | 75 ++++++++++++++++++
 drivers/bluetooth/btusb.c                        |  4 +
 drivers/char/tpm/tpm-dev-common.c                |  8 +-
 drivers/char/tpm/tpm2-space.c                    |  8 +-
 drivers/crypto/qat/qat_4xxx/adf_drv.c            |  7 ++
 drivers/crypto/qat/qat_common/qat_crypto.c       |  7 ++
 drivers/gpu/drm/virtio/virtgpu_gem.c             |  3 +
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 12 +--
 drivers/net/wireless/ath/regd.c                  | 10 +--
 drivers/net/wireless/ath/wcn36xx/main.c          |  3 +
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h       |  1 +
 drivers/nfc/st21nfca/se.c                        | 10 +++
 include/sound/pcm.h                              |  1 +
 kernel/rcu/tree_plugin.h                         |  8 +-
 localversion-rt                                  |  2 +-
 net/ipv6/ip6_output.c                            |  4 +-
 net/llc/af_llc.c                                 | 48 ++++++++----
 net/mac80211/cfg.c                               |  3 -
 net/netfilter/nf_tables_api.c                    | 22 ++++--
 net/netfilter/nf_tables_core.c                   |  2 +-
 sound/core/oss/pcm_oss.c                         | 12 ++-
 sound/core/oss/pcm_plugin.c                      |  5 +-
 sound/core/pcm.c                                 |  2 +
 sound/core/pcm_lib.c                             |  4 +
 sound/core/pcm_memory.c                          | 11 ++-
 sound/core/pcm_native.c                          | 97 +++++++++++++++---------
 sound/pci/ac97/ac97_codec.c                      |  4 +-
 sound/pci/cmipci.c                               |  3 +-
 sound/pci/hda/patch_realtek.c                    |  4 +
 sound/soc/sti/uniperif_player.c                  |  6 +-
 sound/soc/sti/uniperif_reader.c                  |  2 +-
 sound/usb/mixer_maps.c                           | 10 +++
 sound/usb/mixer_quirks.c                         |  7 +-
 41 files changed, 381 insertions(+), 143 deletions(-)
---
