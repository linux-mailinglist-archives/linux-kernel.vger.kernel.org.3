Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4845200DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiEIPS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbiEIPSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:18:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9981EAD8;
        Mon,  9 May 2022 08:14:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 204so9706878pfx.3;
        Mon, 09 May 2022 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VIzcE9Jh/Wl++Vizntiyvc6bbcJWikZRRO7DMyzUoQA=;
        b=BpiOONQUR9CoeZaahhTnJq+980AeyAM13OfSIRjm8FhuvBy+cDakZVpizCZhEPn5aI
         B8wKN6VR/xkPwxTxLUSDTboj0tim6oOAnsCylezD1Ah4MKyVvP5/zGPR5ekk3jpEzWX9
         Ue8GJpDWLCnRQjua9gzxj9Rzg5/I0lhPdRoBNbctEOJEOy9m+sINocKRujVdGL62a39h
         bb3yN+tYqNQDUs/ksekYf52BRJt1sRqxpzfs0KE/uf5wT254h3P2AQ7uKptFtC+2GV31
         usdpuhvw5KZB/S78t2uH9lwoHK97b5qkt57PzSfrB/V9zEl9HfaAmryJm1ZvBEwnrJ8n
         J+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VIzcE9Jh/Wl++Vizntiyvc6bbcJWikZRRO7DMyzUoQA=;
        b=iugW8/jgLD8Biyg3mg6DmVLTvXMtKE0/nOwVv3SuOaDta//AJRj5oh+EI5C7uI6hRN
         jBKz8xi2GOnZKK4NNSzLGAXRCEakF5aAHw6sJ5NtsfYRXmOlgR/D7VlUmfmOIpHbFVze
         5xzNhOdvgyYC/I6diJ6I8x+Oc1W2Ch8ykONToz+iKxxOeGvoj6cC21rMX7MJanm+3PHq
         vmIvypbHFF6GTfoTvxT6lS8HPmu9baurtFkKf1GE38qnnmRgbN9noF3M2UTiUfJs5uXJ
         U6izftXC+OtSNG/RE5+7Xz5seEKGMdeIBYAW0Qz7QdQJJPjB0Ni5YIXeSqee6dJy1DH5
         iZNA==
X-Gm-Message-State: AOAM531hhi9oSGbJaI3slzgLNaQongLll/aq/lLzQtARkuItKgj7hxJb
        yF5BlDhK+D3QP8v5TDr4S8M=
X-Google-Smtp-Source: ABdhPJzdZR3Vz5g68NJkrzAKAsQqiAvl1SNwW/B5PARQ6L1vhtOCNjYukyYbhABxznSJtfmu268NKQ==
X-Received: by 2002:a65:63ce:0:b0:3c6:a186:7878 with SMTP id n14-20020a6563ce000000b003c6a1867878mr6657662pgv.374.1652109262786;
        Mon, 09 May 2022 08:14:22 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id k7-20020a056a00134700b0050dc76281b6sm9221596pfu.144.2022.05.09.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:14:22 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 3/6] ARM: dts: aspeed: bletchley: Enable mdio0 bus
Date:   Mon,  9 May 2022 23:11:15 +0800
Message-Id: <20220509151118.4899-4-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509151118.4899-1-potin.lai.pt@gmail.com>
References: <20220509151118.4899-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable mdio0 bus based on DVT schematic.

TODO: Add Marvell 88E6191 Switch

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index eefb624d4850..0994ea3f41ae 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -829,6 +829,11 @@
 		&pinctrl_adc14_default &pinctrl_adc15_default>;
 };
 
+&mdio0 {
+	status = "okay";
+	/* TODO: Add Marvell 88E6191X */
+};
+
 &mdio3 {
 	status = "okay";
 	/* TODO: Add Marvell 88X3310 */
-- 
2.17.1

