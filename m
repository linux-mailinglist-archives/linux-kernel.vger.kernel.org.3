Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684CB4E2B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349589AbiCUOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349576AbiCUOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:49:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1755E778
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:47:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso16600543pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=O4ogkXV1uIkuGceEVqAzKmGpZZyarlu6xE6mn+lUG0s=;
        b=DeGK8SvJVAgmIjeOzOrGBXCp0RLu/HuMYaJ9YgRJIobyQ3cm5XS8mG6Imp5GKrOXO4
         47l5ImNXcLwqyEQVattXJMy127WeS+0URzdqoCes+nJfwkg2fnvJwNbp8cFKUawcNNk1
         SH15N//FTRHqAxrIoRJNZvfeiGKyFvTg/0C/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=O4ogkXV1uIkuGceEVqAzKmGpZZyarlu6xE6mn+lUG0s=;
        b=NwSND92S2GHovkSysUyBukFeCLlGLXOWzoEi+YNxI0zbGYsi4RIttG9jF+YQQqtm+e
         2LuX3W68ltz0d6k4dfiB2mgsX1u5JOdyG1tIl6PG4ESs5dP8j2XMC48jPWfvTCyvG/cj
         +w5SGduucpc5Wmk3kupAOHrAXDT+aQYig+DVQIsM57Qm9kmQfktOuGfhOQUKCIxmW15i
         dWVCMTr5M5ZAEkCmqUquP7g768+BwvU9ovBJHwyK/VvsQ0U+v554m5oRMLCnM6MC7xnZ
         JSu1qOSh/GF823azLqy1VTGEihTlcqMQjYMp/ZjmB527mliE25e58PeIGHl2utE9aTXt
         XmYw==
X-Gm-Message-State: AOAM532DAfW/SGN4EDnO79JIbPu/rvg8oA+f4S4Xg7j/+GD/9HOnTT88
        ICDvrHOvOhfeU53EHO9kdn2gFw==
X-Google-Smtp-Source: ABdhPJzIcCiu9CVAi9svfEdqd9ehBtJ01KTcsQkPjeoTModbzy4B6KxRm3x/Ov5NvcKgAh4WFInXCQ==
X-Received: by 2002:a17:90b:4ac1:b0:1c6:adfe:322a with SMTP id mh1-20020a17090b4ac100b001c6adfe322amr18966975pjb.189.1647874074263;
        Mon, 21 Mar 2022 07:47:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x29-20020aa79a5d000000b004f0ef1822d3sm19185775pfj.128.2022.03.21.07.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:47:54 -0700 (PDT)
Date:   Mon, 21 Mar 2022 07:47:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [GIT PULL] pstore updates for v5.18-rc1
Message-ID: <202203210747.C40221E63F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these two pstore updates for v5.18-rc1.

Thanks!

-Kees

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.18-rc1

for you to fetch changes up to 8126b1c73108bc691f5643df19071a59a69d0bc6:

  pstore: Don't use semaphores in always-atomic-context code (2022-03-15 11:08:23 -0700)

----------------------------------------------------------------
pstore updates for v5.18-rc1

- Don't use semaphores in always-atomic-context code (Jann Horn)
- Add "ECC:" prefix to ECC messages (Vincent Whitchurch)

----------------------------------------------------------------
Jann Horn (1):
      pstore: Don't use semaphores in always-atomic-context code

Vincent Whitchurch (1):
      pstore: Add prefix to ECC messages

 drivers/firmware/efi/efi-pstore.c |  2 +-
 fs/pstore/platform.c              | 38 ++++++++++++++++++--------------------
 fs/pstore/ram_core.c              |  4 ++--
 include/linux/pstore.h            |  6 +++---
 4 files changed, 24 insertions(+), 26 deletions(-)

-- 
Kees Cook
