Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E9B57D23B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiGURLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGURLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:11:21 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DBF86C05;
        Thu, 21 Jul 2022 10:11:19 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id z132so1866466iof.0;
        Thu, 21 Jul 2022 10:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSQEs0HZT/Xo4GRuc/+cXwXUWYe3250eMC7wwm7xlLA=;
        b=fAcVC3WfjtBK9m6o70UQQybxracHTmVt5qQpnruhiihppBWTeCYM1m26bXM9vv+Q5s
         nAbKkGG2hQiY2SLAyNfrn7aELmyn8smzs0yBBPlELvlX6x63N6kHyP+zSoWJDOXQCgj4
         DHnkO27kev6FKqqH89GG8JhXxOr7NmtIzJXkiyx94KfseoZv63+93w7vYutcfFhTrk+e
         pYbSIy7GMDwwQPDXMcmQDTdkA7WtEpUWtqQnCTBJToCxi0zbkQJAM6ps4YeZEq64+ffT
         30KEquum88jZPby3XMqYp+h4fCwjbjx2z27sd0pRYaFJA1a8bO0pVj/ASq1/V+BngTGe
         WV4g==
X-Gm-Message-State: AJIora97UptJQWpuKoSacN3K4Y5fYFEH9ms9gz9GZfXNk0ihBOyRYw2J
        Q6AhuAxL6/wZbIosgqtAVg==
X-Google-Smtp-Source: AGRyM1ucM/EQx0eoqGUm5wI1e/jwVXy8rvyogOxt9R7tRyBHkIPkte+FCtzBASWtJVf3dZxlXaxt9w==
X-Received: by 2002:a05:6638:3589:b0:33f:88f2:2545 with SMTP id v9-20020a056638358900b0033f88f22545mr21953911jal.229.1658423479176;
        Thu, 21 Jul 2022 10:11:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t10-20020a02b18a000000b0032e2996cadesm1004329jah.66.2022.07.21.10.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:11:18 -0700 (PDT)
Received: (nullmailer pid 1578546 invoked by uid 1000);
        Thu, 21 Jul 2022 17:11:17 -0000
Date:   Thu, 21 Jul 2022 11:11:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [RESEND PATCH v2] dt-bindings: leds: skyworks,aat1290: convert
 to dtschema
Message-ID: <20220721171117.GA1578234-robh@kernel.org>
References: <20220721160611.250274-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721160611.250274-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 18:06:11 +0200, Krzysztof Kozlowski wrote:
> Convert the Skyworks Solutions, Inc. AAT1290 Current Regulator bindings
> to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> 
> ---
> 
> Hi,
> 
> This is waiting on the lists for a month:
> https://lore.kernel.org/all/20220620175033.130468-2-krzysztof.kozlowski@linaro.org/
> 
> so maybe it could be merged via LED or DT binding tree?
> 
> Best regards,
> Krzysztof
> ---
>  .../devicetree/bindings/leds/leds-aat1290.txt | 77 ---------------
>  .../bindings/leds/skyworks,aat1290.yaml       | 95 +++++++++++++++++++
>  2 files changed, 95 insertions(+), 77 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-aat1290.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml
> 

Applied, thanks!
