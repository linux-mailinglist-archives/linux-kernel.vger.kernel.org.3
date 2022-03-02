Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760AC4CA4DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241797AbiCBMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbiCBMcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:32:41 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D86212C;
        Wed,  2 Mar 2022 04:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zs30rfcp9Gy4eJZTj0VHE0zYlF+YvSpqPJY+NDZEYbQ=; b=UUTGwTkeNLZrsWztZAVHFKWbag
        mghQYTZlvPjb4FN4MLAnP6GihRzwI+TJBnDNClIiajEHBC7JdWRUYGLHfi6TxGllLez/0oIIAJU8K
        q7YHlVx9JkDBJLAOZXnHujwAED4tjQDplKkOaPng/B60rGnXAqtXztQq9iaJGjAjWOsi7XUM3SKKr
        iPP8zgnmXrJ40CLUIrmGb852hMqt7ItWxEPzbXzRRQbV8cny5ANiwfQKpHwlljH17brygcWa4K71o
        0AbKmnfOw/QUhc99QJiKykKala7dZO/LplW+jorpooSnXx2jkI/Zq0Ak+e6AYaGG+yBwb+3G0BxZ6
        AJc2KK1Q==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nPO8x-00023j-D7; Wed, 02 Mar 2022 14:31:47 +0200
Message-ID: <3466cb33-7f5c-7b57-85f8-387e93516432@kapsi.fi>
Date:   Wed, 2 Mar 2022 14:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 1/9] dt-bindings: host1x: Add iommu-map property
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220301161455.4037062-1-cyndis@kapsi.fi>
 <20220301161455.4037062-2-cyndis@kapsi.fi>
 <4a748c85-4fdb-0c10-19d8-0379b9e42ab5@arm.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <4a748c85-4fdb-0c10-19d8-0379b9e42ab5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 20:12, Robin Murphy wrote:
> On 2022-03-01 16:14, cyndis@kapsi.fi wrote:
>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>
>> Add schema information for specifying context stream IDs. This uses
>> the standard iommu-map property.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>> v3:
>> * New patch
>> v4:
>> * Remove memory-contexts subnode.
>> ---
>>   .../bindings/display/tegra/nvidia,tegra20-host1x.yaml        | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml 
>> b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml 
>>
>> index 4fd513efb0f7..0adeb03b9e3a 100644
>> --- 
>> a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml 
>>
>> +++ 
>> b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml 
>>
>> @@ -144,6 +144,11 @@ allOf:
>>           reset-names:
>>             maxItems: 1
>> +        iommu-map:
>> +          description: Specification of stream IDs available for 
>> memory context device
>> +            use. Should be a mapping of IDs 0..n to IOMMU entries 
>> corresponding to
> 
> Nit: maybe "context IDs 0..n" for maximum possible clarity?

I left it at "IDs" since there is no "context ID" or similar concept in 
the hardware, so I thought to leave it just as a kind of an 'abstract ID 
as used in iommu-map property'.

> 
> Either way, though, I'm happy that if the simplest and most 
> straightforward approach works, then it's the best choice.

I am happy as well, this is certainly much cleaner than the mess in the 
downstream driver :)

> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Cheers,
> Robin.

Thanks!
Mikko

> 
>> +            usable stream IDs.
>> +
>>         required:
>>           - reg-names

