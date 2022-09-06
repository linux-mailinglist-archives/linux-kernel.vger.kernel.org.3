Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7845AE55C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiIFKaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiIFKaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:30:17 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B428E30;
        Tue,  6 Sep 2022 03:30:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 286AU28L084731;
        Tue, 6 Sep 2022 05:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662460202;
        bh=NcoemCXH05TY9ODveI/RTyU7+TLIkOHYkpTRhi9iocQ=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=earOJCEJxSh7heXTUJ1w73TdC+nrjoFIkLqLle32pQAZlBqzgyX8o0AFKeIGjgce9
         WRGwQ2ccQNkf0OnW4X8s/azozWBi3CzIRvECKslZzNis4x/6HOIpDyAg5QVHFmEkhI
         Pkq2qcmRyvrE12I6f2oFcF7oKzQH48DHqPdrZxxM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 286AU1YJ010551
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Sep 2022 05:30:02 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 6 Sep
 2022 05:30:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 6 Sep 2022 05:30:00 -0500
Received: from [10.24.69.241] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 286ATuM5105135;
        Tue, 6 Sep 2022 05:29:57 -0500
Message-ID: <4c34dcba-0a30-164f-49bb-1cf22781a4b2@ti.com>
Date:   Tue, 6 Sep 2022 15:59:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
CC:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <20220901085506.138633-1-s-vadapalli@ti.com>
 <20220901085506.138633-2-s-vadapalli@ti.com>
 <4b681c03-7f5a-0234-2276-316e0bad1de5@linaro.org>
 <44339382-c4e2-26db-de5d-263ae5a585b8@ti.com>
 <4e61b63b-74ac-1682-968f-17e5d8db7ce6@linaro.org>
 <dfa9e613-054e-cffc-747f-27842e825cc8@ti.com>
 <93600263-0211-9286-9043-fae5b017d15b@linaro.org>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <93600263-0211-9286-9043-fae5b017d15b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 06/09/22 12:33, Krzysztof Kozlowski wrote:
> On 06/09/2022 07:02, Siddharth Vadapalli wrote:
>>>>
>>>> Please let me know if the above description is fine.
>>>
>>> Hm, but that's a phy node, not address of register... Isn't this a phy
>>> node representing the phy of the CPSW MAC ports?
>>
>> Despite it being a phy node, the phy-gmii-sel driver actually uses this
>> node to obtain the address of the CTRLMMR_ENETx_CTRL registers which
>> correspond to the CPSW MAC configuration and are therefore unrelated to
>> the PHY. Please let me know if my suggested description would be fine.
> 
> Either I miss some more pieces or this is wrong design. The phy node
> should not be used to pass some addresses somewhere. It is used to
> define a device which will be instantiated (as parent is simple-mfd). If
> you use it only to obtain some address, not to describe child device,
> then this is wrong property type.

Sorry for describing it incompletely, and at some places incorrectly.
Yes, you were right when you initially mentioned that the phy node
corresponds to the phy of the ethernet MAC ports. I had incorrectly
understood the term "phy" there as the external Layer-1 ethernet phy.The
phy node corresponds to the phy used by the ethernet MAC, based on the
phy-mode configured. The am65-cpsw-nuss driver which is responsible for
ethernet MAC, requires the ethernet MAC's phy to be configured by the
phy-gmii-sel driver. Thus, the phy node corresponds to an actual phy
(ethernet MAC's PHY).

I plan on updating the description for the phy pattern property to the
following:
"The phy node corresponding to the ethernet MAC."

Regards,
Siddharth.
