Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4756E4D2353
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350466AbiCHV3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiCHV3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:29:32 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4C41FA78;
        Tue,  8 Mar 2022 13:28:32 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 94AB9C0008;
        Tue,  8 Mar 2022 21:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646774911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjwxB5pqPhhEakzxq4wWhbJUb8KLqJuhudpO6/+VAQ8=;
        b=ppao86ULf8dINnqhGkX+uPfKHne8Z8pAIdkckj/qt6daF9TojKLpAEqa0DbrDkmXUoa/Bn
        x7JnMRhpSwDtHNKyV1wmSKPhicwFsNPfSIdI1B9Lm7wGdpsfup4Rk8wkW7QplPdPJx6BNv
        vBJ7AKtMhgmtntbA7DTXurqyNbJGCdGN6VWldWvZGLMRtckqjIFe6niSJ8HS726lc/8gcJ
        X0mg+EOz+WrD2X1xtqY43Is1yXaPzPcPhxNCoUfiXIDtGsEkswDcJm5JBmZrqQTirvKNkm
        jx5/a62rlXnvOcF0KJ8zBtXBD8pC6M2lcwEFOvQzCLfIm/3YVWXCRrUPFNEpWg==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: (subset) [PATCH v10 04/18] rtc: sun6i: Add support for linear day storage
Date:   Tue,  8 Mar 2022 22:28:27 +0100
Message-Id: <164677489899.102692.6592261891935466294.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211122643.1343315-5-andre.przywara@arm.com>
References: <20220211122643.1343315-1-andre.przywara@arm.com> <20220211122643.1343315-5-andre.przywara@arm.com>
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

On Fri, 11 Feb 2022 12:26:29 +0000, Andre Przywara wrote:
> Newer versions of the Allwinner RTC, as for instance found in the H616
> SoC, no longer store a broken-down day/month/year representation in the
> RTC_DAY_REG, but just a linear day number.
> The user manual does not give any indication about the expected epoch
> time of this day count, but the BSP kernel uses the UNIX epoch, which
> allows easy support due to existing conversion functions in the kernel.
> 
> [...]

Applied, thanks!

[04/18] rtc: sun6i: Add support for linear day storage
        commit: 62a8306e7315a1ce4479bc7c4f35ba5f9c75b9ab

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
