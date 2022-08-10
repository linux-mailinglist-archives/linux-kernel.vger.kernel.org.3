Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA6F58ED8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiHJNpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiHJNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:45:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BC6647E8;
        Wed, 10 Aug 2022 06:45:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so2193384pjl.0;
        Wed, 10 Aug 2022 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=96pjvUrJcap1bQNqpQXS2ixIwi8nMkQJ0xsftTlwK2k=;
        b=G5cWeDhYLR9kV47rydbHgRaCcwFtB0Md/uLpi2fjqaQrfIkk8DI6WEBC4tcRtcJri+
         y52WW4vBMB634p+cuBIOE4uoYfiEOqasrdNiB9KMfBUpmzgfSqxQVMfux5kX9dOJTgR6
         jwKfwxNwmE/ABUJNFUXdIu+b9lroIC0EcHL26YzGyUfGIIYaQjpLVu4IKg5CAO0+zGGj
         egF5tz9ZamahPxpAgVbJ6R4HWDEPYdPDivbofdKRZ+XtbFoYuPLRgbsrDctIExgLFQyd
         jp2RE/YRc5dnT2vbcNjvzGokXxSp0/yTQ8Q4vw11NJH5FnAg9erM7WcfDdqp86Uxjt7v
         +tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=96pjvUrJcap1bQNqpQXS2ixIwi8nMkQJ0xsftTlwK2k=;
        b=uKm6mEO4gMyMoLan12poXQCD9Vzlu1+rUO42TH5q2QPPb7od9xabrYVluVuSINDaps
         H5QZJc5GOT6/qwL5Tjy+dl2VhwBV0w976sxLvFjSoO/9o2T1VMjgtoNYGHYVwKvUI8iF
         SWCA9cu4IuhWBpIwFEVo7rz67qD7d/RMKsyuQJ5/xWRbdXL8N2Eq0JQEZ94Tmu3XKpYd
         3D5r+RM1BAb2tCxdjiTGKED1PZ8ILv0J5teKDah26vY/+lV0io9kE40JVbwPAS8ufOnm
         pU/MZ6ljmoy3/a5v3r9D0RKy4ubezP8HqtQi30G7kFbnR1NlB1zcyXyBmm55FWLCwp3y
         FhLQ==
X-Gm-Message-State: ACgBeo3rtHoGzpuJrrhS1HPcQ1NIlxICVzPzUzpFwnPpdW427cxJaIBq
        l0C9rusQhq7AkFKXLS1BQtf1uin99U0=
X-Google-Smtp-Source: AA6agR7VfMQKbzzW4fdvBsQUslvHsyiAS6gEZV7JcJMfRaDsRKcyhYgDqgLMQoP3fh1ItHxrWsp6Jg==
X-Received: by 2002:a17:902:e886:b0:16e:d785:5a0 with SMTP id w6-20020a170902e88600b0016ed78505a0mr27254918plg.36.1660139135274;
        Wed, 10 Aug 2022 06:45:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ij21-20020a170902ab5500b0016bdeb58611sm12718930plb.112.2022.08.10.06.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:45:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for hwmon-fixes-for-v6.0-rc1
Date:   Wed, 10 Aug 2022 06:45:33 -0700
Message-Id: <20220810134533.380417-1-linux@roeck-us.net>
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

Please pull hwmon fixes for Linux hwmon-fixes-for-v6.0-rc1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-fixes-for-v6.0-rc1

Thanks,
Guenter
------

The following changes since commit d4252071b97d2027d246f6a82cbee4d52f618b47:

  add barriers to buffer_uptodate and set_buffer_uptodate (2022-08-09 15:03:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-fixes-for-v6.0-rc1

for you to fetch changes up to f4e6960f4f16b1ca5da16cec7612ecc86402ac05:

  hwmon: (nct6775) Fix platform driver suspend regression (2022-08-10 06:37:01 -0700)

----------------------------------------------------------------
hwmon fixes for v6.0-rc1

Fix two regressions in nct6775 and lm90 drivers

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (lm90) Fix error return value from detect function

Zev Weiss (1):
      hwmon: (nct6775) Fix platform driver suspend regression

 drivers/hwmon/lm90.c             | 2 +-
 drivers/hwmon/nct6775-core.c     | 3 ++-
 drivers/hwmon/nct6775-platform.c | 2 +-
 drivers/hwmon/nct6775.h          | 2 ++
 4 files changed, 6 insertions(+), 3 deletions(-)
