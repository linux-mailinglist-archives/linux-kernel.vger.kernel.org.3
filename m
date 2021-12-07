Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EED46C711
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbhLGWGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbhLGWGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:06:15 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA3C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:02:44 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r5so297415pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPOb3f+PP/CHPVEnLCL92r7rMcYux8sb+4mgL/0JGVI=;
        b=PPcAt0tBYiv+3kpXjHp2R3I0b6eJegphbebcm2P7Hr67N2X5T+mztEofzXyVu51h1k
         t0BJ28BSSqf9tl1T3fhJPcst131aRakF0zHd0BahoDIQMHjr4cWLGUveEK6KB6hB9VGU
         kCPFl+eBoyS5a1WHDoGLvexVy04sGZdIt1+5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPOb3f+PP/CHPVEnLCL92r7rMcYux8sb+4mgL/0JGVI=;
        b=OA1+Y/KAOOLQMLQ5O+JTGV8S8BYpYJUQ+tUztRjIPNjA1Z8HVG0TFUE6aYR5jVLrVy
         6M94lHuX11qIVE0yeO17mDWpn5BH+bXIhq0jU/Pfm/bC6jfNCpv9E76Pl+bZ3RxVT13P
         0OUMgUl5O4m9+Jt/VEwmDJ1YzNX9n4as3CtS5IYxX3kUDNzo/ygBa+qu+wFNrRGx9LA6
         D9UMInpxXK8F0V5uG7U6jtbrnQBs44BVSYW3YqLNzZBCy1Yy2+qcag0zzfGXEsuFpO91
         r0xC8mQM++YtZIa4QAckSi5oElD14FF8U1MUJ7mX/XOeFKxTlqLOcEmHtsB72drXhANn
         6E0A==
X-Gm-Message-State: AOAM531GkrqkSCxvrcrU4sLUjheCXeF/zxZgzNXv/WpDkSFzG9prC5au
        5rtn/EkGVwnwiK6z7DcBncdL0Q==
X-Google-Smtp-Source: ABdhPJyieJsFvJIUtI3UUujSEkSuweH6m8DhvucVGJ4MtGyTBtnbKHDZjmLyION4bnAfmtZDQBGW3w==
X-Received: by 2002:a05:6a00:23c7:b0:4a2:ca32:9a27 with SMTP id g7-20020a056a0023c700b004a2ca329a27mr1920629pfc.71.1638914563951;
        Tue, 07 Dec 2021 14:02:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l13sm774009pfu.149.2021.12.07.14.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:02:43 -0800 (PST)
Date:   Tue, 7 Dec 2021 14:02:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com,
        shuah@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] Documentation: dev-tools: Add KTAP specification
Message-ID: <202112071358.E8E6812D@keescook>
References: <20211207190251.18426-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207190251.18426-1-davidgow@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:02:51AM -0800, David Gow wrote:
> From: Rae Moar <rmoar@google.com>
> 
> It does not make any significant additions or changes other than those
> already in use in the kernel: additional features can be added as they
> become necessary and used.
> 
> [1]: https://testanything.org/tap-version-13-specification.html
> 
> Signed-off-by: Rae Moar <rmoar@google.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

I like it! Thank you so much for suffering through my earlier reviews.
:)

The only concern I have is wonder what'll be needed to kselftest to
deal with indentation changes. As long as this can be implemented
without a subtest knowing it is a subtest, we're good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
