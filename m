Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C3552B0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 05:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiERDXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 23:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiERDXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 23:23:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B552E6B7D1;
        Tue, 17 May 2022 20:23:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i1so568249plg.7;
        Tue, 17 May 2022 20:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A7qjxbV5ccZJoe1So3Vum/fwudHwqptCH4mNhXLjotw=;
        b=Z/3OC5GwuTiGw/CfXcsXqXM50Kjl+mSfvXZ+gcI7awvPPAyZUIu/jQPQ6jAW28NSP0
         I7vXTWwG7GPYiTbONaA4iunoJFDz2WuILxUD/2VarW4Dko4TLq9442rH9qq0y3doYKRm
         8zQaXE0qa3qqLsPpQP4PI8qpavEHU9bnquMWMjkbsrCPOTrWDvhnBDMBQDa9ohC3TNIt
         mO2jK69RVKPNBOYGhJsHQOUD2xDeNcQ6BAbDx7ceejOuv6OCWHptfMSUC4pvkgkzM00O
         96oj4W2y2GcuGbpod/7EjG6Fagrekbsgio/M3VBtHcGE2/5jNXm9ctpS12fbl+AZWaEH
         +52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A7qjxbV5ccZJoe1So3Vum/fwudHwqptCH4mNhXLjotw=;
        b=WDu+Vtu9f5EouYHFN0UfQlLmPfut8a3e4cc37l2qUEGxVGK1PLrHTR65GYJJzjgngf
         F3/kBetBnKDiD3lMSjWJ04KlUAxtU/zUO4+CwBsdbRUzWRCc1qGJKZapWBxV5RzQhhyk
         qaGcgBgcomYXMKIX8Q7eQTD9SEq+s+JAxcFsTI9o6zOxB82bgw/2Ko8Z4zfn8dhRcaIs
         q3PlyAQnIReiNk8TK8py23hlgiH4xmGsieGPBAs5iqjGmf+h8zWNZrR51EDMJHTGPy0A
         wSgdjStTitcZs1Q4P7FUVZeGMqJ7FWYEhCES4PKKWuIzvyL/8NBTSa28euvy0QLN7KfQ
         Y4Zw==
X-Gm-Message-State: AOAM531MvDctoVDpLu9gtU78hqvpBf4VoDvwK+gpEz1WDyHqMnZznlrm
        3kD88y+woPibiziA86SQf78=
X-Google-Smtp-Source: ABdhPJw9C8U0ZQmZFDNoFJdQJVk4VcQE6g7z15+QGM7xxM0rvE9jGc3OPLYLlYrEC99lGScNnMI1kQ==
X-Received: by 2002:a17:903:41c5:b0:15e:a7b6:e031 with SMTP id u5-20020a17090341c500b0015ea7b6e031mr25335717ple.82.1652844212221;
        Tue, 17 May 2022 20:23:32 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-63.three.co.id. [116.206.12.63])
        by smtp.gmail.com with ESMTPSA id r12-20020a170903020c00b0015e8d4eb2d2sm340025plh.284.2022.05.17.20.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 20:23:31 -0700 (PDT)
Message-ID: <b159beea-c7ab-b175-26c2-496f82443470@gmail.com>
Date:   Wed, 18 May 2022 10:23:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: linux-next: build warning after merge of the chrome-platform tree
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220516213832.19127535@canb.auug.org.au>
 <5d148732-c14d-4e96-f8fc-31acc8932534@collabora.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <5d148732-c14d-4e96-f8fc-31acc8932534@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 20:09, Muhammad Usama Anjum wrote:
> I've found these warnings in local build. But I'm unable to fix them.
> Apparently, there doesn't seem any unexpected indentation. This kind of
> same warnings have also appeared on some more files before this commit
> without any reason.
> 

Hi,

I've figured out the fix on [1]. Please review.

[1]: https://lore.kernel.org/linux-next/20220518031750.21923-2-bagasdotme@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara
