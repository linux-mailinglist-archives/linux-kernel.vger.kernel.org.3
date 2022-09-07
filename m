Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8775B0413
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiIGMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIGMiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:38:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC00A2D85;
        Wed,  7 Sep 2022 05:38:16 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h188so13419850pgc.12;
        Wed, 07 Sep 2022 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date;
        bh=8cuwNYIM2dG7qV14HGILvNfaTFOpaJjLv1WCC2bShi8=;
        b=UkhX3bpFkQrjMW+BsNFr1MJu7SAmDhU0caxX+kK4YCJkjBPmqM9WDLQZgpzoPX4CiB
         oZPp868wFyz6ukxUb8HqSYMbWyHQjLwc4SzKJtrTLIAXHMIeAjXi7IN3wZRQcIqmvEFD
         SF7B5MQ7r/aoenPzG91VDTBpW86c7dg2oxQBGLHbTQGnLjTY8IMg0djV1++EJwWaFe4+
         DsXPsXZSaJJhc6JbcgR2cqbQwst5l9kP14WJlTRfRb5XKdr+tzzYl5AGKH+FRIO0oh1k
         eWFRy+XWGR14SD6quBdhJMbR0msPoinGowtKDnuOB9TQG5Hhx+d0kOO4syhP1Fv7viVG
         fnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8cuwNYIM2dG7qV14HGILvNfaTFOpaJjLv1WCC2bShi8=;
        b=Ilg0YQBAbKXyRWW93h4Zw+cugBAl012TkDqkUm3wug+Rprkcd06T2Injwkto/gMT6/
         6BBhpUqZpQ2HJfWEROhriz7VPVhw9LpxWR5KZwllPv/2UXEUL05EIZWgserrt+zSpwES
         /aFnrtgLk8eSTQOKZIKfEaD9t6vJPmE2U8AR2nzPwFDkJSb+K3Q4rkpgruwzsgtNOBBe
         Px3n6oa50FFG5Pw83v6U8ATMFb+9Fd8cLyXpBIQDNfEczKi4pdSfhazXdavT3HtU+teT
         GDZtMdjF/JlemhkpGzgldn/+wdUuPru0TRLj1h1aO41RuBGJAS5rBanlxn2LrFmQ03fZ
         0grw==
X-Gm-Message-State: ACgBeo1H0iOKAavfaM6+fbGLezvL+NimkL6/D030HURoc4wt4k7wV8eI
        d0xwpeuR2yMyTNaHINHNYVc=
X-Google-Smtp-Source: AA6agR5V4+MCEuwU9j7UzU+tBSQs2nsdqQxak8nCNwdUh9g82yM2EIQhKa0rCZSTmGaM0mYVjVUrZQ==
X-Received: by 2002:a63:a501:0:b0:434:ff77:1fda with SMTP id n1-20020a63a501000000b00434ff771fdamr1114702pgf.310.1662554296397;
        Wed, 07 Sep 2022 05:38:16 -0700 (PDT)
Received: from hcl-ThinkPad-T495 ([2401:4900:1ce1:13f0:48c4:2ac5:ccad:657d])
        by smtp.gmail.com with ESMTPSA id jf15-20020a170903268f00b00176ca533ea0sm4476231plb.90.2022.09.07.05.38.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Sep 2022 05:38:16 -0700 (PDT)
Date:   Wed, 7 Sep 2022 18:08:10 +0530
From:   Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH v2] ARM: dts: aspeed: yosemitev2: Enable i2c13 controller
Message-ID: <20220907123810.GA27621@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added IPMB-13 channel for Debug Card communication.

---
--- v2-Updated the title
---

---
--- v1 - Initial draft.
---

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..84236df522dc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -215,6 +215,17 @@
 	};
 };
 
+&i2c13 {
+	status = "okay";
+	// Debug Card
+	multi-master;
+	ipmb13@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
 &pwm_tacho {
 	status = "okay";
 	//FSC
-- 
2.17.1

