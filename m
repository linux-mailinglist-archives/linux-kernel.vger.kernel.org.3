Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DC74C8C14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiCAM6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiCAM6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:58:47 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673C013F2F;
        Tue,  1 Mar 2022 04:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=dEZeDrjsIzY0RrTo4uH6LCxsW77wAiB3aeEDQoZvGb0=; b=y26oi
        8DUfY7wPVY+Btl2Z6xXD1TtHWrqBS1unDolNzksxqZxi3zr8h7YoSNuGHxoSRtPUmssh7+OQXZnYx
        3+RGVbJnV1oaYxSAVkQPJSVOKou2Z9XBxPfSE0B8SP/DYjBBo0lQ+0WEn7iZ/SBpM+O9zO7cx10DZ
        rJuvoFVtc+Trtu1PTmPEFos0fj1SuHz0HADTZCl30sV/GnUIy/xiP0i6vLggJ9IpGdHj3gktvX8wg
        HZCwx3ohPfypPIFhCwrtTa95V3S5s3FsbQ/T44lQ4uVrEfblktLXmkDopeAZPcApWFLco3QMIXlQF
        jgNS7o3Ggqpu2opvedY9VqDJxSb9w==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nP249-0007q7-6Q; Tue, 01 Mar 2022 12:57:21 +0000
Date:   Tue, 1 Mar 2022 12:57:16 +0000
From:   John Keeping <john@metanate.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 10/16] crypto: rockchip: rework by using crypto_engine
Message-ID: <Yh4YLGeaXAzzr+PK@donbot>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
 <20220228194037.1600509-11-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228194037.1600509-11-clabbe@baylibre.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 07:40:31PM +0000, Corentin Labbe wrote:
> Instead of doing manual queue management, let's use the crypto/engine
> for that.
> In the same time, rework the requests handling to be easier to
> understand (and fix all bugs related to them).
> 
> Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---

In addition to the warnings reported by the kernel test robot, this
needs to add select CRYPTO_ENGINE to Kconfig for the Rockchip driver.


Regards,
John
