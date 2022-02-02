Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF524A7306
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344937AbiBBO1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:27:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59336 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbiBBO1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:27:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29FA1B83104;
        Wed,  2 Feb 2022 14:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28731C340EB;
        Wed,  2 Feb 2022 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643812035;
        bh=Py5hbDI7QFg9kVgjWXWbp00X8G2g7PgLmwuqyEPZHcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6WNv3ThAYd/x/EDjfwGovlFMA408t9XdMxIed4ZEGXGGpud+xxJI10oeC77BeuxT
         a8D20GPdAXdKobH+GNm/wjm4/k84/hKbkkVpcr/8Ain/mfz3ouSWBV/HxVZpE3aTDh
         8oTVBs/oGBCEGCGFlwtdEbxD2NsOsDGuRcNMDL38Y0IoqkriqecZJrcpI7TO7OCcu0
         BfKet0eHIx60TX4k7cyj770tBbY09hCqcDa1Xh5eeE0wTqxiYyxAjUG++Ios4P0O0f
         PRf6TuUm6Qf5Eq9CHvgVAI4MlGgFRGGs81AWgSF1iDDxccoxLJaxdZw+bBui1IESoC
         76Phn4iNqZyiA==
Date:   Wed, 2 Feb 2022 19:57:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, hsinyi@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: phy: Add compatible for Mediatek
 MT8186
Message-ID: <YfqUwO16KxmBE7vP@matsya>
References: <20220128062050.23978-1-allen-kh.cheng@mediatek.com>
 <20220128062050.23978-6-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128062050.23978-6-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-22, 14:20, allen-kh.cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This commit adds dt-binding documentation of T-Phy for Mediatek MT8186 SoC
> Platform.

Applied, thanks

-- 
~Vinod
