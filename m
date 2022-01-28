Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E549F8CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348269AbiA1Ly6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiA1Lyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:54:55 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A8BC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:54:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id s5so15254522ejx.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYbDIvkLpiv3KebZZgf7tM5pDlVvFx1JbgUZkS6le6I=;
        b=T2dB2IBfnbUEnOsKrt/0PmlICjLIy8lwK9qFfPx5yia+IRv55rdGvGhHSbq5Hlez8q
         O9E/e9oLabzaJGXFZlEuZOA2dg52hEWWwuvVyYWBKaOkCWbBN6KSedwThcK0qcyfQ5JE
         Kms9nSmxaL02ClbTgTrN4fRUaNdS+TOkm4yjQ0z74RyyGNoieLXoKJKeC4XqVJEFRUkb
         GCX8r1NuqnA6UNvohLn49K6xiP4xM64tY+CpnA2wI7vGS+W6bhUp71DKBAeTMxlCYLhO
         AQ9MLhFjCduzG/NiLg/j+0z3AEc1DIPax2DvQPcWtsRanqVcmAXEV/pYvZNMcfbAqEii
         Hs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYbDIvkLpiv3KebZZgf7tM5pDlVvFx1JbgUZkS6le6I=;
        b=5FssBj+tVe9RhZUzKEgW1IW/EAOBksX8OKa6sDMhhDqqCQw34GYa5PgWQkR0w499Jy
         3cI9tDLhMgBsYflbmrSVYn3OmW+2He/8CqNNEk3xQH62VygVdDQCSvvZSk3HqRofqNA/
         sKdRFki27904RC4mEZAmFB/S79vP4jyhYTi6tgcr+9hC1gSleWNo3hFkqz15Je3QAwKf
         KBUTG4LjFI0H4iTa76YTcN6SigzGsBAffqUj3BMqTtsb2cA3EGTzsHfj+np5rcaWOt34
         /wHVjxDPuwN8ni40K4+qOhfBcrnFZqufjp1m3gE/wCCxLxs1gPtqK9tPZLuvtRZJygMX
         c+5g==
X-Gm-Message-State: AOAM533fnnrxyAqA0IOFkCDR3SievodpRP3BM4kR9LCPG+pA44ZzcU2w
        KUm2ZbG/5Md0UgmpzKWLqn01PTCq1xs=
X-Google-Smtp-Source: ABdhPJy+xUnjaH81ecnkXI0AuJEl6hq6ARWiHKmUtGi0f5iDm/DT5qyh8gFBDBXloTEx1BbnzHGlUw==
X-Received: by 2002:a17:906:7315:: with SMTP id di21mr6711662ejc.515.1643370893689;
        Fri, 28 Jan 2022 03:54:53 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb9e.dynamic.kabel-deutschland.de. [95.90.187.158])
        by smtp.gmail.com with ESMTPSA id h20sm12494261eds.9.2022.01.28.03.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:54:53 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/6] staging: r8188eu: some more cleanups
Date:   Fri, 28 Jan 2022 12:54:39 +0100
Message-Id: <20220128115445.6606-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some more cleanups. Mostly removing unsed and/or
unneeded code. As usual tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (6):
  staging: r8188eu: rx_packet_offset and max_recvbuf_sz are write-only
  staging: r8188eu: remove unused cases from GetHalDefVar8188EUsb()
  staging: r8188eu: max_rx_ampdu_factor is always MAX_AMPDU_FACTOR_64K
  staging: r8188eu: convert GetHalDefVar8188EUsb() to void
  staging: r8188eu: convert SetHalDefVar8188EUsb() to void
  staging: r8188eu: remove IS_*_CUT macros

 drivers/staging/r8188eu/core/rtw_mlme.c     |  8 +---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 20 +---------
 drivers/staging/r8188eu/hal/hal_com.c       | 24 ++++++++----
 drivers/staging/r8188eu/hal/usb_halinit.c   | 42 +--------------------
 drivers/staging/r8188eu/include/HalVerDef.h | 18 ---------
 drivers/staging/r8188eu/include/hal_intf.h  | 11 +-----
 drivers/staging/r8188eu/include/wifi.h      |  7 +---
 7 files changed, 23 insertions(+), 107 deletions(-)

-- 
2.34.1

