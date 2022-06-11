Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED954737A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiFKJ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiFKJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:58:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFE3B84F;
        Sat, 11 Jun 2022 02:58:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h23so1483981ljl.3;
        Sat, 11 Jun 2022 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8fgBWB6Fwlc80DQzKSjfadMQq9+v7sFm69/tgJcyx8=;
        b=b+UduNbJq6kwMAPQgOSuaelsP440nPLKh4mZNI3OJpp2oPfpLd8jEkPyeaqxDaKLJu
         g2to7UoslpP80cXn6z2d3qsl+M/hHOAvRJNxZpCs24LeofPfHiZO5kHpvvjZIGxkidUt
         1depfTDbzezsOVlDTMpTQ5C0hPJXeIA5R5ddm522GuKkCuuweAHHWKKnTWzz1hMK3iUb
         4fatkiOpOUAXZLb1MLbF8mYVW6Bf7KtMWmyEzdGU0yfP+aqpDPVUWDs9bScFm+qRwCSI
         zrspBZcGZteC4lgw0N1VXd5yhxOfzhGrcnHTEKm31qag+MEqbBH4aYVq5EHw2vATzIGs
         07hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8fgBWB6Fwlc80DQzKSjfadMQq9+v7sFm69/tgJcyx8=;
        b=d2tnrjm+u9knNv3xz0OWqCFxz/nFIB9WIEMJSBpPP+UmTEEQS/VixWrfqA/6zt+UwS
         Yrd6MGHFnR5CkcmCEt9mEDx/eHrBr0upn5kg/+TRJr4tDghoRO7HETcz4mFdDLZ9L9V5
         QzRhVEKvpYci6d9zN8X56RBIfEFs5Ry/LGs+QuOoIvPMJVgIgipa/0e9GrMbxX1L++jb
         hh0pK8eqSA06kmddXA8SFbVtyErZ3yXxH8026Ya9AIkRNzk8ukoVWWeO3CTgNFn5jclv
         q+zFMGPk8sTApZNeG98zMEia3P26ANR7xSeSj6nBaFRTvmMc3gAaJPyeuHPI0vtVmj/l
         9D5Q==
X-Gm-Message-State: AOAM530sco2WPuWxQoAbk0OLQOpp88901Ic4QsUgXlobv0X2Hq9j/FeO
        a19Es5ZBxuPIpj44Kgjocc6aCNNvDeL0/ZXP
X-Google-Smtp-Source: ABdhPJwzkJ9Xi37kvu4X5cJKh8Gn6rL6I+HOKpwZclM9Wm2twJohgXGGrRlhPOPl63T2tv3oattPFg==
X-Received: by 2002:a2e:8686:0:b0:255:8474:f3af with SMTP id l6-20020a2e8686000000b002558474f3afmr20805147lji.402.1654941526941;
        Sat, 11 Jun 2022 02:58:46 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-90-154-71-254.ip.moscow.rt.ru. [90.154.71.254])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512055200b004785060bad6sm200634lfl.201.2022.06.11.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 02:58:46 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] DTS changes for the AMD EthanolX CRB BMC
Date:   Sat, 11 Jun 2022 12:58:24 +0300
Message-Id: <20220611095828.1090-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several patches for the DTS of the BMC on the AMD EthanolX CRB.

Konstantin Aladyshev (4):
  ARM: dts: aspeed: ethanolx: Add correct label to flash device
  ARM: dts: aspeed: ethanolx: Configure RTS/CTS for UART1
  ARM: dts: aspeed: ethanolx: Use correct driver for the FRU EEPROM
  ARM: dts: aspeed: ethanolx: Enable VUART

 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.25.1

