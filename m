Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EEC4ACDCF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiBHBGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbiBGXyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:54:46 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D12BC061355;
        Mon,  7 Feb 2022 15:54:46 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id r144so19067042iod.9;
        Mon, 07 Feb 2022 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsFG5/GvZCP7d6Q7fgcMRKXpI72aUAEHst1zGwkjpaw=;
        b=Ttmc6V889RmJ6MHAGUJtazmXijIa85n3LlNxupw3lelmko7Xng3pDOFVybhEpsG35n
         8eEmXbgeqYzvp7n83Y8J2m/Zcklhm/ey9Cpj+PHrOUD6qhvBjd3E4Wq/OogBqZk2k8Aa
         txj0Wd9LNQanpICfBvecoBB7NpS5RSDwWr7G972OZVZynLwy06wLHYb6NJOjgS0tNb6h
         3+1Y8aFO0Hd/UrTC1tJGVe0toX542zxMEVLMNdX2eCXPcCzHMxbUOJleTAqGQJgORAPN
         Z60YJFTYrk8Xo+ZZNaXiZ4ar5YajGVyxg1bbgIx2KfHG6vEzEgMdoUcoO/zx8AVMsezj
         +U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsFG5/GvZCP7d6Q7fgcMRKXpI72aUAEHst1zGwkjpaw=;
        b=mDVfs3FvxE4ZKLXsoQBCDwBh0PbRivo1yW+vr0HAE6EGF+jdeJ5uzUehyy+atIJM+D
         KUmJPGsyql3Fz4wFqM7RVxNnzlq9U5sAGeG++IP7JwH90E1MQtW8kQLNkSV8wucvkY64
         YAeLWaovwzsXqWykPqp8/efE0uIXCPJe/6DIxQwBnIk9hcEkJXusK8/HU0V4CxadBvfm
         fMzkkCLjIFMsRKYzpAAYVqFvJ5kbxiJo1rylNiLYgP7wMmCpzZ1+r97ip77/yETw+mUo
         3uZUAOledXIL+KRBgzNmlvmBOrVuKf6+CHBiNobQ8T99XKFlQVBh0crBCJzkSp1Vya9H
         24RA==
X-Gm-Message-State: AOAM530VpBLwtqLUACO3Ryf7DXQ5RXT/aRaB1yP7/+9yEii6ytgOKSRa
        glaAWR3Vvn0NMlM0HMGCSvCAu+D7R4t0p6uw
X-Google-Smtp-Source: ABdhPJxXRaSZjvMa7wV2I843eAN5giCRrPzED7V6mf7qaX885XlsWgHillQURNcqTg9lrfh8ROfE9w==
X-Received: by 2002:a05:6638:10ea:: with SMTP id g10mr959591jae.79.1644278085342;
        Mon, 07 Feb 2022 15:54:45 -0800 (PST)
Received: from localhost.localdomain (c-174-52-171-58.hsd1.ut.comcast.net. [174.52.171.58])
        by smtp.gmail.com with ESMTPSA id w10sm6948815iow.44.2022.02.07.15.54.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Feb 2022 15:54:45 -0800 (PST)
From:   Ethan Dye <mrtops03@gmail.com>
Cc:     Ethan Dye <mrtops03@gmail.com>, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-doc@vger.kernel.org
Subject: [PATCH] block/zram: Fix wording in optional feature docs
Date:   Mon,  7 Feb 2022 16:54:42 -0700
Message-Id: <20220207235442.95090-1-mrtops03@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some simple grammar errors in the documentation for zram,
specifically errors in the optional featue section of the zram
documentation.

Signed-off-by: Ethan Dye <mrtops03@gmail.com>
---
 Documentation/admin-guide/blockdev/zram.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 3e11926a4df9..54fe63745ed8 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -315,8 +315,8 @@ To use the feature, admin should set up backing device via::
 
 	echo /dev/sda5 > /sys/block/zramX/backing_dev
 
-before disksize setting. It supports only partition at this moment.
-If admin wants to use incompressible page writeback, they could do via::
+before disksize setting. It supports only partitions at this moment.
+If admin wants to use incompressible page writeback, they could do it via::
 
 	echo huge > /sys/block/zramX/writeback
 
@@ -341,9 +341,9 @@ Admin can request writeback of those idle pages at right timing via::
 
 	echo idle > /sys/block/zramX/writeback
 
-With the command, zram writeback idle pages from memory to the storage.
+With the command, zram will writeback idle pages from memory to the storage.
 
-If admin want to write a specific page in zram device to backing device,
+If an admin wants to write a specific page in zram device to the backing device,
 they could write a page index into the interface.
 
 	echo "page_index=1251" > /sys/block/zramX/writeback
@@ -354,7 +354,7 @@ to guarantee storage health for entire product life.
 
 To overcome the concern, zram supports "writeback_limit" feature.
 The "writeback_limit_enable"'s default value is 0 so that it doesn't limit
-any writeback. IOW, if admin wants to apply writeback budget, he should
+any writeback. IOW, if admin wants to apply writeback budget, they should
 enable writeback_limit_enable via::
 
 	$ echo 1 > /sys/block/zramX/writeback_limit_enable
@@ -365,7 +365,7 @@ until admin sets the budget via /sys/block/zramX/writeback_limit.
 (If admin doesn't enable writeback_limit_enable, writeback_limit's value
 assigned via /sys/block/zramX/writeback_limit is meaningless.)
 
-If admin want to limit writeback as per-day 400M, he could do it
+If admin wants to limit writeback as per-day 400M, they could do it
 like below::
 
 	$ MB_SHIFT=20
@@ -375,16 +375,16 @@ like below::
 	$ echo 1 > /sys/block/zram0/writeback_limit_enable
 
 If admins want to allow further write again once the budget is exhausted,
-he could do it like below::
+they could do it like below::
 
 	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
 		/sys/block/zram0/writeback_limit
 
-If admin wants to see remaining writeback budget since last set::
+If an admin wants to see the remaining writeback budget since last set::
 
 	$ cat /sys/block/zramX/writeback_limit
 
-If admin want to disable writeback limit, he could do::
+If an admin wants to disable writeback limit, they could do::
 
 	$ echo 0 > /sys/block/zramX/writeback_limit_enable
 
@@ -393,7 +393,7 @@ system reboot, echo 1 > /sys/block/zramX/reset) so keeping how many of
 writeback happened until you reset the zram to allocate extra writeback
 budget in next setting is user's job.
 
-If admin wants to measure writeback count in a certain period, he could
+If admin wants to measure writeback count in a certain period, they could
 know it via /sys/block/zram0/bd_stat's 3rd column.
 
 memory tracking
-- 
2.32.0 (Apple Git-132)

