Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6F454F8AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382504AbiFQNzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382488AbiFQNzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:55:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62523C739;
        Fri, 17 Jun 2022 06:55:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s135so4110074pgs.10;
        Fri, 17 Jun 2022 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvtCGkAM1wmCJxlA0vZdyo0zX0WV5pm+kkuavrn/zKs=;
        b=Wz7ZxCav4VZ2alFJPCtf5CtzJk3EB7kW/gkiOD9wNK+AtOiuwWeugzW05S2lAOJ6cz
         UpY2SYY73RSErSRcj8F0Qpd5T2sN/OIXmgKXt6pXz4iMxlfmH7FKcfVKk5GUhqC62jmY
         mzwVKrpQxauM3fFXw39oOcqb5IMkF/c4Vbsam3j31ko18Qq6I5RrkuUCA8kKdkuzX89c
         awKgaA5+A3bVZ8QOMztPB4mvhNxGxW7FGdkwTL77xr+tyRmUFsRE6N04p5EQoLi8nzBe
         aj5cMssmgQVUOoXFq6MiJnhFlv3IDsniv6dqMlVwFN8C/9gUxsAZP+5Egbpdy7kf2JV1
         R+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jvtCGkAM1wmCJxlA0vZdyo0zX0WV5pm+kkuavrn/zKs=;
        b=Bmt3Fj6q9EgBYkOxANfZaVVGRaSTnhj8p+mImVK4Dk7p+AEGxmA5eli+Dvga9N/p/H
         UCeyMQh/++popTG0JmJ1cyv/3An6h8bBPj6Hx6DSxG750CI6O9hdVnOMeuQrXeXL1dkK
         PjjCoDv5siPM09wGYdYnrSUEejAo60xf9to6j/WLH7xh7VjKIkkqRn8A7BDapqWFqwTS
         Uj3wHBjXuRrFI42MiKcdN/lBQtbMa9QyLCReARMYrgqKO/MZEKyCYiSaxZjCPTZuw2Mg
         f0THyytfYihIoCAZwg0IJ+JpWIsk4kWz45o8X+HdgY7ROVQ30XR6K5cpUNU1KwOpPqeN
         nPqg==
X-Gm-Message-State: AJIora8C14hlGCLy4STRer8pjpvswdlcVnC9+9zHatzqynsiknvwZYT7
        lIgMipT5JFr3EQa0XTfcMMN6gUrcqBI=
X-Google-Smtp-Source: AGRyM1tsHfEwE/aR67IEmimGzulz3PEvzV2k05QxYd00cByGpPlckDHuGm7oUEQ1W4tbkrVNVhLy1A==
X-Received: by 2002:a63:e5d:0:b0:3aa:3c53:537e with SMTP id 29-20020a630e5d000000b003aa3c53537emr9323426pgo.622.1655474128108;
        Fri, 17 Jun 2022 06:55:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l198-20020a633ecf000000b003fdef4f7447sm3865112pga.6.2022.06.17.06.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 06:55:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.19-rc3
Date:   Fri, 17 Jun 2022 06:55:25 -0700
Message-Id: <20220617135525.616752-1-linux@roeck-us.net>
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

Please pull hwmon fixes for Linux v5.19-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.19-rc3

Thanks,
Guenter
------

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.19-rc3

for you to fetch changes up to ec41c6d82056cbbd7ec8f44eed6d86fea50acf4e:

  hwmon: (asus-ec-sensors) add missing comma in board name list. (2022-06-15 08:14:38 -0700)

----------------------------------------------------------------
hwmon fixes for v5.19-rc3

* Add missing lock protection in occ driver

* Add missing comma in board name list in asus-ec-sensors driver

* Fix devicetree bindings for ti,tmp401

----------------------------------------------------------------
Eddie James (1):
      hwmon: (occ) Lock mutex in shutdown to prevent race with occ_active

Michael Carns (1):
      hwmon: (asus-ec-sensors) add missing comma in board name list.

Rob Herring (1):
      dt-bindings: hwmon: ti,tmp401: Drop 'items' from 'ti,n-factor' property

 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml | 5 ++---
 drivers/hwmon/asus-ec-sensors.c                        | 2 +-
 drivers/hwmon/occ/common.c                             | 5 +++++
 3 files changed, 8 insertions(+), 4 deletions(-)
