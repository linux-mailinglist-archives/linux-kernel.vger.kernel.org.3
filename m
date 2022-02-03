Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134474A851E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350779AbiBCNXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiBCNX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:23:27 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B2C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 05:23:27 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t14so3869855ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 05:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Ak+COwfE20Lh+wMI8BKPZo4w9eb0zqwsjKIhrR00dVY=;
        b=yRZR355Mfhbhl7GZ+SdOSUxtvGqB0IXPTh6ytscrhlFCEv43c7EBU/TQ1aGjc2VfOR
         JuU/u1jM17F0EjWgpYrdnjHMoFIZc0Xs8zvK7uOdj4qoKXJmnVhvw6eYpL2EyVkUmpH5
         8s7Mf0ExwIO4vY4BBdVZdNpbu/qh1OG/NhwQxSoKCP6m3PUkISixEhJxYfV4hQpv9D3S
         uFkP+E2X6UK5tA+lmkehEXmg/nV+BTB0Fx/MgzVHDL//DVr7xKOYVWL9679ZH/JK8bba
         xVnng3bqzF4EZcHpOUwkcWs6Hnc1CnXjASHgichtBvMQpJr4BUc91Ijh3Om16dCIRr+W
         qSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ak+COwfE20Lh+wMI8BKPZo4w9eb0zqwsjKIhrR00dVY=;
        b=Nl7DKKWeuiK4hhWFUH6u2fBTU4SFlMPXNUyqZcuDYA6e2DhGucIEBCZUKaTt2eItWn
         QH8MoKCzJHG6WKj307tgOdw/8fy3uc9m3H4GeV5tnpyZLY2HX5vsNZ/0ZEMF1Mmd7wyt
         l3UINrr72v7pWonWKkfSUhGZs9zkta5UdRlsDI8GUSeRfipM9VA8Zh1dueF+qAX7iOuA
         zcKIvGokA9/EZlWlUE6axpdurtAn+bq55M/Ab9CMSbm9kK0xzWwwOGD14+sOnj7kd8HM
         qtLER7ivZk0WCrsEVMlmEL5ycQrGO659weyYea6mpyDRe3ZsEDpFC9vU/uGGwP8nL2qj
         /RPQ==
X-Gm-Message-State: AOAM532l/E1rGygmxc+Ezi8oF0/JQGPKTkj5r8EkEsSYjQDdXurDANfR
        2HSamOt2iDWQaKoX+SFtVyNSU4RhW+Tf/Q==
X-Google-Smtp-Source: ABdhPJxTD07obBKqx4ohmhw45P/a5zdsLVVR5rdZko14LhaAA6p7Co6lBa+Vn7lU+WEd9hRq1B8eYQ==
X-Received: by 2002:a2e:a4dc:: with SMTP id p28mr19960705ljm.367.1643894605785;
        Thu, 03 Feb 2022 05:23:25 -0800 (PST)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u18sm4096730lff.139.2022.02.03.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 05:23:25 -0800 (PST)
Date:   Thu, 3 Feb 2022 14:23:23 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for v5.17
Message-ID: <20220203132323.GA4132001@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this OP-TEE driver fix which decouples driver private shared
memory objects from the original tee_context. This fixes the root cause of
a shutdown problem where the driver would dead-lock waiting for tee-supplicant.

Thanks,
Jens

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for-v5.17

for you to fetch changes up to aceeafefff736057e8f93f19bbfbef26abd94604:

  optee: use driver internal tee_context for some rpc (2022-02-03 13:36:32 +0100)

----------------------------------------------------------------
OP-TEE fix shutdown problems

----------------------------------------------------------------
Jens Wiklander (1):
      optee: use driver internal tee_context for some rpc

 drivers/tee/optee/core.c          |  1 +
 drivers/tee/optee/ffa_abi.c       | 77 ++++++++++++++++++++++-----------------
 drivers/tee/optee/optee_private.h |  5 ++-
 drivers/tee/optee/smc_abi.c       | 48 +++++++++---------------
 4 files changed, 64 insertions(+), 67 deletions(-)
