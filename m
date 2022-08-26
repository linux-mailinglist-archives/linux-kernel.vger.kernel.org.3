Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892955A22A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245262AbiHZIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbiHZIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:12:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10852D2B09;
        Fri, 26 Aug 2022 01:12:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso846759pjr.3;
        Fri, 26 Aug 2022 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=wpZT2rFRVv2cJapem2GAQdmudQUtOAPJxjk3kmyqjyU=;
        b=Qg+Ry7YPcWaIkCHrQ+gkyQy0x768kinoaUJ+5Iv753QcWK7mrd/1qINpSnQWraIFab
         uyLoZsFJTL0qJOX17Fjqy3QwG3bXMkDYtNdvl1UUnTWpC86ULKk4CPxtC6VNmeWlM4mW
         RcBhmRIJHlueJBRGaBpzZ6mW2oSl2R7Wh/cAam5cGH8WIwv48rbJ9KJ4lzQsNCNq+gFy
         06zDuOVIx5fqsrZiDyNeHmW0OeRuqmgea+HYrlIyHPOLH0/l9EqNgOdRR/FQIwrLYy25
         SVLknKwBuDGyTgrICrzgtZIIaT+pt2Konc8P22zAfcWJgNld3kAZyLcgI7/LUjRqKZQL
         HLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wpZT2rFRVv2cJapem2GAQdmudQUtOAPJxjk3kmyqjyU=;
        b=vKqhaLpkZwcN7jzKucPlQDsMb1hDl8qyvoJ7mTa5P82XkDvlOgAa9jQxqapt3ymx/U
         JgevBmN0f5tbI20pA/w8bnai4b0SThBF2WVDFmN0dIqTT3rXO2VzNjHmiXC9eSR+PkQ4
         ybBu23AwrqJodCu4IpFwIfehTGCIfroUHr3OetBX+qV3y+KAbYDmo9L7cqwlFx6vodEZ
         S86KC/qdjGsG+XOmeFNgVP8f0s73tRet0eNyfEnvzJLxBCQP7P9LipN0cuHqmrwAHLiU
         mBoTCa+ElOAlpMeiDwFePe+Bk04KWBhR7ORYGvcQtAyp5T7P5FdFP53bU5UQbZHe39tx
         sEWw==
X-Gm-Message-State: ACgBeo0BZboYzgm4dUbtFtN805wBGWRuTcMPcjqOFgOWExlYlLqZNt/B
        mCQQSkL0kvVPFDwJpx4GKZA=
X-Google-Smtp-Source: AA6agR440WLvEELIQOpn6QexLfmNjX5TaWnWiYIHPUSd1eXorlMFFhvNKot34muSWYo9vDLTqFo4JQ==
X-Received: by 2002:a17:90b:17ce:b0:1f4:d068:5722 with SMTP id me14-20020a17090b17ce00b001f4d0685722mr3162580pjb.28.1661501528567;
        Fri, 26 Aug 2022 01:12:08 -0700 (PDT)
Received: from localhost.localdomain ([103.151.209.218])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b00172de80fec4sm911443pll.69.2022.08.26.01.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:12:08 -0700 (PDT)
From:   Akhil Raj <lf32.dev@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net
Cc:     Akhil Raj <lf32.dev@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Add leds-qcom-lpg to leds kernel docs tree
Date:   Fri, 26 Aug 2022 13:41:50 +0530
Message-Id: <20220826081150.1961-1-lf32.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning was within
./Documentation/leds/leds-qcom-lpg.rst:
	WARNING: document isn't included in any toctree

I have added leds-qcom-lpg to the index.rst

Signed-off-by: Akhil Raj <lf32.dev@gmail.com>
---
 Documentation/leds/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index e5d63b940045..014e009b0761 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -25,4 +25,5 @@ LEDs
    leds-lp5562
    leds-lp55xx
    leds-mlxcpld
+   leds-qcom-lpg
    leds-sc27xx
-- 
2.17.1

