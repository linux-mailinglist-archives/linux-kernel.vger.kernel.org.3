Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E72C5A37C7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiH0NFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH0NFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 09:05:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18F55A3D6;
        Sat, 27 Aug 2022 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661605529;
        bh=NVXCqOY1o0HLhE9U42CLQq+iogrS7/vsx1EZqNj3yZc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NqmXTfRdSsyiFrwjumChhs3v+hHHtXCj47dFS02rOqncX4lw9lCHMbVvz74poND2q
         kYB7ifzVtOnm4Ci45ApqXV0sUWuuYoh3z8azMuaa/A6OWd1fTO3M3B+VKMZBlrG27X
         M7rGYF+rQV/XzULi9Ddno2q51Dci64piZB8zdBY0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.72.241.228] ([141.72.241.228]) by web-mail.gmx.net
 (3c-app-gmx-bap34.server.lan [172.19.172.104]) (via HTTP); Sat, 27 Aug 2022
 15:05:29 +0200
MIME-Version: 1.0
Message-ID: <trinity-be166cb2-a06f-4a08-8e24-800e11652def-1661605529717@3c-app-gmx-bap34>
From:   Max.Buchholz@gmx.de
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH v3] dt-bindings: nvidia,tegra20-kbc: Convert to
 json-schema
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Aug 2022 15:05:29 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220720215449.GA4031847-robh@kernel.org>
References: <20220715131422.51143-1-max.buchholz@gmx.de>
 <20220720215449.GA4031847-robh@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:IRP6iRTR2SPbpPTqHONGYmQCOzLWai9l0EHInV5m1cd8EP0eeReSCiP+Fn3L1yzjJ4G7U
 he4pwEV30wBIBQyIvOtmCqYBE+un2O6y1sYOVSPEcXgikxr7yKnzIRlC3U6ZHcw9/NN+1s65RIl1
 8vxDA+IJ8UH+7b9cabahalAmSm97Qak0uyUREU5hTyJ5ZMUHJOwOzcXqeGukuIJiLDhrMoKUNca4
 g8sdCz5muk5LrYnDkYEt8kQaFQDWaJbbiIp7pAuzGDtCC8z9EQGpxwMIhbQNFr0ouIhCpz91Ckw5
 i0=
X-UI-Out-Filterresults: notjunk:1;V03:K0:AuEDtR6gQAs=:z9lWspvmh42aU8xCszTnGt
 QJFGmkhSX5FHGXfJgsfXCFYBg4I6fAeCJfkg/+wAaANu9khLSaxutF//jsRCnwm2e/bYNqVvf
 9ibHezTwdadAbUO85uGT6sK5S0wP0QHGOlEi6ugABAjh+L2maaoA90R7m7kOKHt/gE0ThE80X
 UkfJzO8QA7ZrfE9COD+D95QeE11WUiNrsPfWAAPUhM7ahTjFO2suEfGZZlZk77sJ7V1irhnPV
 TQAWJ6/K1WHOmtOKAe34crooYn2pyZJOOqbgqImHraFkvwtZa8mzHxos0weSgDV875tECnfNy
 a83Bmz6mWXmILeBoiQDAxIMBtAsRUKaClwYmYtvPShMW71vbvUDaqzeKunnxWbSPEHwSZs3NR
 nSVtXMw49M48GqwoJo25KNEUHjpJZ8e3IGU/uoElScFHq8d2Mz2PF04Epv8Dw6qrRBqj7n+Vd
 xewOjKvTzMzF3hMHjyNDD1QYFkTHTqU3flGImbY2p8gFf0Xq5bZha7PEX7ZQssnWj4hl4TDXP
 vIyaq4mCBu/XhSL1bRVWTDcE+coTVspLp3RbK+I546VPThjmkge3x2VHEI9PrPBaFVivMm3V5
 DbGSo+iFcroUduezn5TSHWwVCWaPVeYaAZR/XZjHTZmkhcvOw3Irn2B9Sr+qKB/I7m/CVmjpu
 CCQ3advMx7Ykg+aJjf6kT1rsguXUimzlKdQ76zSGB235aIQoWdx4q7fAfmETbxbZG5xZEVUE/
 6J0gOg3a4teZphuIrJc4h8CPO11ywLykiFEkpu3tTDncEPcDTBqG/Veu5Hu0RJoaKMcNqVV/2
 erjGTzt
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> items:
> maximum: 24 (or 23?)

I do not exactly get what you mean with this and how you get to 24, which =
isn't the maximum of the kbc-row-pins, but the maximum of kbc-row-pins and =
kbc-col-pins added=2E I would be glad to get some more clarification abou t=
hat=2E

