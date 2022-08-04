Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E4E589850
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbiHDHZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiHDHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:25:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04150BF5B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:25:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v7so1783171ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 00:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tnOwkKfhBzXFppIxRkEPpyNln0liXtEqX58YRBpJcr8=;
        b=KaBX5C27LU2/hiVV41fSRkEObVVMYRvfYHSIbaXVoHOpgKYVOS4QKSU78WR0R5+b9a
         OF+nzgrQ97gospGyxLfTDJvji0fJzMtG6v4s0CH5S0dGTdF4c3VSDpo87ozuZDrlXGfz
         hFrmYFfZti4EdlIVJ+ij29gERCwU0TCakfaI/YHBdE6kYhTw8npkUQEKxbQDKaJeEx95
         bJpHQLNv9DmZlIrF7IrpiHo0n/gntGbQRSL8spUyRFeDqhZm8czbKSHvH0Hr658EMLX+
         dkaJNTlUaQ+wg7SgajA3tBtf5O+v82Xjx9mcAtSZXmxRtH7D7I20Q63MYjC0Lw0TfrxF
         KNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tnOwkKfhBzXFppIxRkEPpyNln0liXtEqX58YRBpJcr8=;
        b=uA3Eg5GexG63ANrljEf49advH0cC2H2ImwtAvF4p+9xeUeIpazifbvPMckEA+Nyp/c
         Gvz87XdC28odorMy23tzifRxSiZtCG/fPocNIpvIe4rZ2Q6jGhIYoUQyTVl6HpGrcDNN
         tLCN3aQw4fjR6wJ13k7NKd/KZWMZFyeG0qFYtuwoqaFSG5vG3dUKHKSoT0mk3qFOpyJ7
         yIR9RSTU3VOa9y/mOYnztlAjvz3/g/lgdvaUdxzSN6F2N8c89YHi/j+pa5A1ncMwxlJu
         QzIrKLbRfqw4Q5rmtE0lIQs4QeVuRpBrbIcGu7UW+0auSLKCI+ozZ6rwU6uyt0OaZuEX
         /dgw==
X-Gm-Message-State: ACgBeo32GUNdhM/g98w5m8wzDyMKrmdMH9qL29EChNcEtD6kH6b7KOUE
        NbxnmsIl6nLJCjl5G4YnUPEaTg==
X-Google-Smtp-Source: AA6agR76ryk0wDxrVOrzMuTszxXgfwzTdW7WwyPRIhNvuxMuIMxK8DVdk/uToJEoH+F0vEOAkYdCdw==
X-Received: by 2002:a2e:9e43:0:b0:25d:d8e9:7b15 with SMTP id g3-20020a2e9e43000000b0025dd8e97b15mr163697ljk.234.1659597935350;
        Thu, 04 Aug 2022 00:25:35 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id bi36-20020a05651c232400b0025e5ff004a0sm17514ljb.100.2022.08.04.00.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 00:25:34 -0700 (PDT)
Message-ID: <1d6b475b-412d-da94-8505-0fd6f8f6a2c9@linaro.org>
Date:   Thu, 4 Aug 2022 09:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] pmic: add mt6366 regulator document
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        =?UTF-8?B?WmhpeW9uZyBUYW8gKOmZtuW/l+WLhyk=?= 
        <Zhiyong.Tao@mediatek.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "fshao@chromium.org" <fshao@chromium.org>
Cc:     =?UTF-8?B?U2VuIENodSAo5YKo5qOuKQ==?= <Sen.Chu@mediatek.com>,
        =?UTF-8?B?SHVpIExpdSAo5YiY6L6JKQ==?= <Hui.Liu@mediatek.com>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        =?UTF-8?B?SHNpbi1Ic2l1bmcgV2FuZyAo546L5L+h6ZuEKQ==?= 
        <Hsin-Hsiung.Wang@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        =?UTF-8?B?V2VuIFN1ICjomIflhqDmlocp?= <Wen.Su@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        zhiyong tao <zhiyong.tao@mediatk.com>
References: <20220728062749.18701-1-zhiyong.tao@mediatek.com>
 <20220728062749.18701-2-zhiyong.tao@mediatek.com>
 <03a13ed4-e7cd-6f7d-f8f7-9b1e6193e202@linaro.org>
 <3d97d4c46467909739b8b69662412fe162dbe613.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3d97d4c46467909739b8b69662412fe162dbe613.camel@mediatek.com>
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

On 03/08/2022 11:50, Rex-BC Chen wrote:
> On Thu, 2022-07-28 at 18:46 +0800, Krzysztof Kozlowski wrote:
>> On 28/07/2022 08:27, Zhiyong Tao wrote:
>>> From: zhiyong tao <zhiyong.tao@mediatek.com>
>>>
>>> Add mt6366 regulator document
>>
>> As usual with Mediatek your emails fail to properly pass modern SMTP
>> checks and you end up in spam.
>>
>> I reported it months ago to folks in Mediatek. No improvements since
>> that time.
>>
>> I stopped checking my spam folder for Mediatek stuff and all will be
>> ignored. I will also stop complaining about it - just ignore
>> Mediatek.
>>
>> Fix your systems, instead of putting additional effort on community
>> and
>> on reviewers.
>>
> 
> Hello Krzysztof,
> 
> I am Rex from MediaTek chrome project team.
> We noticed your complain of our upstream mail.
> 
> First of all, sorry for the inconvenience.
> We really want to fix this SPAM issue.
> 
> From our side, we can make sure mails for kernel upstream from MediaTek
> is clear and these mails pass the verification of DMARC/DKIM/SPF.
> Therefore, to identify the root cause, could you please provide us some
> mails that seen as SPAM from MediaTek?
> It's more useful if you can use the form of attachment. In that case,
> we can analyze whole mails including mail headers.
> 
> We really appreciate your big support, and we hope we can fix this
> issue to reduce the inconvenience for reviewing series from MediaTek.
> If you can spare some time to help us for this, it would very helpful!!
> 
> Our IT also adjust the DKIM setting today. If the situation of this
> issue it much better, please also let us know.
> 

Hi,

Since few days there were no @mediatek.com emails in my spam folder,
either because nothing was sent to me, or they passed spam filters.

If this is the result of some changes, then it seems working. Thank you.

I'll let you now when I find something new in the spam.

Best regards,
Krzysztof
