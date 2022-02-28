Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444BA4C6F04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiB1OK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbiB1OKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:10:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082C7F6D4;
        Mon, 28 Feb 2022 06:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646057347;
        bh=r141YfG2TQ9WjHx6P9dhMfMAMaof7bN8LOa13RRC48g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NIrn91UNecl486EEvEw7naC/R2cywEL+cxYwSJWKJtxuIfSATL1n9Xu0zEZaYPzgc
         SMdE1qSW+ziTS3DUgGJaN0qO3SU+ugrgmqGzKo4YTWBqaP6hF8qzs0+FgYUGCKxxJY
         rcHIRYTlyzD11n3j6ZmFB80izrkDZ8aSsT+sOmN4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.79.12] ([80.245.79.12]) by web-mail.gmx.net
 (3c-app-gmx-bs53.server.lan [172.19.170.137]) (via HTTP); Mon, 28 Feb 2022
 15:09:07 +0100
MIME-Version: 1.0
Message-ID: <trinity-f1b6ce3a-6f22-4cf8-bf51-a5e7f007dda7-1646057347735@3c-app-gmx-bs53>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Aw: Re:  Re: [PATCH v3 1/3] dt-bindings: Convert ahci-platform DT
 bindings to yaml
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 28 Feb 2022 15:09:07 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <8fbbce9e-4fd9-d420-43ef-953e846d29f1@canonical.com>
References: <20220227182800.275572-1-linux@fw-web.de>
 <20220227182800.275572-2-linux@fw-web.de>
 <4c3303f5-7af5-9974-7bea-b7f0d6c7ef53@canonical.com>
 <trinity-ac45bde6-392d-4810-8aad-9a06d2bcd85a-1646050780475@3c-app-gmx-bs53>
 <8fbbce9e-4fd9-d420-43ef-953e846d29f1@canonical.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:hGre/9OaHVVKyjepZefcY8cKVUbZze6nGWhzHQ5CJ1JAUcdA+Fh3vEr9nLUqTMJsOQAcA
 EnrEX1pwBH8J1CTBbQU7C+D8GqqwNp/YVAmXbFwNc1lTMSluKjlz3MB9mLIrs1xpB1aZhCyo2kaG
 tkd2ld9su2JXc3lgjaQ2Ks9ZeXyQV4Z2LDVgTorlAkDTNqlP8gOwqHZIy4i0usyClJq97BeG0jiI
 TB5pLmftI9LZR8cdPiKW35n12LHAdYN00nvASk/hjRgNNlhTXchfAgg3HlMfKFVmIAlJ/opU3PDG
 uo=
X-UI-Out-Filterresults: notjunk:1;V03:K0:5eATMZluwTU=:64hypXlGuUh2wmWGa6843D
 0bt209DEO6DV9kVWZzDE8wG1NrucTE3gRxy6xngEFmLAnMVqN+8Py9pzDwJPSU7rhE2V+YQhf
 1STR90pum8X/BzgABtM0aAHh5B+mD6/QlkD+ii2Mt08iEGIg6R2VxrZb3ElAS0ylirzoBIuHL
 WWSXb4/Y703XTJ0zOJa6Feeh7Is80YD0m+npPFOmKONoNszuN69xAcdgUGGuPZqIOvERVoIx8
 lXRKsfyDyJ1lWuDyqN8QKb2IcoxfR2PFFh0WMoeu1V1uDpBeacbwUxwhEqxqRjPnAP4h59mKn
 66usbdDAh2MOjL6TfhwNFQKyQADz6HBfFXJF4fQd1iiYhdbUWGgGqS96USXMitJAoWWGCNeCV
 Ej62gdhhK4A0y0RqtoWthNYgqsHZ5EFimurP70xafg4sK+cQDrHpxijhYPoWNjvArEMY0hEGe
 QnED7FOQJnCebG51vHM2gkQsd9qQX9b6OAn8xDhiv7HHeEfg8tBQ+sZ9EE9iMlOpA57m4wdAP
 K2iuc009lXHFjJAZpsAcoL0mByUewGqcxEoHif3qV2jlBYTOTVFcm05ErXmSl79tumWATeef5
 +YnO4lNLCE3btZyck0ERq8tEVBoDZhW+OyIkKtD9cQZCCa+yobVv6Gbk/1MfC77zP2dGHj+Ct
 hK+2U0gwr6XYTy5ks25GRBII8XOLGX6e72dVA59DEQPdx568g2zjWhd0BJv6pdVnIWTKFV8j3
 wtzBi+GGr5QGMCBalzcLn05YYHhEhC4Zs/CoNSx5CADRB2RapcblWQWjApZ2Un/X90AloKKj5
 P8/a6AR
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

looks like i'm not the right person to convert the binding. I have not enough knowledge about yaml, bindings, drivers, ...

i will try you suggestions for me as a lerning-by-doing approach, but will drop it from the series, same for part2 as it depends on first.



> Gesendet: Montag, 28. Februar 2022 um 13:38 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>

> On 28/02/2022 13:19, Frank Wunderlich wrote:

> >> You converted the TXT bindings explicitly, but you missed the comment
> >> just below the 'reg' about generic-ahci. The generic-ahci never comes alone.
> >
> > How should this comment be added? description above/below the compatible-property?
> > Sorry for dumb questions...this is my first yaml ;)
>
> No, this has to be oneOf. See for example
> Documentation/devicetree/bindings/gpio/gpio-vf610.yaml or many other files.

