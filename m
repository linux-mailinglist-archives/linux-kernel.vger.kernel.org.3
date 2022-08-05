Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71C858A5EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiHEGgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiHEGgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:36:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36606FA1C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 23:36:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x39so2115654lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 23:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FfYvonlafX3BzC9FTm8GHcqEd0hunBjPCQINuMxo2ew=;
        b=mm4Z1yEIIfoA6xaiVC2oO4ScLt5H5u3UcwmAkGnb46WTbZkOvOiT3ai/s8Jgt1DvHu
         TMfupJwg82ceo7urGrZlYF/gmDkvuyNy0YPd/STyVX/jy1PJ1Eo9pwFbNmiRBcisBAO1
         DpnfmaDpngGmJRGeTIy/hYv3GnHpjmbBaVbcabTwzzacODP7GvEUKNl33a4fHDCFmRZu
         NqgXzI0ifl5+r0ceXSIGHRvR10qWW1PtnE0uyGVugLabBxuK12xdIb+VHlEM9+SpWdAU
         Q0POb7jcDyySSHxIdqI/kLe/P+aYxfgSW5Kw4RjCwvwzsxkKe90GDSmmJej3tGIVukLA
         IX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FfYvonlafX3BzC9FTm8GHcqEd0hunBjPCQINuMxo2ew=;
        b=M0erskb9tW9NXN0MyHR96bip7opXHnC8ZgwvLBGBTKggjCgQ/83bpa2tDyYk24N2uO
         iwdphj45uuL8JY7M09C5PsAmop/b8K9cbVTL7afVM7UvnXInIap45THSmNA7AZyw/bNc
         n9l/6PjujLxcIaT+YVSUMoFZiwNADkqU3lroEG8wmiInb+RTgj491d+pNYSFhDtqMcEV
         eb5QwWAxid4UKVgaLxTHGXtxb2V1uwO7/3PdpPxKGffK6kSvIHNPjMaTX8bncOMG4sES
         f5eb8VQHGzlMAgehlJculwUctUDhSmVwMMK12FPRpInHB82bmpj8K0GDDA69POOyF1Xt
         RKlQ==
X-Gm-Message-State: ACgBeo1UA2UITHKBLE0l7csdgwleRcPGpZdBiCblw1E5zM8a0LV81rEW
        miWQht5/sducWZ0NUEky4xRUZw==
X-Google-Smtp-Source: AA6agR4SjqFpMzckvMkeXKWrrBXPyBG5d1+ymIlgWt2fIsTamlb8H3yn42SuIf/7SHZyb5RhQXW7+Q==
X-Received: by 2002:a05:6512:2185:b0:482:b4f0:f23 with SMTP id b5-20020a056512218500b00482b4f00f23mr2027840lft.31.1659681396871;
        Thu, 04 Aug 2022 23:36:36 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id o4-20020a056512230400b0048a407f41bbsm357162lfu.238.2022.08.04.23.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 23:36:35 -0700 (PDT)
Message-ID: <10e93907-49ef-a3e6-e0b4-0b3e5f236f44@linaro.org>
Date:   Fri, 5 Aug 2022 08:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
        minyard@acm.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     openbmc@lists.ozlabs.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220804181800.235368-1-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804181800.235368-1-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 20:18, Tomer Maimon wrote:
> Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
> string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Your previous commit adding that compatible was simply wrong and not
matching the driver and it is not the first time. I think all Nuvoton
patches need much more careful review :(

You forgot the fixes tag:

Fixes: 84261749e58a ("dt-bindings: ipmi: Add npcm845 compatible")




Best regards,
Krzysztof
