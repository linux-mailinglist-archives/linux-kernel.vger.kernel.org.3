Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C20A4B1477
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245281AbiBJRnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:43:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245269AbiBJRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:43:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B0101B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:43:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c3so2454570pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RfVaSD5Jbl1UCapkvwTHkbWqS8zVw2iOHKCAwa9H0bo=;
        b=mPRxMXX+y3f90qS/gIUi3DqSuIu88IQgUnYn/CtI8oUWe8L9TD1H0WXBI064iWvs9x
         0sURffRFCyyd9vSBECvmcKMtKeYwQRctxSOoQfnBkzNdynfh7tnSgBmffK6bbr4gp+/c
         kq58WyJkxkzQnHmbGDTtGDYBGOvGAN2PIO5RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RfVaSD5Jbl1UCapkvwTHkbWqS8zVw2iOHKCAwa9H0bo=;
        b=6+IHIch4PXQUu3gjA7hE0wyrTMm94g8iGpMY617b4mdvnXda697uCr/YgMI8t393Xq
         75hpyEUHy4JZpr0SIH/14AfR5qvh46ngTIIY0vLVRJ7tcqtKrDAEBeF88TaWwwShm+9R
         zHMS5o+mYpXK+LL4RH2CgQW97wDEcuYDpR4/bNNRGE9quVW3tdxWhYFadyJZNpyTL4Cd
         U6kuoEyAd2eL/0Jh9rLOzZVYpGZTeF/n26RC+XI7fef3LoB964Fm/T1XJB2agzpaQJIk
         vmFsDEqRaEJm5EwWnCoZ2X9addDcF8w4PZMYHbnWah0CFZflZg+tXc1LdxXcy1+WkLri
         9L7Q==
X-Gm-Message-State: AOAM533dFNvHxaEWZuoTZef90a99MEKBbQ8V9gwBvjHeYVyngCqlmG1j
        bqP+6qWIicYxH69G+U7Lo6gNXw==
X-Google-Smtp-Source: ABdhPJyEmB34sogZs6Rj+2bZzHJh+ef5Kc026LQokIFwesK8wdexB1XeGvWkY1tS4FM6JSfJeUjC1g==
X-Received: by 2002:a17:902:b90a:: with SMTP id bf10mr8691668plb.36.1644514993117;
        Thu, 10 Feb 2022 09:43:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 204sm24336775pfu.91.2022.02.10.09.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:43:12 -0800 (PST)
Date:   Thu, 10 Feb 2022 09:43:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     frowand.list@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Documentation: dev-tools: clarify KTAP
 specification wording
Message-ID: <202202100942.A8206C0@keescook>
References: <20220210023519.3221051-1-frowand.list@gmail.com>
 <20220210023519.3221051-2-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210023519.3221051-2-frowand.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 08:35:18PM -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add the spec version to the title line.
> 
> Explain likely source of "Unknown lines".
> 
> "Unknown lines" in nested tests are optionally indented.
> 
> Add "Unknown lines" items to differences between TAP & KTAP list
> 
> Reviewed-by: Tim Bird <Tim.Bird@sony.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Thanks for nailing this down!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
