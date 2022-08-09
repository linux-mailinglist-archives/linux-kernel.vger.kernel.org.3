Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080CF58D217
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiHICvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHICvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:51:09 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92869192BF;
        Mon,  8 Aug 2022 19:51:08 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B7BDF5C01AC;
        Mon,  8 Aug 2022 22:51:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 08 Aug 2022 22:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660013467; x=1660099867; bh=tIl52IRQaxW/iUmLxVVcxMgfe
        DapuxQ+9WVpDqlMsAQ=; b=VpNPGfd22vom+5qO8FHLQJB8V5K6Ztzvw/UPssoKD
        OeNhMyc/2TJQUDwORZW91pwwZnE1+KHlaOtIIYdllQX0F0iU3AwsMyyS9Ypcs8Ot
        P3CrEu+vKaHj9BjXD1/7f+IbKC5E+OyP720Gxs6GcqkrG51jG+NhZ2qY8+wzc7C/
        liRAL8iuEO5z3M6uL62268G50DeJljFvIcnW4JKkBJ7caO9UZlwoNH/Pdm/xiLgI
        3KK334R2pY01XgiNEwaSx1Mm9z9htIkxSgyILTRNWdjQUxQjSXoJ3lObBXlnoObO
        pQ03uCv+gJhJZDyH+tk+5JLZ/PIzPANA5zt2TtB0dK3WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660013467; x=1660099867; bh=tIl52IRQaxW/iUmLxVVcxMgfeDapuxQ+9WV
        pDqlMsAQ=; b=zhBxPFJPabVIJBUuhrgACL92kpno123egEtLo2bhWR/54qqaC/y
        lLdr86NE7WmfTG4PHPL0H75xeK0MlHA8TsEGItLtkSCNcfI+1KAflVcD9Yh0cF3w
        Jnrm6nN8NQmUpH0efMqK1PcMRBZvXF4CDxegFp3uvUq1Loh76uSm0YXBqYTQAGZo
        lse3SHgiGMFPiUiqeHm3gAq2KY1Lh7UWlpi8UmFVKCM5vg9sqP5w6k0lVo46FfcO
        Yl92jy/ghvwTAdzfDKUD0tQsgMEflq9HDqxBnUAluBRM2SfgmU1p+KvhQjtCOLYX
        nftjK+Z5tajQ6jEqc2JQ6hQvIVAKswHzvLg==
X-ME-Sender: <xms:m8vxYrCbFj0kTL_qRBpnfJaUGa-aDCpuoWPtChsWNSZS601IxdMHuw>
    <xme:m8vxYhiGtsBgXK6s8GwiaET1qB3J01rvI4qPbtk91A4KafZn-MzSuuOw7Nd4TorGN
    h0f_8Px1blhX0La-jI>
X-ME-Received: <xmr:m8vxYmkAsW8hFKoJo1UplCKl9cRPoVcV9zeXFNq3pA6qf2F3lxCOUnBGO6XR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgeegieevfeekleejvefhkedvhfffue
    egudeljeeiieeuhfegkeehtdevuedujeejnecuffhomhgrihhnpehlkhhmlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:m8vxYtzuakhiItGXSkRyzg_fzvNlDm2n_on8K0kJBn7jiE_dVd2GCw>
    <xmx:m8vxYgQgNR_DnDVVEYwQkW1mQENu7St0ibvfvgk5Bz_xGv59FHClMQ>
    <xmx:m8vxYgbW-IASn3c9-FueyvAgnItqi1WdHl63Q3ZXZNR47nLkcQWQqw>
    <xmx:m8vxYmPTMBgUj22SksHcrvD03iE0BtyiIgPS8_4AutPWL56J6fpZaw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 22:51:03 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 0/6] asus-wmi: Add support for RGB keyboards
Date:   Tue,  9 Aug 2022 14:50:48 +1200
Message-Id: <20220809025054.1626339-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series to add RGB support for ASUS laptops.
The laptops with this RGB tend to be the TUF series of gamer laptops.

The first step is initial bringup of support using the multicolor LED API.

