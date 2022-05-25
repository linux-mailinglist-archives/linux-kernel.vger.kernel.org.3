Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250575336F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244253AbiEYGvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243504AbiEYGve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:51:34 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B476252A6;
        Tue, 24 May 2022 23:51:33 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id f2so28752790wrc.0;
        Tue, 24 May 2022 23:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qIXc7ckxpaycTNNbZsrqsqmLIc4KjcKf1nyaCXgDayU=;
        b=uL12SN4RH3iInFIny8QWfzSS2oI2DLQt15tNAqna5tkEyTJgJbWPi8ubPUABYk0aWQ
         6UYA+HdNGhXrf3m00xvfuUlkLtSJxjy7/9jUo9ITcsjZpUbYnShI6w+4tee/Wvb707Vj
         Kf855Wgqc2wpEzewM7slRBOWgzuYN7Z5gVnk1a4wctPGMMDCWf2tCkP930X4hFFvUF3B
         aL70Dzbqq0fmly+53gEIRUd+2cYE+BUhH1YVpiH3gVxHQ1jNw+PpchuFA7zsRV08v8GO
         SRBYhfiCELdHPMdWbdQkqrExixY3yMD+o45ja//6TTQ870XL69B8wATsVM+Cahts8l6Y
         tdQQ==
X-Gm-Message-State: AOAM531RHl/bDF4I3knEP+7Gu3NsGCjIZ8vbnc2Gch5jeKAgcDtinylI
        VPlBtkI5K1eIFR8x/NNKhNMRbqU0C6KVjw==
X-Google-Smtp-Source: ABdhPJzjgBw8F3g0LVeI/WFTG/JhCJXju5CTp4OT98sW0FAjmZZeiN2PfdDBVCtCtRFQm0oaJnvsew==
X-Received: by 2002:a05:6000:1861:b0:20f:c91e:bd3b with SMTP id d1-20020a056000186100b0020fc91ebd3bmr15504720wri.705.1653461491247;
        Tue, 24 May 2022 23:51:31 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600002a800b0020cd8f1d25csm1471671wry.8.2022.05.24.23.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 23:51:30 -0700 (PDT)
Message-ID: <b5c0a68d-8387-4909-beea-f70ab9e6e3d5@kernel.org>
Date:   Wed, 25 May 2022 08:51:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] linux/types.h: Remove unnecessary __bitwise__
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220315153048.621328-1-helgaas@kernel.org>
 <20220315153048.621328-2-helgaas@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220315153048.621328-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 03. 22, 16:30, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are no users of "__bitwise__" except the definition of "__bitwise".
> Remove __bitwise__ and define __bitwise directly.
> 
> This is a follow-up to 05de97003c77 ("linux/types.h: enable endian checks
> for all sparse builds").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/uapi/linux/types.h  | 5 ++---
>   tools/include/linux/types.h | 5 ++---
>   2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
> index f6d2f83cbe29..71696f424ac8 100644
> --- a/include/uapi/linux/types.h
> +++ b/include/uapi/linux/types.h
> @@ -20,11 +20,10 @@
>    */
>   
>   #ifdef __CHECKER__
> -#define __bitwise__ __attribute__((bitwise))
> +#define __bitwise	__attribute__((bitwise))
>   #else
> -#define __bitwise__
> +#define __bitwise
>   #endif
> -#define __bitwise __bitwise__

Hi,

this broke userspace, like open-iscsi:
> [   34s] In file included from session_info.h:9,
> [   34s]                  from iscsi_util.c:38:
> [   34s] ../include/iscsi_proto.h:66:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'itt_t'
> [   34s]    66 | typedef uint32_t __bitwise__ itt_t;
> [   34s]       |                              ^~~~~

It looks like we need __bitwise__ back.

thanks,
-- 
js
suse labs
