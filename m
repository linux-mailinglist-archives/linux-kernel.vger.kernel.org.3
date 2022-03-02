Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB64CB04F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbiCBUxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242626AbiCBUws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:52:48 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFBDA9E1E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:52:04 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p17so2613207plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1/zjEbSfhRRwQcZ+Urt/JTyvvofyCg2mmN4lvs+NezQ=;
        b=Oep9w9nuZJVR02ibZvrEcTVkv0YiWk56vRe7ZtORUExSC9xXaEYaPW4RK27O5kGvyw
         b4DdWZ8EywmcbRx8/foJt0NiNzP04MVr1kyq41Q+6NG2YsRUk1l2yIDKqY8vnFl2LdnQ
         NwqWJD2CnGnvj295X5nkl6oYxqgwfqhBgsqZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1/zjEbSfhRRwQcZ+Urt/JTyvvofyCg2mmN4lvs+NezQ=;
        b=aUSNxRsxiLsB/adzh5KaOZw/BVFA1W1NFhOU7hAlZTuQ+1D6D+zacQNFBsZTFaVB+3
         jev5bymbVzhegvwAa3uPiLXg7KMaKMNiN5NbHD+fssukDcu9n9SJMKExUIEY4UL3Yb5g
         zQXg+yy/iHLMazOP8fwqx/uODkG3ykyC/ZzV/jCixl/o894HqZqmgXC0s6z4+8I0uokt
         c81O+lb2wVxdjfdlxk8lm4MCO+UzSKPB1ynEYfbBjTOBg6hclrOW7yAaeFa7IwKshuhk
         lUxMBsML59Tf7LoFLOkC5I2fTB+7CB7JC1vKlYTRqW4aMuoeEBelievWVQdOnPZNGBiB
         M/XQ==
X-Gm-Message-State: AOAM532lzQP/uNJHrCAe5202uMuP+mhkYyRw7kvwatItjPW4YIJ/2kKV
        9QnO41SL4OLdTaQ7uWUXAk7vzg==
X-Google-Smtp-Source: ABdhPJyywT7+4z2Og3DinCge0OBdaL2iq4lk9mSh5O2CZZ5d2WMPgmh0kS9M4Dj9llTUA5VewclR8A==
X-Received: by 2002:a17:902:8f83:b0:151:5c71:a6e6 with SMTP id z3-20020a1709028f8300b001515c71a6e6mr20427267plo.126.1646254323838;
        Wed, 02 Mar 2022 12:52:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12-20020a056a000c8c00b004e1a76f0a8asm71669pfv.51.2022.03.02.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:52:03 -0800 (PST)
Date:   Wed, 2 Mar 2022 12:52:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, Adam Langley <agl@google.com>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH 1/1] sign-file: Use OpenSSL provided define to compile
 out deprecated APIs
Message-ID: <202203021251.1DB0383C@keescook>
References: <20211005161833.1522737-1-lee.jones@linaro.org>
 <YVyE3Ax1PRtiBwf+@gmail.com>
 <CAL9PXLws4DjvPB=1KNpom3W52pXNauXQ4V==MprDx73YQ1-sgg@mail.gmail.com>
 <YVyKc51r2tfMmQuO@gmail.com>
 <YVyVNkijABL7CxnM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVyVNkijABL7CxnM@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 07:11:02PM +0100, Lee Jones wrote:
> On Tue, 05 Oct 2021, Eric Biggers wrote:
> 
> > On Tue, Oct 05, 2021 at 10:14:58AM -0700, Adam Langley wrote:
> > > On Tue, Oct 5, 2021 at 10:01 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > > > I ran into these same -Wdeprecated-declarations compiler warnings on another
> > > > project that uses the ENGINE API to access OpenSSL's support for PKCS#11 tokens.
> > > > The conclusion was that in OpenSSL 3.0, the new API for PKCS#11 support isn't
> > > > actually ready yet, so we had to keep using the ENGINE API and just add
> > > > -Wno-deprecated-declarations to the compiler flags.
> > > >
> > > > Your patch just removes support for PKCS#11 in that case, which seems
> > > > undesirable.  (Unless no one is actually using it?)
> > > 
> > > The patch removes support when OPENSSL_NO_ENGINE is defined, but
> > > that's not defined by default in OpenSSL 3.0. (Unless something
> > > changed recently.)
> > > 
> > > When OPENSSL_NO_ENGINE is defined, ENGINE support is not compiled into
> > > OpenSSL and the headers don't include the functions:
> > > https://github.com/openssl/openssl/blob/master/include/openssl/engine.h
> > > .
> > 
> > Okay so this patch is actually a build fix for when OpenSSL doesn't include
> > ENGINE support?
> 
> Correct.
> 
> > Currently this patch claims that it's removing the use of a
> > "deprecated" API, which is something entirely different.
> 
> I see your point.
> 
> Happy to rejig the commit message if that would help.

*thread necromancy*

Hi,

These warnings are quite noisy on Fedora rawhide and other distros that
have moved to OpenSSL 3.0. It's not clear to me from this thread if this
patch is actually the correct fix?

-Kees

-- 
Kees Cook
