Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D497F4FE7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358684AbiDLST2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358679AbiDLSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:19:20 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242055FF23;
        Tue, 12 Apr 2022 11:16:59 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id r8so19868771oib.5;
        Tue, 12 Apr 2022 11:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B/dD6BxwqxnSz+VcY4c2wabU7PRBtQ+7ZYvEK2V/n/0=;
        b=Z3rZkvYaOf7QF97iaQI0rtaICY6T1fwMtagJA11oN3E6S7Oh8XkfhQMyIP3d+mxAPO
         oemohB7TH1IpoOy+Y44O30wwkh0rlgF6+wlCjQSJlnQcioiyeBPE9XY7RP3tu0mxwcoS
         PCfIWy/wnDyn6j0bRbSmvnoMK14e92SVaDwJmvBwPXgzVvZ0snmRGStZvvr/1+PtWCy7
         OuG48w7uqwWm+uefk3ahyJdYyw5PxGbV7r6uiGbWjfdPi7dZwZfS3RRAaCDb1VA3WATM
         w1hJ0ASz/WEXBd4dIoNYDPvWnf+w3Ik+BOcZtEEGtUcnPQD7BF+VPot1lwBS6K8+LZLX
         wgDA==
X-Gm-Message-State: AOAM530t6HhfZfyU0IK3llZ0Fmxw37EgF1w9FlrTNJOzB0hLh2p9GW6+
        j6jy0m0sBo91mGA5WnwCYg==
X-Google-Smtp-Source: ABdhPJyWiCDJPCkWuVz9Fx0GQ1Bg4Kblx5fgblku4RjTzvAtN+tPP/TaP+yKykeEeMtxSKbgz9oFUw==
X-Received: by 2002:a05:6808:1592:b0:2f7:3095:b7fd with SMTP id t18-20020a056808159200b002f73095b7fdmr2485382oiw.190.1649787418243;
        Tue, 12 Apr 2022 11:16:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x18-20020a056830245200b005ce01c28c77sm13599954otr.1.2022.04.12.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:16:57 -0700 (PDT)
Received: (nullmailer pid 566579 invoked by uid 1000);
        Tue, 12 Apr 2022 18:16:57 -0000
Date:   Tue, 12 Apr 2022 13:16:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: ssd1307fb: Extend schema
 for SPI controllers
Message-ID: <YlXCGfA7DUbPPiXw@robh.at.kernel.org>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-3-javierm@redhat.com>
 <CAMuHMdVuivPSRooR5CqTX6GQtxO6RQYwKUqfOK36zsiN8-v6kg@mail.gmail.com>
 <d37de4b1-55f7-ff4d-6230-6f0b6e65799c@redhat.com>
 <CAMuHMdV_4Gp2fqfCTeUigVxK=J4NF=SqJVd1hKAWpyuUv0Pnzw@mail.gmail.com>
 <c3287f86-636d-33dc-c763-1f28803704f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3287f86-636d-33dc-c763-1f28803704f5@redhat.com>
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

On Tue, Apr 12, 2022 at 10:12:32AM +0200, Javier Martinez Canillas wrote:
> On 4/12/22 10:07, Geert Uytterhoeven wrote:
> > Hi Javier,
> 
> [snip]
> 
> >>
> >> Do you have any hints here on how I should enforce this in the schema ?
> >>
> >> Or if you think that a comment is enough, then I will add it in v3.
> > 
> > I don't know how to make it required for SPI, if possible at all.
> >
> 
> I see. Let's go with a comment then and we can later enforce it, if someone
> knows if is possible / how to do it.

It's not possible unless we annotate child nodes with something from the 
parent. '$nodename' is the one and only example of that. 

Really, this falls below the bar of what I'm concerned about checking. 
Ask me again when the conversions are all done (only ~2K to go :( ).

Rob
