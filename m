Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B6C5880C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiHBRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiHBRHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:07:47 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B3139BB0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:07:45 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id w29so10783876qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6iYgJx1j8ZAFmZN+rJNmYGmMPmy0JicrvsAPug+G8to=;
        b=arrN66fcx5wmQ4e9+DB/J4OegStyVrVZaNZd2gDnH14ow8qoHFAJ98xCwc10dryqiH
         PwgpausrHSvt2oeqVHG5AQO+qExeZX7KCPmQTHDRiYGC7mMgKu8ao8dRjPhwUnxN4reT
         hWoNtSrOE5sioo7yx+TYW5Jc6NGNQP7adYRi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6iYgJx1j8ZAFmZN+rJNmYGmMPmy0JicrvsAPug+G8to=;
        b=UzT2/eA+U28Xtw920SA82R/6b6zx1xz+2RPn93dbAg2hcCipF+XPIbEvXF8I5/MbWh
         FOvCqIIJetruBOgXbYEZEYw1pS/QguSbqFdgvClZHtNj/QMf9t8ALKjR3f+fW9x52ZMq
         wihve/Da7KTZv9L8i7q/6/ufXwRcpgFRgRxkxjq2r4MKd2Odd8j+K5AuhnRU6ofpY65p
         7Z30NkoPjNuLHB8OzDWi13RlBUZTUHFzOGCE0EgluUjtwF23sx1qVySBKiNKQSk28e2G
         HJ2LFcFDEr1jWnnymObhQKhgntj4rdgoa7pHY+q5XPgVkvwQOF5bpCA9MQJrDv+imj7t
         qR6g==
X-Gm-Message-State: AJIora8dOBaycRnZMqKeZW+NvWgDBvTpNBugXWvsnIrxMDIjA8Ra6w/R
        Y4plLz/NufxNqc/UEvhNsVSWog==
X-Google-Smtp-Source: AGRyM1tLzqSsLOMhbc4MMreTdenPj/0I/eaai6L2Pfb70hcXUOiPV21mlgoIzsV68cxAkC/TfTctBw==
X-Received: by 2002:a05:622a:cf:b0:31f:28ac:a8d0 with SMTP id p15-20020a05622a00cf00b0031f28aca8d0mr20050650qtw.581.1659460065100;
        Tue, 02 Aug 2022 10:07:45 -0700 (PDT)
Received: from nitro.local (host-142-67-156-76.public.eastlink.ca. [142.67.156.76])
        by smtp.gmail.com with ESMTPSA id r11-20020ae9d60b000000b006b5869c1525sm10927961qkk.21.2022.08.02.10.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:07:44 -0700 (PDT)
Date:   Tue, 2 Aug 2022 13:07:42 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Wu XiangCheng <wu.xiangcheng@linux.dev>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 1/5] maintainer-pgp-guide: use key terminology
 consistent with upstream
Message-ID: <20220802170742.uujvf7clztfpasqu@nitro.local>
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
 <20220727-docs-pgp-guide-v1-1-c48fb06cb9af@linuxfoundation.org>
 <YuUuQ9shkkY7gco4@bobwxc.mipc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuUuQ9shkkY7gco4@bobwxc.mipc>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 09:12:35PM +0800, Wu XiangCheng wrote:
> They use "primary key" in their interface and document.
> 
> For example in their .po file:
> 
> msgid "Note: The public primary key and all its subkeys will be deleted.\n"
> msgid "using subkey %s instead of primary key %s\n"
> 
> Also in gnupg/doc/gpg.texi:
> 
> By specifying the key to export using a key ID or a fingerprint
> suffixed with an exclamation mark (!), a specific subkey or the
> primary key can be exported.  This does not even require that the key
> has the authentication capability flag set.
> 
> Using the new word?

Hmm.. this documentation must be newer than I last looked at it. Still, I
prefer to call it the "certify" key, because "primary key" is also ambiguous:

- "primary" key suggests that other keys are "secondary", which they are not
- "primary key" clashes with "primary identity" in an important way -- you can
  change your primary identity by adding a new one and assigning it a primary
  status, but you cannot add a new certify key

So, I'm sticking with the wording "certify key".

> > +The **[C]** (certification) key is often called the "master" key, but
> 
> Maybe "The key carrying the **[C]**" is better, match the following
> description. As your said, gpg always create a [SC] key by default.

Sure, I will consider this change.

> > +1. All subkeys are fully independent from each other. If you lose a
> > +   private subkey, it cannot be restored or recreated from any other
> > +   private key on your chain.
> > +2. With the exception of the Certify key, there can be multiple subkeys
> > +   with identical capabilities (e.g. you can have 2 valid encryption
> > +   subkeys, 3 valid signing subkeys, but only one valid certification
> > +   subkey). All subkeys are fully independent -- a message encrypted to
> > +   one **[E]** subkey cannot be decrypted with any other **[E]** subkey
> > +   you may also have.
> > +3. A single subkey may have multiple capabilities (e.g. your **[C]** key
> > +   can also be your **[S]** key).
> 
> Reminding the limit of algorithms' capabilities by the way?
> Like: As long as under the algorithm's capabilities.

I think that's unnecessary in this context. Yes, ed25519 keys cannot be used
for encryption (that's for cv25519 keys), but I'm just illustrating that a
single key can have multiple capabilities, so just leaving it at "may" is
enough here, imo.

Thank you for your suggestions.

Regards,
Konstantin
