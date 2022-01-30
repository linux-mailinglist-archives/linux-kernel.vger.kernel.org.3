Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6C4A35DE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbiA3LMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbiA3LM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:12:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A69CC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:12:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id n10so20913675edv.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBqhdQDBJRGoBLP7N57YtbXFLEg4i5iAZLmqRoUPvx0=;
        b=dXIOQfjcCa9oro1DdBhyRD2GfQlKwq8gWPz/p4iWbpJM0ZEEHpoJzS1yTMgqBXRjwk
         1OIjFfyMSJOgAzZ/FoVjf6dTxMiMMi2Mma/QAwPmSJ98WqDxf+bGw9QxmegVp8oU+d2W
         uyYphjUt+0PzOvNjBjuSYUwTQNCXBL7fRRSASVevBQj5jAxeKhGIrjmNOCcb6j5Iqjrp
         NOYoN80lz2ychKggU/s5WUw3aTxtH4JRQb0xmey2FlHxapZIE/inGyLPtq91ubNsijk3
         wdaeA5QiazGsSV6/06HCWHebPNTb+KDPGoVKWr/Hhr1NNfAhAMckp20DK0pMKWJHY33t
         iI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBqhdQDBJRGoBLP7N57YtbXFLEg4i5iAZLmqRoUPvx0=;
        b=6Sm8c1L60bPJ93HN9BUi+SDJmio1Zac4pfIeoHp31+SNsP1OvtsIptXJXzAC5Wn3P9
         Pz4PhjxA/zq5hNftjQMxC59DiDKYnUBWUE4bC4xKqFZBbKKvuAyz72No/O8wlwQqYBXB
         5BXuJ5UvrVb4TuWhwGZ6WYMDueAy+VyTmTHpyvkwaDeFRAR3vAAUZCo7PnyNqXixHk4F
         yIhZl5eLUdTMG3rsm1WiAaTGtBtjPViy4V1Cy9d8iMJNhAZq6Ru6+UuvmAgbcTFwQUXO
         k82lWY3KumCFmaUESFaDnEFEv0F4P5ITCCnsxKPOzvEos7qcWtsYmdX/NqnXzt8tpCm3
         0V9Q==
X-Gm-Message-State: AOAM530tE6X3P7jvx32V+kEvKldZqopz6cy5eMLMPzOaEZu/Db3zhubl
        iLuX2zqmT2pfxy16S0/xNUf1JhvfrPM=
X-Google-Smtp-Source: ABdhPJwj6gVPg5wkvarYkfHovH7XPab80gbraUv3eTCbmjY1Pf0pKANgFAdGYaVsEDIzdwqDu2gZfg==
X-Received: by 2002:a05:6402:2c7:: with SMTP id b7mr16530788edx.217.1643541146085;
        Sun, 30 Jan 2022 03:12:26 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id nd9sm12129510ejc.169.2022.01.30.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 03:12:25 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: remove two wrappers
Date:   Sun, 30 Jan 2022 12:12:16 +0100
Message-Id: <20220130111219.6390-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set removes the wrapper functions c2h_evt_clear() and
hal_init_macaddr().

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (3):
  staging: r8188eu: remove c2h_evt_clear()
  staging: r8188eu: remove unused parameter from hw_var_set_*
  staging: r8188eu: remove hal_init_macaddr()

 drivers/staging/r8188eu/core/rtw_cmd.c     |  2 +-
 drivers/staging/r8188eu/hal/hal_com.c      | 12 +------
 drivers/staging/r8188eu/hal/usb_halinit.c  | 39 ++++++++++------------
 drivers/staging/r8188eu/include/hal_com.h  |  3 --
 drivers/staging/r8188eu/include/hal_intf.h |  1 -
 5 files changed, 20 insertions(+), 37 deletions(-)

-- 
2.34.1

