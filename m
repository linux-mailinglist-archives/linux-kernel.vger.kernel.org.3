Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A5507169
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349950AbiDSPLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348100AbiDSPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:11:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806F3A722;
        Tue, 19 Apr 2022 08:08:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l7so33613678ejn.2;
        Tue, 19 Apr 2022 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuZNI/cdrd7ALg+RLxl3FV30JyJrvpFFZT6HJ8etR/M=;
        b=mHCGGA+HwKe5Avh4edsQcx1cukyJHQ9H3oa/kH0Me22SKnWbv7lqDHduCdlb63FPOz
         Cvl0G3zaxZt8vbjP/7rGEhyoKnhguJm9KUZu0a0sCjINkdGL8gTO8gr7P7pgRTvvyZyI
         x277s4RAu7nKEwaw05NRKH/NmAnduOmsQfhRi/21n+fydauYzVq+PdaJGEopTug3uXDj
         HGEQKlHoWyVIHTTILTSxB+TGRmjzMquUEPI8c17Mc9nzFT3ieMsH5zEzuC3ndg2oCRD1
         8C2ZCmi/9SnWS+N62ZKmH7QLUcmM3y6J4Egqs+XXSAUSTx24zdCiIFFEyOEeLVRJoWNy
         23+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuZNI/cdrd7ALg+RLxl3FV30JyJrvpFFZT6HJ8etR/M=;
        b=WAKsrkZFaJnoqrp57OLdgRdITYFpj8fYORvPs7SaF/UAlg/rVZCuBG3EN03DgmACOq
         4QgMefwGhyhO0NSH3+l16DeOn0GUddPw/6xQ3Y0jSgDzcOJcOgPjh1jQEm7UeZu45AW3
         wlHxslCOKqjErJfjtgESt4yqdAMTJjOEPuwiYxma3ZgD8JqmTUzCuYDw+0MQFKxxIYY5
         JwHPOXx1A33WGodEDLpfIFDmurfVSYgg4hpS0k6Lhej7J+oh4TfQBzULoepjSDp1s48E
         vQPDC4rw+yLtEdrXrhVW385LliK+ynYpVKxAxa92/a5Fs7n/FQbEYio03UlB7MUEcWNG
         s0KQ==
X-Gm-Message-State: AOAM532/+rXTdh/hWHN+yzEV6HujeeN5ZOOdACl+gr0PaC25J6xfSH+I
        8/lv0I+qjgWjbQWBQf/30XHBGqEzQjc=
X-Google-Smtp-Source: ABdhPJx2/qBZoX9K8AvhlL70ZPhwxQgrhkQaPYSI7sH/d2bfaV2+Tgim0mEoH6k7qRke3gj0U7IGuQ==
X-Received: by 2002:a17:906:5cb:b0:6cf:954:d84d with SMTP id t11-20020a17090605cb00b006cf0954d84dmr14390613ejt.560.1650380916414;
        Tue, 19 Apr 2022 08:08:36 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id m1-20020a170906234100b006ef83025804sm3548604eja.87.2022.04.19.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:08:35 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v3 0/2] AD4130
Date:   Tue, 19 Apr 2022 18:08:26 +0300
Message-Id: <20220419150828.191933-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.3
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

Cosmin Tanislav (2):
  dt-bindings: iio: adc: add AD4130
  iio: adc: ad4130: add AD4130 driver

 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |   36 +
 .../bindings/iio/adc/adi,ad4130.yaml          |  264 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4130.c                      | 2078 +++++++++++++++++
 6 files changed, 2400 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 create mode 100644 drivers/iio/adc/ad4130.c

-- 
2.35.3

