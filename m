Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C574B15C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbiBJTEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:04:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbiBJTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:04:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5848D1084;
        Thu, 10 Feb 2022 11:04:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so5836835wme.1;
        Thu, 10 Feb 2022 11:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rUred02texemxAFVHHRF/9cYwJFFDkzQMpDLFJdomOU=;
        b=QJrmkWzmPO9kLsw74dAatqFSHaPrgRp1qcxYk3KUu0L3+fyir/M9cGe3Y33FloB2Cd
         F3JbYpex+/PYWF2ZDH5buwYHsxRLCU1z3Pn8zfSjgONUr7RunSjWyhTVamZRFyAxof7m
         A1+JyzifWpvsExrYCwEIWL2vQToFka33UEkuQlg6bC5qdA5sDekriKMznfpGpZ7KXt7n
         t8g1TBcgY4IMDTpLdO0U2rMxjGKnJdyJpM4tJH4Rm4+my80fKhtngQCRO4xEkvGhUam8
         zOCAArHRfYKV77Yjuop6sd9l4CPK8HKq4gVk2b+NKxnbrbv1+NvHj07xw6NO/NAA1lq4
         RUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rUred02texemxAFVHHRF/9cYwJFFDkzQMpDLFJdomOU=;
        b=aAtlgABeWQk63ASvXK7l7uy6FWE8kBXxohW3YNbzI/8VjR0xVk5vr9iWaTEK7LWhpT
         2QGAVw3N5T1rCWZbCD3aTCGXhbgbPRlDd2MG9Im3QkhvC6c0OI/qRj9or314vgW6hUEN
         QgqrOEmlWNE8K2lFImfrfHmitmBXwk/ZfkXGYwwtZ0T7Xp38R5xK881jPUCsU1wMFdY3
         POJzzjdJKCOsT5xYu/ZMKANJBlS80elNxmg5PjGjpktjIE9F9qsASKPLPB2gog6+UTP9
         l28bn1HMcRRBb3/FSkehK7/fwr8i4Q3RQ2RqWzo0jSb42DhzzB0cO1c9kHSfSGFt88S+
         D06w==
X-Gm-Message-State: AOAM532AQXknHAgu/ZWEQkNQ6mPEy9KIsS5S7SOBrK0iNxVwd4Jv2nGO
        FzWBbYTpd8nN2dt/qFkIgTU=
X-Google-Smtp-Source: ABdhPJzdxBb7AmPMB9usBKnJr9LBzAJarzbuIxRcTNW/rdrgL/h49TAuxKg4tisBlm2+5HOGZS8PIQ==
X-Received: by 2002:a05:600c:1988:: with SMTP id t8mr3359063wmq.66.1644519885768;
        Thu, 10 Feb 2022 11:04:45 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id o10sm21794816wri.19.2022.02.10.11.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:04:45 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/7] DIGImend patches, part one
Date:   Thu, 10 Feb 2022 20:04:30 +0100
Message-Id: <20220210190437.50152-1-jose.exposito89@gmail.com>
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

Hi everyone,

I'm working on the UC Logic driver to add support for my tablet.
After some work, I noticed that I needed some patches from the
DIGImend project [1].

Instead of cherry picking what I needed, I decided to go the hard
way and upstream every change present in DIGImend but missing in
the kernel with the intention of making development easier in the
future for everyone and providing better hardware support.

In a private conversation with DIGImend's maintainer, Nikolai
Kondrashov, I asked him for permission to upstream his changes and
he said it was fine :) All credit goes to him, I only fixed his
patches so they apply, fixed minor checkpatch errors, squashed
related changes and reviewed and tested them when my hardware
allowed me to.

This is the first series of patches from DIGImend. There are 37
patches in total [2], but I can imagine nobody wants to review such
a long series, so I'll be sending small groups of related patches...
Unless someone feels brave and tells me to send all of them ;)

Thank you very much in advance,
José Expósito

[1] https://github.com/DIGImend/digimend-kernel-drivers
[2] https://github.com/JoseExposito/linux/commits/patch-digimend-parblo-patches-mailing-list

Nikolai Kondrashov (7):
  HID: uclogic: Support Huion tilt reporting
  HID: uclogic: Rename Huion HS64 PID to Huion Tablet 2
  HID: uclogic: Support Huion 13th frame button
  HID: uclogic: Split pen and frame raw event handling
  HID: uclogic: Access pen/frame params directly in raw_event handling
  HID: uclogic: Skip non-input raw events earlier
  HID: uclogic: Handle virtual frame reports

 drivers/hid/hid-ids.h            |   2 +-
 drivers/hid/hid-uclogic-core.c   | 205 +++++++++++++++++++------------
 drivers/hid/hid-uclogic-params.c |   3 +-
 drivers/hid/hid-uclogic-params.h |   8 ++
 drivers/hid/hid-uclogic-rdesc.c  |  20 ++-
 5 files changed, 153 insertions(+), 85 deletions(-)

-- 
2.25.1

