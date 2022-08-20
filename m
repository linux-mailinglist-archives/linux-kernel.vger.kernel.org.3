Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ADB59AAC7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 04:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbiHTC42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 22:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiHTC40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:56:26 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DB6C0B4D;
        Fri, 19 Aug 2022 19:56:26 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id de16so2257102qvb.12;
        Fri, 19 Aug 2022 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=WdNXulQpLKnb1hellq34T9B1cVet72f1MSilSB+CN3I=;
        b=a0T43ybU8bO+siRIbhddbFvW07aOpcJFI9kVRLWv1QE01sXTkiaHNKqcOUKvCwkW83
         U6rq+EgVCugy2FgWYwcKdnrOcF55gS0sCyeyKvfDLqhBm5rGM+rjxwHio4+99dZIyWnJ
         +OgN4lV9ZLoslTJqA/Mnwmxh/Q1QVT4N1ODyOCsLTlV6ymw+2EoS+sn+dJBkKSkh8Sxe
         Cspejh90MS6vhhvyhEJRP6tLRAT89pRJxjVMe38Ucv+LTJAJ8dvLtZrLczbKKfOygPxS
         X+v+SKoo0OV6ZrcSw31WlJrW8I87oua869SCNp1Vqb0RjZHQu8jFbJSu3SaktASnaioV
         FMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WdNXulQpLKnb1hellq34T9B1cVet72f1MSilSB+CN3I=;
        b=omRZctxL+mMmyNKuNS8sjYUt6yWRM3DBe+IHwP6aqVNrwrX89J7lOPLVYcisFOl0sX
         zYLY6lXhRxUwkaZB/CZK+I9Ji6u5jIRTEdTsGy9ixkm+Z+ZVWniLsVYWP+dg+LEHRE4t
         CwEj2OzIu9xGILASoq5pZaF7dyd4zhlJ8DyR9tlIeUIVJ/jFmn7UQE//RB1xhD6crP3D
         XFu/RnNxIKeWVcknvZYOUyIViYjLhYatX+J3JTG2v6c/bUoMWNSuzJdAlAYDKAGa0O8K
         EPO5TVzcGsbRJ01WyXyaxw4T2FhmmmVIKYwrUxDWSHBLonNuhJsVFAZk21m03hGnaXza
         6nEw==
X-Gm-Message-State: ACgBeo2uwxyYmr/6h3uk0r8JOzcoyUdWyMoFjN3K/iJmM7DEg5WIV1WB
        h7KG7BdkgYuk/L+8VoRbV0U=
X-Google-Smtp-Source: AA6agR7UhV0tlzwEw3Nj/aSzxj7GebTOwBfhp2btuNUyiCKC7iqVFL+Ymoa89dvUVa2Q3lk1yzk54Q==
X-Received: by 2002:a05:6214:f27:b0:476:9d88:2597 with SMTP id iw7-20020a0562140f2700b004769d882597mr8722836qvb.45.1660964185291;
        Fri, 19 Aug 2022 19:56:25 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id w16-20020ac843d0000000b00344a9149da2sm1535606qtn.55.2022.08.19.19.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 19:56:24 -0700 (PDT)
Message-ID: <7a438a56-007e-beb8-ef55-ff99ed7ba736@gmail.com>
Date:   Fri, 19 Aug 2022 19:56:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [krzk-mem-ctrl:for-v6.1/brcm-stb 1/3] htmldocs: Warning:
 Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt references a file
 that doesn't exist:
 Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org
References: <202208180941.oGoLuq8U-lkp@intel.com>
 <427c0198-850c-17a7-f0d7-954a8252b11a@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <427c0198-850c-17a7-f0d7-954a8252b11a@kernel.org>
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



On 8/17/2022 11:09 PM, Krzysztof Kozlowski wrote:
> On 18/08/2022 04:59, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git for-v6.1/brcm-stb
>> head:   65991a63d02decf269e7d5334620df0dd5919762
>> commit: 0da0b6bf854dcfb047fec70bbbadabb7ff0fcb3e [1/3] dt-bindings: memory-controller: Document Broadcom STB MEMC
>> reproduce: make htmldocs
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> Warning: Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt references a file that doesn't exist: Documentation/devicetree/bindings/memory-controllers/brcm,memc.yaml
> 
> I'll fixup the commit.

Thanks

> 
> Florian,
> It's useful also to have own development trees covered by LKP.

I will keep that in mind.
-- 
Florian
