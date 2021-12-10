Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9D246FE37
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbhLJJ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbhLJJ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:58:09 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E8C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:54:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id cf39so4940482lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8N1QoomSDHcA8D1T8Tv1TTr0YRk/oLQcu27sC+kmuc=;
        b=XkCisJCEtNeNlUcARJfgK8lAUuGTX8V0RgWLLmy3rHtYvOWlNVSS7bF29eAp/RCADg
         SD9iDqH2813CT+2j0foeTTgPFKqpQgcHrUsViWgXSnI755Uki2fIkHlyjAX0BBXNYtxG
         PaN+zPU1HH7o92dXwLpFfFUMKlqdDV9cpEoBeRZ8DkwP4O2yatG0eC7y3kS5BOvlW1yy
         XlfEnD1pPgg1fsO5KDPLoe3BAGSxtX5oZKbS2989ELBN1cyN9eTpU2PwL2lr3IeYyeeP
         brzbRriIg+nyxCRjQAF4qIExrLAJK+8ISr8tPsuKD/OubSz+jAbbORv3oYQ9YGjTmzP0
         UKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8N1QoomSDHcA8D1T8Tv1TTr0YRk/oLQcu27sC+kmuc=;
        b=j5JH0xfkWP3H6xDfVUuHwAtK9q4FcanbUM0V92nOw5yWDL9bqMGWk1cdVs6SLVE/2I
         8D7FpoekPybmL4wUhB1nNRqnXyJ69UKShDwvn6jSF0Hjaaqcw3ojzAzpgM4NUpHLXwbs
         WcGLwnXhFsOhyfilYCBOW0DM7911vB94pGCQYNhRI6VKFb/gaSNnq7GYReOlegyle6YZ
         z37f0Y5ZU2EUgSLaRWTE3C36pNSYu1zzgg8h8RJu9Dj3QhsKLFXRdDm1xeqSMiTeDoE5
         rls5Yi+rHEILLMaIMvWvuawYVj+ejvAReOuaP0sGFb/WgAlB/nFnbu5XOAgBMOLhMrXI
         2PMA==
X-Gm-Message-State: AOAM530Ixi3SidnK2i5OdxTXvumR8AtBgQkx3LmtwfQG0eimMFUoH0fc
        khb/UjgL+dF+7rkoXUehoGhMCI8gSLqs5A==
X-Google-Smtp-Source: ABdhPJxMtCRcg2pLipCeOwRT+EWiXBB1vSlr3YCbOx9Y3LWEahEOmkN4UttF75CaFKwSXPdc/8bb4A==
X-Received: by 2002:a19:c352:: with SMTP id t79mr11305464lff.251.1639130072797;
        Fri, 10 Dec 2021 01:54:32 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-21.NA.cust.bahnhof.se. [155.4.129.21])
        by smtp.gmail.com with ESMTPSA id h17sm262875lfv.62.2021.12.10.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 01:54:32 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.16-rc5
Date:   Fri, 10 Dec 2021 10:54:31 +0100
Message-Id: <20211210095431.63667-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.16-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc3

for you to fetch changes up to d594b35d3b31bc04b6ef36589f38135d3acb8df5:

  mmc: mediatek: free the ext_csd when mmc_get_ext_csd success (2021-12-09 10:30:11 +0100)

----------------------------------------------------------------
MMC host:
 - mtk-sd: Fix memory leak during tuning
 - renesas_sdhi: Initialize variable properly when tuning

----------------------------------------------------------------
Wenbin Mei (1):
      mmc: mediatek: free the ext_csd when mmc_get_ext_csd success

Wolfram Sang (1):
      mmc: renesas_sdhi: initialize variable properly when tuning

 drivers/mmc/host/mtk-sd.c            | 4 +++-
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)
