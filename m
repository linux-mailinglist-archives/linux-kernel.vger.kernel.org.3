Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B450F564E7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiGDHPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiGDHPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:15:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342C325CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:15:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a13so14210426lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0zQwqwpBBc1QAR7of528D9S7i3SjmvMLzqYgYjJky3I=;
        b=TOPXp9sN6jTCy+JEWnhSCMg/5ZuWMa+RT+y+ck6KKQ5q4xzWfkq84SP10yL9j7iQW3
         mOuqFs2pjAPJq6Snq2e0+SuCqPKTwu/tszb/LymE7etFIzReXQxSJZOYR9Rz0az4/hGJ
         6s3D8yOtTr3/S56ORmhMmRCCtLT3ShXoGbG6s7R9HpKszKux47b0d8SBCmECbv+PYbXN
         uL/wSep+k7zGxsWrDvMYwSnHP5kKmfoBYGljggQUquzYbsJosA+CC5+Ihc47tUWNJZ9c
         4NWb9O2vwwzuSdmV0hmFebKCrb3iea/v01/BgGtrt+M/h2LJwBwWS8wZ4ciPF4GDrpr8
         kFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0zQwqwpBBc1QAR7of528D9S7i3SjmvMLzqYgYjJky3I=;
        b=W2ZPrHlQQXQdMHzHONqUouCLAftnU8llnX6fNIQopwlHRZdglJZd4BtwhAxpoivETI
         6gP7jc2eFRtkrezAFGc56BvWeq3kpeUYVci44an2ut5XjrIN0YC8GQEH3ulqH0pfvIny
         Ng4ZsMV5Qm496SIAY+/VabTWZnbNGW0PZlA/n6CDeZ18x7IUASCbTM0tj1hzB38Cx8WX
         6Qhrp0UNLXKVUreT+DTR3mOXfHE72RcqiyH7ntemj1ZIl8QdGKZhN60kNVDDNOB20Vje
         nRSrkMKO+vmSSpZEiZBSyvsxcs8Hci5GEoJFT2O6RCzeOqhfXV8ueZLHHoJzNYWb+wXW
         Te2A==
X-Gm-Message-State: AJIora8scqTDgln9+Q9EgT946NGxjJlsmJElg3XT3VyKiDoxgPtJ9AT7
        za+v4KLK7SUK9no4inowOHNaFA==
X-Google-Smtp-Source: AGRyM1v0A72LG09lFlL9o6sOBN4Jr3XAWn+A5XiB6W+gWXbzThDuf1ncjuQg/ZF3PottAzEos1s8Ow==
X-Received: by 2002:a05:6512:32ca:b0:47f:942f:26ca with SMTP id f10-20020a05651232ca00b0047f942f26camr18703338lfg.632.1656918916486;
        Mon, 04 Jul 2022 00:15:16 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id bj16-20020a2eaa90000000b0025d254180d7sm166350ljb.113.2022.07.04.00.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 00:15:16 -0700 (PDT)
Message-ID: <1482ae3d-7841-beca-3fa4-7e2519944086@linaro.org>
Date:   Mon, 4 Jul 2022 09:15:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: manual merge of the dt-krzk tree with the qcom tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220704121133.33f82aea@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704121133.33f82aea@canb.auug.org.au>
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

On 04/07/2022 04:11, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the dt-krzk tree got a conflict in:
> 
>   Documentation/devicetree/bindings/arm/qcom.yaml
> 
> between commit:
> 
>   bbd5a6891908 ("dt-bindings: arm: qcom: document sda660 SoC and ifc6560 board")
> 
> from the qcom tree and commit:
> 
>   4fc3efba3205 ("dt-bindings: arm: qcom: add missing SDM630 board compatibles")
> 
> from the dt-krzk tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This

Thanks, looks good.

Bjorn,

There is more and more of dt-bindings work pending on my board patchset
(part of this pull). I think we talked that you will pull it?


Best regards,
Krzysztof
