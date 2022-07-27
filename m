Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0973A58262B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiG0MMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiG0MMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:12:13 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FCA3DF2B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:12:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h12so2042498ljg.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=10ubXVPVFe54DessUBAS/FFT1kv6KKtGGGZr+g/3Ww0=;
        b=sVrtDV9tkd7k9d14Bok3CvF2/a6VNOb3pxYAIgeqYAFfAGFskKkuSOdXWuxFTMvSjO
         1jacSHBH+UGugbQD9PkAbVbW1Js6Co5HbawZnZq1xDNbfIc6Umd96s7jFgoWUVJNqiw8
         f+z7Vp57N23CStMykgKOrKSlxpwji0uMfMDbGQh7FXF+eyEnA7vx6HILPhhoYzfXllEx
         JYqAksVlbAE/tHdaFmxbhDX9VAL1FCHtH9KVVmy3i5OKFGyep+aYgD9o7VBjZQdvvmhT
         t5jv/GAAJsN/4fWoisNzawQ+VCyTpagmY19yPDGAhZlz6/W+zue0BBWT6KgL8iueuRt/
         uYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=10ubXVPVFe54DessUBAS/FFT1kv6KKtGGGZr+g/3Ww0=;
        b=QTepR105FMZ0yys31S1oK7Qbs0Iuwq+ixZMh4TePCRA2VN0IXZaekIPMn5qNYOsAKI
         1yRt+s7bhoIrxcM4pm/tTfT93NAhprNd5JnlatedNvvEnAZuuCtonYVxGURhXh4QkV5r
         EgOY9zdw54TtGfS7WFk/sesKXuPotxzXNtho1vjGD+7+vbADNAjpuVtXR0VqLdcas5ZX
         Rug+fWs5lQG+g0fBn0UvMiCP7EXwBJR1Xq8Gz/jWSMalkliQZ5J7U2r98eoaA6xR3TR6
         SuBohS6u7OG1EzZY3VbC39GE3k5x/nYSeLoGGl2/4/709+POk3Cg80vRA+rHyiVLjFXD
         +PGg==
X-Gm-Message-State: AJIora+t9dnoV0LGfmk740VnNZFP+WyyN/tGDT/cfGaaM1Y9+1sthP+i
        CjtuURCe8IauTPsy2lfzolVanQ==
X-Google-Smtp-Source: AGRyM1sIeYWy7b3sDYVyaroNvjI7uSsdun+0oCSFKP4gpTGnNIJzeDZ0Zs0O9UaW7IT44ATj/IgObA==
X-Received: by 2002:a05:651c:11d2:b0:25d:e9a1:b104 with SMTP id z18-20020a05651c11d200b0025de9a1b104mr8263054ljo.116.1658923931080;
        Wed, 27 Jul 2022 05:12:11 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 197-20020a2e05ce000000b0025d70efeaaasm3912382ljf.75.2022.07.27.05.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 05:12:10 -0700 (PDT)
Message-ID: <ccfd96cd-756a-da73-178a-4a7e0e4de410@linaro.org>
Date:   Wed, 27 Jul 2022 14:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/9] arm64: dts: bcmbca: update BCM4908 board dts files
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        William Zhang <william.zhang@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        dan.beygelman@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220725055402.6013-1-william.zhang@broadcom.com>
 <20220725055402.6013-4-william.zhang@broadcom.com>
 <20220725233238.GA2960972-robh@kernel.org>
 <1004391f-fb6c-5f84-de28-8f76dc3471e5@broadcom.com>
 <0af44be8f5802e66011b4642de4632d4@milecki.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0af44be8f5802e66011b4642de4632d4@milecki.pl>
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

On 27/07/2022 12:39, Rafał Miłecki wrote:
> On 2022-07-26 03:09, William Zhang wrote:
>> On 07/25/2022 04:32 PM, Rob Herring wrote:
>>> On Sun, Jul 24, 2022 at 10:53:56PM -0700, William Zhang wrote:
>>>> Append "brcm,bcmbca" to compatible strings based on the new bcmbca
>>>> binding rule for BCM4908 family based boards. This will break drivers
>>>> that use the old compatible string for binding. Fortunately there is 
>>>> no
>>>> such usage in linux and u-boot.
>>>
>>> How does adding an additional compatible break things?
>>> In theory when some crazy code tries to match the entire string. But 
>>> not
>> in linux, u-boot code and hopefully not in other bootloader and Os
>> does that. But this does change an existing compatible string so
>> Krzysztof suggested to add comment about the breakage in the commit
>> message. I can remove this and send v3 if you guys think it is
>> necessary.
> 
> Krzysztof commented on ABI breakage [1] when you tried removing
> "brcm,bcm4908" from the "compatible" list in your patch
> [RFC PATCH 3/3] arm64: dts: bcmbca: update bcm4808 board dts file [2]
> 
> In this version of your patch you don't remove "brcm,bcm4908" anymore so
> this change doesn't break anything. Adding a new "compatible" string
> doesn't break things. You can remove that info from the commit message.

Thanks... It is second thing (after not existing Reviewed-by) attributed
to me by William, although here probably by misunderstanding... So for
clarity (obvious stuff is not always obvious to everyone):
1. Removal of compatible is an ABI break.
2. Add of compatible is not an ABI break.

See also:
https://elixir.bootlin.com/linux/v5.19-rc8/source/Documentation/devicetree/bindings/ABI.rst#L26

Best regards,
Krzysztof
