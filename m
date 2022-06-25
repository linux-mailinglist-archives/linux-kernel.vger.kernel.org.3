Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A500655A6AF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 05:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiFYDoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 23:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFYDn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 23:43:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F323A714;
        Fri, 24 Jun 2022 20:43:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id z14so4122985pgh.0;
        Fri, 24 Jun 2022 20:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X5w+HulnPF/zYNAZP+7heB8iRi4bWtMYa0BgC6LI980=;
        b=MIMRFLPvYoCjp3vHj9M/tcq6z2v0vvxF+BWZJ2pBS+7v96r4rDphe+74ewa8VC3xHC
         a4Qz/tkob29rqXLA93/0PwEKkKM/kSOkcfSMx5LeS3i4vRu6s+vuvz2JPKpz05risorz
         m527DHCPBQ0+hDrSgezHccFuMbHWGsnnqujbvEd2hTt0IiuTDLmBWSu/ATS17+pYy+AU
         XsuQgv3Us/R771NJodYn+p1qupP4bwgYnH3WZ8Pr09D8IsZe3TJD3hAL9JZe6Cv3hqnA
         KflZjcXuIJ+pGAu4Pi7GUCiQxJ1TWC7RonKeJspQKo40Y/JdHs4xrHEyLxu2sS1rOVmV
         zAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X5w+HulnPF/zYNAZP+7heB8iRi4bWtMYa0BgC6LI980=;
        b=oYEuP5QV05OfvrRFSLwdJ6f5QDhe74Z+K6U74ELuhFu00SuDgWErTfmVLhhzTP61E0
         fGaXe9PaHQwybOQCkcv7mAn1fguS+eC2+bdt5lSK1w6Gtrjnl5bU7ZCVLGJ4aZGcPNWk
         GPnA0Rjp00cIDdHPVezG81J6cXjGTacDRcWyPHIUBpsoCa8lg5KsijGuYk1AcTk89+FE
         3ftGZlq6f2EUB3czUZojKiIyIlDS6ATqr1wUWWx5s521SqoBAoqPh7T/oFMi+/MTmN+R
         bxY9UsHTC6CyWTuMkoH1zUBJ7FI9hE/tP5aH/MViZYylDxc6xVMI8X9MS9NbeG3GCfxP
         Gdwg==
X-Gm-Message-State: AJIora82mnIy7b8qRqPIUBbSxrodJpkXw70FWinTRhnS6DmykBi5bmZX
        588N6mymS97iqaUqPrHRvfjJVU156Je5yA==
X-Google-Smtp-Source: AGRyM1tQ4LCSGO+IvrOaFJxQpxEnKwFvzaMq7DarqdJKFKHl6rLWGiiscIOd6PTlig3YQod1p360bg==
X-Received: by 2002:a65:6e04:0:b0:40d:26eb:8225 with SMTP id bd4-20020a656e04000000b0040d26eb8225mr1995550pgb.138.1656128637083;
        Fri, 24 Jun 2022 20:43:57 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:edae:5ad3:3d10:1075? ([2600:8802:b00:4a48:edae:5ad3:3d10:1075])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090a348f00b001ecc616c9f3sm4725345pjb.21.2022.06.24.20.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 20:43:55 -0700 (PDT)
Message-ID: <903a2ac9-64e6-e4d0-a0e7-6160284e6b3e@gmail.com>
Date:   Fri, 24 Jun 2022 20:43:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] arm64: dts: broadcom: align SPI NOR node name with
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Scott Branden <sbranden@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20220407143211.295271-1-krzysztof.kozlowski@linaro.org>
 <20220407143211.295271-2-krzysztof.kozlowski@linaro.org>
 <20220407185710.2576287-1-f.fainelli@gmail.com>
 <2079f567-ff8f-5790-cba7-837c311e5fce@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <2079f567-ff8f-5790-cba7-837c311e5fce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/2022 1:52 AM, Krzysztof Kozlowski wrote:
> On 07/04/2022 20:57, Florian Fainelli wrote:
>> On Thu,  7 Apr 2022 16:32:11 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>> The node names should be generic and SPI NOR dtschema expects "flash".
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>
>> Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
> 
> Thanks Florian. It seems that patch is still not in linux-next. Is your
> tree included in the linux-next?

Somehow I missed the email of yours, sorry about that. linux-next is now 
tracking our "fixes" and "next" branches which are the aggregate 
branches that merge all of the other branches that I used for maintenance:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8aeec38e054da2bcc8201f7fd511e22fa73dc4cf
-- 
Florian
