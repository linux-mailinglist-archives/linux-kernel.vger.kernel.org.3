Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A8E507AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353515AbiDSUX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347699AbiDSUXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:23:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E821D314;
        Tue, 19 Apr 2022 13:21:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so2252735wms.2;
        Tue, 19 Apr 2022 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uteNDEdpC6vaqnTbN8V9WW4VbVcn1QZMpJDP2OY1IM8=;
        b=aAlF/CZry2fODgPyACyeFaLZBYPWELsqGBgSAcwRnR0JEGD6dQefLcSZNFsZN9Jk+1
         ZOjp0T0h3tPCcJp07rsS9VtM1uhZzux0UpmBfV7OtC9rpctskvMpQvGynvMdIp6sR/CZ
         t+3sjYhQY+ldfrqDxv7TbmbR+YLHuzhmXfULYBGXj8TlKYJyjfXS1XZHXQwJrT07xPvd
         uVF9184AbprdZ6JN/yhLzhXr5/kA38WthKHFRPDRPB67SZBGNAPEPDFMezyOFftK7CuX
         lfpy6ua+AasbLhvfTXZXAJIrlPxSwS6fh3fi366w9ij0Jj88jnNqv9JzH2wDKgepGrw1
         HKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uteNDEdpC6vaqnTbN8V9WW4VbVcn1QZMpJDP2OY1IM8=;
        b=BkIU6pXVxEWgLRQv2TsiKrqLN90FjnbjayjLAtdKph94VWDwXaCP2y6MvnYRiXcIKj
         A5ZhAR26JBlmRl5VPA5VAs0ruEsk0rajvwH6hB1JquRmtGRa1S/KKTozXfXK6BP77Hpg
         yrJdYLuzKrjjOGSRrDPHSQTPTmShqb8g+myxraqy/jzlKgyNodAYxbvsiPZIqxujCHfc
         sQuo7148RymUO/G8bB+biMMFa40uASKSsK0UiEGYnPd/JxlA0tdVuYVf0s0/y3QPW12u
         x3C2XCzkL7Ogl60gMsyuWABamt5WcnptNr4eIaFS2rk28IkouwVXsqo1Dx7iFKGeu9lE
         S5Ow==
X-Gm-Message-State: AOAM5324iFWQ8+4xWaqAvmO2biNlDRgFO6Wb7d6VtIZo9yIC1//A6i7t
        JmFqoVVHSrPylcwNspbqyeg=
X-Google-Smtp-Source: ABdhPJzk3koefiu/697Cw8gsEiy0MVxRxS8k7kLch17G9ujSaJ1lr/0XMIfIKvp5cKRR1bTxNwuUsA==
X-Received: by 2002:a05:600c:3b27:b0:392:a630:2899 with SMTP id m39-20020a05600c3b2700b00392a6302899mr243428wms.193.1650399667590;
        Tue, 19 Apr 2022 13:21:07 -0700 (PDT)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d45cb000000b0020a810f7726sm9959168wrs.5.2022.04.19.13.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:21:06 -0700 (PDT)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     matt.ranostay@konsulko.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH 0/3] media: i2c: video-i2c: Minor corrections
Date:   Tue, 19 Apr 2022 22:20:48 +0200
Message-Id: <20220419202051.44013-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
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

* Move define statements to the top of the file
* Add ram and eeprom start addr as define statements
* fix masking of bits using GENMASK macro from bits.h

Moses Christopher Bollavarapu (3):
  media: i2c: video-i2c: Move defines to the top of the file
  media: i2c: video-i2c: Replace constants with proper names
  media: i2c: video-i2c: Use GENMASK for masking bits

 drivers/media/i2c/video-i2c.c | 61 +++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 27 deletions(-)

-- 
2.30.2

