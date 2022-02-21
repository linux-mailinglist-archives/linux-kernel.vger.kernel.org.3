Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EAB4BEBA2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiBUUNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:13:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBUUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:13:40 -0500
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E13610E7;
        Mon, 21 Feb 2022 12:13:14 -0800 (PST)
Received: from [10.0.0.111] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 017CA20056;
        Mon, 21 Feb 2022 21:13:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1645474387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qH/9p1w6QC2hLIU0utsg/6yIl4selFdaqpNjspWxRvA=;
        b=pkZi2gwc9ZHBBYwbaC0tJt7ppT0MF2oIaUdtZRokZeebn1CxsczIznK9kGCzK3yJu4IfJ+
        19XxjEAnUW3d00x5VPovcLeXUJJaDTEWf0cdmvn1ceumyNELXXcxCuHkxBKJYmpCDIw2Qz
        ymrTJpCIfjrOTh9F+0GerkJeaqgTYUA=
Date:   Mon, 21 Feb 2022 21:13:00 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add second HiSilicon
 prefix
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>
Message-Id: <O58O7R.2UU60LTBXDXZ1@ixit.cz>
In-Reply-To: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
References: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: David Heidelberg <david@ixit.cz>


On Mon, Feb 21 2022 at 09:22:26 +0100, Krzysztof Kozlowski 
<krzysztof.kozlowski@canonical.com> wrote:
> There are few boards DTS using "hisi,rst-syscon" property -
> undocumented "hisi" prefix.  The property will not be changed in DTS 
> to
> non-deprecated one, because of compatibility reasons.  Add deprecated
> "hisi" prefix to silence DT schema warnings.
> 
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: David Heidelberg <david@ixit.cz>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> See:
> https://lore.kernel.org/all/61AF1E3B.5060706@hisilicon.com/
> https://www.spinics.net/lists/arm-kernel/msg887577.html
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml 
> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index ebe294516937..79a172eaaaee 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -505,6 +505,9 @@ patternProperties:
>      description: Himax Technologies, Inc.
>    "^hirschmann,.*":
>      description: Hirschmann Automation and Control GmbH
> +  "^hisi,.*":
> +    description: HiSilicon Limited (deprecated, use hisilicon)
> +    deprecated: true
>    "^hisilicon,.*":
>      description: HiSilicon Limited.
>    "^hit,.*":
> --
> 2.32.0
> 


