Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06E450CED5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbiDXDTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiDXDTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:19:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEEA3B299;
        Sat, 23 Apr 2022 20:16:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d15so5133044plh.2;
        Sat, 23 Apr 2022 20:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3bvurDKgvUK5gVjuAf7rLv/Q7SaVp8dMr6PwRHtYoNk=;
        b=OKwZ0zpYmQ9G0/O2HR6ljEzj7OIokLKjQxZexuo7s5z17kL1BWtCFuNp6L+kHgy3u+
         zNc5Yq9o6L8p1No89z2FIFA1oi0eAayyAaYwWQdt+vjLWNWvE+lKHYLAFMEGPjW9BSDJ
         WlKoL/lTbbigOa/tuUlXkc8dzAkf+yDYZ0EOxAVGKypGrQZnxcclJoFI0D/nmggRQByr
         ZsBp1tsVM7tZHogi2xf5MUFuYRLdOJ9nf2KTo+k+59i95O0tln/qPnxgNxbn1nX6oy34
         UnS8sbkn5ElSVs180zwnk407yGRqunrGpDO8ncX6GyRyK/aJC2EBIk4xy5ITI0Gt4rOW
         oDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3bvurDKgvUK5gVjuAf7rLv/Q7SaVp8dMr6PwRHtYoNk=;
        b=lmS01Tju1DLPZGwR+vfYTEenyblSAcBHr6x7mQatOKlH2zXgoumm6McvqbJF+B7x6L
         06+9gtqaGX1Ec+wyUr2Mk6PyVf8udarCqg/m7RSdV45yHG9cTZtcFpCDW4/abfbKhQv9
         BgzvJPVHhp8z1VcqXFTNBtdM9E16D5x+8O5cEtG5Z9efDWzr21ofP2VgSyJziZY9Nk1p
         A3fc5GGPVnvtnW0bYczMc9FkeLxnoZYqEn97d/MRI4vGOQs5+F1jhYNa11z6ci9AKW3T
         eANOEqN5rfQ742KE4pTb+zo5Tvn2yidKjOOKHgwT1nbYJu8F8E1oqnDbOOAKDin1Lm86
         khfQ==
X-Gm-Message-State: AOAM530Di3uSLAClAyB6+yAEXHxU/qf4/ITwaU4J1DV2dixOoS3qJYTP
        qWzs+EfCch73pKy5aj69tKzt5hnAgfOCffnM
X-Google-Smtp-Source: ABdhPJw8pBAvzLZVR1t6lFbi2GvrKsH/tUa5FYAeMfBHr73YfpJrxcq7gthtq8YRmSYZMbWQxXFbAQ==
X-Received: by 2002:a17:903:1d0:b0:15c:f02f:d2d6 with SMTP id e16-20020a17090301d000b0015cf02fd2d6mr3994755plh.77.1650770169003;
        Sat, 23 Apr 2022 20:16:09 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00088d00b004e1bea9c582sm7485336pfj.43.2022.04.23.20.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 20:16:08 -0700 (PDT)
Message-ID: <c498b2a7-8f0e-4f6d-10ba-49c4c7794ff9@gmail.com>
Date:   Sun, 24 Apr 2022 11:16:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
Content-Language: en-US
To:     baihaowen <baihaowen@meizu.com>, siyanteng01@gmail.com
Cc:     alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, siyanteng@loongson.cn
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com>
 <1650424016-7225-2-git-send-email-baihaowen@meizu.com>
 <30d2f96e-99e1-2976-a294-8e112166afff@gmail.com>
 <049ccac8-c394-0cdc-c2ed-4ea91cab6439@meizu.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <049ccac8-c394-0cdc-c2ed-4ea91cab6439@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/22 10:56, baihaowen wrote:
>>> +        ======          ==========      ==================
> hi, Alex
> I can apply local.
> ➜  linux-next git:(heads/next-20220421) ✗ git am doc_pageonwer_patches/0001-docs-zh_CN-sync-with-original-text-Documentation-vm-.patch
> 应用：docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
> ➜  linux-next git:(heads/next-20220421) ✗ git am doc_pageonwer_patches/0002-doc-vm-page_owner.rst-Fix-table-display-confusion.patch   
> 应用：doc/vm/page_owner.rst: Fix table display confusion
> 
> I think git send-email will change format by my select. I'll try to resend.

Send to yourself only then get it from your email client and try applying. 

Thanks
Alex
