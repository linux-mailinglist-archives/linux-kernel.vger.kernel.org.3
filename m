Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E962F47E620
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhLWQC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhLWQCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:02:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6DC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:02:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w20so3383654wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Gmz+I9YOWUFBoJ3b8t5RcyDp1oBXQrMfwOu7m1+e4oc=;
        b=kCpiZ4Yxxr+HJMxmCAWeXSKoTq1bqZHJRB5MOqMrJDjJAXMKbgZkNezFgrT1Gx7z7V
         wYHjGQYjFA/Y9tzZ7dbqd12HQWp/vHPtCISZoM/A8kQkdCucYVbeMm3a7dvc775VrtEV
         FW+JhCBaQdvKJGUCC5xqOfrQm1bYkmvQwpNigFK1cDyBWg7AEfABJmQDiNR7StE3xzSk
         XrdAshoSqivvKTB5zH7RDhSn3OqvzqJ1R64JKh6op6L/d+suqqXHPNRV0IFBSK8uHCXI
         ZG5H+MGhNS84wqwksvH1W0rgktA8++8OjEvUHZ8foFBi9iufpSGCnXE8jBpxtxIAclAu
         s0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Gmz+I9YOWUFBoJ3b8t5RcyDp1oBXQrMfwOu7m1+e4oc=;
        b=laEjwLXwD86v1sgrZf+cke8Aw/85qH5wdx1+6QHAJXGoFegVNd5SnpA9qd2xgQQy4s
         /dlzdTAh5c/qLJDJ/Sj9p9pkgXz/YJYwLu3H09fUpocjmbJV9XPT88FDteXAvpG9JLTh
         JbA19XKfjX93RmOLBbopxzXWMMm7ide/jhiq9uFazTRnF+rrjgt2w7t8vAvJn64IePki
         2KMrH7/aFSup1rzt7f6S8Tk/FbVbH41YDgyGF6+SDwcMs6qq7gIpznhcTMsTAix/D56a
         FiNX+qEyPRcoaiCSWbAxtfirH7LW4E2S4cj5+A9ejOtozG0BNW+ZlDqcsbKE/e15tln6
         ib/A==
X-Gm-Message-State: AOAM531XiqtOp11KCmOFozY1uPXXDlyN4hVKu5dSOUX0fcbU+U1ZSfeh
        GsgxOhEJjwrNhtB1+SCjgNYPLw==
X-Google-Smtp-Source: ABdhPJynqNZQq5iIVvl9LNrEkjZokX6G2VkRE1WFIeLkjjKnEeMKchCyO6nXP2vIrfsIcpERCuY5YA==
X-Received: by 2002:adf:d226:: with SMTP id k6mr2074178wrh.243.1640275343827;
        Thu, 23 Dec 2021 08:02:23 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:34ca:f67b:b782:1949? ([2a01:e34:ed2f:f020:34ca:f67b:b782:1949])
        by smtp.googlemail.com with ESMTPSA id n9sm9545318wmq.37.2021.12.23.08.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 08:02:21 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] dtpm for v5.17
Message-ID: <ffbefd9a-5dff-5c3d-8a24-2d42b3aa42ca@linaro.org>
Date:   Thu, 23 Dec 2021 17:02:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

please consider pulling this little changes for DTPM

Thanks

  -- Daniel

The following changes since commit a7904a538933c525096ca2ccde1e60d0ee62c08e:

  Linux 5.16-rc6 (2021-12-19 14:14:33 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git tags/dtpm-v5.17

for you to fetch changes up to c1af85e442278fe120974358cf71c41bc48e0580:

  powercap/drivers/dtpm: Reduce trace verbosity (2021-12-23 16:57:36 +0100)

----------------------------------------------------------------
- Cleanup and reduce trace verbosity (Daniel Lezcano)

----------------------------------------------------------------
Daniel Lezcano (2):
      powercap/drivers/dtpm: Remove unused function definition
      powercap/drivers/dtpm: Reduce trace verbosity

 drivers/powercap/dtpm.c | 6 +++---
 include/linux/dtpm.h    | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
