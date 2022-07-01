Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C1563981
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiGATBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGATBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:01:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246F535AAA;
        Fri,  1 Jul 2022 12:01:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p14so3246865pfh.6;
        Fri, 01 Jul 2022 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FePtkGIG3fPNyP8jCDhz+QF1tyoCMzLu4NvPzC+Cgsc=;
        b=kG/0RvoCKA82xdIhVNShBpu7m8sIAp3jasFr3HH96k+lbHyRNZ7kn7gRXo8fm1jITv
         1ss7Ul9D4FPLulIgiUJbV2e3wnTAqNiyhS1MK7aV1cofUnsWITr+oSQWHz5xAXM7W13t
         wzH1YW8Tkgm9gTkKL1dqmtAQfcL5ex65i+CwCoPNrJgZurqykbesNru6yj0Ij0BCnlhU
         vWwcJP/KoBTUtyimLo1AmOo47DLN8YzOCTbFy/iC0HWdO5oiashidOyGvWW+mslCeNRd
         AMwXfjl9RbLROpFvzGkVzU9NwGAKDSmb3/nKa1cdU91F+aUx8GhYdIvgFtdu0O3UbQZv
         MjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FePtkGIG3fPNyP8jCDhz+QF1tyoCMzLu4NvPzC+Cgsc=;
        b=j4LlRgdnBkslIY4Tq4N7ybawquJEHqqVjsthTaJo/DkjnQ4HQQhaRrU5XCFg+yT+0X
         JN5FADaGvcjBMNSCukgY5u8Hj5AXSw/mxPlDxP+8Yrd0gtpKLnnSWtHioBpWw5RvE+iJ
         /CAcd50Bbea7RxaCcn+w08mwdFIwpN3h3fO7aGVRofbPmiFC7Qblyrq/C+qHwaPLDFS7
         Y/X6rXD1WzWDueJ/YXhHjRQfKHIuuKi7A2RE/Gxxuc95/cK990KjSMJE4wYPO0enS37E
         7D3bVXTd4DhbNmXnQy7G0dTybe1y7AKvZVGsNRbjoE3JB7p8fGcz1BCYczttuU0AF6e9
         x19w==
X-Gm-Message-State: AJIora8c4RQmqoJMQUi+zmJ6sAtMYCnFb8ShCx6f1f7j/OwAbFiPFN86
        ROAMK8OxULypQgo8t4+7Twi2sfftKCk=
X-Google-Smtp-Source: AGRyM1sXJ8Ik4r3/OgDVYHQgFL0Yj+3wLI+M3e6lIgqONfDd1b2/0Y/PeEoC7RRocYqlU52oyz6VTw==
X-Received: by 2002:a63:87c6:0:b0:411:75e3:31e0 with SMTP id i189-20020a6387c6000000b0041175e331e0mr13298424pge.408.1656702063518;
        Fri, 01 Jul 2022 12:01:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u3-20020a170903108300b0016a613012a0sm15793300pld.210.2022.07.01.12.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:01:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.19-rc5
Date:   Fri,  1 Jul 2022 12:01:01 -0700
Message-Id: <20220701190101.2982333-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.19-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.19-rc5

Thanks,
Guenter
------

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.19-rc5

for you to fetch changes up to d0e51022a025ca5350fafb8e413a6fe5d4baf833:

  hwmon: (ibmaem) don't call platform_device_del() if platform_device_add() fails (2022-07-01 11:53:29 -0700)

----------------------------------------------------------------
hwmon fixes for v5.19-rc5

* Fix error handling in ibmaem driver initialization

* Fix bad data reported by occ driver after setting power cap

* Fix typos in pmbus/ucd9200 driver comments

----------------------------------------------------------------
Eddie James (1):
      hwmon: (occ) Prevent power cap command overwriting poll response

Jiang Jian (1):
      hwmon: (pmbus/ucd9200) fix typos in comments

Yang Yingliang (1):
      hwmon: (ibmaem) don't call platform_device_del() if platform_device_add() fails

 drivers/hwmon/ibmaem.c        | 12 ++++++++----
 drivers/hwmon/occ/common.c    |  5 +++--
 drivers/hwmon/occ/common.h    |  3 ++-
 drivers/hwmon/occ/p8_i2c.c    | 13 +++++++------
 drivers/hwmon/occ/p9_sbe.c    |  7 +++----
 drivers/hwmon/pmbus/ucd9200.c |  2 +-
 6 files changed, 24 insertions(+), 18 deletions(-)
