Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0363F4E71C1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353183AbiCYLBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353174AbiCYLBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:01:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E19BF039
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:59:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r13so10325551wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=QUuvuWx0AHdHxhKcNG871JJ4v7rlpXrie/P5Lhm5m3E=;
        b=rGvEAxAvCYzcX7kzi5ONuWblQJjvcGKUJLNhXM8ImX3ZWHD9ozycr9q5EbHg+WIfKc
         PZDJ5dFDCFmDzOjV7ZzTJps88Lhj8mGKcfJm5qjALFkwuN4XL6WITfIjN6r5Fx17LHm2
         RD7UxuVkbTW7X9LCXng6KYG/TwgzfhnVjo698VKCIhBj/fMe3RAOme41Gqs1ncRjkUX9
         5/YuMdDqCgYg7AssNh3jVevbeeJ0q/jxpYhMQYQR4l4+Iymax0W0+mYbt3sRqYfcS0z2
         jqnSiiuSSEn/Nk0BPf2iNW7O8sKgSeGu8RMukM32dRUZlascCHPOrsuB4d0Qb/IbMsiG
         15mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=QUuvuWx0AHdHxhKcNG871JJ4v7rlpXrie/P5Lhm5m3E=;
        b=OACVNhqO9Jv7/SCc0kWvFLTLSOFnHc/xLIe6otIRCJBegu2W37UA73gDJpm2YLOfH3
         Ty9Y58D1FXIg64C8QKPT3kFypE8eyDMuj4Q30/WdIh7FXQ1lHEzjraL7LTSVmi/8H+Va
         TGGaGiIACk4nTXsBB4+OE/+PQvYf9tMtfIiWU0HopYzVNBxYniafA7PAQJfnrOUVSzt+
         RUK081wp8oYvx1A1XirfhC6YOLOt3bx8O6H8O/k3OGmasfcT91PW9ifIKOPwoOc9wnq9
         KIvvtYclODlFBgRtZUDgEO5T8XNby1IceJ0UUm0bqOtrwk6NrGasyudqqjescsaNF7lD
         /Asw==
X-Gm-Message-State: AOAM533z3TzqNYA9VjsQHvjlwGd69i8vcSeN90NmlES9+C6LOhsqqCu3
        VZqpD1xiyn79ayDJKF6bIpK/vYG7ARApig==
X-Google-Smtp-Source: ABdhPJwPJck71gv8SQqBQj01bgk7FX/y+SqznA2Ju0ewPebQcJEY89Z0oEkDGjw7zvjHDYjNzUfMcg==
X-Received: by 2002:a5d:40c8:0:b0:205:2a3b:c2c with SMTP id b8-20020a5d40c8000000b002052a3b0c2cmr8510219wrq.13.1648205996880;
        Fri, 25 Mar 2022 03:59:56 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0038ceb0b21b4sm1003997wmq.24.2022.03.25.03.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 03:59:56 -0700 (PDT)
Date:   Fri, 25 Mar 2022 10:59:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v5.18
Message-ID: <Yj2gqnIk6HY5WyKo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.18

for you to fetch changes up to 023a8830a62846e1cecc8da07e00c801dd0d7598:

  backlight: backlight: Slighly simplify devm_of_find_backlight() (2022-03-08 10:47:28 +0000)

----------------------------------------------------------------
 - New Device Support
   - Add support for PM6150L to Qualcomm WLED

 - Fix-ups
   - Use kcalloc() to avoid open-coding; pwm_bl
   - Device Tree changes (inc. YAML conversion); qcom-wled
   - Cleanup or simplify code; backlight

----------------------------------------------------------------
Christophe JAILLET (2):
      backlight: pwm_bl: Avoid open coded arithmetic in memory allocation
      backlight: backlight: Slighly simplify devm_of_find_backlight()

Luca Weiss (2):
      dt-bindings: backlight: qcom-wled: Add PM6150L compatible
      backlight: qcom-wled: Add PM6150L compatible

 .../devicetree/bindings/leds/backlight/qcom-wled.yaml          |  1 +
 drivers/video/backlight/backlight.c                            | 10 ++++------
 drivers/video/backlight/pwm_bl.c                               |  9 ++++-----
 drivers/video/backlight/qcom-wled.c                            |  1 +
 4 files changed, 10 insertions(+), 11 deletions(-)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
