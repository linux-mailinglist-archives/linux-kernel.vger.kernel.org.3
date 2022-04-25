Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068F150E93B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244884AbiDYTOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244893AbiDYTOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:14:21 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6016E2F3BA;
        Mon, 25 Apr 2022 12:11:15 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id s21-20020a0568301e1500b006054da8e72dso11470331otr.1;
        Mon, 25 Apr 2022 12:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KfvsdaNrqzE1BZExO2gpU9gM5Zw3mrEmzjGsDm/IN7Y=;
        b=zz5caVfHghNswkFwZTDIF9TLg4iqUZDC266wt2z+Pnkn4OLLPEK8fChgsfPgRNAyaz
         g+GtzOwR+e4vB0Va0sSHi6zeozHckSNs1SnzWHCLSELVXh4Bd5nPsKiDWzinavrlxo9c
         RM3zjKxldq1C0WjZYtx2kFF4O5w8RU4ceAmdoRCoKZhaTQjB+Onqsy+/Aa1JkqnwkQ7e
         RfqywunEM8laY5yx5jm3GMj8DwoeaLb1KkTcSM5GCcV/csjw6qrWSC6FvLIqWkW0gXoE
         V9I8JjrLbNxUuSnjfzboPhvq+YJYz3aE+MWnDUFuERYPOS08uPjaAVAxNgwaVHceDttl
         0amA==
X-Gm-Message-State: AOAM531mphJOpbOAxlUaSuewTSG1PUV+2G4/SVoFop1ABau+4ifqTCCe
        pPXoYRgAf/7vAYiOpYln7oJ+gotNCg==
X-Google-Smtp-Source: ABdhPJw9uxpUO9LKnG040QuMwHyOzS4tHc0WimyBmaTy2/e4n1V3ST1BXyUY9YaMQrHV8DrvaiVaAQ==
X-Received: by 2002:a05:6830:18f:b0:605:433b:c568 with SMTP id q15-20020a056830018f00b00605433bc568mr6954877ota.46.1650913874611;
        Mon, 25 Apr 2022 12:11:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e26-20020a056820061a00b0035e46250f56sm4020495oow.13.2022.04.25.12.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 12:11:14 -0700 (PDT)
Received: (nullmailer pid 83469 invoked by uid 1000);
        Mon, 25 Apr 2022 19:11:13 -0000
Date:   Mon, 25 Apr 2022 14:11:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>, arnd@arndb.de,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, soc@kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>, etienne.carriere@st.com
Subject: Re: [PATCH 2/8] dt-bindings: clock: stm32mp1: describes clocks if
 "st,stm32mp1-rcc-secure"
Message-ID: <YmbyUc5uTXoTD/nt@robh.at.kernel.org>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-3-alexandre.torgue@foss.st.com>
 <dd48a7b5-ce08-5fb2-8236-8802ac91d827@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd48a7b5-ce08-5fb2-8236-8802ac91d827@denx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 06:31:25PM +0200, Marek Vasut wrote:
> On 4/22/22 17:09, Alexandre Torgue wrote:
> > In case of "st,stm32mp1-rcc-secure" (stm32mp1 clock driver with RCC
> > security support hardened), "clocks" and "clock-names" describe oscillators
> > and are required.
> > 
> > Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> > index 7a251264582d..bb0e0b92e907 100644
> > --- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> > @@ -58,14 +58,8 @@ properties:
> >             - st,stm32mp1-rcc-secure
> >             - st,stm32mp1-rcc
> >         - const: syscon
> > -
> > -  clocks:
> > -    description:
> > -      Specifies the external RX clock for ethernet MAC.
> > -    maxItems: 1
> > -
> > -  clock-names:
> > -    const: ETH_RX_CLK/ETH_REF_CLK
> > +  clocks: true
> > +  clock-names: true
> 
> It looks like this should rather be a property than a compatible string --
> the compatible string is used by the OS to determine which hardware is
> represented by a node, but here it is the same hardware in either case,
> "st,stm32mp1-rcc" and "st,stm32mp1-rcc-secure", it is still the same
> STM32MP1 RCC block, just configured differently by some bootloader stage.
> 
> So why not just add one-liner property of the RCC block like ?
> st,rcc-in-secure-configuration

Because using compatible was already decided.

Rob
