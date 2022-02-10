Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5C4B1475
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245297AbiBJRnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:43:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiBJRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:43:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DA421B7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:43:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c8-20020a17090a674800b001b91184b732so6849616pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JWTciHa8tMED3FXA+Ogdt6wVZFyYQZwP+ShqeFRit+I=;
        b=Ck3LZGNu0+N7P6xsV9DDei7cJLvODVs1BnOzvk0bszpoiLl6jJyJGZ2+30GWFFu9jz
         5/O7MdvbVHxjTB0K8wZMEsvKndsWprLvwjfAeMdDhiGY/8VADLXqmH/vR5HlpstEvzMm
         4oRjk2qpDWkgSUR+DXT4SyThiJjLHLqZFdUqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JWTciHa8tMED3FXA+Ogdt6wVZFyYQZwP+ShqeFRit+I=;
        b=gp819GmCzIblgWVbM6IY39MHsYvmEt13/uHEJnW22Sq0TTNDuO1iDDNkavF+LneGwp
         GWcTw8x78BV34d7vx/E3rdfXXgbDmfWYXJHHbNiNXD4fkvo5XevzjA2dcUO/CBfdWlHV
         +6nUCkygY4PVH2BddavNNgQT0yuEdKSsVK4re17EPYqr7ojJ6wvd5A+w7qSpUq1dnl9m
         3aqv0y2atGJVJVW63kS4HZ2qiHf1PCBdCN7c9CIcjMx+K4wlsI9iWespmPJIWEg8Zr67
         f0mDpIm0j4gqsTSfXQHvwrkL7IifkkOeziSrk2lKJ71OSCUQqmTDIkaWmxh1G/GMtSmv
         nNbA==
X-Gm-Message-State: AOAM532h2zRGwFkumkacLXuB0Y1rtnpomNxEzzqZTPa1DJptOd1/9Xjk
        yQ/KOrChX+dM7T0FKZ2NvIvBKg==
X-Google-Smtp-Source: ABdhPJwfu2aJvaqWXY1aRdvOiBamWd2wXwn64hpgV8EqWsUme9kFg4luF0ZxCPobzkh3kcfPGwXuPw==
X-Received: by 2002:a17:90b:4c52:: with SMTP id np18mr3975968pjb.49.1644515000573;
        Thu, 10 Feb 2022 09:43:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16sm24645520pfu.194.2022.02.10.09.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:43:20 -0800 (PST)
Date:   Thu, 10 Feb 2022 09:43:19 -0800
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
Subject: Re: [PATCH v4 2/2] Documentation: dev-tools: fix KTAP specification
 build warnings
Message-ID: <202202100943.3E8C5B4B@keescook>
References: <20220210023519.3221051-1-frowand.list@gmail.com>
 <20220210023519.3221051-3-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210023519.3221051-3-frowand.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 08:35:19PM -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Convert "Major differences between TAP and KTAP" from a bullet list
> to a table.  The bullet list was being formatted as a single
> paragraph.
> 
> Add missing required argument in code-block directives.
> 
> ---
> 
> Table conversion suggested by Shuah.
> 
> Patch 2/2 not previously reviewed, so Reviewed-by tags not provided.
> 
> Changes since version 3
>   - Add this commit (patch 2/2) to the series
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
