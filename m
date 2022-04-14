Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94B9501806
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbiDNP75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348944AbiDNPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:40:12 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BFBC5583;
        Thu, 14 Apr 2022 08:19:00 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 12so5699020oix.12;
        Thu, 14 Apr 2022 08:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rTnbii0TkfiP0IgylH+LPQeyfK4chNSMZIeQMu2dlZ0=;
        b=44Lvk3aKbxtOBzPkD6hHm1CjWoWpgA2QoNMfqHRlgXnizhX3EsCyxHVnWDrEIuFXZm
         OKSKF4h0xAwKNpzt8GbSoFbgZsmTbNDz1GtOV5S0ZkB8M6fFedYV8Yz1LTp4NzMNlmml
         xLJz1eR0hN8/+MRc9t087Y/+QNhiOgMIcu5YLWG8cbXEiAuZyW8Ppp1zRBKBwRvjQ1MK
         0Jsf1Uj/PGGIz/+qgviNF3h9+NwbCYm7YkPEWVCnDNuA9oGJ/maWtdjJWYj7LG2wQlNb
         WDaNDTnh3Jr4cjrm68uhWtIzKOxNPXp0zM+QPN45OyFobk68bnRaT3N6NATyVEBQPWmi
         cG1A==
X-Gm-Message-State: AOAM5337BI4i00pmA/TgLak4RiYeZCtyuB0uTv8alrQdJGGz8JsgKKAy
        sPCyM5TH9XBS6myCBshuMg==
X-Google-Smtp-Source: ABdhPJx97/FQcjk9Be6OMKujrhUC85sEPYMS6H5cAeRSjdGYelkOgG068e0xOR/WfxQnx5K/o4EfsQ==
X-Received: by 2002:aca:2418:0:b0:2ee:f7da:795f with SMTP id n24-20020aca2418000000b002eef7da795fmr1833724oic.276.1649949539942;
        Thu, 14 Apr 2022 08:18:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c19-20020a9d7853000000b005cdbc0f02ccsm106314otm.68.2022.04.14.08.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:18:59 -0700 (PDT)
Received: (nullmailer pid 2073887 invoked by uid 1000);
        Thu, 14 Apr 2022 15:18:58 -0000
Date:   Thu, 14 Apr 2022 10:18:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v13 4/9] dt-bindings: clock: Add bindings for SP7021
 clock driver
Message-ID: <Ylg7Yl9GmgpOFipk@robh.at.kernel.org>
References: <cover.1649659095.git.qinjian@cqplus1.com>
 <f8d5675d1bc32962af6379f78a171ed35b181ebc.1649659095.git.qinjian@cqplus1.com>
 <c2a7f2e0-1a21-bb0c-9221-c184cfaa3626@linaro.org>
 <b1b85440f7d647a0adf014b091e31c10@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1b85440f7d647a0adf014b091e31c10@cqplus1.com>
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

On Thu, Apr 14, 2022 at 07:06:12AM +0000, qinjian[覃健] wrote:
> 
> > > +#ifndef _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
> > > +#define _DT_BINDINGS_CLOCK_SUNPLUS_SP7021_H
> > > +
> > > +#define XTAL            27000000
> > 
> > This looks like frequency which usually does not belong to bindings. Why
> > do you need it here?
> > 
> 
> OK, I'll remove it.

If that's the input frequency to the clock controller and it could 
possibly change, then it should be defined in DT with a 'fixed-clock' 
node and 'clocks' property in the clock controller.

Rob

