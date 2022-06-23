Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ABE5587F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiFWS4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiFWSqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:46:25 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0685DA8B45
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:50:07 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3E6BF240027
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1656006597; bh=9z4F8N+hb9sjB8yqiYKIg3nnlI5xJEvNG+P1PWED4G4=;
        h=Date:From:To:Cc:Subject:From;
        b=rp+7qA98zOJ1HB9Vu9bhFOBWPbGZNk0gze9vAYENIgC2F3KHc+m8gU6Xm5qTvjsGs
         ie8y+Zw8WrQBFq/hmTmluIAXPHl5n8PdgrL1xIug+qPE0uEGC9l3cQlebEnX6KJ39Y
         /RNEekjlfMbNmxDZarxpeQYqAfYVm08Y+LoHTW/L1/RjfqL5AEeW0JyNcSaY32UrAc
         F2NQB8K64hEDjTlqZvoqcPWDxOMe9ZDJNBWC06J3HhfGIHv04iBzDtXFKUg2Ki50uV
         llIk/3q/ozK1sRXflksG4ZWdzy6HAKKBuxOMgb7jFgpi3nZiL+InbtunFagN2tZ4bK
         LBQd90Oz5gTEg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTSSh2PVrz6tmY;
        Thu, 23 Jun 2022 19:49:56 +0200 (CEST)
Date:   Thu, 23 Jun 2022 17:49:04 +0000
From:   Tom Schwindl <schwindl@posteo.de>
To:     corbet@lwn.net
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: driver-api: gpio: Fix some typos
Message-ID: <YrSnkBodv7TYvtMb@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tom Schwindl <schwindl@posteo.de>
---
 Documentation/driver-api/gpio/consumer.rst   | 2 +-
 Documentation/driver-api/gpio/driver.rst     | 6 +++---
 Documentation/driver-api/gpio/using-gpio.rst | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index 72bcf5f5e3a2..de6fc79ad6f0 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -114,7 +114,7 @@ For a function using multiple GPIOs all of those can be obtained with one call::
 
 This function returns a struct gpio_descs which contains an array of
 descriptors.  It also contains a pointer to a gpiolib private structure which,
-if passed back to get/set array functions, may speed up I/O proocessing::
+if passed back to get/set array functions, may speed up I/O processing::
 
 	struct gpio_descs {
 		struct gpio_array *info;
diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index 70ff43ac4fcc..6baaeab79534 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -119,7 +119,7 @@ GPIO lines with debounce support
 Debouncing is a configuration set to a pin indicating that it is connected to
 a mechanical switch or button, or similar that may bounce. Bouncing means the
 line is pulled high/low quickly at very short intervals for mechanical
-reasons. This can result in the value being unstable or irqs fireing repeatedly
+reasons. This can result in the value being unstable or irqs firing repeatedly
 unless the line is debounced.
 
 Debouncing in practice involves setting up a timer when something happens on
@@ -219,7 +219,7 @@ use a trick: when a line is set as output, if the line is flagged as open
 drain, and the IN output value is low, it will be driven low as usual. But
 if the IN output value is set to high, it will instead *NOT* be driven high,
 instead it will be switched to input, as input mode is high impedance, thus
-achieveing an "open drain emulation" of sorts: electrically the behaviour will
+achieving an "open drain emulation" of sorts: electrically the behaviour will
 be identical, with the exception of possible hardware glitches when switching
 the mode of the line.
 
@@ -642,7 +642,7 @@ In this case the typical set-up will look like this:
 
 As you can see pretty similar, but you do not supply a parent handler for
 the IRQ, instead a parent irqdomain, an fwnode for the hardware and
-a funcion .child_to_parent_hwirq() that has the purpose of looking up
+a function .child_to_parent_hwirq() that has the purpose of looking up
 the parent hardware irq from a child (i.e. this gpio chip) hardware irq.
 As always it is good to look at examples in the kernel tree for advice
 on how to find the required pieces.
diff --git a/Documentation/driver-api/gpio/using-gpio.rst b/Documentation/driver-api/gpio/using-gpio.rst
index 64c8d3f76c3a..894d88855d73 100644
--- a/Documentation/driver-api/gpio/using-gpio.rst
+++ b/Documentation/driver-api/gpio/using-gpio.rst
@@ -44,7 +44,7 @@ These devices will appear on the system as ``/dev/gpiochip0`` thru
 found in the kernel tree ``tools/gpio`` subdirectory.
 
 For structured and managed applications, we recommend that you make use of the
-libgpiod_ library. This provides helper abstractions, command line utlities
+libgpiod_ library. This provides helper abstractions, command line utilities
 and arbitration for multiple simultaneous consumers on the same GPIO chip.
 
 .. _libgpiod: https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/
-- 
2.36.1

