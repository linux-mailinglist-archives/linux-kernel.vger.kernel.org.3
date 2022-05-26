Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9367C534C21
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244881AbiEZJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiEZJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:00:58 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9619AA7E39;
        Thu, 26 May 2022 02:00:57 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id f21so1696723ejh.11;
        Thu, 26 May 2022 02:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sjBm94r+SZCpqMEtFTlHZhDX0lygeSCfuwzmdT2Wqlk=;
        b=6C+W6A8XmfgMmb8aPF2SRZh4gN0TaqzULFWf8gsRbuSSq86nIoC3D+eTuN6Rwp5uYG
         1Z0Uoi8pOVJdx1Tr1BxeLiH1J7nBy6iIgPnGwNkpmi6Enlrg8GW7ntNM0CP29HxLjXP0
         V0hTjsJivA1iYVgbDs/oAOpneglsr9H+ymGvGVZWI+D6fylFpl6FZWNf57dd7Uiehavn
         rLUatSCCtkjz/1t05lR1HEyuLbLtUK7lXwJiH+ElYucLPFxgNhT7616C4vylwqhYNFh0
         4SQZDX3+e90pZ+Z2+ceACvskD8L/aoz0SfLzlrGRvrLIrBOtk80EAPw65RnQ8bw5U5nz
         LnoQ==
X-Gm-Message-State: AOAM533QXPiTWIFd8GZm6+1yNsf7pTVhPb4TOMpAtlWRQhQAgVzbx7Iv
        tPEVeHtokyEaNhP+dNr5A/A=
X-Google-Smtp-Source: ABdhPJxqjGaQdiFgCf1SGM3twv9W4CPY5SZ9hMzvvBpbF/H5q4uJ7jgeabbmL+dxHb8NZ/SKb9eVbQ==
X-Received: by 2002:a17:906:49c6:b0:6fe:95bb:93cc with SMTP id w6-20020a17090649c600b006fe95bb93ccmr32272454ejv.30.1653555656059;
        Thu, 26 May 2022 02:00:56 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id a24-20020a056402237800b0042ae4dea360sm511221eda.63.2022.05.26.02.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 02:00:55 -0700 (PDT)
Message-ID: <ef79f546-0d10-f603-ccbe-789ed021943c@kernel.org>
Date:   Thu, 26 May 2022 11:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] Revert "linux/types.h: remove unnecessary __bitwise__"
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, llvm@lists.linux.dev,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220525144638.293934-1-helgaas@kernel.org>
 <CAHk-=whk=ygWsxt=1HhndCwjtXdga9sPmkxFGby5PJWRk5yx9Q@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAHk-=whk=ygWsxt=1HhndCwjtXdga9sPmkxFGby5PJWRk5yx9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 05. 22, 18:02, Linus Torvalds wrote:
> On Wed, May 25, 2022 at 7:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> This reverts commit c724c866bb70cb8c607081a26823a1f0ebde4387.
>>
>> Jiri Slaby reported that c724c866bb70 ("linux/types.h: remove unnecessary
>> __bitwise__") broke userspace, including open-iscsi, because it uses
>> __bitwise__.
>>
>> Restore the __bitwise__ definition.
> 
> Hmm.
> 
> Presumably it's only the uapi case that actually wants to re-instate it.
> 
> And I'd rather make that "__bitwise__" case explicitly special, with a
> comment about why it exists when the kernel itself doesn't use it.
> 
> IOW, rather than the revert, maybe something like the below
> (whitespace-damaged) instead?
> 
> Jiri, does something like this work for you?

Yes, thanks.

> ---
>   include/uapi/linux/types.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
> index c4dc597f3dcf..308433be33c2 100644
> --- a/include/uapi/linux/types.h
> +++ b/include/uapi/linux/types.h
> @@ -26,6 +26,9 @@
>   #define __bitwise
>   #endif
> 
> +/* The kernel doesn't use this legacy form, but user space does */
> +#define __bitwise__ __bitwise
> +
>   typedef __u16 __bitwise __le16;
>   typedef __u16 __bitwise __be16;
>   typedef __u32 __bitwise __le32;


-- 
js
suse labs
