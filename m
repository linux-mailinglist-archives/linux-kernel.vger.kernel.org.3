Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1587E4C8C2B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiCANBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiCANBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:01:38 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65CF9ADA1;
        Tue,  1 Mar 2022 05:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=M542kUDYwYiNo5piJUcRV3k6x93s5dP3ia7BcMUvork=; b=M1Mzb
        6+gUV25q8y5q9JN07VrgezVwW6vCHpnisrPaZpnl+tM6m6HILbmxTMZDd1+mgZ4yt8SSSNsfaGA2V
        3AepluzHpoN4AEEdyFCSp6k3gemCgESJT8COZqL7Hby/MrWx7zDtQDB1uNE2k1iA/8cGZJ6pW4a0v
        oirP+StqBTdtuqt1W/Z1HClzRmc9d+Pc2rP1eTWQQ30cnBLAjZeVsQpsGissorGUfAiDn6V4oKg5H
        QGASjXN4Dynv1+eOH1ihM6ATCUIW8Go9RkhysUTg76ImfTsDkkkUc6TAMyqyOR5KTKhoUA6MSiHpJ
        qmItrP0ATa0upTuWCke0vlt2zXzvA==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nP27M-0007wi-D0; Tue, 01 Mar 2022 13:00:40 +0000
Date:   Tue, 1 Mar 2022 13:00:39 +0000
From:   John Keeping <john@metanate.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 00/16] crypto: rockchip: permit to pass self-tests
Message-ID: <Yh4Y99KCi+1lbrve@donbot>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228194037.1600509-1-clabbe@baylibre.com>
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

On Mon, Feb 28, 2022 at 07:40:21PM +0000, Corentin Labbe wrote:
> The rockchip crypto driver is broken and do not pass self-tests.
> This serie's goal is to permit to become usable and pass self-tests.
> 
> This whole serie is tested on a rk3328-rock64 with selftests (with
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)

I previously noticed this breakage on rk3288 but never got time to
investigate (disabling the driver was quicker).

This series fixes everything on rk3288 as well, thanks!

I hit the same warnings as the kernel test robot as well as a missing
new kconfig dependency (see separate reply to patch 10), but this is

Tested-by: John Keeping <john@metanate.com>


Regards,
John
