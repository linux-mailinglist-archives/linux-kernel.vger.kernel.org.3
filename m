Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1887550E9BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbiDYTum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiDYTuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:50:40 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2336C2E0AA;
        Mon, 25 Apr 2022 12:47:36 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso11518310otk.10;
        Mon, 25 Apr 2022 12:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1BawjqkBLHRmejvmDxzJLVGY9D9hx57rjotxcPxJnyk=;
        b=kh+xTB0xVhF/wfMuJ7XD0CUUQ8wvhyx9ufZ3uzZ2jjDH+3OSq/GFKva6Cc3zvsnwAk
         839kPKd6B5190GZg8pW/6OZPcOPq6NS5eV0W0WJhOJxyjb42Ajn57tCWadSuVsAHWZzD
         Pf1SGPZGhBoefPowjwCOZWrpNqdsVgP8i9BXkTksEqyF4N2cpkaA/4bkapj3+6zVaNhY
         NC0w79iK+KwhAcPuOJzcHJR0tCuytTDPxw/PBCXxbxNa/eVk0Vw+5q6Kmzk/GRbJ/Qxk
         +FRl+HS70j2HrQDwWw4GdXyVFw4V6T9y7VITXBKdhhNEmOgDNiAFiVEQwY6wraM2SDce
         7BNg==
X-Gm-Message-State: AOAM530FR/7kvBdPJ+DDgFq0tcU3g5OCRPbshJecekMpMB6lUiF4Jq/2
        Cbbs6AISuSJ/9MOc1Am2zw==
X-Google-Smtp-Source: ABdhPJxUVOseF982okz0I94zQl56iy4xw06HftnN6UG796Lf0dWh37WBfSBkWydezRL2R0TwJ+xhxQ==
X-Received: by 2002:a9d:bc2:0:b0:605:c65f:96c2 with SMTP id 60-20020a9d0bc2000000b00605c65f96c2mr900036oth.319.1650916055360;
        Mon, 25 Apr 2022 12:47:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s10-20020a056830148a00b005ea12d6454bsm2769826otq.38.2022.04.25.12.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 12:47:34 -0700 (PDT)
Received: (nullmailer pid 147316 invoked by uid 1000);
        Mon, 25 Apr 2022 19:47:33 -0000
Date:   Mon, 25 Apr 2022 14:47:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: i3c: Convert snps,dw-i3c-master to DT schema
Message-ID: <Ymb61YHl62AfSe2R@robh.at.kernel.org>
References: <20220422192236.2594577-1-robh@kernel.org>
 <CAL_Jsq+t5e-Dr0z9Zd_+jaqwb1afEVx4SdjbQZA4bHpWf8a2jg@mail.gmail.com>
 <YmMD3RPXfPdiYXyg@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmMD3RPXfPdiYXyg@mail.local>
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

On Fri, Apr 22, 2022 at 09:37:01PM +0200, Alexandre Belloni wrote:
> On 22/04/2022 14:28:53-0500, Rob Herring wrote:
> > On Fri, Apr 22, 2022 at 2:22 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > Convert the Synopsys Designware I3C master to DT schema format.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/i3c/snps,dw-i3c-master.txt       | 41 ---------------
> > >  .../bindings/i3c/snps,dw-i3c-master.yaml      | 52 +++++++++++++++++++
> > >  2 files changed, 52 insertions(+), 41 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> > >  create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> > > deleted file mode 100644
> > > index 07f35f36085d..000000000000
> > > --- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> > > +++ /dev/null
> > > @@ -1,41 +0,0 @@
> > > -Bindings for Synopsys DesignWare I3C master block
> > > -=================================================
> > > -
> > > -Required properties:
> > > ---------------------
> > > -- compatible: shall be "snps,dw-i3c-master-1.00a"
> > > -- clocks: shall reference the core_clk
> > > -- interrupts: the interrupt line connected to this I3C master
> > > -- reg: Offset and length of I3C master registers
> > > -
> > > -Mandatory properties defined by the generic binding (see
> > > -Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
> > > -
> > > -- #address-cells: shall be set to 3
> > > -- #size-cells: shall be set to 0
> > > -
> > > -Optional properties defined by the generic binding (see
> > > -Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
> > > -
> > > -- i2c-scl-hz
> > > -- i3c-scl-hz
> > > -
> > > -I3C device connected on the bus follow the generic description (see
> > > -Documentation/devicetree/bindings/i3c/i3c.yaml for more details).
> > > -
> > > -Example:
> > > -
> > > -       i3c-master@2000 {
> > > -               compatible = "snps,dw-i3c-master-1.00a";
> > > -               #address-cells = <3>;
> > > -               #size-cells = <0>;
> > > -               reg = <0x02000 0x1000>;
> > > -               interrupts = <0>;
> > > -               clocks = <&i3cclk>;
> > > -
> > > -               eeprom@57{
> > > -                       compatible = "atmel,24c01";
> > > -                       reg = <0x57 0x0 0x10>;
> > > -                       pagesize = <0x8>;
> > > -               };
> > > -       };
> > > diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> > > new file mode 100644
> > > index 000000000000..5b8b43e6f1e4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> > > @@ -0,0 +1,52 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/i3c/snps,dw-i3c-master.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Synopsys DesignWare I3C master block
> > > +
> > > +maintainers:
> > > +  - Vitor Soares <vitor.soares@synopsys.com>
> > 
> > And it bounces. Someone else want it?
> > 
> 
> Probably no one but me.

Can you change it to yourself when applying?

Rob
