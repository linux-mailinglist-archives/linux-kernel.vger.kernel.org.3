Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68FC51A44A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352678AbiEDPns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352614AbiEDPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:42:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED7C165BB;
        Wed,  4 May 2022 08:38:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so2588220wrb.2;
        Wed, 04 May 2022 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtzdCLQ1sMXip1wJYQTCTJSMcVxnPKUWI694G3NFHYs=;
        b=QF6KL/3YVxfI4tf1KSfxllilhSSRMCc+0qW7eYARjEJ8W0X4GuaRhErkXsYRmMUIKD
         QRAzVYg/mi1u530dbD1YaQdlXveHquKCJVq9ytiQQFyjK84Oo5rvziZg5pJLcib3CkEr
         aEmfb7ZVvX3wtDemSXO88gPnCa9DYZS/OcCwH6rSBFx9iySklqAcpVRhHNF8cTec3uD/
         8jYzQbcL0dN+9CQ5ZxzIwoCPf0XUqOLmLyQVmMh9iamAA8huL7/1+k1+YKXJpESk2tEi
         gBkVLla254GDSd9Y3fzxFpEG/9mLY/ysH0QwRGhpq4MG8MbzKzcDcxlV0yx5DJrODt9d
         27gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OtzdCLQ1sMXip1wJYQTCTJSMcVxnPKUWI694G3NFHYs=;
        b=gPpve8RFQHspW9AylbnUZRBFQVdd/1bpEJhcjykLcnK6eCYcxI5yGg6AacaBr+hi4g
         sK4HjiEyx4vez1MK4w4wffJVK8RxEqDzC+BrFupTu8QYV0E5t7sexGvbIe4wCycrThE2
         UVyFV6KCJwBMXP8roGl4cNu4kpARWpmVoJbzR9miYS+UMyAbLt+DKqiQ/gB60aoyWU+C
         bK2MeO+6IwZNfMWHFUvzcYD4Q9GLz6m6sN5Hv7a5UUq0BwJDIbSdWcdv1I09z7eTSQCR
         YVaezvgc6qW9Au+trlZe3PKm6FdbSy8/XDAnvZNOPC//s8Kg2Ivt/wndAFlfd6O5LB9y
         8Mmg==
X-Gm-Message-State: AOAM533OMUibvtzj5Bkr8oTgU6MPP4yXnfpLx0EII98PgVxaQChZEXcJ
        xcV+NQjmeAOZCj4faEUC9B4=
X-Google-Smtp-Source: ABdhPJwDfwdiXHKaFHVytyamWAxEwb4UMu8aQ+oSMVF4rtlgGbsxjnSp8fwnhw9uDDPtqSCnIaFitw==
X-Received: by 2002:a5d:66c8:0:b0:20a:c807:6061 with SMTP id k8-20020a5d66c8000000b0020ac8076061mr16711076wrw.399.1651678704376;
        Wed, 04 May 2022 08:38:24 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id e18-20020adf9bd2000000b0020c5253d8besm11792725wrc.10.2022.05.04.08.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:38:23 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     pavel@ucw.cz
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 (corrected v2) 0/2] Make AUX gpio pin optional for ktd2692
Date:   Wed,  4 May 2022 18:38:09 +0300
Message-Id: <20220504153814.11108-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Some appliances of ktd2692 don't have the AUX pin connected to
a GPIO. Specifically, Samsung Galaxy J5 (2015), which uses ktd2692
for driving the front flash LED, has the pin not connected anywhere on
schematics. Make specifying the AUX pin optional, since it is additional
functionality and only affects amount of current going through the LED.

Also convert the txt device-tree bindings to yaml and pick up maintenance
over the yaml binding and the driver itself.

v2:
- fix the dt_binding_check
v3:
- set the aux_gpio to NULL to avoid passing ERR_PTR as a gpio
v4:
- maintainership -> maintenance (description)
- remove the if (led->aux_gpio)
- use devm_gpiod_get_optional for aux gpio
v5:
- use ret to pass a correct error return code (Christophe)
v6:
- use PTR_ERR properly (when IS_ERR is true) (Christophe)
v6-a:
- ended up being a mess, corrected-v2 should have proper tags now

Markuss Broks (2):
  dt-bindings: leds: convert ktd2692 bindings to yaml
  leds: ktd2692: Make aux-gpios optional

 .../bindings/leds/kinetic,ktd2692.yaml        | 87 +++++++++++++++++++
 .../devicetree/bindings/leds/leds-ktd2692.txt | 50 -----------
 MAINTAINERS                                   |  6 ++
 drivers/leds/flash/leds-ktd2692.c             | 18 ++--
 4 files changed, 103 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-ktd2692.txt

-- 
2.35.1

