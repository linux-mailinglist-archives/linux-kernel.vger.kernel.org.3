Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B656354E5C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377294AbiFPPOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbiFPPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:14:30 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA831529;
        Thu, 16 Jun 2022 08:14:29 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id r3so1124507ilt.8;
        Thu, 16 Jun 2022 08:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SHTgK05tyQDk/p4I1IuzEx4HHbym5o2z7SW1D/t5csQ=;
        b=z3gZ1RHATaH1duxXzfT+dXxzsQgKBh7VkI5ek7PmriQaoPaJsLbWiiorPIvKBu3alp
         XEzCSr/PevYl72fG74jW3GnsLh4UNsFngwQVC8qH3PN6dIYViO7ESOoSi/nXl/6wVfJq
         EMh5sR006hQ/wa8Bzfxv+uSdnSwFRL9/CyBYpuk6BjPeDJGjE/LOYPu7EiaJtcPT9E6W
         cpWw/ovcjFQn6N9gMHlwRnqE3DN5MJn7bGU5vJqN9kqnZOafKXK6Awvv3yLs2uhyGPZn
         PHstG5KxQaeXvxAaKZIJ+z+v2YlEM/0wFn2YFqh+my/OYFJP905PV7ylrJetQCMmfNI/
         961A==
X-Gm-Message-State: AJIora++IW53umMdu8hs/z1yiCNhMOhunE72O635HdDJX9XWr9o/Dtf7
        HJ78Ivhdtczi+61uonxstg==
X-Google-Smtp-Source: AGRyM1seksdmYC/rsKfzOtS0UIDbEz+8IFwb6rVjipUAuQlJZLhmJey7HBdaGWD11yJHAU3pJY8grA==
X-Received: by 2002:a05:6e02:1788:b0:2d1:ed04:88df with SMTP id y8-20020a056e02178800b002d1ed0488dfmr3212770ilu.226.1655392468841;
        Thu, 16 Jun 2022 08:14:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id o14-20020a056e0214ce00b002cc20b48163sm1112539ilk.3.2022.06.16.08.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:14:28 -0700 (PDT)
Received: (nullmailer pid 3487684 invoked by uid 1000);
        Thu, 16 Jun 2022 15:14:26 -0000
Date:   Thu, 16 Jun 2022 09:14:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joe Perches <joe@perches.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        patches@opensource.cirrus.com, Stephen Boyd <sboyd@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Move lochnagar.h to
 dt-bindings/clock
Message-ID: <20220616151426.GA3487574-robh@kernel.org>
References: <20220613081632.2159-1-lukas.bulwahn@gmail.com>
 <20220613081632.2159-2-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613081632.2159-2-lukas.bulwahn@gmail.com>
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

On Mon, 13 Jun 2022 10:16:31 +0200, Lukas Bulwahn wrote:
> Most of the clock-related dt-binding header files are located in
> include/dt-bindings/clock. It would be good to keep all the similar
> header files at a single location.
> 
> This was discovered while investigating the state of ownership of the files
> in include/dt-bindings/ according to the MAINTAINERS file.
> 
> This change here is similar to commit 8e28918a85a0 ("dt-bindings: clock:
> Move ti-dra7-atl.h to dt-bindings/clock") and commit 35d35aae8177
> ("dt-bindings: clock: Move at91.h to dt-bindigs/clock").
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml | 2 +-
>  MAINTAINERS                                                 | 2 +-
>  drivers/clk/clk-lochnagar.c                                 | 2 +-
>  include/dt-bindings/{clk => clock}/lochnagar.h              | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename include/dt-bindings/{clk => clock}/lochnagar.h (100%)
> 

Acked-by: Rob Herring <robh@kernel.org>
