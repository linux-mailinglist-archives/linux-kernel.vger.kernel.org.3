Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706ED49F32B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346246AbiA1Fyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbiA1Fyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:54:43 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74196C061714;
        Thu, 27 Jan 2022 21:54:43 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so4805114otf.1;
        Thu, 27 Jan 2022 21:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5iUJxIm11wuHAjAk/U9qyVK8Q1/8AM34mvlFMQ0jz4o=;
        b=KRSAJ86fpotWcMMhPUusYEY+q06d7as4lj5/hcbJt1raSYhIvkAZaU19dkaL485lMr
         sBNeNnVBau4qvFPu7wa8kaAy4SjiyyO2p4P3vXtBp0pIm7Ko2O5ZwutvWFqd7BwF72ol
         yFnHAB8ZyI45av3Yhlo/EYPkViFldnAiaT+HkovsEYbBy64+TJzdY1zMksT66Wt4OYZ7
         jmLzYEHHpjTNm10vk5hM8BgB1rYIp/Hd6Oh49UsbnRRLMjbROlhNiCqYGmsC7b1bGLUN
         d1OgxkkWkKreXYkkHHEl+Iq+76tqocApLUcPlzPm/rwo7ic9CzlruR6nca1GEepxYuLf
         mOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5iUJxIm11wuHAjAk/U9qyVK8Q1/8AM34mvlFMQ0jz4o=;
        b=nGYOAekLOWtAZPh/dgKvX9zpJ+Zq+LueS4AHxwLu3F7aUpghNnpb4WXLlV8GkII9gQ
         CQExFOfN/0twY/+mtGi1ly6tegfyYJMAkB6gJHuxkGJgpxj6I5xg9oOyM4O9eT1syTzo
         pL1n97MDQDcprgyDjWHTKXAezq59H3y0tL5GqtolcuJ08R9gRUateElkPTyBTEitjZL4
         kBgRBiopG3LQRaZsreEf7dn8tbqyLHZCYFhPUNpKg3ENksilAJpdLzrvjTqdx7nN3Uos
         x4wMtZTw2/6WO5hcEYTbGoquzHqg0vYw7q7x6BwLFbZ8uvX77jm6fPYylJddAp0wk9cb
         7ihQ==
X-Gm-Message-State: AOAM532W6zTX3OnhUZ7AnOlF8LQJWaDMz3ACvGBHTlmcZnXqhcIknT9X
        bgEW+SQeR/9kFJcAhLwyb2OJZGZiqmi4lw==
X-Google-Smtp-Source: ABdhPJwf9vtCL5ExNiA9UPs7QW/7lgXdB/HZmMOEwRB1zbVDepF5m+ckMxZ51vjWndG8rSWGM/ZxOA==
X-Received: by 2002:a05:6830:1153:: with SMTP id x19mr3831256otq.321.1643349282858;
        Thu, 27 Jan 2022 21:54:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n22sm9902538ooq.27.2022.01.27.21.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 21:54:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.17-rc2
Date:   Thu, 27 Jan 2022 21:54:40 -0800
Message-Id: <20220128055440.3947883-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.17-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.17-rc2

Thanks,
Guenter
------

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.17-rc2

for you to fetch changes up to 79da533d3cc717ccc05ddbd3190da8a72bc2408b:

  hwmon: (nct6775) Fix crash in clear_caseopen (2022-01-24 14:32:47 -0800)

----------------------------------------------------------------
hwmon fixes for v5.17-rc2

- Fix crash in nct6775 driver
- Prevent divide by zero in adt7470 driver
- Fix conditional compile warning in pmbus/ir38064 driver
- Various minor fixes in lm90 driver

----------------------------------------------------------------
Dan Carpenter (1):
      hwmon: (adt7470) Prevent divide by zero in adt7470_fan_write()

Guenter Roeck (8):
      hwmon: (lm90) Reduce maximum conversion rate for G781
      hwmon: (lm90) Re-enable interrupts after alert clears
      hwmon: (lm90) Mark alert as broken for MAX6654
      hwmon: (lm90) Mark alert as broken for MAX6680
      hwmon: (lm90) Mark alert as broken for MAX6646/6647/6649
      hwmon: (lm90) Fix sysfs and udev notifications
      hwmon: (pmbus/ir38064) Mark ir38064_of_match as __maybe_unused
      hwmon: (nct6775) Fix crash in clear_caseopen

 drivers/hwmon/adt7470.c       |  3 +++
 drivers/hwmon/lm90.c          | 21 +++++++++++----------
 drivers/hwmon/nct6775.c       |  6 +++---
 drivers/hwmon/pmbus/ir38064.c |  2 +-
 4 files changed, 18 insertions(+), 14 deletions(-)
