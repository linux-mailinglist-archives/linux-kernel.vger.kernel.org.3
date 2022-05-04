Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8451A325
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351776AbiEDPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351730AbiEDPKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:10:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CDD1D0FE;
        Wed,  4 May 2022 08:06:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p7-20020a05600c358700b00393e80c59daso2775914wmq.0;
        Wed, 04 May 2022 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLmxdEGvqe0b9xKOHj+/DgoHCwSTpZrIfVZVX1IGYVE=;
        b=RJ5Y+sMQpd20ZyIJH1JA5wTBSuhhYBuHYRDaWB21Q8hJk+0dSFTKTxpwt/e11XBGQs
         GkHQqeZoac8FqFZ7bOwyic+hNGBcWM/3ZHSxsgiEZS/aAAozjV7vkK26hQnU+t1Q3zwU
         sLjCJpUI+aexAU8HQDvF/5ogQErLQELeV+E9hhiB2gDfGWlkfyW1BokC/Vhpc1ujjhjC
         s9osgfDoi1Y49kiIrk2y3K6VjBOmCcgW460LAV0Bbbbp7a3ObNum5R4UoLlWMfbCn942
         idZqZ7pvkPYITEnrVuJak+PHDrAHbPKsuDzWdfVJ1NcDehZKfSQFS6ss6RDKj6tmAI+M
         La9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLmxdEGvqe0b9xKOHj+/DgoHCwSTpZrIfVZVX1IGYVE=;
        b=HMHm4RksbdvhiQWdgLnzEYygAi+jZPWtMFDPAUnlkgFMOkKEUltznxiGS848qaCAwr
         53N8u0dixrr1zAIKnm6aOVWi3jrKtUCWegb7vjoKZB486eFYVEImui1M0jfMgdzAIKma
         mPEqTukZLIQcmZ/xQbigBgbMjMPYdVjE+2smqtsvIlylU3lMoALsKP2KGFjI6nLNPs1i
         YLrwFs9wrfTqNcY9hWBhLTBXUFsyGdfpSJEsPxNWeA9MmelOQNWfRIZnxGVUPEmKf+QI
         LyvRdcoiZzaIXppVSHX94bS4O55NwRvoPZfU0M+TjXRwQ52oE+ECuM+diZ5sau4NIGGr
         YzBw==
X-Gm-Message-State: AOAM530Hr/ZmEkEnlB/lkA7TnW0ibU+6h5YlaAgQtahfQU+z+e7bxfFD
        AgQxyKaeyETb7oXXFErACdw=
X-Google-Smtp-Source: ABdhPJx+qvrlmXgsYT5R8LTc8zrOEgffWUXrPSoe9HJXdVRJcuiV8a4dw5YQactUmt24rxBGG0DTRA==
X-Received: by 2002:a1c:f606:0:b0:394:1a21:f68c with SMTP id w6-20020a1cf606000000b003941a21f68cmr8183075wmc.131.1651676806706;
        Wed, 04 May 2022 08:06:46 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id q14-20020adfaa4e000000b0020c5253d91fsm12143596wrd.107.2022.05.04.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:06:46 -0700 (PDT)
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
Subject: [PATCH RESEND v6 0/2] Make AUX gpio pin optional for ktd2692
Date:   Wed,  4 May 2022 18:04:09 +0300
Message-Id: <20220504150457.5626-1-markuss.broks@gmail.com>
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

