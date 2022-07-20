Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85757AB58
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiGTBKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiGTBKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:10:36 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DDC481FA;
        Tue, 19 Jul 2022 18:10:34 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id x185so9214025oig.1;
        Tue, 19 Jul 2022 18:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OU+/gjfai01z34lLexG+BxAsHjhJYkOiU0JxFwo1+l0=;
        b=NyodhQaxGxiGLbB5IERYcQxMjT7Qg5/9x5cMZ0TFkg/66ju+b2OcGZ4MshzV10NrrQ
         6j8ZI164SjqC5GMX/CDOgFt0TsBej9cQdwHPQQeOWiGkneTDeDGNgM5GGUqOo5ucvax8
         WjqUagVgTshsiCNS8RKScg1LauT5E0npbMpsLqSjHO6wNHjt1470+hDM22+f1l3KOg8g
         1+UrsqZ5KbjrvIlZu/9tXWDiywoXUutB+5BVN1IP49SGrY/cKcgYzWXqJQb2kLKGJkK5
         5P75SU7BZbkzQZT/r6MM0CHEoaBaLJciCHZrq4WiK2QTP0ouI7qSvzKUImcueiHCL5cB
         9IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OU+/gjfai01z34lLexG+BxAsHjhJYkOiU0JxFwo1+l0=;
        b=WXmOEV3Erxi511IzeIZw3Xd1JZMfynaTDP6m9vIvk847sR292l5eoP5k+ZPL8HYnvW
         ZVQs0ZKCozzN5y7Htdq8K8OSsNypZkMuBQEjAQRMMAS3Vuw4PT6u8XOBQBzRswTM9PfF
         ycv1dCxOAV2/v/Hxs67S/8N5rw/mBK2ncIa0bwUaS/JPIVLjs+rZbCgVevV+vWEwwc2v
         O3JHPcYd3ek55FxRGILP0NjG0eEbdpzSy6ZK0aIA//ZMuPk1OwxeQOqjFQeYkAAuILpA
         0uNkfQeFKjaOMa42DHb36u/h+dtb+d1CGM0mZcgDEnWp2dDyEqFPjk2P58ELE9gvjnnp
         KXFw==
X-Gm-Message-State: AJIora8EayRhELxY+IOvAyERL0OlmPoHsLLdz9fNztOcyCx9y9qUYmUY
        rbsf1oogtBgDEmZ2SgXdY5c=
X-Google-Smtp-Source: AGRyM1sE6ufK5TO11SBv0E88cCRLOQPRdJAIDIWjrG1Szk6NVnZTkBr+2+dO79e2SGCY7s8f2MuvkA==
X-Received: by 2002:a05:6808:f8a:b0:33a:3b5d:d5f5 with SMTP id o10-20020a0568080f8a00b0033a3b5dd5f5mr1164801oiw.287.1658279434127;
        Tue, 19 Jul 2022 18:10:34 -0700 (PDT)
Received: from localhost ([2600:1700:7130:4fa0::43])
        by smtp.gmail.com with ESMTPSA id p13-20020a0568708a0d00b0010cb6fa9166sm8715216oaq.0.2022.07.19.18.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 18:10:33 -0700 (PDT)
From:   Fae <faenkhauser@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fae <faenkhauser@gmail.com>
Subject: [PATCH] drivers/bluetooth: Add PID of Foxconn bluetooth Adapter
Date:   Tue, 19 Jul 2022 20:10:02 -0500
Message-Id: <20220720011002.5221-1-faenkhauser@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes bluetooth on HP Envy ey0xxx

---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e25fcd49db70..973d122c738f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -454,6 +454,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0c8), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0e0), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x04ca, 0x3802), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
-- 
2.36.1

