Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5515D48BDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 05:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350609AbiALEWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 23:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiALEWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 23:22:07 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D645EC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:22:06 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso2406737pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=BdvQPS52cJCNcWplkVhU9iiTtx8MtjvpdiuiGOuSq7c=;
        b=IPTmv2sMvu2/Ii7lbwvMVlK7zNawN3QrAIJD3UoHGH9sQwghFkeyifRl3xy1fTfL8/
         mIB9vswiFwfCbAHX+Kict6Q9A/iVn5UOYEP6tfbofSeWJeT+WXA9pIKG4epBfaTGZdYQ
         zD3lZhsCTDKngJlULJqK1LWS6a8pLdOuFGla42urcXi3WzJxatr1ui/n/i5blr4cbUan
         hjmU2FLmlSZic4z1kpo0gG5VUJwagSGwW8LmyriXvAfI4CWz9ZX+VvVDHuXGFSRLkUda
         pT4bhEkeIfuATtBp1JRdJyX9+rM2mLnQw/CsgQNgK+KGtJV3jnbmJuyJwU3+M7joFwIe
         RedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BdvQPS52cJCNcWplkVhU9iiTtx8MtjvpdiuiGOuSq7c=;
        b=tzjrTYaA+dvZg5ft0tV+OXzg3DWtI1MQ5LjX/kg9WMvOnodDinNLs3lVIM8kcqnH8D
         +RHEelzQSL67buD3nk2/11l6+I4CkPUI6VQwVJXT7wWwa8JAWHWGgmu6k+Z7gKzS3wel
         /KKUxQQnl5s1Z+PLi+UP75Kt8i0cCFIX8xRx2RYU6Z10rmGuGpKQNnUJktuVA2RbR1OJ
         tL+ZMVjB/1iGLxE1UXoh6FEd83iue76Md+0vipsVJ5QudO0dYaKfkMOOVaV8VZmlLI/n
         hnE0C+aVfKstEPAO5JqwQ2KXa/2BJd10MGyYVFOiDjvmpXpqcOENrsBUAwuMeLZfz6V+
         xHBg==
X-Gm-Message-State: AOAM530Il+ErjVHppkIv/DBRzrcPRIJGFIkRGk6k8Wut3qDHvkpn0G9f
        Kr8w/lPZa3/K7vBXzUPCL40=
X-Google-Smtp-Source: ABdhPJxosyTXf4wce0Cr2Cv0vbps8/hxqDpRi17uliRyVjyEWDVgHN1j33lCIOqlM4BNpHiKVpnc3g==
X-Received: by 2002:a63:7156:: with SMTP id b22mr5086937pgn.288.1641961326343;
        Tue, 11 Jan 2022 20:22:06 -0800 (PST)
Received: from localhost.localdomain ([115.99.137.58])
        by smtp.gmail.com with ESMTPSA id t207sm11237747pfc.205.2022.01.11.20.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 20:22:06 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jagathjog1996@gmail.com
Subject: [PATCH  0/4] Staging: rtl8723bs: Fix codestyle errors and warnings
Date:   Wed, 12 Jan 2022 09:51:57 +0530
Message-Id: <20220112042201.5056-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix the following errors/warnings:

-Placing { braces at the end of same line of if condition
-Placing constants on the right side of test
-Removed extra spaces in declaration
-Placing necessary blank line after declaration

Jagath Jog J (4):
  Staging: rtl8723bs: Placing opening { braces in previous line
  Staging: rtl8723bs: Interchanging comparison expression operands
  Staging: rtl8723bs: Removed extra spaces between datatype and variable
  Staging: rtl8723bs: Inserting blank line after declaration

 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 42 +++++++++----------
 drivers/staging/rtl8723bs/core/rtw_security.c |  2 +-
 drivers/staging/rtl8723bs/hal/hal_intf.c      | 15 ++++---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 40 ++++++------------
 4 files changed, 44 insertions(+), 55 deletions(-)

-- 
2.17.1

