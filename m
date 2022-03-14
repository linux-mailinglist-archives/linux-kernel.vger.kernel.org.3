Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB54D7913
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 02:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiCNB2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 21:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiCNB2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:28:12 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55BB220F6;
        Sun, 13 Mar 2022 18:27:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z66so11614888qke.10;
        Sun, 13 Mar 2022 18:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DH4p6xL9ZALjUBJZZxpIP/BlhTX9TFFyaunISoFtdWs=;
        b=mo4gcsynOk+f0EnaMFXzZexIo8pFqbMWvElk5v1wYqQeoEJXmY6KjRk+GKFQcNuNgV
         6cvPTyq3Loa2l/eu0spwxavOzBy2ARH+2Hv90Hal3g55y4qVADLxL8YYiNF9y6LJrWU8
         0iMXlDhfb7PbUFVnyW0CEORvWjkuN0sum9IoeoBH6Innp4veaMKmopijBgvw5DF89rAN
         9GOP97gbT6SiYqxzVNLJrNQbhBoy//lYOW6kaATPhLrMpGTaZH/VtQKZNbQMRz3fQmrD
         8po7RwaXSzR5f0s6Gg01A/kbEI6JQ/BLHmTiqNfYMzrhK9++fmXTWtpR/PR8Njt6u4Qb
         tQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DH4p6xL9ZALjUBJZZxpIP/BlhTX9TFFyaunISoFtdWs=;
        b=djThji3vx3ChY3dnBjPPM5oW03tFM3IEKBSgm0tSa6a4BA+q1Er8vJKkvaxtA9rU/L
         1y6kbgqNUhleC92T1AzTr/PNcZ2LP6127LKrIiph3Z5ZxTGU5QZAGUCJ8LG5sNa3z+Ch
         R2TBv4JMey1sD1bMCEm9ZPFo6aKVpFPJ4GLUjAUoPXwidqsjPiPg+k6DbgQUNeDLoMu2
         OprG24koHSI7tdQUyCY08yj+VTeNaeKzILBkcCyPuF4lkT19/WvLmM+xZHarnMa7Kymy
         H4YXeqe5t+4RVtYDChcyCsPq2vKMXNKtEup9pvFRUem6Xmeqjx+9jxAAj/WyFkTqQbuN
         xGuw==
X-Gm-Message-State: AOAM531FNsBHJ+lv75wucEWZWFsL4Bm4fcP7LsPaVtZRgtytxxHPBqEb
        QhXjpGqc+NAprS+Drc9BvT1eg2HIJ+s=
X-Google-Smtp-Source: ABdhPJyNZzJlg6mRYYuIEx44zMB5qnJerrmZw61OHd3kYu5Den3pc2HPFMeGQtgdFEMvkVoY3e0MDw==
X-Received: by 2002:a05:620a:16c5:b0:67d:47db:8b50 with SMTP id a5-20020a05620a16c500b0067d47db8b50mr13410968qkn.77.1647221222965;
        Sun, 13 Mar 2022 18:27:02 -0700 (PDT)
Received: from grrm.lan (bras-base-mtrlpq4809w-grc-17-70-53-205-21.dsl.bell.ca. [70.53.205.21])
        by smtp.gmail.com with ESMTPSA id r12-20020a05620a03cc00b0067d370e414esm7021467qkm.15.2022.03.13.18.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 18:27:02 -0700 (PDT)
From:   Yannick Brosseau <yannick.brosseau@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Yannick Brosseau <yannick.brosseau@gmail.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: stm32: Fix typo in comment
Date:   Sun, 13 Mar 2022 21:26:33 -0400
Message-Id: <20220314012634.1176231-1-yannick.brosseau@gmail.com>
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

s/Documentatoin/Documentation/ in path to the doc file

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 include/dt-bindings/clock/stm32fx-clock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/stm32fx-clock.h b/include/dt-bindings/clock/stm32fx-clock.h
index 1cc89c548578..e1ee08055a65 100644
--- a/include/dt-bindings/clock/stm32fx-clock.h
+++ b/include/dt-bindings/clock/stm32fx-clock.h
@@ -10,7 +10,7 @@
  * List of clocks wich are not derived from system clock (SYSCLOCK)
  *
  * The index of these clocks is the secondary index of DT bindings
- * (see Documentatoin/devicetree/bindings/clock/st,stm32-rcc.txt)
+ * (see Documentation/devicetree/bindings/clock/st,stm32-rcc.txt)
  *
  * e.g:
 	<assigned-clocks = <&rcc 1 CLK_LSE>;
-- 
2.35.1

