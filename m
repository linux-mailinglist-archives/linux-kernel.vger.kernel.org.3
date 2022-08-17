Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0865978E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiHQV2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiHQV15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:27:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF395AB070
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:27:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so1660421wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=xb6yvMg/5+ZmAzRi09/O29dbL3v5n6oRPgJ/b2a1u0g=;
        b=i+CAGtVtpnRaafgVSaxm2x4tf3LLsFPScZIVdI/n+KFT7qH2g/kF/RVSZqcc+D2YxW
         NtkbhtmYYmcDAEyKQZBsszQzkgjf4d2K4rPIS0jwsM59U9DJvJu8r13Ax6XMazoRysUd
         TFrniDi9gvx4I32S7ofrCsZ5ERfMS2bR3rT2KPxmmTu25cbTRCSk/HawixAkAcNRmxes
         Mtvr7dAiz0m6+8i5fMa80flmgjGPUILg5m7bTgELHa4DjJZwD6WZhRmHGPDGhEbI8TBw
         1YdXjuRjuOUpYnziIACRhBwhtZpEIaG5rKRV22oBiAQi0hPf2SkjrjKck8fdN8+LP8mL
         t5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=xb6yvMg/5+ZmAzRi09/O29dbL3v5n6oRPgJ/b2a1u0g=;
        b=aOKN4tdAurZIMI9avlEtueJrhbbgyTYn2t0tK55Cy57gE0syV518TJnNNucmjIj2X1
         DdVUZPfIWaDXWesTrO+PaKZLtuYQuHmIGtnPhCLOUzYkoas6TGyn4QQLb8jkYgqRbS0a
         D4JJ8ws2t4xp9RaCRNDYm2ucZ9ezmYZr+i8/k5zixqCf3FlYXN2oH/mkyC++stI2WOhP
         9e/X5cukcU7TBorpMr5a+5MsMd6jcipIkYg4JKNdCifJPoWSpgvoS82sDggKdSe9eved
         ic8nXLq3skcLlPC2lJNqxyZpYrbP0ihBN4R0Md7Z5P50aV9l/PL/hXWQsygOLT0pzqJj
         bMXw==
X-Gm-Message-State: ACgBeo0Gu9DoPugWZKfA0ZOvng7YcsomcObFmXugiW6SYRCBvOWX8WaQ
        jWwdjSrliZ9AkjdZgTtPgQZ/D/ZwJBk=
X-Google-Smtp-Source: AA6agR4VR+hymEnj9PuROuCLqQEscn85Ox8moBLzjbU2gSO/4n/e32GFYDlh0t3+cCJQa8LxteF5/g==
X-Received: by 2002:a05:600c:1449:b0:3a5:3973:55d6 with SMTP id h9-20020a05600c144900b003a5397355d6mr3349971wmi.89.1660771675181;
        Wed, 17 Aug 2022 14:27:55 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c05c600b003a604a29a34sm2861829wmd.35.2022.08.17.14.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 14:27:54 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: update email address for Colin King
Date:   Wed, 17 Aug 2022 22:27:53 +0100
Message-Id: <20220817212753.101109-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King is working on kernel janitorial fixes in his spare
time and using his Intel email is confusing. Use his gmail account
as the default email address.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .mailmap | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 38255d412f0b..0e0cfe986f05 100644
--- a/.mailmap
+++ b/.mailmap
@@ -98,8 +98,7 @@ Christian Brauner <brauner@kernel.org> <christian.brauner@ubuntu.com>
 Christian Marangi <ansuelsmth@gmail.com>
 Christophe Ricard <christophe.ricard@gmail.com>
 Christoph Hellwig <hch@lst.de>
-Colin Ian King <colin.king@intel.com> <colin.king@canonical.com>
-Colin Ian King <colin.king@intel.com> <colin.i.king@gmail.com>
+Colin Ian King <colin.i.king@gmail.com> <colin.king@canonical.com>
 Corey Minyard <minyard@acm.org>
 Damian Hobson-Garcia <dhobsong@igel.co.jp>
 Daniel Borkmann <daniel@iogearbox.net> <danborkmann@googlemail.com>
-- 
2.36.1

