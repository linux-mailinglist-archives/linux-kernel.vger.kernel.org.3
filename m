Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39544A935A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbiBDFXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiBDFXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:23:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A477BC061749;
        Thu,  3 Feb 2022 21:23:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p15so15773882ejc.7;
        Thu, 03 Feb 2022 21:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5D0naLf91S5HixsewYTrKMJ1b16kD1c/WHyD174dJNQ=;
        b=a42cgaxvkM+BuU2FtW1++CCXkFzaeTORxwxluTTyKVBc877qLghuJsxJ9ccogJrSBi
         kbwozUtwm1j8swe3cph2H47+TkQL59aohX65dL910gF/rouXzVqxEPZ1r4Ky6veBViys
         wbpGphaQS30yEmAD961PMfWxoQpYx5R5PqzQ/T4gSe16+3syqMjx0g8BWsP6xLj3iLbf
         ncROhDlRpG4K4EBgtgUy8Fdg1DF2QpfznGvL9E99Axot75rv+cOjtQ4l91ogl9ul4GLk
         KMrPvIExTHgXf5Fnt/xVnYN3+y7QPrBz3blqRNmGrWqwLz7Rg6Ua4H66t4uIOKy3n87v
         qqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5D0naLf91S5HixsewYTrKMJ1b16kD1c/WHyD174dJNQ=;
        b=R5S/4RXfhBfuk/PZh5kpMDk8tcP65WpY/Y8H45zGMYfTRokYW8J6AXVU25B29zdlL1
         I2sW/IcvbMlmuy4hEWCJ5F63LZE1Rglaa6ZbqFpUNgLh6hck9VJqq6SonshsTqEUHe7g
         uyENVVUYhPS6HBsKfFfQAKmYJ3+N0nr0nOBn4ylULjhUMFFFdHui5Z+ZIPA2eqcaFjDF
         232z1Pm/rEtfr/erlZ8nf9WmjK6FNCo4GeyL167CYQG4T06BWMghvyTqAgXH2XNcpmMg
         Avi+yCByoLbyZSjnb75/kRUDQijpehKvc2yAq9CuIQIvjH7zBOBalJcwubesHc80gOd4
         lqLA==
X-Gm-Message-State: AOAM532vhNH1zk60TgAUmmYzZ8wGz8LobJUSnkB8aNlKISSH4s831vEp
        R7KjHni7BLGjfUpXp/kVW+A=
X-Google-Smtp-Source: ABdhPJyft0UjBbLgL3CvuQU8n42pXi4lndzlDeJhI/0RYQo9bjL/OZGDxDF1/t82duYxELtI7XURkQ==
X-Received: by 2002:a17:907:213c:: with SMTP id qo28mr1062817ejb.325.1643952184153;
        Thu, 03 Feb 2022 21:23:04 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id cz6sm394941edb.4.2022.02.03.21.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 21:23:03 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: fix documentation index
Date:   Fri,  4 Feb 2022 06:22:56 +0100
Message-Id: <20220204052258.556667-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace asus_wmi_ec_sensors with asus_ec_sensors, which should have been
done in d4b4bb104d12.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index df20022c741f..1bad4e6116e4 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -43,7 +43,7 @@ Hardware Monitoring Kernel Drivers
    asb100
    asc7621
    aspeed-pwm-tacho
-   asus_wmi_ec_sensors
+   asus_ec_sensors
    asus_wmi_sensors
    bcm54140
    bel-pfe
-- 
2.35.1

