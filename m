Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878954F13EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376328AbiDDLlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357235AbiDDLlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:41:44 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4E60F8;
        Mon,  4 Apr 2022 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=mkeyhSxyusAHKnALY1uDS0yoYbKp/eWJvkf6lcIQ/ow=; b=Fm5GA
        TBQNzVNjpeMf6PBUOAJ9pNHY3ubuipR2YgkdzmOpAhyPvBAigkYuaS6Bt0qztNTinj82y7cY5wrzk
        8M49jVH8ViVvLkqvhIPegfDZSkhFhWx36ewZbiITh9OAsu/ycpVz5a+dHUtHxUCoYRX56bJiAK7Du
        5/r0ZfI60FYkAuR0uw0E2vD0KLCxNiNvj0S/TFUIfUgPVBbwx1rf4dVqqyANjk28GnrUR1GqUamEM
        1umr5Lxo//WXFEco/mu2E/pvtYSX3Ndk1cB0o5G+FHykx0xxC39HxCfCUddgMQnD4J8a0iDbj4wVh
        IyGkZNPCSsaO8V3OeZwvbDozc22qg==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nbL3h-00054c-2I; Mon, 04 Apr 2022 12:39:45 +0100
Date:   Mon, 4 Apr 2022 12:39:43 +0100
From:   John Keeping <john@metanate.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 18/33] crypto: rockchip: fix style issue
Message-ID: <YkrY/9xE702mqKR/@donbot>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
 <20220401201804.2867154-19-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401201804.2867154-19-clabbe@baylibre.com>
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

On Fri, Apr 01, 2022 at 08:17:49PM +0000, Corentin Labbe wrote:
> This patch fixes some warning reported by checkpatch
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/rockchip/rk3288_crypto_ahash.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

There's also a badly indented comment in rk_hash_run() which could be
fixed in this patch.
