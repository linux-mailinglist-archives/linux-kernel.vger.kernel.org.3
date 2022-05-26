Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B24053503D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbiEZNyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbiEZNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:54:07 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A2150E00;
        Thu, 26 May 2022 06:54:07 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id t14-20020a9d66ce000000b0060af9ed4b87so997771otm.9;
        Thu, 26 May 2022 06:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tWtkq+ZgB9S1oTbgzHdEwf/ab9DFJtwyJBbeHOUfdrU=;
        b=5+ocknvTOtzVIYPBjlC6i8+Pkej96bVA/TOTRGdeRmwM5M8JCxEkxqyzgzyUMNlWgy
         UoWNOfYkQnMNWIsFPbRU5Vvsnc4nTWrUX9TxKQvmYya7D0Fe92QbVwufkGxpxTJC4ujT
         UMumRj+p7XE3f9nVyBM5mWBiXv2wvFIxoJD3q1Ln0n/2NOwD/VkcuoOAyJHKaTvapKvn
         K+Q6fL0fPMLhJjH7tdzIVt6QUAObWS0E/+iHt6I/jujNFRZpZXmpqbOOIgUn9lQ29zEW
         LhHRSHO1rjFDRs22TBf6Ssm1MBHGUlTK5fXfUXsvulwJA82RG4pQhxX2ZpmPpE4Mm/iO
         5BGg==
X-Gm-Message-State: AOAM531N7F4KIAvAJUNMjehWWzMbCqJ3+oxBi+sNrx9KADD6EShYpBNn
        0LHIsJ2VA0UHWU4eAKjOBg==
X-Google-Smtp-Source: ABdhPJyyGTmbEtWbp66qoLi7HJ1+T/K9+fgEDHCLCEfMAAot8n/7o5EARMzXzZdYyNHVM8nb9sy6Jw==
X-Received: by 2002:a05:6830:44a4:b0:60b:39e7:ab22 with SMTP id r36-20020a05683044a400b0060b39e7ab22mr2274296otv.148.1653573246266;
        Thu, 26 May 2022 06:54:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g7-20020a9d6a07000000b0060603221279sm591495otn.73.2022.05.26.06.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 06:54:05 -0700 (PDT)
Received: (nullmailer pid 3906910 invoked by uid 1000);
        Thu, 26 May 2022 13:54:04 -0000
Date:   Thu, 26 May 2022 08:54:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: Move 'rx-sample-delay-ns' to
 spi-peripheral-props.yaml
Message-ID: <20220526135404.GA3831942-robh@kernel.org>
References: <20220525210053.2488756-1-robh@kernel.org>
 <20220526054642.zw44mgw2bd2u5v76@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526054642.zw44mgw2bd2u5v76@ti.com>
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

On Thu, May 26, 2022 at 11:16:42AM +0530, Pratyush Yadav wrote:
> Hi Rob,
> 
> On 25/05/22 04:00PM, Rob Herring wrote:
> > SPI bus per device properties must be defined in spi-peripheral-props.yaml
> > for unevaluatedProperties checks to work correctly on device nodes.
> > 
> > This has the side effect of promoting 'rx-sample-delay-ns' to be a
> > common property, but functionally it's no different if it was defined in
> > a Synopsys specific schema file.
> 
> Functionally it is no different, but does this property make sense for 
> other controllers? If not then I don't see why we should pollute the 
> common list with controller-specific ones. For one, this now no longer 
> makes it obvious that this property should only be used with the 
> Synopsys controller. And if you keep making small exceptions for other 
> controllers too, soon the common list will be full of controller 
> properties and it will be a mess finding out what belongs to who.

There's at least one other case already:

  cdns,read-delay:
    $ref: /schemas/types.yaml#/definitions/uint32
    description:
      Delay for read capture logic, in clock cycles.


Too many common properties is not a problem we have. Too many custom 
properties doing the same thing is the problem.

Rob
