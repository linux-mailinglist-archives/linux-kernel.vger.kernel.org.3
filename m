Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928E04C7B92
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiB1VNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiB1VNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:13:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AE1369C5;
        Mon, 28 Feb 2022 13:13:06 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a8so27433004ejc.8;
        Mon, 28 Feb 2022 13:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YElPQ90MzgZ5t7UF5cUawb5iNATJs1V0tAe3h48q5Ic=;
        b=VzumKY+IFEanIBWPVoBF+6QRo3fWqzDABeMzHukdxfpGhm7Qs4NeK3EDQjUwkRoPqM
         QyVYV0wukpwoIQmkDwYjT2Wefm5j+vdtSrwPwmBhZRQHv1NdI1hiCYHDDWwL+AXPCNTq
         6vEb2uH0ArT8ijMlFJe88RWa9APKVj11p4fxch0339KBmiDjqJdarsyYW8sgqiJKD1S+
         FT44Nb4ORn+Uz1Hoa0+yvqRoX+JkgxvXzg1Mn75bgqSfXFTzGarBm8yqqnm8IkbME+Il
         4psqYEpN3TLomDnWapAEnXwRwvxSMJpBIFJ2/c07Vjq567JmvS/DuzHDuRoPTk8K01Zx
         xXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YElPQ90MzgZ5t7UF5cUawb5iNATJs1V0tAe3h48q5Ic=;
        b=udt3roYVWR4aytIvaRI7XEFW27nmU8eic051L/rVCYodqEOyL58gqm7DmE4xpJVfg+
         bdBHN6SEBGj7AVjeQDKBA0VMG6NkDtIgDRxdlTeH6zbSi6ANGVbyu1Qy/VBc7YF853cZ
         ifPb1sWR3PulqRBIyxuId6r3Oj7236JDXXDnFth7TaMR9gQFfvi7i86p9H6QERvrGSmH
         VMeC/ETK3iG0am8eDnl30N81lwS2b8dGnW8IlN6uDJvcXtcyqwLPkNMTccDIlB23OwDD
         HCNBcBoiYnVqyLxhFpa//SNNjOkcHKSR31ptqjJm4+KoJlyBpVsiuajhjoPHypSYi7oC
         rzOw==
X-Gm-Message-State: AOAM533GUIAnbTUUpjVoFe7ZygVuTuXrR/BsSNsbKfIXik2bvPQ16hjr
        heVxxotRcTjCoaGJWPvUpbs=
X-Google-Smtp-Source: ABdhPJyoLznZAjc0gfKpSzx7Xn/iaaSpoiD3vjUv9rQSy6YLP//XFpDw0mqFQU2V9Q94Y/3Ca9VsJw==
X-Received: by 2002:a17:906:6b87:b0:6ce:537b:53bb with SMTP id l7-20020a1709066b8700b006ce537b53bbmr16409243ejr.51.1646082785050;
        Mon, 28 Feb 2022 13:13:05 -0800 (PST)
Received: from [192.168.2.27] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906538b00b006ae38eb0561sm4677545ejo.195.2022.02.28.13.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 13:13:04 -0800 (PST)
Message-ID: <91fe9f87-54d7-4140-4d1a-eac8e2081a7c@gmail.com>
Date:   Mon, 28 Feb 2022 22:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [dm-devel] Intel QAT on A2SDi-8C-HLN4F causes massive data
 corruption with dm-crypt + xfs
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux-Kernal <linux-kernel@vger.kernel.org>, qat-linux@intel.com,
        linux-xfs <linux-xfs@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <CACsaVZ+mt3CfdXV0_yJh7d50tRcGcRZ12j3n6-hoX2cz3+njsg@mail.gmail.com>
 <20220219210354.GF59715@dread.disaster.area>
 <CACsaVZ+LZUebtsGuiKhNV_No8fNLTv5kJywFKOigieB1cZcKUw@mail.gmail.com>
 <YhN76/ONC9qgIKQc@silpixa00400314>
 <CACsaVZJFane88cXxG_E1VkcMcJm8YVN+GDqQ2+tRYNpCf+m8zA@mail.gmail.com>
 <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 20:25, Linus Torvalds wrote:
> On Mon, Feb 28, 2022 at 12:18 AM Kyle Sanderson <kyle.leet@gmail.com> wrote:
>>
>> Makes sense - this kernel driver has been destroying users for many
>> years. I'm disappointed that this critical bricking failure isn't
>> searchable for others.
> 
> It does sound like we should just disable that driver entirely until
> it is fixed.
> 
> Or at least the configuration that can cause problems, if there is
> some particular sub-case. Although from a cursory glance and the
> noises made in this thread, it looks like it's all of the 'qat_aeads'
> cases (since that uses qat_alg_aead_enc() which can return -EAGAIN),
> which effectively means that all of the QAT stuff.
> 
> So presumably CRYPTO_DEV_QAT should just be marked as
> 
>          depends on BROKEN || COMPILE_TEST
> 
> or similar?

Yes, please! Or at least disable it in stable for now.

During the last years, we had several reports of problems with this driver
for cryptsetup/LUKS (dm-crypt with qat driver; here it is skcipher, not aead, though).

The problem with the misunderstanding of the crypto API queue has been known
to authors for some time, at least since 2020
see https://lore.kernel.org/dm-devel/20200601160418.171851200@debian-a64.vm/
and it is apparently not fixed yet.

Thanks you,
Milan
