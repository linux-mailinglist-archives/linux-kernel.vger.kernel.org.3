Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9905488E15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbiAJBcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiAJBcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:32:47 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D31C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 17:32:47 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o3so525692pjs.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 17:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDInHq/ZBlgHE+7Mddqlt+1G7R4LZ45IdBOOJm5Mw+8=;
        b=quWx7dX4s95s9Y4pDV3zq/+tlw208MQUlShVhvYwgU7l0KQUrG7tqx1ea7OMyRCmRR
         bd/0W28I32cblxyKYHdTVTtcecI+bmgs43d1JpY7MxM5ryqNu2xWMzPqM84uAzc/CuWT
         poE+cJ5Mp6JTM00Cwm0EoN77e89bvIpbprdu+403rrMciz0Kr1dhs3DrGk1DFwmIG2oi
         O3gRnKqca/gVSzD8qMJH1uS4IaXGOCQv2qSgdlSi0HGE1KvnxWzP/clSCOvTpMGVJs0S
         j7SgIDCXrTvN5iTfpH7hmrerUBluO1qs+J61DIUFdoNTTsd0FcebhnYuer26CH8ThFGs
         SgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDInHq/ZBlgHE+7Mddqlt+1G7R4LZ45IdBOOJm5Mw+8=;
        b=gyfMGfKIEEP9dgPzUscmeeT+v5sT+EXV3OCpUMmc72aL5084I6c/mQN26PlFCZo7Xh
         +D4OcVpabjJElg1nkQxfh9ZD3utdWLk3X8yOIy0R/17thecD2voSjKX1ug4hBn2g6MVf
         +x1KzqJhKmnG0sbLNHN/3qMt/IrySFqAtusrL4y4KMuflnWEihESETJveWdR6+5bv0LR
         eToG/V5Jks6+HdJCIHDMyXBNIn6NwTfFAovsQUjDBlaZPN8MDtd0c6lA5ml4f9GZRc2h
         V0iSCC/yhL0wZtNxF+Gv91aO2pfvzL+UJBGXmGNHb9Y5LsRkDU6sA4F52IaDCCTY4624
         WiFg==
X-Gm-Message-State: AOAM531LUG6eb6yKJqdJbiQXacl+nSibGz6dO55StLgnt4Fg3LNh0SJg
        Y6pk4sQQlNLkBczwYnEIX0Q=
X-Google-Smtp-Source: ABdhPJz9uRvifEgabZZKRFZ1ykOa2i62a9OXRm/5yWOH7bMRipy1qBsgeq3ECdIVnINcIfyjQZBwvA==
X-Received: by 2002:a17:90a:ce18:: with SMTP id f24mr4423863pju.98.1641778366606;
        Sun, 09 Jan 2022 17:32:46 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mn13sm4021566pjb.53.2022.01.09.17.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:32:46 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     marcocesati@gmail.com
Cc:     fabioaiuto83@gmail.com, hdegoede@redhat.com,
        saurav.girepunje@gmail.com, kuba@kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/staging: remove redundant result variable
Date:   Mon, 10 Jan 2022 01:32:40 +0000
Message-Id: <20220110013240.644190-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from ips_netdrv_open() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 05482341eefe..757efeb49d08 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -922,11 +922,7 @@ static int  ips_netdrv_open(struct adapter *padapter)
 
 int rtw_ips_pwr_up(struct adapter *padapter)
 {
-	int result;
-
-	result = ips_netdrv_open(padapter);
-
-	return result;
+	return ips_netdrv_open(padapter);
 }
 
 void rtw_ips_pwr_down(struct adapter *padapter)
-- 
2.25.1

