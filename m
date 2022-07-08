Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734C956BB1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbiGHNqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiGHNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:46:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B07D2AE07
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:46:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s14so26027595ljs.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ftCQgL1IH5y3XBplqV417/ir/b+4fi5ovTGrT24Sbrg=;
        b=XvzotjOmwUMkwmQCk6CPPiN8GmYCTOGrvE+49z1IZJ4hG+aLC//O1xUhtGVYz3N/+v
         WzV2qHB5lsvqxhvw4OXHvOEK4m+FSIYo+ADgxoeKmQngq/wQemhmN6OWKnQLbcC5wbh4
         Y43Vzaw6/xC99ARj/8JpAqatDCHqXRFkhT1ojY+C0F81cDeYq3E4IZnEj/P0r2Q6MFoT
         kYkY2zaHx6zz6eIg7lKHhDDGJgY7OX+ILHAqzd0ibBfjpIH9fk+/AHK+FvY8JDrMPb3f
         dKtKulWGrNxNW/7gYhkvQI1XLGj1uK7e5UEZxOh21vCQdJWHEzKkxZfj3ctpyqlDZlUq
         fMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ftCQgL1IH5y3XBplqV417/ir/b+4fi5ovTGrT24Sbrg=;
        b=FSMMi8XWiNE9QOJL++/Xo/JbovE6K8/zLW+s73MJIWcq5IDpV5yr3X8rvIjpBtIT8e
         nDsYawjUAAVXJn0LztQvT8lBrx5GEcTjsl2V4rNNBluXPysoePDslR+uJvGKVFt/B6jq
         JhytqrR++ljqJNBcnl3vbewxJOyBtqiYIy5RTq1sqOQ3RLC/++P7klI0In3AnM7Z55Bm
         vq9vd8i3se2dcvNlKhhRIsoKeRR1Hqas7VCvzhjj82dxxskn7HT3reSplNisnsVgvq9k
         PWUl4wzfb5iOvTvBm2hmnh44XY6ZJ8MrqGeYmdhnxEfTgREM1AzmjkFngt6r/KLjTOkj
         DO9A==
X-Gm-Message-State: AJIora8Kst+27RJLvVrvhE/L6vF3CSSPyXGl6WnwSjOJLJfdA+OPiJ2J
        U+6dhpLZPmhvlR37wNhW0irFcgX6ewjFYw==
X-Google-Smtp-Source: AGRyM1saYxhEp3LUGYaX461stWYeGJkKo1DfCNWmUKpN2FBs85Vqv9mvQUqJqW133/eB7oRP6K9qsQ==
X-Received: by 2002:a2e:b8c2:0:b0:25b:6b0c:34e with SMTP id s2-20020a2eb8c2000000b0025b6b0c034emr2047024ljp.397.1657287969517;
        Fri, 08 Jul 2022 06:46:09 -0700 (PDT)
Received: from jade (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id u10-20020a05651220ca00b0048957b0c58fsm583953lfr.47.2022.07.08.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:46:09 -0700 (PDT)
Date:   Fri, 8 Jul 2022 15:46:07 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE Fixes for v5.19
Message-ID: <20220708134607.GA901814@jade>
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

Please pull these small fixes in the TEE subssytem. The OP-TEE driver
patch fixes an error which was introduced during the merge window. I'm
not sure if the error really can be triggered, but it would be nice to
have it fixed before the release.

Thanks,
Jens

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-fixes-for-v5.19

for you to fetch changes up to e5ce073c8a1e01b215a5eb32ba48f8d17ded3bd5:

  tee: tee_get_drvdata(): fix description of return value (2022-07-08 10:51:24 +0200)

----------------------------------------------------------------
Fixes for TEE subsystem

A fix for the recently merged commit ed8faf6c8f8c ("optee: add
OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG").
Two small fixes in comment, repeated words etc.

----------------------------------------------------------------
Jiang Jian (1):
      optee: Remove duplicate 'of' in two places.

Marc Kleine-Budde (1):
      tee: tee_get_drvdata(): fix description of return value

Yang Yingliang (1):
      optee: smc_abi.c: fix wrong pointer passed to IS_ERR/PTR_ERR()

 drivers/tee/optee/optee_smc.h | 2 +-
 drivers/tee/optee/smc_abi.c   | 4 ++--
 drivers/tee/tee_core.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
