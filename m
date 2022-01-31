Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B04A3E80
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbiAaILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiAaILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:11:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D64C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 00:11:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s18so23681925wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 00:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LzBo+qZfYgsc3DpL31g6/Y58gAL+IatCA1mpbV8SqCA=;
        b=IKK/WUAziglEsYPesGOVaApR/hIrHlnn441Stu298Yt6FxqI2AB02A7m/fTZmNTW0s
         N6jHCwRmXawzvwdWj9aRM5AZbr/QHn4EpFBqj4QDhhTEKYg1g6+H24TU6n4bDl7uPger
         DWUcMM5QGRNduDizYUzqHqCSuu9qLaWcWaXEygdNG+jZqnGrPkXm8m9wewb7N8PAaPWr
         UH0tKHcyPRT9Uaf8Iqwpj86ml2bAnlzcl68NvQ084PmnAxeK4KTH5XaQltq6cBI/A1S8
         GkAEKtbGNjQBGpDCf/Rd/Ok0Suv34t3GM1LcbQ+hrxoxHdiektgoPsXDGS45HrQ7E6IN
         D5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LzBo+qZfYgsc3DpL31g6/Y58gAL+IatCA1mpbV8SqCA=;
        b=q7D92Ok/H0AWYudY0JYHiduYucCS2dTG8VvL71SaBAKljc6ozQlEfs8/I4n1X/zcHh
         PcmUYqdmYcUCiJzhj4aLivicEJcTkIQjuJSkSsecxEb5/TBjSkpXM688t7mwkgIGB7lU
         Z+sUL/PjayMFKbzg/5ijJT2y/nB+DubNIErUej04BPcgum+TiZiHA0MLwLHV9v7nsW/D
         SGtGv5dfKUeMnlMgfL2tuQYgS7hH3GiWDds63xXrHCil3SHgNj/2DkEcKXxqf94h7r4n
         ssdLEeKwI2fc+1N3Yr7ZIzEBE6bx1eCJfKTCLv+7hzB8YZwKVjqKtcTNlcJ362AWnZ9D
         FpKg==
X-Gm-Message-State: AOAM531kZaYzJNkGqdr6kGRbXWOC5tSQUn0RXvS1PKkmcWAXW8zK3C4m
        O6M0PqVg69keJmnUFQIG1m0OmA==
X-Google-Smtp-Source: ABdhPJxzy67mDG/u4p5XJJcAdyf6Zvq5P9L55f4JTOcksviLQW/dY0y/TNu+z2gYC+QSyVEnHNvqQw==
X-Received: by 2002:a05:6000:1707:: with SMTP id n7mr16588513wrc.234.1643616693635;
        Mon, 31 Jan 2022 00:11:33 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id t5sm11492990wrw.92.2022.01.31.00.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 00:11:33 -0800 (PST)
Date:   Mon, 31 Jan 2022 09:11:31 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ata: convert ata/cortina,gemini-sata-bridge
 to yaml
Message-ID: <YfeZs//CcSqWPjhl@Red>
References: <20220129204004.1009571-1-clabbe@baylibre.com>
 <c827a283-a2ba-b89c-2361-627f24e5f86f@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c827a283-a2ba-b89c-2361-627f24e5f86f@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Jan 31, 2022 at 09:48:20AM +0900, Damien Le Moal a écrit :
> On 2022/01/30 5:40, Corentin Labbe wrote:
> > This patch converts ata/cortina,gemini-sata-bridge binding to yaml
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../ata/cortina,gemini-sata-bridge.txt        |  55 ----------
> >  .../ata/cortina,gemini-sata-bridge.yaml       | 100 ++++++++++++++++++
> >  2 files changed, 100 insertions(+), 55 deletions(-)
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
> > index 000000000000..ff27e4884e21
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
> > @@ -0,0 +1,100 @@
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
> > +    const: "cortina,gemini-sata-bridge"
> > +  reg:
> > +    minItems: 1
> > +  resets:
> > +    minItems: 2
> > +    description: phandles to the reset lines for both SATA bridges
> > +  reset-names:
> > +    items:
> > +      - const: "sata0"
> > +      - const: "sata1"
> > +  clocks:
> > +    minItems: 2
> > +    description: phandles to the compulsory peripheral clocks
> > +  clock-names:
> > +    items:
> > +      - const: "SATA0_PCLK"
> > +      - const: "SATA1_PCLK"
> > +  syscon:
> > +    minItems: 1
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: a phandle to the global Gemini system controller
> 
> s/a phandle/phandle ?
> 
> Saying "a phandle" seems to imply that there may be many. I am not sure here though.
> 
> > +  cortina,gemini-ata-muxmode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum:
> > +      - 0
> > +      - 1
> > +      - 2
> > +      - 3
> > +    description: |
> > +      tell the desired multiplexing mode for the ATA controller and SATA bridges. Values 0..3:
> 
> Nit: Start the sentence with an uppercase "Tell...".
> 
> > +      Mode 0: ata0 master <-> sata0
> > +              ata1 master <-> sata1
> > +              ata0 slave interface brought out on IDE pads
> > +      Mode 1: ata0 master <-> sata0
> > +              ata1 master <-> sata1
> > +              ata1 slave interface brought out on IDE pads
> > +      Mode 2: ata1 master <-> sata1
> > +              ata1 slave  <-> sata0
> > +              ata0 master and slave interfaces brought out on IDE pads
> > +      Mode 3: ata0 master <-> sata0
> > +              ata0 slave  <-> sata1
> > +              ata1 master and slave interfaces brought out on IDE pads
> > +
> > +  cortina,gemini-enable-ide-pins:
> > +    type: boolean
> > +    description: enables the PATA to IDE connection.
> 
> Same here.
> 
> > +                 The muxmode setting decides whether ATA0 or ATA1 is brought out,
> > +                 and whether master, slave or both interfaces get brought out.
> > +  cortina,gemini-enable-sata-bridge:
> > +    type: boolean
> > +    description: enables the PATA to SATA bridge
> 
> Ditto. And the line break is a little early. The first line could be longer so
> that everything fits in 2 lines.
> 
> > +                 inside the Gemnini SoC. The Muxmode decides what PATA blocks will
> > +                 be muxed out and how.
> > +
> > +required:
> > +  - clocks
> > +  - clock-names
> > +  - cortina,gemini-ata-muxmode
> > +  - resets
> > +  - reset-names
> > +  - compatible
> > +  - reg
> > +  - syscon
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/cortina,gemini-clock.h>
> > +    sata: sata@46000000 {
> > +      compatible = "cortina,gemini-sata-bridge";
> > +      reg = <0x46000000 0x100>;
> > +      resets = <&rcon 26>, <&rcon 27>;
> > +      reset-names = "sata0", "sata1";
> > +      clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
> > +               <&gcc GEMINI_CLK_GATE_SATA1>;
> > +      clock-names = "SATA0_PCLK", "SATA1_PCLK";
> > +      syscon = <&syscon>;
> > +      cortina,gemini-ata-muxmode = <3>;
> > +      cortina,gemini-enable-ide-pins;
> > +      cortina,gemini-enable-sata-bridge;
> > +    };
> 
> With the above cosmetic nits addressed (if necessary):
> 
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 

Hello

I will fix all thoses in v2.

Thanks!
