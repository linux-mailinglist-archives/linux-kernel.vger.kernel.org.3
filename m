Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470F55477F9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 02:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiFLABj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 20:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiFLABh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 20:01:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12146A425;
        Sat, 11 Jun 2022 17:01:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so2671295pjb.3;
        Sat, 11 Jun 2022 17:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rrR2yAG5ZDoOc5RKGUSqko0qrkTdkFcvAE69IpskmQk=;
        b=bxm/xiWQoxyLzg/Q6KDEDCwr+QZ3vIvSrbwYfyVTcvKPaoIxtp34y3V3YDIDleYI+W
         QK/vtFXhrhy2ZhZRrycP2vEZ0ewJbEZQa3myf2dCw85jXBLROXvMLWRZoF/fWczBPjZo
         VyxfUKhQsoA0rnjMKfSCfmGI0Wr6s0grg37+v8JpW7Qt5qxlMybuzGNZDIuyEE/IOcOB
         ZgNge4Pw8ce200HQ49utHlg6PPmI0zIPFY74F3gyntOl3fRzU4XWnTI99vIItxdWSRrU
         m9Sow0NKHDamMtXdKpPq42VO/pr8bh9twl6MVcv7pw6o8NfsGUyw20z3wYPPG1/b60NJ
         0dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rrR2yAG5ZDoOc5RKGUSqko0qrkTdkFcvAE69IpskmQk=;
        b=H3goDps9U2JRGibN4+AHv7y6p2/hguvAh6eaAr5hXTKVIpM/7ZGqvx0YxQPaYkWUAa
         d8ChUaB/lagZF8evbPEPvY2fY/8vHbRsq2Edg8iRvdefH1vanim1G5+BcXL/fiGSWmwV
         Hjtf02BCzAqMUeYDuF1ZCP7CtLU0gqtp5JmUnWGX+3w1RtoFfBN7eiETaqZAyEwV8NLv
         p2YzoSEMDylGpd7ZmEDtWtwYjLu8NCoBDLPiXGpn1948nieYDLgdx7NkjST6SZfdb4Cp
         V/snTGDJ9/XucwQZ33qqNf58smgmflXYSsy/e0iKCg4EDpa6ovQcXxDkDhMf12269ujs
         2YAA==
X-Gm-Message-State: AOAM533FxA7DeHuOMkA9M1sxHee+4ARZTEf5VInNcXPwvyJAIz5arl22
        NKF0MJDw3huyEHXRu6Q8pSxCY0U/oKQ=
X-Google-Smtp-Source: ABdhPJwzSAUVchKa+rTUGUJRkr60hBjUTrhIP0rYG8PQuiBVJ4d9X8ZgTMHK527r6yMU87IvTMLFEA==
X-Received: by 2002:a17:902:cf05:b0:156:9d:ca01 with SMTP id i5-20020a170902cf0500b00156009dca01mr51176328plg.111.1654992095656;
        Sat, 11 Jun 2022 17:01:35 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id a15-20020a62d40f000000b0051f2b9f9b05sm2146794pfh.76.2022.06.11.17.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 17:01:35 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] leds: Add leds-qcom-lpg entry to documentation table of contents
Date:   Sun, 12 Jun 2022 07:01:25 +0700
Message-Id: <20220612000125.9777-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging linux-leds tree to the mainline [1], htmldocs build produces
a new warning:

checking consistency... /home/bagas/repo/linux-stable/Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included in any toctree

The warning above is because leds-qcom-lpg.rst is missing in the table of
contents.

Add the missing entry.

[1]: https://lore.kernel.org/all/20220531200619.GA8906@duo.ucw.cz/

Fixes: 24e2d05d1b6898 ("leds: Add driver for Qualcomm LPG")
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-leds@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/leds/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index e5d63b9400459c..014e009b076159 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -25,4 +25,5 @@ LEDs
    leds-lp5562
    leds-lp55xx
    leds-mlxcpld
+   leds-qcom-lpg
    leds-sc27xx

base-commit: 0678afa6055d14799c1dc1eee47c8025eba56cab
-- 
An old man doll... just what I always wanted! - Clara

