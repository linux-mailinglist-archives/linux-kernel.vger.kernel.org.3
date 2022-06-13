Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF03E54971D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352621AbiFMPRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387598AbiFMPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:15:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908BF12088B;
        Mon, 13 Jun 2022 05:33:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id s12so10903814ejx.3;
        Mon, 13 Jun 2022 05:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=VD9AusQPhhsv19ZmDVVBkmiyTKW+gPW1C2iR/TqV7/0=;
        b=JZ6X4CGWWDBszUZ2NwNsM/JYojtlM1KcmH82DN3FVl/69G92+oG5fclDS3btw4+lSI
         LwERbGexHq/RDZf/i4sBGW/rIElyWn8Oz3PkD29Y4GwWJsy4H1Sdsy7UfGoL8naaKU4+
         +8SvZ84keSSSu/Y/9C1ARkwEv7T738bPkLlfLK/Fvzfyg5fEJXbMP+33uC9OPq4KgcRk
         4V2bTougmnYBIwsbs3parJK07RlBy7rwedbOMsAQf99byX7JEutvjGqiVBDwXbNV8/Eg
         jhWdJsGkv3Ca1Czv3gUXGZn5nd5+GlA0adEBBlxrejZ5x33evj8P59dV3Eb3gWPY0YCs
         RWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VD9AusQPhhsv19ZmDVVBkmiyTKW+gPW1C2iR/TqV7/0=;
        b=nDBuV62CEf7MoUCuDl0uSiGy00eB/+YlTEnOm9DQIR6jWrfFSV0XPWCr80OMNLC13r
         BoCsNRhRGb8dEXgVyAPAOyHr/fRY1m4Kc28xy8kG1EB01dgxPnFKheTk1ZkQ5y/oibGp
         J5xs+zQqGroWtfALAKaGGzhIRmQTJXPyYLkjcr/Hppi8QQwC1IXgaWCQpyh+q6tKrc9k
         1S5gqxus8G7c2c+xqRDoUeBXhLJhWMaZ4Ee1oWy8NSRJCa1bDOfW6sxsK1ElXMHWQEv8
         iAugY2AUD24Dr6UDIhKAPVTj4Fsf/N4+uyb7OgC9ykujE74uyQ+Lxx1SdD1efH+J80GD
         CDWw==
X-Gm-Message-State: AOAM531BzPKbI6FBbT9/65exDH+aQGTQWPLfaTJUgVjkfR3VjT2DqfDD
        flmOF6zL8AVmU9VOTaxgX8c=
X-Google-Smtp-Source: ABdhPJw+RBhp5AwXRhr0zcDILCY+/pwvYIjbhjLDFxY3Qpacux2pQUqlC+Xrr++nZCJw0+2YDJ/vjQ==
X-Received: by 2002:a17:906:b788:b0:711:fc54:e55e with SMTP id dt8-20020a170906b78800b00711fc54e55emr22200025ejb.270.1655123610787;
        Mon, 13 Jun 2022 05:33:30 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906a00e00b007101f6f0720sm3782221ejy.120.2022.06.13.05.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:33:30 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/pwm to PWM SUBSYSTEM
Date:   Mon, 13 Jun 2022 14:33:19 +0200
Message-Id: <20220613123319.22964-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintainers of the directory Documentation/devicetree/bindings/pwm
are also the maintainers of the corresponding directory
include/dt-bindings/pwm.

Add the file entry for include/dt-bindings/pwm to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Thierry, Lee, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c67cd163cbb..ec2e764a22ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16287,6 +16287,7 @@ F:	Documentation/driver-api/pwm.rst
 F:	drivers/gpio/gpio-mvebu.c
 F:	drivers/pwm/
 F:	drivers/video/backlight/pwm_bl.c
+F:	include/dt-bindings/pwm/
 F:	include/linux/pwm.h
 F:	include/linux/pwm_backlight.h
 K:	pwm_(config|apply_state|ops)
-- 
2.17.1

