Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B144B7A76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbiBOWaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:30:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiBOWaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:30:19 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3B59E9C1;
        Tue, 15 Feb 2022 14:30:08 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 04D00100005;
        Tue, 15 Feb 2022 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644964205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uGxbKJALjdQWXJoB5xhkbF5xjty/yQs85sxAFzAGws=;
        b=ZTL+UlISssfW5u1U5HgPgzPk97O9i09r6zKBXj3W9/LKH0MKHGSuURy5nVmaj1x87tZILa
        aEjVLJP4zqJWvUJARkf4B+taVCdC5wp6tkhp3IalGPe1oIERkbAc5etpoFRLA9udAtJbIM
        PigfDVG+7NAQO2MxU933sa6vH6bT6fT60Fwefvt9Ra7eQfNq70o5bQtiZ6seT0DPVq2+KA
        Tr7Ec81ja7lEc6jukqN3STtPHm/CLjxTc6+9UGJaWuvH/SeVP4qwOf6u9IM5jOUfqGNm0T
        HBBSYwa7cZv0uq+y1tHdymFjY7Q0iBKeQloq6M4zH1Wt0sSI394X7r6e47YiLQ==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org
Subject: Re: (subset) [PATCH] rtc: pcf2127: use IRQ flags obtained from device tree if available
Date:   Tue, 15 Feb 2022 23:30:04 +0100
Message-Id: <164496419669.66498.1082108220146364958.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220117225742.1252362-1-hugo@hugovil.com>
References: <20220117225742.1252362-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 17:57:42 -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> If the interrupt pin of the PCF2127 is routed to the input of a GPIO
> expander using the pca953x driver, the later will only accept an IRQ
> of type IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_RISING, and the IRQ
> request will fail.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf2127: use IRQ flags obtained from device tree if available
      commit: d4785b46345cc9564f883c94acc4c4de6bbfeea5

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
