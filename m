Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85A54FEE5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382833AbiFQUlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383649AbiFQUlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:41:05 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF06D3AF;
        Fri, 17 Jun 2022 13:38:35 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id y17so3698155ilj.11;
        Fri, 17 Jun 2022 13:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WxC8y4xgzpsGIQGT5vC3MH6pL5FDuKzI7XWPboiHFXc=;
        b=LYbQQF+KB2wM8B7yVpZDvjRaPEqgEk8Mpr9eqd8kxG6HVP7/SmWgPa62y9TP71Fszv
         DUE1jSfB2caq8/VYYnBYnZwYM+tlWVIu7MfjvDmH4O8FYJL9bLzFw+GXEH6cKiVjWBZq
         aqhdMKkSNzdI7M1z/bqnjY3OV8qeHsU5re21mkkHhjQQtq+23X38p7INDjyBj6SRj2jl
         fNQQ+vwYytPTU1XnfBREKGzVBelr+5bUYMOe9qhY0B67TVTOW0x2ckSz7oaqzwj4UWKz
         8etfqBVKXnJdzD5tusR83UUAww25ROyFthpfDcepNWT8KQ+2zSuztZAJJ68rxTkL6aXk
         M0lg==
X-Gm-Message-State: AJIora8KnlMlWZZ1kNi7ZeqWyFAPXkO2NTq64O9MROtDKDBXv8zDwlhL
        3m/3ABe4GpxHKaFfzw3kYw==
X-Google-Smtp-Source: AGRyM1tRfGyyxlHmt6DVN6C8QJwoAzdTs2WSfZKnyY/mpeCUg4tFUo332pxr0ovhLfFD051ISEv6SA==
X-Received: by 2002:a05:6e02:1188:b0:2d8:c8cb:3fd0 with SMTP id y8-20020a056e02118800b002d8c8cb3fd0mr6715419ili.150.1655498289906;
        Fri, 17 Jun 2022 13:38:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l124-20020a6bbb82000000b006694bc50b82sm2991817iof.35.2022.06.17.13.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:38:09 -0700 (PDT)
Received: (nullmailer pid 2402049 invoked by uid 1000);
        Fri, 17 Jun 2022 20:38:08 -0000
Date:   Fri, 17 Jun 2022 14:38:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rcc: stm32: select the "secure" path for
 stm32mp13
Message-ID: <20220617203808.GA2400871-robh@kernel.org>
References: <20220613093815.18334-1-alexandre.torgue@foss.st.com>
 <20220616175531.GA3716982-robh@kernel.org>
 <abf9247c-085b-05ff-a589-d9b190e88666@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf9247c-085b-05ff-a589-d9b190e88666@foss.st.com>
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

On Fri, Jun 17, 2022 at 09:21:40AM +0200, Alexandre TORGUE wrote:
> Hi Rob
> 
> On 6/16/22 19:55, Rob Herring wrote:
> > On Mon, Jun 13, 2022 at 11:38:15AM +0200, Alexandre Torgue wrote:
> > > Like for stm32mp15, when stm32 RCC node is used to interact with a secure
> > 
> > 'st,stm32mp1' is stm32mp15?
> 
> Yes "st,stm32mp1-rcc" is for the STM32MP15.
> 
> > 
> > > context (using clock SCMI protocol), a different path has to be used for
> > > yaml verification.
> > > 
> > > Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > > 
> > > ---
> > > 
> > > Hi Rob, Krzysztof,
> > > 
> > > If you agree with this patch, I'll apply it directly in my STM32 tree.
> > > 
> > > Thanks
> > > Alex
> > > 
> > > diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> > > index f8c474227807..242fe922b035 100644
> > > --- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> > > @@ -78,6 +78,7 @@ if:
> > >         contains:
> > >           enum:
> > >             - st,stm32mp1-rcc-secure
> > > +          - st,stm32mp13-rcc
> > 
> > You don't need '-secure' because it's always secure?
> 
> Yes. Compare to STM32MP15, the STM32MP13 is by default "secure". In our case
> it is "mapped" to OPTEE, using SCMI protocols.

Okay,

Acked-by: Rob Herring <robh@kernel.org>
