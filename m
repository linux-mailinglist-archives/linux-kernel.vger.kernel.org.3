Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771C557517F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbiGNPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiGNPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:13:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1516390F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:13:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bf9so3286020lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=trLdkjoRXYQiMPYt0cCxJMaIrIZClx412tGvql4SCjs=;
        b=OmT7iOYlyagkzx3HT14Zs8++dtALh2sdWWud2GTcgDaK8KHwr9fs0El+U+NhAsawLM
         9BsNaIwK7lwOYdPVAwd5zTo7KhzqS9yDbqLSJ4jv1pBfO4fx/N101CY7M6cgf6nFzAE6
         5rqRyQPK3RHNm5RTlFqeK9/N2TPgFBKNDzVKXBnFIUCqhDYz6bF0xBD6oY22NKun4Xrc
         dpqSoijSRzy6Pzcv7d7Use844mcFrcHxuOJHbvPFbOpi9c0KajQLJnManCP0VHPBG5Cs
         dMkfQJLAx3isfz/mnoQSDyqaQGrpYjYDEFGjlMcpOGuBMwtHATfBEdGL93r6wn21QbtT
         4gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=trLdkjoRXYQiMPYt0cCxJMaIrIZClx412tGvql4SCjs=;
        b=ziRWO1T4vJntzTErCvnGDe7n9eco8Ay9lnZ6l3YJD2h5mbnmfBfQgwUzFiRlf2PEl+
         4XGdAFEnv0resoWWZlWlwbFIKyQJtspqohbDA/2yQAu6vmyKDZJQjR+ox/1dr5yQtMVQ
         5d9k7FmqP+DkT3NYadhYc6YCNfaYBzkrIw4GByXyz8XJZMU+jbUfypsFQrJ1HJWb1HnG
         6k/faPVurXN7rEHi0hut7HF7KTefCiMpKJ25IjNlil8NHxhZ4MVu0Lg6qA8YaJPFlaNL
         Q978gwI44/aWseJYPkyEmmw4FvYBr6atYFDp+Bb4h4xkQg9ocsPU61aleQ2/GNAnSnrG
         kqWQ==
X-Gm-Message-State: AJIora8ujDBxWLVl2FkFWdqdUp8m8edbWIrpn3kG7iLoevITZFxswjJg
        FOhyzDA5MbiCI0ExF9rkyEwxiA==
X-Google-Smtp-Source: AGRyM1v99ALpj0n+3YeuvpeazIwQj8WFb71vvXSmMibv4cKrig+zeFUy6P9VjR/zAfLdBlDPUEdpAQ==
X-Received: by 2002:a05:6512:eaa:b0:489:3781:7b39 with SMTP id bi42-20020a0565120eaa00b0048937817b39mr5510977lfb.76.1657811595082;
        Thu, 14 Jul 2022 08:13:15 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id e18-20020a05651236d200b0047f72bf3c32sm399702lfs.77.2022.07.14.08.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 08:13:14 -0700 (PDT)
Message-ID: <14b0e150-511c-867a-281a-1d13e7e318e8@linaro.org>
Date:   Thu, 14 Jul 2022 17:13:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Question: regmap_field_write() - why using update?
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e759045a-bc01-c194-35ad-42b534ccaa01@linaro.org>
 <YtAxK1lIooDmdVBP@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YtAxK1lIooDmdVBP@sirena.org.uk>
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

On 14/07/2022 17:07, Mark Brown wrote:
> On Thu, Jul 14, 2022 at 05:01:29PM +0200, Krzysztof Kozlowski wrote:
> 
>> I am converting my driver using MMIO to regmap from readl/writel and to
>> my surprise I found that regmap_field_write() does not behave the same
>> as regmap_write(). I would expect that they are the same, except one
>> operates on fields.
> 
>> However regmap_field_write() uses an update method [1] which means it
>> reads and performs update. regmap_write() simply writes without a read.
> 
>> I find it inconsistent and a bit confusing. Any reasons for such
>> behavior so I won't send a patch which breaks 100 of devices?
> 
> How would you propose to write to a field without reading the rest of
> the bits in the register?  Otherwise you'd be doing a full register
> write rather than just a write to the specific field.

Indeed, I forgot about bits in a field... So it has to be like this or I
need to use regmap_write(). I find the regmap field API very useful for
devices with different register layouts, but the actual "fields" part is
not really needed in my case.

Best regards,
Krzysztof
