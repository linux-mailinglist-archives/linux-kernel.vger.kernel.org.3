Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B463D597A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 02:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242368AbiHRAHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 20:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiHRAHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:07:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649AF98CA8;
        Wed, 17 Aug 2022 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=tLr7+QdcKt37fG9vQbW6OA+sM/lUyc4qqqxSutQDtsE=; b=n4FyXfDNdZ2+mPwzuXs3F9T9aE
        XLhHeva+FpcuezzFtlU92BHJwx5IeCU/ZdOoaNE1zAkhD1U35rtowKkaxarwIE6RLp7JFxQGfbg7k
        2dYRoWqd1OGqpoZU8mSN0teqfwVeRkP2REDU4ZKu/lQhgcYHXTe8QbrJzZ7aM4p2hWOZuoNz1TqKA
        FSYNEbeGiDRb8RBOFQddg+Zjwx2RTHTQ7NglpoViJSy6PX/u0bGlSkIB9IIGMKz3URBfC41TdTB7j
        9ZKwStocGOJSZAJevMbmoXIrXI3tn1F771cac4gj1S6VwK+DkM3Cd8VDQOYm/5lbKXlPU04hAcubA
        r0Y3p8yw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOT4C-008zMn-Uz; Thu, 18 Aug 2022 00:07:21 +0000
Message-ID: <37646b7f-8479-133e-7340-23580072d4f7@infradead.org>
Date:   Wed, 17 Aug 2022 17:07:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH/RESEND v1] "system" mispelled as "ststem" in help for
 configuration option SND_AUDIO_GRAPH_CARD.
Content-Language: en-US
To:     Maurycy Z <10maurycy10@gmail.com>, linux-config@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
References: <Yv2AytbyUT/pCrn+@thinbox>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yv2AytbyUT/pCrn+@thinbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We no longer use trivial@kernel.org for kernel patches, so this needs to be
sent to the correct maintainer(s) and mailing list:

SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)
M:	Liam Girdwood <lgirdwood@gmail.com>
M:	Mark Brown <broonie@kernel.org>
L:	alsa-devel@alsa-project.org


Also, the Subject: line should look similar to these commits:


95373f36b9b8 ASoC: add Audio Graph Card2 Custom Sample
6e5f68fe3f2d ASoC: add Audio Graph Card2 driver
d293abc0c8fb ASoC: test-component: add Test Component for Sound debug/test
5268e0bf7123 ASoC: Fix 7/8 spaces indentation in Kconfig
c8ed6aca6b82 ASoC: simple-scu-card: remove simple-scu-card
61c263ac27a3 ASoC: audio-graph-scu-card: remove audio-graph-scu-card
da215354eb55 ASoC: simple-card: merge simple-scu-card
ae3cb5790906 ASoC: audio-graph-card: merge audio-graph-scu-card
c3830f1a00f0 ASoC: audio-graph-card: tidyup typo SND_AUDIO_GRAPH_CARD
87f937b45f7d ASoC: add audio-graph-scu-card support
2692c1c63c29 ASoC: add audio-graph-card support
97b4bc76d9f7 ASoC: trivial: system spelling fix
88da724f77f7 ASoC: simple-scu-card: depends on CONFIG_OF
d12c6216c4a5 ASoC: rsrc-card: rename rsrc-card to simple-scu-card phase3
cecdef365695 ASoC: simple-card: use asoc_simple_card_parse_daifmt()
abd3147e6948 ASoC: add new simple-card-utils.c
f2390880ec02 ASoC: add generic simple-card support


You can also add
Acked-by: Randy Dunlap <rdunlap@infradead.org>
to the patch.

On 8/17/22 16:59, Maurycy Z wrote:
> "system" is mis-spelled as "ststem" in the help for SND_AUDIO_GRAPH_CARD.
> 
> Signed-off-by: Maurycy Zalewski <10maurycy10@gmail.com>
> ---
> 
> diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
> index b6df4e26b..72f3446e1 100644
> --- a/sound/soc/generic/Kconfig
> +++ b/sound/soc/generic/Kconfig
> @@ -16,7 +16,7 @@ config SND_AUDIO_GRAPH_CARD
>  	help
>  	  This option enables generic simple sound card support
>  	  with OF-graph DT bindings.
> -	  It also support DPCM of multi CPU single Codec ststem.
> +	  It also support DPCM of multi CPU single Codec system.
>  
>  config SND_AUDIO_GRAPH_CARD2
>  	tristate "ASoC Audio Graph sound card2 support"
> 

Thanks.
-- 
~Randy
