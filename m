Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537A85B043B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIGMuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIGMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:50:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40780753B6;
        Wed,  7 Sep 2022 05:50:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r17so1034242pgr.7;
        Wed, 07 Sep 2022 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date;
        bh=jPyKiHK9Z1f/mDgcNl32AxqjgUc4Ptqqz+HyhxKfYq4=;
        b=ZAMD8mItqJ7YqDQ3bHcwDY/4B6fkAILhnL2e+pz66KKPOOfXtKhThy+IvJrsL+fV0D
         8Iffyu6DNtCG9aFafbX7HOsZnYXYDY2W2B2A/5eBzzKxZNJXa1kK73Uv1GLSiTb8SLn3
         gn3PIIYfJd5/ubD7E3EGesaQaCBk9EJbqpgwnK2VqaCRzFNWB0U0A0YttBLYdUIf475C
         DsVWovp/Gv+xDYy9R86dagC4WH8FBlBg86mYLdLJYaUU52bzC90dN3sCSyesAL+toXYN
         sJaSz7l+Kz0N5yOiLI/5a6JzydcSFLzclETpmVHhjDMkvYj1UNNsRJKbOMWAATqjAji5
         Oxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jPyKiHK9Z1f/mDgcNl32AxqjgUc4Ptqqz+HyhxKfYq4=;
        b=7Lfnztm5s5E6kBgyH+Cuy31pIzgKrrKZRlEzRi+9GE+eBrco7cT0RHZ1eLVkC4Z/ie
         AjLwTO/82IZFLg/oLEx5PAWM3Nl5sdbuduXntkM8LcTZ8Swn/0LAx+i8haqYTbgPwEeu
         C1io9/GSopUWGz4ASxYt/d/fYvEkjgYmZ0eDVvA3H0G8lIyTd6wi+LyhqNNMlwrgTeT2
         t4Jcp+CPcSdwELRZOmYMLKMuVzwLUe0bwDViP+78D4vD4qsFZT/ikXFUBU0nRHYaeJyC
         MDNWP+o3Tn5T/54gaxS3Z2GsfEdJOFvcn+17tVZmYu93Qa4S6SC1XcU8fHU5UvXVES0S
         +s6w==
X-Gm-Message-State: ACgBeo0T7f4Ng3gxvY1rjqYNz8dAzQKMczifCRbImKUCvX5JMRqfMUXH
        IrK+Er0iQlZyPubIozOer9E=
X-Google-Smtp-Source: AA6agR6wqTSiC4quRaCw4iH7eVY9qz1KHmrlAlH7dE8ysQ1Msha5l8j12ZXgbQ5wEWXPGl9od6MaGg==
X-Received: by 2002:a05:6a00:e85:b0:52b:5db8:f3df with SMTP id bo5-20020a056a000e8500b0052b5db8f3dfmr3966989pfb.14.1662555041806;
        Wed, 07 Sep 2022 05:50:41 -0700 (PDT)
Received: from hcl-ThinkPad-T495 ([2401:4900:1ce1:13f0:48c4:2ac5:ccad:657d])
        by smtp.gmail.com with ESMTPSA id bj9-20020a056a02018900b0041bcd8f3958sm10450967pgb.44.2022.09.07.05.50.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Sep 2022 05:50:41 -0700 (PDT)
Date:   Wed, 7 Sep 2022 18:20:35 +0530
From:   Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH v2] ARM: dts: aspeed: yosemit V2: Update for Facebook
 Yosemite V2 BMC
Message-ID: <20220907125035.GA28461@hcl-ThinkPad-T495>
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

Removed NIC EEPROM driver IPMB-12 channel and keeping it as
"status ok".

---
--- v2- Updated the title
---

---
--- v1- Initial draft
---

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..2293f10e94d6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -207,12 +207,6 @@
 
 &i2c12 {
 	status = "okay";
-	//MEZZ_FRU
-	eeprom@51 {
-		compatible = "atmel,24c64";
-		reg = <0x51>;
-		pagesize = <32>;
-	};
 };
 
 &pwm_tacho {
-- 
2.17.1

