Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7464D52C3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbiERUCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbiERUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:02:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD3F15AB2F;
        Wed, 18 May 2022 13:02:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j21so2897896pga.13;
        Wed, 18 May 2022 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pA4F+AF75ygBxpN2DZp2ZVuWLP66moDrAbKv6OgKxgQ=;
        b=M29TBgau+hwR582eyxTY6zmUFXN4l9DOqmxrQ779j0k8hYlv9Jvbb+jH5PPU9eXRiT
         2Ttjfu7LycGwAZZPE7IzIqvcvZqu9cETAhr8PC5KlitMfQxKtu9zoXFRR2jk+79VJEK/
         06qzMZBO/MjfCGoVjj9OexK6oltNzmDwB7WPogSmrgrs7YhbIio8TJCPMqF/94nGKSQl
         6s7Ap/iDPe+5lcvcbSCnGw3Go+Xac0Gkv/3bwXb4eKdriOZ15Ccjf3p/4T/JAED3txwY
         tE0+kCmUSI2tH7n4HF2s+a1T5m3H9IUEkbhli4i7G01WsLIqXYJ5/3ofWf842WPb4MLx
         dTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pA4F+AF75ygBxpN2DZp2ZVuWLP66moDrAbKv6OgKxgQ=;
        b=q6bIDxO7xbtpWtpanfXIMGtFRCkcfDvFnseQvYzzOiIVd3O0b+SFKBjPPgsnOEGSIl
         JXHK2Kzrut4YSp+fNhOc946SYTlkawTZbSht7qxTYEGDI7H+oyXklolEmVzHy9F9Ko1k
         hzKvydRiu69SstRZg5WLye8lcLA5S7ByQOremFaxb2BcbTx8uah9qz06eASxRn6BsyMN
         5/LtUe2fwx6HVLzP5eWh9rCK/RXtpTMSbf+Cvv+4E2lzcssvUKwDKfY3jih8h4zHtRpJ
         3cIJGkBxvpqt5jCKjX/EtKBmchK/f4sA+73bTOBFOMwarT03YDXbeGMSJfcSCTq3bJ8t
         oCCw==
X-Gm-Message-State: AOAM530BH2cwvBluaKrDgg4EM/P5+oCrYjliIn/rz1uT1+d8aFvHIYzY
        jH55GysFHCIWgAnI/RzQZxE=
X-Google-Smtp-Source: ABdhPJzZNqK5Q1DOU4BZhv84sq8isrqHbnePyKFmEkEPzi52QKFG4d0RARKyKOQQdJKHZ0YBxqPhfg==
X-Received: by 2002:a63:ea4b:0:b0:3db:5325:d55a with SMTP id l11-20020a63ea4b000000b003db5325d55amr911721pgk.588.1652904129567;
        Wed, 18 May 2022 13:02:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j8-20020aa79288000000b005183112db97sm1311189pfa.74.2022.05.18.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:02:09 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Anand Gore <anand.gore@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        florian.fainelli@broadcom.com, kursad.oney@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: add BCM63178 soc to binding document
Date:   Wed, 18 May 2022 13:02:07 -0700
Message-Id: <20220518200207.323175-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516103801.2.Iec642f72ecc8fe0178cd94faba372e89296168dc@changeid>
References: <20220516173808.1391482-1-anand.gore@broadcom.com> <20220516103801.2.Iec642f72ecc8fe0178cd94faba372e89296168dc@changeid>
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

On Mon, 16 May 2022 10:38:07 -0700, Anand Gore <anand.gore@broadcom.com> wrote:
> Add BCM63178 SOC device tree description to bcmbca binding document.
> 
> Signed-off-by: Anand Gore <anand.gore@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
