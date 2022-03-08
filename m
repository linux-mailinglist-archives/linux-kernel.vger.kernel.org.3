Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14FD4D2354
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350473AbiCHV3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350335AbiCHV3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:29:32 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3F31512;
        Tue,  8 Mar 2022 13:28:34 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C6423FF808;
        Tue,  8 Mar 2022 21:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646774913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTarAopzLDOuafPpTwK5kvhF2KZ8Y6/kloPhqGXDzLM=;
        b=NxbKMJ/EFDVUGnkxlbV4VtWvuKGXiMPODYCFL4g6R3DHH0ivm4hZVqSBOwO4Zn3Mh5lAhF
        4JqKhMOr8YjRX1HeWzZ1FZNWZf8nr7rsFntoCqP/GCfCyrbL0sTYlBYEn6SOKYsCdTRgIb
        mGMHy28sWOsU9X9dByORprKNJvNJQUc05syXNgDSskG1TIb9k/BBwM0B5UfsnP3Z04kEft
        SI5s1CsPM8BNn+jIvBb31KMvIgGEugNgri6uFlHnmpKOjJKi8dg2BKZuFE5TqJ6qxsm8a6
        ZikDRT9X/cPyoaul1cSdSJarZh/A8ZCzdo6gklTv28mKWxxVM2TGe+l+mNXY1A==
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
Subject: Re: (subset) [PATCH v10 05/18] rtc: sun6i: Add support for broken-down alarm registers
Date:   Tue,  8 Mar 2022 22:28:28 +0100
Message-Id: <164677489899.102692.3167315727676905171.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211122643.1343315-6-andre.przywara@arm.com>
References: <20220211122643.1343315-1-andre.przywara@arm.com> <20220211122643.1343315-6-andre.przywara@arm.com>
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

On Fri, 11 Feb 2022 12:26:30 +0000, Andre Przywara wrote:
> Newer versions of the Allwinner RTC, for instance as found in the H616
> SoC, not only store the current day as a linear number, but also change
> the way the alarm is handled: There are now two registers, that
> explicitly store the wakeup time, in the same format as the current
> time.
> 
> Add support for that variant by writing the requested wakeup time
> directly into the registers, instead of programming the seconds left, as
> the old SoCs required.
> 
> [...]

Applied, thanks!

[05/18] rtc: sun6i: Add support for broken-down alarm registers
        commit: fd6e4315d0dac5c919f6c80db42120793abb8706

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
