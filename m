Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8328521DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbiEJPTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242423AbiEJPTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:19:18 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058F86B7F7;
        Tue, 10 May 2022 07:57:04 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id q10so3649167oia.9;
        Tue, 10 May 2022 07:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ap6ylfqMwi8yDjngmCG5tOOg9ip9yvHb2ovQ9serW2k=;
        b=OAHZpNCNMld0FzItCwZfLElCHHUZdZKqhVCokAKEWCc/cz53lkjT7jNRgQAm6pgPHg
         RCpSnuI03UhRSJLzChdJRPfZISeQsYFBVHpxLmEZp5elx3ybi1iMCPhiJnAJBXSrw0Zs
         ToNDcBJnVL6GXsYvC9h9pjdqBsfWum6yRPYvBrUdWNeET8wVpj7ts/dqdKDbMxU6qRUi
         roSqh4oqCK6vqKbgjMq/O+NORC9HC2xjzQa8wdGwgdixmYqKOZ0tQIkR9Dh7lSJRXc6/
         2EHgZrdOHHQbDPSrFdCNPCWfpWi4Pkm627nZnLeTpk8oq6gAIsn3LPvhQbtKzYMuKgc0
         i9Lg==
X-Gm-Message-State: AOAM530CAh6/Nd9hjZVUXXGYMV2iHIrxUHrz9LTzRwRVMxlxl6qnn3Sv
        xrdSWyRcujZQ8IBYQFsC7svhgAcvDg==
X-Google-Smtp-Source: ABdhPJyNR1Dzo0YBqlKSswmacA759cXut1FMrzx83tJFzR+WrBQuB/xMR6Bvv+0cKGWRDkahD6/RYw==
X-Received: by 2002:a05:6808:d54:b0:326:d355:69c0 with SMTP id w20-20020a0568080d5400b00326d35569c0mr227188oik.121.1652194623263;
        Tue, 10 May 2022 07:57:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k22-20020a4a8516000000b0035eb4e5a6b0sm2711967ooh.6.2022.05.10.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 07:57:02 -0700 (PDT)
Received: (nullmailer pid 1994439 invoked by uid 1000);
        Tue, 10 May 2022 14:57:02 -0000
Date:   Tue, 10 May 2022 09:57:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: stm32mp1: adapt example for
 "st,stm32mp1-rcc-secure"
Message-ID: <Ynp9Pu+ZqjaBu8ne@robh.at.kernel.org>
References: <20220509134658.16267-1-alexandre.torgue@foss.st.com>
 <1652123805.754133.27398.nullmailer@robh.at.kernel.org>
 <ddd5d5b2-32a5-6464-80a6-0054c376dd96@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd5d5b2-32a5-6464-80a6-0054c376dd96@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 09:47:05AM +0200, Alexandre TORGUE wrote:
> Hi Rob
> 
> On 5/9/22 21:16, Rob Herring wrote:
> > On Mon, 09 May 2022 15:46:58 +0200, Alexandre Torgue wrote:
> > > For "st,stm32mp1-rcc-secure" schema, clocks and clock-names entries are now
> > > required properties.
> > > 
> > > Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Error: Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dts:27.33-34 syntax error
> > FATAL ERROR: Unable to parse input tree
> > make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dtb] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1401: dt_binding_check] Error 2
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/patch/
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> > 
> 
> I just updated dtschema and yamllint seems to be well installed. I don't see
> the see above. I wrote this patch on top of my stm32-next tree. Do I have to
> send it directly to arm-soc in order to be merged on top of my latest
> pull-request ?

That appears to be header related AFAICT. Maybe you have header changes 
in your tree. The issue this is fixing is in your tree, so it should be 
applied there.

Rob
