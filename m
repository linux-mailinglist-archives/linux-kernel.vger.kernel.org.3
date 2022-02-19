Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08A4BC775
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbiBSKC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:02:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiBSKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:02:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E50EE4C;
        Sat, 19 Feb 2022 02:02:07 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso10272115wme.5;
        Sat, 19 Feb 2022 02:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XXsaw4tgn83gS8crkwTPKdvTDY08Kp+Lc4B7yP1Hzg=;
        b=WemdgXnsuaBI8ROsyullKo+qPZ2fYYkSB5fdOnPJ0HbpQuDqm8EBY0lUPiGG3OFfah
         2NNWyCqoEGXInQ6M4MsVohKmyuzOsBIEvSZI5r5q7hZgXEmSGvmJwxRGK41JxKsCrTiw
         qjZmnc8t7aI1Z9ZMTI9HjKUqr62BShEId1JYvGzGDDLlS8y38SSWr98Ev6xR7fH1DvyX
         vG687qlRvlIs2DnNrok1lFLeNK7+F2ZYlmTeKiILdmdb8kbAXM2Ka6U7EP17Z0NlqBSl
         eKv6hmr55xt7l2xxvrOmRa7vDYhaJjcLWQ+C3yIzV0CkpSkJahGa2vOIEUnu2W66HNCf
         6dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XXsaw4tgn83gS8crkwTPKdvTDY08Kp+Lc4B7yP1Hzg=;
        b=MoDPA1vWHddJn59KE8vbAnu0++YlAUdsDmy8post/SPrTHuXkpImxUNSwZL0sh9qwL
         xL/lmKD4cEjgnbf9AcWjFyiyHOD+F2+OGANfkg1A3TvlDQou+gDV2QL6+eadlz8GMSBL
         q60uUhYVC7KMnnhgiwtK8lVGXt6/c+ZKf0dQZsC6+oqICurmzpdItqPm3oE8u49T2lFC
         Fzie9CI/q8bFsPJvGhPxBUzWwLHg9dTjl5a4UJ752zgt2iuc8bPw13e4gduvs6pSOk2Z
         tqsJ9GKFRbOPu0hW/nQgwKYjKfg5BHBQPX0yH7rS0ZR94Rx6kr9G54v2p+8FB2uXtmjv
         5Lbw==
X-Gm-Message-State: AOAM530pf+gld27MjohM2DWuMyQQfBNV/fo3pWsBlgNY2yHr5cmLJ68I
        FkmV4RIL5dz1O3nBAaIhw54=
X-Google-Smtp-Source: ABdhPJxQczUNC/qb3nVrZ7bsLEfXpXYMTGcByqqY5D3N9praTG9+e8KnrDQ++xckW1DYCYOJMXqfNw==
X-Received: by 2002:a7b:c143:0:b0:37b:dacd:bf2f with SMTP id z3-20020a7bc143000000b0037bdacdbf2fmr10285943wmi.16.1645264925719;
        Sat, 19 Feb 2022 02:02:05 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id az13sm24417244wrb.39.2022.02.19.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:02:05 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 0/9] DIGImend patches, part II
Date:   Sat, 19 Feb 2022 11:01:48 +0100
Message-Id: <20220219100157.41920-1-jose.exposito89@gmail.com>
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

This series is a follow up to [1], kindly reviewed and applied
by Jiří in hid.git#for-5.18/uclogic.

It might look a little bit longer than desired, but most of the
patches are code simplification and refactoring in preparation
for the last patch which adds support for multiple frame input
devices.

Thank you very much in advance to maintainers for reviewing it,
José Expósito

[1] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm/T/

Nikolai Kondrashov (9):
  HID: uclogic: Remove pen usage masking
  HID: uclogic: Replace pen_frame_flag with subreport_list
  HID: uclogic: Switch to matching subreport bytes
  HID: uclogic: Specify total report size to buttonpad macro
  HID: uclogic: Use different constants for frame report IDs
  HID: uclogic: Use "frame" instead of "buttonpad"
  HID: uclogic: Put version first in rdesc namespace
  HID: uclogic: Define report IDs before their descriptors
  HID: uclogic: Support multiple frame input devices

 drivers/hid/hid-uclogic-core.c   |  79 +++++++------
 drivers/hid/hid-uclogic-params.c | 195 ++++++++++++++-----------------
 drivers/hid/hid-uclogic-params.h |  86 +++++++-------
 drivers/hid/hid-uclogic-rdesc.c  |  53 ++++-----
 drivers/hid/hid-uclogic-rdesc.h  |  38 +++---
 5 files changed, 221 insertions(+), 230 deletions(-)

-- 
2.25.1

