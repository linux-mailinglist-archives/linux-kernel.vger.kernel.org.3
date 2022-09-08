Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4F55B16F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIHI1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHI1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:27:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BE48E99C;
        Thu,  8 Sep 2022 01:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D9D3B8204B;
        Thu,  8 Sep 2022 08:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE0DC433C1;
        Thu,  8 Sep 2022 08:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662625657;
        bh=Eo2pRaNuO4sf2mE2unCxNUqWyvB0vbD8c+vHCwj8PuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H20Ss7G1aoBSqE0GW0IlPIamIz9NucjMyR98agJqhthW8pay9TT7E5qD4qhnVU4fS
         iGAW6KBl7rbYkfYtDy6dswEftBe9UNhGInZsVta6lHoMONvaRQK9Tg7XSsb8ZT4Erl
         KrlNV4D4jSm9XfXo17072eWGAHnj/8+cmMC29B+aBMGSe0uNnZJWZ4ygsafkK53MiK
         UzCiCLoW3UKq5u7iMC+uG+toq4IQ1fH6/Dx7k30Tl3WxmC3crof35nOkI+acXZISlv
         TYBt3EhPf3w9OmPthvcIQOCWeQayJNBmiWeUWbm9NfKBh0S+j7c4cx+1dReKa+fhek
         CWxDwcxaVAX8Q==
Date:   Thu, 8 Sep 2022 09:27:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: syscon: drop ref from reg-io-width
Message-ID: <YxmndCN66k/dw8Zk@google.com>
References: <20220823101021.387034-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823101021.387034-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022, Krzysztof Kozlowski wrote:

> reg-io-width is a standard property, so no need for defining its type
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
