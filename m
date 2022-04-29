Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556CB515620
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380953AbiD2U43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbiD2U40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:56:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254FECC517
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:53:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k27so10358538edk.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=5rueA+5P6DTgRKhYiRtmSze3ymkDAf5ytcrTJ+jun9M=;
        b=Lld+U214U5FpR4tHUMml0PeDOJMDTHUSspkT9J9PRSGdfHLrXLUZh5TzNZKVksNGyn
         lsJIeEyOuKjndcsMU3i11HFYeUeGHR8whS5ERQjMdMJRtK7cHF7813uS1Pf1K7Kkk9LB
         TB9F7PnvpLhSQfqKea+3KLbAEuB1BeslNWWrd//LCgYFGiqTe43gOuVgJgMOl3YWqlbu
         Z6NO7+NVFMoo93e6PcPFIVj9eK8M43N8GM4G+6c/ZXJG5m9g7x2te+LAVhrygp7wpmFg
         oqqdXY79pVug5hMWwJGwAD+BD/gXE5EaNPdBbuhT0QCGlKtR3hEeM41Iu8JGITrZdn3u
         Bb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5rueA+5P6DTgRKhYiRtmSze3ymkDAf5ytcrTJ+jun9M=;
        b=B+hFRnbjH7Dxptg86cQGuWK44WvyU4op/dpN5Hzym+QOLWE3ASTqQj5938dk6nXiH7
         fX9/xksCsbVJfLSM9oaOnA9UuG8m+6B/KQfspFIf222hrgZThX5j/6spl9bRSEK2K1PM
         CFSaAZWPtAg6Yn+5oNToJqqY1ZNRAtpXigyxO9iXLoi/lFWtGePGqfqv7v6REUo/j8dY
         Q5RUtFKNJ71AlBFwoq3F0SGA4BDg9PRW6Yhb426Nho427ydqnC+nlQ7NjkbhIDyXoExe
         w3oClZhYnoVK3wR3s68Td7mWjLE646naKayj2l3V40gc6+BRzb1Llkh7iZftCA1YZHTG
         3ByA==
X-Gm-Message-State: AOAM5300FNXr6selgeKLJbZ0f8nsyp53cO7Y7aKP3DMH5REkczRobEtn
        88uYrfd6IiXpyzuzVzIi/KQ7Jg==
X-Google-Smtp-Source: ABdhPJy8IUwbb2odNT7CTTekNssjCh4o9qQLalWP0g+aNBCPfam0Wsuwz3cMRZqb5yANHs0LGjORGQ==
X-Received: by 2002:aa7:ce84:0:b0:425:d2e0:a75f with SMTP id y4-20020aa7ce84000000b00425d2e0a75fmr1119803edv.263.1651265585758;
        Fri, 29 Apr 2022 13:53:05 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7d99a000000b0042617ba63b7sm3418077eds.65.2022.04.29.13.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:53:05 -0700 (PDT)
Message-ID: <5866fb85-37ee-76ce-a1c4-a0d9b9aebda4@linaro.org>
Date:   Fri, 29 Apr 2022 22:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/2] dt-bindings: usb: Add bindings doc for Sunplus
 EHCI driver
Content-Language: en-US
To:     Vincent Shih <vincent.sunplus@gmail.com>,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, davem@davemloft.net,
        vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
References: <1651220876-26705-1-git-send-email-vincent.sunplus@gmail.com>
 <1651220876-26705-3-git-send-email-vincent.sunplus@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1651220876-26705-3-git-send-email-vincent.sunplus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 10:27, Vincent Shih wrote:
> Add bindings doc for Sunplus EHCI driver
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
> Changes in v2:
>   - Address the comments from Mr. Krzysztof Kozlowski and Mr. Rob Herring

Improved, but still I don't think you applied all of my comments. Please
go through them one more time.

https://lore.kernel.org/all/67ec6f3a-1579-f77a-a54d-381472252d6b@canonical.com/


Best regards,
Krzysztof
