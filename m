Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA04B0E51
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbiBJNWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:22:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbiBJNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:22:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48589208
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:22:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q7so9459507wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NKJ18gxzb+DSZ0V1Oa8wZA6qFSAn8YENHdOaAvTuJeA=;
        b=LwgbNOmQG0mrjTHwQz9e6vSkt9hihsXNSD64VOOThEIVzJ1hfLCKo7u0jJa8HevzYM
         eqsqgAVQFeUO+0klCneyi3Tcjc7YEAx0MUWVNmNLLYeM1+BgfCzij5/S/oZyPJ17mRng
         MhgNZ1nIXPhwSxtjJ3yIN7KhzobdDekBbcl1xiDrQ1Wb2kMcBkGenzydiiGgh0ReMnt0
         Xdj0i4kgxDoCU3I904j9KU29a6VX6PooDdoynrxBhDWmlYm4VJR+/0bDNLkxOooc7w09
         OjneyXIBDXTm+IxTEvjrIGUyIWWSWCMahw9m/IBOpjB8jZJxv10dmyFQnnRYghHEAcjz
         CGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NKJ18gxzb+DSZ0V1Oa8wZA6qFSAn8YENHdOaAvTuJeA=;
        b=cmOddA/WSqa3WIsoh3H7jy8+ocITEHsMkDvQpnw7DPPigI78Nws5m6CWVT8REPcBQP
         usmn8erx0qoaTsHe6HJI6lcscpXgunuoCl3d5ZujbMC96+Adv8C7JM6DBBwWEBsJavbG
         yyzxmz5vjXWq6Ion9GsyX7cHZpyRc60mjXjO9upynIeTE0XyIRkNBgNvkEsYCH9+UOp/
         Z5xd8kOsPooDN9j333uWgqvBzhDNxniPgqd3V34UnJhbtnmCy/fhfE6T+0hx5uoUhzlr
         RVvhQnZs5dZ38Rd251YOL1wuSnT9inq3UgP1D/Om4wLwlxgNcptcoTuaYIZkTiRWjApH
         rCeQ==
X-Gm-Message-State: AOAM533nDqSw7zcJtId1CF+AIWI1oxq0nCFT4O/4DYQc6hQhYbRCEa3W
        i4gJLr7j3yGaa/apWWtWTGenBg==
X-Google-Smtp-Source: ABdhPJzcmxLy2Eka/lbS611JX3zJDDqg2yREihDf25aO97Nup+iQ58tpH4OX0cwKoVbe6p1sQ33ajA==
X-Received: by 2002:a5d:48c1:: with SMTP id p1mr6406878wrs.137.1644499322727;
        Thu, 10 Feb 2022 05:22:02 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id b4sm10992490wrw.100.2022.02.10.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 05:22:02 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:22:00 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     damien.lemoal@opensource.wdc.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: convert ata/cortina,gemini-sata-bridge
 to yaml
Message-ID: <YgUReEQ1TlTMdenJ@Red>
References: <20220210094414.2815616-1-clabbe@baylibre.com>
 <50d3bef2-82af-325e-72e9-15af5794ce12@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50d3bef2-82af-325e-72e9-15af5794ce12@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Feb 10, 2022 at 10:58:39AM +0100, Krzysztof Kozlowski a écrit :
