Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A508055E917
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347193AbiF1OrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347172AbiF1OrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:47:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B811F2E085;
        Tue, 28 Jun 2022 07:47:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so10056376edb.9;
        Tue, 28 Jun 2022 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvKr5j/dub3wuJesSofmLHXw6F64QcEksX3Kp+Javoc=;
        b=RKxx5lIrgJKpT7BgPk7abz4kuj3DLCCMU7pE5aFCFtrzchYJ9OY/63IqU6m1P2zyGc
         sCyZ3hN7QHRm2E00u6sogsNLK7VZ8xp2Kls0RxJhAGFKqZrG8E8ZwfgUTDagdekk/zQh
         sEm9ORMFT781gbrXSKj70WBSWpEs85BPdK9ME21fclm65sndYjVyWV8ybE4ep5cf9uZA
         fq62HgM3GmZeP66meaOp82Fj4A48YqF+uEA+xBIbgCntCsJbm/7o49jvzvEd8xG63nwL
         DIHSMV8d2X0bQ3IbMrV7WFNfx/RTmgbHfGPZoVS4D60vPsrzBczygJdOTx8pTTgYiMCr
         WQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvKr5j/dub3wuJesSofmLHXw6F64QcEksX3Kp+Javoc=;
        b=w2NGichhvwQ3rqpyJJ+DYIUXSW8mf4KHhR75kfHY+WPVP/t/nG6o5Taqd0JpFP3LW8
         xCmDbFBS4WrgviX/N3waYic7Mb/WIGNWITcrJpfTXxV9fX5GVDaj7cjBgrwSTEb080yH
         GL6oQdPAJUKLFhkw0chXPbdy/xKrDcoUZIKdsVtmhLhf8he9he7htEegXqu8xd2+RN9X
         hsSjfwaGQ3ZHBkVSfK/ZhpkQeV9tg7EgYK57PdhvdK1mKcscQ6tRlFkdEWBbvN6LAjFC
         z1j7jvv6CVv1t93BnicqFNnNokaxXu/g6l9vv/ZUon+7xzugV1R77OGDSE6TItf4oY7p
         PP+Q==
X-Gm-Message-State: AJIora8xoP60z83S/O6i+a4NdABgLy6j4LsTd420iSmDHeyFi1sQUfTN
        fEaKWH8aD36wL2s3mp4WGs7SZi68fn0=
X-Google-Smtp-Source: AGRyM1uFDh5YebcLOf5IY7T7KFRlo6yv30GAubrbREsf25E0mWYjuI9s1slbjQNTqkhTLPqfCu4Ihw==
X-Received: by 2002:a05:6402:2948:b0:42a:ae0c:2f26 with SMTP id ed8-20020a056402294800b0042aae0c2f26mr23704552edb.425.1656427621242;
        Tue, 28 Jun 2022 07:47:01 -0700 (PDT)
Received: from demon-pc.localdomain ([79.119.98.153])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906825300b0071160715917sm6460537ejx.223.2022.06.28.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:47:00 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v7 0/2] AD4130
Date:   Tue, 28 Jun 2022 17:46:47 +0300
Message-Id: <20220628144649.3957286-1-cosmin.tanislav@analog.com>
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
  * remove support for other variants because of unavailability of model
    ids for future chip variants
  * remove support for db3 frequency because of inaccuracy when calculating
  * remove ternary where possible
  * refactor defines
  * dt-bindings: add unevaluatedProperties: true to channel node

V4 -> V5:
 * simplify get_ref_voltage function and move print statement to first user
 * inline statements not going over the 80 cols limit
 * simplify scale table filling
 * determine table length inside find table index macro
 * current_na -> tmp inside ad4130_parse_fw_setup
 * define full register set
 * put range register size definitions on one line
 * nanoamps -> nanoamp
 * adi,ext-clk-freq -> adi,ext-clk-freq-hz
 * return directly in ad4130_validate_vbias_pins
 * place comment regarding irq_trigger at assignment
 * inversed -> inverted inside irq_trigger comment
 * do not initialize int_clk_out
 * return directly in ad4130_validate_diff_channels
 * add () after reference to update_scan_mode in comment
 * use BIT() for channel offset
 * comment nitpicks on slot finding
 * return -EINVAL out of reg read for invalid sizes
 * place regmap at start of ad4130_state
 * place bools at the end of ad4130_setup_info
 * remove commas after terminators
 * dt-bindings: only allow one element in reg
 * dt-bindings: inline reg description
 * dt-bindings: remove $ref from adi,ext-clk-freq-hz

V5 -> V6:
 * bump KernelVersion
 * use IIO_DEVICE_ATTR_RO
 * nitpick inside mutex comment
 * use valid_mask for validating gpios
 * improve DMA comment

V6 -> V7:
 * remove $ref from -nanoamp properties (to be added to dtschema)
 * use hexadecimal numbers for channel unit-addresses

Cosmin Tanislav (2):
  dt-bindings: iio: adc: add AD4130
  iio: adc: ad4130: add AD4130 driver

 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |   36 +
 .../bindings/iio/adc/adi,ad4130.yaml          |  256 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4130.c                      | 2014 +++++++++++++++++
 6 files changed, 2328 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 create mode 100644 drivers/iio/adc/ad4130.c

-- 
2.36.1

