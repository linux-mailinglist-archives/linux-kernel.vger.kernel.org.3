Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FC646851E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385092AbhLDNsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbhLDNsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:48:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CC5C061751;
        Sat,  4 Dec 2021 05:44:49 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 133so4647424wme.0;
        Sat, 04 Dec 2021 05:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=II3JUmnxlDylRM1/KBirxDwNPlaDfNA2La0jNZX/n04=;
        b=dBMj39/SqYigfA7mctGBjob/wu6o9t+8AKP91V/QpvpKfqFTKi6otEMaXPTqHIibRM
         Rq3U2VzD/QmUO9RLa6lSdFV25+j0A5wveQ1H1NThW6LW0nwWB9hFXkq9Vstb7XWdIgUl
         mo6NaEwi2Zdy/TTSPezhYmTqDiS/S7TFb17CBFYG39jiodbvCyfFVnB8quG57KhblfbW
         BnmbGKQMCrFPhtJAgn+r579bl69uAj0M7RrDnmdTMxsvb2nHJrUFsToq/TqafI6O9G4N
         2hSczmilr0EzQitOgC9t2h9lkvcsd/7t2lqSYljHps99qhnD8UmpF/KXIXUL63zyOS7K
         AisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=II3JUmnxlDylRM1/KBirxDwNPlaDfNA2La0jNZX/n04=;
        b=zb5xN1cKPcA57st/TWLkcsbtDAgRkjsqpxU1IPh2nWXWeiUiFvHca230VLKkO3JUV0
         leusFd54rZu9GZJz1a9EO3tjCk+8VsHwHHT4b9T2ysa6179uD/IE0fiyN7AOF34wrvHm
         8VoIjJIepicosUQr/YjjprfYi+qz96Zdm2z9zlzjutHmElB3SCfTn2ZYXaBkL5KlsF6k
         c54nUhsEtQ/VRklEiCU4uhEKiOD8gbkliCXzbZprN5PyrVIhGAbiUstEOTkZ7oFALP+z
         XoANAC5J8cshuiHQa15YXtgEJ32vnbT5E84dkO+5Bc+GKv+QpZik6gA61kcz/2e0o23v
         5xwA==
X-Gm-Message-State: AOAM533Lfeb3YWevZJunot++TLNLKTU5UwESmyZv2xMDPjjvyZGOUBaq
        WjfdfbV5cUAIjQftJUJ8DLxUGX5d03ojvQ==
X-Google-Smtp-Source: ABdhPJzTHlAFoQ+zevciQOeZpVCZrOY7a1FT7UjBymV4cxxy4DQpiQ4CqBwI/lphLsLrDeIovoB5UQ==
X-Received: by 2002:a1c:43c1:: with SMTP id q184mr23355584wma.153.1638625488225;
        Sat, 04 Dec 2021 05:44:48 -0800 (PST)
Received: from fedora.domain.name ([95.70.244.110])
        by smtp.googlemail.com with ESMTPSA id r8sm7132139wrz.43.2021.12.04.05.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 05:44:47 -0800 (PST)
From:   Onur Ozkan <onurozkan.dev@gmail.com>
X-Google-Original-From: Onur Ozkan <work@onurozkan.dev>
To:     trenn@suse.com
Cc:     shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Onur Ozkan <work@onurozkan.dev>
Subject: [PATCH] tools/power/cpupower/{ToDo => TODO}: Rename the todo file
Date:   Sat,  4 Dec 2021 16:44:39 +0300
Message-Id: <20211204134439.79754-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed the to-do file to 'TODO' instead of 'ToDo' to
comply with the naming standard.

Signed-off-by: Onur Ozkan <work@onurozkan.dev>
---
 tools/power/cpupower/{ToDo => TODO} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/power/cpupower/{ToDo => TODO} (100%)

diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/TODO
similarity index 100%
rename from tools/power/cpupower/ToDo
rename to tools/power/cpupower/TODO
-- 
2.33.1

