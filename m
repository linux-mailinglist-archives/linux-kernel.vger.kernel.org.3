Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981AC4AE0EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384957AbiBHShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiBHShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:37:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F97BC061576;
        Tue,  8 Feb 2022 10:37:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so2367678wml.5;
        Tue, 08 Feb 2022 10:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOp/1BNAJMIaOdK8qmZtxyH1OAhIRwW4JSUFQ8sTpFQ=;
        b=LpHin/tn/wCZVi4KXiWgAFJTpMjpkQ6wyjwD0JfxXAAdlCpPGasV/rJ3v/OywadhQJ
         u1gqKk9+cWI7YFNRYQssq8fdB1yqrBIQ0IVPaRBp9zqYbNm67UtzQccoxHyq7l8lvMmy
         VMFy2Uc1logLW+xkeZozsQJISXV+pVxOBT9rKPnC9ZcJiFbTAYSANKQ97PhjSsLjICKh
         MwnCPnna3kOm2E9jX7dkvT4FnH7ydb4zQ7efFcRmjjUMZNRKTa6v49scH2pBVULDhk95
         nBHw3M8MMg4AbxAyWqFKd2B2R3vXT7Hy14dmH3pXX6AhTDMCfEESckbclCJxDDiG3elQ
         OpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOp/1BNAJMIaOdK8qmZtxyH1OAhIRwW4JSUFQ8sTpFQ=;
        b=Pe3aH7OTjLMG5HSP8X6jOS1r+2XUdTk/YCE4WrzdPpaS5E1bHc2BxH2mdfwTwaQRJd
         gioIBwD1+EIbYdY8YlKFC6c1kaYEmD72Poqgqx2Q41TAn05V3eYu28Hkp3p/gI92MKC6
         XskFZclo5e+o/38PHcdtMPsaz/C30mf7STV3UntQ0CAdWrS+WHy6Qxjb4MBEiSlnjaPW
         2urkV6hDv9hXaGKFL83rw4B8lx9fSYaWKNqVvw1wmjBRUjAHoCbeKwmP904gJEGzJc3m
         3JzpT/Mc933RfvXu7oBt9Jr5RebTeNfmZREQByX8FrZJNTblpmzEblDjZz21fc9Wcpu6
         4kOA==
X-Gm-Message-State: AOAM530JDz8rWhQf4+Zj96b1x1x09v0aUtyNgnEKO//XsLcNbrXTXK/x
        7IsyDJDERhxEWVUpfd07l5o=
X-Google-Smtp-Source: ABdhPJwES4dH9YcRG1gixZ5OkLe5XION1Cw915s0nBKgJsbxIksDRwcuK9kcHk6ry3B+zjIM5lG5uw==
X-Received: by 2002:a05:600c:4a17:: with SMTP id c23mr2188051wmp.27.1644345431038;
        Tue, 08 Feb 2022 10:37:11 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id l20sm2945308wmq.22.2022.02.08.10.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:37:10 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 0/3] Magic Keyboard first generation and 2015 FN key mapping
Date:   Tue,  8 Feb 2022 19:37:01 +0100
Message-Id: <20220208183704.40101-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This patchset adds the missing key mapping for the Magic Keyboard first
generation and the 2015 models.

Since the first generation model had numlock emulation in place, I
decided to fix the bug (described in the patch) and keep it in place
just because it has been there for so long that people might use it.
Having said that, there is no indication in the keyboard about which
keys can be used as numbers or how to enable/disable numlock.
I think that a patch removing APPLE_NUMLOCK_EMULATION might make sense,
but I didn't want to remove existing functionality without asking :)

Thanks a lot,
José Expósito

v2: Resolve conflicts

José Expósito (3):
  HID: apple: Refactor key translation setup
  HID: apple: Magic Keyboard first generation FN key mapping
  HID: apple: Magic Keyboard 2015 FN key mapping

 drivers/hid/hid-apple.c | 100 ++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 24 deletions(-)

-- 
2.25.1

