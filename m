Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0A5A7BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiHaKyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaKyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:54:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A690AC59FF
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 583A9B81F3D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D647DC433D7;
        Wed, 31 Aug 2022 10:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661943257;
        bh=lr8x3tNF7lIWiL5VvXm5SH3TuUOBHE0m1G6/J5CEF14=;
        h=Date:From:To:cc:Subject:From;
        b=g6WrfMUQLqxKdT9+3FeZSIryjYHrlgAreK4cm/TuVNmRWwFoTH68lD46BgymBhK78
         GSaEN5+hZACTzl27Dn6d0ll9M686HwioZWPXfMcLcKHFeN1dkLPYxem1rq/jBMc0w4
         Ov6z93nmEfFC3E31jH3X2OPaOiydZtpyPDd82OphGsy8VNb8c+eNYP7sRDUH/s1A9f
         dHRaKBQgNHkAtL7hRvHKdRTcsyB5VjxdQEsIYhXQx9vmLLk+8GZiGJDeHRccN38frk
         Qbavc53G3NSN5Uh4ylkWifJe6ZNa3wVoclmmv1M9Wt4s7ctitJUMT9sDxNpTNs1GO0
         RUtuVBsaoKuQA==
Date:   Wed, 31 Aug 2022 12:54:14 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2208311248520.19850@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022083101

to receive fixes for HID subsystem. Highlights:

=====
- NULL pointer dereference fix for Steam driver (Lee Jones)
- memory leak fix for hidraw (Karthik Alapati)
- regression fix for functionality of some UCLogic tables (Benjamin 
  Tissoires)
- a few new device IDs and device-specific quirks
=====

Thanks.

----------------------------------------------------------------
Aditya Garg (1):
      HID: Add Apple Touchbar on T2 Macs in hid_have_special_driver list

Akihiko Odaki (1):
      HID: AMD_SFH: Add a DMI quirk entry for Chromebooks

Benjamin Tissoires (1):
      HID: input: fix uclogic tablets

Daniel J. Ogorchock (1):
      HID: nintendo: fix rumble worker null pointer deref

Even Xu (2):
      hid: intel-ish-hid: ishtp: Fix ishtp client sending disordered message
      HID: intel-ish-hid: ipc: Add Meteor Lake PCI device ID

Jason Wang (1):
      HID: ishtp-hid-clientHID: ishtp-hid-client: Fix comment typo

Josh Kilmer (1):
      HID: asus: ROG NKey: Ignore portion of 0x5a report

Karthik Alapati (1):
      HID: hidraw: fix memory leak in hidraw_release()

Lee Jones (1):
      HID: steam: Prevent NULL pointer dereference in steam_{recv,send}_report

Michael Hübner (1):
      HID: thrustmaster: Add sparco wheel and fix array length

Steev Klimaszewski (1):
      HID: add Lenovo Yoga C630 battery quirk

 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 18 +++++++++
 drivers/hid/hid-asus.c                   |  7 ++++
 drivers/hid/hid-ids.h                    |  3 ++
 drivers/hid/hid-input.c                  |  7 +++-
 drivers/hid/hid-nintendo.c               |  6 ++-
 drivers/hid/hid-quirks.c                 |  2 +
 drivers/hid/hid-steam.c                  | 10 +++++
 drivers/hid/hid-thrustmaster.c           |  3 +-
 drivers/hid/hidraw.c                     |  2 +
 drivers/hid/intel-ish-hid/ipc/hw-ish.h   |  1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c  |  1 +
 drivers/hid/intel-ish-hid/ishtp-hid.h    |  2 +-
 drivers/hid/intel-ish-hid/ishtp/client.c | 68 ++++++++++++++++++--------------
 13 files changed, 96 insertions(+), 34 deletions(-)

-- 
Jiri Kosina
SUSE Labs

