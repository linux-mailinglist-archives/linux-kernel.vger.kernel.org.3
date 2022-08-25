Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF5E5A1D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244069AbiHYXXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243907AbiHYXXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:23:07 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20054C2FA4;
        Thu, 25 Aug 2022 16:23:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 227C6320016F;
        Thu, 25 Aug 2022 19:23:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 25 Aug 2022 19:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1661469783; x=1661556183; bh=mDuvvb9RCIojYgQ0FIAsxRInC
        RiRXtle30ZDjvxkp+g=; b=O9SQooAi8n/6mJTIUcaHbwmzu9FcNkohNTvKTf6ip
        R2Z82Tj2r/037LiYGC2H1zkNiqKNWV76aSzhxKL594VG2F/GQxSjF9z2nHqMosvJ
        bHFNwHlKJz4up4Eid9sEMiV/kO2/3ZA07uhSSmnF/vcLRRkOD0OX895AYYCl16Ae
        heHYAlFyXkKzPzHU7JTo4l7kSp/bgFDsHZ9n+mSIcX+nQbDtGcjjNcXrsot7OXHG
        OvDOcUx+Mwu93RIyRVQeEB7YgvCXj6FFoXqpVtfrTy7IbRiBlPc0eBTEI/4z7/Gq
        W5G61njdHoW9d/9QEoWnbCeetZzZqD13ElSP4FR1k7epQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1661469783; x=1661556183; bh=mDuvvb9RCIojYgQ0FIAsxRInCRiRXtle30Z
        Djvxkp+g=; b=UYAGwlCGSGtZXHxv1TQtvYcDVy8xZRBxarx7wacWX30uk+yZu1L
        ASbMWkIeM1TUjHgZKtUdpKTVy5C3Pcko6/7duHvnKFSlVFUCVUWrR7YX4YekE4WE
        y9LlEAREENdFkEHHEWapc+9IWd6x0n1qwjGLfhN6kmC1nQJHDcgHM8mozo3HnupE
        A4bZvIbXCpJuJdm/ypkpPSndZZsXePgtng9sRi3HzMD2nKf7d8D9JwSeJPJNqs49
        tm51hqBxvmqJnHB+8o0O0LO44gKIwX61W6pNF31GoQYnNOTY7ighpT4yfTY3UBHI
        EVA7Rp6RmomHP+IZcdZN1AK94zzfYEYznTg==
X-ME-Sender: <xms:VwQIYzfsEZ6th69ZLjoyt1YuKMltwvMoqjeqHjfkSpdsxvSs4T3iNA>
    <xme:VwQIY5MZhSSWey4Haec6mGvRys1ndK_cZT7C7IRGaihmoChdiP1XejJQLu3tjPuay
    42uIUZ9hBV4S1ogqxE>
X-ME-Received: <xmr:VwQIY8hNiiaMUPoQkOTRa7GNkAzqn10X2fL5pDlkTgjDUvDUDebPPVGMr5Zd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnheptdehkeeigeeggfelkeeufeefjeduvd
    ejveduvdehtdegveeftdeugeetvdeltdejnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:VwQIY086CBSnPfpp6eWyajkAehh4PMgF7KwP0c8MI2jvWBeQoLsGOw>
    <xmx:VwQIY_uR-2qGzuwRgbPHVhlkFEjHrnr-7fzhS39iemWLQros5GxOVQ>
    <xmx:VwQIYzFGj1DztRHWf-6e8_ibgGbrE_RqUaiD1Ifi7-nOSOA_fo21RA>
    <xmx:VwQIY1XK0ofilkjfCyTFflvehTf95cNi2zeaDnEf-OMWxV3pFBhFnQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 19:22:58 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        pobrn@protonmail.com, pavel@ucw.cz,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 0/2] asus-wmi: Add support for RGB keyboards
Date:   Fri, 26 Aug 2022 11:22:49 +1200
Message-Id: <20220825232251.345893-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series to add RGB support for ASUS laptops.
The laptops with this RGB tend to be the TUF series of gamer laptops.

These types of keyboards implement a slightly more complex interface than just
RGB control - they also have modes with can be static LED, blinking, rainbow,
color cycles, and more. They also have some custom animations that can play
depending on device state, such as suspended playing a fancy colour cycle, or
playing a "wave" animation.

Two of the patches add support for these features.

It should be noted that these patches progressed from an initial version much
like the one here, to an implementation using the multicolor RGB class that is
available. This class was found to be unsuitable after testing actual use
because these keyboards provide a `asus::kbd_backlight` backlight control which
is 4-step, and completely turns off LEDs, alongside the fact that some laptops
boot with LEDs off by default, making multicolor invisible.

The added attributes for RGB control are added to attr groups under
asus::kbd_backlight.

Previous discussion regarding the above can be found here:
https://lore.kernel.org/platform-driver-x86/af6b9480-5e33-ec1b-94cc-e51724db0716@redhat.com/
  
Changelog:
- V4:
+ Reimplement an version of the patch with attributes for control. 
+ Add the control attributes as a group under `asus::kbd_backlight`
+ Rebased on `review-hans`
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

Luke D. Jones (2):
  asus-wmi: Implement TUF laptop keyboard LED modes
  asus-wmi: Implement TUF laptop keyboard power states

 drivers/platform/x86/asus-wmi.c            | 157 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   6 +
 2 files changed, 162 insertions(+), 1 deletion(-)

-- 
2.37.1

