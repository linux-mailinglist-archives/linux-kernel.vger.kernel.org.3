Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429444AACD1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 23:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380899AbiBEV7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 16:59:54 -0500
Received: from mailserv1.kapsi.fi ([91.232.154.157]:52992 "EHLO
        mailserv1.kapsi.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbiBEV7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 16:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rdOCqJZjpyoibeF91hRhL7D6HyDrCn3lzEaCLVQLB8w=; b=W0qNCohL/fvHY7My+QGJ3hNyXu
        Vl57W2FVEq8afDUaF5TGjEZ4AyBqHvyQ7/BIhAFV0P8ytx2aS8QxMjYMD8qzmKuKwUSK4S2Ita1Di
        d9Ss4IJVLJIppI1kGSU+10uTn4r6Y0oCkeuExZMrKQ1N95AxvKWytH577z/dpQp+B7JyUkpwP6rZt
        BOiklPFSW5RqB/VxBFQBuoKLiIAH0B5wvm905ptXEKH6eWV964rN8c9K0H9sK3pluXWyT78yPtHtk
        sTbMAkdAK4bVJOkoxTheVvu83/RX2Sloplml2Y6t9pcjJZB9iuxcHJSl6FiLZwwa975bAkY8WR2o6
        w5isCQpA==;
Received: from 246-30-196-88.dyn.estpak.ee ([88.196.30.246]:49928 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1nGT5n-0006cE-K8; Sat, 05 Feb 2022 23:59:40 +0200
Received: by localhost (sSMTP sendmail emulation); Sat, 05 Feb 2022 23:59:38 +0200
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     bgolaszewski@baylibre.com, brgl@bgdev.pl
Cc:     andy.shevchenko@gmail.com, geert+renesas@glider.be,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, drew@beagleboard.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Date:   Sat,  5 Feb 2022 23:59:16 +0200
Message-Id: <20220205215918.8924-1-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325122832.119147-1-sandberg@mailfence.com>
References: <20210325122832.119147-1-sandberg@mailfence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 88.196.30.246
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mailserv1.kapsi.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [RESEND v8 0/2] gpio: gpio-cascade: add generic GPIO cascade
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Hopefully I am reaching Bartosz with this too now. I may have used an
outdated e-mail address earlier. Please kindly take these two pathces
in consideration.

Thanks,
Mauri

Mauri Sandberg (2):
  dt-bindings: gpio-cascade: add documentation
  gpio: gpio-cascade: add generic GPIO cascade

 .../bindings/gpio/gpio-cascade.yaml           | 103 +++++++++++++++
 drivers/gpio/Kconfig                          |  15 +++
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-cascade.c                   | 117 ++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cascade.yaml
 create mode 100644 drivers/gpio/gpio-cascade.c


base-commit: 0868ad385affa28cf15aebca3c38c5c51f79b286
--
2.25.1
