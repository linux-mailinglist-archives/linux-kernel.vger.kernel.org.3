Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5E94BADDD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiBRAFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:05:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiBRAFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:05:12 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4223E49697;
        Thu, 17 Feb 2022 16:04:57 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id s1so5687482iob.9;
        Thu, 17 Feb 2022 16:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B62giDPKCTM5nfuTzbayozzLbsilXdSpUvmPVSIuVUw=;
        b=vh5STkQRsvrtW2+jvvpwjUm83EAI+Corlt9EQ+iH5SFe5PA3kRz0rTwENmF8qSLnIA
         Ia1xAiWd9Q2X69Vs056qc1Mzbfn7FhO9DuOl5BKWdY8eYBWBoCLngomG0nyQqLqjJ8+a
         jajPT74NDoxe/8jGXGawmOkN2apLCAUy5MtyZcvSVGX0Z+9LZDMQzE7BlrwVcXTJc691
         cmM4MONjQvplPernHrF29eG31er49xWk6QwC086SARxT1ZJhVnfnmV9bXuq1QY5ehZQQ
         z2ArFo+oJtqqGcUd0CCSwYH3wClodxWH9uOUzLO68S+Aq8rxx1VogyBABztADb4zA+Kt
         uw9Q==
X-Gm-Message-State: AOAM532D3KGycqLRR/3At717cyA3G0TktlHiaDq7NWFVefSlI+GowWU+
        3XslXgRj058+OXbYM2yIKrfakefUog==
X-Google-Smtp-Source: ABdhPJxbgnaEAywJ1ZC6r4ojBjLcbfkIz/Iex5l51UBfhJTLGPeeCYkkp47fEbu/9WnEl+mjIY36yA==
X-Received: by 2002:a05:6e02:20e9:b0:2b9:64da:602c with SMTP id q9-20020a056e0220e900b002b964da602cmr3595363ilv.38.1645140765104;
        Thu, 17 Feb 2022 15:32:45 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l16sm2694851ilc.54.2022.02.17.15.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:32:44 -0800 (PST)
Received: (nullmailer pid 3977535 invoked by uid 1000);
        Thu, 17 Feb 2022 23:32:41 -0000
Date:   Thu, 17 Feb 2022 17:32:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     wim@linux-watchdog.org, krzysztof.kozlowski@canonical.com,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4] dt-bindings: watchdog: convert faraday,ftwdt010 to
 yaml
Message-ID: <Yg7bGU1A/GvtyN/z@robh.at.kernel.org>
References: <20220211115528.3382374-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211115528.3382374-1-clabbe@baylibre.com>
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

On Fri, 11 Feb 2022 11:55:28 +0000, Corentin Labbe wrote:
> Converts watchdog/faraday,ftwdt010.txt to yaml.
> This permits to detect missing properties like clocks and resets or
> compatible like moxa,moxart-watchdog.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - Added myself as maintainer as requested by Linus
> - Added $ref to watchdog.yaml
> - Removed useless quotes
> - Added blank lines between properties
> - Removed timeout-secs as already provided by watchdog.yaml
> 
> Change since v2:
> - rewrite compatible section
> 
> Changes since v3:
> - Fix indent errors reported by yamllint
> - Change additionalProperties to unevaluatedProperties
> - Added timeout-secs in example
> 
>  .../bindings/watchdog/faraday,ftwdt010.txt    | 22 ------
>  .../bindings/watchdog/faraday,ftwdt010.yaml   | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
