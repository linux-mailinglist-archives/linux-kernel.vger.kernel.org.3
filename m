Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9A4CE771
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 23:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiCEWep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 17:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiCEWen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 17:34:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C3C5AA49;
        Sat,  5 Mar 2022 14:33:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kx1-20020a17090b228100b001bf2dd26729so3692088pjb.1;
        Sat, 05 Mar 2022 14:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cZapo6sd4e3L55/3+wn+gVa77A42F2g2ptUKnd7guMQ=;
        b=gFICULfuX0JVUB8l5lRUmlwIXPGbq3uIuiwCZMFQhhMbWsnYpJ+mmL5X0KWqCz22eQ
         YCrM7mbHFO1DJRX1mpcvwrDu2p4OPRNHnGElEQYneiG0xuqhVZGMhDXA2CCN7NrHwqqB
         CgnRzrp7jqhKUIZ0HbDHABx1ZjINjZ8jfYLVP50EVf729XL2qAy8/+vi0eKeo3WfxB7N
         ZAFA/t4gs3Vr5yjUXwUHaYB6qqyJ0lsowBMLtLtTMCN5DyIkUsuXzoMTUd0bdZW1wEp/
         uSlORYQGEKo2yws/Wd/0RACJ6haSy8io99a7RgWV4ytCSGtKoUCtmu0ObrPRpYjitpZH
         nLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cZapo6sd4e3L55/3+wn+gVa77A42F2g2ptUKnd7guMQ=;
        b=I+oA04dVYPmXZnarjeMptFMZ/h7K3d4k+MD3iek56rhi+F6e9gE8GOWBdSrTdW1RGu
         hAA6UlXK2dOR/Lyqe+akM5FGvr03xjgCVBWhW9HpWY6wxS1PnxJvLFod2DdnjIVqqBs5
         oBZ3wyeaPQ8L49zcPjbYdFl+op06FXglTKjxRfINy3hn6jYMPfbQmJDCcyYcJFz7rkvd
         p/gIgBRF9A3V5KZX8pKRm+0Ybuqug+G7UwMcvU0ccdo0Ikzd1AvEEN/gmmlRaFNrUuKB
         HhY11fi63Uyv8FoQt5jZrqPu0gd1gXMQHpNvwSGN/z2aX8pnlkzJzVaE0C6XLDWEu59S
         MFKw==
X-Gm-Message-State: AOAM530aslKpgUjYHO+S7JeFOPTlit3D4ty9q0r8BVlpYVfQqZOy+s0j
        1di3qOeu17V+GvuOFhjpzjM=
X-Google-Smtp-Source: ABdhPJyQs4bpbxDn7b/q1KbHh4DGCVWmb9zwXHBLfc/rUGBBKkuH5wiCzHUVmbs6s30Q+BS+U0q5MA==
X-Received: by 2002:a17:903:244d:b0:150:1d22:617e with SMTP id l13-20020a170903244d00b001501d22617emr5346439pls.38.1646519632697;
        Sat, 05 Mar 2022 14:33:52 -0800 (PST)
Received: from google.com ([2620:15c:202:201:15af:5d15:3044:acb9])
        by smtp.gmail.com with ESMTPSA id o5-20020a655bc5000000b00372f7ecfcecsm7738582pgr.37.2022.03.05.14.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 14:33:52 -0800 (PST)
Date:   Sat, 5 Mar 2022 14:33:49 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.17-rc6
Message-ID: <YiPlTcVeLWi2pDiq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a fixup for Goodix touchscreen driver allowing it to work on certain
  Cherry Trail devices;

- a fix for imbalanced enable/disable regulator in Elam touchpad driver
  that became apparent when used with Asus TF103C 2-in-1 dock;

- a couple new input keycodes used on newer keyboards.

Changelog:
---------

David Gow (1):
      Input: samsung-keypad - properly state IOMEM dependency

Hans de Goede (4):
      Input: goodix - use the new soc_intel_is_byt() helper
      Input: goodix - workaround Cherry Trail devices with a bogus ACPI Interrupt() resource
      Input: elan_i2c - move regulator_[en|dis]able() out of elan_[en|dis]able_power()
      Input: elan_i2c - fix regulator enable count imbalance after suspend/resume

William Mahon (2):
      HID: add mapping for KEY_DICTATE
      HID: add mapping for KEY_ALL_APPLICATIONS

Diffstat:
--------

 drivers/hid/hid-debug.c                |  5 ++-
 drivers/hid/hid-input.c                |  3 ++
 drivers/input/keyboard/Kconfig         |  2 +-
 drivers/input/mouse/elan_i2c_core.c    | 64 ++++++++++++----------------------
 drivers/input/touchscreen/goodix.c     | 34 +++++++++---------
 include/uapi/linux/input-event-codes.h |  4 ++-
 6 files changed, 51 insertions(+), 61 deletions(-)

Thanks.


-- 
Dmitry
