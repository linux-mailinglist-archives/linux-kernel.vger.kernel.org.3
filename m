Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7AB57A655
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbiGSSSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiGSSSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:18:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E264E630
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:18:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o7so26257907lfq.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L1Nb0zh4ARUsCff9U60Czkk0oDFcczHT1EIsSWvyea0=;
        b=Pb9pjtR5OkQ9+MzbqKUzq2B2A0hhhlY7I6X4YQwoK5F4ANZYPjLIoZxKqYfGTYfbpY
         66AD2XM+WwdrWVQ7Rdo0orzKbBIIKu3j1iYF7woFF158jCQSZPnbhP4FQCuVpBgnlu/4
         9kyro3WL8Ic3DJHd8OQlw4eBED9TunUWF1Ae+y0suhBDrEynsvJSyE7IhjlJ2ZSV3lqN
         g1Hc9GQWCqkqcHJEYZiGDHGeZRUqQpgsYhwB/uqkQxLlxkgDgNKY3TtkwWOv22qX5sbw
         8wIC5AGxGUEaYxiMyE8gZk5nf3KFw5MYx7AHDFBmNjXPBbOsr1GaKhVH8LiQqmMSxvMi
         VHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L1Nb0zh4ARUsCff9U60Czkk0oDFcczHT1EIsSWvyea0=;
        b=msCeF/H29MXjhomMbEUxs+COWDKprwlNnaA5zpuX3qUjvtXoahu3BzbH/OTNbB6015
         ZhMADivJbSRJKoMG++/mYhmQJ0aiNqT1hjX+X8c726eyPrCbkQoBNNNP+1s5nMHz1Uo0
         EOags60ex8An1PdTIsOngDO1WJIP2HyKmf5y0eqXPUlZM5Z65/J0R2ltf+BVDxkzMhpU
         1dDojlJIcq9oFWTDgccw9vFerfh28PRpTV5xYIlBAsNF25XWFIYotCrlEiFroj9Icchq
         uUjc5OJJlqGNHoJYbZXwxUQizS1SIuWuYoJw1Ue2TU3LYKjQ6tktPFnffufzS7NrPefE
         zSdg==
X-Gm-Message-State: AJIora+TKUKKUr4udu5HSpmOkAhKHpLVso9elFQFknfWaP5BBXNYh/7F
        Z9UjS1rNY4EV/483v1Jx5EE0zg==
X-Google-Smtp-Source: AGRyM1tjKIZl34mrzZ0U9cKQip/P1C+vRjH8ZHQimiHqDz2B4qRQNCIPLyhvrnUvI1sT3QZgirsdFA==
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id y15-20020a0565123f0f00b0047f6f890326mr17266009lfa.124.1658254712122;
        Tue, 19 Jul 2022 11:18:32 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512358e00b00489c59819ebsm3333736lfr.66.2022.07.19.11.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:18:31 -0700 (PDT)
Message-ID: <b0f17207-8f6d-77b9-3030-e2429a951a71@linaro.org>
Date:   Tue, 19 Jul 2022 20:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: Add device trees for MSC SM2S-IMX8PLUS SoM
 and carrier board
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220718152310.1937899-1-martyn.welch@collabora.com>
 <4473378f-1c14-3ec7-5380-12f49f3b1e3b@linaro.org>
 <abd2e9affdc3e4001f9fc6f036516ddfa6654bdd.camel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <abd2e9affdc3e4001f9fc6f036516ddfa6654bdd.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 18:37, Martyn Welch wrote:
> On Tue, 2022-07-19 at 12:01 +0200, Krzysztof Kozlowski wrote:
>> On 18/07/2022 17:23, Martyn Welch wrote:
>>> Add device trees for one of a number of MSCs variants of the SM2S-
>>> IMX8PLUS
>>> system on module along with the compatible SM2S-SK-AL-EP1 carrier
>>> board.
>>> As the name suggests, this family of SoMs use the NXP i.MX8MP SoC
>>> and
>>> provide the SMARC module interface.
>>>
>>> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>>
>> Use subject prefix matching subsystem. I expect other folks in
>> Collabora
>> help you in that, so you do not need our advices for such trivial
>> stuff. :)
>>
> 
> Hi Krzysztof,
> 
> Thanks for the review.
> 
> I picked that based on the last 20-30 commits under
> arch/arm64/boot/dts/. Would you prefer something starting "arm64: dts:
> freescale: "? I see that "arm64: dts: imx8mp: " is typically being used
> for changes to the more generic imx8mp device trees...

git log --oneline --
gives you three popular answers (where first seems the most popular):
arm64: dts: board-name:
arm64: dts: freescale:
arm64: dts: freescale: board-name:

> 
>>> +       extcon_usb0: extcon_usb0 {
>>
>> No underscores, extcon is Linux term, so use node name describing
>> device.
>>
> 
> I note that the device binding file lists an example using
> "extcon_usb1". I also note that existing users seem to broadly use a
> variation of "extcon-XXXX", would "extcon-usb0" be acceptable in this
> case?

It still uses extcon, so a Linux driver name not hardware, but I don't
have other idea, at the moment.

Best regards,
Krzysztof
