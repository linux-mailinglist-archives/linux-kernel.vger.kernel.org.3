Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16E157D3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiGUTQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiGUTPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:15:50 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5725C34A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:15:20 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h18so1922901qvr.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ImhHJx4Vd1FevHdyjgSCSnH8Im71TSuXWWjTS8e9Dw=;
        b=ByTDxhXX+luQEdOqug9WixagMCsnFlKEjeC/vn7w3OH293zYmsig3njMxuJ4eQ/z+d
         7CF0ZDgG42cFl6lRfdRjq8MkZcMS8xYiJr5eKWfKonBZV1NG6BodczVkimLTZ10qyDQq
         NjO6rlgUvnpMBOlVErMIuR26urBuALLU/yEBRYjkB+Au9X2pxwwIbsG9PSBGNMp85lo+
         zKsHHjJhq/pdy/TAVM375T2i8PsMH7bc7pOIRBTNrG59M2gII9UbnJHjRptCvUKF5M8F
         Ez91PKt8LGc/RD9HMfgHOURW7cfc32MzRKFgtELH0KMWu+tNnbO42gb4m0tXBSDpyHW0
         YMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ImhHJx4Vd1FevHdyjgSCSnH8Im71TSuXWWjTS8e9Dw=;
        b=L9RbY3mTvee+eyoUxqWi2jjYCNu8FM6UGMsWCLwxtnNG4EF0PWxyPKVqP9yP0HRxI3
         Rzh3cnvrizLJ7GRE/8J1fky7KWCAd4c9Znljr6RAEgVbMbplQJ9ktWVc9ZwQNtdLMvRJ
         BWLvPah+kOp/wKHVSuEK7aHgbB3hP08k+ehwgyAmrRRBYNrod7Y4ZwkjnZ0HOFU2fWjN
         MOjXqLtKgRsh7o+HqtWBNKn4Lo9hsibQeGLNkfmQhh0wTVOf7HO4KYxF217VK5KCY9Q5
         lExVLTvn4H5mcndfM6H25UVlOtq0LSTEjDNQ2tpVxJRBD/K3QSLVLnrjvgoWUNndx6mb
         JlOA==
X-Gm-Message-State: AJIora9RGNvUUUhLlj4PqfDuBG2FqlkmUrLUBxQf5CheHXxmmT6XDRKx
        J39W62px2g7ocbQgtIwy/narH+e5WayYCQ==
X-Google-Smtp-Source: AGRyM1uMldStzbeoXJ5pl5+ljso5lKYS55h7lToGnX3Meln/qbMA1OHUzadtZOHL+Qut+UPmmVa5CQ==
X-Received: by 2002:a05:6214:238b:b0:473:358:ddf4 with SMTP id fw11-20020a056214238b00b004730358ddf4mr35709438qvb.66.1658430919566;
        Thu, 21 Jul 2022 12:15:19 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h20-20020ac85854000000b0031ef0081d77sm1897221qth.79.2022.07.21.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:15:19 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] MAINTAINERS: Update Intel 8255 GPIO driver file list
Date:   Thu, 21 Jul 2022 11:25:08 -0400
Message-Id: <20220721152508.3661-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers/gpio/gpio-i8255.h header file is also maintained.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 960abc07304e..2bd82ce171ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9907,6 +9907,7 @@ M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-i8255.c
+F:	drivers/gpio/gpio-i8255.h
 
 INTEL ASoC DRIVERS
 M:	Cezary Rojewski <cezary.rojewski@intel.com>

base-commit: 949506dc608f9820e0cee51b106c35fd3503bbb2
-- 
2.36.1

