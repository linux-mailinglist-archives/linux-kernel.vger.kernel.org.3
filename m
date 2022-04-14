Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6450081D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbiDNITb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDNITa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:19:30 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A7F49F0A;
        Thu, 14 Apr 2022 01:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649924196; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=AsbspUXkFkn8IT+0dQO6+nAUIXZBWkX3UudduNXGRNXTpwpnad/24gTpkZXU4e6kWLvaXBOd/lXqB01ovdbEgANQtvnESnkRDfYFuKhg2SSP4d/EP9pz65ddBIJNdyc+dzYuysdpUxSAmO7Eqh2iQltHsZvJqWTJlD6reeyq8NM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649924196; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=DX3FsxaeKDI941g7IHym5WqsNB7za3Lzp+oTtlBrdg0=; 
        b=VwazXdxxgsDKh5PXsOfE7N4+KzRmOBXQMiVIWkJevXYM+/0pQv23rogmj3atN9ktfwu4KlwVI9aXCshk+2M53vfd+GKuGdiUKGFaveHFX1Ap1R1gyER/F2oJOOs1LQHCJjiU6DNwLWEn5oK3zl4MAy4p97STQwg+4/Y9aUlx/Hw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649924196;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=DX3FsxaeKDI941g7IHym5WqsNB7za3Lzp+oTtlBrdg0=;
        b=ezOkLB+TYbDZluCEVnRi6RdNfdJBhCMxcsg4a//QBZID7wwzpWbfkbzstNRnWgtG
        sOk3kAm0FrDmrWAEG996iSmrMTmmlk1OIGMYSpX53Vi7pbnqj6r2Xa7NvFepsC3paGc
        bikhviBTfHCnxO8C3+s1dvim9mleWqsUql/olEkg=
Received: from [10.10.10.3] (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649924194390779.7996201062704; Thu, 14 Apr 2022 01:16:34 -0700 (PDT)
Message-ID: <1023e28e-6523-ea3a-7ac7-fe1d08e5e67f@arinc9.com>
Date:   Thu, 14 Apr 2022 11:16:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 11/14] dt-bindings: pinctrl: add binding for Ralink MT7620
 pinctrl
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     erkin.bozoglu@xeront.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
 <20220413060729.27639-12-arinc.unal@arinc9.com>
 <41fa58ee-728b-7f0d-eea7-448c59641d85@linaro.org>
 <0dd1da16-232b-d634-3146-bf91e58c9543@arinc9.com>
 <02953ce1-0a43-5918-d139-35afd5f15b5b@linaro.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <02953ce1-0a43-5918-d139-35afd5f15b5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 09:33, Krzysztof Kozlowski wrote:
> On 14/04/2022 03:52, Arınç ÜNAL wrote:
>>>
>>>> +  is not supported. There is no pinconf support.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: ralink,mt7620-pinctrl
>>>> +
>>>> +patternProperties:
>>>> +  '-pins$':
>>>> +    type: object
>>>> +    patternProperties:
>>>> +      '^(.*-)?pinmux$':
>>>
>>> Why do you have two levels here? pins->pinmux->actual pin configuration?
>>
>> Yes, pins->pinmux->pin-configuration is currently how it's done.
> 
> It is currently done? Aren't you bringing here new bindings and new
> driver support?

I'm submitting bindings for the existing subdrivers. There's nothing new 
but refactoring and submitting the missing bindings.

Cheers.
Arınç
