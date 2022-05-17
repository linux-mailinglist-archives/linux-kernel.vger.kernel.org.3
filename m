Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4F52ACFC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353026AbiEQUtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbiEQUtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:49:49 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BA952E60;
        Tue, 17 May 2022 13:49:46 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AE690C0008;
        Tue, 17 May 2022 20:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652820584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTwYHMZ9AJOOz5QnG1101HT1nNGvfTsi5HXdvlLVRds=;
        b=DetHmiIWHV3mClxsq+hjnBmKx1krmZB5xf2D5gk9N8d4QYaDxnWHnOMYcQEKH3/Z+LEh8X
        I/dvHcKF7rOlWli54pHqXiuhcJ/k873gjzWfgmwNxN6lNdUd3xQspwgxepRsgKvBTownhK
        gw+lY0Cgsgl1np6svUshX163QzMkq5MSL5XAB0rcP3wYLChBQnp1GoG6+ulyvSAU26E42O
        q7K1Yqoou0qU8wjVeNLEmY89F8+LaEhCzuUUlM5tq6cRxOfaDYRYeyIJeN70shrrjBpl3F
        SoykS6Ef8EzolhHF3PU01bODKA+01uytgOb/HK7j0C6GdtBG99YJQBoiibONuQ==
From:   alexandre.belloni@bootlin.com
To:     Samuel Holland <samuel@sholland.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: sun6i: Add NVMEM provider
Date:   Tue, 17 May 2022 22:49:43 +0200
Message-Id: <165282057545.288453.15330991918846151117.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220413231731.56709-1-samuel@sholland.org>
References: <20220413231731.56709-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

On Wed, 13 Apr 2022 18:17:30 -0500, Samuel Holland wrote:
> The sun6i RTC provides 32 bytes of general-purpose data registers.
> They can be used to save data in the always-on RTC power domain.
> The registers are writable via 32-bit MMIO accesses only.
> 
> Expose them with a NVMEM provider so they can be used by other drivers.
> 
> 
> [...]

Applied, thanks!

[1/1] rtc: sun6i: Add NVMEM provider
      commit: 581d6d8f483696ff164f52a71beb43a87b718592

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