Additionally thanks for yll the feedback so far, really appreciate it=2E

regards

Max Buchholz
=C2=A0

> From: Max Buchholz <Max=2EBuchholz@gmx=2Ede>
>
> This converts the Nvidia Tegra keyboard controller bindings to YAML
> and fix them up a bit=2E
>
> Reviewed-by: David Heidelberg <david@ixit=2Ecz>
> Signed-off-by: Max Buchholz <max=2Ebuchholz@gmx=2Ede>
> ---
> v3:
> - fixed maxItems for array properties
> v2:
> - rework the file according to the feedback
>
> =2E=2E=2E/bindings/input/nvidia,tegra20-kbc=2Etxt | 55 ---------
> =2E=2E=2E/bindings/input/nvidia,tegra20-kbc=2Eyaml | 111 +++++++++++++++=
+++
> =2E=2E=2E/bindings/power/wakeup-source=2Etxt | 2 +-
> 3 files changed, 112 insertions(+), 56 deletions(-)
> delete mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra2=
0-kbc=2Etxt
> create mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra2=
0-kbc=2Eyaml
>
> diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc=
=2Etxt b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc=2Etxt
> deleted file mode 100644
> index 1faa7292e21f=2E=2E000000000000
> --- a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc=2Etxt
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -* Tegra keyboard controller
> -The key controller has maximum 24 pins to make matrix keypad=2E Any pin
> -can be configured as row or column=2E The maximum column pin can be 8
> -and maximum row pins can be 16 for Tegra20/Tegra30=2E
> -
> -Required properties:
> -- compatible: "nvidia,tegra20-kbc"
> -- reg: Register base address of KBC=2E
> -- interrupts: Interrupt number for the KBC=2E
> -- nvidia,kbc-row-pins: The KBC pins which are configured as row=2E This=
 is an
> - array of pin numbers which is used as rows=2E
> -- nvidia,kbc-col-pins: The KBC pins which are configured as column=2E T=
his is an
> - array of pin numbers which is used as column=2E
> -- linux,keymap: The keymap for keys as described in the binding documen=
t
> - devicetree/bindings/input/matrix-keymap=2Etxt=2E
> -- clocks: Must contain one entry, for the module clock=2E
> - See =2E=2E/clocks/clock-bindings=2Etxt for details=2E
> -- resets: Must contain an entry for each entry in reset-names=2E
> - See =2E=2E/reset/reset=2Etxt for details=2E
> -- reset-names: Must include the following entries:
> - - kbc
> -
> -Optional properties, in addition to those specified by the shared
> -matrix-keyboard bindings:
> -
> -- linux,fn-keymap: a second keymap, same specification as the
> - matrix-keyboard-controller spec but to be used when the KEY_FN modifie=
r
> - key is pressed=2E
> -- nvidia,debounce-delay-ms: delay in milliseconds per row scan for debo=
uncing
> -- nvidia,repeat-delay-ms: delay in milliseconds before repeat starts
> -- nvidia,ghost-filter: enable ghost filtering for this device
> -- wakeup-source: configure keyboard as a wakeup source for suspend/resu=
me
> - (Legacy property supported: "nvidia,wakeup-source")
> -
> -Example:
> -
> -keyboard: keyboard {
> - compatible =3D "nvidia,tegra20-kbc";
> - reg =3D <0x7000e200 0x100>;
> - interrupts =3D <0 85 0x04>;
> - clocks =3D <&tegra_car 36>;
> - resets =3D <&tegra_car 36>;
> - reset-names =3D "kbc";
> - nvidia,ghost-filter;
> - nvidia,debounce-delay-ms =3D <640>;
> - nvidia,kbc-row-pins =3D <0 1 2>; /* pin 0, 1, 2 as rows */
> - nvidia,kbc-col-pins =3D <11 12 13>; /* pin 11, 12, 13 as columns */
> - linux,keymap =3D <0x00000074
> - 0x00010067
> - 0x00020066
> - 0x01010068
> - 0x02000069
> - 0x02010070
> - 0x02020071>;
> -};
> diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc=
=2Eyaml b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc=2Eyaml
> new file mode 100644
> index 000000000000=2E=2E8e1eaad2fdc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc=2Eyaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2=2E0-only OR BSD-2-Clause)
> +%YAML 1=2E2
> +---
> +$id: "http://devicetree=2Eorg/schemas/input/nvidia,tegra20-kbc=2Eyaml#"
> +$schema: "http://devicetree=2Eorg/meta-schemas/core=2Eyaml#[http://devi=
cetree=2Eorg/meta-schemas/core=2Eyaml#]"
> +
> +title: Nvidia Tegra keyboard controller
> +
> +maintainers:
> + - Jon Hunter <jonathanh@nvidia=2Ecom>
> + - Sameer Pujar <spujar@nvidia=2Ecom>
> +
> +description: The key controller has maximum 24 pins to make matrix keyp=
ad=2E Any pin
> + can be configured as row or column=2E
> +
> +allOf:
> + - $ref: "/schemas/input/matrix-keymap=2Eyaml#"
> +
> +properties:
> + compatible:
> + oneOf:
> + - items:
> + - const: nvidia,tegra30-kbc
> + - const: nvidia,tegra20-kbc
> + - items:
> + - const: nvidia,tegra20-kbc
> +
> + reg:
> + maxItems: 1
> +
> + interrupts:
> + maxItems: 1
> +
> + nvidia,kbc-row-pins:
> + minItems: 1
> + maxItems: 16
> + description: KBC pins which are configured as row
> + $ref: /schemas/types=2Eyaml#/definitions/uint32-array

