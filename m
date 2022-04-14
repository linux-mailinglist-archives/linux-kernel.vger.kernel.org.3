Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4E500E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbiDNMw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbiDNMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:52:26 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEB14A91D;
        Thu, 14 Apr 2022 05:50:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23ECnewc102384;
        Thu, 14 Apr 2022 07:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649940580;
        bh=g+j2oUIC6dotZBjVT4VBMnus4cyGj+76qX6AdSDi9po=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=M3PhvvwMex6H8WsNLjYtFJwCCwqwCCYEyt553cFusTAHNFrUhmehoCKBBiihpGMfI
         cG3uxFSN2mFiL2szLG2nRRT2Cu+caAkLYpzsaJuZmuW37NuV1KPBB/TMywaPDGZ76f
         Xr67oRqPdDXBacvZJVA+8wcxcqDo2JPv0cQ5s580=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23ECnexV010096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Apr 2022 07:49:40 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 14
 Apr 2022 07:49:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 14 Apr 2022 07:49:40 -0500
Received: from [128.247.81.242] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23ECneNf008215;
        Thu, 14 Apr 2022 07:49:40 -0500
Message-ID: <6516baf2-0d5c-a9e5-e2c9-6edd3dd35c9c@ti.com>
Date:   Thu, 14 Apr 2022 07:49:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: wkup-m3-ipc: Add ti,io-isolation
 property
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Drew Fustini <dfustini@baylibre.com>
CC:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220413020641.2789408-1-dfustini@baylibre.com>
 <20220413020641.2789408-2-dfustini@baylibre.com>
 <YlgUv2szqjes9arm@robh.at.kernel.org>
From:   Dave Gerlach <d-gerlach@ti.com>
In-Reply-To: <YlgUv2szqjes9arm@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/14/22 07:34, Rob Herring wrote:
> On Tue, Apr 12, 2022 at 07:06:40PM -0700, Drew Fustini wrote:
>> Add documentation for the ti,io-isolation DT property on the wkup_m3_ipc
>> node which tells the wkup_m3_ipc driver to use the wkup_m3 to enable
>> IO Isolation during low power mode transitions on am43xx platforms.
>>

$subject should be 'ti,set-io-isolation'.

>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> [dfustini: convert to YAML, make DTS example that passes check]
>> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
>> ---
>>  .../bindings/soc/ti/wkup-m3-ipc.yaml          | 68 +++++++++++++++++--
>>  1 file changed, 63 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
>> index 7f4a75c5fcaa..30a65b75c024 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
>> @@ -24,14 +24,22 @@ description: |+
>>    A wkup_m3_ipc device node is used to represent the IPC registers within an
>>    SoC.
>>  
>> -  Support for VTT Toggle
>> -  ==================================
>> +  Support for VTT Toggle with GPIO pin
>> +  ====================================
>>    On some boards like the AM335x EVM-SK and the AM437x GP EVM, a GPIO pin is
>>    connected to the enable pin on the DDR VTT regulator. This allows the
>>    regulator to be disabled upon suspend and enabled upon resume. Please note
>>    that the GPIO pin must be part of the GPIO0 module as only this GPIO module
>>    is in the wakeup power domain.
>>  
>> +  Support for IO Isolation
>> +  ========================
>> +  On AM437x SoCs, certain pins can be forced into an alternate state when IO
>> +  isolation is activated. Those pins have pad control registers prefixed by
>> +  'CTRL_CONF_' that contain DS0 (e.g. deep sleep) configuration bits that can
>> +  override the pin's existing bias (pull-up/pull-down) and value (high/low) when
>> +  IO isolation is active.
> 
> Can't this feature be implied from the compatible string?

All AM437x SoCs support it, but it may be enabled/disabled on different
boards. For example, this will be set for am437x-gp-evm, but not
am43x-epos-evm.

Regards,
Dave

> 
>> +
>>  properties:
>>    compatible:
>>      enum:
>> @@ -63,6 +71,14 @@ properties:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>>      description: GPIO pin connected to enable pin on VTT regulator
>>  
>> +  ti,set-io-isolation:
>> +    type: boolean
>> +    description:
>> +      If this property is present, then the wkup_m3_ipc driver will instruct
>> +      the CM3 firmware to activate IO isolation when suspending to deep sleep.
>> +      This can be leveraged by a board design to put other devices on the board
>> +      into a low power state.
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -74,21 +90,63 @@ additionalProperties: false
>>  
>>  examples:
>>    - |
>> +    /* Example for AM335x SoC */
>>      soc {
>>          #address-cells = <1>;
>>          #size-cells = <1>;
>>  
>> -        mailbox: mailbox {
>> +        am335x_mailbox: mailbox {
>>              #mbox-cells = <1>;
>>          };
>>  
>> -        wkup_m3_ipc: wkup_m3_ipc@1324 {
>> +        wkup_m3_ipc@1324 {
>>             compatible = "ti,am3352-wkup-m3-ipc";
>>             reg = <0x1324 0x24>;
>>             interrupts = <78>;
>>             ti,rproc = <&wkup_m3>;
>> -           mboxes = <&mailbox &mbox_wkupm3>;
>> +           mboxes = <&am335x_mailbox &mbox_wkupm3>;
>>             ti,vtt-gpio-pin = <7>;
>>          };
>>      };
>> +
>> +  - |
>> +    /*
>> +     * Example for AM473x SoC:
>> +     * On the AM437x-GP-EVM board, gpio5_7 is wired to enable pin of the DDR VTT
>> +     * regulator. The 'ddr_vtt_toggle_default' pinmux node configures gpio5_7
>> +     * for pull-up during normal system operation. However, the DS0 (deep sleep)
>> +     * state of the pin is configured for pull-down and thus the VTT regulator
>> +     * will be disabled to save power when IO isolation is active. Note that
>> +     * this method is an alternative to using the 'ti,vtt-gpio-pin' property.
>> +     */
>> +    #include <dt-bindings/pinctrl/am43xx.h>
>> +    soc {
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        am437x_mailbox: mailbox {
>> +            #mbox-cells = <1>;
>> +        };
>> +
>> +        am43xx_pinmux {
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&ddr3_vtt_toggle_default>;
>> +
>> +            ddr3_vtt_toggle_default: ddr_vtt_toggle_default {
>> +                 pinctrl-single,pins = <
>> +                    0x25C (DS0_PULL_UP_DOWN_EN | PIN_OUTPUT_PULLUP | DS0_FORCE_OFF_MODE | MUX_MODE7)
>> +                 >;
>> +            };
>> +        };
>> +
>> +        wkup_m3_ipc@1324 {
>> +           compatible = "ti,am4372-wkup-m3-ipc";
>> +           reg = <0x1324 0x24>;
>> +           interrupts = <78>;
>> +           ti,rproc = <&wkup_m3>;
>> +           mboxes = <&am437x_mailbox &mbox_wkupm3>;
>> +           ti,set-io-isolation;
>> +        };
>> +    };
>> +
>>  ...
>> -- 
>> 2.32.0
>>
>>
