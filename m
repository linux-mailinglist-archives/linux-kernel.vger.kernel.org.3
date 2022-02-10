Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D104B049E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiBJErI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:47:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiBJEq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:46:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB801AA;
        Wed,  9 Feb 2022 20:46:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k18so7319232wrg.11;
        Wed, 09 Feb 2022 20:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CINhVeMEJRnxt2N7nzrBj1BDzXGGBYQDuFCYQXZDz9Q=;
        b=jM4fIs9WFGN+yAxLwcMz2Rw7n5SZE+DiU9dTpcsBap7A6Va+CVuICY8STiXAAwNId9
         gtUlfLX/KxgxpGIDonB34zxorkxBOjJlOgUMD7ZtJpNMeyREmYWTwslfrwMfQNGeckGf
         6zbsxERFbaEMHJrDx4ci5dRiLSRkzDK21j4NygrapicI6Mti+Zm66JEbZbNhopSTqtHW
         LylOkS5wiUi+kFPDLLs0Lf9xhT6N5RvFSloOLoVeEUSFDilkCH+gOUOFhroA+tbu9Y6T
         GOxX5KKlz7YcBpfT5GJhmrBCPsgSOROoH4hM2E6XGMqzpOngqAjmk9jvhRIzCpO35+QH
         AE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CINhVeMEJRnxt2N7nzrBj1BDzXGGBYQDuFCYQXZDz9Q=;
        b=u56IwOSBNuHJqVVHt5zUd1YGYUswG8x//+EZ7r+T1rzHpMQOgT7+7rRoAV3+M6Ldqq
         6CjJ2KVUUY0reoGOeHx7wU970d/P8gBd+0wKtnHXUs/c63U6qbsQAfjwzg6JZA/dWhRZ
         tYMqGyN1W+q9yahTfZhN4LRzDMoirloZi7tZXaJ9oVeLbc4g/ucD7BKxBK0oNm5SxiPd
         Y0GtpzC/ds6LOOMtFxnbyLHNpyzHux7TCa/X01ol4I+xkFzZmJc5FOFMum/mbKvEst4q
         BdTtHNsg3qRwdaCF+FD2GUijW7zQ1+O7/mx5NQaQZzRyNQV0tqlb6ycH/jmsEmEf9Rrm
         F8FA==
X-Gm-Message-State: AOAM531PjwVpzJizGZWxDWA0zvFPHqPhHH9EuJCy1xqN5KBN3LvR+wEU
        R5sPvOz6z1HbKD9aQ5Fs8U/KxG4OJGLLjw==
X-Google-Smtp-Source: ABdhPJzMSDhKCtHlwy6VUTO3oQMZNo/xnWU8iYVtBLY77RIa9onkmuFf0FO3SP4Gkzl1RllgvBTm0Q==
X-Received: by 2002:a5d:6e86:: with SMTP id k6mr2441841wrz.388.1644468417203;
        Wed, 09 Feb 2022 20:46:57 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h17sm323089wmm.15.2022.02.09.20.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:46:56 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Sam Nazarko <email@samnazarko.co.uk>,
        Chad Wagner <wagnerch42@gmail.com>
Subject: [PATCH 2/3] dt-bindings: arm: amlogic: add Vero 4K+ bindings
Date:   Thu, 10 Feb 2022 04:46:46 +0000
Message-Id: <20220210044647.14443-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210044647.14443-1-christianshewitt@gmail.com>
References: <20220210044647.14443-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board binding for the OSMC Vero 4K+ STB device

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index a073a959232c..61a6cabb375b 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -108,6 +108,7 @@ properties:
               - amlogic,p230
               - amlogic,p231
               - libretech,aml-s905d-pc
+              - osmc,vero4k-plus
               - phicomm,n1
               - smartlabs,sml5442tw
               - videostrong,gxl-kii-pro
-- 
2.17.1

