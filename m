Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACA568A67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiGFOAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiGFOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:00:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BB51F2D7;
        Wed,  6 Jul 2022 06:59:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 090DC660186F;
        Wed,  6 Jul 2022 14:59:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657115998;
        bh=hlSoJlMQ1wNrpKuPTKn+3MdUzD6VbIFbGoYJHvb0jKU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X9+ALsZmAkZHB57bQsEqs/yp/DtoHi+5edpM+LAwaBt2OVVBP/IlUYu+L52n3To7z
         R3jSDTxLpQcdkUD/oM3E9Iqe12UPRPe8qdAiAqFDv0P+YEbsphVdVxhtMsfzMpL36u
         Zli3i5AdW3v8EfJEckF5TQ4fi+lr9njpbTpjQ0M6ZzXhTDjBEAKQTwnB6aomuRjQNT
         FoPAn52JK414APBY+eBHYAT/hjh1qJfNG22hkWRhU4ujNkeYo+WOnfL5qLPZldKL/I
         blCDOZYR/NFIhT3uaIK4onFqjOdbDQ455gBYC8FOkWa3KJNMVO7jh68GeDWgB6oWCr
         d0hUXXTkUbQbw==
Message-ID: <a7c7e807-5489-c731-224f-a4b681952917@collabora.com>
Date:   Wed, 6 Jul 2022 15:59:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 RESEND 0/4] MediaTek Helio X10 MT6795 - MT6331/6332
 Regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lee.jones@linaro.org
References: <20220706100912.200698-1-angelogioacchino.delregno@collabora.com>
 <YsV9IerWCoa/xtwM@sirena.org.uk>
 <57367b11-f2d4-476b-b92d-16c1726316c0@collabora.com>
 <YsWG0jfqAf4EqojE@sirena.org.uk>
 <82736173-b3b8-1e1a-3e2e-25d9ca3287eb@collabora.com>
 <YsWTt3YSHI9LLpnw@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YsWTt3YSHI9LLpnw@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/22 15:52, Mark Brown ha scritto:
> On Wed, Jul 06, 2022 at 03:38:34PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 06/07/22 14:57, Mark Brown ha scritto:
>>> On Wed, Jul 06, 2022 at 02:49:56PM +0200, AngeloGioacchino Del Regno wrote:
>>>> Il 06/07/22 14:16, Mark Brown ha scritto:
>>>
>>>>> This previously got 0day failures due to missing dependencies which
>>>>> need would need a merge with IIRC MFD, I see no reference in the cover
>>>>> letter to dependencies?
>>>
>>>> The only blocker for this series was the MFD patch, which got picked and
>>>> it's present in next-20220706 (as you suggested me to resend when things
>>>> were picked... I decided to wait until they actually landed on -next...)
>>>
>>> Right, I also said I'd need a pull request - if I apply the patches
>>> without having the MFD bits they depend on in my tree then it will fail
>>> to build.
>>
>> I remember writing that to Lee... how do we proceed in this case?
>> Should we add him to the Cc's of this patch to notify him or..?
> 
> Lee, Angelo has sent me this series for Helio X10 which needs some MFD
> bits (not 100% sure which, I guess Angelo can fill that in) - is there a
> tagged branch available to pull in?


(Thank you, Mark!)

The required bits are all in just one commit:

https://patchwork.kernel.org/project/linux-mediatek/patch/20220627123954.64299-1-angelogioacchino.delregno@collabora.com/

Landed on next-20220706 with ID ad7f984a6aa9722443c1db9e8f72609bf06a8910

...which can be also found here:
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next
