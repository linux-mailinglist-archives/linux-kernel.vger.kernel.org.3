Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4956D092
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 19:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiGJRvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 13:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 13:51:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0151B1055C;
        Sun, 10 Jul 2022 10:51:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so4355293wrd.13;
        Sun, 10 Jul 2022 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JB95EOb7kF1r0wKeHhsm1Zy9Cfy2EBIRKhZZlQs9l6Y=;
        b=U7XQxtZ4aLimPAaYRqeIgP/vwUOHjUT0W2KIb9+zXCHV33+luVKUT3M5bYLaqG39/w
         eVc6Gz5zA59+KM19NGpSAaqvL10bfAGh41HWVaHbZdu6UE6+Ke8020Am+l6Mrp8dPcm6
         SB9AMimS5Ny1wSELgiJYrHja6VQDrPIQoQQ2dNIbguU9ZBqpvCjFDGXcmK5bIctRcjix
         RIXQlR8Cp24PFg4fBjTaZAdeYwfnBO6M/e84xMaoTNjKPtBZ6Ow+a5LYxT0+Qxtn/rJS
         ucVR0t3HnThBGRPit1kBCmzEJ+fT8snxiGhzt7LlDBWIDcL8krahkZSIK9fJrFTba0qG
         +2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JB95EOb7kF1r0wKeHhsm1Zy9Cfy2EBIRKhZZlQs9l6Y=;
        b=I2fQM/u1finvK02bQoN2EypitNDmDV5EzymlnVYOgnpfBjF7LGg3tvMY5pQndEGyRa
         UkatyvRqe6hkr6SmmAJCAAlvYeZ7O7cDFKuUYyvQtQ5sMFTlnJM/nu1X0ej+rh2C6oR1
         2YmEABw9vPNIt9OMWHgRLtRT72uxnXnEcLuNjP044YPKTdmDpYSymg6jQCPp7ECz4/0x
         H8mizZLC6mWx5VhIJ35HnzwWhY7cvSko+OXfevdjcwq4bdEIb1VEzbPg1VbCxL/2Afqv
         WpdmWwbGeiIkqW9TIqsn2xodDuJM79fe9Y/t7uBbJXxKizfzWSIJ+259QANhsSWoLj3z
         frbg==
X-Gm-Message-State: AJIora/QFUVJJlySsPr0wqCtEzA7YUi7/GJgVq6T8ad52iscVob58gxf
        EKr1M8kqYWr8m2DgMkkPKzQ=
X-Google-Smtp-Source: AGRyM1uD3uV1UQFdngXNrv8GYStTMuk/+aKstRfS8HI63shEVe2a9KhaMWZHszIasUMmCgh6+mLp2g==
X-Received: by 2002:a5d:64c3:0:b0:21d:720c:4ade with SMTP id f3-20020a5d64c3000000b0021d720c4ademr14120911wri.570.1657475464452;
        Sun, 10 Jul 2022 10:51:04 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id l23-20020a1ced17000000b003a03ae64f57sm4523495wmh.8.2022.07.10.10.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 10:51:04 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/7] XP-PEN Deco Pro S support (for-5.20/uclogic)
Date:   Sun, 10 Jul 2022 19:50:36 +0200
Message-Id: <20220710175043.192901-1-jose.exposito89@gmail.com>
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

This patchset adds support for the XP-PEN Deco Pro S.

Like the Deco L (for-5.20/uclogic) this tablet is a UGEE v2 tablet.

The first patch is not related to this tablet. It fixes some naming
conventions on the KUnit tests.

Patches 2 and 3 just move code to functions and add more unit tests.

Patch 4 parses the tablet string descriptor to get its frame type. The
values discovered so far are: only buttons, buttons + dial or
buttons + dial + mouse.

Patches 5 and 6 add the descriptors for the new frame types.

The last patch uses all of this to add support for the tablet.

I don't have access to the tablet. Credit for testing the patches and
providing the required recordings goes to Jouke Witteveen.
This fixes an issue reported in libinput:
https://gitlab.freedesktop.org/libinput/libinput/-/issues/738

Best wishes,
José Expósito

José Expósito (7):
  HID: uclogic: KUnit best practices and naming conventions
  HID: uclogic: Refactor UGEE v2 string descriptor parsing
  HID: uclogic: Refactor UGEE v2 frame initialization
  HID: uclogic: Parse the UGEE v2 frame type
  HID: uclogic: Add support for UGEE v2 dial frames
  HID: uclogic: Add support for UGEE v2 mouse frames
  HID: uclogic: Add support for XP-PEN Deco Pro S

 drivers/hid/Kconfig                   |   2 +-
 drivers/hid/Makefile                  |   4 +-
 drivers/hid/hid-ids.h                 |   1 +
 drivers/hid/hid-uclogic-core.c        |   2 +
 drivers/hid/hid-uclogic-params-test.c | 192 ++++++++++++++++++++++
 drivers/hid/hid-uclogic-params.c      | 225 ++++++++++++++++++++++----
 drivers/hid/hid-uclogic-params.h      |  10 ++
 drivers/hid/hid-uclogic-rdesc-test.c  |  22 +--
 drivers/hid/hid-uclogic-rdesc.c       |  74 +++++++++
 drivers/hid/hid-uclogic-rdesc.h       |   8 +
 10 files changed, 494 insertions(+), 46 deletions(-)
 create mode 100644 drivers/hid/hid-uclogic-params-test.c


base-commit: 0cb1fc0988e32bda84c2b7218e0c761af1430baf
-- 
2.25.1

