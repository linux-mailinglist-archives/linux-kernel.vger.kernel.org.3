Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D944E95BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbiC1Lw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243590AbiC1LpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:45:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55668FD05
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:40:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q5so18755294ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pKf7PvevJfYatf3Udsav0t2VcxmPjbATHbgBbAFSPFc=;
        b=qTGkIsJ/uDIqj5i76EurdCIlZia23YgiDp+oxTekYLYcNB0ApgsrI7r0JI7T/j3MGf
         +HWpVWQ/si+nI2ZBUhrC9+lU9Sa1gKlzP+MFUGbR72dFSQl2h4A4cid/tlKR10v1ljq/
         83bUJUMkEHJRGxOKUHxxz/sglxuFJUs3eQCZ9MpbwNqSU/Lc7MlQCI265FRQwezh/Gmj
         RuFGWon6JyUSSYf0Z0Rbvj0+o+cfi/73ZroK95vM6tFQZZ4FOC/CDpl6SNHssR00HqDF
         vWq1SbbYuj+yi+Yh55linEIsfSaKh13O75oDH/vxMS7fmyLw0vfc+CZnfwgUAEVQ4XTM
         tYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=pKf7PvevJfYatf3Udsav0t2VcxmPjbATHbgBbAFSPFc=;
        b=oCB5m3mMMsHCN3sLgSvrPWi7D5hkjJqyypoHVxCxo2EBmb2oa3gOqNp6shHReKggHh
         Ctbd8M0/l4aalSFTv89XCYjgDH9jmlaHcUjbej097cqTD5RIkfk7FHmgtPYtWP1XRbj/
         WZ6rcEUS6/jU8Bi5vHefneHkwLAJmCFCGoO6YFkO0tRbkF1dzD0ZzySesPuafwjMbmST
         MhDuWPQkO81ukBzgpsHhboACqJyIHjz8wA69cVSrTaXl155rYS2ab75IkllliJ9sqg4O
         hD5O00WZECPYaF53pbHFR41Nzqtt/TUVjnA3ZEEQNEuyplMw5pVeGdaNrwYKrv59Bno2
         qvUg==
X-Gm-Message-State: AOAM531IuIRTlbalAIRmi2qVPTGnvPR1j3WZ/YP471Xp/rTZcavnerNq
        MNxF4KzjcNjtrd9GVMHkyFJt6ZIN6rV7NVVs
X-Google-Smtp-Source: ABdhPJz5KibnA5f1yoUJ4qnG1TNNpGT8/5xANhUPJtLp7Nx+/dqUb385Uu4UlkigBUXYs29qUzdYtg==
X-Received: by 2002:a2e:a786:0:b0:249:a13d:d67f with SMTP id c6-20020a2ea786000000b00249a13dd67fmr19705606ljf.457.1648467650706;
        Mon, 28 Mar 2022 04:40:50 -0700 (PDT)
Received: from [127.0.1.1] ([2.92.192.17])
        by smtp.gmail.com with ESMTPSA id y18-20020a056512045200b0044a35fd9945sm1613361lfk.23.2022.03.28.04.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:40:50 -0700 (PDT)
Subject: [PATCH] mailmap: update Kirill's email
From:   Kirill Tkhai <kirill.tkhai@openvz.org>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kirill.tkhai@openvz.org, ktkhai@virtuozzo.com
Date:   Mon, 28 Mar 2022 14:40:49 +0300
Message-ID: <164846762354.278960.13129571556274098855.stgit@pro>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My new email address is kirill.tkhai@openvz.org.

Signed-off-by: Kirill Tkhai <kirill.tkhai@openvz.org>
---
 .mailmap |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 97ccdf147111..4129fb2482dc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -212,6 +212,7 @@ Kees Cook <keescook@chromium.org> <kees@ubuntu.com>
 Keith Busch <kbusch@kernel.org> <keith.busch@intel.com>
 Keith Busch <kbusch@kernel.org> <keith.busch@linux.intel.com>
 Kenneth W Chen <kenneth.w.chen@intel.com>
+Kirill Tkhai <kirill.tkhai@openvz.org> <ktkhai@virtuozzo.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
 Koushik <raghavendra.koushik@neterion.com>