Afaik the generic-ahci should be defined optional with one of the others needed, but afaik this will duplicate the list i had.

so i end up in a struct like this

compatible:
  oneOf:
    - enum:
      - brcm,iproc-ahci
      - cavium,octeon-7130-ahci
      - hisilicon,hisi-ahci
      - ibm,476gtr-ahci
      - marvell,armada-3700-ahci
      - marvell,armada-380-ahci
      - snps,dwc-ahci
      - snps,spear-ahci
    - items:
      - const: generic-ahci
      - enum:
        - brcm,iproc-ahci
        - cavium,octeon-7130-ahci
        - hisilicon,hisi-ahci
        - ibm,476gtr-ahci
        - marvell,armada-3700-ahci
        - marvell,armada-380-ahci
        - snps,dwc-ahci
        - snps,spear-ahci


> >>> + interrupts:
> >>> + minItems: 1
> >>
> >> You mean maxItems?
> >
> > no, minItems, as interrupts suggests 1+ (same for phys)
>
> You cannot have infinite number of interrupts... What suggests "1+"?
> What does it mean "as interrupts suggests"? Do these hardware blocks
> really have many interrupt lines?
>
> The same for phys.

interrupts/phys is plural of interrupt/phy, so it suggests it can be more than 1.

as i said i do not know every driver with all possibilities, so i started with the min-items as we need at least 1 interrupt/phy, but yes if there are any limits then they should be added, but this needs extensive knowledge about the drivers/hardware, i don't have.

> >>> + ports-implemented:
> >>> + description:
> >>> + Mask that indicates which ports that the HBA supports
> >>> + are available for software to use. Useful if PORTS_IMPL
> >>> + is not programmed by the BIOS, which is true with
> >>> + some embedded SoCs.
> >>> + minItems: 1
> >>
> >> You need a type and maxItems.
> >
> > what will be the type of a mask?
>
> `git grep ports-implemented` gives pretty straightfoward answer. All DTS
> have u32 and driver also uses u32.

so type should be

$ref: '/schemas/types.yaml#/definitions/uint32'

?

it's the only one i've found with u32 looking like a type

found in Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml

> >
> >>> +
> >>> + resets:
> >>> + minItems: 1
> >>
> >> maxItems?
> >
> > if there is a known maximum....
>
> Must be. You cannot have infinite number of reset lines... Please check
> all DTS and drivers. If there is public documentation, it also might be
> useful.

"Please check all DTS and drivers." this is impossible for me as doing this as hobby with still limited time ;(

> >
> >>> +
> >>> + target-supply:
> >>> + description:
> >>> + regulator for SATA target power
> >>> +
> >>> +required:
> >>> + - compatible
> >>> + - reg
> >>> + - interrupts
> >>> +
> >>> +patternProperties:
> >>> + "^sata-port@[0-9]+$":
> >>
> >> You limit number of ports to 10. On purpose? What about 0xa? 0xb?
> >
> > oh, right, there can be hexadecimal...
> > thought this is only true for the main-node (address) and have only seen @0, @1 and @2
> >
> >>> + type: object
> >>> + description:
> >>> + Subnode with configuration of the Ports.
> >>> +
> >>> + properties:
> >>> + reg:
> >>> + maxItems: 1
> >>> +
> >>> + phys:
> >>> + minItems: 1
> >>
> >> maxItems? Why do you put everywhere minItems? Are several phys really
> >> expected?
> >
> > name suggests that it can be more than 1.
>
> What do you mean "name suggests"? Name of property? No, it does not
> suggest that. Name is standard. Please check example schema and other
> existing schema bindings to see how it is done. For example earlier
> gpio-vf610.yaml is not bad.

> > i know from usb subsystem (dwc3 usb3) that a device can have more than one phy, and because in the txt there are no ranges i set everywhere MinItems to 1 with open end as i do not know all possibilities. Anything else will be trial and error...for all properties
>
> The bindings need to be specific, so only properties which really,
> really can have many unknown elements we could keep here some high
> maxItems limit. In 99% of cases maxItems are clearly defined.

so i need to do try-and-error, setting maxItems to 1, make checks, if failing look in driver, increase, ...

but this is maybe not the right way to do as dts can contain errors which should not modify the binding.

> > these are the commands i used:
> >
> > ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/ata/ahci-platform.yaml
>
> Install dependencies (libyaml-dev) and you will see first error:
> Documentation/devicetree/bindings/ata/ahci-platform.yaml:110:1:
> [warning] wrong indentation: expected 2 but found 0 (indentation)
>
> But the one I am thinking is indeed not visible by default. You would
> need to run it like Rob's boot is running, so add DT_CHECKER_FLAGS=-m.
> Then you see:
>
> Documentation/devicetree/bindings/ata/ahci-platform.example.dt.yaml:0:0:
> /example-1/sata@f7e90000: failed to match any schema with compatible:
> ['marvell,berlin2q-achi', 'generic-ahci']

i try this, but imho it's better to drop the Patch as i'm no expert in this, don't know the HW/drivers enough and this will delay the dts patch too much.
I thought i can help getting this (simple looking) txt converted to yaml.
Seems the binding needs to be done by someone who knows the drivers more than me.

regards Frank
