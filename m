Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7824BC86C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 13:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbiBSMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 07:49:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiBSMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 07:49:40 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DA8483AB;
        Sat, 19 Feb 2022 04:49:20 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f11so229047ljq.11;
        Sat, 19 Feb 2022 04:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wtjZ8Ae2cLsRZz7SUHUZ5yy4CcOsPrQ4KfjvroHRHfE=;
        b=g7Xnklyx4Bu1DTso0pb2Bv6zQrurbW9O0sXWI2pmgrM8eaFGTyBLL5SliVyhj8U2Wk
         ODmUEzZMGSNr7vqTWXHfzOgnqrwkmShY8J2ZeDS+fojyEBWILoLac2H3aPTP4tFZs3W+
         XYa8W1ZGcuUeZHhxjw+8NQ7sxY+LpJpQrWV4ZtWYTzg7eomIsi48bCsasZEO5euEs+yD
         JlMG/FRGCXd+RP0fjP5BP7v6EvdzMO3Nuu7gT7QDJeX4x9iLDCM2wp1t7qswnCEXZCC7
         C0YoiT6f/LiLf4QrX2NsT4OxvijsnWdy8ezrr8XsLXc4xo9ECovyiWDz3ehHJLfIwDa8
         zWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wtjZ8Ae2cLsRZz7SUHUZ5yy4CcOsPrQ4KfjvroHRHfE=;
        b=S9Ii55OYHcYWIX/LY8Wm786tiEZSPoPLi+OMJDq6zRSZhjR5mPHEQtT09LTRVXCTdb
         eHl5ejOHqhZXMH3dxF+OBkxVhFoM+KI9nZWOIF8Qa4XWDDwikTCDa5i9Jq6FrLF8ZVuQ
         Kpo+y0dV/3I4I5znP7NqYnDu/srKjawJLg+sV2C3MG1eXSYZcYgljXTYd8wh5V3bGOOJ
         zBGurV4tOzXwKU1ecJCcoTGCM4qiFulfsmfo6NbECkeM7fHg5vDkg43T+fGk6XyCWE/U
         4TmX9EU7WaHAiwWrgh3Pi93c7j5/toxxAFZCkVpmrA74y+L+GT4YaJ295pxWyvlMXp3D
         LBOw==
X-Gm-Message-State: AOAM533tNGcY3EZVBCokSYeOESsHMt+gpFgYdIMEvTEDeFNzK/izTdgm
        EyRPCrkYZL+PmMnwhbH3FpY5dbfa+TE=
X-Google-Smtp-Source: ABdhPJx3F50rZ2UoMvyAf2Z7Yddg7sa7UyrtTbX2UhyUX/S87/IyNgMMg/SdCzbizOH/VDJYTpOBgw==
X-Received: by 2002:a2e:808b:0:b0:243:f7ef:fbb6 with SMTP id i11-20020a2e808b000000b00243f7effbb6mr8530698ljg.30.1645274958701;
        Sat, 19 Feb 2022 04:49:18 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id w3sm569682lft.161.2022.02.19.04.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 04:49:18 -0800 (PST)
Message-ID: <aa3e4a15-0e9b-5aea-7c6c-26b80d12ad7d@gmail.com>
Date:   Sat, 19 Feb 2022 15:49:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] dt-bindings: memory: lpddr2: Adjust revision ID
 property to match lpddr3
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220219012457.2889385-1-jwerner@chromium.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220219012457.2889385-1-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.02.2022 04:24, Julius Werner пишет:
> Commit 3539a2 (dt-bindings: memory: lpddr2: Add revision-id properties)
> added the properties `revision-id1` and `revision-id2` to the
> "jedec,lpddr2" binding. The "jedec,lpddr3" binding already had a single
> array property `revision-id` for the same purpose. For consistency
> between related memory types, this patch deprecates the LPDDR2
> properties and instead adds a property in the same style as for LPDDR3
> to that binding.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---

Every revised version of the patch must contain changelog.

>  .../memory-controllers/ddr/jedec,lpddr2.yaml       | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
> index 25ed0266f6dd3d..37229738f47271 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
> @@ -30,12 +30,23 @@ properties:
>      maximum: 255
>      description: |
>        Revision 1 value of SDRAM chip. Obtained from device datasheet.
> +      Property is deprecated, use revision-id instead.
> +    deprecated: true
>  
>    revision-id2:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      maximum: 255
>      description: |
>        Revision 2 value of SDRAM chip. Obtained from device datasheet.
> +      Property is deprecated, use revision-id instead.
> +    deprecated: true
> +
> +  revision-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
>  
>    density:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -164,8 +175,7 @@ examples:
>          compatible = "elpida,ECB240ABACN", "jedec,lpddr2-s4";
>          density = <2048>;
>          io-width = <32>;
> -        revision-id1 = <1>;
> -        revision-id2 = <0>;
> +        revision-id = <123 234>;
>  
>          tRPab-min-tck = <3>;
>          tRCD-min-tck = <3>;

It's not enough to change only the binding. You should also update the
device-trees and drivers/memory.
