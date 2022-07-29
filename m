Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C89C585612
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbiG2UYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2UYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:24:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF8088741
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:24:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z18so7101747edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=DD5ZTUFuKAP0HflbyT4tZofzegaYKmqv/uxWG1vqBO4=;
        b=Jm3l9HhHkx5hqABQOnfdln7qyATxQaRlBiOS5jsXIeXPzxxoAoLnBwmesVJ4gbG2cq
         Jm3PvjjOK+aW/VJqiIiPG1ccR5fKellIuDnzJ3J85hU++B35mEU9gMlNeK2AxEbScH27
         YZ1DrToUrRUkJRdKhmH72EMr2YW6Xv2WTp+X8rOqKxKZnKsxxam2whmLHQMXJlpfT5f1
         RrMlid5be+mecjbVQPP18JzrPep22/VkW7CnjW2b4CFY4GhOkk2wBT4+ms5aosZmhfut
         62jNX0H8y9n06SWlIoZ4FaRheLKx4sTeyYuo8QLpYoSGqQZ7wmXcT21Kgjz40dejhudN
         Xa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=DD5ZTUFuKAP0HflbyT4tZofzegaYKmqv/uxWG1vqBO4=;
        b=7wKaLFkR3V1FIlRKxHHhuKPx+GRK2Uxc5NRhVEJdyaRWCoguAbB+3tOu+EmsXvOLWG
         SBZ0HN6YWtEoXPi3i+g43P+b+e0DTmAQiL+uDRh1ZSyo5p8NBR7zhKFx0n0M/2Qhu8Db
         w191mNf9LiNCk/qCWnhLcEk885zW8nkBdD8x9BIyUZopIHaEOeBnK9fYEGNtavG4wt6i
         DyalWPmorop8hZeIASr9FtfpHkyXlPynq2GA/qSYzcMf4puTLKfSJ/5ZyxmnqawDe04R
         Pis2KXKEotxTp3al3+YZW2P7RpLVsk0EzYgbvh/U8IPcHaY8TMgay5zilEpxOQE6NpcZ
         MU0A==
X-Gm-Message-State: AJIora/YmJXi+wbfOm/beOUxxetiu96pMPTuWQnGBjyZkb/gGDZIt2o6
        bnPQQmwiDPWuRbxuvLddogLPryzIBs8exKH8HrAkcrlo7pFwuA==
X-Google-Smtp-Source: AGRyM1sJGV43E1lWJdEwZnroFIFGxZkNFN0msL97/FHFmAUUBBTVi+g8K85bUi4sl3c8G/yjvwrPQMLOY30kIxj91pg=
X-Received: by 2002:a05:6402:e93:b0:43b:6a49:7e88 with SMTP id
 h19-20020a0564020e9300b0043b6a497e88mr5288547eda.132.1659126277931; Fri, 29
 Jul 2022 13:24:37 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 30 Jul 2022 06:24:26 +1000
Message-ID: <CAPM=9twcrq24uhTF4yYR2v1tJsK76D_S4=fjE=K4s+78Wds91Q@mail.gmail.com>
Subject: [git pull] drm fixes for 5.19 final (part 2)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Maxime had the dog^Wmailing list server eat his homework^Wmisc pull
request. Two more small fixes, one in nouveau svm code and the other
in simpledrm.

Thanks,
Dave.

drm-fixes-2022-07-30:
drm fixes for 5.19 final (part 2)

nouveau:
- page migration fix

simpledrm:
- fix mode_valid return value
The following changes since commit f16a2f593d0095e82e6b7f9d776f869c8ab45952:

  Merge tag 'drm-intel-fixes-2022-07-28-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-07-29
11:39:13 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-30

for you to fetch changes up to ce156c8a1811c96a243590abd0e9b5a3b72c1f3a:

  Merge tag 'drm-misc-fixes-2022-07-29' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2022-07-30
06:09:57 +1000)

----------------------------------------------------------------
drm fixes for 5.19 final (part 2)

nouveau:
- page migration fix

simpledrm:
- fix mode_valid return value

----------------------------------------------------------------
Alistair Popple (1):
      nouveau/svm: Fix to migrate all requested pages

Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2022-07-29' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Nathan Chancellor (1):
      drm/simpledrm: Fix return type of
simpledrm_simple_display_pipe_mode_valid()

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 6 +++++-
 drivers/gpu/drm/tiny/simpledrm.c       | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)
