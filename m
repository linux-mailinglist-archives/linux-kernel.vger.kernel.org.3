Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5446CE17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbhLHHIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbhLHHIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:08:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B7BC061574;
        Tue,  7 Dec 2021 23:05:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i5so2358110wrb.2;
        Tue, 07 Dec 2021 23:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMTKVUHespHQvvRUczObQ55Lrl+DRNepRfurh3saSM4=;
        b=nuQY7BcjYDt7pdfFd/8rHCxsSFitwjmxnMEdo3dJXMUJhVSqNtRZHRbFpFx0IEPumg
         99gJFQ+byHEsJ5/6X7pCkWPG3b0kS3uGfsK+wIfdYRl0W0fNEDL1lPdvsz5R40WpWKtk
         aG6ubrNT0YgTi7hN3eZ8jw0WnhLT40L0sZKPvTupKda76INHPd2h5BN+Hz6fWRSPR464
         tYZDwF/51b9tba20/95lITKoIfWsT+ElfVv7WR1OYiR+/jrBk7S4ecZD6cntEX4se8HH
         pOm0x7XKim19+ILqz/0HpwojWF2AVxHjJ8ObJGyOMwsqezU+Vv+bcZMVm13UbEBPgXwu
         kWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMTKVUHespHQvvRUczObQ55Lrl+DRNepRfurh3saSM4=;
        b=yp0NkY8agmoJrvN2zDOF9+gchraJS9lmHiK7M7YGixowYl8pDwpMvTPjMPAEoNa0JF
         xx2BYMWL5Bxy4g3JwsbBpLsbrZ23q3i1cYtlpvFOUVI7zhrZWu+O56vya4ii7xaym93O
         ZlOFUgkA0XSHtpBpa0j00YxRiUc4qGZGCQvRNmYeLrGx7hyF6pzG/zHQdRmUtLL+6bLH
         zHW+4c6V7ddMup/iSMTdRW2IqDAeVDyY+ddfsSKH1oJml+aCqyCyQnlfQlyCFzIBO0TG
         nDBhZkCirFkyaVuLA/FvpwK/+/c+kMAFf46tKBBisNO6Xc0nOxGI0OE556yh2EJ3iH6R
         LyQg==
X-Gm-Message-State: AOAM5310auyQsfOjkoxCD5tyfp2Z0SPcnFSWlVVMWEoUgDPm01n9osbv
        p492HzxnCSFt5gSfT/qVqg0=
X-Google-Smtp-Source: ABdhPJzzO8zvmc8uMVoh3isAci9m7CH1gvzft247l9qrTSDnrqANBNVGxZHzyn/hyohzDz8+6FOgCg==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr57830704wri.425.1638947118821;
        Tue, 07 Dec 2021 23:05:18 -0800 (PST)
Received: from localhost.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id 4sm2302352wrz.90.2021.12.07.23.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 23:05:18 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     George Cherian <gcherian@marvell.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove devicetree binding entry for XLP9XX I2C DRIVER
Date:   Wed,  8 Dec 2021 08:04:59 +0100
Message-Id: <20211208070459.23222-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0e5f897708e8 ("dt-bindings: Remove Netlogic bindings") removes the
devicetree binding i2c-xlp9xx.txt, but misses to remove its reference in
MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
a broken reference. Remove this file reference in XLP9XX I2C DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Rob, please pick this minor cleanup patch on top of the commit mentioned
above.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 842be45b37ab..cbbcfc4237a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21095,7 +21095,6 @@ M:	George Cherian <gcherian@marvell.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
 W:	http://www.marvell.com
-F:	Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
 F:	drivers/i2c/busses/i2c-xlp9xx.c
 
 XRA1403 GPIO EXPANDER
-- 
2.26.2

