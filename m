Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1921527D38
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiEPFyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiEPFyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:54:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0719717054
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:54:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h29so23944528lfj.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iQu4lukAu6aND/lSxHXOC9CQZKXgScz0FZajkncufEw=;
        b=WOTncPc2v5NZjRnTIJIh4IXO1dj9ckDUzbSMpFADqaVVFteQj9TEczbboaO7BSW2/s
         XISBzIocyQtoLTgR7gWJ/xy+YDxJlUaAAnAbtnBo+Ja4yyTkPE3dNrqwQyJL1N6Lt4H0
         ++LYr9UXQs5/Qplz1Zqp2mpf5Mt3r7P9Z9O4UHYmkTLk3lPXMJ1Bwkihocd9f4kVWpdk
         3IzpmTfXxrlrmJeAStqS0d+5hFCtGcTIYjrwdLrzg/HL53pH2ksHGVkx5ljLbGLK0EZE
         n33jLIToD1mvWSg0ZTsItxhaHXXnCYpgLBJ7kwzcMxk9kRkJfIChVs5xPxBONi0DnCfU
         rI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iQu4lukAu6aND/lSxHXOC9CQZKXgScz0FZajkncufEw=;
        b=OsG7i+8Vm2fxDpeafeNjtLptp958t8CkFjkDoCZ3YWx/46tOnBfCJJQRa3myYm5i4X
         8d4r++KnaJJmFmS/nftRJYrTUy2vRfs+v+szk0hv6hSakr9OvS4HZVXpsxqwgSM9gbgL
         8YGo+nM/7c3ro9F3/wStKW+1111lz/LB1cY9GhWd3GLmJTkk9kDECfvlTQPE6e6GZKEP
         mV26khkavSNrQ6yNyorcrhZiz2NpluC/hcHG0w4+bW54tzlwDmy6azH0pqDiisOaW85x
         Z+bJGYMmGSWtwjpdeD5HCGJdzRk0GDpR21m+WCNqRxx+JYxAmSUSIHg2jkQ7ddl9uVdO
         rS9g==
X-Gm-Message-State: AOAM530LB18k7u51FwWg41Ihe7VW1WrqoG8XDcufPBUOdzVQL0qxdPYW
        8XMaIjpmfAmIuRDSR7d5pKGmsA==
X-Google-Smtp-Source: ABdhPJxDB/Sa5OHAguWRCgpV67m8ipVKXudtdyV00vw1QteYiiQh9fRXMYiofl5SGOVzWKsH/Wkjhg==
X-Received: by 2002:a05:6512:228d:b0:473:f729:3219 with SMTP id f13-20020a056512228d00b00473f7293219mr12132861lfu.428.1652680445339;
        Sun, 15 May 2022 22:54:05 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m20-20020a2e9114000000b0024f3d1daeb5sm1384293ljg.61.2022.05.15.22.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 22:54:04 -0700 (PDT)
Message-ID: <3499cca2-1d7b-12f5-adbe-0c9b279cc51a@linaro.org>
Date:   Mon, 16 May 2022 07:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] dt-bindings: usb: add documentation for aspeed udc
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Felipe Balbi <balbi@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Li Yang <leoyang.li@nxp.com>
Cc:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>
References: <20220513065728.857722-1-neal_liu@aspeedtech.com>
 <20220513065728.857722-4-neal_liu@aspeedtech.com>
 <da78aaf6-c9ae-d591-fdc4-723f097ace2c@linaro.org>
 <HK0PR06MB3202679A7FABAF7D0D045F0880CA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <567d135b-3d40-9958-e000-1357020b5650@linaro.org>
 <HK0PR06MB32020539063F8A7C5D56E0B980CF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <HK0PR06MB32020539063F8A7C5D56E0B980CF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 03:59, Neal Liu wrote:
>>> Okay, I could rename it for next patch if you preferred.
>>> But there are lots of yaml files which are not named as first compatible.
>>
>> Yes, I know, I quite likely I also produced such bindings, but a specific name is
>> rather preferred. Otherwise you will have a difficult naming choice when your
>> next Aspeed UDC requires new bindings file because of some differences (not
>> yet known now).
>>
> We can rename the bindings if next Aspeed UDC needs, don't you think?
> Currently, Aspeed has no requirement.

So just use proper name from the beginning....


Best regards,
Krzysztof
