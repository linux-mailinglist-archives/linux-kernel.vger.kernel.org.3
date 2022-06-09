Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37CC545566
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiFIUOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbiFIUOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:14:01 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5BB3B3E7;
        Thu,  9 Jun 2022 13:14:00 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id h8so4953212iof.11;
        Thu, 09 Jun 2022 13:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2KkpT0I50VlXDq/btmrEijbLSj1GbLM7Pr4vqgB6tLk=;
        b=heCh1yMeFCXxJznaaNlKspjFftQuia5cZOX3pMUouQKAi9bOcS19c2ZSoFLrY184CT
         ILZ7NXNsW1eyOhtvqPStOTngQ6LLoDxYDXYhJQGKlqWty/kH+cXG3ehrWJZQDFXO6UrQ
         IrxIRJ5vYDcqW6c8W4qh3fEovXUW9nU4ZG3ZG5z6YKobfMEeWjZDe3S5wzdWnsYUJyji
         FwuCrL6ekxaheKYlshMj8qSYoR5Y7wTMaYjCBhzSkaB019VJ7HrcGx3TMVtNC7YpcSmP
         Ugu1SQp0nd70R6iMxZoSWc1ErFaTagIDCOYEMrC4eQIjF3NiGa0a6VjNXt2vgcYRdXdz
         rIiQ==
X-Gm-Message-State: AOAM532Svhj18YQpGmGsYzhuOA8BwLgCWJZxqzmcXZy8CZ+7Jk7veWqx
        CFn6Qo47DTFnqnz7MY6TqQ==
X-Google-Smtp-Source: ABdhPJw0mM7iPoqnXAKMFVr5qPmIgxWFs0vYnRVNHuGjjrIGztDdKeMUgYWmMoMhjf/C9dXLFz0MLg==
X-Received: by 2002:a05:6638:138f:b0:332:1c0:1e81 with SMTP id w15-20020a056638138f00b0033201c01e81mr2215246jad.293.1654805639873;
        Thu, 09 Jun 2022 13:13:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i6-20020a056e0212c600b002cde6e352c2sm10802148ilm.12.2022.06.09.13.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:13:59 -0700 (PDT)
Received: (nullmailer pid 27817 invoked by uid 1000);
        Thu, 09 Jun 2022 20:13:57 -0000
Date:   Thu, 9 Jun 2022 14:13:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dvorkin Dmitry <dvorkin@tibbo.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, Wells Lu <wellslutw@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pinctrl: sunplus,sp7021-pinctrl: reference
 generic schema
Message-ID: <20220609201357.GA27718-robh@kernel.org>
References: <20220607121335.131497-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607121335.131497-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 07 Jun 2022 14:13:35 +0200, Krzysztof Kozlowski wrote:
> Reference generic pin controller schema to enforce proper root node
> name.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml  | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
