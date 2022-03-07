Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902764CF33D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiCGIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbiCGIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:10:26 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F3F4B1C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:09:33 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 154223F1E6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646640571;
        bh=4HAGUFdmLrEMxU9EFzkJe4Ux3HcmnFK/yDcsBQCmOjM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ar7fL9ueWOkRzUtFITgzBX2E5qX8D4HHFnO0EhcVYoKY2xzlzhEnCJwswfxASZ+eK
         GF78AwOEvxtIbPS3jVwi7DyDd9m/7wRLKuyUgPLqlv5rGkl6yB4FnWQNWETmLaIq9o
         WXYa0hUHZ/YELlvXrSOcICQjLU2TydVoUWXL5IeUmLesykOzbLK4NwkO786BZahSue
         PG4PTemQUUTyTGE0JRMGqBsa+cpI0Uny97us1EtoYbUjL+RLdOO91l8NSXlr97yZU1
         C+Dq/Rxf3Usc/fxk067AMiHAeXBAsCIdhqHMDm6e7b8rj4NnqyFp3gW8Fg0Ak7+MgS
         JZYcw465OHyfg==
Received: by mail-ed1-f70.google.com with SMTP id e10-20020a056402190a00b00410f20467abso8141083edz.14
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HAGUFdmLrEMxU9EFzkJe4Ux3HcmnFK/yDcsBQCmOjM=;
        b=IwsamsJmAuu2JLQJUtP+G/2dTg8N4w7tgJho1GYtfh1e/ABgm5JEXV7HapadTMoJkT
         CVEqlL44Lg/wdMGGx7sHjSxjTDrdAm4P8EBhkTF3bXruij64mdUQRu+MtWiBfGtpR1mC
         TchQcjoHH2RftbKXDaEabUz8W7pixXG+SxB8lvt0ZjjGJQU2fLwJ9Z2rpJVuA1xsrlOe
         yQ2cMkrpAMvpNvpZcaPw+SeRqAgsvuMgeCpS3rdR6vp7HB7J6oQ/lXt5a3y1XXzZjLLF
         7eWaMtZvpEdR+x1vHWqeajSv3kQ6e4AhKuqEWo3iFRw6stLlJ02Vx2ci0b7sie6BWJsd
         NqYA==
X-Gm-Message-State: AOAM532DVZATZVv5uW87WUqTPlLREJITX+1zPVYF/Wdj+xqbdfkuc6Ec
        UOrqzncc81SbSO2A48lOry0ErHm+QO0TDelBmFMmpLL9Nbu/uJrdMwFIrSl4nIDtYv0iSMBP7gZ
        O/mii80dmxyfQUN0JhAp0tltnHdjZqERXhd3AVNLBBw==
X-Received: by 2002:a05:6402:18:b0:410:86cd:9dce with SMTP id d24-20020a056402001800b0041086cd9dcemr9810252edu.70.1646640570856;
        Mon, 07 Mar 2022 00:09:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgU+c7KFSylijaRWQXv0cNRe/wpPkgSFLwallIr6sdnzfiO44fulIE699j1F9ifcnE8L0KOA==
X-Received: by 2002:a05:6402:18:b0:410:86cd:9dce with SMTP id d24-20020a056402001800b0041086cd9dcemr9810243edu.70.1646640570665;
        Mon, 07 Mar 2022 00:09:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fq14-20020a1709069d8e00b006da650af5a9sm4472594ejc.3.2022.03.07.00.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:09:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] tty: serial: samsung: constify UART name
Date:   Mon,  7 Mar 2022 09:09:22 +0100
Message-Id: <20220307080925.54131-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UART name from driver data holds only string literals.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c4b13f2d6e26..7025306f76b7 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -63,7 +63,7 @@ enum s3c24xx_port_type {
 };
 
 struct s3c24xx_uart_info {
-	char			*name;
+	const char		*name;
 	enum s3c24xx_port_type	type;
 	unsigned int		port_type;
 	unsigned int		fifosize;
-- 
2.32.0

