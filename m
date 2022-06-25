Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B64155A5D2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 03:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiFYBWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 21:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiFYBWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 21:22:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450BD2981D;
        Fri, 24 Jun 2022 18:22:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so7216263pjm.4;
        Fri, 24 Jun 2022 18:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oab5pkGHNScBy29BY/vUlO/Jq0PnbUXb+Uq+pWQ2JE0=;
        b=ZC8c4XKObB3k9bs0UVISG0emAbk9MDe4QM1B/ppNDhmsQgh7XF1VG38SYp0Dtdqi3t
         bCGBFJkXloOuEyJi9CeY0rBxRM3RZfLmJG264tRknc3vQ3gXYxBn8nqxKaDWVn7Tnxnr
         0HfV37bmPr8iCpl0GnMZUl1uuK0p4pIjNLkjahHiJVzM1dc1n5NpKW6iJAErNBactvIG
         vPgRHl72tzVVT3dZNbJtjyzrm4o1onjM15VK/k6qHOATRdznUPqCaU4YXDv7xdvrnpdq
         arVUXc3y1XXoLwGJdZya4qb1/mLMBwUQO3WpakWHaucin6RIZPusL1+ZG6X5dfo4nlG5
         A2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oab5pkGHNScBy29BY/vUlO/Jq0PnbUXb+Uq+pWQ2JE0=;
        b=NJ2u1x5kArhyllLFFZk6HvHxRX1Ge+jaQl/c8f2D3TtEsDCL98M3Yd3W+Yq/X/D5XD
         gzPrt79yVQP6Gc5VmqLPgQkKgqsPGDRgb/3Q1ShiTB8+S+hrHHaqqu44eAy2+jOKMkIX
         keG77vXLfaZR3mOYkHfn2ioyWWUDdx9hH6C7HRkRsI+Gneeu/6kYCy5Anyd15ykCWquY
         BslvEkwOPlpAICdEMXxGZjU2qS33W8IFR0RKO0cjYvbUIMNFeVJhTdxbWi1XecRhW1RF
         WJ6U2WQUcFVwIGUiDUyUi4A/twt521D6LAOZBnF09eUm+yroOz7mDHAmX+qVbSZtLprN
         BYEA==
X-Gm-Message-State: AJIora/3aN2+Mc2WzUg0qdmJLRd/L2a6Swzfvfo9eB9rJqiyW5XmTJY9
        096NaRCL20+Se7A/51MfyEPNSpE98Q4=
X-Google-Smtp-Source: AGRyM1vUM6pY46Bo8PVdjR11WolOTknz75/RHApcr7a+t4Y/WZW17R+k6Ra8xR92qK3aBGNvCsfDIg==
X-Received: by 2002:a17:902:ea07:b0:16a:2833:3207 with SMTP id s7-20020a170902ea0700b0016a28333207mr1839599plg.86.1656120119602;
        Fri, 24 Jun 2022 18:21:59 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-86.three.co.id. [180.214.233.86])
        by smtp.gmail.com with ESMTPSA id i14-20020a62870e000000b005251ce498cfsm2326094pfe.191.2022.06.24.18.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 18:21:59 -0700 (PDT)
Message-ID: <0afa5acc-e78f-9920-8488-5c322312f14f@gmail.com>
Date:   Sat, 25 Jun 2022 08:21:55 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] docs/doc-guide: Mention make variable SPHINXDIRS
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
References: <50d6f0bc-030d-9529-0665-e2b3e7c792d8@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <50d6f0bc-030d-9529-0665-e2b3e7c792d8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/22 04:58, Akira Yokosawa wrote:
> +There is another make variable ``SPHINXDIRS``, which is useful when test
> +building a subset of documentation.  For example, you can build documents
> +under ``Documentation/doc-guide`` by running
> +``make SPHINXDIRS=doc-guide htmldocs``.
> +The documentation section of ``make help`` will show you the list of
> +subdirectories you can specify.
> +

What about "The list of valid subdirectories can be found in the documentation
section of ``make help``."?

-- 
An old man doll... just what I always wanted! - Clara
