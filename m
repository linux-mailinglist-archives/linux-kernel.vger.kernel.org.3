Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F9555CA02
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbiF0WSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiF0WSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:18:16 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724CADAE;
        Mon, 27 Jun 2022 15:18:15 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id z191so11094896iof.6;
        Mon, 27 Jun 2022 15:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YibwpeFlLUAXldT3IcMtZUEv7yVm8RZ87dZAwMJufVw=;
        b=TDiCVHNBbVvdpOvubT15ZyiXc0b1JK3R1chgZ8hRRLf1V3a8zMVyBPNSMnG7s0AZOK
         tA3zP1NW7nDTI3mFMNHEyIgxlazgA5xbmDlwE+RLCsc/KMFR8lGQnEZCK6Gf2mJWJrzB
         c7pzKBP/+CRxT1mfyVIrUZCx8C5hcHXeQ2Z/Yx2AicuVfjje+d9Fxq5r1om7swgAsljL
         5rGzdiBGJzXgzjnsURexCffGKEeRj3rNi+A2Uq28F2YUGO6UX7bsnbkIHCSOqE1M6pp+
         Jo9yc7//Rmx0V4x3zrP+lexfUhl2R7RMjZjXPOJN2bAqeyeOrGk12/Us43uOxfAgoLS2
         Cizg==
X-Gm-Message-State: AJIora8XyDEE3fJvqyoGcF2hPdUnYTPTlRrg+orU6UuB5cZldLRQ35PB
        pZoIG/pSR6XpaFg3pR6Ji4PJs4M1Iw==
X-Google-Smtp-Source: AGRyM1v1uMcYY0sXxp0P098New6WbDFXGNit8XNV3ZEYVn08nGYcoSP532Tx60bnDX9w8a+/DBwomQ==
X-Received: by 2002:a05:6602:13c3:b0:672:6e5b:f91d with SMTP id o3-20020a05660213c300b006726e5bf91dmr7538403iov.68.1656368294681;
        Mon, 27 Jun 2022 15:18:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z18-20020a92bf12000000b002d11c598e12sm5052398ilh.61.2022.06.27.15.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:18:14 -0700 (PDT)
Received: (nullmailer pid 3065966 invoked by uid 1000);
        Mon, 27 Jun 2022 22:18:12 -0000
Date:   Mon, 27 Jun 2022 16:18:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>, linux-gpio@vger.kernel.org,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, soc@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v3 04/40] dt-bindings: pinctrl: nuvoton,wpcm450-pinctrl:
 align key node name
Message-ID: <20220627221812.GA3065912-robh@kernel.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616005333.18491-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 17:52:57 -0700, Krzysztof Kozlowski wrote:
> gpio-keys schema requires keys to have more generic name.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Name it "button-uid"
> ---
>  .../devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
