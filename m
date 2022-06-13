Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540BA548D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354142AbiFMMur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357833AbiFMMtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:49:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A3462CDC;
        Mon, 13 Jun 2022 04:12:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q15so6640895wrc.11;
        Mon, 13 Jun 2022 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=nxBz3qHkVn2TwJLFD/O8ZWBNECKB6JOYIpB2txAlnTU=;
        b=DrGP1C9s7uVfit5Le9fV3MmRwt2245ivNh58+VZ0oaL9Hp1DulHdqq4Hz1BUXlvxSC
         MS+EyknGcz/KHctth0hQ/x0wy2P5xutUx5M0gFOxTtGDRV5S9oQwbq/56Hl8tlYTWV4z
         Wr+vVnkGko2KthawDQPYmpspI3t4oAbrLqlA8VNIURbjoLTbZlDu9EqaI4inJYOjw1Uk
         vRTprBydqfAery66VWcZMr7vZmFYDyhfGFrYpgu8qnv7PdAhNmzuU+rQ+5gccJM9wuzR
         V7w0gx/0g6s6F/GF+BuvE+Ip9pAaEPFEL4+d8dPIhlPhueBuYireIIH8r7gZpZBI3sFf
         t/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nxBz3qHkVn2TwJLFD/O8ZWBNECKB6JOYIpB2txAlnTU=;
        b=eoJO6rVgwoWz5hnzh4EUoqZ8MheJmCkJ6YveCCIlcLPRkQytDnF5V18/nSK+l/ahIf
         N1V7p+ccD29Qir2xRd9uOYP/C/MyxJzXEPi97Drx3xS3p/5ssB9LNbVQltvEtB4Ychky
         goPef+/FVSypy57VuXd4C1MDMkSQ/aVGxmSj1f8uAySJfaHWvK0BXjHNKHK7MtMuGQbN
         NwA4dAYVkeCLR28oMjFs6DgWTsQlb8e+Evz9NLyJMFXizbYyMCzQ18rgq5lsW7Svra82
         YUHbisyPpx1o7q4GMTS75HG0guZg1GjrF1ibBWACQ5ghgs9UeJycgS+gvbaEchL1TAAq
         Bnzg==
X-Gm-Message-State: AOAM530YRFQBL9b1dRh2UlmTugE1QKJuMpNf19LIuAVuFw0LOCMpfy8l
        Uf6IstkEFJSZz0bloWsgfuKC+2Kd05U=
X-Google-Smtp-Source: ABdhPJzsO86n6LAzIIMT88E+TEl1yUE6wGss027Tmux12Ii5dPWmcpVt6cO+Ky1tm6z2dIr759m0Gg==
X-Received: by 2002:adf:9cca:0:b0:210:2f76:93fe with SMTP id h10-20020adf9cca000000b002102f7693femr55161804wre.12.1655118717149;
        Mon, 13 Jun 2022 04:11:57 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50089ef6db2443adc92.dip.versatel-1u1.de. [2001:16b8:260d:f500:89ef:6db2:443a:dc92])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003942a244f39sm16933349wmq.18.2022.06.13.04.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:11:56 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/gpio to GPIO SUBSYSTEM
Date:   Mon, 13 Jun 2022 13:11:34 +0200
Message-Id: <20220613111134.23255-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory Documentation/devicetree/bindings/gpio
are also the maintainers of the corresponding directory
include/dt-bindings/gpio.

Add the file entry for include/dt-bindings/gpio to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Linus, Bartosz, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1adf8767422b..d04e74ade88a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8517,6 +8517,7 @@ F:	Documentation/devicetree/bindings/gpio/
 F:	Documentation/driver-api/gpio/
 F:	drivers/gpio/
 F:	include/asm-generic/gpio.h
+F:	include/dt-bindings/gpio/
 F:	include/linux/gpio.h
 F:	include/linux/gpio/
 F:	include/linux/of_gpio.h
-- 
2.17.1

