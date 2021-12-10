Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418DD470BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbhLJUoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhLJUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:44:46 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68A8C061746;
        Fri, 10 Dec 2021 12:41:10 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id u74so14789671oie.8;
        Fri, 10 Dec 2021 12:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAC08hRIlv2dTeioKqE14yRYlHCAq47RZTeon0Dsuys=;
        b=T4NB9uXFEwxOxwQL+qvvR5U7gW+2BHNGzuRV5fhUtWnnQQjfVZnwBeXIflF93dguFU
         5p4LfB5h5F6g3oB4oMc8S+BVW9RAkXXXQwF+XgEi7ZYFoqPnLTwQJhzyIPNvyNdK3/71
         FLph5IdQSNXL5/YKmwCABs/LKc7c38wgths8nZf0uQz3t9T3yOEWMbnO48EkoiLbVEDr
         5p2TQHyt2WQu2Hnp1G0J9lOWDWobjmNaOUdVCy9WOMPkQbdQIihClVbCXy5f5htUc7c8
         lVm+YXalk71jd8NxIWfV85MzfflTawvDTTU3D0zJakQAeI40Eb0H78fjStJJ91wiVydr
         4PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pAC08hRIlv2dTeioKqE14yRYlHCAq47RZTeon0Dsuys=;
        b=C3hrfx1pJ3ZARfnWItRjpQrj/sQs68yh1kO47yP/pXnTHEhsi/L8FgunOL1o2qFZhD
         lyH1XctdaEnsCR7jSZ9AKfIyfDQmLd8wUAxRCyBLq2gKa9gEZLyTDPG/2ijGKjM49Vkj
         F057cIeYR8KwpILE4z5N1tteIYCA5R9dxWknFAz91o7d/+ipyQhFuQbNK7ZgOGqx2lEt
         rqt2+ftdQNYMtaJBuR2spo0BmFVvnuaw84BroJ4W3o9Su8fxu2vYcvS3vtTsaNlKj6Eb
         L32a26LtHVKZYQKgEYyIdpW//i6oxOw751VTwSDdc5F3czZSTNPPs6mPzRuvrS2qwSts
         pCeQ==
X-Gm-Message-State: AOAM530mkoGYzlgwgM2+J3RhMYh8zxRkSv4ZLf/j4FEgyRgs/xzQbc99
        jnOlUKpiUNL0r+0SPYUV1Rleu7rQQTI=
X-Google-Smtp-Source: ABdhPJz8xhoUWWOp8+Tj/L8E2oPh/6odt8sFQun940W6zq7UIUEDdxJqvYBi1NfsGQTyIh8JfIW4oA==
X-Received: by 2002:a05:6808:2216:: with SMTP id bd22mr14415557oib.27.1639168868838;
        Fri, 10 Dec 2021 12:41:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w17sm695710oth.17.2021.12.10.12.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:41:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.16-rc5
Date:   Fri, 10 Dec 2021 12:41:06 -0800
Message-Id: <20211210204106.1663978-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.16-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.16-rc5

Thanks,
Guenter
------

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.16-rc5

for you to fetch changes up to a2ca752055edd39be38b887e264d3de7ca2bc1bb:

  hwmon: (pwm-fan) Ensure the fan going on in .probe() (2021-11-30 06:44:18 -0800)

----------------------------------------------------------------
hwmon fixes for v5.16-rc5

- In the pwm-fan driver, ensure that the internal pwm state matches
  the state assumed by the pwm code.
- Avoid EREMOTEIO errors in sht4 driver
- In the nct6775 driver, make it explicit that the register value
  passed to nct6775_asuswmi_read() is an 8-bit value
- Avoid WARNing in dell-smm driver removal after failing to create
  /proc/i8k
- Stop using a plain integer as NULL pointer in corsair-psu driver

----------------------------------------------------------------
Armin Wolf (1):
      hwmon: (dell-smm) Fix warning on /proc/i8k creation error

Billy Tsai (1):
      hwmon: (pwm-fan) Ensure the fan going on in .probe()

David Mosberger-Tang (1):
      hwmon: (sht4x) Fix EREMOTEIO errors

Wilken Gottwalt (1):
      hwmon: (corsair-psu) fix plain integer used as NULL pointer

Zev Weiss (1):
      hwmon: (nct6775) mask out bank number in nct6775_wmi_read_value()

 drivers/hwmon/corsair-psu.c    | 2 +-
 drivers/hwmon/dell-smm-hwmon.c | 7 +++----
 drivers/hwmon/nct6775.c        | 2 +-
 drivers/hwmon/pwm-fan.c        | 2 --
 drivers/hwmon/sht4x.c          | 4 ++--
 5 files changed, 7 insertions(+), 10 deletions(-)
