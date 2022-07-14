Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F571574C10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbiGNL2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiGNL16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D7959254;
        Thu, 14 Jul 2022 04:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A5F661B75;
        Thu, 14 Jul 2022 11:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10998C341C6;
        Thu, 14 Jul 2022 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657798071;
        bh=z3OehqzocWWfEInB5FG2h4y3ILd+e0iNXAQOXKXUjPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+734pI6r2qJStCs1uQdWyl2f0eVUtzmP5Tnc4PvAb+v9B1sFZNRanQeOWa6MNw41
         s45RBw5kMgOVx59Y2QYwEnc0xITsuCAJA/AXBTFEr/QuaJ2yivwGYtM1HHtU4fxBPe
         fJw9fa4+90LXZjRB8kvcdViBIhnIt/h3lg8jscE8SCvPGuH6f8MO00hCRAjNfrPQYa
         QaZEXYfOVlpb4ayBmXcsypzx3RTOYrFs1zOolBmX4OXfUEMRX9TBGRIb4FdNtR3iun
         G95Cfw6MSmqDI+uOJH8Bf8V7RzDLXKJg65pbLCP2o/WaPOVJCyGqAU2aYKIqpuJNzJ
         GhUEm1P/I4mqg==
From:   Lee Jones <lee@kernel.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: [PATCH 3/8] MAINTAINERS: Remove myself as PWM maintainer
Date:   Thu, 14 Jul 2022 12:25:28 +0100
Message-Id: <20220714112533.539910-4-lee@kernel.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220714112533.539910-1-lee@kernel.org>
References: <20220714112533.539910-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry and Uwe are doing a fine job, leaving me surplus to requirement.

Happy to pop back on-board if anything changes in the future.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5fbbeec1fae6b..67ae1329123fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16465,7 +16465,6 @@ F:	drivers/media/rc/pwm-ir-tx.c
 PWM SUBSYSTEM
 M:	Thierry Reding <thierry.reding@gmail.com>
 R:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
-M:	Lee Jones <lee.jones@linaro.org>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
-- 
2.37.0.144.g8ac04bfd2-goog

