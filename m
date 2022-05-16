Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA582528CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbiEPSNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiEPSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:13:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B843A1A4;
        Mon, 16 May 2022 11:13:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l38-20020a05600c1d2600b00395b809dfbaso50436wms.2;
        Mon, 16 May 2022 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nysVKRQ7mo2MtvA99LcZLT9qlQggYwLJPzhkhaFBf5s=;
        b=MybMj0jX8oTKU6IznGZJJq5NMYteTiQ5ynNuJ/fr/tJIF7vL7mKCB/KcCtbQmVO2FI
         9597Y87bZAMzqBnXDtyWXNaddmf9cLF96zJzmClJPb9reHn+LP6tTujzzlMqoJk8LNn7
         JpzNLiL1B/eYF45/nHY6vUJTexSpx2HsiEoHYyxsDCmFtszPzddn6rZUUaMn1vRqLCqV
         l1GtWjyo24pFxp29XwSiM5XdcQeSXGj81GHC5i5ULtMZJsiqeOTUi3CYow9aFKIw/lPi
         68Ge4o4El9fS7Rpo0gJFg59w4G+0KHDxLZnlJn2Gw05V+am3KS4WbzvPLYV5uCGI8PvJ
         IEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nysVKRQ7mo2MtvA99LcZLT9qlQggYwLJPzhkhaFBf5s=;
        b=jXnxxy9U53ehXLhL4AMD5TSrYWb9GyGdOI67zIc0l1rld+Eb4CfEQqwZx8q2etC3Yu
         Vpnh6/UE3jQcZ6A+OyqJnNa+oW3kP2W1dMZRPzcguRcaz4VCo06GsTFC+DjuwbQ/JfMH
         E5nDjwY8cmdPspWxoXbPVeut076YgaV8iVAHAzyUgjR4w9UKHErJ40pvuhp5KAWQEVqD
         tc6HOJbPsU8r5/Y78L+tTLKnumtooLptPX0FkKneQXN+nr3hz2euAG+ESNGe8/AXaE+O
         TxSHfjjEVPiAPvoieUEWHogUQFi8I4lYYPV1ED0R7nHryLrpkXraH6PeiK+Xcea54B0j
         bBQA==
X-Gm-Message-State: AOAM530IFA80hL1/nXVCOvBM4x3hBwsjEktBjjHooB9O8ymBaeajtSQT
        aUgXE51qi6xTBSpDs73SdG5bvdf5F7FmJQ==
X-Google-Smtp-Source: ABdhPJx1skdulVYiVTOfqmLDV0HrFjS9K7mqO2dGU5uD4KmJ8n6W1ojAvvRkOAPG/gEzwqZcDFVaAw==
X-Received: by 2002:a05:600c:4ed3:b0:394:789b:913 with SMTP id g19-20020a05600c4ed300b00394789b0913mr17634924wmq.175.1652724820389;
        Mon, 16 May 2022 11:13:40 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600002cf00b0020d0c9c95d3sm3276382wry.77.2022.05.16.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:13:39 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 0/4] Add support for XP-PEN Deco L
Date:   Mon, 16 May 2022 20:13:19 +0200
Message-Id: <20220516181323.59554-1-jose.exposito89@gmail.com>
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

This patchset adds support for the UGEE XP-PEN Deco L tablet.
This device belongs to a family of tablets that must receive a chunk of
magic data in order to be enabled (named UGEE v2 internally).

Once the device is enabled, its parameters can be discovered by parsing
a report descriptor. HUION v1 tablets have a similar report descriptor
but, in the case of UGEE v2 tablets, the number of buttons are also
discoverable [1].

The ability to discover the number of buttons is the reason for the
first 3 patches. They enable frame templates.
Because I lack the hardware to fully test this driver, I added some
KUnit tests to make sure no bugs are introduced.
I didn't see any other test in the subsystem (and I doubt I'm the first
person writing one) so please let me know if I need to move the test to
a different place.

The last patch enables the tablet and it should give Stefan a stable
code to work on his XP-PEN Deco Mini 7 tablet.

Stefan: I didn't include the code for the Mini 4 because once connected
no events are received until I unload and load the driver.
If anyone has a clue about why this could happen, I'd really appreciate
some help. [2]

Best wishes,
José Expósito

[1] I don't own a HUION v1 device, so I'm not sure if the information
    about the number of buttons is also present and it is not used in
    the driver for some reason.
[2] https://lore.kernel.org/linux-input/20220516112159.GA74406@elementary/T/#t

José Expósito (4):
  HID: uclogic: Make template placeholder IDs generic
  HID: uclogic: Add KUnit tests for uclogic_rdesc_template_apply()
  HID: uclogic: Allow to generate frame templates
  HID: uclogic: Add support for XP-PEN Deco L

 drivers/hid/Kconfig                  |   7 +
 drivers/hid/Makefile                 |   2 +
 drivers/hid/hid-ids.h                |   1 +
 drivers/hid/hid-uclogic-core.c       |   2 +
 drivers/hid/hid-uclogic-params.c     | 203 ++++++++++++++++++++++++-
 drivers/hid/hid-uclogic-rdesc-test.c | 215 +++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c      | 124 ++++++++++++++-
 drivers/hid/hid-uclogic-rdesc.h      |  24 ++-
 8 files changed, 564 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hid/hid-uclogic-rdesc-test.c


base-commit: f7d8e387d9aeff963e6691c0166269b8042b4ff9
-- 
2.25.1

