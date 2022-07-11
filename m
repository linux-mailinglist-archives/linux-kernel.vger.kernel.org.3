Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A1570A55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiGKTG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGKTG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:06:57 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D481D37FBA;
        Mon, 11 Jul 2022 12:06:56 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id n68so5831803iod.3;
        Mon, 11 Jul 2022 12:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kSf41vMgFvCmlzJmWGYyXM6OwfPGih2l3PKdkftneNk=;
        b=k/0LjLwqTVgnmXaC9q6FErj0ez3uXXb6TP1nfOUpHbC1W7r/KzolNMm9lqXwEqwFcP
         69293f8GtUiOdVbh26feYAWHNFW5eLGzsUxE7Zz8JChTUXkZwfvS/GTno/yI2Me9JXL9
         xzXKwWff6YES51uXxGX2/FCFyZ2V6jxmGPDSUj6NU+oWrxDinG9QhQc8IeT1EkU1O9av
         2r7bJ1BIIJ3dQc9wQp/7UOA7vQ1VaTFrlQon1ZAZ9KjmaiG08sR+8kc558UgVoPW9M2s
         B7pW+jJ6ZpOL4bb1UHuPM86G/g5V8oqS9vIOcyvWDQ51wYkiGFr5BIsFtboeuXGF2ZXa
         mLHQ==
X-Gm-Message-State: AJIora85wmSO6F5VZLXI24N853u1kl7EvTU1KJQJR3ZzpcBcXC6LNelw
        Jweec0hPY1RROkYVs/zy4Q==
X-Google-Smtp-Source: AGRyM1sbJWo+xNkDLZFUGospNLVIv5q0BrKxEblZDv7XeUe19bxqXsziHG6X8+boIY9VSbM1va/LeQ==
X-Received: by 2002:a05:6638:4683:b0:33e:e4e3:d76 with SMTP id bq3-20020a056638468300b0033ee4e30d76mr11599077jab.110.1657566416107;
        Mon, 11 Jul 2022 12:06:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t11-20020a5edd0b000000b0067b7805d27fsm3871214iop.33.2022.07.11.12.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:06:55 -0700 (PDT)
Received: (nullmailer pid 104028 invoked by uid 1000);
        Mon, 11 Jul 2022 19:06:54 -0000
Date:   Mon, 11 Jul 2022 13:06:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: nvidia,tegra20-pmc: Move fixed string
 property names under 'properties'
Message-ID: <20220711190654.GA103893-robh@kernel.org>
References: <20220706212034.568861-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706212034.568861-1-robh@kernel.org>
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

On Wed, 06 Jul 2022 15:20:34 -0600, Rob Herring wrote:
> Fixed string property names should be under 'properties' rather than
> 'patternProperties'. Additionally, without beginning and end of line
> anchors, any prefix or suffix is allowed on the specified property names.
> 
> As all the nvidia,tegra20-pmc powergates child node properties are fixed
> strings, change 'patternProperties' to 'properties'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
