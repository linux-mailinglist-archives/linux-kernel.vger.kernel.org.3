Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8743F5121D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiD0S7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiD0S7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:59:24 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67561611DF;
        Wed, 27 Apr 2022 11:44:53 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id q8so2517951oif.13;
        Wed, 27 Apr 2022 11:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/sIxYWvFlMoHReoMPfX2NBRTuxsiKhz/pal5GhylPqg=;
        b=PN/WCN/lJCiNMu10xuaOmS9MxjYy07TYnJnbrxcJxLZ1TetHbPoXZQtIfiGNYcxKtD
         lh3/cwwSi0xfgQxrTnIyDXEaRD/wMRqiN6NcusaHLhw+A9kvsWOfH2Y5uUgPciYzEgWU
         RtA5WbOPgWpURhbmCrMoZ85lPvmLo+w63G6yJP4A1uUpXWUijK/sYZ8pwb+tN5vTmyb0
         mClV+PlUfZimMiAfTqOvbIet7GAB+LuJguREm3pu7i6KWwrq5cBdbehwRL9jFj+ut3SZ
         951R6nbqKUJihdotbl6MQzzXG+aSTSZnsAQgde5y1V5kuGZcZRvFnFIOsoSHYjm2UaKw
         2Axg==
X-Gm-Message-State: AOAM532FkCy6BldeuvC7cvcCzGG6kmifJNV4yPSX/SvNxTYXZOT3c1Rl
        R6SKLatMnpp0kukK0paBXg==
X-Google-Smtp-Source: ABdhPJz6nKdb0AwwSKP/n1AYikKnnui7VO1eKjkTuDHiUj8S52Lm4O++NP3zOk3jiqIIDRQN/19pQA==
X-Received: by 2002:aca:1a09:0:b0:325:90ab:a812 with SMTP id a9-20020aca1a09000000b0032590aba812mr1384519oia.131.1651085093218;
        Wed, 27 Apr 2022 11:44:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m4-20020a056870030400b000e686d13890sm963611oaf.42.2022.04.27.11.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:44:52 -0700 (PDT)
Received: (nullmailer pid 436853 invoked by uid 1000);
        Wed, 27 Apr 2022 18:44:52 -0000
Date:   Wed, 27 Apr 2022 13:44:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: aspeed: Drop referenced nodes in
 examples
Message-ID: <YmmPJLcI7PnsBtXn@robh.at.kernel.org>
References: <20220422192139.2592632-1-robh@kernel.org>
 <CACPK8XcQNJNyzqdjMQuCP+z-L-A9mcMqs-HJJrh9MscasV+D=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcQNJNyzqdjMQuCP+z-L-A9mcMqs-HJJrh9MscasV+D=A@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:40:31AM +0000, Joel Stanley wrote:
> On Fri, 22 Apr 2022 at 19:21, Rob Herring <robh@kernel.org> wrote:
> >
> > The additional nodes in the example referenced from the pinctrl node
> > 'aspeed,external-nodes' properties are either incorrect (aspeed,ast2500-lpc)
> > or not documented with a schema (aspeed,ast2500-gfx). There's no need to
> > show these nodes as part of the pinctrl example, so just remove them.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Nak.

I welcome patches that add schemas for the undocumented compatibles 
instead. Otherwise, I will be turning on this check by default and 
nagging people to fix them.

> This removes the information on how to use the bindings. Surely we
> prefer to over document rather than under document?

How is what the 'gfx' and 'lpc' nodes contain relevant to how the 
pinctrl binding works? If a user wants to know, then they should go look 
at the aspeed,ast2500-lpc/aspeed,ast2500-gfx bindings and their 
examples. Which brings up my secondary issue which is having the same 
example multiple times. It is multiple chances for errors (that I end 
up fixing).

How do we know the example is even correct without any schema checks? 
The 'framebuffer' node is not in a valid location is the most obvious 
thing I see.

Rob
