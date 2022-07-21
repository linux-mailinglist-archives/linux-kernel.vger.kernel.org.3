Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4801E57C4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiGUHBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGUHBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:01:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5DB753B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:01:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a10so744247ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n+SSCx2OFwtU5XYYs4flEXRZ/EIm9z3U+bgO9J/kElw=;
        b=b4bQCp4lvvuYtyIFjQdAtoCvRR3KDomPpl9gCqNYxJZ5JhBii4Gd02lDK3u5bx1lN6
         JCpBPdKa3+1Hk0XbSOU+XL34d/iYIqLvNMLaplIDQj8NoYkJZXnZ7S8jCbM9x7aG0EWR
         VbmGqHxlODlXI84GbxC+/WCPDLNYOAvmwpY8gDN4PfUbf8th3CTUj0FhDTxZTy4853lA
         mlPbzff+NsDRiUObv2lGuo6E3ORwzDoGaEDdqtgelc2HkKDtbe842LAVKr2jj/b3HtkR
         MQm0CHXttZ++EGRy2xWEN6ZDSsmH6pqn4etDzpuuSqU11Dbgi9c2deSU8yqK+HOq8GCR
         ge5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n+SSCx2OFwtU5XYYs4flEXRZ/EIm9z3U+bgO9J/kElw=;
        b=76YTPS4yxKbrwVh3UyltB82s8jLGaimC7b7Ndu5FcNse+CdVgCf8+xi1kPS4OnsMeE
         UUy0dc4+2IznkNHeh/IlONIZIbfJ2GQjxxU6qWuwiO1e/yKqVrxQZeK6O47XdjG6juqA
         juh3bqFUrqhbIA8wGpeq8cERHaq8tyXFMEK/dWv93vLl5fFEm7rAk1IkFF5UBZYw6gXH
         9blvB1qxRmMCxexNMMWJMR8FqEDRGaIykoqle4cGfc5ZSXDzka1Hf0GwqpfUx+72jTii
         rC+GQk8iI6VWLWuOkJ7uZRxhIeOrUEEQO+7bI49VWZmvp89ez4t+VJox115J5Vnc8dhr
         7taA==
X-Gm-Message-State: AJIora9tFJPBRMuxqt87pqu3XCTLZAOkaZS57xsRmV/c2BfctTH/o/Iw
        9KnAcaEsu9f+lHJPTn32dGQuYg==
X-Google-Smtp-Source: AGRyM1vxaJl/E5urFENE1deq3SnjdW7FkyOEH9cUWqI24bB6kXn9pCjnHq/7leK2tmnPN/lfTVCEKQ==
X-Received: by 2002:a2e:8003:0:b0:25d:e500:23e0 with SMTP id j3-20020a2e8003000000b0025de50023e0mr664239ljg.227.1658386888328;
        Thu, 21 Jul 2022 00:01:28 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id d23-20020a196b17000000b00488d1acb7b0sm250511lfa.130.2022.07.21.00.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 00:01:27 -0700 (PDT)
Message-ID: <193845cb-6149-1ae6-5eb6-6b01ffcf763b@linaro.org>
Date:   Thu, 21 Jul 2022 09:01:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220721000658.29537-1-william.zhang@broadcom.com>
 <a635754e-bf41-4058-5fbb-57ead36b7128@linaro.org>
 <883c2ad4c36220b488519a8902ad72bc@milecki.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <883c2ad4c36220b488519a8902ad72bc@milecki.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 08:51, Rafał Miłecki wrote:
> On 2022-07-21 08:44, Krzysztof Kozlowski wrote:
>> On 21/07/2022 02:06, William Zhang wrote:
>>> Append "brcm,bcmbca" to BCM4908 chip family compatible strings. Add
>>> generic 4908 board entry.
>>
>> This does not explain at all why you are doing it. Improve your commit
>> messages.
> 
> To clarify it from my side (and maybe help a bit):
> 
> 1. As I understand it BCMBCA is a one big family of SoCs.
> 2. BCM4908 is a subset of that family (a subfamily?) designed for a
>     specific group of devices.
> 
> If that's correct I think William it's what you should describe in your
> commit message. That would make binding more accurate and should be a
> good argument for your change (I believe).

That's better argument. But what's the benefit of adding generic
compatible? Devices cannot bind to it (it is too generic). Does it
describe the device anyhow? Imagine someone adding compatible
"brcm,all-soc-of-broadcom" - does it make any sense?

Best regards,
Krzysztof
