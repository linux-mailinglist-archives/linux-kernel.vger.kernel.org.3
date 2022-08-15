Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08035930BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiHOOaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243062AbiHOOaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:30:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F7923BE9;
        Mon, 15 Aug 2022 07:30:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r16so54846wrm.6;
        Mon, 15 Aug 2022 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=WmIpevBLsnUFqMnMi+FX/+yaSn5lfOL9tGWezEhT5bs=;
        b=XQEqW0qFBJcZRZFd/drbliyW7NwJFx23gqpIfX2vlZ2BSiU/e3fP3c4JV+xpFJsGB4
         fn4jv5cGJf1LfBZPGlADwzGm4sBh6OoTjCSZaL+FIUzE5jUDldQGUEi+wOgZrbEmt5tG
         mntj/pnXuG0LuQs+r/0lb1l1BbOxGkXcfOfa0/m1UH3f8LEIJgUAK1xrFomQxdhIAH5L
         Rb2IyaZ8gRYv9tzSBxH1o2I2fiNj0fk7xlgwSuiluz07Iu09qgQMu0GVEakN86mR+K9l
         0uOZpQTXemyzJn+GtPquqX5n+OYZxbePs+ja5hSbKGTyC79AyG85B0T/hc5QIT37D/fz
         QGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=WmIpevBLsnUFqMnMi+FX/+yaSn5lfOL9tGWezEhT5bs=;
        b=droRTVth23IUWFVjR2UHic+BdMJMkdBgsgoT+ku1J/jzNM70IuyRrXL6NiZvBNqjGn
         mzZIs1p0EPp7M5ZI+EtkZog9LEeXLl3YNtQCReRX5MnelBgUMOIg8vV+mAHi+JvXU9cy
         Bc0EB0/3rENLh0e4JVth9YFQcamzf1oVaxeld4/i+jdVVzR7v6y3vS/896vyegSMSB10
         wEslnyDVCQiXqhCkwnB2RCOB3AGR6ck/b4u72ce4W/m5xDtVs57iISap1hbWyQP5Y9uy
         xI7EnPZEgqO4GDAZdzvYttkaSN6HtzqoxdEDlA4zxGeVYTthMufH9AAkobqFb9Cak730
         mi6w==
X-Gm-Message-State: ACgBeo1MGY5kOXUFnSzhIhT5jlXyKoL9j3MIwF9yOfYIznvqMYK+AJJ/
        7xb947bHIPyNmpqNn4/CnBU=
X-Google-Smtp-Source: AA6agR5+xdWCimgZccN8Jr291EGDLb72WSIsa7SKVeQm8Z9PiMzBc1ZTp5puIAQJa/T4Q8mNW31qtA==
X-Received: by 2002:a5d:5c04:0:b0:220:6d80:60ce with SMTP id cc4-20020a5d5c04000000b002206d8060cemr9090926wrb.499.1660573800668;
        Mon, 15 Aug 2022 07:30:00 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b00224f895d620sm5456894wrx.48.2022.08.15.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:30:00 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 0/8] XP-PEN Deco Pro S support
Date:   Mon, 15 Aug 2022 16:29:48 +0200
Message-Id: <20220815142956.19180-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is v4 of [1]. Check the description in the link for more
information, please.

v1 -> v2:

 - First patch acked-by Daniel Latypov

v2 -> v3:

 - Fix bug in "HID: uclogic: Add support for UGEE v2 mouse frames".
   Reported-by: kernel test robot <lkp@intel.com>

   I copy-pasted the wrong template size.
   Thanks to Nathan Chancellor for looking into it. As he mentioned [2],
   CONFIG_FORTIFY_SOURCE doesn't catch this error without LTO enabled.

v3 -> v4:

 - Rebase on hid/master after the merge window.

 - Add and extra patch to add support for Parblo A610 PRO. The tablet
   is similar to the XP-PEN Deco Pro S and adding its ID is enough to
   support it.

 - Minimal cleanup in the return branch of uclogic_params_ugee_v2_init_frame_mouse
   and uclogic_params_ugee_v2_init_frame_buttons.

[1] https://lore.kernel.org/linux-input/20220717144333.251190-1-jose.exposito89@gmail.com/T/
[2] https://lore.kernel.org/linux-input/20220717144333.251190-1-jose.exposito89@gmail.com/T/#m796ac6c8f7484b0bafc1f1>

José Expósito (8):
  HID: uclogic: KUnit best practices and naming conventions
  HID: uclogic: Refactor UGEE v2 string descriptor parsing
  HID: uclogic: Refactor UGEE v2 frame initialization
  HID: uclogic: Parse the UGEE v2 frame type
  HID: uclogic: Add support for UGEE v2 dial frames
  HID: uclogic: Add support for UGEE v2 mouse frames
  HID: uclogic: Add support for XP-PEN Deco Pro S
  HID: uclogic: Add support for Parblo A610 PRO

 drivers/hid/Kconfig                   |   2 +-
 drivers/hid/Makefile                  |   4 +-
 drivers/hid/hid-ids.h                 |   2 +
 drivers/hid/hid-uclogic-core.c        |   4 +
 drivers/hid/hid-uclogic-params-test.c | 192 +++++++++++++++++++++
 drivers/hid/hid-uclogic-params.c      | 230 +++++++++++++++++++++-----
 drivers/hid/hid-uclogic-params.h      |  10 ++
 drivers/hid/hid-uclogic-rdesc-test.c  |  22 +--
 drivers/hid/hid-uclogic-rdesc.c       |  74 +++++++++
 drivers/hid/hid-uclogic-rdesc.h       |   8 +
 10 files changed, 498 insertions(+), 50 deletions(-)
 create mode 100644 drivers/hid/hid-uclogic-params-test.c

-- 
2.25.1

