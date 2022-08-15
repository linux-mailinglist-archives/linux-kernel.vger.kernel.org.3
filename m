Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC345937C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245373AbiHOTEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245196AbiHOTBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:01:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A464B0E0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:32:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so15197595pjm.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8bJQmDi/lCA9PqirReS3MPMutajyKB5RDjNh4fqCzaA=;
        b=jdED2coZKjWQwnNfe6vINVdrNYG/s4Ap5/xy5Gcip3nOeogSVmoaiJccuFjEMCn604
         aiAZAQA12xrgovQ0EK7RmswbJp8NFIGlbMK7CJIoj829dlR/YYKVOetZHn6kiWBGYqVw
         iKFOwG4d+6zBCeFAM+4iDS7+9tD9UBi/j3bzxO26XKdYiOx4BB2DNlOWrPLyESziZRHe
         LEaQNj92ErOuotlQ1magSPuxiMp4HGWT4qlqOjqs26rIJlOdgx2ohKm85mKBuL0W3Xiz
         UuCSlnwEL0+m8YK540p/n30zlzjGqOSmL/ZEk6NbS6E6meNvlkJSA2GfQZf+c2O2OWU8
         uGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8bJQmDi/lCA9PqirReS3MPMutajyKB5RDjNh4fqCzaA=;
        b=X1z9HjMoXjJumWqSQUpfPPbZll+rvhGnJ/wEoQ3mDnTsZpwPuBfOdJdxGUqUfS7DWP
         dLTAUXAV+1gG1lnWMYjibb5hJRZNEvDV9HkqOHvQy+K06ryCmkpEOHDMIjrRTu4Xxsng
         fsIUdhB/Z0biPh40wF6GiXXp6dpbKOy8qcLgJO0n0OrihHfw+wGGEHyg5uYZBGL5uo0/
         Nd47CXQgnRuAPhCi9VE6p5kDx3EA69lfJ1aQRZcOzCl8rJisAagnA257sWN7QJuqLhH7
         6z/Sl+oAuhSuJWtthe204wtdNyzyjaXQ7jJ/Witmn1l1m5GN8pZuxbl8M2eoYDfUcrAG
         8oRQ==
X-Gm-Message-State: ACgBeo1F5milE6JG/nOwQVGNL96dceEdZwzVnM/mfiOj6x5XNU/TNO0/
        hhF7b9YcWB1eH7OPvVgBVUg=
X-Google-Smtp-Source: AA6agR6Clbh4D6hp8u1BwYfWLa6d/Cwe/QwEr2ontSg2+IYjxn4HZJNCGeWwoDVqjl6HR/cTznhCPA==
X-Received: by 2002:a17:902:c201:b0:172:6c9d:14b9 with SMTP id 1-20020a170902c20100b001726c9d14b9mr7195297pll.161.1660588374426;
        Mon, 15 Aug 2022 11:32:54 -0700 (PDT)
Received: from [192.168.0.110] ([103.159.189.148])
        by smtp.gmail.com with ESMTPSA id 200-20020a6216d1000000b005289fad1bbesm7034667pfw.94.2022.08.15.11.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 11:32:53 -0700 (PDT)
Message-ID: <83820e90-04ac-16cd-b5be-87e1a0bbfca8@gmail.com>
Date:   Tue, 16 Aug 2022 00:32:46 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH linux-next] drm/amdgpu/vcn: Remove unused assignment in
 vcn_v4_0_stop
Content-Language: en-US
To:     "Dong, Ruijing" <Ruijing.Dong@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Zhu, James" <James.Zhu@amd.com>,
        "Jiang, Sonny" <Sonny.Jiang@amd.com>,
        Wan Jiabing <wanjiabing@vivo.com>, "Liu, Leo" <Leo.Liu@amd.com>
References: <20220815070056.10816-1-khalid.masum.92@gmail.com>
 <SJ1PR12MB61944B1D53330D5E9531158695689@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <86088c17-585c-4a53-312d-ef339b824538@gmail.com>
 <SJ1PR12MB6194C83D51101ACD97B55F0295689@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <f8734af1-6e31-75c9-9556-9519709284f1@gmail.com>
 <SJ1PR12MB6194033EC36251B95A6737A095689@SJ1PR12MB6194.namprd12.prod.outlook.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
In-Reply-To: <SJ1PR12MB6194033EC36251B95A6737A095689@SJ1PR12MB6194.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 22:00, Dong, Ruijing wrote:
> [AMD Official Use Only - General]
> 
> Then please update commit message, this change is due to "value r is never used, and remove unnecessary assignment", that makes sense to me.
> 
> Thanks
> Ruijing
> 
Greg also pointed out that the function vcn_v4_0_stop_dpg_mode should 
return void. I shall send a patch shortly with these two changes. Thanks 
for your suggestion.

Thanks,
   -- Khalid Masum
