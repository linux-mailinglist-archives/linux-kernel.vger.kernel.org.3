Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED84977B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 04:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiAXDpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 22:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241061AbiAXDpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 22:45:01 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4DC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:45:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d1so14250735plh.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=dvwTLzMIYV8rIX2vp2D7TYVhSv3EaE9p1XD2xRzEULA=;
        b=lT+R58S0wjQMnjEW48O9E8XXmIHQ9F+yHZgkJw35WHAmFdvtMn1szbHULjQnpjT68M
         PfVNQFxaFgZ49gnUxNg6EOn1J8QbkEUkvlJaoxRVj85FCEp6ZOa096U3b3Mb95KhUjoI
         ctpzXfRlPmOw7K6EPOwDeg+vUCfguqJRQny6tbXO4RIsLWjBJEaEU6I8U0rV/ir2I7/z
         AmXmkaMqDTbXx7rFL/4hiCuWgAf8atkyGTW9Qz42LXE4zDcH4PeMxZaKuJAtHJxJ2Rhz
         lsRehL2kra9WQ9rsMO5KscghXTUxD2XGQ8aDEJ0nG3GHgvbrjA0AWL176lFhRCaEa/Rs
         X/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dvwTLzMIYV8rIX2vp2D7TYVhSv3EaE9p1XD2xRzEULA=;
        b=cwPeJkZf7R2Ys8UrKO2Dr4gGfrhhe2hJhgwxrAqXR4u23KcEHCAlOidf3mT68zcDdB
         j4V2DkTFUQAselyNcwrwltQwpr8x7/j2E2GgnXpqow7/J/TenxjalQp/mB4IaMKHjrX/
         svdTzwXnC39VS2pS/XJzKyBU34je05n3+X1PfbfjyXlmcq4TgkeUjnZteGUyfc81hMBS
         bRWFeD//1ueo+eLJW7Rv3eBkCJTCrT1QJyaXesPeMuwP+pFDF9LxOJ0kAW/D+BTRbdfK
         Oy7JwsDmgFciBvpVLNc4zuix0+wYryuqX0zqLoPegb95Ec+HSHheLRJgIGAYeIJZtMSG
         DLew==
X-Gm-Message-State: AOAM531vTScKhwSpDWIjxhRigM01ye/c8CDd3lBplZRKrUBbQ/V0GFwp
        JMEC3Bxub8K8Heomoi8N8gPa8nGKiQFyMQ==
X-Google-Smtp-Source: ABdhPJz+zSvrtPXD+6KPv7j0xG9F61AIZUg9TVfs/O8kB4VB/6qzzaVsXis1oJRYSOxqSJ+B7lnlnw==
X-Received: by 2002:a17:902:8f91:b0:149:87ff:ac85 with SMTP id z17-20020a1709028f9100b0014987ffac85mr13052389plo.162.1642995901227;
        Sun, 23 Jan 2022 19:45:01 -0800 (PST)
Received: from localhost.localdomain ([27.7.142.194])
        by smtp.gmail.com with ESMTPSA id p38sm9853390pgb.36.2022.01.23.19.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 19:45:00 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     fabioaiuto83@gmail.com, dan.carpenter@oracle.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, jagathjog1996@gmail.com
Subject: [Patch  0/3] Staging: rtl8723bs: Fix codestyle errors and warnings
Date:   Mon, 24 Jan 2022 09:14:53 +0530
Message-Id: <20220124034456.8665-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix the following errors/warnings:

-Placing { braces at the end of same line of if condition
-Removed extra spaces in declaration
-Placing necessary blank line after declaration

Jagath Jog J (3):
  Staging: rtl8723bs: Placing opening { braces in previous line
  Staging: rtl8723bs: Removed extra spaces between datatype and variable
  Staging: rtl8723bs: Inserting blank line after declaration

 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 54 +++++-----
 drivers/staging/rtl8723bs/hal/hal_intf.c      |  5 +
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 98 ++++++-------------
 3 files changed, 63 insertions(+), 94 deletions(-)

-- 
2.17.1

