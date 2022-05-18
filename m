Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDCF52B813
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiERK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiERK3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:29:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF02983E;
        Wed, 18 May 2022 03:29:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so1586234pjf.5;
        Wed, 18 May 2022 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tCR77X5KJzXzjwVu9pL91jwkBdEv1pW+cLS+PO8Vcik=;
        b=ZG7CxNZXB1xtQRfcXg33+TFzyl2P4QqbdUVJ3vNgWs+/AK+/YcM5d1RY11JGtLSTCf
         sRavJIA4qGbB4SMTs9LL0vcxd70ljZGATHfW15KLL7EGR9+5aZJlh3jD7HeP00B5Mjrk
         fz3NfUKOddVo9tKGC6k6yANp1QWRPQTNfh1eN2lAjQvozBUmjbTcQh9r2HOTJ9O4QUTC
         PFjKXNNN0sJYp43QpidAKMd8lygvpEqBVjBzwhJ6KYwqirgrH6xpkI/+eMsV8oSyUBnK
         YsRzXFj7yvthmxb/mH6ttvtL4u2aUf0jmCLp7JyoczN1aGPEKpvsUNbNH2ykADKuLtjZ
         Qw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tCR77X5KJzXzjwVu9pL91jwkBdEv1pW+cLS+PO8Vcik=;
        b=d2nzt0YPcl9OU2N3LdTVvjM0trsquc/So7UmyEnRvcgNmZAxO8MqCgXQQIZhz+ezrU
         SZ8VuhSbsJzZ50GuqSspzIKpEYEXtoF7QxMizUy1pI/x4zxHAoTX4+W0F444EgrFkCP7
         4nv2oKh7mzYFb5tAStbcXeRiMTZedTuAuiCIqFSpxR3zrw/8XLJR8NhFTjEpK1Z40uSO
         tWiAhOWVfynDOfvkeZMTjhMs8PTB8dj0aw9DOrkaxMwipk9QyjEjy8L0XVC2ed58BSYf
         4MykDzSWqeBM5H969uzPDmisrk40tNeJVKXShPTXJ3bzB/xeeiDkMV6g/cu9jmTNQi82
         JJIw==
X-Gm-Message-State: AOAM531jM8ekpUr+WekhqoCOd/qgk1NLGiQq+IY+/QrlCLFs72+sxxwe
        4aJC/8WDSulmY7/qOpRC2Zo=
X-Google-Smtp-Source: ABdhPJzzMq9lavYIL3nILBvlFRFrEwl3t2vQSvrgmETf9+0k6wMZO2R4gY1j9iUxTTULuf85aPRbGw==
X-Received: by 2002:a17:90b:3b4a:b0:1df:5451:4e5a with SMTP id ot10-20020a17090b3b4a00b001df54514e5amr16078767pjb.223.1652869749853;
        Wed, 18 May 2022 03:29:09 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id v10-20020a62a50a000000b00518285976cdsm1300073pfm.9.2022.05.18.03.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 03:29:09 -0700 (PDT)
Message-ID: <070fe87d-43a0-5e4f-e4c7-c44782c2c195@gmail.com>
Date:   Wed, 18 May 2022 18:29:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] psi: add support for multi level pressure stall
 trigger
Content-Language: en-US
To:     Chen Wandun <chenwandun@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20220516033524.3130816-1-chenwandun@huawei.com>
 <30b37eeb-e77b-882e-fc24-3367321a8ca3@gmail.com>
 <CAJuCfpE7fBsp8ntYVeLsW7Cd0Z09OmxN75X9Az_Qco0GJrz3Wg@mail.gmail.com>
 <CAJuCfpH-BDqsft1YvGFhkbR60VC0TJgfXKRVN+80e0iqQdhxpA@mail.gmail.com>
 <3a31521f-a68a-b2a9-baae-9a458ee17033@huawei.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <3a31521f-a68a-b2a9-baae-9a458ee17033@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/22 20:46, Chen Wandun wrote:
>>>> This breaks the old ABI. And why you need this new function?
>>> Both great points.
>> BTW, I think the additional max_threshold parameter could be
>> implemented in a backward compatible way so that the old API is not
>> broken:
>>
>> arg_count = sscanf(buf, "some %u %u %u", &min_threshold_us,  &arg2, &arg3);
>> if (arg_count < 2) return ERR_PTR(-EINVAL);
>> if (arg_count < 3) {
>>      max_threshold_us = INT_MAX;
>>      window_us = arg2;
>> } else {
>>      max_threshold_us = arg2;
>>      window_us = arg3;
>> }
> OK
> 
> Thanks.
>> But again, the motivation still needs to be explained.
> we want do different operation for different stall level,
> just as prev email explain, multi trigger is also OK in old
> ways, but it is a litter complex.

In fact, I am not keen for this solution, the older and newer
interface is easy to be confused by users, for some resolvable
unclear issues. It's not a good idea.

Thanks
Alex
