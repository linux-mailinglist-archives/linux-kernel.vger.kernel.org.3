Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6A4EF92E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349415AbiDARzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244792AbiDARzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:55:06 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB22D28EA2A;
        Fri,  1 Apr 2022 10:53:16 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id b188so3508224oia.13;
        Fri, 01 Apr 2022 10:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KRYf5KVQn/9TVFC8m/mZH5t7YA/+oecomtuT98DZH6A=;
        b=0J3SVbhwiJTNOkooMQafytsNaOVz5+EhEEhIDPWpYNTfYwjWdyVVWh4Uri+QsT8Qqh
         gOkc1NGOmhkMGLLGh0+vrRMbfHZsrnsdEbwCA+xQUYeOk9Xh8jT0SAZM053SpLlh9D+6
         8M43BJ39rArHAOxW84/9x0tlwdgHcUnuCPxQ/sK4rYn+9uoovnpqV7N2IgfTjXiLlv7+
         Ren0e19Da7HDmqBz0rAYbRHs0jZuI4cvKperETcCIkOX+PG0cRp1OSiR5JvQyKyzwJbx
         J7zxPEVQ4cG5LwkHuxyjao1GtD7xFxa6ef8qNqHV4ebSxHyRhXitBXIYMgIiVo3mS4gR
         witQ==
X-Gm-Message-State: AOAM53014BrZAB1gTDLZ39+MiWmxbpnPDsnVMAvZbSFcS8/xmhQh1eWP
        MCyrLfvXaU84VhsU9ifZ3A==
X-Google-Smtp-Source: ABdhPJyGVwEDdajob3aoE6VamFB2Kgaa+Md455uNk8dX14/1a+be0FqMFMEh08i/Lpfe0iJ9lfbXhA==
X-Received: by 2002:a05:6808:2019:b0:2ec:bcde:efe with SMTP id q25-20020a056808201900b002ecbcde0efemr5523229oiw.266.1648835596219;
        Fri, 01 Apr 2022 10:53:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 60-20020a9d0642000000b005b22a82458csm1412709otn.55.2022.04.01.10.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 10:53:15 -0700 (PDT)
Received: (nullmailer pid 3315459 invoked by uid 1000);
        Fri, 01 Apr 2022 17:53:14 -0000
Date:   Fri, 1 Apr 2022 12:53:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v12 6/9] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Message-ID: <Ykc8Cv/TbYlr9GxV@robh.at.kernel.org>
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <ff5bfd5611ab0defe0c98f98edbbf655e33cd16d.1648714851.git.qinjian@cqplus1.com>
 <YkYSyHVGsXkGs0uf@robh.at.kernel.org>
 <3373b11528214394baae71198df3adff@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3373b11528214394baae71198df3adff@cqplus1.com>
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

On Fri, Apr 01, 2022 at 02:29:58AM +0000, qinjian[覃健] wrote:
> > 
> > On Thu, 31 Mar 2022 16:29:53 +0800, Qin Jian wrote:
> > > Add documentation to describe Sunplus SP7021 interrupt controller bindings.
> > >
> > > Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> > > ---
> > > Move 'reg' after 'compatible'
> > > ---
> > >  .../sunplus,sp7021-intc.yaml                  | 62 +++++++++++++++++++
> > >  MAINTAINERS                                   |  1 +
> > >  2 files changed, 63 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
> > >
> > 
> > 
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> > 
> > If a tag was not added on purpose, please state why and what changed.
> 
> Changes: Move 'reg' after 'compatible'
> I did a modification based on comments from krzysztof.kozlowski@canonical.com [1]
> 
> [1] https://lore.kernel.org/all/6dbeda18-a11c-609d-7a8f-bf2e6f27aea7@kernel.org/

A trivial change like that can keep a tag especially if it came after 
the comment (not sure here).

Rob