> On 10/02/2022 10:44, Corentin Labbe wrote:
> > This patch converts ata/cortina,gemini-sata-bridge binding to yaml
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> > Change since v1:
> > - fixed cosmetic nits reported by Damien Le Moal
> > Changes since v2:
> > - Added blank lines between properties
> > - Removed useless quotes and label
> > - Re-indented description
> > 
> >  .../ata/cortina,gemini-sata-bridge.txt        |  55 ---------
> >  .../ata/cortina,gemini-sata-bridge.yaml       | 107 ++++++++++++++++++
> >  2 files changed, 107 insertions(+), 55 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> >  create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> > deleted file mode 100644
> > index 1c3d3cc70051..000000000000
> > --- a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
> > +++ /dev/null
> > @@ -1,55 +0,0 @@
> > -* Cortina Systems Gemini SATA Bridge
> > -
> > -The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
> > -takes two Faraday Technology FTIDE010 PATA controllers and bridges
> > -them in different configurations to two SATA ports.
> > -
> > -Required properties:
> > -- compatible: should be
> > -  "cortina,gemini-sata-bridge"
> > -- reg: registers and size for the block
> > -- resets: phandles to the reset lines for both SATA bridges
> > -- reset-names: must be "sata0", "sata1"
> > -- clocks: phandles to the compulsory peripheral clocks
> > -- clock-names: must be "SATA0_PCLK", "SATA1_PCLK"
> > -- syscon: a phandle to the global Gemini system controller
> > -- cortina,gemini-ata-muxmode: tell the desired multiplexing mode for
> > -  the ATA controller and SATA bridges. Values 0..3:
> > -  Mode 0: ata0 master <-> sata0
> > -          ata1 master <-> sata1
> > -          ata0 slave interface brought out on IDE pads
> > -  Mode 1: ata0 master <-> sata0
> > -          ata1 master <-> sata1
> > -          ata1 slave interface brought out on IDE pads
> > -  Mode 2: ata1 master <-> sata1
> > -          ata1 slave  <-> sata0
> > -          ata0 master and slave interfaces brought out
> > -               on IDE pads
> > -  Mode 3: ata0 master <-> sata0
> > -          ata0 slave  <-> sata1
> > -          ata1 master and slave interfaces brought out
> > -               on IDE pads
> > -
> > -Optional boolean properties:
> > -- cortina,gemini-enable-ide-pins: enables the PATA to IDE connection.
> > -  The muxmode setting decides whether ATA0 or ATA1 is brought out,
> > -  and whether master, slave or both interfaces get brought out.
> > -- cortina,gemini-enable-sata-bridge: enables the PATA to SATA bridge
> > -  inside the Gemnini SoC. The Muxmode decides what PATA blocks will
> > -  be muxed out and how.
> > -
> > -Example:
> > -
> > -sata: sata@46000000 {
> > -	compatible = "cortina,gemini-sata-bridge";
> > -	reg = <0x46000000 0x100>;
> > -	resets = <&rcon 26>, <&rcon 27>;
> > -	reset-names = "sata0", "sata1";
> > -	clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
> > -		 <&gcc GEMINI_CLK_GATE_SATA1>;
> > -	clock-names = "SATA0_PCLK", "SATA1_PCLK";
> > -	syscon = <&syscon>;
> > -	cortina,gemini-ata-muxmode = <3>;
> > -	cortina,gemini-enable-ide-pins;
> > -	cortina,gemini-enable-sata-bridge;
> > -};
> > diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> > new file mode 100644
> > index 000000000000..f0fad63bb1af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ata/cortina,gemini-sata-bridge.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cortina Systems Gemini SATA Bridge
> > +
> > +maintainers:
> > +  - Linus Walleij <linus.walleij@linaro.org>
> > +
> > +description: |
> > +    The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
> > +    takes two Faraday Technology FTIDE010 PATA controllers and bridges
> > +    them in different configurations to two SATA ports.
> > +
> > +properties:
> > +  compatible:
> > +    const: cortina,gemini-sata-bridge
> > +
> > +  reg:
> > +    minItems: 1
> 
> maxItems? Why min?
> 
> > +
> > +  resets:
> > +    minItems: 2
> > +    description: phandles to the reset lines for both SATA bridges
> 
> min+maxItems
> 
> > +
> > +  reset-names:
> > +    items:
> > +      - const: sata0
> > +      - const: sata1
> > +
> > +  clocks:
> > +    minItems: 2
> > +    description: phandles to the compulsory peripheral clocks
> 
> min+maxItems
> 
> > +
> > +  clock-names:
> > +    items:
> > +      - const: SATA0_PCLK
> > +      - const: SATA1_PCLK
> > +
> > +  syscon:
> > +    minItems: 1
> 
> maxItems
> 

Hello

I will fix them in v4.

Thanks
Regards
