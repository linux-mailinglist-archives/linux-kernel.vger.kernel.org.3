Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39E56361E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiGAOtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiGAOtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:49:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D832C6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:49:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s27so2569358pga.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BCU8tBwV7dKAMv2Q/+gFcUqrZxq5rWryWL5G4eU2og=;
        b=JZoMZBtPSWOfni4WXIdW0sBq/fo9s07HVGREtlQjpLh1UNmRzQ5AS26LCn7mH8r51T
         AZT36Owc9hS7rIx2qZPkDtFe2WlNHkHGo1IHcjK54JY4ZeDrIdtTYvOxHTZU88o75EvU
         6/WSWrsChD63sPRCtEs1KNnbLCb/gMvhdXr0bGmtpVKnVSggdtxGNeWq5hkbpqt3U+cQ
         dD+F7UOHXKB12XbBmwRMe1Lp+XA3l6maJv5UXoHlDxrbqmiVv26H+OtJCmbSiZMxZakX
         PD6c7WLWxx2N1EIGkdgvF0gOh2WEGxdl3ttGZJqHQAmUg+Yg9rpXgE7xeu1YJ1ulGUbh
         Ecew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8BCU8tBwV7dKAMv2Q/+gFcUqrZxq5rWryWL5G4eU2og=;
        b=sb4HUTjKIL//mHknT6x3S/6YO7nrsxFqiBvBn+k+MKlM83bocVcHdEc40yrzFrJxLt
         JMrUsfnQ7lHe4xdqzgC72C7dw6MlcSVAtQigzl4OeZrDZOI7w0zHaw4XuQS/ex5CA/Tj
         g9SU37HHDMQRW7iDcakxX02abOo+KRWSEHffIXebRpgxeODOg6KbOc9WiHidqneiv/Fz
         OQM4vYm2DeHARl5tEuEo0vWpQzS/NCqA+C1ioq7+N6zzioL6U4wiWe7AhP4VtKRjACJ2
         X3DoMCwW2DEnoWBeC7rpDIvwwF66Hn2PJX5ugyBEtgETOThE7gQFkYokJQa6oU8S8+GR
         F53Q==
X-Gm-Message-State: AJIora+5ZrO84b4s0Jckr0OB4H26bfZqYpXn+kmeSaCQ1L1vwzqxHZrG
        mScQcuKQ+DKpIBuyGJS3HhE=
X-Google-Smtp-Source: AGRyM1va10ykgy0jlmrGOYnU4/U5uHmwRoYtfc/m2piSKKUV3DAhYHAvq5L9Sudz3HuAcIuPcN5M8g==
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id d12-20020a056a0024cc00b0050d58bf5104mr20429691pfv.36.1656686989915;
        Fri, 01 Jul 2022 07:49:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bo7-20020a056a000e8700b0052515a79b78sm15517450pfb.189.2022.07.01.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 07:49:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Guo Ren <guoren@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/3] LoongArch: Fix build errors
Date:   Fri,  1 Jul 2022 07:49:43 -0700
Message-Id: <20220701144946.2528972-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of build errors is seen when trying to build loongarch:allnoconfig
or loongarch:tinyconfig. This patch series tries to fix the observed
errors. 

----------------------------------------------------------------
Guenter Roeck (3):
      LoongArch: page.h: Add missing include file
      LoongArch: Do not include file from toolchain
      LoongArch: Always select EFI

 arch/loongarch/Kconfig                 |  6 ++----
 arch/loongarch/include/asm/loongarch.h | 23 +++++++++++------------
 arch/loongarch/include/asm/page.h      |  1 +
 3 files changed, 14 insertions(+), 16 deletions(-)
