Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B0056C1E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiGHTpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiGHTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:45:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78D983F1B;
        Fri,  8 Jul 2022 12:45:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2934837pjl.5;
        Fri, 08 Jul 2022 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N8DWxr3cOGfGJ0M5r5IGNCu5UhFIYsIjqooNs/duLE4=;
        b=Lo1aR/J4wYvMpA8tQzeQV1wC1mQDSWrvOC1QAgXLY/cJssAQeZhp3PUFHEtEnzvVu6
         T+VP1D7VEtf28FSvXqq5hv+AKW7bZ9abG+g43bXEskYKDXvsHxQKuKoGk9ja/5mMyzBi
         eLUlfsEVLCQ+EEMKMeXpTkdWeWN/SvOSw26rXN4ooPnVkLBoPC1hox0SPEwwN+bsxR9y
         iCiZ9sZHYCJasGKKO0uGaVoBgcnXBdHNvXpoO1viz0UCWOeTXEeF3uM0dCqjBz0eYLoZ
         3a9oWLorRP/WxUoZYlbHq7Wh8Vri6Jy+yACO74ke1sAdpIyjwO6WGZlyEa0TGyzcLtkv
         kFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N8DWxr3cOGfGJ0M5r5IGNCu5UhFIYsIjqooNs/duLE4=;
        b=c+kO+ieuSbxXjg10rzFPakfwG2PwUpUGTaF5h6cRjVDtYOcGc661tFKhPnhbdVcAH0
         BUCYWjUw0yXuJvrjHipBNVHxE92emD4r6JfmJhv/jgM7/2TSMn5WLaXTF4vCztQt86pw
         0ABw42OM/luMu+YOBEVhyESG06pAxGa9yipqaZK9R8J85efIwiLsb6tteO9ED10+fH5U
         oRCoQai2e0PgWhAMtx+ff1vDxD/00/cAsWY9092pW0sjtkUhgcwqcaJSybBpAboAjweb
         9v/ToGhNpDtoqpvK0Bs0EIvgVkdrhOk8CKbkUbFw8JAH4FNWSeHsAfJg11lwy9RA9FVj
         D2iw==
X-Gm-Message-State: AJIora/dNWNHT6QqOaiHeB1Y/PTvt1r6bXY/45aGEJaC6YyttlgjJJ74
        HZmYmbpfROIFW43DE0g5JSE=
X-Google-Smtp-Source: AGRyM1sKA/NE86R2wmVR+KhxAYqabDrR+Ti+/AoQzGgzdZR9rQiTHTywPJ5wdrOd0jjN/U/0NRATgg==
X-Received: by 2002:a17:902:cecd:b0:16a:5cab:4721 with SMTP id d13-20020a170902cecd00b0016a5cab4721mr5301233plg.104.1657309507293;
        Fri, 08 Jul 2022 12:45:07 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o9-20020a63e349000000b0040cf934a1a0sm28160649pgj.28.2022.07.08.12.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 12:45:06 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: broadcom: bcm4908: Fix timer node for BCM4906 SoC
Date:   Fri,  8 Jul 2022 12:45:05 -0700
Message-Id: <20220708194505.1857628-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708182507.23542-1-william.zhang@broadcom.com>
References: <20220708182507.23542-1-william.zhang@broadcom.com>
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

On Fri,  8 Jul 2022 11:25:06 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> The cpu mask value in interrupt property inherits from bcm4908.dtsi
> which sets to four cpus. Correct the value to two cpus for dual core
> BCM4906 SoC.
> 
> Fixes: c8b404fb05dc ("arm64: dts: broadcom: bcm4908: add BCM4906
> Netgear R8000P DTS files")
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/fixes, thanks!
--
Florian
