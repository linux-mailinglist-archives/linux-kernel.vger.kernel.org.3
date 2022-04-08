Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9744F8B3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiDHAf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiDHAf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:35:26 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605A8132EA4;
        Thu,  7 Apr 2022 17:33:25 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-d39f741ba0so8149567fac.13;
        Thu, 07 Apr 2022 17:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FuhSRqLc9YX+vS3DQySTObIYyjmCN9so1xiUO3aEse4=;
        b=lLX67thIZW7C1urVy1JCswj70Qdqa+i0+RPxKdzpKHvvj9NvSXQss8EUGM7iOX0Xuo
         f4nY3EKDXFQWoFyfOYJpnyUx4CUrMcsyq/AxMkf5DrALk8igNiUGKFqb8RcN3EztKNZ2
         LBqgyPsKYmj56ZMh1FEzwh5CNByI1LcXZmyfLAGNxTXhukcYccttS2czgLTpbYH6QFUe
         bzQ5cm4wvl/JPdRlvYpIqRR+aVHXlgJ9vLk5cIG0wbj1cuAr9SRNHDE3H2WXW8l5FUrj
         wuiogQLN4wrkisX/USAroRhYwvgMGLBCpSf33Wlpyj8Wuhk7lYzcB17D8qRJB+cUD/7k
         nlWA==
X-Gm-Message-State: AOAM53310Jl3065GV/K2frfjjgOZBqSadJO+MVmBo05UdhXbYengM4HY
        wGnMQ1Kkw0uPCokAhCS8bUkUgUO9UA==
X-Google-Smtp-Source: ABdhPJx4rH+2+AE5Tzihn8EsxMfe4JS9cw90ljWp/QDayo/YYWWb8m9bWWoObNAVtikPZzjnJqk80g==
X-Received: by 2002:a05:6870:d58c:b0:de:6900:6222 with SMTP id u12-20020a056870d58c00b000de69006222mr7437702oao.179.1649378004683;
        Thu, 07 Apr 2022 17:33:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870e50300b000d9be6436f1sm8179775oag.29.2022.04.07.17.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 17:33:24 -0700 (PDT)
Received: (nullmailer pid 2315471 invoked by uid 1000);
        Fri, 08 Apr 2022 00:33:23 -0000
Date:   Thu, 7 Apr 2022 19:33:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RESEND PATCH] dt-bindings: power: renesas,rcar-sysc: drop
 useless consumer example
Message-ID: <Yk+C098vWGzE0tnl@robh.at.kernel.org>
References: <20220407193542.17230-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407193542.17230-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 07 Apr 2022 21:35:42 +0200, Krzysztof Kozlowski wrote:
> Consumer examples in the bindings of resource providers are trivial,
> useless and duplication of code.  Remove the example code for consumer.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/power/renesas,rcar-sysc.yaml         | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 

Applied, thanks!
