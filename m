Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEFB5AB8EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIBTgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIBTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:36:52 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B3BE1AA9;
        Fri,  2 Sep 2022 12:36:51 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so7244945fac.4;
        Fri, 02 Sep 2022 12:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sXNxzf7M7fo2fs+7HnVoTwx/Ib6H9B2vXsq+d4vdh3Y=;
        b=fhXvZKxbba0UlG6OpJruuilP0xQSmSIT30VLRSue8Ubvx4Yx36oODUFY2DFip1HKSj
         xtoP3zVMWNOZCUlaHsdggOUZUSfKFT2tYQwtzsAQhmbDGaCCySOmSYmbQR+oxkxOtFW4
         gsrVFEyehpQ+Iti0X+Vc9/W2Rp3p3kqjeo42aquFOaOu/W27vsbvhYEl+addsAZHcq0S
         N0MEF+RAa2gbBWr/d/v9nKQB4HV5PppPsoAhTEDQmTn4A6QaP5NihgiW5Ay2gfyRTDsp
         tBInQylpv9JuFlvVwypxMQS4PgETbm3eXPXwccNsff1PEwZujMPJBSkwMK1Ld1nHa7Cv
         uoIg==
X-Gm-Message-State: ACgBeo3h/U5QPHCeQQeryu33sQV723VBqX3fRL5UHxtFnYp5LLDnupRE
        AcyMQSbJp62ho0JG230ExraJSJa1TA==
X-Google-Smtp-Source: AA6agR4I3AfQ8eyxNtpSiOalgILHga7aBwL1V50UKJN2u3JthWlOpuJuhUV617oa0D5wVTVOyF1Sbw==
X-Received: by 2002:aca:3010:0:b0:343:91b:7f7 with SMTP id w16-20020aca3010000000b00343091b07f7mr2500590oiw.51.1662147411242;
        Fri, 02 Sep 2022 12:36:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fo10-20020a0568709a0a00b0011eeff77d1bsm1607351oab.10.2022.09.02.12.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 12:36:50 -0700 (PDT)
Received: (nullmailer pid 286047 invoked by uid 1000);
        Fri, 02 Sep 2022 19:36:50 -0000
Date:   Fri, 2 Sep 2022 14:36:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     robh+dt@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, aou@eecs.berkeley.edu
Subject: Re: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for
 l3 cache
Message-ID: <20220902193650.GA285986-robh@kernel.org>
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220830125133.1698781-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830125133.1698781-1-ben.dooks@sifive.com>
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

On Tue, 30 Aug 2022 13:51:33 +0100, Ben Dooks wrote:
> With newer cores such as the p550, the SiFive composable cache can be
> a level 3 cache. Update the cache level to be one of 2 or 3.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  Documentation/devicetree/bindings/riscv/sifive-ccache.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
