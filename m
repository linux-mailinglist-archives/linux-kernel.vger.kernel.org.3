Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9FF50E8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244695AbiDYSup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244621AbiDYSuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:50:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D15372E28;
        Mon, 25 Apr 2022 11:47:04 -0700 (PDT)
Received: from [IPV6:2a00:23c7:6883:e501:cf51:f3a2:10b5:accf] (unknown [IPv6:2a00:23c7:6883:e501:cf51:f3a2:10b5:accf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 32C671F42FFF;
        Mon, 25 Apr 2022 19:47:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650912423;
        bh=GsF4PA6CVkBTkoQKSTNYtMWwQMXprSnuSY5mmmiZGNw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZklSte8+3eZnlheanzGcfBd50w0HqQ8uMGyPCyFe6IaAZ+1jzBncV7Xi8jBfEQN29
         t6IS4bzHpBIiqexEVnFB24sGATNLmi/DiqqW9zYvot24zitqCkfQ2HbjPsYJofcn4O
         /ZIGGoDbsq+SNeMJtw8T0U0PswczvI2qcsgNDO6z9ysjoMGJ+tSGQCv7RYef7Dxmvo
         snY9qUtEtBRZsnC/aUQ2+9h53bj7TgAUQDhaZh1avmYADNWKhSBhx69U2GhOT9LjTD
         6/M8ZERD6Q+fAfgmmIDeytbf+tLWzSFcbd5aUifiqhKCAd5/zOVr52qQkhYpjYlM1e
         HBWzIDzAIOVOw==
Message-ID: <7ac887aa-5949-0c2f-b510-d145ee50c32c@collabora.com>
Date:   Mon, 25 Apr 2022 19:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] media: dt-bindings: media: rockchip-vdec: Add
 RK3328 compatible
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220425123215.1055251-1-chris.obbard@collabora.com>
 <20220425123215.1055251-2-chris.obbard@collabora.com>
 <2c347033-bd63-05a8-94fb-2eb467e63e76@linaro.org>
From:   Christopher Obbard <chris.obbard@collabora.com>
In-Reply-To: <2c347033-bd63-05a8-94fb-2eb467e63e76@linaro.org>
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


On 25/04/2022 19:07, Krzysztof Kozlowski wrote:
> On 25/04/2022 14:32, Christopher Obbard wrote:
>> Document the RK3328 compatible for rockchip-vdec.
>>
>> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/media/rockchip,vdec.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
>> index 089f11d21b25..ce06835e8d61 100644
>> --- a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
>> +++ b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
>> @@ -20,6 +20,9 @@ properties:
>>         - items:
>>             - const: rockchip,rk3228-vdec
>>             - const: rockchip,rk3399-vdec
>> +      - items:
>> +          - const: rockchip,rk3328-vdec
>> +          - const: rockchip,rk3399-vdec
> 
> 
> This should be rather an enum with rk3228, so:
> - enum
>     - rockchip,rk3228-vdec
>     - rockchip,rk3328-vdec
> - const: rockchip,rk3399-vdec


Thanks for your patience with reviewing the series. I sent v3 which 
should finally solve this now.

Cheers!

Chris
