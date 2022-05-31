Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E865393AA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbiEaPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiEaPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:10:34 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837A554AB;
        Tue, 31 May 2022 08:10:32 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id r65so12693860oia.9;
        Tue, 31 May 2022 08:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RBXm9/Esfsyjt1r/aC8kkjNZpxuz6CMibBZbCrct5sU=;
        b=fg8/p6zXxw6/SKsaovjlb0ENruHxX7IGCJ0/xRjlU+lDf4afG4PYZF9O2WgeRKRUnB
         5Kch9S/8UGK4SEBmR4kEYCDKh3j0StvY/xmf+LTPx/voyeDkIkgw3NskKB9i0hc+5B9p
         HkVsuSjEHJY9nZNQt24bZG05MADitnYdsPDhqsWQ7hhQBsDOBzgJNO0edBLUe2sB93Ha
         I4SvaeTAvCEF/DzV0/0IML5dR8bOVlETpt90LDaJOFCtupAQzl2+ZlhcwZzEqorntyk3
         LvJCgAgkh74NV4Olg2JyCjgf+cR4jcHD2UYCBvk3b5do/F1HEfW6Lce2UZhR2CiX41pe
         GZTw==
X-Gm-Message-State: AOAM531MHpnIkoiLg3mORBK/tsAOMSFCougQd5Gj8tOYJyVUMQAgA2Sz
        5jYkolM6akkrGhrCduwkVQ==
X-Google-Smtp-Source: ABdhPJzoAp+Z3IQUZKoxH1jPa/vqFRWyugKv6Lj1GOazPZZ8U2duOMOyCfWEUTN10HNxmAg8d9kt7A==
X-Received: by 2002:a05:6808:2005:b0:32b:23a1:e6fd with SMTP id q5-20020a056808200500b0032b23a1e6fdmr12605499oiw.59.1654009831912;
        Tue, 31 May 2022 08:10:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r13-20020a056830080d00b0060603221245sm6410657ots.21.2022.05.31.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 08:10:31 -0700 (PDT)
Received: (nullmailer pid 1770063 invoked by uid 1000);
        Tue, 31 May 2022 15:10:30 -0000
Date:   Tue, 31 May 2022 10:10:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Pratyush Yadav <p.yadav@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: Move 'rx-sample-delay-ns' to
 spi-peripheral-props.yaml
Message-ID: <20220531151030.GC1742958-robh@kernel.org>
References: <20220525210053.2488756-1-robh@kernel.org>
 <20220526054642.zw44mgw2bd2u5v76@ti.com>
 <20220526135404.GA3831942-robh@kernel.org>
 <20220527113226.x62neigmrnljxtph@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527113226.x62neigmrnljxtph@mobilestation>
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

On Fri, May 27, 2022 at 02:32:26PM +0300, Serge Semin wrote:
> On Thu, May 26, 2022 at 08:54:04AM -0500, Rob Herring wrote:
> > On Thu, May 26, 2022 at 11:16:42AM +0530, Pratyush Yadav wrote:
> > > Hi Rob,
> > > 
> > > On 25/05/22 04:00PM, Rob Herring wrote:
> > > > SPI bus per device properties must be defined in spi-peripheral-props.yaml
> > > > for unevaluatedProperties checks to work correctly on device nodes.
> > > > 
> > > > This has the side effect of promoting 'rx-sample-delay-ns' to be a
> > > > common property, but functionally it's no different if it was defined in
> > > > a Synopsys specific schema file.
> > > 
> > > Functionally it is no different, but does this property make sense for 
> > > other controllers? If not then I don't see why we should pollute the 
> > > common list with controller-specific ones. For one, this now no longer 
> > > makes it obvious that this property should only be used with the 
> > > Synopsys controller. And if you keep making small exceptions for other 
> > > controllers too, soon the common list will be full of controller 
> > > properties and it will be a mess finding out what belongs to who.
> > 
> 
> > There's at least one other case already:
> > 
> >   cdns,read-delay:
> >     $ref: /schemas/types.yaml#/definitions/uint32
> >     description:
> >       Delay for read capture logic, in clock cycles.
> 
> What about creating the schemas hierarchy for the device-specific
> properties as I already suggested in the other thread? Like this:
> 
> https://lore.kernel.org/linux-ide/20220527101057.b5z7ase6y4naoxvk@mobilestation

Because that doesn't work. I'll explain in that thread.

Rob
