Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA84D0917
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbiCGU6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbiCGU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:57:45 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A5F2C12C;
        Mon,  7 Mar 2022 12:56:50 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id z8so13291574oix.3;
        Mon, 07 Mar 2022 12:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N3tlFPBMHtWcn0iYUzj3qnhmmykFEumeuwZz6QLguzw=;
        b=ERF5/HkofH5dCafGcarj8X6AHVhWkZLsyWg2aTHsHyN0jW6Vy/+xJ7d6noPPa+JHbw
         7lq0bLLczc4pjiO4+xIRK7X9VCW5w4gaMTiEr0K69ol+IJW+EOqemQUUQHAE+t43Nhn0
         Msx3Yfv4RwTpbacOK5xo9LmXNcv7tX63dkwp8uIxMYCCNe/RRY4iqcfo3kE3JvZZ0lFL
         Le41/P6JkD4aD3Huh+AtSbrnqJTtlvHsB28ebKrPcV+LyUQ14KGzp127a4ys7qyj4y4i
         oMldDo56FaSG5fngNneoA8kUBbbP+3ByCXv6gkCKVDdhJQYu/gmurObK05S/YnUuAP8V
         dM1A==
X-Gm-Message-State: AOAM531XyIYteqGIp5E3BmkLRcppMrSEvMjCjTQu9d68tNweRMyEDIm3
        pBAN5kWW0MaNBqqvelHSnQ==
X-Google-Smtp-Source: ABdhPJzDLCgdPyR34NOXygDObosWM9xRC5QKLx/VwasrcQ1zel824ZI6Ao1CL/ffw63L2Rx5CojpFQ==
X-Received: by 2002:a05:6808:159d:b0:2d9:a9a8:f896 with SMTP id t29-20020a056808159d00b002d9a9a8f896mr562260oiw.171.1646686609939;
        Mon, 07 Mar 2022 12:56:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u7-20020a05687036c700b000da4bcdae42sm1892045oak.13.2022.03.07.12.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:56:49 -0800 (PST)
Received: (nullmailer pid 3208776 invoked by uid 1000);
        Mon, 07 Mar 2022 20:56:48 -0000
Date:   Mon, 7 Mar 2022 14:56:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: dt-bindings: update Krzysztof Kozlowski's
 email
Message-ID: <YiZxkKrngFonoXH5@robh.at.kernel.org>
References: <20220307172901.156929-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307172901.156929-1-krzysztof.kozlowski@canonical.com>
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

On Mon, 07 Mar 2022 18:29:01 +0100, Krzysztof Kozlowski wrote:
> Use Krzysztof Kozlowski's @kernel.org account in dt-bindings maintainer
> entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Hi Rob,
> 
> Could you take this one directly (optionally squash with the patch
> adding me as maintainer)?
> 
> My email address also appears in the bindings. For now mailmap will
> handle it (see my other commit). I will change it after merge window,
> because some of the bindings are in separate for-next branches.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