These types of keyboards implement a slightly more complex interface than
just RGB control however - they also have modes with can be static LED,
blinking, rainbow, color cycles, and more. They also have some custom
animations that can play depending on device state, such as suspended
playing a fancy colour cycle, or playing a "wave" animation.

Two of the patches add support for these features.

One patch adds documentation in:
Documentation/ABI/testing/sysfs-platform-asus-wmi
for some features that were added previously.

The final patch adds support for a particular MUX switch found only
on a few ROG laptops. This patch is added to this series due to some
conflicts in merge caused by the RGB patch series.

Some notes:

- this patch series obsoletes the previous RGB patches by myself

- it is not possible to add attribute groups to multicolor LED as
  they get overwritten by `led_multicolor_groups` in
  `led_classdev_multicolor_register_ext`.

- the methods for RGB control do not provide a way to fetch exisiting
  state, so these methods are WO.

- There is an existing `asus::kbd_backlight`, this provides a 4-step
  brightness to the RGB (off,low,med,high) individually to multicolor.
  I was unsure of the effect of adding a similar path so have used the
  `asus::multicolour::kbd_backlight` name to be clear about purpose.
  If the `asus::kbd_backlight` is off, then no RGB is shown at all.
  
Changelog:
- V3: patch 2: asus-wmi RGB mode control
	+ Split save, speed, mode in to separate nodes
	+ Remove the _index node as it is not required with the above nodes
	+ Cleanup of a one-line ternary
	+ rename asus->keyboard_rgb_mode to keyboard_rgb_led to be clearer about purpose
	+ Attach documentation to this patch
- V3: patch 3:
	+ Use BIT() in place of previous hex for flags
	+ Comment on purpose of 0xbd in state write
	+ Attach documentation to this patch
- V3: patch 6: asus-wmi: hardware GPU MUX:
	+ Include the correct patch for this feature 
- V2: patch 1: asus-wmi - RGB
	+ shorten a few lines
	+ move unused keyboard_rgb_mode_available to next patch
	+ remove tuf_rgb_brightness_get() is it was only returning current
	  led_classdev brightness, not reading it from device
	+ remove unnecessary setting of brightness on multicolor init
	+ set brightness_get to null for TUF RGB
	+ actually use the member subled_info in keyboard_rgb_led struct and
	  not the leftover dynamic allocation (now removed)
- V2: patch 2: asus-wmi RGB mode control
	+ tuf_rgb_brightness_set() was still using hardcoded save/mode/speed
	  from testing. This is now using the pre-set default.
	+ asus_wmi_led_init(), set speed value to a correct value
	+ keyboard_rgb_mode_store() return count, not 0
	+ correctly unregister the mulicolor led on module exit
	+ use switch/case in keyboard_rgb_mode_store() for speed
	+ remove a single line bracket block
- V2: patch 3: asus-wmi RGB power control
	+ Try to fix the indent warning from buildbot
	+ Use correct date on added API docs
	+ Add missing panel_od doc
	+ correctly label attribute for keyboard_rgb_state
- V2: patch 4: documentation
	+ Add commit message
- V2: patch 5: attributes using sysfs_emit:
	+ Add commit message
- V2: patch 6: new patch, dgpu_only mode
	+ A previous patch I submitted "0006-asus-wmi-Add-support-for-dGPU-only-mode.patch"
	  is now part of this series due to merge conflicts caused by the
	  previous 5 patches

Previous patches obsoleted:
https://lkml.org/lkml/2022/8/3/885
https://lkml.org/lkml/2022/8/3/886
https://lkml.org/lkml/2022/8/3/44
I may not have listed all.

Luke D. Jones (6):
  asus-wmi: Implement TUF laptop keyboard RGB control
  asus-wmi: Implement TUF laptop keyboard LED modes
  asus-wmi: Implement TUF laptop keyboard power states
  asus-wmi: Document previously added attributes
  asus-wmi: Convert all attr-show to use sysfs_emit
  asus-wmi: Support the hardware GPU MUX on some laptops

 .../ABI/testing/sysfs-platform-asus-wmi       |  83 ++++
 drivers/platform/x86/asus-wmi.c               | 368 +++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h    |   8 +
 3 files changed, 452 insertions(+), 7 deletions(-)

-- 
2.37.1

