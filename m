Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7940542BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiFHJrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiFHJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:46:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAEF1CC5E2;
        Wed,  8 Jun 2022 02:12:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o7so6872810eja.1;
        Wed, 08 Jun 2022 02:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BqLwO26NLp+1ZTSb5UUYEKQhj/0MyC5LksJjVWCNpWU=;
        b=kpvfy88MJSkG0hIy5RuOI4do24taDNVHsCDwfVQPCT9SHc9XIJyD5J3d2nGpl4Trt9
         e+QiEkhfgwyU2m9hg72dR/LP59sBrDEEpDactJwS1xbFp2PBTDePVFdY6lGkjAkHlm4x
         3Lq+0smfdHLMUesQoJr2KevaGvlBqOOydc0mGs8FpVerSJpxxqGI7d0rmldFR6JfzMuz
         wLCgrgayGFrKwvZSNmBg7COSMuw63+ZQcy4wK0RUMi1nB/VzP2VHdv8hJVaHsydOcMAU
         DdKb+zbEGjJWaGOfNBsby3Jun8K0Qhp4h1XiE9pcSGZPTmYNlDWJIkO9vx3z6REe2Pw9
         lOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BqLwO26NLp+1ZTSb5UUYEKQhj/0MyC5LksJjVWCNpWU=;
        b=I0wImtfNFxfSCq+vOOpTPcIgtbQo8CIDtIHCK7j7on6jeFtbWnD+ndJP5oHbjhcTP/
         uTI6FNCg99MpbIcimmxk5FHNcdDgyFLsG8TFU6hYIfzlce6otqCAm++YzDmzCquCuSsB
         ldOlTekcGfVe47tmw33cuf4hv1T2gt8n+7SLTNgoXPjwYKyIo5jMDW1uPjcPBVvDJuQr
         7BleImhGbwrNR9cL5EkN/b/Y226XUFCgP3auwzdJTD+algO9FcSJgSlXY60bttZgM1cr
         W1k3FLn25a5YBxhHlD9gr8WgBCT9clDizXhLJNbbJy1P67U+DtOdqFQ958U68PGS9ADv
         AdtA==
X-Gm-Message-State: AOAM530/ZeN3iOfP59Nk2p9w1U2HlB3NnnbEiCKEdf1rpVHvn5n8j5rW
        gvcIDkYrfdemQQOF3jpb6F4=
X-Google-Smtp-Source: ABdhPJwDFpiUhdmOYeiNAeI1blhEnQL0hLzCE8nHHw5t2M/oMFogPUBoLdJHShrhWpgfhtCga/7S9A==
X-Received: by 2002:a17:907:8a13:b0:707:194c:30df with SMTP id sc19-20020a1709078a1300b00707194c30dfmr30840946ejc.154.1654679570986;
        Wed, 08 Jun 2022 02:12:50 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.112.100])
        by smtp.gmail.com with ESMTPSA id bs13-20020a056402304d00b0042bd6f745fasm11789870edb.92.2022.06.08.02.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:12:50 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v4 0/2] AD4130
Date:   Wed,  8 Jun 2022 12:12:36 +0300
Message-Id: <20220608091238.403897-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AD4130-8 is an ultra-low power, high precision, measurement solution for
low bandwidth battery operated applications.

The fully integrated AFE (Analog Front-End) includes a multiplexer for up
to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
selectable filter options, smart sequencer, sensor biasing and excitation
options, diagnostics, and a FIFO buffer.

V1 -> V2
 * add kernel version to ABI file
 * merge ABI patch into driver patch
 * make copyright header similar to other drivers
 * rearrange includes
 * use units.h defines where possible and add unit sufix to
   SOFT_RESET_SLEEP define
 * remove ending comma to last members of enums / lists
 * remove unused FILTER_MAX define
 * use BIT macro for PIN_FN_*
 * rearrange SETUP_SIZE definition
 * group bools in ad4130_state and ad4130_chan_info
 * put scale_tbls definition on one line
 * remove newline before reg size == 0 check
 * put mask used as value in a variable
 * remove useless ret = 0 assignment
 * make buffer attrs oneline
 * use for_each_set_bit in update_scan_mode
 * use if else for internal reference voltage error checking
 * inline reference voltage check
 * check number of vbias pins
 * remove .has_int_pin = false
 * remove avail_len for IIO_AVAIL_RANGE
 * remove useless enabled_channels check in unlink_slot
 * remove unused AD4130_RESET_CLK_COUNT define
 * only call fwnode_handle_put for child in case of error
 * default adi,reference-select to REFIN1
 * default adi,int-ref-en to false
 * of_irq_get_byname -> fwnode_irq_get_byname
 * P1 -> P2 as interrupt pin options
 * add missing comma in db3_freq_avail init
 * cast values to u64 to make math using units.h work
 * add datasheet reference to IRQ polarity
 * add comment about disabling channels in predisable
 * add part number prefix find_table_index
 * return voltage from get_ref_voltage
 * add datasheet reference for internal reference voltage selection
 * add comment explaining AIN and GPIO pin sharing
 * parse channel setup before parsing excitation pins
 * only validate excitation pin if value is not off
 * use FIELD_PREP for bipolar and int_ref_en
 * put devm_regmap_init call on one line
 * introduce a slot_info struct to contain setup_info for each slot
 * enable internal reference automatically if needed
 * decide mclk sel based on adi,ext-clk-freq and adi,int-clk-out
 * dt-bindings: use internal reference explicitly
 * dt-bindings: set type for adi,excitation-pin-0
 * dt-bindings: set $ref for adi,vbias-pins
 * dt-bindings: remove minItems from interrupts property
 * dt-bindings: remove adi,int-ref-en default value
 * dt-bindings: remove adi,bipolar default value
 * dt-bindings: inline adi,int-ref-en description
 * dt-bindings: default adi,reference-select to REFIN1
 * dt-bindings: clean up description for diff-channels and
   adi,reference-select
 * dt-bindings: add more text to interrupt-names description
 * dt-bindings: turn interrupt-names into a single string
 * dt-bindings: add maxItems to adi,vbias-pins

V2 -> V3
 * dt-bindings: add interrupt controller include to example
 * dt-bindings: remove $ref in diff-channels

V3 -> V4:
  * handle watermark value as number of datum
  * DOUT_OR_INT -> INT
  * AD4130_8_NAME -> AD4130_NAME
  * return early in case of failure when parsing fw channel
  * use IIO_DMA_MINALIGN for aligning buffer
  * add comments for fs_to_freq and freq_to_fs
  * remove support for other variants because of unavailability of model ids
    for future chip variants
  * remove support for db3 frequency because of inaccuracy when calculating
  * remove ternary where possible
  * refactor defines
  * dt-bindings: add unevaluatedProperties: true to channel node

Cosmin Tanislav (2):
  dt-bindings: iio: adc: add AD4130
  iio: adc: ad4130: add AD4130 driver

 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |   36 +
 .../bindings/iio/adc/adi,ad4130.yaml          |  262 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4130.c                      | 2015 +++++++++++++++++
 6 files changed, 2335 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 create mode 100644 drivers/iio/adc/ad4130.c

-- 
2.36.1

