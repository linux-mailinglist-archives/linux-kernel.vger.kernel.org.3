Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB994BBAA9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiBROdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:33:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiBROdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:33:11 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA4825AE6E;
        Fri, 18 Feb 2022 06:32:53 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5E725FF808;
        Fri, 18 Feb 2022 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645194771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilA53umUtnmqPhELfjf166xepuYFHYKSwnmlx/soh6k=;
        b=bFDr/GInPV++oTzutDVGOwvRe9vA0HoRFKba2bRFGTwdpSJkVKZuYV4dxNJTF3EKDbMJGW
        E+tHKE6Oe4Dv3jJppChsO1ZYezG8PybdQFaqRTBDwjsDrxke70kZqCRODYQayNm3/pA/AL
        RcLSGTkEyfM/Wv5ibsYGeW8Lw2WQKBE1J2bLTrzxGLM17eUJ4QQ79A9Kx8AOt4iIDmspI4
        r0gLhT3U9lq7E0D6j1AJar4VC2UiyagVabeZwSStJOD5G7mqFu/n84/AL6GuD9ED3wRt3I
        oY7HoK26A7asmbYcB/LbrdEOPl4uoc6jERhzD+HRd1OIzNNfbzBeGzn9wt3xFQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>,
        krzysztof.kozlowski@canonical.com, linus.walleij@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: mtd: drop mtd/cortina,gemini-flash.txt
Date:   Fri, 18 Feb 2022 15:32:49 +0100
Message-Id: <20220218143249.321926-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220211120842.3388592-1-clabbe@baylibre.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'438356e5151b929af90e501b9c6dd1f3ea2fc7c4'
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

On Fri, 2022-02-11 at 12:08:42 UTC, Corentin Labbe wrote:
> Drop mtd/cortina,gemini-flash.txt since it is nearly already handled by
> Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.
> 
> We add jedec-flash to list of compatible because one board (gemini-dlink-dns-313.dts) needs it.
> See commit a10d862e585e ("ARM: dts: Fix the DNS-313 flash compatible")
> The flash on the DNS-313 needs to be probed as JEDEC, it does not conform to the common CFI standard.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
