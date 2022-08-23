Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC359D1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbiHWHJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbiHWHJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:09:41 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B04D61B13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:09:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 83so6919725pfw.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DVy0TzJK124HkjXGlxbNmGak/65vU4dzYh2orwnTpNc=;
        b=mPu6WSWP0qULX93vTjJLvJY9Zhgn5+HzlKmj3TODNEBAkey2CFmdtpg1tgfks1Nsj+
         lGHpo1zmPnKWdBXPvWWBtQY7QV0Aqme1xQnTxWc+oLwimEF1F5BGjRxza35MwCYWEFjR
         AiYS/SwsME1mbwt/+p0C3BqqPw7GDJ9JSQ460qJRNwlAbvO/tpGNYxRoJ+kbETYV6lYT
         vcbOquYKX2e3OdUP6El2Iio+wLnaXBgHFpsTkuAGk4o2MbQdqGiSYhg6YGAi7J0oD9aO
         jkHYufKSJAOifu2qAcJB3VJ8jzpwPTMqB7f00wbnY9ottFoxJnbnau/ptVpZk+SA71IK
         muxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DVy0TzJK124HkjXGlxbNmGak/65vU4dzYh2orwnTpNc=;
        b=NR1Wj6uoAB5tDHDdAcZQL+ZUhfcBkZz8t5+U7gHLfIN/gh6jBmFHbm3PoOVYiwQOrJ
         Mg3hDszq56cBbiDmjwQV7v1/ozltDiLKPtuknRL815pdDk9sqnGn5qyKvhdKpcRKmId3
         1Rz7rPr6Uo+5NQPfRbDLoORvdO3qLRwzG32k3onCEpPPd6RS8MzaGVoCqMX3UjjvYq2U
         C0pR9q/SfH9Ikojjq3O8/GxNIQEyq7c+m4ytm7DcBBBon6dD9bnW8ybb1tQZjQse7LHh
         HOsAkkc/Qxgx+4P/K4K4xc3pjpPk2EO5UPkZvc65S1ggR53JDogXEl8XNpqyU/777Rys
         5fjg==
X-Gm-Message-State: ACgBeo3S77BVtW3ke/CEcPlIIx6LuhshWqrXBuhZD0xv+CmJC6p1C0fW
        D5Ee6oTI14B/ImSEequU9aXGURQeJ98=
X-Google-Smtp-Source: AA6agR6QR28nO5zXtIetcNivJQPQCvRsuHGvxk9OMoyOtT1qkOduu7glkDcRwnRz13eux+L2xH7AcA==
X-Received: by 2002:aa7:88c6:0:b0:537:9d6:2c76 with SMTP id k6-20020aa788c6000000b0053709d62c76mr711568pff.41.1661238578760;
        Tue, 23 Aug 2022 00:09:38 -0700 (PDT)
Received: from localhost.localdomain (121-200-9-125.79c809.mel.nbn.aussiebb.net. [121.200.9.125])
        by smtp.gmail.com with ESMTPSA id 22-20020a630d56000000b0041c66a66d41sm8506773pgn.45.2022.08.23.00.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:09:38 -0700 (PDT)
From:   Daniel Tobias <dan.g.tob@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Tobias <dan.g.tob@gmail.com>, trivial@kernel.org
Subject: [PATCH 0/3] spelling: fix debugsfs -> debugfs
Date:   Tue, 23 Aug 2022 17:08:36 +1000
Message-Id: <20220823070839.533562-1-dan.g.tob@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Tobias (3):
  amdgpu: fix typo debugsfs -> debugfs
  scsi: fix typo debugsfs -> debugfs
  spellings.txt: add entry for debugsfs -> debugfs

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 drivers/scsi/fnic/fnic_debugfs.c            | 4 ++--
 scripts/spelling.txt                        | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.37.2
To: linux-kernel@vger.kernel.org
