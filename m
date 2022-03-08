Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A44D2356
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350478AbiCHV3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350458AbiCHV3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:29:33 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C892B3150F;
        Tue,  8 Mar 2022 13:28:35 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 57DB0C0006;
        Tue,  8 Mar 2022 21:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646774914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUIreEr/bRgy0DFDUqowfnimyNsYHJN1LGnjWbGc9eA=;
        b=XSE/ahn08fYktqXgLludolAYJ90F9Krm7hUvcDtpTO1KypVQimCrkpWoi7GQ6gY0xLAaYa
        3x4rxzCwrDB6MG8ihsdguCSowoE2nX2cBFopFsMaii4YD1y1qfyHUQODeTMS7CMMF9TYbk
        IjE2/u8fMDl0IVrZIPbspKj9/k3NaoW2DIm8ZhDC16UrpxMJsNmHst2AIj/gLihdxrYylm
        cYt4Z0kyc2LhNrEfbf+eS9jvkGXz0PhrGLXv4To/zSvJtP7lCWdWgv9mID3gwvCMHjUqaD
        eVhNEBvwbpl2SQsIiShNNKElYOGLt5hi9fE5MFEsFOoI7XmaFVAIUoTkl3Yn+g==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Ondrej Jirman <megous@megous.com>
Subject: Re: (subset) [PATCH v10 06/18] rtc: sun6i: Add Allwinner H616 support
Date:   Tue,  8 Mar 2022 22:28:29 +0100
Message-Id: <164677489899.102692.4262645098452145668.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211122643.1343315-7-andre.przywara@arm.com>
References: <20220211122643.1343315-1-andre.przywara@arm.com> <20220211122643.1343315-7-andre.przywara@arm.com>
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

On Fri, 11 Feb 2022 12:26:31 +0000, Andre Przywara wrote:
> The H616 RTC changes its day storage to the newly introduced linear day
> scheme, so pair the new compatible string with this feature flag.
> The RTC clock parts are handled in a separate driver now, so we skip
> the clock parts in this driver completely.
> 
> 

Applied, thanks!

[06/18] rtc: sun6i: Add Allwinner H616 support
        commit: df02071fd3fb8228a0996758a251994e61df04cc

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
