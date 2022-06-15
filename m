Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA36754D1DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350292AbiFOTov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244636AbiFOTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:44:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874773CFF2;
        Wed, 15 Jun 2022 12:44:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y19so25255434ejq.6;
        Wed, 15 Jun 2022 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=767OJrCK8HUadii808hVEy3GxcnvixklGPCO6V3YD5M=;
        b=jFT/VeSc63iFgMPMb2xRcBbUCqXUnEZl1E1MVx1Yd2xAmk3ax4Uy65On/y29eZkoe2
         EPvPLMkZIFEBJbO/DrmTsslXpsOfH14CWV/xGigqff7/K3B/BKmC5+61MIvtfT+WZpjS
         RMqvC0cMMqe3uUD7OFBaas6cXGWaO+EzMk6KMymXcRzGsE2Ww5xjysjW4+PrZDjsV9tO
         FyodoLXWhR4ioUoNG6krEdVinHpphmZO+IZVKrD8eX7Le1gfbzgMifUy58g6drBSSZ2S
         x61qQcs/hRho1FhiO1lqm+d0Zm+1hEgLk1/ro/pRLJUSHwdfNL+b8dGXulEQO0kLlMeF
         JTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=767OJrCK8HUadii808hVEy3GxcnvixklGPCO6V3YD5M=;
        b=JTmCa6eiGmslLdPSH13yTsPqBSFxejnZGs3LDQDP3lvNlwQRvKZD8JoqpjIUKIyJ8J
         TWjP/KiVMvIg6At1lFJqBaUDf5p20iIOL7X9Dk0j0V/YIuZfLP+fDz8s0WBg1SN//UQ4
         RoHYxwUkbSEu+1WM/ofEtW+sbYvm9cUspjsYPhQ0k6RwcLWRwFnP8Luo1HEKyu+JhKwD
         fCelDcnl91ljatE7WsSJqTgjeDIImEp8sa92eONoriTRBXfXFuDvTpJVE/8ZfeIdNhpu
         sdEo+xgchPj8CcYoj3sCBzkmi660gxESY7boB6n6PjhMomHWorrI5jn86Hfm8MFVhauJ
         D3zQ==
X-Gm-Message-State: AJIora/XOIE4tDxeWB68p3NvAKJRl4H7Ug64vRw9SP6rcvKMx6TAX2pf
        gwk5FlB+xIOWQCNMgF4lmzomSot8muE=
X-Google-Smtp-Source: AGRyM1sgGqJHUeVw3u3W7rE3sqf5Kp8zpWdfvFHOMgDNOhP8CojDYKciFvgC5O7XXJFBkGcWqg0OLw==
X-Received: by 2002:a17:907:c71b:b0:718:d0a2:a447 with SMTP id ty27-20020a170907c71b00b00718d0a2a447mr1266043ejc.157.1655322284933;
        Wed, 15 Jun 2022 12:44:44 -0700 (PDT)
Received: from felia.fritz.box (200116b826878200b4eabc3163d51ca4.dip.versatel-1u1.de. [2001:16b8:2687:8200:b4ea:bc31:63d5:1ca4])
        by smtp.gmail.com with ESMTPSA id i24-20020a05640200d800b0042dcac2afc6sm29565edu.72.2022.06.15.12.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 12:44:44 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Neal Liu <neal_liu@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: Repair file entry in ASPEED USB UDC DRIVER
Date:   Wed, 15 Jun 2022 21:44:09 +0200
Message-Id: <20220615194409.11875-1-lukas.bulwahn@gmail.com>
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

Commit 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver") adds
the section ASPEED USB UDC DRIVER with a file entry to aspeed,udc.yaml,
but then, commit 0dde9a46a2cf ("dt-bindings: usb: add documentation for
aspeed udc") actually adds a device tree binding aspeed,ast2600-udc.yaml.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair the reference to the actually added file in ASPEED USB UDC DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Neal, please ack.
Greg, please pick this minor non-urgent clean-up patch in your usb-next tree.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9c3576b082f..8830d1adb23b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3144,7 +3144,7 @@ ASPEED USB UDC DRIVER
 M:	Neal Liu <neal_liu@aspeedtech.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/usb/aspeed,udc.yaml
+F:	Documentation/devicetree/bindings/usb/aspeed,ast2600-udc.yaml
 F:	drivers/usb/gadget/udc/aspeed_udc.c
 
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
-- 
2.17.1

