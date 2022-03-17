Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845394DCEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbiCQTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiCQTRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:17:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74722261CA;
        Thu, 17 Mar 2022 12:15:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id rm8-20020a17090b3ec800b001c55791fdb1so6356220pjb.1;
        Thu, 17 Mar 2022 12:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ra3lig8Mw5jgrfIYORH6OPZQGSdQZUTC0lhaPMPwJKY=;
        b=M4AvDjXI/NitZPtXNLOus/tMJ6/l+u6+pfomdfirI+wQmqSMdTDoI/O/PZPXJSj+b9
         KLDjtwGI4mJga86llA0NxD1YdZMQE23lNYkgShZQTlJpU8i4CDveEVR4f4/KavMXqX6L
         PBQTxnsS0gFUXD5pm/jtbVBQQ1ZxWOsnSYLBsPIaC5FZzZu+UheAbZZIexi70gE569ys
         X7Dhp2n/ngtAI/QXcR30cBMLEZ2YxUNwl0MsO/azrk0MDrQChZghK3wWbriiYnj5yFCi
         J0L0Z8biOyjoKGk6A7N4vTDG+Fd3W5CmxXWc3/zrU7mVJQTxM9h462oWG4sQ6AUGleKL
         x+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ra3lig8Mw5jgrfIYORH6OPZQGSdQZUTC0lhaPMPwJKY=;
        b=aCloF7s0oi0Q370wz/LLkeSVWSzQAGk3hP8BjbDOo23tmf8xKm7F9eyvOPluOfoG5h
         LurCbAjTUJOlCnfYAleL3MwS7uF+hKVibAcF+HCL45GSrTKy4t6XxPoaGMR305NoaSlM
         +CEs3kNqFd0taaaWpdcrpwn4oqx+gRPUGFg+iuNxdHne70byVYUoXWYyeII6DawEYeBb
         vDFsGTvZsVnUA/DbUoHy5rNjywmcLdaAlMSeLJjiE4BsuAvvKVzy8jJiIuGzyy6a0kK/
         9CKzTEWGRxgBa8QLtFosPHCfn2+V1a7jAJRkq3zXPJ4f+TL0qNkNtmk0lfegIj0ZraDc
         o58Q==
X-Gm-Message-State: AOAM530y8/RfsPxXnF/GrHY5mJHb5rBwupfz5QYqdlya3cDKpHBXqIvX
        /1D6snZlxRFLgt6vbZqKOGQ=
X-Google-Smtp-Source: ABdhPJzZrFOfTfDFR/A+MlW2V7H/O5+s8KWluMgYHWIxVUMEOBwUxz7hGpUNjliJLIqA0EyC3gBN2A==
X-Received: by 2002:a17:90a:558b:b0:1c6:6f44:a36a with SMTP id c11-20020a17090a558b00b001c66f44a36amr7028417pji.141.1647544551687;
        Thu, 17 Mar 2022 12:15:51 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a0010cb00b004e1b76b09c0sm7623076pfu.74.2022.03.17.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 12:15:51 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 3/3] ARM: dts: aspeed: Remove arch timer clocks property
Date:   Fri, 18 Mar 2022 00:45:26 +0530
Message-Id: <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arch timer either require clock-frequency property or doesn't need to
specify clock at all in DT. In general, frequency can be determined
internally and in case of brokern firmwares, need to extend
clock-frequency to pass info to driver.

Aspeed BMC is the platform which defines clocks property, an invalid
entry which can be safely removed.

Moreover, clocks also matches incorrectly with the regex pattern.
Remove this entry altogether to fix it.
'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index c32e87fad4dc..d5ef9aceb632 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -64,7 +64,6 @@ timer {
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
-		clocks = <&syscon ASPEED_CLK_HPLL>;
 		arm,cpu-registers-not-fw-configured;
 		always-on;
 	};
-- 
2.25.1

