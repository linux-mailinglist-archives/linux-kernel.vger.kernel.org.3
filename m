Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EFC57DC2C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiGVITc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiGVIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:19:28 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E5B9E28D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:19:26 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 0F8272FEE7F;
        Fri, 22 Jul 2022 10:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658477963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1g5OIGIUtsg99dkkiWJOZEKAQyFblxgUZPyM/3d27nU=;
        b=YsGfgAUTG3YRnkR8VrREGZ2ZRW3aLuCmYdQWfKjBaiMRzjFX6abqXg3/lsudR41+XPyn9z
        VRGQ+kl94SWJe7smrx1O442nTdiSRIt0H675ViRfg74mcR6x7e6t9UEATQyktZZ5zQXZye
        1kGcDbAu2QGVdFMHoDpfn4nr7BlL1xvmbtqQNb1ygstO4nRJ4GtrJLR9ugeDdmVNWwvVWR
        SoNKpLpduWjkp8AYp4CRBXcqAIYJKHLS6RAKJbV7rr6KkIlai1/4tWynSC71CCjPr7le34
        0xGetD7PYsL+lWm2Tn8+9y3sNiK5envuyteJTbXIuSEZ/iX/k3wCeaKQbQhIHA==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Bert Vermeulen <bert@biot.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 0/2] gpio: update Realtek Otto documenentation
Date:   Fri, 22 Jul 2022 10:19:15 +0200
Message-Id: <cover.1658477809.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amend some driver documentation that was missing from recent changes,
and add myself as maintainer for the driver, since that's pretty much
the de facto situation.

Sander Vanheule (2):
  gpio: realtek-otto: amend ctrl struct docs
  MAINTAINERS: add info for Realtek Otto GPIO

 MAINTAINERS                      |  7 +++++++
 drivers/gpio/gpio-realtek-otto.c | 10 ++++++++++
 2 files changed, 17 insertions(+)

-- 
2.36.1

