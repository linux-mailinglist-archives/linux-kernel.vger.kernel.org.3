Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5772554916E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240967AbiFMPVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244271AbiFMPU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:20:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B5B12E33B;
        Mon, 13 Jun 2022 05:46:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id e5so2916891wma.0;
        Mon, 13 Jun 2022 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=uZn86I/QpaNWIanURTy2oUxTuFO8ontc206QYMJD6nw=;
        b=aQjJsfvXRZL16rd57OHG7LhT60WRoqn0F6J2oW3ksJnO7zxx2Gi+i86/PHMWZsY5u7
         8CLR5XziRZxDc60zPngqGA8675DIhsQY3x4L8BBJPOjeckuzr6Va31Hiog93AzeYu934
         A64+XwXGHCaHTLtQTIwhai4XLQfjOvqiaAhY18Gvnh8mtOE7hRg43dLK+wWoNyRaSura
         2RNdG2nbNu8JzyjGx7dc/MipLDcbC3KvSVCdmu+swYb9UDLES5Wq1hITfii9hgvfpxzz
         cfwn916QgHXdinQPL1vi7sX0/6g9Gg/3GDTUOtBLwP27dyPldwDazi4CzmSVfKYC3hB5
         rxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uZn86I/QpaNWIanURTy2oUxTuFO8ontc206QYMJD6nw=;
        b=X589EG/AZgx/t85dhScRf9k1XrBNBQcJ6b7T0OY5hoChCtXLT5ADo9J7GHCywuLB/j
         EmjqtzEvkxIiv++Z1pi51Av+2YP1UW50ybxmFoUoUGy1TPe5/JIi1kIOhDzGlM56SdHB
         ai2sfv0X8MM5t6mENsUlTb/1+y0W+B+wo3zrdRrBI+XbSnETdhI3Nz9d22DopYCeMkGw
         zxwC3kk3EFjODA9hifa7i9ZLmeKCW9VPIcxmANAf3/lhBv7tcJ5mMt6MCpP1+jYkrMB7
         MAVOtv0uAL7KHoFqGlQlIvu2HWXPaCW5rYfTLq76vosuJAEuCDkAZvsB3InryFWLNbI+
         w2dA==
X-Gm-Message-State: AOAM533ewlKzpZxRVd6Ey6a3ZcUi05EnpsadlIetroVVDEf2G5TKL7jc
        A9fRTSA/3wlZQDExEOzLtEc=
X-Google-Smtp-Source: ABdhPJw+qzU9/HjjCnxQbIJ0dzec17ovt8hi7cNWVHrRvPSQzc1d+4qSZU2fSwq9fu5XCgk3h0EPhg==
X-Received: by 2002:a7b:c856:0:b0:39c:3b44:7ab0 with SMTP id c22-20020a7bc856000000b0039c3b447ab0mr14531641wml.117.1655124418303;
        Mon, 13 Jun 2022 05:46:58 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50011e978c0f780de03.dip.versatel-1u1.de. [2001:16b8:260d:f500:11e9:78c0:f780:de03])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600016c700b0020c7ec0fdf4sm9985404wrf.117.2022.06.13.05.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:46:57 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: add include/dt-bindings/usb to USB SUBSYSTEM
Date:   Mon, 13 Jun 2022 14:46:47 +0200
Message-Id: <20220613124647.32019-1-lukas.bulwahn@gmail.com>
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

Maintainers of the directory Documentation/devicetree/bindings/usb
are also the maintainers of the corresponding directory
include/dt-bindings/usb.

Add the file entry for include/dt-bindings/usb to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Greg, please pick this MAINTAINERS addition to your section.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fd2c1080aa5..b84ef4091535 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20801,6 +20801,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
 F:	Documentation/devicetree/bindings/usb/
 F:	Documentation/usb/
 F:	drivers/usb/
+F:	include/dt-bindings/usb/
 F:	include/linux/usb.h
 F:	include/linux/usb/
 
-- 
2.17.1

