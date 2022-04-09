Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805024FA82A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiDINW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbiDINWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:22:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0B2B7C8;
        Sat,  9 Apr 2022 06:20:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id q14so14628771ljc.12;
        Sat, 09 Apr 2022 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2IYDe10dmsGy8DJcaB3vGWy7J8LhPKTO6Cy2zoRK/ho=;
        b=mt++UCES/exeXjRVb7JPbS3ZpWcOYQXe3eKjgYEAFS5DUVNUDSulsQ5FgaDVplCXiC
         KZcGfJH8V52LSkVPb7LCbOF+vWcVODy6iXS4T1iRTkcVs8DvdHD2pDqDBBweVW9W3MZ/
         cdJYn+WovG1sDY+XNVYyhIAuXjzpP+9bc4k5fggvVY20NxVdZiQ2/9iolFmCx7rZiMtH
         b5MNtWORQFQuM/yFkRa6cgthe7iCHumWCc6XUDX5wG9D4pAW6K6W20NH2NnIkfLIN3sW
         2b4GZgPyjT+lZKGB4giCgOnBv5rBp4QHkSaf4y0AAP0lHffRiFg/ofy1R5BBq5Ys7cC0
         wNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2IYDe10dmsGy8DJcaB3vGWy7J8LhPKTO6Cy2zoRK/ho=;
        b=qYO/K1E6UJE6F5xAZ6TYkcVolMfiWsbKp8t0dh/1A/CaRChja4XNKgTHnoLsA7yCte
         /+cW8aoQo8MzfATTFljUxFSbMfmTs8v98NWNZpFtErGhdHVqzLm+0FppiNOlswAc5QbE
         cIV9rXy9dxALTomiBtTY3Idt0D9sbwZd4qIdJYvbNt0unpRE9uKQVIs0ikYK5My+lxhX
         vNI/R77BulhU+MXukIAzICHNLWnWnzHvytQvHMqzRkBUYp2CGebN3RLMq0ChMnpDK04I
         Z+S/2/Jshqz+HYotc3S0m/5Lc1szSXmPlQiz6jLsl7RqFcscp/19d8lYkbnJG7hzceyp
         qoxg==
X-Gm-Message-State: AOAM533rsBoTNS5+KRHXu3lDQNCYOXY1PWiQR1jxpLRCDtFH+21DTvy0
        IVZZNSZ8GLQPVFdQ8Z45QHs=
X-Google-Smtp-Source: ABdhPJyJy8HuDMh8C0fCMF8KqYpun+F3VqSjI45xB1lID679uOi5hdADtkguk2UcWKQritzJA7ggGA==
X-Received: by 2002:a2e:81da:0:b0:24b:4e65:e3e0 with SMTP id s26-20020a2e81da000000b0024b4e65e3e0mr4934755ljg.483.1649510432658;
        Sat, 09 Apr 2022 06:20:32 -0700 (PDT)
Received: from [192.168.31.104] (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id s11-20020a2e9c0b000000b0024ace83744asm2527195lji.116.2022.04.09.06.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:20:32 -0700 (PDT)
Message-ID: <446a3e88-4c14-300d-862a-1279274c3760@gmail.com>
Date:   Sat, 9 Apr 2022 15:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] block: Remove redundant assignments
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, llvm@lists.linux.dev
References: <20220409101933.207157-1-michalorzel.eng@gmail.com>
 <20220409101933.207157-2-michalorzel.eng@gmail.com>
 <a56d1184-d399-d5f8-765f-5a4f35dacd5e@redhat.com>
From:   Michal Orzel <michalorzel.eng@gmail.com>
In-Reply-To: <a56d1184-d399-d5f8-765f-5a4f35dacd5e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

> 
> On 4/9/22 3:19 AM, Michal Orzel wrote:
>> Get rid of redundant assignments which end up in values not being
>> read either because they are overwritten or the function ends.
> 
> This log is the same as your last patch.
> 
> Instead of a general statement on deadstores, a more specific
> 
> analysis of the setting being removed would be helpful.
> 
> This will mean splitting the patch to match the analysis.
> 
> Tom
> 

I think that this explanation in a commit is enough for such a trivial patch.
It informs that we are fixing clang-tidy findings related to deadstores
in a block subsystem. What analysis would you want to see?
Something like "Remove deadstore assignment ret = -EINVAL  in a function bio_map_user_iov" ?
I think that it will create too much of not needed overhead.

Cheers,
Michal
