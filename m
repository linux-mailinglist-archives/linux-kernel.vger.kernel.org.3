Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67684ACAB6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiBGUsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbiBGUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:42:59 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D884C0401DA;
        Mon,  7 Feb 2022 12:42:58 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id u3so2486827oiv.12;
        Mon, 07 Feb 2022 12:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rlE1V9OTk6BkuyItKfJDtXE3hovJxZT5HEVCUsaARlc=;
        b=FbXej2qIduulG9djnqrz0rVXQndYbVTxSPxMKKg3HSh4RYdCeHy05ocM7wg4WQo7w+
         Bf4JnfY9MfM1pXnm65SU4HXk/FN6LTpPflCAGQxBvzESdZRFIjiafUbILMm3tEUqCTAj
         xtcOFxu9h9zxvNwXqkS1s47p18IXPkbWP+0Dy7VjM3bmP5tzjVbvS1b3IiptLEToEzsW
         HMQn7qG7TAai+aXG7W4ZF9m/IdqNdIrqCKf6Lh6k5rRDmjPSQ0t8SS4KJMZ9T/WXvjsC
         RrPIQKkkoxlrCX6sNKb5Y/CjVDsmztpFrK2zaPmaJLRClevoosADJgkxuPRwV3PA/c7g
         V5Hw==
X-Gm-Message-State: AOAM530h6smyg8IxjK3ovONBuKcrUSNUacYzLX/fAOjqDd0wQINsmfTG
        4xvNHETJaN/tly/wJuKuaw==
X-Google-Smtp-Source: ABdhPJzdEby2HALFZLU6QZB+I9qAgJ2rlgPsbx8QFyIGftJZxHXR/0k5XwciVAIo5f+eoTkU8xhLMA==
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr354523oic.299.1644266577999;
        Mon, 07 Feb 2022 12:42:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g4sm4317453otl.1.2022.02.07.12.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:42:56 -0800 (PST)
Received: (nullmailer pid 883752 invoked by uid 1000);
        Mon, 07 Feb 2022 20:42:55 -0000
Date:   Mon, 7 Feb 2022 14:42:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        andi@etezian.org, linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adithya K V <adithya.kv@samsung.com>
Subject: Re: [PATCH v3 1/3] spi: dt-bindings: samsung: Add fsd spi compatible
Message-ID: <YgGET9UVDCxDA621@robh.at.kernel.org>
References: <20220125031604.76009-1-alim.akhtar@samsung.com>
 <CGME20220125032821epcas5p128c99ca3654fce0ec046943c90211849@epcas5p1.samsung.com>
 <20220125031604.76009-2-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125031604.76009-2-alim.akhtar@samsung.com>
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

On Tue, 25 Jan 2022 08:46:02 +0530, Alim Akhtar wrote:
> Adds spi controller dt-binding compatible information for
> Tesla Full Self-Driving (FSD) SoC.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Adithya K V <adithya.kv@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Andi Shyti <andi@etezian.org>
> ---
>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
