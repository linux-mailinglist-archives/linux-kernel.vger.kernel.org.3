Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF7569313
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiGFUJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiGFUJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:09:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273AC14099
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:09:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e12so27703265lfr.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L8DTfq0A17haA8PrzESImW0A0vAqb2TTX88eAMxkKSs=;
        b=BaNAZAN8Ey3DxRg4kZ1FW0Knr+92LENOOrVvEW1b7mEpGbZtBjo6ZKoXdgZERe4j2f
         +EohmvdmnP0KXho1Ux+wHF+zvqgZg/a9DCNbk86vfgrKJ4aYVlqdPvyZaMO5dXerOGL6
         Jc9P5kacpUNDKRipouaPFFFBigel1xZIkBLvzBmDHkpO6p76cz6HTGVTj37Vr6ke74ob
         RQr5R5cr+vfWOrYwOUOQCm1ivgcyl4uEu+wJn9ZAxbt8OecFKgIPyhDyH47MVQuxmIfe
         WX63XPJtz06tRUYg9oOeRICMsOrnKqAbRJi201rfpNWdX6amBUw+tNBHbUIi+avzDl9X
         AyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L8DTfq0A17haA8PrzESImW0A0vAqb2TTX88eAMxkKSs=;
        b=iXO51vsAONHCyufpPs1c5HP0g5H9sFnEa3DB8gTbS3Puti9CvfVK/Jgc2ckAj0f2V/
         OnOqTsVu2lzp5JbR2a42qHxuLpKhCCGnXE2iEJbKhP5L7JRWDrKwq3LRnoutLRS/6+Qu
         wm73+ZsJbvKpyIA5GC09aYks4TTQ8kgPurw2qnhTduXHVJU6mE4pi058O7xZkygPwcu2
         CurWu3NYX+1vlaymR2Kbic8KRmFOA3jEQ5qZZTH1rwSg7kvpzKU/fGp0ZnjNntLZ6sEf
         IGmFkEu+g7ybHPbx/CZidK5LmiloyZZU7nO9zkRgxVInOfmQwyk7kCtIEWOGz7TSZC3y
         6JfQ==
X-Gm-Message-State: AJIora/c4f2OUnEXtqV5wiGrm4hCNXGWznswiy6C3vEbuhLd1ELvNqho
        d5/gr1YpI3vUa3BlMOpLI7sVaQ==
X-Google-Smtp-Source: AGRyM1tJTPfDmRl23fBqdP0m32ujrkJ0ZHgPEbSUIojL6Gcc1siGm1BZ2LGNfZluNXw7Sd4UGqL0Yw==
X-Received: by 2002:ac2:5b02:0:b0:481:286d:afdc with SMTP id v2-20020ac25b02000000b00481286dafdcmr25785099lfn.24.1657138147418;
        Wed, 06 Jul 2022 13:09:07 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id 2-20020a05651c00c200b0025bd4ec3ef2sm3472926ljr.81.2022.07.06.13.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 13:09:06 -0700 (PDT)
Message-ID: <e1fed734-8629-5bf2-60ba-ee62243def6f@linaro.org>
Date:   Wed, 6 Jul 2022 22:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] ARM: DTS: qcom: fix dtbs_check warning with new rpmcc
 clocks
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-3-ansuelsmth@gmail.com>
 <18e40247-7151-b50a-97fe-00ee88f47d9b@linaro.org>
 <62c565dc.1c69fb81.a4566.e9b2@mx.google.com>
 <bcb64218-2d2b-2f6b-dc79-303bac8c3bd3@linaro.org>
 <62c5de27.1c69fb81.c73fe.02c5@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <62c5de27.1c69fb81.c73fe.02c5@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 21:10, Christian Marangi wrote:
> On Wed, Jul 06, 2022 at 05:07:12PM +0200, Krzysztof Kozlowski wrote:
>> On 06/07/2022 12:20, Christian Marangi wrote:
>>> On Wed, Jul 06, 2022 at 09:44:04AM +0200, Krzysztof Kozlowski wrote:
>>>> On 05/07/2022 22:28, Christian Marangi wrote:
>>>>> Fix dtbs_check warning for new rpmcc Documentation changes and add the
>>>>> required clocks.
>>>>
>>>> There is no warning in the kernel, right? So the commit is not correct.
>>>>
>>>
>>> Oh ok, the warning is generated by the new Documentation.
>>
>> Patches, especially DTS, might go via different trees, so the moment DTS
>> is applied there might be no such warning.
>>
> 
> I'm still confused about this topic...
> With this kind of change, I notice I sent Documentation change and then
> rob bot complain about dtbs_check having warning...
> 
> So the correct way is to send Documentation change and fix dtbs_check
> warning in the same commit OR keep what I'm doing with sending
> Documentation changes and fix DTS in a separate commit?

Binding is almost always separate from DTS and always separate from
driver. The order depends on what you're doing. If you bring ABI break
change to bindings, then the order does not matter, because each order
will be non-bisectable. Because you broke ABI. That's the case in this
patchset.

For other cases, usually bindings patches should be the first in patchset.

How it goes via maintainer trees is not your problem here. Patches might
go together or might go separate.

Anyway it was not the topic of my comment. Comment was about not
specific commit msg which does not fit the Linux kernel process and does
not fit git history once applied by maintainer. It fits even less when
backported to stable kernels, which you commit msg encourages to do.

Best regards,
Krzysztof
