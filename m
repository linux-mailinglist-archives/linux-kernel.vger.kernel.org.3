Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C14552C688
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiERWrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiERWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:47:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C87131291;
        Wed, 18 May 2022 15:47:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so4641523wrg.12;
        Wed, 18 May 2022 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xZqC6+FVMDm22ezI0sXRmdSFzqa9nfbZudIzRViSOko=;
        b=faRM7UCW9PFk/Cuf1+8m4ZGlWWipaE+dQvE3g7nqG8YtMyTL3UkTn0MD4IHom6f1gV
         JFln4fJVF6WAx3pr3JMtJtzmyd5TiXFG8pT77hZnLet3yFyh7RsSf6k17kjoUMOZFfJB
         RD3aQ11RGDQwTbYKY8HbnHHGa/bLRfNqDdb382hEP1VgUwx8W1vnj3tuIy+ddEtHTSrO
         sEvyV5MNDdsdk3x4yA5VAxnchHOnV2yYanrzWiuyF7LeJs1rJy7ng6kNqxQnKlJQC+7l
         nvZXuBrktmvdPOTr+n3hzjZP0R1Y6n50v3YHZsVo820jo483e4oK1jCjwUw3B0yf9XPz
         9JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xZqC6+FVMDm22ezI0sXRmdSFzqa9nfbZudIzRViSOko=;
        b=pRTpjm47+cf1j3zuaKtugSN66NND1FcEJA+Tz5GXLkvIRgKrtWIZlfs3o7XQBxb/Vu
         pbC6P2kytjjJoSzfd35Nvrg3EKcVIALfAoVpReZ9ASGHn0lbsDFA3AzrMJNcAcO2PQQF
         igbckRrHg3sTc+mR8ZnCW/zSP+N+CvMrvtm53KcVOaSmInpUQirfBiGXjZpSNdzBPjEZ
         7fX/sRGQAHlOPGLbPiX4iKs/Yfv2+3jih0m6bs2MPHXvD6pESQtyvVsLaAYkCVdR4TfG
         o4mOIJjiBwvzDwmkOrLui/0xazWgTUfcA7iNZC9HrnrZWFjFzkmtxpY1RFAuCtG8cQpO
         GiZw==
X-Gm-Message-State: AOAM530mY9903qwQ9YtdRC/tMJMKxQxkDHJ6YsG1vG/hkTO4f0DoOO7I
        BNEO8JtUHB5uWbnO5KtgvYs=
X-Google-Smtp-Source: ABdhPJwRO0yG7c1nmRhzkZ+zu72Hm+ixasMXOybSZHXHceAuWBQCy2OUlNo827LJ8gTNnXvAas7GCw==
X-Received: by 2002:a05:6000:143:b0:20d:6e9:d4e6 with SMTP id r3-20020a056000014300b0020d06e9d4e6mr1461548wrx.25.1652914028801;
        Wed, 18 May 2022 15:47:08 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id bi22-20020a05600c3d9600b003942a244f33sm5223419wmb.12.2022.05.18.15.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:47:08 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic v2 0/4] Add support for XP-PEN Deco L
Date:   Thu, 19 May 2022 00:46:58 +0200
Message-Id: <20220518224702.1409327-1-jose.exposito89@gmail.com>
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

---

v2 - Fix some errors reported by the kernel test robot:

 - Add MODULE_DESCRIPTION/LICENSE/AUTHOR to hid-uclogic-rdesc-test.c
 - Remove unused variable in uclogic_params_ugee_v2_init
 - Add sparse __force anotation in the result of cpu_to_le16
 - Add DISABLE_STRUCTLEAK_PLUGIN for KUnit tests


José Expósito (4):
  HID: uclogic: Make template placeholder IDs generic
  HID: uclogic: Add KUnit tests for uclogic_rdesc_template_apply()
  HID: uclogic: Allow to generate frame templates
  HID: uclogic: Add support for XP-PEN Deco L

 drivers/hid/Kconfig                  |   7 +
 drivers/hid/Makefile                 |   3 +
 drivers/hid/hid-ids.h                |   1 +
 drivers/hid/hid-uclogic-core.c       |   2 +
 drivers/hid/hid-uclogic-params.c     | 201 +++++++++++++++++++++++-
 drivers/hid/hid-uclogic-rdesc-test.c | 219 +++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c      | 124 ++++++++++++++-
 drivers/hid/hid-uclogic-rdesc.h      |  24 ++-
 8 files changed, 567 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hid/hid-uclogic-rdesc-test.c


base-commit: f7d8e387d9aeff963e6691c0166269b8042b4ff9
-- 
2.25.1

