Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA45223D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348913AbiEJS1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348898AbiEJS0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:26:22 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D32EA0D;
        Tue, 10 May 2022 11:22:23 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-deb9295679so19290915fac.6;
        Tue, 10 May 2022 11:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5eaxIUkfRDs5zSochol4WtIm5357tYweJMGDFI2u4pU=;
        b=SJlJeaDlw/oBMPbofFuPwipw/4tK+Sp/NHRp8uayvLyQaRpYNqMGha1LedZlot9OkV
         cnCW3+MF1FYyWpdmvduWXoEL/5caoGHyCVxceqd1ZEXZpLTyiqCGREUORjgE226s7/Mg
         xyaS2dFfIjmvdn8ZjF/nV9CpKfysbONKdDVS5PJr5H7opdWykSXU0CAgDwIqCLDHLBBs
         xjDsv/rSlOfoPrx4Hkzmf3spZBrjaGxlqV1KGs/Qcc+Ny754Rl5WkgGKYi2M3I2XO1mA
         hfwKwrjo0RkdJlds7YeXALloiebengy3sZViL6GCjmknyWG93aGr7pX9WU7OdPmb8gNE
         7H/w==
X-Gm-Message-State: AOAM530jDgbR+miSYhWENSdppcUABP58nXCdzNvafSunhFeAR0tCNAmx
        S9UqLv7wEA5/mDykHSHMfg==
X-Google-Smtp-Source: ABdhPJzS4rbTDp32QJIoRssqYEpMJ/7t5ksogGydtS0hdk3+FTzqaG5lGb+rFO7ig2cCi/AXJcUl8Q==
X-Received: by 2002:a05:6870:e613:b0:ec:6564:c7c9 with SMTP id q19-20020a056870e61300b000ec6564c7c9mr787852oag.230.1652206942446;
        Tue, 10 May 2022 11:22:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k2-20020a056870570200b000edae17a8cesm5974143oap.3.2022.05.10.11.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:22:21 -0700 (PDT)
Received: (nullmailer pid 2332088 invoked by uid 1000);
        Tue, 10 May 2022 18:22:21 -0000
Date:   Tue, 10 May 2022 13:22:21 -0500
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
Message-ID: <YnqtXa+NhVUH0oyi@robh.at.kernel.org>
References: <20220509134658.16267-1-alexandre.torgue@foss.st.com>
 <1652123805.754133.27398.nullmailer@robh.at.kernel.org>
 <ddd5d5b2-32a5-6464-80a6-0054c376dd96@foss.st.com>
 <Ynp9Pu+ZqjaBu8ne@robh.at.kernel.org>
 <b64e6662-5fd2-5223-1e25-15217d75d06a@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64e6662-5fd2-5223-1e25-15217d75d06a@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 06:44:19PM +0200, Alexandre TORGUE wrote:
> Hi Rob
> 
> On 5/10/22 16:57, Rob Herring wrote:
> > On Tue, May 10, 2022 at 09:47:05AM +0200, Alexandre TORGUE wrote:
> > > Hi Rob
> > > 
> > > On 5/9/22 21:16, Rob Herring wrote:
> > > > On Mon, 09 May 2022 15:46:58 +0200, Alexandre Torgue wrote:
> > > > > For "st,stm32mp1-rcc-secure" schema, clocks and clock-names entries are now
> > > > > required properties.
> > > > > 
> > > > > Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > > > > 
> > > > 
> > > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > > 
> > > > yamllint warnings/errors:
> > > > 
> > > > dtschema/dtc warnings/errors:
> > > > Error: Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dts:27.33-34 syntax error
> > > > FATAL ERROR: Unable to parse input tree
> > > > make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dtb] Error 1
> > > > make[1]: *** Waiting for unfinished jobs....
> > > > make: *** [Makefile:1401: dt_binding_check] Error 2
> > > > 
> > > > doc reference errors (make refcheckdocs):
> > > > 
> > > > See https://patchwork.ozlabs.org/patch/
> > > > 
> > > > This check can fail if there are any dependencies. The base for a patch
> > > > series is generally the most recent rc1.
> > > > 
> > > > If you already ran 'make dt_binding_check' and didn't see the above
> > > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > > date:
> > > > 
> > > > pip3 install dtschema --upgrade
> > > > 
> > > > Please check and re-submit.
> > > > 
> > > 
> > > I just updated dtschema and yamllint seems to be well installed. I don't see
> > > the see above. I wrote this patch on top of my stm32-next tree. Do I have to
> > > send it directly to arm-soc in order to be merged on top of my latest
> > > pull-request ?
> > 
> > That appears to be header related AFAICT. Maybe you have header changes
> > in your tree. The issue this is fixing is in your tree, so it should be
> > applied there.
> 
> Ah yes! CK_SCMIxxx have changed in my tree (merged in arm-soc tree) and this
> patch is done on top of this change. So has to be applied in arm-soc.
> So I just have to send it directly to Arnd and arm-soc ?

If you don't have a fixes branch for them (or one that will be pulled 
soonish), then yes.

Rob
