Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF954BB20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351010AbiFNUHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiFNUHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:07:17 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D774D694;
        Tue, 14 Jun 2022 13:07:16 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id a10so10565783ioe.9;
        Tue, 14 Jun 2022 13:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DayktJij2+5kjiAGYQ2iZp1ZSn1xYucSLsZcXjx5rXE=;
        b=t7QhGpG4fKkINRguUCzyGThR6dSHhQP1aKKJEJPbXWlOqV+cPWI56B66O2tQJr8cCp
         8g1wIsCdf1FqIFloHD+AZQAifoaBw1MnJZ6XNfIZHaKVFJPKr4d8zK1R38y0TwqPhXLk
         /0vIE4FyJ1B1iqNI/9rKjdmPS5nBePE0MIGKKlLef5R2BB7UCUOmkJCWPAGMvCJ31TAV
         v4FpeMKCj1d/sB7AM6Fp3TyY4lVLkBC3C0phlQbNnoQe9gVckbj6fRkKtP91+1UA+39q
         6otjl3CMXS7Rjx7bTshZzhgfXiZMN2lLuloxHJGsLqTLxrJYxrVnsCUBKNhKORogA1cn
         YFsg==
X-Gm-Message-State: AOAM533dypzvANwW8WIDYLuimQKbGTAH36xvxR+GrpTY46Sqq0YtaeR5
        F76tJJeX0Eh0kiZnKEgnIg==
X-Google-Smtp-Source: ABdhPJx/r6P3yUtTLVxe2uQT2YXDBHqId0p5ehJT+scfOkZS/eZdB6z/mAVJWOKpuAAjI1lF6Q4x5w==
X-Received: by 2002:a05:6638:430e:b0:332:586:5182 with SMTP id bt14-20020a056638430e00b0033205865182mr3830617jab.225.1655237235350;
        Tue, 14 Jun 2022 13:07:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v2-20020a056602014200b0066a0c0beee7sm1803048iot.44.2022.06.14.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:07:14 -0700 (PDT)
Received: (nullmailer pid 2343178 invoked by uid 1000);
        Tue, 14 Jun 2022 20:07:12 -0000
Date:   Tue, 14 Jun 2022 14:07:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v3 2/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779f0 support
Message-ID: <20220614200712.GA2342886-robh@kernel.org>
References: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
 <20220610201701.7946-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610201701.7946-2-wsa+renesas@sang-engineering.com>
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

On Fri, 10 Jun 2022 22:17:01 +0200, Wolfram Sang wrote:
> Add support for R-Car S4. The S4 IP differs a bit from its siblings in
> such way that it has 3 out of 4 TSC nodes for Linux and the interrupts
> are not routed to the INTC-AP but to the ECM.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Change since V2:
> * make interrupts not required for this SoC
> 
> Tested with:
> make dtbs_check DT_SCHEMA_FILES=thermal/rcar-gen3-thermal.yaml
> 
>  .../bindings/thermal/rcar-gen3-thermal.yaml   | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
