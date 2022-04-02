Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6D04F012C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiDBLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiDBLjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:39:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2105520D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:37:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d29so1563159wra.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4EOXThxF+MGi8ejb9b6d/qQvr3UdpXe4etGNsWqJ3g=;
        b=WZuCEDVw2LR2yQ6AETsIWibNMg24Vzpx4X2HKWmaAWU9RK+r5aha6LWedcPfVnU97k
         phramPP57zS7p5Z34plHcu/WNXpoxe3J3+4pXtQuPEC/3lxOjILTnqLVK73HVomtW+iw
         1ylwZz6prPaTaGbrW7B7BC+o6lgovyRJHMcLwQ23Hy/5+ry44puUwoj1/wDp9VEKBP+A
         hUeeWC8BFsp7chwGoGJdfOGO7+aBYiXrVbu004EaP5hdzv9jT2mRTb5iOmwcQHzHhXp+
         s9tQTnP9HyygGEj/Ucc3nOjdxkqm7xN5o+OuhFPMzosj/T9HruPffwpPx9CcDiKxHeA7
         IYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4EOXThxF+MGi8ejb9b6d/qQvr3UdpXe4etGNsWqJ3g=;
        b=xYvssshqX47S+608fcgkwfNKxd93UmUI59BYyLUibpjU8TSsllBGzqkqHh1JaKmZYG
         mzk4NmcOsfCsFN9f2cMgqzTPnvbGX03m3IscMc1d/knrnOBgJc3zMLFUUW631+7gNcTQ
         AfCwuuEAOFs1RI10TvokRqqp6hYAW/ZR/aK1t+tNVqpGti/dutdIHZ3tUEze1NeQ3LD8
         k/8NmilfYNit1PWPo5CwSpclh8F0tTLhgHc/m5rnPmOxCZl4qYf+oZiSvUEPPul603Rz
         HQqupjD+v41uToB9CCOt+FvA93Wi7UbVUuwpDSKgtYmqnIAiAAwj0JUaVJtRsh620Gss
         vylQ==
X-Gm-Message-State: AOAM531QOf8Zmm+nE5bDHmI4iV/TQdDUxx6pQ+D7ezE7g5X2vWh0Gtqk
        Zg6+9ERAQxVGNkOv+MZzY7o=
X-Google-Smtp-Source: ABdhPJwOIxcjt2ql8oFYOoOCVYT4/ctN3MdOJclpNzO7UTpg6OmIerqRPhm1nZp+rLBDjPMgu38cuQ==
X-Received: by 2002:adf:a450:0:b0:206:b29:2425 with SMTP id e16-20020adfa450000000b002060b292425mr535780wra.90.1648899465654;
        Sat, 02 Apr 2022 04:37:45 -0700 (PDT)
Received: from alaa-emad ([197.57.138.121])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d456b000000b0020406ce0e06sm4348812wrc.94.2022.04.02.04.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 04:37:45 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH 0/2] Fix coding style in cfg80211.c
Date:   Sat,  2 Apr 2022 13:37:31 +0200
Message-Id: <cover.1648899123.git.eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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


Alaa Mohamed (2):
  staging: wlan-ng: Fix Lines shouldn't end with '('
  staging: wlan-ng: Fix Alignment with parenthesis

 drivers/staging/wlan-ng/cfg80211.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.35.1