items:
maximum: 24 (or 23?)

> +
> + nvidia,kbc-col-pins:
> + minItems: 1
> + maxItems: 8
> + description: KBC pins which are configured as column
> + $ref: /schemas/types=2Eyaml#/definitions/uint32-array

Same here=2E

> +
> + clocks:
> + maxItems: 1
> +
> + resets:
> + maxItems: 1
> +
> + reset-names:
> + const: kbc
> +
> + linux,fn-keymap:

While mentioned in matrix-keymap=2Eyaml, it is not defined as a schema
anywhere=2E It needs a type=2E I guess here is fine as this doesn't seem
to be used much=2E

> + description: a secondary keymap to be used when the KEY_FN modifier ke=
y is pressed
> +
> + nvidia,debounce-delay-ms:
> + description: delay in milliseconds per row scan for debouncing
> +
> + nvidia,repeat-delay-ms:
> + description: delay in milliseconds before repeat starts
> +
> + nvidia,ghost-filter:
> + description: enable ghost filtering for this device
> + type: boolean
> +
> + wakeup-source:
> + description: configure keyboard as a wakeup source for suspend/resume
> +
> + nvidia,wakeup-source:
> + description: configure keyboard as a wakeup source for suspend/resume
> + deprecated: true
> + type: boolean

Deprecated for 7 years=2E Could be dropped?

> +
> +required:
> + - compatible
> + - reg
> + - interrupts
> + - nvidia,kbc-row-pins
> + - nvidia,kbc-col-pins
> + - linux,keymap
> + - clocks
> + - resets
> + - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> + - |
> + #include <dt-bindings/interrupt-controller/arm-gic=2Eh>
> +
> + kbc@7000e200 {

keyboard@=2E=2E=2E

> + compatible =3D "nvidia,tegra20-kbc";
> + reg =3D <0x7000e200 0x100>;
> + interrupts =3D <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> + clocks =3D <&tegra_car 36>;
> + resets =3D <&tegra_car 36>;
> + reset-names =3D "kbc";
> + nvidia,ghost-filter;
> + nvidia,debounce-delay-ms =3D <640>;
> + nvidia,kbc-row-pins =3D <0 1 2>; /* pin 0, 1, 2 as rows */
> + nvidia,kbc-col-pins =3D <11 12 13>; /* pin 11, 12, 13 as columns */
> + linux,keymap =3D <0x00000074
> + 0x00010067
> + 0x00020066
> + 0x01010068
> + 0x02000069
> + 0x02010070
> + 0x02020071>;
> + };
> diff --git a/Documentation/devicetree/bindings/power/wakeup-source=2Etxt=
 b/Documentation/devicetree/bindings/power/wakeup-source=2Etxt
> index cfd74659fbed=2E=2E728f88de371d 100644
> --- a/Documentation/devicetree/bindings/power/wakeup-source=2Etxt
> +++ b/Documentation/devicetree/bindings/power/wakeup-source=2Etxt
> @@ -25,7 +25,7 @@ List of legacy properties and respective binding docum=
ent
> Documentation/devicetree/bindings/input/touchscreen/ads7846=2Etxt
> 5=2E "linux,keypad-wakeup" Documentation/devicetree/bindings/input/qcom,=
pm8xxx-keypad=2Etxt
> 6=2E "linux,input-wakeup" Documentation/devicetree/bindings/input/samsun=
g-keypad=2Etxt
> -7=2E "nvidia,wakeup-source" Documentation/devicetree/bindings/input/nvi=
dia,tegra20-kbc=2Etxt
> +7=2E "nvidia,wakeup-source" Documentation/devicetree/bindings/input/nvi=
dia,tegra20-kbc=2Eyaml
>
> Examples
> --------
> --
> 2=2E37=2E0
>
>
