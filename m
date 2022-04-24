Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2721E50D247
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiDXOh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiDXOhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:37:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB11233A18
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:34:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g20so15680962edw.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+IvreAFlZ7WN1oSh6mz8g0KZPjFboEMtyxdYXlqR+YE=;
        b=Ipg2a/WrYl020qSef2xIrztFmw2oE8T58hCAT35PInriSj0D56ksqS7VDmFLgviXJX
         Ice0CBq08htvPn8/d6vUxQNRlRJ7dHRqk/jJIt/6daoKzbjtVP+OQnrZifOZhLOnZ043
         hQzb9WYUXHwp405jlUUZiXkcbd9ms4dNAtjMHSaElujpVf0S+f5vOrTdWUr/TBta0zYv
         9LLkVNsTHliu8ljLe0dgzRCUlEncQSSKYs1LzQawwpccWuIqZcgMvsmHmz9JWR+D5RU3
         O4F8EnWE0sDiczy/0feGtEigLfkp1VUT8DYUSQ1xUh7GZk6nLOKky7kiEbrwFrz/ubYP
         gCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+IvreAFlZ7WN1oSh6mz8g0KZPjFboEMtyxdYXlqR+YE=;
        b=q4rYS9IdCZoX9lsJMCaLW074LgAwAEDOHBLrejzIq0hmwKe1L6aq4zGF4r/a2Xp14K
         4L3UBdAPirsSdfK8wzThooIOgWqytD2IPR3n395eEqnfdYngePTnKfNXaRwyi/O9GhoH
         1UZj9nBQbOAvbiD6Q5sd8EOXl21OgnzkIP+MRIkcL7vHwQlJNbuGRWoq8exrcdAuUVTd
         lc94QVvHOJm1ZiBR+Rf9Nt8GOe8/TWzpeMjIpsn/vEy/xvwsXlL5OkKJ9jC6n0H/Ekjc
         olLokqH+Lf3j9oWsPPevEBkMybCSCRArUIL/KFvg8SjCtOQd5DyagDILiGFJtyM53gJ5
         qOUw==
X-Gm-Message-State: AOAM5322PbnvpEibUHttGcX3VYIQIub07hIgBYVuQwfcj+l8Ie/h6gfX
        qWmaIb/tnE5EjSdBJEkfUAP/63fKxw0hiQ==
X-Google-Smtp-Source: ABdhPJzzsu4vRs/Z/xkWPmrBGOmgzzRujE4OVmNwYy6mi28SnMI9uYv/8FN3JlyozQ8KHS7wjC0/Lw==
X-Received: by 2002:a05:6402:209:b0:416:5211:841f with SMTP id t9-20020a056402020900b004165211841fmr14594595edv.59.1650810888302;
        Sun, 24 Apr 2022 07:34:48 -0700 (PDT)
Received: from [192.168.0.235] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906074600b006efc5a283b4sm2664832ejb.89.2022.04.24.07.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 07:34:47 -0700 (PDT)
Message-ID: <47ccfe2d-5b96-2a76-90b7-6c3679dcec27@linaro.org>
Date:   Sun, 24 Apr 2022 16:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v7 3/4] dt-bindings: memory: Update reg/reg-names
 validation
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, Rob Herring <robh@kernel.org>
Cc:     dmitry.osipenko@collabora.com, digetx@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220413094012.13589-1-amhetre@nvidia.com>
 <20220413094012.13589-4-amhetre@nvidia.com>
 <YlbSGEBKgpVC51dZ@robh.at.kernel.org>
 <60db2153-2d78-646c-1e5e-e89346991b0c@nvidia.com>
 <011311d4-7139-c10c-edd7-119f5466469e@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <011311d4-7139-c10c-edd7-119f5466469e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 07:20, Ashish Mhetre wrote:
>>>
>>> New, added properties cannot be required. That's an ABI break.
>>>
>> This is handled in driver code to make sure driver works with old dts
>> as well. So is this bindings change fine or shall I change it such that
>> dt bindings check shall pass with older dts as well?
>> Or as mentioned by Dmitry, I can update the commit message to reflect
>> that ABI change is intended and driver is compatible with older DTBs as
>> well.
>>
> Hi Rob,
> Can you please confirm how shall I go in next version?
> Is it fine for dt bindings check to fail if driver is compatible with
> old as well as new dts? Or dt bindings check shall pass with old as
> well as new dts?
The driver works fine without reg-names and accepts old DTB, right? In
such case, just mention this in commit msg, that the bindings require
reg-names but backwards compatibility will be preserved in the driver. I
think it's fine to alter bindings such way.

Best regards,
Krzysztof
