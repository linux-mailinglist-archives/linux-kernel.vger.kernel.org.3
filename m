Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456854F22E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiDEGKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDEGKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:10:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D7E12AEC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:08:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qh7so14399392ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+FPzuMqfL+tm7onrZD+j5++mLmXoOFcMmgPUGk3Dgg=;
        b=HqfJHEUxz7Jh21okwWtNTly5CHbQ34YwsbDZLIhIHStvCME4jMphgnuGqT9NBW5B0m
         +cEcOruD+Jq3s7B9jGCnSNSx8EXkAKeUUGqwSvwl1bwXcgunfwy7JXXKG1ovBxIP0IEj
         1ZsFAb6nJr1Yin1lMZ2wDf08EvuiptRMyUwlDOOmOU65qUgBCmaWB/WOxQMW1VGEaDbI
         mb5N/bQ69NwJNSob4ZnxgH38nAiI9iS0Y3nkIaoRs70G+Mel7W0EFYf8SK0HZYsV13aI
         sb1J3j6ixGr70bsjEsM0AYIaPD5pnx9mb4aIfsnUeBc0EiP8yS1Wko/ptYhDYDDX6HFq
         ebbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+FPzuMqfL+tm7onrZD+j5++mLmXoOFcMmgPUGk3Dgg=;
        b=paVxf49hxCdN6046P6MS9XpQZnjUnUVivgty2rlQTCTfw4ygz7Gj4IQeUoUqsPsXQI
         D+nRVc/G5OrtF4ksGwmXbUgQz9pREDSzYtAwZq1TBHTyzqhfYP/6Atjdn9QP66xU6THG
         LjyksWn2MaYeOIYcM7/QoSvCSD3tujEKWHvKBMSmrD+nX1DrUipBkyej5iXYSXD7g9Wa
         IubEZWoKKjgU/dqaGySWcPufHF1/QSjVD3PJ8iyezRjgDN/wYmzaqecVRtUjmVJZDIW/
         Y8gFfZd7zxhcE+Sq1iDlLM+pAJNLpBZUOMkfB143NcE3oUF1o6XjACY4dAjfaOp8FtdT
         z6lg==
X-Gm-Message-State: AOAM532K1Se0DjqmnJXMM9Hjq3way1qOFY0jDKalZWhR/zMAsFjU3xLe
        i92HE/RqJth6hHLIuDKzEFs=
X-Google-Smtp-Source: ABdhPJw+PJOEI6KMp+/0TgB/6PgKs7K0Bmge8uh5Q/96ZPHjXF64+KGXEZeg0iT0hXR0L6PGRLuVXg==
X-Received: by 2002:a17:907:72d0:b0:6db:4788:66a9 with SMTP id du16-20020a17090772d000b006db478866a9mr1968057ejc.516.1649138899963;
        Mon, 04 Apr 2022 23:08:19 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id h5-20020a170906718500b006e7edcda732sm2484538ejk.125.2022.04.04.23.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:08:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/2] staging: r8188eu: remove ternary operator
Date:   Tue,  5 Apr 2022 08:08:11 +0200
Message-Id: <20220405060813.8448-1-straube.linux@gmail.com>
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

This series removes unnecessary uses of ternary operator that
explicitly set true or false and removes unused macros from
ieee80211.h.

v2:
- Do not remove ternary operator where the condition does not evaluate
  to true or false.
- Added patch that removes unused macros from ieee80211.h

Michael Straube (2):
  staging: r8188eu: remove unncessary ternary operator
  staging: r8188eu: remove unused macros from ieee80211.h

 drivers/staging/r8188eu/core/rtw_p2p.c         |  2 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c     |  4 ++--
 drivers/staging/r8188eu/core/rtw_sta_mgt.c     |  4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c   |  2 +-
 drivers/staging/r8188eu/hal/hal_com.c          |  2 +-
 drivers/staging/r8188eu/hal/odm_HWConfig.c     |  4 ++--
 drivers/staging/r8188eu/include/HalVerDef.h    |  4 ++--
 drivers/staging/r8188eu/include/ieee80211.h    | 18 ------------------
 drivers/staging/r8188eu/os_dep/osdep_service.c |  2 +-
 9 files changed, 12 insertions(+), 30 deletions(-)

-- 
2.35.1

