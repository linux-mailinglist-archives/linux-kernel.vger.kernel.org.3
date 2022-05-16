Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61F052890E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiEPPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245407AbiEPPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:39:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E97A3C737
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:39:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g6so29497190ejw.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QeTzlSoKejIzpA/CAduavQTBSJGaWHTM+6ACJIUc4Ls=;
        b=iBUVsMo1tUy6ku2kKrAq06P4tNuRs8L7DuSuMJsMffIfw9EJq0At17N3EFzXWo+W89
         h1VRgjMAZCz/Tdo9TJVCB/EK+j0UB+Rc7Q876XFYXzbKhKdz/Z+z1lq4+aDYyKo8pXPv
         nOxdF1itJEz5oF055uiMM9uQRD8OBFIkwieOa+/CJMxUzc9eUZPrw/cIniXG/1TpBeIQ
         nXTs90Xi184cLv8dN0lQ0mtlKDZBZKle3MwTS3X70U77kfBgeJsPl0UrFU23FEUhavRm
         JIofXbf/FQdSA2DAyP/19uvDNwfeTyn7TJgxtAOa3hWQaDTLZqgxa2yRCKTlrZkfHAcn
         EvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QeTzlSoKejIzpA/CAduavQTBSJGaWHTM+6ACJIUc4Ls=;
        b=NIuqRuO/6lEQa+GwLjwN4BKmVE/r6tbOyD0qpa93IGDF+MUKBbxAa0N3AWjZanfa3Z
         89lDjs1z1nBgeAoKgzjgGox0SbFpOIOaeQwPLOx7JTPb7WuJ5TOOl8bumNSiAIA48n/z
         GCdHTl4a4/9rolvbO1yZixjlRI4WBwgaiAqQ2UocYZSS/4nRfU3Y0hNDYQf0Spmpcyso
         7TfHLuHhtOu6zxrY9myIKDUQzug4wk4nU6IoUGK7SLi6zb8Kb+nJIR+lEY9UhjErR2rl
         MaXiSQF7BoAdPpKPUf3rKf86qXxguipgFpDMGJ/2yMt0I6ECJogtVlUq8fN9Hna7/1P1
         8teg==
X-Gm-Message-State: AOAM531op+XjUoedUGa+e3EfsMHcO7oR/tZy2Bh3DbyJjvvNCsh+5spa
        hQICF54Le/ddGIEAarRFL/Y0CQ==
X-Google-Smtp-Source: ABdhPJzGGrQoOSmJ9vD3CMkYO/M8Z/D7CsPSwd6YiSuqRc3ss5QTTRcW0bxHqNKD1ofxAe9kVrTeeA==
X-Received: by 2002:a17:907:6294:b0:6e1:ea4:74a3 with SMTP id nd20-20020a170907629400b006e10ea474a3mr15582068ejc.168.1652715572978;
        Mon, 16 May 2022 08:39:32 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7d29a000000b0042aae307407sm2287770edq.21.2022.05.16.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:39:32 -0700 (PDT)
Message-ID: <e35ff2c4-e6a7-29d4-a0c5-aace840a0c19@linaro.org>
Date:   Mon, 16 May 2022 17:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/3] dt-bindings: mtd: partitions: Extend
 fixed-partitions binding
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>
References: <20220503155007.2339847-1-csharper2005@gmail.com>
 <20220512152725.244872-1-miquel.raynal@bootlin.com>
 <CAL_JsqJdUm4p9qAq9dLeVTVC9PA2q2SP01kG2jyEb_f=Fo=bEQ@mail.gmail.com>
 <20220516102115.4ab6fada@xps13>
 <ed853a8c-f1a5-d137-e2bb-df782d43b65e@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ed853a8c-f1a5-d137-e2bb-df782d43b65e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 17:34, Mikhail Zhilkin wrote:
> Hi, Miquel!
> 
> On 5/16/2022 11:21 AM, Miquel Raynal wrote:
>> Hi,
>>
>> robh+dt@kernel.org wrote on Fri, 13 May 2022 09:12:03 -0500:
>>
>>> On Thu, May 12, 2022 at 10:27 AM Miquel Raynal
>>> <miquel.raynal@bootlin.com> wrote:
>>>> On Tue, 2022-05-03 at 15:50:07 UTC, Mikhail Zhilkin wrote:  
>>>>> Extend fixed-partitions binding for support of Sercomm partition parser
>>>>> (add "sercomm,sc-partitions" compatible).
>>>>>
>>>>> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
>>>> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.  
>>> Patch 1 is a dependency, please apply it too. Without it, we now get
>>> in linux-next:
>> Only patch 3 was sent to me/the mtd ML. I'll drop the patch.
>>
>> Mikhail, please resend the series including us on all your patches.
> 
> Done! I sent the series to you and mtd
> https://lore.kernel.org/linux-mtd/20220516151228.885222-1-csharper2005@gmail.com/T/#t
> 
> P.S. get_maintainer.pl didn't recommend to add you and mtd that and this
> time. Do I need to send each patch from the series to all maintainers of
> all the patches in the future?

Yes, entire patchset should be sent to the same folks, same maintainers.
Otherwise maintainer should assume patches are independent, which is not
true.

Exception is for large patchsets where we do not want to spam everyone
and these require different approaches. It's not the case here.


Best regards,
Krzysztof
