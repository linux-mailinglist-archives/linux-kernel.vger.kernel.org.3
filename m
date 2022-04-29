Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B22514F13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378278AbiD2PWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378272AbiD2PWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:22:00 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D33D4C98;
        Fri, 29 Apr 2022 08:18:39 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id e189so8814455oia.8;
        Fri, 29 Apr 2022 08:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h5I147M5SAG5aKSeTFIpJ9Fdg0GC9tCoery/v4BvAoc=;
        b=3solqmbv4YB5OQq5XpMZs3Gtf6LO8tSB3cjdWlvkY6bU9bQeyTOfEQrW4SBHoKMdKx
         A2P0n/jMOj4aepVP+DS3cqdzggpQqrnIHump7m2usrKCPrRztO/MQjfj+zxcQ3I2/Z3G
         MLfFT0YZNmOBrmLaUXrQjPqmDm0UwYQ6qZ9dassZi8jt93oONnLNqZwo1Vs0IBN3KHzT
         RpNYQVjTNeoZUp9QGFYtow2EHT5IhN3OQBEwo/nJCSjaaoie8nUup+iGp+YeBDcy3K9v
         kcgVAv9RKm467h8gg4BlA86tT+XLoohBuyNn3HkolctVU8N672lAqC+Mv82lpv85WYK5
         +1zQ==
X-Gm-Message-State: AOAM530onG9E8ElKWia90dc3qG2FmbhAEJztm6Jz7U+k5woF6JnkFaMf
        ZmhARP3uYhgNKV0B6ygg1pBK+W/LKw==
X-Google-Smtp-Source: ABdhPJw1fKhbwx6lx70lrdW0UswFjeYAMQ8BdI+q1NecOx0z8DU6TRguS9yHIi1JzMEh2mVexnvGug==
X-Received: by 2002:a05:6808:1886:b0:322:f55c:133d with SMTP id bi6-20020a056808188600b00322f55c133dmr1691725oib.217.1651245518636;
        Fri, 29 Apr 2022 08:18:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m18-20020a4add12000000b0035eb4e5a6d3sm852822oou.41.2022.04.29.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:18:38 -0700 (PDT)
Received: (nullmailer pid 2284027 invoked by uid 1000);
        Fri, 29 Apr 2022 15:18:36 -0000
Date:   Fri, 29 Apr 2022 10:18:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] arm64: dts: tegra: Fix boolean properties with
 values
Message-ID: <YmwBzLrTilOPdX5m@robh.at.kernel.org>
References: <Yk3nShkFzNJaI3/Z@robh.at.kernel.org>
 <YlVAy95eF/9b1nmu@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlVAy95eF/9b1nmu@orome>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 11:05:15AM +0200, Thierry Reding wrote:
> On Wed, Apr 06, 2022 at 02:17:30PM -0500, Rob Herring wrote:
> > Boolean properties in DT are present or not present and don't take a value.
> > A property such as 'foo = <0>;' evaluated to true. IOW, the value doesn't
> > matter.
> > 
> > It may have been intended that 0 values are false, but there is no change
> > in behavior with this patch.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Can someone apply this for 5.18.
> > 
> >  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi            | 8 ++++----
> >  .../boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts    | 8 ++++----
> >  arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi            | 6 +++---
> >  arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi            | 6 +++---
> >  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi            | 6 +++---
> >  arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi            | 8 ++++----
> >  arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts        | 8 ++++----
> >  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts             | 4 ++--
> >  8 files changed, 27 insertions(+), 27 deletions(-)
> 
> This causes multiple regressions on Tegra boards. The reason for this is
> that these properties are not in fact boolean, despite what the DT
> bindings say. If you look at the code that handles these, you'll notice
> that they are single-cell properties, typically with <0> and <1> values.
> What may have led to the conclusion that these are boolean is that there
> is also a special case where these can be left out, but the meaning of
> that is not the "false" (<0>) value. Instead, leaving these out means
> that the values should be left at whatever is currently in the register.

The majority of users do use boolean in their DT.

Treating these as tri-state doesn't make much sense because what does 
setting the pin to !push-pull mean? Isn't that just open-drain or 
open-source for which also have boolean values? Allowing these to have 
values is unnecessary and enables more invalid combinations.

> See pinconf_generic_parse_dt_config() and parse_dt_cfg() specifically in
> drivers/pinctrl/pinconf-generic.c.

of_property_read_u32() will return -EOVERFLOW on a boolean value and 
then the default value (0) is used. However, at least for QCom the value 
is ignored.

Looking at max77620, the value is used. However, it is clear that 
push-pull and open-drain operate on the same register bit.

> Arnd, can you please revert this so that these boards can be unbroken?

That's fine for now...

> It's a bit unfortunate because there seem to be other platforms that
> also employ these in the boolean form that Rob mentioned, but I think it
> is those that probably need fixing instead. Not sure what the intentions
> were for those.

I still think it's Tegra that needs fixing. The question is to what 
extent forwards and backwards compatibity is needed on these platforms? 
I'm not sure if we can fix new dtb with old kernel. A new dtb with a 
stable kernel update would be plausible. It may work just replacing 
'drive-push-pull = <0>' cases with 'drive-open-drain'.

Rob
