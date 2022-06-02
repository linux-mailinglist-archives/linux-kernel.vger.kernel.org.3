Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1953BBCF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiFBPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiFBPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:47:56 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9E41A04E;
        Thu,  2 Jun 2022 08:47:51 -0700 (PDT)
Received: from [192.168.43.127] (unknown [89.24.43.208])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 0C4AF2007F;
        Thu,  2 Jun 2022 17:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1654184868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFipLSaSNt6AVZj+ipJuiWLqxOfkAwoPaoKp6HET13A=;
        b=Px/3AEjj0ms3qrktWNl/+/H/NLVeovGt6F4eeiEjwwtQcKAJTH+lymb0lVYTNIiH99/Cko
        zTHPO5GcDkbMou8ZNea8hjm4k+lRoHY5jz/lNOPbF+HTMHTEenckKoJjG+81ah0hs1PHQO
        sS+EjBpCDaEoaWjA+oqggXoDirxalwk=
Message-ID: <9a7b3be5-f75d-d269-1113-f2865e9c4919@ixit.cz>
Date:   Thu, 2 Jun 2022 17:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/4] dt-bindings: power: supply: summit,smb347: use
 absolute path to schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
 <20220601071911.6435-4-krzysztof.kozlowski@linaro.org>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <20220601071911.6435-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: David Heidelberg <david@ixit.cz>

On 01/06/2022 09:19, Krzysztof Kozlowski wrote:
> Reference regulator schema by absolute path, as expected by DT schema
> coding style.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/power/supply/summit,smb347-charger.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
> index 20862cdfc116..ce0bca4689f6 100644
> --- a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
> @@ -82,7 +82,7 @@ properties:
>         - 1 # SMB3XX_SYSOK_INOK_ACTIVE_HIGH
>   
>     usb-vbus:
> -    $ref: "../../regulator/regulator.yaml#"
> +    $ref: /schemas/regulator/regulator.yaml#
>       type: object
>   
>       properties:

-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

