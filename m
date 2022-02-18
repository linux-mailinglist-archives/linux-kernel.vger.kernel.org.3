Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581734BBFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiBRSsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:48:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiBRSsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:48:23 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3025A12AC3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:48:06 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g39so7073641lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RkUq0OM2ro+ceIbIPuuiHN4XgUkIzla203RG0anLfvg=;
        b=hlRxOPBR4EsZDOlmKyYqBEezFvgvoYCADk9bVHTYBDV8IuLBmaOuph9tMAhFZO/21w
         U2mpoI9P45kGrauZkIt+km6mQxl6TNati9LaACtg9qVl454Cje0tFuKgAwPTM84rSbBX
         Y5JqaKtimtGUr1nhO0DNMNeedOcz2cOO9JvQOx+UNJqlGjuIj9lcX9J8CiEI+PvasQwm
         RpDMzbXfIwOvy2jjPVrL4HXJipa4JfQLjshwTKk0TmfNICHXaIlfm0r/P8ivkgdlpEBT
         S8UgvtfE2th9KnTov470vrkivxHpZoo753JxQgla8ON9ojy6qcHyzFTmrboJ5cFSFhX4
         +9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RkUq0OM2ro+ceIbIPuuiHN4XgUkIzla203RG0anLfvg=;
        b=m6gxR1EOz59djoL0punuW+SYqvU+hIGFCUX0F/j3aoYgO0O0VDWuasmfgVlioSH5sY
         cnK8Dn7i/rY88Ys/irc03PgKjCzkovT07SZ/T/13EjnJErIQENGpwlI/fTtf8ZOf0Uwl
         nBTxQqo7DQxvWzHhdDu0KAMNqB5T3r42xahFGP+6V39/Afqsu39UKAVXPLyVeG+3r2S8
         7qhbx3lEpOQWqHkBb0ySVF8QGFDbYYF6bnzt0UKBYy/FgCe4Xf6dfQrKD+SjfHYDBedQ
         xKu02VADe/TwW3Mmq+AVcuU8WNs1CUEUy8YxbT8VTkwErKbz3YAl3eKCWFbF6kPa9YqZ
         3LvQ==
X-Gm-Message-State: AOAM531wGI+bZ+ZtJwi9K38Udj7J6UZTZk/niffaefUSWGdFCKIsvit5
        93vPHOsT9CuqMENnjA0W7JtaK2B5B4Bkdg==
X-Google-Smtp-Source: ABdhPJyOHVwpEt2nUDoEv/b1QM80vvPkFoHX7JvICuP5h5LccHlMJ+KeuvpxF+Z4Oec+ownV2jfYRA==
X-Received: by 2002:a05:6512:4022:b0:443:98eb:97c7 with SMTP id br34-20020a056512402200b0044398eb97c7mr6259121lfb.68.1645210084532;
        Fri, 18 Feb 2022 10:48:04 -0800 (PST)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id v18sm405996ljb.98.2022.02.18.10.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:48:03 -0800 (PST)
Date:   Fri, 18 Feb 2022 19:48:02 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] tee: shared memory updates for v5.18
Message-ID: <20220218184802.GA968155@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this TEE shared memory cleanup. Some kernel internal APIs are
replaced with easier to use counter parts. The TEE shared memory pool is
also simplified.

Note that this pull request includes two patches which are outside the TEE
subsystem:
- 231b1fc5da09 ("KEYS: trusted: tee: use tee_shm_register_kernel_buf()")
- e7ddab084740 ("hwrng: optee-rng: use tee_shm_alloc_kernel_buf()")
Those patches are reviewed by their maintainer. I've also asked the
maintainers that normally sends patches upstream for these modules if it's
OK that I take these patches via my tree. As I got no answer I assume that
it's OK.

This pull request is on top of the patch, aceeafefff73 ("optee: use driver
internal tee_context for some rpc"), I've already sent (and has since been
merged) for the 5.17 kernel. That's why I'm not including it in the stat.

Thanks,
Jens

The following changes since commit aceeafefff736057e8f93f19bbfbef26abd94604:

  optee: use driver internal tee_context for some rpc (2022-02-03 13:36:32 +0100)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-shm-for-v5.18

for you to fetch changes up to a45ea4efa358577c623d7353a6ba9af3c17f6ca0:

  tee: refactor TEE_SHM_* flags (2022-02-16 07:49:41 +0100)

----------------------------------------------------------------
TEE shared memory cleanup for v5.18

- The TEE shared memory pool based on two pools is replaced with a single
  somewhat more capable pool.
- Replaces tee_shm_alloc() and tee_shm_register() with new functions
  easier to use and maintain.  The TEE subsystem and the TEE drivers are
  updated to use the new functions instead.
- The TEE based Trusted keys routines are updated to use the new
  simplified functions above.
- The OP-TEE based rng driver is updated to use the new simplified
  functions above.
- The TEE_SHM-flags are refactored to better match their usage

----------------------------------------------------------------
Jens Wiklander (10):
      hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
      tee: remove unused tee_shm_pool_alloc_res_mem()
      tee: add tee_shm_alloc_user_buf()
      tee: simplify shm pool handling
      tee: replace tee_shm_alloc()
      optee: add optee_pool_op_free_helper()
      tee: add tee_shm_register_{user,kernel}_buf()
      KEYS: trusted: tee: use tee_shm_register_kernel_buf()
      tee: replace tee_shm_register()
      tee: refactor TEE_SHM_* flags

 drivers/char/hw_random/optee-rng.c       |   6 +-
 drivers/tee/amdtee/shm_pool.c            |  55 ++----
 drivers/tee/optee/Kconfig                |   8 -
 drivers/tee/optee/call.c                 |   2 +-
 drivers/tee/optee/core.c                 |  21 +-
 drivers/tee/optee/device.c               |   5 +-
 drivers/tee/optee/ffa_abi.c              |  63 ++----
 drivers/tee/optee/optee_private.h        |   7 +-
 drivers/tee/optee/smc_abi.c              | 125 ++++--------
 drivers/tee/tee_core.c                   |   5 +-
 drivers/tee/tee_private.h                |  15 +-
 drivers/tee/tee_shm.c                    | 320 ++++++++++++++++++++-----------
 drivers/tee/tee_shm_pool.c               | 162 ++++------------
 include/linux/tee_drv.h                  | 138 +++----------
 security/keys/trusted-keys/trusted_tee.c |  23 +--
 15 files changed, 388 insertions(+), 567 deletions(-)
