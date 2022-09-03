Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AE05ABC34
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 04:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiICCBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 22:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICCBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 22:01:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBC3C8754;
        Fri,  2 Sep 2022 19:01:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so3369972pgb.13;
        Fri, 02 Sep 2022 19:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=SL2OYo4Y0nRVWNk4wkdLxh4PM2k6Tf5TlXKaNlHd0hA=;
        b=EwhJrKWE+kHpLXR1dPyFa+YBsZWDzfcBpZ4fc07lumM2ZyvdkbrcaMJubiK3mQr6jo
         zZJ3VO8bOK35Tehyb6/qURRWrXusqMM/91y5q0HoCxx8iyYMi7dLCjO6dyYtJJLDHDnI
         eG4bYBPMNfsvk4cCdxtkVg6u2aMp3n0YN676QCUEPm2w0KmOa+cU7CflbeRHP1ZBDWMY
         3lZEJ53k1nH8zldOqykdo+5ZRhzC+qzxEV3Em/JSCkF8gco+sSOxblBsVVouz2kIKve3
         QBjKgl9E1KzHpj0Z1gLrSyEWgGV2UuMLQFzCuP5m9TSXH9eG+8NtYgMwzD2Z8GOP8AOO
         YLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=SL2OYo4Y0nRVWNk4wkdLxh4PM2k6Tf5TlXKaNlHd0hA=;
        b=IZsv96AV2AU0vy2Jp9PWtg6VNvO/iyDVYdUMvIDORH/8+mdigB3gFUFdQqdhIVDTBk
         CAlFYruBWSCIMdytujFPaqVc/kjaQBj3kuCJDLZzrfq3Hn/u39Tfk3vrTxP8GHlahzs/
         SafLHHpqcoIVJ4b8HrJLycyOK1fhA/lscW4X9LPl0PFOVMGadBMS8HV/Rk5+3W8fuiD1
         b6zCXo389mgS3CyPUbRkM+UtwYltpjO3ZglIprMrWhKdfdKPEEIKAsZh9EYSyqh53sTi
         n7LR22k0rayiuCIp4p11QeyO9ofeco7RygIw86cvxr6X3INnCvB9hK0OEn+I3MA7PJgj
         hm0g==
X-Gm-Message-State: ACgBeo3uuAWx3e4AzBHzGHqqOAP91vB9zMs6/5rJtl0aMNNiJS+kQHrs
        5xpq2yapEBqvJNl9gqr/eRJLYyRtyJ0beg==
X-Google-Smtp-Source: AA6agR7DuGXQ7p0PuJkDvlZ/I4w7fr3C12eiSRwvIWADF99iU9LYtaTUC6XrgFbgs58xCAX0zy2GrQ==
X-Received: by 2002:a63:484a:0:b0:42b:2e71:6665 with SMTP id x10-20020a63484a000000b0042b2e716665mr32759033pgk.407.1662170505239;
        Fri, 02 Sep 2022 19:01:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n19-20020a170903405300b00172b5d1e054sm2305628pla.17.2022.09.02.19.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 19:01:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.0-rc4
Date:   Fri,  2 Sep 2022 19:01:42 -0700
Message-Id: <20220903020142.852288-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
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

Please pull hwmon fixes for Linux v6.0-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.0-rc4

Thanks,
Guenter
------

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.0-rc4

for you to fetch changes up to f233d2be38dbbb22299192292983037f01ab363c:

  hwmon: (gpio-fan) Fix array out of bounds access (2022-08-29 21:23:23 -0700)

----------------------------------------------------------------
hwmon fixes for v6.0-rc4

- Fix out of bounds access in gpio-fan driver

- Fix VOUT margin caching in PMBus core

- Avoid error message after -EPROBE_DEFER from devm_regulator_register()

----------------------------------------------------------------
Armin Wolf (1):
      hwmon: (gpio-fan) Fix array out of bounds access

Christophe JAILLET (1):
      hwmon: (pmbus) Use dev_err_probe() to filter -EPROBE_DEFER error messages

Vincent Whitchurch (1):
      hwmon: (pmbus) Fix vout margin caching

 drivers/hwmon/gpio-fan.c         |  3 +++
 drivers/hwmon/pmbus/pmbus_core.c | 19 ++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)
