Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A7953C6C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242732AbiFCILM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiFCILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:11:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CEC39BAD;
        Fri,  3 Jun 2022 01:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4A6618A6;
        Fri,  3 Jun 2022 08:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B6FC385A9;
        Fri,  3 Jun 2022 08:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654243866;
        bh=Zuuk2BFVHgqDOOa0QhgsL7oMb1UanVQf4pSgQrJ1+Yc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pC6sPxW10xp5d6NbjNTP9uVQMFtPrPxrSK5++FIMLhOiJW0K7crEjfOxs0pKtI3PX
         x0ZvxvdiRswtoNXw1GTxO2aiNXTS1PHELoxFjgGwv+nSO1bURbYObrU9k14qMxlFvE
         Kwix7caDE6ppeKL6tL9SGba7cRdavQRdBCX9too9nBDxgHLYIIjtAMsNXoeEDKzuO1
         GGDlL9g01LeTQO7a+8qjEWejZX2jbP2V1M01zHhtAFiHZF9Ka23CwSHtHhVBf3bEQl
         8vK/SLtGqwEYPkz+Lf6K8AyuLtyY19GAci2w1UXMXtjxxc18OXF+5bX0I8cXgm+BCB
         v/YFvmZpayfvg==
Message-ID: <5bf638ee-6cc8-d5cb-5795-a840d8d2bb87@kernel.org>
Date:   Fri, 3 Jun 2022 11:11:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/5] dt-bindings: remoteproc: Add PRU consumer bindings
Content-Language: en-US
To:     Puranjay Mohan <p-mohan@ti.com>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com,
        vigneshr@ti.com, kishon@ti.com
References: <20220418104118.12878-1-p-mohan@ti.com>
 <20220418104118.12878-2-p-mohan@ti.com> <YnA3dtaqptLgZBrV@robh.at.kernel.org>
 <6c054a1b-2842-a6f0-733a-92cfda76f828@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <6c054a1b-2842-a6f0-733a-92cfda76f828@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Puranjay,

On 02/06/2022 08:28, Puranjay Mohan wrote:
> Hi Rob,
> 
> On 03/05/22 01:26, Rob Herring wrote:
>> On Mon, Apr 18, 2022 at 04:11:14PM +0530, Puranjay Mohan wrote:
>>> From: Suman Anna <s-anna@ti.com>
>>>
>>> Add a YAML binding document for PRU consumers. The binding includes
>>> all the common properties that can be used by different PRU consumer
>>> or application nodes and supported by the PRU remoteproc driver.
>>> These are used to configure the PRU hardware for specific user
>>> applications.
>>>
>>> The application nodes themselves should define their own bindings.
>>>
>>> Co-developed-by: Tero Kristo <t-kristo@ti.com>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>>> ---
>>>  .../bindings/remoteproc/ti,pru-consumer.yaml  | 70 +++++++++++++++++++
>>>  1 file changed, 70 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>>> new file mode 100644
>>> index 000000000000..5b1f1cb2f098
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>>> @@ -0,0 +1,70 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Common TI PRU Consumer Binding
>>> +
>>> +maintainers:
>>> +  - Suman Anna <s-anna@ti.com>
>>> +
>>> +description: |
>>> +  A PRU application/consumer/user node typically uses one or more PRU device
>>> +  nodes to implement a PRU application/functionality. Each application/client
>>> +  node would need a reference to at least a PRU node, and optionally define
>>> +  some properties needed for hardware/firmware configuration. The below
>>> +  properties are a list of common properties supported by the PRU remoteproc
>>> +  infrastructure.
>>> +
>>> +  The application nodes shall define their own bindings like regular platform
>>> +  devices, so below are in addition to each node's bindings.
>>> +
>>> +properties:
>>> +  ti,prus:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description: phandles to the PRU, RTU or Tx_PRU nodes used
>>> +    minItems: 1
>>> +    maxItems: 6
>>> +    items:
>>> +      maxItems: 1
>>> +
>>> +  firmware-name:
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>> +    description: |
>>> +      firmwares for the PRU cores, the default firmware for the core from
>>> +      the PRU node will be used if not provided. The firmware names should
>>> +      correspond to the PRU cores listed in the 'ti,prus' property
>>
>> So should be the name number of entries?:
>>
>> minItems: 1
>> maxItems: 6
> 
> will add in v4
> 
>>
>>> +
>>> +  ti,pruss-gp-mux-sel:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>
>> minItems: 1
> 
> will add in v4
> 
>>
>>> +    maxItems: 6
>>> +    items:
>>> +      enum: [0, 1, 2, 3, 4]
>>> +    description: |
>>> +      array of values for the GP_MUX_SEL under PRUSS_GPCFG register for a PRU.
>>> +      This selects the internal muxing scheme for the PRU instance. Values
>>> +      should correspond to the PRU cores listed in the 'ti,prus' property. The
>>> +      GP_MUX_SEL setting is a per-slice setting (one setting for PRU0, RTU0,
>>> +      and Tx_PRU0 on K3 SoCs). Use the same value for all cores within the
>>> +      same slice in the associative array. If the array size is smaller than
>>> +      the size of 'ti,prus' property, the default out-of-reset value (0) for the
>>> +      PRU core is used.
>>> +
>>> +required:
>>> +  - ti,prus
>>> +
>>> +dependencies:
>>> +  firmware-name: [ 'ti,prus' ]
>>> +  ti,pruss-gp-mux-sel: [ 'ti,prus' ]
>>
>> This doesn't make sense because 'ti,prus' is already required. Should 
>> all 3 properties always be required?
> 
> All three of these are always required, so, I will remove the

Are you sure? It should not be required and remoteproc driver should use
default name if not provided in DT.
In patch 5 see what is being done in pru_rproc_get().
It doesn't error out if firmware-name is not provided.

Same for ti,pruss-gp-mux-sel. Did you miss the patch that adds support for this
in this series?

> "dependencies:" tag and add all three of them to "required:" in v4
> Will it be the correct way to do it?
> 
>>
>>> +
>>> +additionalProperties: true
>>> +
>>> +examples:
>>> +  - |
>>> +    /* PRU application node example */
>>> +    pru-app {
>>> +        ti,prus = <&pru0>, <&pru1>;
>>> +        firmware-name = "pruss-app-fw0", "pruss-app-fw1";
>>> +        ti,pruss-gp-mux-sel = <2>, <1>;
>>
>> This example never validates, but okay I guess.
>>
>>> +    };
>>> -- 
>>> 2.17.1
>>>
>>>
> 
> Thanks,
> Puranjay Mohan

cheers,
-roger
