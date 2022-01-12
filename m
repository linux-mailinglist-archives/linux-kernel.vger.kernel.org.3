Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B125848CD65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiALVEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiALVEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:04:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC6EC06173F;
        Wed, 12 Jan 2022 13:04:30 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so15208837edn.0;
        Wed, 12 Jan 2022 13:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ThSThbm8jqTBBe76oP5BA5XU5DKB6LNTnemsUXlyd9k=;
        b=e6898xcMaQpjMVu+ZGiATJxhdy5xqw7eQ1tsd9QfsGmeOLvoQu2tGNeo40hMWRj9sZ
         3N4NVXyMrBwJVxvubIpae0FIqxuwcC6NlR2SgrzCO8Spde1xmE+xii4OBhZ4iKwe93Nv
         KwoD3Bn7iu0d4l3aZSQ+wheICK6VXMdYWoN6R3owGdKlMfpX+A8Zi/Woz6RpxBdxW5P+
         VdPPlPSKi/GPNoWRzbyqp0e4bLB57lN++NwZeQocLGgcL+agnVKHctOkR+33s7wVUrY3
         JQryFRtYfd8zj49HbqwmfG1GFcH80QO62uV6oIxfvJXG1r2HrN3cJ/noWYT8CZyUKBsj
         T+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ThSThbm8jqTBBe76oP5BA5XU5DKB6LNTnemsUXlyd9k=;
        b=zhK19hUId0wpxhO5M7jC80j9k+4XMQaxITqhTzz67UYEV80sF3j5wMjAjb9ic3W1nt
         TQ7YTG81MAch2R89EdySsptjXywITkTnP9mAE4gp9CK9JCEEc1/t6EO2Fes8RUFmzHLJ
         KfBLXhbWUiDLsLJ4FttNjkTwY0p0m+/uBqG0d2PJYNNKCUH45+oE/HoDCNtEuteYiIeD
         D8ENdrYGjrvRPX0TkXlEqCotyMWOkdtcJMs45/CPbMKEFoyXODbfaX+XeE8XI/RMhNzZ
         y3bhRQoZvNzD/aMLJLmtdk9lK3xC6fplDw45Sz9pukwVPpYy0cse6HtGpsJel4q6Kgai
         4Lfg==
X-Gm-Message-State: AOAM533eN1TCaBYLX9sUVZhURXvsCiGYw4nuLmDJW/Ey0j0PC8uNrlyK
        Cjl8wlZO+J+7nltOV82ux4U=
X-Google-Smtp-Source: ABdhPJy8iKKrvRUJo/qE1rl6DMNo8JFJCgqk8SUjzVg1qL4iuYXL8BFC7QikelgLdaetoBZWsx9FFA==
X-Received: by 2002:a17:906:274f:: with SMTP id a15mr1171154ejd.492.1642021469427;
        Wed, 12 Jan 2022 13:04:29 -0800 (PST)
Received: from fedora.domain.name ([95.70.245.190])
        by smtp.gmail.com with ESMTPSA id o8sm333930edc.85.2022.01.12.13.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 13:04:29 -0800 (PST)
From:   ozkanonur <onurozkan.dev@gmail.com>
To:     trenn@suse.com
Cc:     shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ozkanonur <onurozkan.dev@gmail.com>
Subject: [PATCH v4] tools/power/cpupower/{ToDo => TODO}: Rename the todo file
Date:   Thu, 13 Jan 2022 00:04:21 +0300
Message-Id: <20220112210421.37254-1-onurozkan.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed the to-do file to 'TODO' instead of 'ToDo' to
comply with the naming standard.

Signed-off-by: ozkanonur <onurozkan.dev@gmail.com>
---
 tools/power/cpupower/{ToDo => TODO} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/power/cpupower/{ToDo => TODO} (100%)

diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/TODO
similarity index 100%
rename from tools/power/cpupower/ToDo
rename to tools/power/cpupower/TODO
-- 
2.34.1

