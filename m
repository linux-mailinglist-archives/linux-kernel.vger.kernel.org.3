Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E38C58872D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbiHCGMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiHCGMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:12:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669862181B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:12:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m9so17834914ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xA1IV1gSTfROQBdJbxYL1cFnue2WQ14EMBxttL8IeyU=;
        b=keQycvdDpt2USZqOkCWgao6evR8jRHZ+p3lbtmV2/Hrz+7++JDhEROKETVZEx1QKze
         CJaVdBm6POIeFN3psb5li8CVdyZByCmAF/pfC5rjA28FnC5Ko3ZXQOAvnyM/0EHnxAgN
         bHNSX+vxs9WmtpD/tq/D78YXhWebBMRrW2R+ZTbLn/pplrkFwpFFq9WZv4vd6N2+08LE
         VefTHqPZQL+Iz8GqnWH7ckHQ0MCvHAe581uVOK/pKmuvYDnIyovQKAdKNonPGrqbbLzO
         D/aOLGGPV4QMT0eob0farvsq0xCKMRQShLFMhYrFBMGk7W02a5Yz+aqLXHK227GOOJmi
         AvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xA1IV1gSTfROQBdJbxYL1cFnue2WQ14EMBxttL8IeyU=;
        b=O/FyGCnualH8l4k9ZIE3qirbiVDRYrIcb1bAGS3xO94LP/kJ0+OT705BFJDGPOOmMg
         /u+QprOm7Svn0jBNZxrLlaKbV71tNqdJg88VDr9mTAklEnmvndADV0YscTQquVK1aBlg
         +lqEOg4i2dQvFDxTVgT9b7oPR+RTrXAXjPgQGBqyx6QLP+5AxUCau+17O0f1KFOVJi4i
         y9CG+5zkCoWr2gyGpjMJl2PqfiYhfZeM7xdvwDy8o+vYWjWtSQA/hUaTCaaWZDE2955H
         8PmuKHOu6hhBzu95R1LSmLBYRd03tL4p+ooBfEGY5G/hmVxrOfeN2AzVDqzH+HX0dqg/
         axDg==
X-Gm-Message-State: ACgBeo1WTNHVqHSMoGg8teo91wyPelOlPWnJTkeReScALBo0MkGzp7O/
        9qx6GGlQsYS83okuxIpwer//FQ==
X-Google-Smtp-Source: AA6agR7rFk5phrwiCW0GkyzfsMN8/qQgb88zQG/wQzaNiqiaKlWjk7lMz9PCGlbKKNWq+NH3ffoGYg==
X-Received: by 2002:a2e:88d3:0:b0:25e:67cf:ecc4 with SMTP id a19-20020a2e88d3000000b0025e67cfecc4mr1152451ljk.277.1659507118750;
        Tue, 02 Aug 2022 23:11:58 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id f23-20020ac25097000000b0048b18fb378fsm218754lfm.119.2022.08.02.23.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 23:11:58 -0700 (PDT)
Message-ID: <751115c3-086c-7207-8281-3ffbb5d45872@linaro.org>
Date:   Wed, 3 Aug 2022 08:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 9/9] ARM: dts: uniphier: Remove compatible
 "snps,dw-pcie-ep" from Pro5 pcie-ep node
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1656894026-15707-10-git-send-email-hayashi.kunihiko@socionext.com>
 <CAK8P3a0D4CYqZipY30scDA=KkWR_Az_5i-8avkg6EeDs1nM62w@mail.gmail.com>
 <64e3702b-f09b-5a2e-b6a5-4c8752fbad77@linaro.org>
 <612989a2-c6c7-5f04-a3ba-2a82667d420b@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <612989a2-c6c7-5f04-a3ba-2a82667d420b@socionext.com>
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

On 02/08/2022 15:10, Kunihiko Hayashi wrote:
> On 2022/08/02 17:33, Krzysztof Kozlowski wrote:
>> On 30/07/2022 13:58, Arnd Bergmann wrote:
>>> On Mon, Jul 4, 2022 at 2:20 AM Kunihiko Hayashi
>>> <hayashi.kunihiko@socionext.com> wrote:
>>>>
>>>> UniPhier PCIe endpoint controller doesn't use "snps,dw-pcie-ep"
>>>> compatible,
>>>> so this is no longer needed. Remove the compatible string from the
>>>> pcie-ep
>>>> node to fix the following warning.
>>>>
>>>>    uniphier-pro5-epcore.dtb: pcie@66000000: compatible:
>>>> ['socionext,uniphier-pro5-pcie-ep', 'snps,dw-pcie-ep'] is too long
>>>>        From schema:
>>>> Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
>>>>
>>>
>>> This sounds like a problem with the binding rather than the dt file. Is
>>> this not
>>> a designware pci endpoint? Should it be documented in that binding
>>> instead?
> 
> In term of the binding, it seems that the current binding doesn't allow descriptions
> that list two compatibles. There is something wrong with the binding.
> 
>> Depends. We had one or two similar cases, where we dropped the snps/dw
>> generic compatible, because device was actually quite different and
>> could not match against snps/dw compatible. IOW, if device bound/matched
>> via generic compatible it would be entirely non-operational. Logically I
>> think it is okay to drop the generic compatible. Different question is
>> any ABI break.
> 
> In term of the controller, we can add dw general compatible if the more generic
> driver (pcie-designware-plat) works on the controller.
> 
> However, the generic driver can't do the initialization what the controller
> needs, so we can add controller-specific compatible only.
> The commit bf2942a8b7c3 ("arm64: tegra: Fix Tegra194 PCIe EP compatible string")
> removes the generic compatible for the same reason.
> 
> This patch suggests removing the generic compatible for the former reason,
> though, I might suggest it for the controller reason.

The patch does not explain this, though.


Best regards,
Krzysztof
