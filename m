Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEE0493985
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354149AbiASLbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354064AbiASLbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:31:31 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B275C061574;
        Wed, 19 Jan 2022 03:31:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c2so4830733wml.1;
        Wed, 19 Jan 2022 03:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B184jFapKUoaCmeCoLa/RY1yl2o5xLb5T8mZ+GEtvMc=;
        b=kUJFN1kFYOr2PB86f3ofbWNuzAWIiKt4CKNBAuTjmwOxQ1X9fi8QrmX4DatmvxKL1a
         eUJ2A8WsGvpPrtlbPPvHr08Z5pM7UGogwF6UHWa75ijA3H6Ujp2FpZ4qi8bikWY4urlt
         qEQOLREVOYlF/fjPCN88aeKmFGwDjEZkTbuIR4BiyTBVAXqHGv+H+3R9Mjt8JBwPtUoP
         s1dhuGhdOe2l2yz/+JPu2W6sD3MYRzlKCHH/Y+qXjH+Aruz8AiDkuGROnkYoyFwjEr6v
         1wdX6SUeW59NCRGD/WnZHmOPxfkcjwayBjKTIchKBBLtT+P6/iADFFPYnx4//nG0db+j
         GtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B184jFapKUoaCmeCoLa/RY1yl2o5xLb5T8mZ+GEtvMc=;
        b=ZICkMVceimrlF0SnZVk6cMbkuyRUrxvCkoo1ElC5Kl2D/EogSHXWAW+Rnz3+R+noC6
         KECifiOgEJwhscbzNF0g/80v4FIirZqkrRw+PNtdpWkzowNJSOl2lwxrLFkZhH5gtFkh
         tF0oGkr5ARRDJQksM+/hY760p7qMkrT2AtBGDFM/WIqADFd3o0eHlk/YmrvFs1HUwfIq
         USlPzipwxqeLEnS7QrQLozLTIglwjrJEmu9+NgXFIfqc8NRcsfnuJZh+UCUPtdEqnt3v
         9IXrSG7sNJobna6RPV/6JQztgQDtJSrYbIf9d+8J79f8lcDk/j2sEdtM69Le2I/NGUxJ
         uf3g==
X-Gm-Message-State: AOAM532xUFLu3resCI7gMBtpaf0i5mDIZX9wyRiwCqiztm7G9SI2YbNI
        EOmKz7C3YTg/8nqjdJJilrrQa7nCOnq/vA==
X-Google-Smtp-Source: ABdhPJyoASqFatmoRBFJhD6xsJLll7K5Y++9lZk9wFHgaVQ3B0ZBvKxlt3zqwehgaWMNAUDMO645EA==
X-Received: by 2002:a1c:4c11:: with SMTP id z17mr409412wmf.0.1642591889196;
        Wed, 19 Jan 2022 03:31:29 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id a20sm4778049wmb.27.2022.01.19.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 03:31:28 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.17-rc1
Date:   Wed, 19 Jan 2022 12:31:26 +0100
Message-Id: <20220119113126.1244615-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.17-rc1

for you to fetch changes up to 3f0565451cc0c5158513af0bc4e91aa8fb0b5e75:

  dt-bindings: pwm: Avoid selecting schema on node name match (2021-12-09 18:17:02 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.17-rc1

This contains a number of nice cleanups and improvements for the core
and various drivers as well as a minor tweak to the json-schema device
tree bindings.

----------------------------------------------------------------
Thierry Reding (1):
      dt-bindings: pwm: Avoid selecting schema on node name match

Uwe Kleine-König (7):
      pwm: Move legacy driver handling into a dedicated function
      pwm: Prevent a glitch for legacy drivers
      pwm: Restore initial state if a legacy callback fails
      pwm: twl: Implement .apply() callback
      pwm: img: Implement .apply() callback
      pwm: vt8500: Implement .apply() callback
      pwm: img: Use only a single idiom to get a runtime PM reference

 Documentation/devicetree/bindings/pwm/pwm.yaml |   2 +
 drivers/pwm/core.c                             | 139 ++++++++++++++-----------
 drivers/pwm/pwm-img.c                          |  35 +++++--
 drivers/pwm/pwm-twl.c                          |  62 +++++++++--
 drivers/pwm/pwm-vt8500.c                       |  57 ++++++++--
 5 files changed, 213 insertions(+), 82 deletions(-)
