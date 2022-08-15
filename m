Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAACC595225
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiHPFlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiHPFkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:40:49 -0400
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 15:27:20 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E706CD1;
        Mon, 15 Aug 2022 15:27:20 -0700 (PDT)
Received: from [192.168.0.12] (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 614F414015B;
        Mon, 15 Aug 2022 22:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1660602439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4c/Vn6NcaEIBanYavvPzdPCSkOe7p2YV5ZnRO6hBVo=;
        b=K+yGhokSqhjDbxedPjnTfMtnzoCBVOpwha9JSweOL3UkbsYYHBHuYqieLGLtus9nWhgMss
        9j+68mD0P+dZKPBizNlr2eSWRMpb5XkXkQFx9ps4Nv3SO/5+cibj4TBjvcJSYEakViwRTi
        W1GKZNRo9smsI1+IBrYYoJOgER6/luM=
Message-ID: <5ea0a9d7-cd14-1acc-3bd8-828c7b5e55ad@postmarketos.org>
Date:   Mon, 15 Aug 2022 23:27:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add PinePhone Pro
 bindings
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
 <4zqDGP71uKXjwgNqkEOaMdU5T3XKr7axd17DLLCEvoOEw1B_fov8tUyaGeNDyu9A1YYUkpRW2G33Uzs0CIkDoQ==@protonmail.internalid>
 <20220815123004.252014-2-tom@tom-fitzhenry.me.uk>
From:   Caleb Connolly <kc@postmarketos.org>
In-Reply-To: <20220815123004.252014-2-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/08/2022 13:30, Tom Fitzhenry wrote:
> Document board compatible names for Pine64 PinePhonePro.
> 
> https://wiki.pine64.org/wiki/PinePhone_Pro
> 
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>

Reviewed-by: Caleb Connolly <kc@postmarketos.org>
> ---
>   Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 7811ba64149cb..8ddedbd1ce317 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -494,6 +494,11 @@ properties:
>             - const: pine64,pinenote
>             - const: rockchip,rk3566
> 
> +      - description: Pine64 PinePhonePro
> +        items:
> +          - const: pine64,pinephone-pro
> +          - const: rockchip,rk3399
> +
>         - description: Pine64 Rock64
>           items:
>             - const: pine64,rock64
> --
> 2.37.1
> 
