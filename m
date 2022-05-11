Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6085A523AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbiEKQyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiEKQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:54:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9474F18E0C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:54:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id be20so3227655edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TbQrFHlNKxIAIU7eL6DveeAGrYsQtI19SwICttsjk8A=;
        b=dw0oeH0FEbBa2K+A8EhHxW8DmzXNFptw6Wcp+Wwo1lofYfIgg5/TWNsUGRMgcO4v2d
         QufcEpADUEy5iuMqT1A16ydzJ5OTVie82Ff7BwtZ0/6QJwNQEKaIv7zpjnHxz2sjKlpX
         3qE5gW90+wXLcBW6gaRinVFclPqC7d0BGI0+NypwhLeVrATzV2PkKYD6LSr+fvxAREJX
         Wc10SYJMbF1DxJ6QHyngaftTSiriKcRPY/P4e49Mytg73B8hR0PkCHPFxJ9w2R4pJTz+
         TnsW24yPRkYVjlUIXySl2HM9rPwRtMrHUTy7/cmHSvdGHjZKVUymx77f1GFp+av6gDcE
         JYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TbQrFHlNKxIAIU7eL6DveeAGrYsQtI19SwICttsjk8A=;
        b=Ucf6KCtXyLjoJLdmOkbBvydaUrtlwHzNYQFS/aE3nSpYi5l2OKX/wVIrowuzA0n44Z
         MyoS4q8t/9WX1ucZuQdCYNdEeHYtScMEZJfvI7wnAMSUxSFkiWslKnK3WhcGhAaOuob+
         8XZHQBFkP4uoP4s9AH+UnnkrGargrgfb3To4lbDF/jGbfl/YYfS9BVdxugd34bUEV757
         p5Q0CTwM9hJWVgWakScvUGyeemHj7BOPfT3Zx7gMj9eyfUmfYmGT0D3NNGMDsKCceT7C
         3sy5wgEvaPpy7K9lcyWVLttJx5d1BCz5kistBSIx5LXxeFay3H2mO8V4ktoGurrOIity
         JAVw==
X-Gm-Message-State: AOAM530PR/0Q17NyBTVFipG7FY249UAk97+wY7fdQTOGWU1wOIe0hknr
        83dtosFGcbkHSaNVP2pwdNCKNQ==
X-Google-Smtp-Source: ABdhPJyEZrk5BLKuyTqX+mGLdnxJHBpmmWeK9JxdjXBXXsXTCCKwU9x7c0QlfbJuhAEdgfsLP182yw==
X-Received: by 2002:a05:6402:f25:b0:427:bf59:ad72 with SMTP id i37-20020a0564020f2500b00427bf59ad72mr29954285eda.231.1652288062246;
        Wed, 11 May 2022 09:54:22 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w16-20020a170906d21000b006f3ef214e33sm1141162ejz.153.2022.05.11.09.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:54:21 -0700 (PDT)
Message-ID: <467f25e1-a658-745b-2927-ba88c4e2da46@linaro.org>
Date:   Wed, 11 May 2022 18:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 10/11] dt-bindings: marvell: armada-37xx: add Methode
 eDPU compatible
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pali@kernel.org, marek.behun@nic.cz
References: <20220510124929.91000-1-robert.marko@sartura.hr>
 <20220510124929.91000-10-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510124929.91000-10-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 14:49, Robert Marko wrote:
> Document compatible for the Methode eDPU Armada 3720 based board.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> index 3f41ef2c6f3e..db0307241e39 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> @@ -25,6 +25,7 @@ properties:
>                - globalscale,espressobin
>                - cznic,turris-mox
>                - methode,udpu
> +              - methode,edpu

Alphabetical order, by entire compatible.


Best regards,
Krzysztof
