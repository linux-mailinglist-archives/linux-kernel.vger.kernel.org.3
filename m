Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D415079A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356335AbiDSTDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357545AbiDSTCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:02:38 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B56B1C6;
        Tue, 19 Apr 2022 11:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1650394759; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gyMpKPwcZ56A0saJrbnZ2SGeHNdFwrYWpbLGx4k4y84R17oVRQmnonieJVIHPZpah0c+9Qe9fe5lGD40v6XI/ZyJiowh3uclK+QF2JHzb8FtQ2SIvVRXNWyvWTcErBlJ03VmPx4ziJEoK7gzu+IjbFe4u1VfLzgjX01c3cgeuWA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1650394759; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9VjwSH0I9W/DB4x/BmRW3flCPs5gbLidfDoHgiRZ19E=; 
        b=f6z9mss4D2oQa/Pxv8nau+aVX/wXNvFKkZ2pb3n/X1hdAY2DE7hM3rmJOcKopNrqwAVAduWPu3k85etTGQn7W5AScEzGa17M2Y9wZxB9QcJQoPBpd8pWxPMi+BS7rcxMtAsK/OXKYPPBmr3U3lQewiXFzGa2yij/uUOk5HLNcjg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1650394759;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=9VjwSH0I9W/DB4x/BmRW3flCPs5gbLidfDoHgiRZ19E=;
        b=NV9Zgjw9a55SlOkSW+AhfsTH1oRAcNtDgGFThRtVAYI3uMCpWbSZWXl7XYg+dh8B
        00+vebYCpTFhaEq2CGoN+vuXKoUTSHODXOcHOQYZMD6Y2ooUO2JscEFDilh5jsQgICZ
        /LeNWbe4Cn6ZCfpYIslKePnYJm/XkB/Z2ChOEkxo=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 165039475819462.97284354678186; Tue, 19 Apr 2022 11:59:18 -0700 (PDT)
Message-ID: <4c84c9ce-be19-ee34-d9d0-e69495722b01@arinc9.com>
Date:   Tue, 19 Apr 2022 21:59:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 13/14] dt-bindings: pinctrl: add binding for Ralink
 RT305X pinctrl
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>, erkin.bozoglu@xeront.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
 <20220414173916.5552-14-arinc.unal@arinc9.com>
 <Yl758u9iIMnhYPz2@robh.at.kernel.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Yl758u9iIMnhYPz2@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 21:05, Rob Herring wrote:
> On Thu, Apr 14, 2022 at 08:39:15PM +0300, Arınç ÜNAL wrote:
>> Add binding for the Ralink RT305X pin controller for RT3050, RT3052,
>> RT3350, RT3352 and RT5350 SoCs.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   .../pinctrl/ralink,rt305x-pinctrl.yaml        | 92 +++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..425401c54269
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
>> @@ -0,0 +1,92 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/ralink,rt305x-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ralink RT305X Pin Controller
>> +
>> +maintainers:
>> +  - Arınç ÜNAL <arinc.unal@arinc9.com>
>> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>> +
>> +description:
>> +  Ralink RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
>> +  SoCs.
>> +  The pin controller can only set the muxing of pin groups. Muxing individual
>> +  pins is not supported. There is no pinconf support.
>> +
>> +properties:
>> +  compatible:
>> +    const: ralink,rt305x-pinctrl
> 
> You should have a compatible for each SoC unless these are all just
> fused or package varients of the same chip.

The rt305x pin controller calls code from 
arch/mips/include/asm/mach-ralink/rt305x.h to determine the SoC and uses 
different pinmux data by the result of the determination.

I guess we can call this fused.

Arınç
