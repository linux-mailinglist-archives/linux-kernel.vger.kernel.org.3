Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01525A27EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbiHZMpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHZMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:45:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7186949B6B;
        Fri, 26 Aug 2022 05:45:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 142so1432164pfu.10;
        Fri, 26 Aug 2022 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0Jalfc0HxjKc+GE5nZWOqr4WjxcDkHgSEA8QdLd35ec=;
        b=oKAQfum6ZwPgjRwWQPsywTwMfH6I8xWCGt7lM56f6SMu4KGaU3XaXJKCFE8MUJL8tF
         wHiY2O1xf08LB6FhzXEHlXbLgEu5IYuo2peNUd8h5cGGhx2UB+rutOQOC4AvVUUcyZUh
         qw3hIejvsrec7HJphmZZdvg3Q9wGWM9lOk/FgiAUU5j0x62mcmY1vmFDhKoRjHrKXmfp
         fbJJiyz44PkSeSTgeHDfYJqCSetS3Neq3XReqMZ15VVCM9fSpsqr+FSNwVSOD6oz7dts
         zP+teGIXQJll4GShUA2tOmaCK/5mpAyEgad7/lzsPiS2S0LgBOYu+n7jB1JQ+pNrufpC
         U7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0Jalfc0HxjKc+GE5nZWOqr4WjxcDkHgSEA8QdLd35ec=;
        b=Vrb4yWmeXxD4LjyXo4zPs3W0tDBWA9t1x90Wj9sn7YsbEuMW/fhVB6OSUmfhWTKrg0
         bK9hzlf7iLMXMFXz+ghV7b/GEFd4OntJP7kL1UdDSdqka1rfA6bVkTT8s8xIpeUpe6gx
         Dopnqp0uqLjLPhL/GBK0ZBY45VeuYNcC1bTe5I4EMlskZdrWoFb+I52M76B0V4ilgSOz
         XhMmgy8ftuL42ZpF/7tu8upjbEiSsc8KpM96wCYZPhm+EBu1kbynwrZFiOMKkQxoX6bC
         7x05x2wMMfCKTYisOPjY6W1n3MC231/sNRxEaFfZDHWiezJvhPCzWv3Blmu4hgbwT3B+
         fY9g==
X-Gm-Message-State: ACgBeo1YTGuz9HCzWfpjq3Xegpm1+cYBi9aLcaLt1VZU5ySUgjiPO8cS
        8AIiQIeIe3ochYqTf2VjAvWArtXV75M=
X-Google-Smtp-Source: AA6agR792kiU/XsjiWsOKTCpmxxEDIyRUt9BD6Nu09EJ2dhEOQzfHlddIQZN6PqpjT1SD3gDt1mPCA==
X-Received: by 2002:a62:ed08:0:b0:537:17a6:57aa with SMTP id u8-20020a62ed08000000b0053717a657aamr3799562pfh.6.1661517906983;
        Fri, 26 Aug 2022 05:45:06 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id w129-20020a623087000000b0052d4afc4302sm1674409pfw.175.2022.08.26.05.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 05:45:06 -0700 (PDT)
Message-ID: <70f2a63b-fe1b-34bd-a5fd-374e2628ee60@gmail.com>
Date:   Fri, 26 Aug 2022 19:45:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] Documentation: Fix repeated words in documentation
Content-Language: en-US
To:     Jules Maselbas <jmaselbas@kalray.eu>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220826095321.21548-1-jmaselbas@kalray.eu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220826095321.21548-1-jmaselbas@kalray.eu>
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

On 8/26/22 16:52, Jules Maselbas wrote:
> Remove redundant word `the`.
> 
What about "Remove duplicated 'the' across the whole documentation"
as patch subject and/or description?

This reminds me of typofix patch bombs from @cdjrlc.com people.

> -The arguments are the same as for the the cpuhp_state_add_instance*()
> +The arguments are the same as for the cpuhp_state_add_instance*()
>  variants above.
>  

The second 'the' isn't necessary.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
