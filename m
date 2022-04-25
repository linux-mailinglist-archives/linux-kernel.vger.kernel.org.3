Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A58650DD4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiDYJ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbiDYJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:57:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDADC1AF1A;
        Mon, 25 Apr 2022 02:53:59 -0700 (PDT)
Received: from [IPV6:2a00:23c7:6883:e501:cf51:f3a2:10b5:accf] (unknown [IPv6:2a00:23c7:6883:e501:cf51:f3a2:10b5:accf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4A7021F44585;
        Mon, 25 Apr 2022 10:53:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650880438;
        bh=VBMc9dIEE785nVs3jdcNupByvEPldz01DvtMEbOIyyI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ij1WYP9D2ZHcuq8b3qLpKQ8MV4gdm4BeswTuBmmjTbTDl+JrdaXXBC7VvxLR+xn2v
         ddZrrI/HItZ//PKLh82rCb2AChunncCjLJcnpDZ6Xq1fPWecwwdsnTVIo8LjxDlbXg
         Dyoxvup/DDgy/SYK4w+yrSbnayParbZl1VlrDQ+qCVhMAEXjK0Q1ve4fjNuLbrA8ah
         a6TzaGR8kS7l+dO1Mb/n4H17zQUUulYa+S9GviBVmR/Rs+mVYHqqjf+BYp0+Hr0eBs
         48g+6wJAAiI0MDcvEHTqt3lkUoXYqky3s3JYdv8UJiW/FC2mPjX1VeA+1LQ3R2ujsh
         jyziZBWtRcL/g==
Message-ID: <366fe755-6f07-499a-0b19-f046fd03c89a@collabora.com>
Date:   Mon, 25 Apr 2022 10:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] media: dt-bindings: media: rockchip-vdec: Add RK3328
 compatible
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Alex Bee <knaerzche@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220422133803.989256-1-chris.obbard@collabora.com>
 <20220422133803.989256-2-chris.obbard@collabora.com>
 <ff87d5cb-b0d4-95a2-90b0-7827a2a34d05@linaro.org>
 <34819690-5cb7-bbce-a2f5-3f6e66661049@linaro.org>
From:   Christopher Obbard <chris.obbard@collabora.com>
In-Reply-To: <34819690-5cb7-bbce-a2f5-3f6e66661049@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/04/2022 18:31, Krzysztof Kozlowski wrote:
> On 23/04/2022 13:10, Krzysztof Kozlowski wrote:
>> On 22/04/2022 15:38, Christopher Obbard wrote:
>>> Document the RK3328 compatible for rockchip-vdec.
>>>
>>> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
>>> ---
>>>   Documentation/devicetree/bindings/media/rockchip,vdec.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I acked this but Johan pointed out that your intention was different and
> missing patch context is quite important here. Please explain what
> exactly you wanted in the patch? Now it looks actually wrong, so my ack
> is not correct.

Wow - I think i was in weekend mode and forgot to run dtbs_check ;-).
It will be solved in v2. I have now added the check to my "pre 
send-patch" review checklist.

Just out of interest, I didn't get a mail from Johan and I can't seem to 
find it the archive either. Is that message in public as I'd like to 
address any other concerns at the same time ?

Cheers!
Chris
