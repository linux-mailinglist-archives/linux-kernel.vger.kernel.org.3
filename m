Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADDF56C23F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbiGHU7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbiGHU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:59:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91FAAA;
        Fri,  8 Jul 2022 13:59:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 145so23276685pga.12;
        Fri, 08 Jul 2022 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YumDX3Rw5usdLXzWSPJ3aNUPaMpayhBDq62c6xot/8=;
        b=gwDAB2SMLWdrllCWlWjMefARRZYH/5q1tc7TvoRjTas6Ejqt1DE7Z8I36zXB+y7pgu
         tr4H+6ihbh4OtJK1FlmSWZXkB8UcVyzfMX9/5kkkGqsWU2rgeqOA96bVDeyymYfW8s3z
         wVBqkYe7C0ATflOZQHDrealcidr0/JJPwJn2fp/joXcwBxBh0blEQ2SLigm7V9MO4Acq
         9vjpjiVC/yINkHpS5VHdl5L4jJ8e17WmhV8gV6Tisx9dCBno8hMmuyQO+Z0Ed8w4lefI
         24R523PVI0S0XOPdk50O1n9eGj0qQgxanV0xRDW4OtCfuTV95bkWpSDQBC0JtDYjSFLi
         YsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YumDX3Rw5usdLXzWSPJ3aNUPaMpayhBDq62c6xot/8=;
        b=KaV4GXzl3hWjZr9jBKIpTG09JejtUSMWQssAB0NTnnK4EOsLMHuZIfBol4OTa8L9+a
         WbOKEhKoED+yCiws8G4Bgi3x1fz4Gv2xlhUjgMGVVEXCyMIWX9C+n8UebHi/Lmu8FRe+
         qNr3+7hXBEfqJ4L/QU03VfNpGefCp+oxxI3utOXR74lFT593LzREJSpb7Ra4Pwi2XIFb
         6sGmSe/Q1n5RXLQ1VvYhnvOnZYsjIypx0jsE/YgFPOx3hmC0IoR9Odk0ImQzlo2Zg4jV
         gqedTVyNrvCUDEa9RSfB/kl3LSWx0JCW6MboWKJYQJt5NEQ2hK0+ZPm97JB6HG2rx2dX
         xFCg==
X-Gm-Message-State: AJIora8/jGCh3a7HT9GVBThOdqHYQbGL9QUjzhbG5+RwBgvnSNXk+y00
        ZX8l0faf3196WzS4M7qp5gM=
X-Google-Smtp-Source: AGRyM1uEB5UGVB6IPxhLTkAteB5sbJyMdMn6gSm+5nIc9sV94rKH09QdwQlru92Dzp1razOpH4QefQ==
X-Received: by 2002:a65:6801:0:b0:412:b42c:9d3c with SMTP id l1-20020a656801000000b00412b42c9d3cmr4761768pgt.525.1657313976231;
        Fri, 08 Jul 2022 13:59:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id az8-20020a170902a58800b00163d76696e1sm30261169plb.102.2022.07.08.13.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:59:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] ARM: dts: update dts files for bcmbca SoC BCM63138
Date:   Fri,  8 Jul 2022 13:59:34 -0700
Message-Id: <20220708205934.2438412-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707070037.261532-4-william.zhang@broadcom.com>
References: <20220707070037.261532-1-william.zhang@broadcom.com> <20220707070037.261532-4-william.zhang@broadcom.com>
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

On Thu,  7 Jul 2022 00:00:33 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Update BCM63138 board compatible string based on binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
