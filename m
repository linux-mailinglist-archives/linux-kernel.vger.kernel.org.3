Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0495AABD9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiIBJwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiIBJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EFFCD7BB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kk26so2734635ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FMEGVSOQkvEokkzg/zVey43XHPk5Q3zfHXWM53CUdaY=;
        b=f+PjAC+0e5lCK6fRQQe0Q09f7Jkj6BMsEz0Z/kmCqNNPtLl0eEPV/I+1Ole9ylTHyC
         M92keJqqZsTRqm9IbQifbptNbcNzANGRrole8CMNwt02MEYYrduJQFkUmIaTPfblavLk
         8mIgHgxyL0dHE2W9YhqYeMdypgvXEtKEK8/vvh9zof7E4S9m/xmeao46xexZ4mP0knGM
         WivaDVeMb205BeaVnBkWP1LwRoDdhq5YRxyV6RyERgAIaMH8645W9+zE6Vpdxa4O5zq4
         tI6sSJsM7dsmgtPHqCyeYYOgkbumJHKFtXMHEL1NbUZhtE/JC9EzzHyugt1ztD7hlUDj
         Vaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FMEGVSOQkvEokkzg/zVey43XHPk5Q3zfHXWM53CUdaY=;
        b=OJWEj08b1wXAa1vKLv7/XHyRPeVJsxUenZfcpmdPAbQVE3Jt0iSkHsjXOdDkWPKTEO
         dUmApsZULQBudgxMXiv/wuKOxnSpvWDqAOkyLpQZ6myuvSDpGW2+/qoVvjrtRFa4ncd9
         fhYVrnCKAr16j/3YxhxLZcBc+naL0hI8wUxnevBBQb1strd6lXUT9c/ufMamAQjaWcVr
         hNH+UqTBnG2bWAEU7Y+3dBizw8pXtum0NKLUYn/xGHzQdYOLyEYpM2UhPK8n94vsqAGv
         4WcXeRWRKW/rhEhu0K8qNGjLJSqUhI+qqbHOMAQftnC3pxOTwvp/4nEu09W7pQ4ioUS4
         UscA==
X-Gm-Message-State: ACgBeo3HLloWzoY75+zVd8OxZN/ljqvjzMX2lTxi4xIv7fwP7r5JgF7K
        yKsxV/CTCEfmp7NE1xFxEIg=
X-Google-Smtp-Source: AA6agR6h9SKqWA8ZtgnUx9yY1cfILzhCU0Iv0fn3rtUUhswC7N2X4v2tOJryQAu3SsMuPfyzCEcIRg==
X-Received: by 2002:a17:907:7b92:b0:72b:67fb:8985 with SMTP id ne18-20020a1709077b9200b0072b67fb8985mr25319525ejc.569.1662112353712;
        Fri, 02 Sep 2022 02:52:33 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:33 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 00/10] staging: rtl8723bs: delete some dead code
Date:   Fri,  2 Sep 2022 11:51:50 +0200
Message-Id: <cover.1662111798.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Delete some unused functions and files.

Nam Cao (10):
  staging: rtl8723bs: delete rtw_setdatarate_cmd
  staging: rtl8723bs: delete function rtw_set_chplan_cmd
  staging: rtl8723bs: remove rtw_change_ifname
  staging: rtl8723bs: delete rtw_odm.c and rtw_odm.h
  staging: rtl8723bs: remove odm_PauseDIG
  staging: rtl8723bs: remove GetHexValueFromString
  staging: rtl8723bs: remove hal_btcoex_SetManualControl
  staging: rtl8723bs: remove rtw_hal_is_disable_sw_channel_plan
  staging: rtl8723bs: remove IsHexDigit
  staging: rtl8723bs: remove rtw_is_wps_ie

 drivers/staging/rtl8723bs/Makefile            |   1 -
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  84 -------------
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  17 ---
 drivers/staging/rtl8723bs/core/rtw_odm.c      | 116 ------------------
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    |   5 -
 drivers/staging/rtl8723bs/hal/hal_com.c       |  64 ----------
 drivers/staging/rtl8723bs/hal/hal_intf.c      |   5 -
 drivers/staging/rtl8723bs/hal/odm_DIG.c       |  57 ---------
 drivers/staging/rtl8723bs/hal/odm_DIG.h       |   2 -
 drivers/staging/rtl8723bs/include/drv_types.h |   3 -
 .../staging/rtl8723bs/include/hal_btcoex.h    |   1 -
 drivers/staging/rtl8723bs/include/hal_com.h   |   4 -
 drivers/staging/rtl8723bs/include/hal_intf.h  |   2 -
 drivers/staging/rtl8723bs/include/ieee80211.h |   1 -
 drivers/staging/rtl8723bs/include/rtw_cmd.h   |   3 -
 drivers/staging/rtl8723bs/include/rtw_odm.h   |  24 ----
 .../staging/rtl8723bs/os_dep/osdep_service.c  |  50 --------
 17 files changed, 439 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_odm.c
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_odm.h

-- 
2.25.1

