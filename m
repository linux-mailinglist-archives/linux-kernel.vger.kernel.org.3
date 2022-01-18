Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAFD49285D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245504AbiARO2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiARO2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:28:11 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DBEC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 06:28:11 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bb37so1044907oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fkJsmeB7165f0SJ65+JtHacZHTvcYLO9yyJUgbHYpo=;
        b=BdcgUkDj8SdYSXsSJgPL3zm43cFGei5vVUZOKBAg0Rqt+mgB1Aw4bn9q0sffU8VF8v
         QzD6PwcTCmg3kp+nK8HVxFAO17Tdb4MP+EhOTCiApXy0ONIbFmITQGp7qsjPjswljTDu
         iIpUHaLSBf5aeqD7fR6y2nXFMv2JwZakNy15X8WbgUMor3fPfQcpiwSupIlZMDavdsBy
         vS5nKVco4rmJH7f+8XbFQwCuUWD0YWGgJ2mpPbSwheCSnHb8phHbgvrlHaHk1je/Izd5
         dqpTmDmg/mfCSDYRQR9jVdgfHl/F1i8TegoJC0OINDPfzvHcyN1ksqfafBX4mWzrnSPI
         +lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fkJsmeB7165f0SJ65+JtHacZHTvcYLO9yyJUgbHYpo=;
        b=HUlK5crmK0A6B52zjidGIMdiyoeNuH/vxvij07/3+l/wHIOcpVl7CVIRWeld8OKGGO
         mMwfJBAMcFxhR1r4Tv1tZv6Xz0+YxbnazzzdBO7xcixyRUqh0Dzqr9lU1LH+AJkFKN/9
         3rt2PEcU2jv6yzgDh1J52E3tTjB+H5E2eEhHlIr+vcb3wTgK6uYhbtsjT9LVaWLwG+Sc
         dzQ53xeTFSyhiMQYS1qydy5UFXawYSNtyL4eJ9bAMl/k6j1IQrU648p+1pW5+ds7l3U7
         528jmRy/PrpAcC5SsVqvVvO4QVJOIv+8pyUNRt8A9Nvoq16mYW8JFimyxgBIX2Nlky6M
         G07A==
X-Gm-Message-State: AOAM53216ar5iKwm8qiHBSlrHKgUFWjzlShO6RZ1sXBOR+LNxn9N10du
        epQq9+v7n6eNuL3nyzdVb+LWUw==
X-Google-Smtp-Source: ABdhPJwG70L6WOC4NLSIi6zQrjbwiaKOI6CLkQeMbsIFP1dM7e3U9RPC+GHM028Q2rQDPmlE9afwjg==
X-Received: by 2002:a54:4e8c:: with SMTP id c12mr26670097oiy.65.1642516091047;
        Tue, 18 Jan 2022 06:28:11 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id d12sm6335477otl.80.2022.01.18.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 06:28:10 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@foss.st.com>
Subject: [GIT PULL] hwspinlock updates for v5.17
Date:   Tue, 18 Jan 2022 08:28:09 -0600
Message-Id: <20220118142809.1751011-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v5.17

for you to fetch changes up to 60630924bb5af8751adcecc896e7763c3783ca89:

  hwspinlock: stm32: enable clock at probe (2021-11-17 16:12:44 -0600)

----------------------------------------------------------------
hwspinlock updates for v5.17

This contains a change to the stm32 hwspinlock driver to ensure that
the hardware is operational even without CONFIG_PM.

----------------------------------------------------------------
Fabien Dessenne (1):
      hwspinlock: stm32: enable clock at probe

 drivers/hwspinlock/stm32_hwspinlock.c | 58 ++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 21 deletions(-)
