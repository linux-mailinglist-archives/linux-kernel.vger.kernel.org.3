Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09351217A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiD0SsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiD0Srt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:47:49 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EAB98F52;
        Wed, 27 Apr 2022 11:29:43 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id s131so2928591oie.1;
        Wed, 27 Apr 2022 11:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vjPJA+HsT3O8e7pT007nOpwyAA0Fc4ItG808mQNfBcI=;
        b=Ua4a/O69UXJkOAiGSGXufHJOmtV6AFe/P2N2TceLzdkAWFqO4DLoZucNNE+ICfNNZN
         lqE4Xv2brsxzVDtjoHybRazaH5oadsUyJURPZZO155aiMIvuxevoRNPPyx2Z2D4smieW
         DK5tu5bsSMwUIaqqvXjzSUDdINJS3Icj3HBSdWpFuCMRo3ck/6ZJrepxxGXWMdN4ippj
         uZqHI4QWpFtO966jTVze6iNnmIyDoo+5RifQR97DZ6AtT0gzeRkP6ah8tYlAGjsVAOoK
         DRfOr4YSywDQ9VovakanKeKkYIsZqYNfK5jZn5CBsjgEEASAyjimIAItC8MTme4sdpo0
         XepA==
X-Gm-Message-State: AOAM533DjfkoRqlllLcWoT3ZTgc9fVQ+5FHpVcHYJ2dCdMbNOVcoTYAT
        a0Aci3daYfq0A+BPFZz5CQ==
X-Google-Smtp-Source: ABdhPJxZ3SeCvrv8dS2qxIX+0bcfLBlYMQ95fdA79/7DvoLxrCcOHN1VHc6+L5T34OAY+/zprWp1dg==
X-Received: by 2002:a05:6808:11c9:b0:2f9:b01b:17f0 with SMTP id p9-20020a05680811c900b002f9b01b17f0mr13800053oiv.233.1651084182549;
        Wed, 27 Apr 2022 11:29:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e4-20020a0568301e4400b006054dca5442sm6229280otj.28.2022.04.27.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:29:41 -0700 (PDT)
Received: (nullmailer pid 414596 invoked by uid 1000);
        Wed, 27 Apr 2022 18:29:41 -0000
Date:   Wed, 27 Apr 2022 13:29:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Gene Chen <gene_chen@richtek.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: leds-mt6360: Drop redundant
 'unevaluateProperties'
Message-ID: <YmmLldJcJ2tOOCO7@robh.at.kernel.org>
References: <20220426133508.1849580-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426133508.1849580-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 08:35:08 -0500, Rob Herring wrote:
> The binding has both 'unevaluateProperties: false' and
> 'additionalProperties: false' which is redundant. 'additionalProperties'
> is the stricter of the two, so drop 'unevaluateProperties'.
> 
> Fixes: e05cab34e417 ("dt-bindings: leds: Add bindings for MT6360 LED")
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-mt6360.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Applied, thanks!
