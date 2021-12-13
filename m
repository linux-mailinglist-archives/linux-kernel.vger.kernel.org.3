Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55792472FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbhLMPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhLMPD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:03:29 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3743CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:03:29 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u80so15154145pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcuIIwM21mt54zGJHA+4pqfR543ASriY2mOZaxIXjfA=;
        b=pFsBhS2rnzevLjvnqVEVMru6imiIeU3HBr2BvpZIsd6mmJNvOsOfRfLmokKxZ4fLF7
         nYbZ58AU29SUKzQ0U8y0CR++EvZVKEscFF/fD8omLvE3GfxPGKjXI8CMuwXNslc6PFNU
         3ufqWRwHv3oNg5hyp9f0A9o0VU4KEi9OtPXN7DMs0XiISbUQHif8tYC66C5UO65egs7w
         Y42SPWznjn4RG8j53rfmxKZrkh87dlY7heynKNCveWlYg9u9P7klUfrk1aCZFqCDCtQD
         i7+CWGesvs6Tbszjqw5bXhjIb25mpwrwWbeZmxycing4xhUW7ggsBm3PvAyEdRrBEG0F
         K4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcuIIwM21mt54zGJHA+4pqfR543ASriY2mOZaxIXjfA=;
        b=L3wM76ZKXBUIW0pHEE9XHXfaZgHnyBmC/kzEoN3X6Ga4fWAF1Ak+wCmXp/62O/1FGe
         f8X3z8S3jWbqd3G8LW7YMNtKZVoX4S33nRRy9CzpkUed0cc1Axc+62cL9ZEdM2F3ODxZ
         u/gS4t3/RaWxOOGV3pv8Nw3Vig89wbU3UAzaTX+3yR6pwIuhyVy+2QJYK+1HELfcEw68
         /D9AVQPZIrGS5rvW3j6PBWd87xbOlNSz+OH0YopOjp+5+uEq4Ugy0r9/mBazk2ZHwcCY
         c8GKj+Ipm3tq+CQkX6Jh/ffsoHjyXpijVjVCVySksIZK3SfjJ0updixpQ7Yo70XCcR6p
         /CXA==
X-Gm-Message-State: AOAM533PEd/0Eu/U+0ibavKtwCzAt1X4BZ0hXT7dO+G/ZKbWeuQwkGLz
        m6s61XSSKxrksrUYMZ3Y4/4b/k1sVZ644g==
X-Google-Smtp-Source: ABdhPJyWhSm36CmKHRFkp8svS5LxjnOI9dWyON+PznBNP0rWM34eI5/YKT7J+0Vz4E0zxUpzv3VwTA==
X-Received: by 2002:a05:6a00:882:b0:4a8:342:659c with SMTP id q2-20020a056a00088200b004a80342659cmr33667422pfj.79.1639407808532;
        Mon, 13 Dec 2021 07:03:28 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id k5sm6476368pgm.94.2021.12.13.07.03.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 07:03:28 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 0/4] x86/nmi: NMI cleanups
Date:   Mon, 13 Dec 2021 23:03:36 +0800
Message-Id: <20211213150340.9419-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

These are very simple cleanups for NMI.  They make NMI code a bit
tidier.

Patch1-3 are picked from the patchset
https://lore.kernel.org/lkml/20211126101209.8613-1-jiangshanlai@gmail.com/
which coverts ASM code to C code.

Patch4 is new.

Lai Jiangshan (4):
  x86/entry: Make paranoid_exit() callable
  x86/entry: Call paranoid_exit() in asm_exc_nmi()
  x86/nmi: Use DEFINE_IDTENTRY_NMI for NMI handler
  x86/nmi: Convert nmi_cr2/nmi_dr7 to be func-local variable

 arch/x86/entry/entry_64.S | 52 ++++++++++++---------------------------
 arch/x86/kernel/nmi.c     | 16 ++++++------
 2 files changed, 24 insertions(+), 44 deletions(-)

-- 
2.19.1.6.gb485710b

