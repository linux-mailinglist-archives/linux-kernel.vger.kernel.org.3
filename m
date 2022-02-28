Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED24C6CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiB1Mob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiB1Moa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:44:30 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4D945ACF;
        Mon, 28 Feb 2022 04:43:51 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e13so10622679plh.3;
        Mon, 28 Feb 2022 04:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/n04DAAy6NTAncSMZU/fUAYsk1NlkqyxPFCnG7ywoio=;
        b=qv3AxVdM1dwmQfDNhw99Z04ba3T03Ipac6lwppRsf5ao6Xo9OXs45ucMkAtSMnEV2P
         vayO5LFETyD8aVxU0t/N23hGsNbAgKx3a0lfXklWg0M7Wy9hsrvjr71hzsVmd2qJ/3Q7
         NVwirb4mjzPkzgPv9Q26P9LOWSKLU7axVJGzoYIxTBm5A8IENBnT2uqS2Qtyko8qr8Q7
         fnJZH8HviAkUvyMlPOtjwzDv2+1m9bJc2JSmt2XAQ97SETSo3KRCf7cX33YPruXjrsyh
         TDelEOXtICdRefWZSyKxWPUS2CQ3TwZLFH2Zl70NAi6fhmRXoPuok6Ak6Ow4KtyS4+9e
         1hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/n04DAAy6NTAncSMZU/fUAYsk1NlkqyxPFCnG7ywoio=;
        b=y2FqhB/YhMN9/TzUR/wa7Nol3PQW732svpxCH90zu/SuZg31qzs3W7Cd6BSks9+76D
         9afPlu+/dPcQJst+NeBaaktfRPY+G6B+WlElb7bgQeyXsV3V85VyUtZ0aldoDXfFJNgA
         IoATGazLoeC7NO+1uEsDmISi5RkdpbPmxxwNzorS76TpDLnkYwsZzuxt+wvmEJS4Bmjl
         bZ+/266E+Va1jlLa6ZoS++fE0VZn7YEekEDmfBSyClYHRN+fa40yZsgc1aNFHqYxIXvA
         XqLG4+0MNxqaUkF+Zd8IlTPB8w487okyLZAUThZaNMr6fdgEt1mlBZgv4jw7reJvyvmD
         fTBg==
X-Gm-Message-State: AOAM530CU10Q4FJN1BhcZc3YyJQubi1n6FOFz/CIWORFU8e/E/5XDF+q
        8/gmbJGGAYgnFokYNB41M+HgwIw6TljA5A==
X-Google-Smtp-Source: ABdhPJwXnYWUpczIZyfADpFl80koCgkjgM5Nl7e7lTmmqj9FC3f2XCvwOn2XunGXyF+n53k40jBW2A==
X-Received: by 2002:a17:902:e80c:b0:14f:f95c:41ee with SMTP id u12-20020a170902e80c00b0014ff95c41eemr19504178plg.31.1646052230892;
        Mon, 28 Feb 2022 04:43:50 -0800 (PST)
Received: from localhost.localdomain ([122.161.51.77])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b004e1bf2f5818sm14129214pfj.87.2022.02.28.04.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:43:50 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] DTC fixes for Arm pl022 bindings
Date:   Mon, 28 Feb 2022 18:13:42 +0530
Message-Id: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
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

This patchset helps in resolving dtc warnings for arm pl022 bindings.
Fixing requires updation to clock and clock-names properties.
One more dts fix is required to eliminate all warnings which will be
sent from other tree.

Please note, this patch is based on top of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git, for-next

Kuldeep Singh (3):
  dt-bindings: spi: Update clocks property for ARM pl022
  dt-bindings: spi: Update clock-names property for ARM pl022
  dt-bindings: spi: Add spiclk to clock-names property in pl022

 .../devicetree/bindings/spi/spi-pl022.yaml          | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.25.1

