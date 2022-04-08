Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34D34F9474
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiDHLvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiDHLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:51:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF02217396
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:49:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b24so9727179edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=he3gdObBOBoinobd6bETaG2orN7yh1mXFF6rOA4GggQ=;
        b=igbEum0h0bneYqp5ZVIe0c5/1vrQ8x3yXTwOQUhN7ejBCzqIjtSNqheea8HI9IA+ir
         5kxQ9j7xw4bALYjvc3IBxdahLmf2fjsOu76cSDshPwgLul0h0dOiUL6Tjhd1oZnnKUfP
         TwNn0dICJHXo44ixZj7h5/GyKe1TwRYUOxC8cUP8EPzh/IU+sjMBkYlyj+OTaPmo+0eP
         EF5nm02LnOvVJu08CDR1lGSBn70cfah1rM8JqWihYZppDCNQ+hPS9jHPkVVseEFszO49
         lOX5NhIkE04pAoRtUlQLBStMVVULzaSIcetB3l1xg0hho8kjIZhXmJ9DPzQT1Hhbtn86
         bfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=he3gdObBOBoinobd6bETaG2orN7yh1mXFF6rOA4GggQ=;
        b=KK1DtHNbIzsxFy5Qh41jRC4QYB7R/iQr7CCI+kjjnyPs3sxRLsdeWW0a8df3sAhy1A
         2NjkQH1fDQFP7jN+8TZzrkDR76JYOPZNCpDXV1ckSi5hsbQ3Af9ZI7VWF+H617nurBxx
         y35uTCeny3ZLYHx22b43yCNQJqoMxLr3gab6aePtZl44mYP+fYi7ACrpycYPMOsq1RgD
         vH5hNOwEbuCtmpLAsbV5dvrHRAYsdJ06p5kwtDly6t9wySIkh7QEbOC8K2AZqZyU69Qy
         AKD6UZdn+Fz/Gmv51bygbtJFEIr1Q/agMUoZw8G0cEm3QO4yqrkX0lxqClBqCEUbiVsn
         YI0g==
X-Gm-Message-State: AOAM530dsCsjJuv8zwY94iX24jyelbjF6q+nX7tzZ51WSkGNHPmFB1Fi
        c9nhDZ0ofyB+eDfonz9XRXTCdA==
X-Google-Smtp-Source: ABdhPJxdwi31EfPDB0YNNE36knwLNszHrlfTbQLlYH+xudC85hES0Ah3kL8bq7rqTOWxg1QWmV1wpQ==
X-Received: by 2002:a05:6402:202a:b0:41c:d9b0:e519 with SMTP id ay10-20020a056402202a00b0041cd9b0e519mr18716253edb.361.1649418542587;
        Fri, 08 Apr 2022 04:49:02 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k26-20020a056402049a00b004197b0867e0sm10349194edv.42.2022.04.08.04.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 04:49:02 -0700 (PDT)
Message-ID: <0ef8f2c3-fd16-041b-3304-b167a2a36ff9@linaro.org>
Date:   Fri, 8 Apr 2022 13:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 01/15] dt-bindings: cpufreq: mediatek: Add MediaTek CCI
 property
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-2-rex-bc.chen@mediatek.com>
 <a171f33c-cda1-8602-ac67-93076b676578@linaro.org>
 <8d466903d42dbc823f4d0a245378d983ab904435.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8d466903d42dbc823f4d0a245378d983ab904435.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 12:24, Rex-BC Chen wrote:
>>
>> You need to describe the type. I am a bit confused whether this is a
>> cci
>> (so cci-control-port property?) or an interconnect (so interconnect
>> property)... It does not look like a generic property, so you need
>> vendor prefix.
> 
> Hello Krzysztof,
> 
> Thanks for your review.
> 
> Yes, this cci is not arm's cci (cci-control-port property), and it's
> mediatek's cci. I will revise this name to "mtk-cci" in next version.

Vendor is "mediatek" and comma comes after it. See devicetree spec
paragraph 2.3.1.

> 
>>
>>> +       For details, please refer to
>>> +       Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
>>
>> Such file does not exist.
> 
> This mediatek cci is still upstreaming in this patch:
> message-id:20220408052150.22536-2-johnson.wang@mediatek.com
> 
> Do you have suggestion that I should put this reference?

> Or I just remove it and describe the mediatek cci in detail?

It's ok, but you need to keep path/filename updated.


Best regards,
Krzysztof
