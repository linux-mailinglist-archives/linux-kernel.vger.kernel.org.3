Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41745882B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiHBTis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiHBTic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:38:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA28E52E7C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 12:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DF28B82083
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 19:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7D3C433D6;
        Tue,  2 Aug 2022 19:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659469093;
        bh=B9Jg79wsdj0p0zqQhbvU/HEbMuWjyM32+lTVh+EmbBU=;
        h=Date:From:To:cc:Subject:From;
        b=HUvss0jvgdPluHWKS7u8kfKKE5kKHx8Mc55KOIBMQ+tNHLlvfY+yFZXiF3bs14gY9
         q2nhEd1IHmDW+jH4wJatv7T+az7x3SZNh+MbJ03fLloPWeh65vKkBShjqo0uASPh7d
         ot59yM1V4lxKR8ycbpZPmG5IhME8CMKwGqc6C44W0dxjELAk44XhDyLwArIqkUkDCc
         ytXe8OwTOg+lww1McdwXq+8CbWzvACMTuH9GGXxRlMdp0zmCbvDNqBGCGyUtudd9g/
         s2Ik8So5kqLijR3DjU+bw5eQE7sv2wA5Fw2BdBJcnDW4xPwOPhySCyf4CI5GCwL+c3
         myXsVnlPrMdLQ==
Date:   Tue, 2 Aug 2022 21:38:09 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.20
Message-ID: <nycvar.YFH.7.76.2208022133430.19850@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022080201

to receive HID subsystem queue for 5.20. Highlights:

=====
- support for AMD SOCs using SFH1.1 memory access (Basavaraj Natikar)
- XP-PEN Deco L support (José Expósito)
- support for Elan eKTH6915 touchscreens (Douglas Anderson)
- other small assorted fixes and device ID additions
=====

Thanks.

----------------------------------------------------------------
Artem Borisov (1):
      HID: alps: Declare U1_UNICORN_LEGACY support

Bagas Sanjaya (1):
      HID: uclogic: properly format kernel-doc comment for hid_dbg() wrappers

Basavaraj Natikar (13):
      HID: amd_sfh: Add NULL check for hid device
      HID: amd_sfh: Move common macros and structures
      HID: amd_sfh: Move request_list struct to header file
      HID: amd_sfh: Move request_list variable to client data
      HID: amd_sfh: Add descriptor operations in amd_mp2_ops
      HID: amd_sfh: Add PM operations in amd_mp2_ops
      HID: amd_sfh: Add remove operation in amd_mp2_ops
      HID: amd_sfh: Move global functions to static
      HID: amd_sfh: Move amd_sfh_work to common interface
      HID: amd_sfh: Move interrupt handling to common interface
      HID: amd_sfh: Implement SFH1.1 functionality
      HID: amd_sfh: Fix implicit declaration error on i386
      HID: amd_sfh: Handle condition of "no sensors"

Daniel J. Ogorchock (1):
      HID: nintendo: fix unused const warning

Douglas Anderson (2):
      dt-bindings: HID: i2c-hid: elan: Introduce bindings for Elan eKTH6915
      HID: i2c-hid: elan: Add support for Elan eKTH6915 i2c-hid touchscreens

Guenter Roeck (1):
      HID: nintendo: Add missing array termination

Harshit Mogalapalli (2):
      HID: cp2112: prevent a buffer overflow in cp2112_xfer()
      HID: mcp2221: prevent a buffer overflow in mcp_smbus_write()

Hilton Chain (2):
      HID: apple: Properly handle function keys on non-Apple keyboard
      HID: apple: Add "GANSS" to the non-Apple list

Jason Gerecke (1):
      HID: wacom: Force pen out of prox if no events have been received in a while

Jason Wang (1):
      HID: lg-g15: Fix comment typo

Jiang Jian (1):
      ID: intel-ish-hid: hid-client: drop unexpected word "the" in the comments

José Expósito (4):
      HID: uclogic: Make template placeholder IDs generic
      HID: uclogic: Add KUnit tests for uclogic_rdesc_template_apply()
      HID: uclogic: Allow to generate frame templates
      HID: uclogic: Add support for XP-PEN Deco L

Li Qiong (1):
      HID: intel-ish-hid: ipc: use time_before to replace "jiffies < a"

Lukas Bulwahn (1):
      HID: core: remove unneeded assignment in hid_process_report()

Mario Limonciello (1):
      HID: amd_sfh: Don't show client init failed as error when discovery fails

Maximilian Luz (1):
      HID: hid-input: add Surface Go battery quirk

Ping Cheng (2):
      HID: wacom: Only report rotation for art pen
      HID: wacom: Don't register pad_input for touch switch

Tao Jin (1):
      HID: multitouch: new device class fix Lenovo X12 trackpad sticky

Thomas Schneider (1):
      HID: nintendo: Set phys property of input device based on HID phys

Xiang wangx (1):
      HID: logitech-hidpp: Fix syntax errors in comments

 .../devicetree/bindings/input/elan,ekth6915.yaml   |  65 +++++
 drivers/hid/.kunitconfig                           |   5 +
 drivers/hid/Kconfig                                |  16 +
 drivers/hid/Makefile                               |   3 +
 drivers/hid/amd-sfh-hid/Makefile                   |   3 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c           | 117 ++++++--
 drivers/hid/amd-sfh-hid/amd_sfh_common.h           |  76 +++++
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c              |  12 +-
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h              |  12 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |  78 ++---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h             |  52 +---
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  |  17 +-
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  |   3 -
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      | 300 +++++++++++++++++++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      | 324 +++++++++++++++++++++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.h      |  26 ++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c |  75 +++++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h | 154 ++++++++++
 drivers/hid/hid-alps.c                             |   2 +
 drivers/hid/hid-apple.c                            |  35 ++-
 drivers/hid/hid-core.c                             |   2 +-
 drivers/hid/hid-cp2112.c                           |   5 +
 drivers/hid/hid-ids.h                              |   2 +
 drivers/hid/hid-input.c                            |   2 +
 drivers/hid/hid-lg-g15.c                           |   2 +-
 drivers/hid/hid-logitech-hidpp.c                   |   2 +-
 drivers/hid/hid-mcp2221.c                          |   3 +
 drivers/hid/hid-multitouch.c                       |  13 +-
 drivers/hid/hid-nintendo.c                         |   6 +-
 drivers/hid/hid-uclogic-core.c                     |   2 +
 drivers/hid/hid-uclogic-params.c                   | 225 +++++++++++++-
 drivers/hid/hid-uclogic-rdesc-test.c               | 219 ++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c                    | 124 +++++++-
 drivers/hid/hid-uclogic-rdesc.h                    |  24 +-
 drivers/hid/i2c-hid/Kconfig                        |  15 +
 drivers/hid/i2c-hid/Makefile                       |   1 +
 drivers/hid/i2c-hid/i2c-hid-of-elan.c              | 130 +++++++++
 drivers/hid/intel-ish-hid/ipc/ipc.c                |   2 +-
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       |   2 +-
 drivers/hid/wacom.h                                |   3 +
 drivers/hid/wacom_sys.c                            |   4 +-
 drivers/hid/wacom_wac.c                            | 111 +++++--
 42 files changed, 2066 insertions(+), 208 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/elan,ekth6915.yaml
 create mode 100644 drivers/hid/.kunitconfig
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_common.h
 create mode 100644 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
 create mode 100644 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
 create mode 100644 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.h
 create mode 100644 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
 create mode 100644 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
 create mode 100644 drivers/hid/hid-uclogic-rdesc-test.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of-elan.c

-- 
Jiri Kosina
SUSE Labs

