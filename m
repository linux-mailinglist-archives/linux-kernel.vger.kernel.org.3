Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B624E3E76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiCVM3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiCVM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:29:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FF07DA9B;
        Tue, 22 Mar 2022 05:27:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o30-20020a05600c511e00b0038c9cfb79cbso1368402wms.1;
        Tue, 22 Mar 2022 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J0XVZsccyYJ9Mem2SrqqXmIc+qNVt5+LRwSBtuEfuLE=;
        b=IxAnldyyvOvUmwerKfTSKOCAqJP0C0r8dyKUmc3NAz1kFbkwbObzw8v8vjkqTSfSFz
         7XMD707GuhjuSHLhKo9yO/KhdyVgmstR9tnQh6IEohWU/d6NvCIIB7hfr1lwJ/6GSABo
         x4VvM2oiCnvSEQPeq9BenCPN8KClhOZdNSAaHpToRaL4odo/v6IlWyFbotms99cucclo
         QwUEXtLR25190rR+VE9K5F62JSM3nYKY4xwyNO6NG/hhZxyYZGk+nUT73/dOq7dsOqIX
         n0clvAkv9DnX8jTBgfD6bwUhs7BR9ecai70Yd2GnaJ7XlXfgVcKAQHkBnbKTqWI7Gzyp
         pc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J0XVZsccyYJ9Mem2SrqqXmIc+qNVt5+LRwSBtuEfuLE=;
        b=j6ddxIqMRjBUI98ELKVBClp3UK2l+Ekleq/QirYIPxnefteXBzY9lOSHx9er3kkjE0
         Idc41n8hDku+P8jduZwFO+L/ASLTqcv76L8p+2vJ4pmfo2MQ+GD5tdRzqMlxGGG0q2bX
         gmrxkpsI+S+D8uh4r4V8b6UTw0akj21W9FpZvu9r4Aom8Hs+GWGMSB/SeejF/zWJOmcF
         OanEFgBr91DgcHIX1M2khBvrTlCcUKpmZdudf4kuZfZfT+lKBOIyFzV+IojhGnzkjUSe
         gpvXWsnQ6mt7xfq74LI0IiDa8FIRZCH2hQ0wNdMp/IOEyj+vWaUUy1XHFjQTdg4yL19Z
         f8hg==
X-Gm-Message-State: AOAM530En00fdKPEDCrJsqqfVU4oV2vyxEkSUPKFDEcdrafnhlggZ3wU
        nFpVMsiyf8m3ku0JuC3fpSE=
X-Google-Smtp-Source: ABdhPJwPPP9lVN/CiF3Mv94/Ta8O9nqmFgKbmzmhJuOCfiiEhKZEsENMvCjNKKu1oNysHhLkHYsLVA==
X-Received: by 2002:a1c:7906:0:b0:38c:8cfa:cbb0 with SMTP id l6-20020a1c7906000000b0038c8cfacbb0mr3556553wme.163.1647952061411;
        Tue, 22 Mar 2022 05:27:41 -0700 (PDT)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm1323964wrf.80.2022.03.22.05.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 05:27:40 -0700 (PDT)
Message-ID: <809c40c4-068b-8296-57d9-024e6623362d@gmail.com>
Date:   Tue, 22 Mar 2022 13:27:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [patch] console_codes.4: ffix
Content-Language: en-US
To:     nick black <dankamongmen@gmail.com>
Cc:     "G. Branden Robinson" <g.branden.robinson@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
 <CAN4uE+p-uKzHNYry2YhCMfEFBQ2jUqpDAGx=+eha01w-L4fAjg@mail.gmail.com>
 <20220320160217.gws42lklp6ishzub@localhost.localdomain>
 <fd0b3fea-4b40-ffba-442f-00908a5335a9@gmail.com>
 <Yjg3jXCAsjQVHJAi@schwarzgerat.orthanc>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <Yjg3jXCAsjQVHJAi@schwarzgerat.orthanc>
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

Hi nick,

On 3/21/22 09:30, nick black wrote:
> Alejandro Colomar (man-pages) left as an exercise for the reader:
>> nick, can you please resend the patch?  I've lost the original email.
> 
> Fix up the busted OSC command list (reset palette and
> set palette). Remove CSI prefix from the list of non-CSI
> escapes. End all items of said list with periods,
> matching other sections of the page.
> 
> Signed-off-by: nick black <nickblack@linux.com>

Patch applied.
However, it's weird:  I had to apply the following to your patch before 
applying it with `git am`:

/^diff --git/s, man4, a/man4,
/^diff --git/s, man4, b/man4,
/^--- man4/s, man4, a/man4,
/^+++ man4/s, man4, b/man4,

I'm curious, how did you generate the patch?

Cheers,

Alex

> ---
>   man4/console_codes.4 | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git man4/console_codes.4 man4/console_codes.4
> index d549b76a9..001de1955 100644
> --- man4/console_codes.4
> +++ man4/console_codes.4
> @@ -139,29 +139,28 @@ T}
>   ESC 8	DECRC	T{
>   Restore state most recently saved by ESC 7.
>   T}
> -ESC [	CSI	Control sequence introducer
>   ESC %		Start sequence selecting character set
>   ESC % @		\0\0\0Select default (ISO 646 / ISO 8859-1)
>   ESC % G		\0\0\0Select UTF-8
>   ESC % 8		\0\0\0Select UTF-8 (obsolete)
>   ESC # 8	DECALN	T{
> -DEC screen alignment test \- fill screen with E's
> +DEC screen alignment test \- fill screen with E's.
>   T}
>   ESC (		T{
>   Start sequence defining G0 character set
>   (followed by one of B, 0, U, K, as below)
>   T}
>   ESC ( B		T{
> -Select default (ISO 8859-1 mapping)
> +Select default (ISO 8859-1 mapping).
>   T}
>   ESC ( 0		T{
> -Select VT100 graphics mapping
> +Select VT100 graphics mapping.
>   T}
>   ESC ( U		T{
> -Select null mapping \- straight to character ROM
> +Select null mapping \- straight to character ROM.
>   T}
>   ESC ( K		T{
> -Select user mapping \- the map that is loaded by the utility \fBmapscrn\fP(8)
> +Select user mapping \- the map that is loaded by the utility \fBmapscrn\fP(8).
>   T}
>   ESC )		T{
>   Start sequence defining G1 (followed by one of B, 0, U, K, as above).
> @@ -169,12 +168,13 @@ T}
>   ESC >	DECPNM	Set numeric keypad mode
>   ESC =	DECPAM	Set application keypad mode
>   ESC ]	OSC	T{
> -(Should be: Operating system command)
> -ESC ] P \fInrrggbb\fP: set palette, with parameter
> -given in 7 hexadecimal digits after the final P :-(.
> -Here \fIn\fP is the color (0\(en15), and \fIrrggbb\fP indicates
> +Operating System Command prefix.
> +T}
> +ESC ] R		Reset palette.
> +ESC ] P		T{
> +Set palette, with parameter given in 7 hexadecimal digits \fInrrggbb\fP after
> +the final P. Here \fIn\fP is the color (0\(en15), and \fIrrggbb\fP indicates
>   the red/green/blue values (0\(en255).
> -ESC ] R: reset palette
>   T}
>   .TE
>   .ad

-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
