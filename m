Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75508563803
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiGAQfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiGAQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:34:57 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236D243AE9;
        Fri,  1 Jul 2022 09:34:56 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id u20so2755732iob.8;
        Fri, 01 Jul 2022 09:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=55hRSP/w3rvpp9TsnL35ydQoX/LWK6GoP8N89NL7PFI=;
        b=o0l1Q3er4GsPkpm+C+VFCj6XFoeFqXijm9sBCOJDNQUEXMrc62WplklMsY10Q24CBE
         91D0/Wl4jVcYA8/M0EPPsI4VEywuswA0AOAscSXVDuSjmPrxcT963o54dapS6hUncbmN
         nnFqJNXZUmZoglFisQcgr99Rl2n1yPQQa/wuz25UbqrAPcyHPtowqhUNCwoYVJMpcTJS
         A5kZkzepnem/LB2/KSBMggQDi6SpOe8LLsCoEe7nGiI8qEsGfzrgSTvUmrK/Qo9lUB1e
         xEyViIlM1wKts4s7w89YIuXtjCAmv1KuFrT/cj9NDIb7WlNdhe15hSVJsN7bWcM9qq6v
         Uc0A==
X-Gm-Message-State: AJIora9lKRdOmg0Z4lMPq/tvC7WofnJa7NwDdPdJxrdPJrzYu58ik10W
        sa1Gm3y9oOOjOeE617dqBg==
X-Google-Smtp-Source: AGRyM1vFPXB68b9W3FN25GIqccQhrF7paJkdox5ewz2KYZ5v1T4YjYta/ZdF+5FhRpfCzPpZgWgI+w==
X-Received: by 2002:a05:6638:24c9:b0:33c:b7e8:4a14 with SMTP id y9-20020a05663824c900b0033cb7e84a14mr9170081jat.293.1656693295444;
        Fri, 01 Jul 2022 09:34:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e17-20020a6b5011000000b00675594df2d3sm5077855iob.17.2022.07.01.09.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:34:55 -0700 (PDT)
Received: (nullmailer pid 1092275 invoked by uid 1000);
        Fri, 01 Jul 2022 16:34:53 -0000
Date:   Fri, 1 Jul 2022 10:34:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: chosen: remove
Message-ID: <20220701163453.GA1092186-robh@kernel.org>
References: <YrserfmdD+QH+y/X@zx2c4.com>
 <20220628153354.870543-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628153354.870543-1-Jason@zx2c4.com>
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

On Tue, 28 Jun 2022 17:33:54 +0200, Jason A. Donenfeld wrote:
> Apparently this is no longer maintained and undesired. Remove it.
> 
> Link: https://lore.kernel.org/lkml/c8dddfe6-6385-ed34-e789-9f845c8a32bd@linaro.org/
> Link: https://lore.kernel.org/lkml/CAL_Jsq+uSdk9YNbUW35yjN3q8-3FDobrxHmBpy=4RKmCfnB0KQ@mail.gmail.com/
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 137 -------------------
>  1 file changed, 137 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/chosen.txt
> 

Applied, thanks!
