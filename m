Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686E45693F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiGFVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiGFVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:12:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF2C5FD3;
        Wed,  6 Jul 2022 14:12:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sb34so29105958ejc.11;
        Wed, 06 Jul 2022 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlRWy02zusIsUjy51IfsD8EFF9idJBdnV6TtlGLlG7w=;
        b=qb9e6xSi4YGj99hCl0LmSEu/pPb9/2huufM19YOqbwjGovUNz/nkedAAuYTdgVbEe4
         3r4ZLOnNmk+33MNs2qmv+ah1Zn/uCM9RRIT02m0bWFpP06MrYg3g13O5gTUtWIEgLhl/
         NbGNEIBmDTuUuGM3YfG8uZ0F12LgtMQcX/q1O3LyiSsyt8X/EhlTLHJf4c5X96f4ggWb
         ic1Cg88PumAbnvwpv3xml4Bue+3hLaI4Db2ObHNt64UUJOadcLTtqo1cmekhLvvt5MFi
         m1oUiT0j5Fm85+3I1byfRfoIX4kaGmok55tHrJOpd+wt24tYej40KeVjG6xmElpjDQo1
         L+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlRWy02zusIsUjy51IfsD8EFF9idJBdnV6TtlGLlG7w=;
        b=zGSzx4eEPiqWk5e7GkLw4UGgnMbUlX1fKhcumdy1Qrgwud9Bb7pMg809nOdptbbnyE
         kqoVY+Z2hFhhQjis/kithKBzSw3Nq/gl9EWvWXPzRveNPWQojgtDNnxwnPNiUEjz8ZFD
         p2iaQ7n21hhMLzLD3VHYN2Yvyu32tVG6fbTsvpuuq7aqtS68FkM/BJ/7zuspjmKqCKpa
         JrCEyd6KNVEJ2Dj2UYs/Bmb825CASx/ISL8ZNj/JD7wZQ5aOAOnjLngEOrP4qlwh0EHV
         UUc/wE1WtYrcEErkEQ7C1abmL8kbA3VVQ8NcQflCQ9bmzD+t2v04urJzdMT9shDp8a/A
         yuSg==
X-Gm-Message-State: AJIora/egjdTnxQBY2ZyM8AwOJ5++GqfJTXVoOtjOtutBFu8c8CJn6zp
        WpVYxMZVD7DXzNMUk3AYriM=
X-Google-Smtp-Source: AGRyM1tEqj+EobmWuQAZP9TOvfu4OSdAJ6ycBMd+DooaOHHdPJh4Pa2wJeAu7SqQ7bPcc/fUaulPbg==
X-Received: by 2002:a17:907:1b1c:b0:6fe:f1a9:ef5a with SMTP id mp28-20020a1709071b1c00b006fef1a9ef5amr42622029ejc.233.1657141957227;
        Wed, 06 Jul 2022 14:12:37 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b0042617ba638esm26409412edt.24.2022.07.06.14.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:12:36 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] ASoC: cleanups and improvements for jz4740-i2s
Date:   Wed,  6 Jul 2022 22:13:19 +0100
Message-Id: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
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

This series is a preparatory cleanup of the jz4740-i2s driver before
adding support for a new SoC. The last two patches lift unnecessary
restrictions on sample rates and formats -- the existing ones appear
to be derived from the limitations of the JZ4740's internal codec and
don't reflect the actual capabilities of the I2S controller.

I'm unable to test the series on any JZ47xx SoCs, but I have tested
on an X1000 (which is the SoC I'll be adding in a followup series).

Aidan MacDonald (11):
  ASoC: jz4740-i2s: Remove Open Firmware dependency
  ASoC: jz4740-i2s: Refactor DMA channel setup
  ASoC: jz4740-i2s: Convert to regmap API
  ASoC: jz4740-i2s: Simplify using regmap fields
  ASoC: jz4740-i2s: Remove unused SoC version IDs
  ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
  ASoC: jz4740-i2s: Remove some unused macros
  ASoC: jz4740-i2s: Align macro values and sort includes
  ASoC: jz4740-i2s: Make the PLL clock name SoC-specific
  ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
  ASoC: jz4740-i2s: Support continuous sample rate

 sound/soc/jz4740/Kconfig      |   3 +-
 sound/soc/jz4740/jz4740-i2s.c | 351 +++++++++++++++++-----------------
 2 files changed, 177 insertions(+), 177 deletions(-)

-- 
2.35.1

