Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF07E547B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 21:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiFLTCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiFLTCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 15:02:01 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55219167C4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 12:01:58 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BA316240027
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 21:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1655060515; bh=OIJ2JP7SQeXyamrKWxoIIVw/HJ+6Iauyz0L3wpT0p3s=;
        h=Date:From:To:Cc:Subject:From;
        b=pdv5QUjSULTph4ufdkyAhyOK41v50GuNzt8MFjO+nFdBTb10GK9w6jzRFrnsApqKm
         t9xt7u8xnYT9nsyn8IY8/X7wlsuDvjT/cp/MHczuSTrqK94WHVqpKeT0hfeWHrWFTk
         QyeclBX0tu1eHzk5cQobkM5KSZDSSk47OhroIETTdUT4iN0t1ZzKFTyru7TeRBEmxF
         gGmPyRqLLwC0AbnvJqQnfmSF0dZYcDx60Un35Kq5mA2SGBjytGvGFHC+lNME90I45l
         NZDl64+VYhsixylsRNTMwibr7U8YlrNrzBykzb0ijn/A7+oJTqDzu5xiQHrj6JP2cb
         E+MmYNfnMyvng==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LLkZp6cJyz6tmX;
        Sun, 12 Jun 2022 21:01:54 +0200 (CEST)
Date:   Sun, 12 Jun 2022 19:01:09 +0000
From:   Tom Schwindl <schwindl@posteo.de>
To:     corbet@lwn.net
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: driver-api: gpio: Fix filename mismatch
Message-ID: <YqY39Rwi4Lnzw2GH@posteo.de>
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

The filenames were changed a while ago, but board.rst, consumer.rst and
intro.rst still refer to the old names. Fix those references to match the
Actual names and avoid possible confusion.

Signed-off-by: Tom Schwindl <schwindl@posteo.de>
---
 Documentation/driver-api/gpio/board.rst    | 2 +-
 Documentation/driver-api/gpio/consumer.rst | 6 +++---
 Documentation/driver-api/gpio/intro.rst    | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index 4e3adf31c8d1..b33aa04f213f 100644
--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -6,7 +6,7 @@ This document explains how GPIOs can be assigned to given devices and functions.
 
 Note that it only applies to the new descriptor-based interface. For a
 description of the deprecated integer-based GPIO interface please refer to
-gpio-legacy.txt (actually, there is no real mapping possible with the old
+legacy.rst (actually, there is no real mapping possible with the old
 interface; you just fetch an integer from somewhere and request the
 corresponding GPIO).
 
diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index 47869ca8ccf0..72bcf5f5e3a2 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -4,7 +4,7 @@ GPIO Descriptor Consumer Interface
 
 This document describes the consumer interface of the GPIO framework. Note that
 it describes the new descriptor-based interface. For a description of the
-deprecated integer-based GPIO interface please refer to gpio-legacy.txt.
+deprecated integer-based GPIO interface please refer to legacy.rst.
 
 
 Guidelines for GPIOs consumers
@@ -78,7 +78,7 @@ whether the line is configured active high or active low (see
 
 The two last flags are used for use cases where open drain is mandatory, such
 as I2C: if the line is not already configured as open drain in the mappings
-(see board.txt), then open drain will be enforced anyway and a warning will be
+(see board.rst), then open drain will be enforced anyway and a warning will be
 printed that the board configuration needs to be updated to match the use case.
 
 Both functions return either a valid GPIO descriptor, or an error code checkable
@@ -270,7 +270,7 @@ driven.
 The same is applicable for open drain or open source output lines: those do not
 actively drive their output high (open drain) or low (open source), they just
 switch their output to a high impedance value. The consumer should not need to
-care. (For details read about open drain in driver.txt.)
+care. (For details read about open drain in driver.rst.)
 
 With this, all the gpiod_set_(array)_value_xxx() functions interpret the
 parameter "value" as "asserted" ("1") or "de-asserted" ("0"). The physical line
diff --git a/Documentation/driver-api/gpio/intro.rst b/Documentation/driver-api/gpio/intro.rst
index 2e924fb5b3d5..c9c19243b97f 100644
--- a/Documentation/driver-api/gpio/intro.rst
+++ b/Documentation/driver-api/gpio/intro.rst
@@ -14,12 +14,12 @@ Due to the history of GPIO interfaces in the kernel, there are two different
 ways to obtain and use GPIOs:
 
   - The descriptor-based interface is the preferred way to manipulate GPIOs,
-    and is described by all the files in this directory excepted gpio-legacy.txt.
+    and is described by all the files in this directory excepted legacy.rst.
   - The legacy integer-based interface which is considered deprecated (but still
-    usable for compatibility reasons) is documented in gpio-legacy.txt.
+    usable for compatibility reasons) is documented in legacy.rst.
 
 The remainder of this document applies to the new descriptor-based interface.
-gpio-legacy.txt contains the same information applied to the legacy
+legacy.rst contains the same information applied to the legacy
 integer-based interface.
 
 
-- 

