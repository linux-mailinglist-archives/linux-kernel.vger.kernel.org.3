Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5B5816C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiGZPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiGZPvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:51:47 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAF127B1A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:51:47 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id m10so10924178qvu.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JRFcvDZwwt70vwm2Ew63MLuxsxwy4bx0z2jyF9XeZOY=;
        b=ll3vLnY7Hmee1FfHu5SErZGSwRrDSI5eSgAAqOY3hu9KQpRthO47RtD4II2+22QSDR
         l9VmglWhHvjGd88mMmk8wV6cXAeTblbcxNs2U3uxd2ORn2TSW2RxFMJJCi5xJZm+riiX
         l1b/MTzMLJqCjjcN5akHb0UTcGJRk/4GeeZUWAO5qYrbgO2QUhLpFC+/9W1C2sACz2GS
         BA65w2+GH55qKD6tmvZ9uMUCG2K9YeVtkdU9KV269i0Z09QWKPinglU4am4OgfdggpYm
         d/Ula0xo3Y9oLon4Ce9t92x4kZF8WyvDZUmupDWi3MFeFXVRrbQGmLFWJVRBGo8j5TwU
         Hqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JRFcvDZwwt70vwm2Ew63MLuxsxwy4bx0z2jyF9XeZOY=;
        b=ufo24C5nHdKcuO6BG95tzDx2Fc/6qbgI9OI0ZzPOxXDVbitnUhIg9YIGI7i1Wf2KYL
         9VKhvOvqETu1sHfKL2mnl6LlZOaezOGRTR6Vw7Xdr1s1vyKrAmRijbT94BD8vwR6h7DM
         5yE4KeVSRwx111h7ddlisXL/oyeRzhzw4CwRL1WLyehiMZvecUYt34N5DGOyswn9GwG1
         rgTx0GFAhkzm1Is46FbQC5sN4jVRxCublQtg4Uz13Sn0t8x8jvUO5m+1/KXidyNsjgUq
         SNkmsgvTYziyNTlD8I6a0YmaPldYy7cXj62dYqfVCWpGGygQ4l+/fgEQFjX6V5LJpnVO
         92pw==
X-Gm-Message-State: AJIora8l+82sq4Nw8gFlvAB9bkNHv9y5M2FoVRXgzsPpLWSSpAEk7GCb
        aXJdiGSxNnDaqMDcQ1CKrkA=
X-Google-Smtp-Source: AGRyM1tKDLjnfPB4gpxcdX64LZ4TENA3+O2Y5tWiB16bIxzzFmfNQG7HInh7R/DkNOTSypr4jbfIvg==
X-Received: by 2002:a05:6214:e68:b0:474:40d6:de28 with SMTP id jz8-20020a0562140e6800b0047440d6de28mr10867924qvb.103.1658850706116;
        Tue, 26 Jul 2022 08:51:46 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id x2-20020a05620a448200b006a8b6848556sm11126322qkp.7.2022.07.26.08.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:51:45 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:51:39 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc8
Message-ID: <YuANi8LVsoeqdcPN@yury-laptop>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <CAHk-=wgGrewyOqT7Cm-eHKp5W+8rJ=aL8iNtsbhRfc0YD2gbeA@mail.gmail.com>
 <Yt7+pPyEmYYH8D1K@yury-laptop>
 <CAHk-=wg6k1oxtEF3M7_icZ_62Je4R0VUaA69jo4xrOTxF_mMoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6k1oxtEF3M7_icZ_62Je4R0VUaA69jo4xrOTxF_mMoQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 01:40:58PM -0700, Linus Torvalds wrote:
> On Mon, Jul 25, 2022 at 1:35 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Here we have 2 ugly options - having pairs of almost identical
> > functions, or passing dummy variables. I decided that copy-pasting is
> > worse than abusing branch predictor.
> 
> The thing is, we have solutions for this - just use a single inline
> function, and make it *see* the constant.
> 
> That way the compiler can DTRT, either generating two copies (with the
> constant elided) or depending on the branch predictor.
> 
> That's particularly true in a case like this, when there is only *one*
> case for the normal situation (ie little-endian). Because let's face
> it, big-endian is completely dead and legacy model.

OK, I'll do it for 5.20. Thanks for the hint.
