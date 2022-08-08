Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9246F58C1ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiHHDFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiHHDEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:04:51 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAC4BE00;
        Sun,  7 Aug 2022 20:04:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EF2135C00E6;
        Sun,  7 Aug 2022 23:04:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 07 Aug 2022 23:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659927887; x=1660014287; bh=Z5R2L+gMqfhlDJ1pKWrydVVz6
        GYap6Tl3Yu7djbzgvs=; b=Nz++NDIf38kPg1jnEzQFeX0mTgof8CFW8ZJEAYG1i
        b7uOvDsTG2G62qyycOyEl/ZWSkLY8wRwB32RbNBelZVQzZKsn8Ozl5u18WmutS2/
        W9SQBzl2Xr/szCvTu7+fyrlxArFMFXk87N7d5GAokRag4zi1rkzuOh+evpSxyjs4
        gZuk6O1u9dfkZU1HHbrT12kSeZes0CZBOgVzXXUMQfW569vNiCzSJ33kYhxroMsJ
        CDZUzSnCGpA+nnTKzf5M2/CaTPoxxIqeCazJmRr5ofMI5yO4hAA80Li0OOhO/z3s
        +/Z+Itw9C3I9N7XWhb17OEP1/lqYd2TTHZwdTdsxPJ5QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1659927887; x=1660014287; bh=Z5R2L+gMqfhlDJ1pKWrydVVz6GYap6Tl3Yu
        7djbzgvs=; b=kXvfHvWN4gAbUQY5hATCGtBCgyq69kUDd9q28I1XMf46hziZgqr
        v9ouPl2c4SmQw91obfc20sgGgqVBrEBjtbBvbh7nbvevf9w0zHPVOBYujyyxkdHk
        QH6AzBHofNgpJ+l39VWZ6baXOS+4q7ji4ngREHxecQ2Oa+tTK7Mxn1/L6MF1PWvZ
        vzhwhAjF5u87G9XB23Ud/E+Jfiut1mIy4VvIXGmSBaz1infeEj3Fi+Lv9vcvA4yQ
        kb+kz5i+YCly+ngiMFDQC+gSIf1dsCglH1lUwQqYJIH4yMCGHFViM8vr603i8o/s
        A+i0PWUiTJSgPRIprHca+GTmgdzjfLxGWQw==
X-ME-Sender: <xms:T33wYrcvviOQveMH83zBCQRvDoA__xAz67lGGJprxjavCMQvka5_pA>
    <xme:T33wYhPXgg3GqlhtccoQEAxE_Pw9EBpzY3zngrw4AuLx6V4QL9zPwsqVl-6mCC3my
    0uDuyScdiQcck2IGb8>
X-ME-Received: <xmr:T33wYkj91ASnUO-5qRsbyErrX1VCWrjFl6wTASEhf9CktDcZMUpCy-RAbfpB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgeegieevfeekleejvefhkedvhfffue
    egudeljeeiieeuhfegkeehtdevuedujeejnecuffhomhgrihhnpehlkhhmlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:T33wYs_zgZ1ol6KnFTMOGboX2uDu_ZJ2hckVFGFwysj7JVFGk935Ow>
    <xmx:T33wYnuNeFKJmHs1R5DNZ7vS5ovlRDmuwczdrOpGcvJYfxknT0hdJQ>
    <xmx:T33wYrFbuwTroURcJG7xZQopNbZWnbmbEfsMCTzH2lwYdXIutYT3Gg>
    <xmx:T33wYg6v-xUOGn7mB_2Jr_dzXr9IEd7QGCPrR4J_MG60HpSmQ1cCyQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:04:44 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/6] asus-wmi: Add support for RGB keyboards
Date:   Mon,  8 Aug 2022 15:04:14 +1200
Message-Id: <20220808030420.8633-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

The last patch adds documentation in:
Documentation/ABI/testing/sysfs-platform-asus-wmi

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
  asus-wmi: Add support for dGPU-only mode

 .../ABI/testing/sysfs-platform-asus-wmi       |  68 ++++
 drivers/platform/x86/asus-wmi.c               | 343 +++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h    |   8 +
 3 files changed, 412 insertions(+), 7 deletions(-)

-- 
2.37.1

