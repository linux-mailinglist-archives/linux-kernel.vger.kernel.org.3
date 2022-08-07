Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB258BAD0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 14:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiHGM1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 08:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiHGM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 08:27:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE513B7FA;
        Sun,  7 Aug 2022 05:27:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p8so6309454plq.13;
        Sun, 07 Aug 2022 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pPEFfXFS2bPZaC6r7fH0ix2vur9Xz7husL4v2aFGft0=;
        b=jo+bxny5Oyn5mBeFoUIJCZiy0y/AO/CKcVw8w16GDfxHBhz1vVEOAXUxvoelgpQDgp
         vEaWCmB041LzSNBdqJOUVRJ3ytatXLNziyxEGvZkFcbzkJO1qfs0YfHZJo/lL7pKgBKe
         IezNbOvBuJlhwnfXnMClJ0aGM6d18ZiEY/6W5MfDUJNvJ2hPLkWk/YCWKds5HNW1+YxH
         wfo+/xHNVuGlkkafpGHZxbDgrSeTBcnmR9ln8IGkYO7kGFDNiIIoUSiY5xhOWvJWYMz2
         OjfrKN20/5aboFVAI0kP8fu0sbsBOBgdWt/C8Q+OfNMxqaqFjwFLnecAAVYlLXbx1yEc
         ly9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pPEFfXFS2bPZaC6r7fH0ix2vur9Xz7husL4v2aFGft0=;
        b=nCsjG1DQkop/0kOZ547VDG/yM12CGpMTep8OgKxzm+qlYyuyA0VBiz2D8h/MU1FmlA
         2+VXRoyCbUJyfe7qeHngH2Cf9dS2IZZdSTUvIXKMhfGZzMejlDFme3cSNbYmEGXrrqN7
         3kw14qQ541OsC4sVKAAlSlZmczU5RBB1nN3YWBy+qVmARntQNY/Ysi8YYHiCcSXliFfg
         68OkQMhSrRYoDONQT4bDA/u3P4anEhCi48VUNXMSnCWssS2NA2whltrqyb0Wu4BiqH+Y
         4VE2FAi7keRFQ6AZ1h+6YZDlWQwitxWD4bXix3+UQWl3dqkn19mZq0g1AXRv8Cjt+Lky
         Nigw==
X-Gm-Message-State: ACgBeo32GjWwk8v1ipeEVsETuN5ZqBEiBYfQO9P7O+ooxviufvhBMkE8
        578vVEfOCvNIRidLb4jOupjkaH/P5U8=
X-Google-Smtp-Source: AA6agR4iukdOUa0v1dM83re2pWI5Y8w2PNlnocrTnoYLUpOOAHvkuoumSl/URvwvmLng8G87z3KzEQ==
X-Received: by 2002:a17:902:ce0a:b0:16d:737b:feed with SMTP id k10-20020a170902ce0a00b0016d737bfeedmr14238837plg.152.1659875226254;
        Sun, 07 Aug 2022 05:27:06 -0700 (PDT)
Received: from Redmi-G.localdomain ([112.0.190.111])
        by smtp.googlemail.com with ESMTPSA id n7-20020a170902e54700b0016c16648213sm6716709plf.20.2022.08.07.05.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 05:27:05 -0700 (PDT)
From:   Molly Sophia <mollysophia379@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Molly Sophia <mollysophia379@gmail.com>
Subject: [PATCH 0/2] Fix some typos in SC8180X pinctrl driver
Date:   Sun,  7 Aug 2022 20:26:43 +0800
Message-Id: <20220807122645.13830-1-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some little mistakes in the sc8180x pinctrl
driver. The following patches fix them.

Molly Sophia (2):
  pinctrl: qcom: sc8180x: Fix gpio_wakeirq_map
  pinctrl: qcom: sc8180x: Fix wrong pin numbers

 drivers/pinctrl/qcom/pinctrl-sc8180x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

