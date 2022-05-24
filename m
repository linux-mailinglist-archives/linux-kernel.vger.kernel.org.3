Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CBD532627
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiEXJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiEXJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:11:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC32ADF35
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32943615F5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80696C385AA;
        Tue, 24 May 2022 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653383488;
        bh=nm267qQMC+ijTPFmPNwaNVgihYuezEhC/N8QJDt3XLY=;
        h=Date:From:To:cc:Subject:From;
        b=HmuUWEKnT8tk3KvfWOecJ+TQi7MbbgaNtLoCfVwvf+gfSffh2b/mT3xDsSFjMI9ex
         cbp24/LQzdN0uOHzPwPSs42iZrqGQZbq7lDvCUhFdzpEI2bLviAEAhMosXuui/S7ix
         MqmrYTu9VeKG09cAtn9+LBxNbO1oPds7Z5HYEjU6S/CR3KuCiFFbCWnv0VzYQ8sTrj
         7sklCqJnSdhp5mQYaO6vrGk5XQpGBldHD0XYLk33znACqpjj6eVxioTLICk5H5e+C1
         F8iF/ccGWyh8KTVUxi0f1O3KMQLiL8OYTa+gkTiP5Uhd1V6X5Ceaz6IRezJh3RTlxy
         3yHc6bgahQM6w==
Date:   Tue, 24 May 2022 11:11:25 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 5.19
Message-ID: <nycvar.YFH.7.76.2205241107530.28985@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022052401

to receive HID subsystem patch queue for 5.19 merge window. Highlights:

=====
- support for pens with 3 buttons with Wacom driver (Joshua Dickens)
- support for HID_DG_SCANTIME to report the timestamp for pen and touch 
  events in Wacom driver (Joshua Dickens)
- support for sensor discovery in amd-sfh driver (Basavaraj Natikar)
- support for wider variety of Huion tablets ported from DIGImend project 
  (José Expósito, Nikolai Kondrashov)
- new device IDs and other assorted small code cleanups
=====

Thanks.

----------------------------------------------------------------
Basavaraj Natikar (7):
      HID: amd_sfh: Add support for sensor discovery
      HID: amd_sfh: Add sensor name by index for debug info
      HID: amd_sfh: Modify the bus name
      HID: amd_sfh: Modify the hid name
      HID: amd_sfh: Add physical location to HID device
      HID: amd_sfh: Move bus declaration outside of amd-sfh
      HID: core: Display "SENSOR HUB" for sensor hub bus string in hid_info

Bastien Nocera (1):
      HID: wacom: Correct power_supply type

Bryan Cain (1):
      HID: apple: Properly handle function keys on Keychron keyboards

Dongliang Mu (1):
      HID: bigben: fix slab-out-of-bounds Write in bigben_probe

Even Xu (1):
      HID: intel-ish-hid: ipc: add ADL and RPL device id

Jonathan Teh (1):
      HID: hid-led: fix maximum brightness for Dream Cheeky

Joshua-Dickens (2):
      HID: wacom: Adding Support for new usages
      Hid: wacom: Fix kernel test robot warning

Marek Ma¶lanka (1):
      HID: multitouch: Add support for Google Whiskers Touchpad

Miaoqian Lin (1):
      HID: elan: Fix potential double free in elan_input_configured

Nehal Bakulchandra Shah (1):
      HID: amd_sfh: Remove name from maintainers list

Nikolai Kondrashov (19):
      HID: uclogic: Add support for touch ring reports
      HID: uclogic: Support custom device suffix for frames
      HID: uclogic: Allow three frame parameter sets
      HID: uclogic: Add support for Huion touch ring reports
      HID: uclogic: Compress params format string
      HID: uclogic: Reduce indent for params format str/args
      HID: uclogic: Add support for bitmap dials
      HID: uclogic: Add support for Huion Q620M
      HID: uclogic: Clarify params desc_size description
      HID: uclogic: Clarify pen/frame desc_ptr description
      HID: uclogic: Pass keyboard reports as is
      HID: uclogic: Support disabling pen usage
      HID: uclogic: Disable pen usage for Huion keyboard interfaces
      HID: uclogic: Move param printing to a function
      HID: uclogic: Return raw parameters from v2 pen init
      HID: uclogic: Do not focus on touch ring only
      HID: uclogic: Always shift touch reports to zero
      HID: uclogic: Differentiate touch ring and touch strip
      HID: uclogic: Switch to Digitizer usage for styluses

Ping Cheng (1):
      MAINTAINERS: Add Wacom driver maintainers

Roman Romanenko (1):
      HID: uclogic: Add pen support for XP-PEN Star 06

Tao Jin (1):
      HID: multitouch: add quirks to enable Lenovo X12 trackpoint

Tom Rix (1):
      HID: amd_sfh: change global variables to static

ValdikSS (3):
      HID: lenovo: Add support for ThinkPad TrackPoint Keyboard II
      HID: lenovo: Sync Fn-lock state on button press for Compact and TrackPoint II keyboards
      HID: lenovo: Add note about different report numbers

frank zago (1):
      HID: Add support for Mega World controller force feedback

 MAINTAINERS                                        |   9 +-
 drivers/hid/Kconfig                                |   8 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c           |  45 +++-
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c              |   9 +-
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h              |   1 -
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |  17 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h             |   5 +
 .../hid_descriptor/amd_sfh_hid_report_desc.h       |   6 +-
 drivers/hid/hid-apple.c                            |  22 +-
 drivers/hid/hid-bigbenff.c                         |   6 +
 drivers/hid/hid-core.c                             |   4 +
 drivers/hid/hid-elan.c                             |   2 -
 drivers/hid/hid-ids.h                              |   7 +
 drivers/hid/hid-kye.c                              |  12 +-
 drivers/hid/hid-led.c                              |   2 +-
 drivers/hid/hid-lenovo.c                           | 174 ++++++++++++-
 drivers/hid/hid-megaworld.c                        | 125 +++++++++
 drivers/hid/hid-multitouch.c                       |   9 +
 drivers/hid/hid-uclogic-core.c                     | 113 ++++++--
 drivers/hid/hid-uclogic-params.c                   | 288 +++++++++++++++++----
 drivers/hid/hid-uclogic-params.h                   | 105 ++++----
 drivers/hid/hid-uclogic-rdesc.c                    | 181 +++++++++++--
 drivers/hid/hid-uclogic-rdesc.h                    |  34 ++-
 drivers/hid/hid-viewsonic.c                        |   2 +-
 drivers/hid/intel-ish-hid/ipc/hw-ish.h             |   2 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   2 +
 drivers/hid/wacom_sys.c                            |   2 +-
 drivers/hid/wacom_wac.c                            |  43 ++-
 drivers/hid/wacom_wac.h                            |   5 +
 include/uapi/linux/input.h                         |   1 +
 31 files changed, 1054 insertions(+), 188 deletions(-)
 create mode 100644 drivers/hid/hid-megaworld.c

-- 
Jiri Kosina
SUSE Labs

