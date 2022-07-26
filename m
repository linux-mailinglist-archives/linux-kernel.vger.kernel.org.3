Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30C3580C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiGZHBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiGZHBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:01:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BED11A19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:01:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p10so13806433lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RG0eN8uugCKRz93pQEqk4v9hZKegHu0Xn8eqAPlANXM=;
        b=Q/Pa9+OqvMWvsr8FKS29W1/x++0soBsoOpkQtTWk50O6vSfj04stb+WwA9lJeQBMzM
         kLfyld/HkWiyRdxoyYT9PuqWQI8cKlImyLDJ8+QM97NDx1VK87g3vMrhm9NG8h1Oh2Qc
         6Hk/29fDyzWjZo2rQTTrA9TpO/OdCkW2UOtyXldvlEvfHuhvKX0VI9kobmSUqXU3IEqu
         DAhV62OBs6iaUCNVfRL7SRk1nwOIkNPsRzfVypWlJftoFoj3haQZrLNLb+5Ov8ste64K
         25wuwSB1qr3z1a8t+f/xfAdMqx1cI/7tVDR90fcvhfVRkxUyX6zb4SduUDZSawFcH2gk
         RUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RG0eN8uugCKRz93pQEqk4v9hZKegHu0Xn8eqAPlANXM=;
        b=v1KOubjPDZynJv4l6sdZHSgV3cGFT+CodGEwn+sD9tc1H+/TVP5fQGl9QguptR2c72
         DccFB85LSnl3t/yzDZMo13N9jaFuwFa5m28/F9Mqelcu0bQuThPb/naHjpNXk7qvtrPC
         XidTgVi+d4SuVt0kgbEwgCcBYiliQJDNJlCSPMn2MQkgFeGPM18nXAjC2aibItIDNexr
         BNfGQTeuKBXmqgrcduMGugrCmkIG6WNRYsexufJLGV1tJJ8SYclKDDqMyEhBY7GVGfpx
         EjIIUZl/9e8fLIbQ1ntjymrVCY/KK++SNbH5j8Bqkq6uTzobvU9DtBzYEDf/j5g568CS
         hudA==
X-Gm-Message-State: AJIora8nbEYp7gYf/2YhkLiZLf/TyzEWXWm73fltYSYGM953EIC8xN+k
        dVugzuQeOTYKfE0HIrkbHinZAg==
X-Google-Smtp-Source: AGRyM1ty3nycRLWrjVL77zZCn5D+xEhjzPTp/HZ2Rkm60PM3b09A5OeL6AyY3IHHhxeQ2D+tdFWPRw==
X-Received: by 2002:a05:6512:16a1:b0:48a:87a2:103c with SMTP id bu33-20020a05651216a100b0048a87a2103cmr4144577lfb.554.1658818908940;
        Tue, 26 Jul 2022 00:01:48 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id f11-20020a056512360b00b0048aa0531c97sm226279lfs.17.2022.07.26.00.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 00:01:48 -0700 (PDT)
Message-ID: <340a4a81-d4ec-2f42-28ae-49124830157a@linaro.org>
Date:   Tue, 26 Jul 2022 09:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm: dts: imx6qdl-vicut1.dtsi: Add backlight-isb node
Content-Language: en-US
To:     David Jander <david@protonic.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220725124813.1001032-1-david@protonic.nl>
 <de68c1e8-447d-f1e9-7885-6a109af1e971@linaro.org>
 <20220726083006.5c65b597@erd992>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726083006.5c65b597@erd992>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 08:30, David Jander wrote:
> On Mon, 25 Jul 2022 22:33:12 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 25/07/2022 14:48, David Jander wrote:
>>> On some older hardware models this is needed. It will do no harm if used
>>> with newer models though.
>>>
>>> Signed-off-by: David Jander <david@protonic.nl>
>>> ---
>>>  arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
>>> index a1676b5d2980..08d425020088 100644
>>> --- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
>>> +++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
>>> @@ -37,6 +37,16 @@ backlight_led: backlight_led {
>>>  		power-supply = <&reg_3v3>;
>>>  	};
>>>  
>>> +	/* only for backwards compatibility with old HW */
>>> +	backlight_isb: backlight_isb {  
>>
>> Node name: backlight-isb
>>
>> I know that other node had underscore, but these are not correct for names.
> 
> I know the names are not correct, but they are in the style of existing node
> names in the same file. Do you want me to change them all, or just this one?
> This change would break existing user-space software though, which is something
> I prefer not to do. Unfortunately both names are relied upon by user-space
> software for almost 10 years now, and changing them will force me to maintain
> off-tree patches that revert these changes.
> I understand the reason for the change though, and if you insist I will do it.

Node names are not ABI, thus any user-space depending on them does it
wrong. Could you link/name which user-space depends on it?

I don't understand why new node is also already a dependency. It's a new
node, there cannot be anything which depends on it before it is being
applied in upstream.


Best regards,
Krzysztof
