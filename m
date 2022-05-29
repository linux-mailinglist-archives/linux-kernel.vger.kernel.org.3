Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA9536EED
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 02:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiE2AYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 20:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiE2AYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 20:24:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0810069706;
        Sat, 28 May 2022 17:24:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m14-20020a17090a414e00b001df77d29587so10235656pjg.2;
        Sat, 28 May 2022 17:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WhyhhW2mjLf1hCJA50iP2y9QqdqAFuhCJnlod5WW0i4=;
        b=oblHbcRwHTpJ79jYSwkOP0uPrKEULYr7GZNCWZAgiJxgcWJRKC/opAygbuWCxaKTxl
         v/TAECoDC9JiK5SKjIHzlVlE9A0ZEd+ASLYP+TyN6pd864E6NQ3tTqaR3hdWWTtAEmDW
         iLd4H+thPZ8R37899q0Few2/jJUCi1uaILEkgdRp0B6ymHRsMOKyNk/w2La/Th1/LU8M
         1qGMLkMR9a7SprUQ1Xj17q5pSWe48Qt3JaNie9p7dp3AaQeow+/eZvLy+650F/Wlcuu0
         9HfXVO5rVkLnjKga3h3rzkr43NHmOQ7BtyZ8DQQ/S+VhtWfoMnC+ZTeUaDlWVuGv2tlM
         S4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WhyhhW2mjLf1hCJA50iP2y9QqdqAFuhCJnlod5WW0i4=;
        b=AOvbfVxQmWuBIA92RbpRl1x5uJkD05827d5tN+TjtYSv1Dz5nMVL7loWSG8YYVvHl5
         5i2Y/zxnPrTcZrXqvgGBJ4t1SprvXVU4O0Su+c+ChH0fDI6gnpdc460pY+0mtrlUg7xV
         DBk1zXt0gLIvsICcK9KTcrRZHm2IZIBrs30BnqPfez5nl60xJrmBfDbagG1E0wcd2H1p
         HoVZ+wcHwYSSykx/7c+gyobvCUv1DC72So8zhJHZdcLuJq8OcBqxfDNBuF4GLxHWZV9M
         OIazP6jAxIhXmtQavXCeD6VXH/wjJ4V6k3IuVjTlA1pmhHGbYeTbmnVqQmeiPFEtDjXh
         shUQ==
X-Gm-Message-State: AOAM5329KwgD8gmzAeiTA2/HioJGu3mC8dm8nMsbzG13GUalsSpMTzK0
        CKZ2ybVj/x2H7Vbk5DhI0+XACV6zFG71GA==
X-Google-Smtp-Source: ABdhPJxLMPgu43tY0eBAKBOnyufnu4z94Emg04N3tivGoaKuFGjnd364ljcNuRk7YjI5SKTh7su2Tg==
X-Received: by 2002:a17:90b:314c:b0:1e0:35e9:e6b with SMTP id ip12-20020a17090b314c00b001e035e90e6bmr15522545pjb.25.1653783845347;
        Sat, 28 May 2022 17:24:05 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id p11-20020a170903248b00b001624b1e1a7bsm6152165plw.250.2022.05.28.17.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 17:24:04 -0700 (PDT)
Message-ID: <135d2b02-a888-f3ae-ee16-ef30ab80e529@gmail.com>
Date:   Sun, 29 May 2022 07:24:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] docs: move Linux logo into a new `images` folder
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Garrett LeSage <garrett@lesage.us>,
        IFo Hancroft <contact@ifohancroft.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220528153132.8636-1-ojeda@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220528153132.8636-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/22 22:31, Miguel Ojeda wrote:
> Having assets in the top-level `Documentation` directory can make
> it harder to find the documents one needs, especially if we want
> to add more of them later on.
> 
> Instead, create a new `images` folder inside it that is used
> to hold assets such as logos.
> 

Do assets include CSS and JS files?

And if we plan to add non-image assets to images/, that directory will
be misleading. I suggest to name the directory as assets/.

-- 
An old man doll... just what I always wanted! - Clara
