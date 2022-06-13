Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A91548416
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbiFMJyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiFMJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:54:01 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346FD186FF;
        Mon, 13 Jun 2022 02:54:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q140so5086647pgq.6;
        Mon, 13 Jun 2022 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/cXVElxHAcvgbTqkcDPEZcgMxgzQCWHYrFhvr/zy9d8=;
        b=fY6zN5C+bBWs5V8Mu3xSpbjQPxb5GNgJwzl0WAfablo8FG8nwL3VJfXEB9Z5f4garM
         HecCZm+crzpugtGg0XDvPayO9KSCf1zck8RMhSckWz41R1jDpBPCr8yCITFF3Dlc9qFg
         KMvkm4qFzFC6enlW1HkV0zr1MUDNbt+X8oHj0VBPzOhFYGCMjyWxHSRchgBvOXa9kpNY
         x53pqaylUrni+sLBr3pPvBOv+2RdqRhou023bztWj9pHXDQi4nJa2Yf0Qo/BhN6ZeuGJ
         EwWsQra/5hlM9r7Tt4NK/NsbM2/QNMim6ikGa87b9JlTUwPiiXjpgxc2arZBdeQFMTDr
         XGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/cXVElxHAcvgbTqkcDPEZcgMxgzQCWHYrFhvr/zy9d8=;
        b=badJ6cSlUZ/LWajq0BQGC8nNcjGLSUl4rX3NJV8INpdf0vLQeuT7E5EgmE6LdRp/Fw
         hLboT93MSxS1FFp+1kMK49K2uw6QdJpZsaRMmRi3JD6uKDvz+sYdc2UVPmndoIEq9oq1
         hnBCgC+LH5ssExP+wDP63AiEDhgFL9MYy2kamRFuJP8Z484H/f4mmM+J46m9SpXR3cQi
         LprfjLD4G/VzpT4Cqec91Lui32yHu97PjpZshSUTJf4qF9GWis6BxIiRVDAx2vzhJ1oG
         Rp2mkeTWqRHoq4BaSEqkOiGdNB1XbAkFzDtOXW87sfwfPtiwLcMYdc29j/JV9Yw6GCBd
         4w4g==
X-Gm-Message-State: AOAM531gYPlEZOXBujCHxs9pCK++mdc9Wp4+W0K51sqVWenM/6dRq6jP
        ZdSZaMFFO2p+jTXcoPCXIq0=
X-Google-Smtp-Source: ABdhPJyGCEMsQN9qDf3iwARJOkhFXJADJBx5omweDUlEcjVMzYEnFVPENmPbWF1LT76ms1Ryy4fHOQ==
X-Received: by 2002:a05:6a00:23c6:b0:51b:f8e3:2e5c with SMTP id g6-20020a056a0023c600b0051bf8e32e5cmr45996931pfc.43.1655114040629;
        Mon, 13 Jun 2022 02:54:00 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b001639f038250sm4639754plk.220.2022.06.13.02.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:54:00 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 1/4] ARM: dts: aspeed: bletchley: change LED sys_log_id to active low
Date:   Mon, 13 Jun 2022 17:51:47 +0800
Message-Id: <20220613095150.21917-2-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613095150.21917-1-potin.lai.pt@gmail.com>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change LED sys_log_id to active low base on DVT schematic.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 41d2b1535d9a..d34bfa50620e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -59,7 +59,7 @@
 		compatible = "gpio-leds";
 		sys_log_id {
 			default-state = "off";
-			gpios = <&front_leds 0 GPIO_ACTIVE_HIGH>;
+			gpios = <&front_leds 0 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-- 
2.17.1

