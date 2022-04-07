Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363224F7696
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbiDGGvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241384AbiDGGvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:51:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974D9E6C5F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:49:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n6so8713703ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 23:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ig1etyDF68tf5y4+B0bKhTRY5wsKZ9GD0NtPhkq4h5I=;
        b=xrLUcHHwKuNTh4APSk1UhhZeFKYx5/K1fJIzae4MIT/Bg1RYnwCOSqstuf/ZYismFz
         3CE2yBy2HCiEUJAT/uhluRStnRmtIzabcvauHCUnncDJ8Tef7BPXRE24Slg8eoVuPEed
         Gjt/OGqI/n7/B0coJmgJrd9Sxx2WmltbunSffJZ7Avw2PXYdaqFgGx6F1GEcu7Rd9r+i
         Fw3vnDg6Ki+RhIKBcblCZ0hVP5wkbBQBAwZTDUoZVPnkzJZad9y/K6Q/zJlo6TuTbnoe
         lrCllXvX3vtSI0HhWwYw6WHEmtKRUglMA43DnsjdHGD2e2igUDPwa5MqXOMJ5ezBnman
         /JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ig1etyDF68tf5y4+B0bKhTRY5wsKZ9GD0NtPhkq4h5I=;
        b=dFKTULZgA6ABzSHfNs2rYtoKPE7qQq27HZgaVivWou2oThB05vHUxekJZCgC9PmtY2
         5UdoVFSYbaoBJVV6CwtBVl7aMqKfFDdY8D9Jz7JEd4eot6Dot4SpQPKg4BKmD6gt9cRr
         tiTBBrXXegUZ3MjyX6i+SIWUufY5OEQzmhwtkZJ+ZzuL30fOcCo2yJaLHiW6VHa+lXLd
         K7wPdm6gkzAloR0f0M3zCAjXALRElH15QYPbjcub/M22tsl05xsazjjX2/RzufASTync
         EQKfEByY3aLL8Q8YDQ+zB4aKEXyyx8xy1R9BOCm7F+D/JtOXZzV+ypcCjNap16Mm/MVd
         Vr+w==
X-Gm-Message-State: AOAM532Zq/AC5B127jw1NmY2wSxgHRluM9Wtfh09QPwinZnIAuvLiFE9
        QkzdFqhHmEuyPgiNm+HzXCuE3Tz2C4ixHO5u
X-Google-Smtp-Source: ABdhPJyI+a19I669vtBg9dpBsKeqt/6i1D7etaTUE8OFw7G4q33l4BRlM1qJgUjqaoH0PJSjKLZYdA==
X-Received: by 2002:a17:907:608d:b0:6e7:f1d1:ff42 with SMTP id ht13-20020a170907608d00b006e7f1d1ff42mr12405023ejc.620.1649314142185;
        Wed, 06 Apr 2022 23:49:02 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s10-20020a50daca000000b0041cc361b1c9sm5877690edj.68.2022.04.06.23.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 23:49:01 -0700 (PDT)
Message-ID: <594c124d-403f-56f1-b9fb-f48042d7056b@linaro.org>
Date:   Thu, 7 Apr 2022 08:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek: Correct disp_aal
 binding for MT8183
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de, airlied@linux.ie,
        yongqiang.niu@mediatek.com, jason-jh.lin@mediatek.com,
        nancy.lin@mediatek.com, allen-kh.cheng@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220406094654.29722-1-rex-bc.chen@mediatek.com>
 <20220406094654.29722-2-rex-bc.chen@mediatek.com>
 <397e30c2-18c3-93d6-16f5-b113be77f51a@linaro.org>
 <c9a54f1c9350d63489a0f85443f5623fe5d7fe1d.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c9a54f1c9350d63489a0f85443f5623fe5d7fe1d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 08:22, Rex-BC Chen wrote:
> On Wed, 2022-04-06 at 16:44 +0200, Krzysztof Kozlowski wrote:
>> On 06/04/2022 11:46, Rex-BC Chen wrote:
>>> The driver data of MT8183 and MT8173 are different.
>>> The value of has_gamma for MT8173 is true while the value of MT8183
>>> is
>>> false. Therefore, the compatible of disp_aal for MT8183 is not
>>> suitable
>>> for the compatible for MT8173.
>>
>> Just because one feature is not supported, it does not mean they are
>> incompatible, which you claim in the patch below. Are you sure they
>> are
>> really incompatible and MT8173 fallback cannot be used?
>>
>>
>> Best regards,
>> Krzysztof
> 
> Hello Krzysztof,
> 
> Thanks for your review.
> 
> The difference of disp_aal for each MediaTek SoCs is "has_gamma".
> And we only control this variable for different MediaTek SoCs.
> 
> The value of has_gamma for MT8173 is true.
> The value of has_gamma for MT8183 is false. (Moreover, the driver data
> is null for MT8183)
> 
> From this situation, I think it's not compatible between MT8173 and
> MT8183.

You repeated the commit msg without bringing any new information... but
let it be, I assume setting gamma on MTT8183 is incorrect or produces
wrong results.


Best regards,
Krzysztof
