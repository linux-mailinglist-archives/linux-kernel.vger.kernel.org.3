Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C825858A04F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiHDSML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiHDSMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:12:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801DE4E860
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:12:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso537310pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=WF/cYFGagnF40nv8l7k9eP25Q0NBXp9Z9COyyJ/N54o=;
        b=cjD75C8zkKUPAnEZi2R8ZifsZOuBDxI97ehOWuAjwg9BU9nlwTsRbKXh3SGxTngkip
         KVam6izMKL3D9XccgmS8FZvf+SYP4i0ieM2bk1nI6xqSpBPqyDM/be1sfOpZDOsz6xbi
         fDPASsXiSdWTwliZCcBTXWmGLBP4N0p4BaH4wFKq9KVrldbdhkF+Cr+P+Zcv2sQI18Z1
         i1hR0X0pAHePEH/K0ca2C+1YObl3Kb8e/cbMFWsdKs4OLUpf9XwVrR0moe8/uaP5eOC3
         7XNdpDq2UpAS2tOr6JFRyZDwiCdZshHkyZTgD56YBznu6nfVxa6VmRzC5YfdKg/7OTkv
         mHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=WF/cYFGagnF40nv8l7k9eP25Q0NBXp9Z9COyyJ/N54o=;
        b=Tb6U3RSQ/hYzokM+Pv+ZQmlX899Jgaa7SaAtaKcp5e6Z/hUL+De3rUV+otrhv9TZGA
         8Rt4OfCZT/OcMxNo8PooMDsfhTwcBBfs7Tupp6r62qZ9NWlIw05dJvEy+i+W085mBk2z
         FEWkdLubV0s2ZFsI9fGCO+rNu9Zb0Oc1d5PE5xzv2z5cRFd8xudte+TVsyv4Ze4ksaLE
         gdBfKTeqa73/CRvMPL35rw3K5Sub8zTRa1opEbT+DRHLFzjLuuc8dGM/hA8RkT+H8CMG
         3TNLeQY4EuiTHc8Y5ekhwqp4Df+btAOsj9/GGABP293/weIrDrxjQNGKLQ2zNFtR5WtI
         yUyw==
X-Gm-Message-State: ACgBeo3v8uK6FZXSkVfolEYKeY6hLLvBoypLdokixtTN6bbMhJkjwnt9
        +5JHauclx3TmiDrb1XSUoXk=
X-Google-Smtp-Source: AA6agR5BOXJKtSK2Srv6y9MJ6RPVaTE8HZIlIMfABcIutnJuDFoSMbRF+hWRXs+8Tr5daapCWiEZoQ==
X-Received: by 2002:a17:902:6a8c:b0:16d:ca07:61df with SMTP id n12-20020a1709026a8c00b0016dca0761dfmr3038813plk.124.1659636727982;
        Thu, 04 Aug 2022 11:12:07 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:6f47:bd53:1f33:e84c])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016d5a356b31sm1320642plh.116.2022.08.04.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:12:07 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/5] xtensa updates for v5.20
Date:   Thu,  4 Aug 2022 11:12:07 -0700
Message-Id: <20220804181207.1246232-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following updates for the xtensa architecture.

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220804

for you to fetch changes up to 0847d167d0f9bdc8f61e5e5d32831fa8fdcd150f:

  xtensa: enable ARCH_HAS_GCOV_PROFILE_ALL (2022-07-14 00:54:47 -0700)

----------------------------------------------------------------
Xtensa updates for v5.20

- support KCOV
- enable ARCH_HAS_GCOV_PROFILE_ALL
- minor ISS network driver cleanups

----------------------------------------------------------------
Max Filippov (4):
      xtensa: iss/network: drop 'devices' list
      xtensa: iss/network: provide release() callback
      xtensa: enable KCOV support
      xtensa: enable ARCH_HAS_GCOV_PROFILE_ALL

Yang Yingliang (1):
      xtensa: iss: fix handling error cases in iss_net_configure()

 .../debug/gcov-profile-all/arch-support.txt        |  2 +-
 Documentation/features/debug/kcov/arch-support.txt |  2 +-
 arch/xtensa/Kconfig                                |  2 +
 arch/xtensa/boot/lib/Makefile                      |  2 +
 arch/xtensa/platforms/iss/network.c                | 63 ++++++++++------------
 5 files changed, 34 insertions(+), 37 deletions(-)

-- 
Thanks.
-- Max
