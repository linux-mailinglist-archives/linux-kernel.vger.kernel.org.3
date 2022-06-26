Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7555B147
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiFZKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiFZKrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:47:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D90112D2B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:47:31 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 23so6482864pgc.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orV5VbG/L/Oc/EYYxy01Vn21BD/RRjrxeo269NpoUHY=;
        b=MlcFaFWJaXM/u0BqdRH/8B4tfYFbpi6sHytjjslVyDPv5fJMXAk6IJhv1UFI5sr3+L
         XwmnNYFwL+UBEccdSVeneKlbkqL+njonS0p+4BxgGNsv2zTpaqy+ymoaV9zVLUBzjp7R
         6z6SEXPiKc1EabSrmyJarIqeuaAo1KIjYJhdV/RlK/Y+6lXr1FD37VrbiGUTZDon/z2B
         Egw+D1EAqHEY5FCQAYiPkh7+WWk2wJ+/ntYiXVteixqWGZuja/QYdMDW2S2va9NkL4Nk
         6qqEs7QUquw4Wplqz8hzqbzlyWXzZyaEtGdsh8Kn0Jd737elQHHQ6Zob59N/0W2apbwo
         /zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orV5VbG/L/Oc/EYYxy01Vn21BD/RRjrxeo269NpoUHY=;
        b=JvzNJNtYYYMRQGgPBB9RvosPySIuyGhzPZ9+IULAymWKeCDFojlW2ugmRq12c0Dma/
         IZ3LgwS1mEgyi8T+7DdkrLtc7G+GIg77I+h7faaMZborDvqIs8OBfOAvFSvbMV1DxIR2
         hew5J/MLJq0GEL/ceJ95T4bl7cQg+w/bY99T30r08adx00pbSkfcr8zcYebIbpNkOqnz
         5SgIsY3DClUYePwGWNYCFsmYtaqPuuKWHbWvJkqziLCXs9m5/t1iAaKdkwf4izYvBBvw
         jwCUt4zLvp2LidugUZ7plVfaxGw5qN0DvUnTslOH5woVtwAt33cfLzVtvXZE4qGi8z0W
         He0A==
X-Gm-Message-State: AJIora9xVfGY6oHx04EUXiaFC2ta32fBCkySat5t9WkaKKpLOJU24fhB
        8YijVRcNU54t01JEXuptZhM=
X-Google-Smtp-Source: AGRyM1u1weQraX0E1TFGkKhCsZi2hOv5a7qSPCeu9UD/ICNd/V1FAxz9lzsROer5s5gChPU2tfVDHw==
X-Received: by 2002:aa7:9425:0:b0:525:279e:9251 with SMTP id y5-20020aa79425000000b00525279e9251mr9211021pfo.4.1656240450827;
        Sun, 26 Jun 2022 03:47:30 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:cd6d:3789:7c7e:554c])
        by smtp.gmail.com with ESMTPSA id iy11-20020a170903130b00b0016a4a2ea92asm4964700plb.255.2022.06.26.03.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 03:47:29 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/3] xtensa fixes for v5.19
Date:   Sun, 26 Jun 2022 03:47:11 -0700
Message-Id: <20220626104711.2024291-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fixes for the Xtensa architecture.

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220626

for you to fetch changes up to a2d9b75b19dc8863f0845ffb401d33b2286d0aa1:

  xtensa: change '.bss' to '.section .bss' (2022-06-20 02:50:34 -0700)

----------------------------------------------------------------
Xtensa fixes for v5.19:

- fix OF reference leaks in xtensa arch code
- replace '.bss' with '.section .bss' to fix entry.S build with old
  assembler

----------------------------------------------------------------
Liang He (2):
      xtensa: Fix refcount leak bug in time.c
      xtensa: xtfpga: Fix refcount leak bug in setup

Max Filippov (1):
      xtensa: change '.bss' to '.section .bss'

 arch/xtensa/kernel/entry.S           | 2 +-
 arch/xtensa/kernel/time.c            | 1 +
 arch/xtensa/platforms/xtfpga/setup.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
Thanks.
-- Max
