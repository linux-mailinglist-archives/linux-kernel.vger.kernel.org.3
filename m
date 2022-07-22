Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A35157DF3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiGVJth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbiGVJtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:49:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D873233
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:47:41 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u14so4855533lju.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+NH2TZLTRkYMUwxblNoX3+rqsbmRNXklBWALPtVASk=;
        b=Dd6sxx+/IbCXUNyG24ZdbEWxqMb3YAubc0eBrxpdoVTXknPoix5z10aLYTY+TlVvGO
         dpz7Qa4jL+XIfT7I8hXXrL2h5xB6yVBaOoe1CjlJrWIjM/pJVau8/5Jeo4DZzeQBZTUF
         ey0qYxeACyvx8OTothxDWcVoH6f1urxja0zE1sVs6aD5IqUReDq1HJUaxTPzlmreOYhv
         wTaALV0vSDuXllJPJ6a0mgp/Bil+0rvrmDowF/efhXg/SETZ+qdIj1Zt7/15LEogTmRZ
         nZb5Nr03TkCgcxy6nsNFCOnOvVAZtsa1LXg8LpxzwfQ6Z+uIWDjCKlODZtgew4AChYt5
         q1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+NH2TZLTRkYMUwxblNoX3+rqsbmRNXklBWALPtVASk=;
        b=DMHHz/7npXIMyeVTq/8Ju89GLwzjZyEwffUm8aJQ7C+Ls7+91Lu4I3OILdB7tIYHJ9
         tmB7Y/1QlXqUuqLJCcyIQtRYBzMUvaBDQykIdHMJici+3bgt5WkhcI9ADFZPGgIrhutd
         0MnVBkI3pZxJFqwFEbNProh0F7JhNeEO02uFn/WFYlVegl1+D6j2zXyMU3VDMxhin/nM
         BU9HelOXy2ZR4LB3sfXBPuQVai/bUPr15u6x3iHUytTgqLm6I3/50x+x8UU4diqfTOel
         ShsAOH0F7Xt8xQmTXOrT97vsjC0JSfDkuhGIZ4ipV3nRUivU8NGCvtvJq6aizk2koo2u
         1Imw==
X-Gm-Message-State: AJIora+A49JMqhiX9Zp4nV5Nni+8a5PHPKJmKWTPB0bi708RlUpw5R6Z
        OtQTTIA2pr2g9oKbxeq9NRz+SQ==
X-Google-Smtp-Source: AGRyM1sytXnlWNmfuLELM3bB1W1fEx2SWNh/TQCE0YHwPpFzmosmN4N3iMQN74GFsAG+sdu1yv91Ow==
X-Received: by 2002:a2e:96c1:0:b0:258:e8ec:3889 with SMTP id d1-20020a2e96c1000000b00258e8ec3889mr969008ljj.6.1658483259441;
        Fri, 22 Jul 2022 02:47:39 -0700 (PDT)
Received: from localhost.localdomain (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b004811bf4999csm953638lfr.290.2022.07.22.02.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 02:47:38 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.19-rc8
Date:   Fri, 22 Jul 2022 11:47:37 +0200
Message-Id: <20220722094737.50886-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with one MMC fix intended for v5.19-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-rc6

for you to fetch changes up to 51189eb9ddc88851edc42f539a0f9862fd0630c2:

  mmc: sdhci-omap: Fix a lockdep warning for PM runtime init (2022-07-13 12:29:17 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-omap: Fix a lockdep warning while probing

----------------------------------------------------------------
Tony Lindgren (1):
      mmc: sdhci-omap: Fix a lockdep warning for PM runtime init

 drivers/mmc/host/sdhci-omap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)
