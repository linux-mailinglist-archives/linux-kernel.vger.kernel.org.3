Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE3159BFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiHVMrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiHVMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:47:30 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BC33AB03;
        Mon, 22 Aug 2022 05:47:29 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id z22-20020a056830129600b0063711f456ceso7602909otp.7;
        Mon, 22 Aug 2022 05:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=7cbjI0WaZhQTvZlNz7q5LmNIlRjDT3q4dyHallkLrTo=;
        b=CVhIP2M47w0eAhmUTcrlpYx2JKuSBdky0u8RWxwjXTgF7jPPfvZqtWxadk6wlfo3LQ
         uiSl1hKd7tvRyMPsiNXc79cwLyYFtr5UADc3xacySrFPokO0qZLY4hi+Y0wTEODHl6Kw
         CMLnSEiZjGRNmyVYkqurblMx7e7XJhUrAcP4lEbAraLfr65jcXlboaRT4PpnxauqWsMy
         DxggInkjgCtEFeoKR6fxIdSitAnEUXpqCURE0o6eaVSinYAgZNLCm2NEqAN1llQmUAuM
         A5T0jhSzNkT5+jmYMic8ndRqDRyXHDzME8qpcQ8EOdveo/lAdYxcMB/Qz5OPORNZCNJn
         yUGQ==
X-Gm-Message-State: ACgBeo0CBloaoQ8xySKTrdKo26ct4QylppTBG1kI/H9LD7XR8bBc5T68
        ica1ixaSSDlCfybb8oOLOp6Jr5fEMg==
X-Google-Smtp-Source: AA6agR6HuU3nFQ4lGlufxXNkmmzngtFFlaInk7mDi0EkehJepEpbode3NOBV0cAGi7IkodNWlHOamA==
X-Received: by 2002:a05:6830:310d:b0:637:1b6c:6647 with SMTP id b13-20020a056830310d00b006371b6c6647mr7668149ots.170.1661172448975;
        Mon, 22 Aug 2022 05:47:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k4-20020a056870570400b0010f07647598sm2978471oap.7.2022.08.22.05.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 05:47:28 -0700 (PDT)
Received: (nullmailer pid 3653297 invoked by uid 1000);
        Mon, 22 Aug 2022 12:47:28 -0000
Date:   Mon, 22 Aug 2022 07:47:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Message-ID: <20220822124728.GA3641041-robh@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220820102925.29476-1-pali@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 12:29:23PM +0200, Pali Rohár wrote:
> This new optional priority property allows to specify custom priority level
> of reset device. Default level was always 192.

Why do we need/want this? What problem does it solve?

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../devicetree/bindings/power/reset/syscon-reboot.yaml        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> index da2509724812..d905133aab27 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> @@ -42,6 +42,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: The reset value written to the reboot register (32 bit access).
>  
> +  priority:

A bit too generic for the name.

> +    $ref: /schemas/types.yaml#/definitions/sint32
> +    description: Priority level of this syscon reset device. Default 192.

default: 192


Though I'm not really sure about the whole concept of this in DT. Where 
does 192 come from? Presumably if we have more than 1 reset device, then 
'priority' is needed in multiple places. So you need a common schema 
defining the property (as property types should be defined exactly 
once) which this schema can reference.

Rob
