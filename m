Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FF3531B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiEWTp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiEWTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:45:11 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E82B39B;
        Mon, 23 May 2022 12:45:05 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id e189so19040109oia.8;
        Mon, 23 May 2022 12:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8QuWz2Mjtt5rst0g3ggmFv6IrEyFmgOByNDWupAMrDs=;
        b=YTKSVU2Qk6kN4s+lmvIyQQ9d8uRnspySJIqjxneilS1lBUrGS1DGuu37sVHOptLIsU
         7qOQZ7liQL5jjoaNfX8iyz+sEhUKPIxfxPDDC4gSPXOUs+WvjBS103SZpHVs7d7PjjB/
         Zw03Lp480pZTiEOHUjEvhi1MKa9eM2/CxUftxgNSCJJBTUZHBaHuCs7Cs9juTtN5xvn4
         Iv4GSucbUu0KVJ2VR1CURNh9Q4MWRk3RJhmBmgLmhd02nfWu/77VX1w4DrfECEWpcVhW
         SFuSI60S3SdBn1JRfhJQi+e3/GDdxf+UvhUFfSmfLGBu9i0WUSW392ysZxUEC+MXvoF4
         K+pg==
X-Gm-Message-State: AOAM530vIqYhIeucwdwEYOyvTybyMP/vQWBe2y6qrrKfWfEZYDNrLzDv
        zRJFBDZ94tGRreHd3JC4d+pto9BcUA==
X-Google-Smtp-Source: ABdhPJx+ccOOhlILod3IObwcYhri/hjaVhQcrfGm7LvMK/NjAdC10/SDIKP+s7ceFHKroQ6OlbjEgg==
X-Received: by 2002:a05:6808:1981:b0:32b:9fc:6f9e with SMTP id bj1-20020a056808198100b0032b09fc6f9emr375889oib.111.1653335104820;
        Mon, 23 May 2022 12:45:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m12-20020a4a390c000000b0035eb4e5a6cbsm4564240ooa.33.2022.05.23.12.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:45:04 -0700 (PDT)
Received: (nullmailer pid 2023787 invoked by uid 1000);
        Mon, 23 May 2022 19:45:03 -0000
Date:   Mon, 23 May 2022 14:45:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: matrix-keymap: Add common
 'linux,no-autorepeat' property
Message-ID: <20220523194503.GA2004570-robh@kernel.org>
References: <20220523170449.1763039-1-robh@kernel.org>
 <YovWpSvabyhcYnzL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YovWpSvabyhcYnzL@google.com>
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

On Mon, May 23, 2022 at 11:47:01AM -0700, Dmitry Torokhov wrote:
> On Mon, May 23, 2022 at 12:04:49PM -0500, Rob Herring wrote:
> > 'linux,no-autorepeat' is a common property used in multiple bindings,
> > but doesn't have a common type definition nor description. Add a common
> > definition and drop the now redundant description from
> > holtek,ht16k33.yaml.
> 
> We have "autorepeat" in the common input binding description, should we
> not promote it over "no-autorepeat"?

We're kind of stuck with it I think. We can't just deprecate one and 
switch existing users as what would neither property present mean?

Hopefully, documented in input.yaml vs. matrix-keypad.yaml is enough to 
say which one is preferred for new users. 

Rob

