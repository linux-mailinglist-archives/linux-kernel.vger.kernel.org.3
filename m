Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2605946BBBF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhLGMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:52:54 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44510 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLGMws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:52:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 65603CE1A7E;
        Tue,  7 Dec 2021 12:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E127C341C1;
        Tue,  7 Dec 2021 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638881355;
        bh=FUeS5OKYqlwq5GfNT9YDHvFKgZgQJXp5vN47IEJN1UA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JBZIwpAzGmvTKQHbYTaJlAZXiovuJzhYcwOrExykuTUsAMm4PSqED1hxQbuyTb6+4
         Hc2NHDRULa7/Fulg8DNPooWxTUxBSXYDmwkIenJS4uM6Ox08XUlQtvnWd5PECqAZw2
         QHbNsc3YyDkBWvrZwM246WA4wKoII642Sf17zmiR1bLLt4TQsiyO/1cOEXfeEPkQ5s
         /jLGtS3aFhfDn4k53n3NjBcBbl4d8VoKdc7G6QxrO2I1y8E2t7X0eQN4Eg5xo45umM
         4ji+hQNqL7weS3CJig3tbMc97s38F3nFFtDCi11mmlcA/ta9I1erg/cdIyK8R6szYe
         w12uaSHR/OJmg==
Subject: Re: [PATCH] dt-bindings: memory-controllers: ti,gpmc: Drop incorrect
 unevaluatedProperties
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211206174215.2297796-1-robh@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <d2b524c5-3e65-248d-44d2-eaf337cf4765@kernel.org>
Date:   Tue, 7 Dec 2021 14:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206174215.2297796-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2021 19:42, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the TI GPMC example
> has a warning:
> 
> Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.example.dt.yaml: memory-controller@6e000000: onenand@0,0: Unevaluated properties are not allowed ('compatible', '#address-cells', '#size-cells', 'partition@0', 'partition@100000' were unexpected)
> 
> The child node definition for GPMC is not a complete binding, so specifying
> 'unevaluatedProperties: false' for it is not correct and should be
> dropped.
> 
> Fixup the unnecessary 'allOf' while we're here.
> 
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

cheers,
-roger
