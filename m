Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139D448A2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbiAJWYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbiAJWYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:24:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF35FC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:24:19 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g5so5071329plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZe412goOgkJ2yRe/8GbTEcdcyz0PvRF1D1A/JT3fNI=;
        b=IT6idU6TxaPdLu07PRcciqOa1IWlH8uo41bSThpiifhuHxo9LDOfEFYwXvstst48L3
         6w/seo1Ic3T9hVAEnajLPH6+4ihm46gJZNMqmFzo+nWbPGT4pkNalXzW7hU118H7iDFC
         /eOMWGPfaOUanNitvT61L+XA/F8pcgO+uPlrKDus5EPkCJA7u6oLM7g5eDvc8jQfsLf4
         s6l/IdRZ9RZu3DnSY7kU59yY12Y74sm9ETGqcf4w5CrvwIwSDBLQRnUkfcIC7kSEJNx5
         qTWliTLM+mEWsMz6X2JWf/UQTFEXvf7U0PEjQWR9mtT6dmo9ngQTf8Nc2Db5VudMFvIN
         1R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZe412goOgkJ2yRe/8GbTEcdcyz0PvRF1D1A/JT3fNI=;
        b=53T87p25Nth0LUUfBXkznmiJspNeQiP0ZhnhaUqi0ro4vR5q1oSuLnUBFKuHPsQUK0
         aIkCiaOhEo/WgOqOOudavsR3uEo+jDrAYZzpyBjeMhfrHcSQfljZSrVgQnsjpg0eEDIN
         sXmkGBclMEjrr58jsAxP0o3cPjZHNOunepGdgIUzpwxaeT6nqurfEKHR78rEjblFVwCh
         WVgsbVQoF4bR6EDzGvnnu1XVxnLRzpzdiXMQyDqNHB/7SO9iU7z7F7uAdiBxeh94Jvx8
         vrTaWavS9M22XXPidHUZj8B9qVcmB5R1EDr6H8s10WLumD4aHNfSi7uRTD7GZOyOZHHb
         lPyA==
X-Gm-Message-State: AOAM532mj/kBdrnOU3C/0OGX4a7iEyUIxKkqNmlchtNp25bgi8VeA3KG
        NdJJW5sJ/kzKmLtYbZZh09RrUxdhrjh1MgJ+qjcNUQ==
X-Google-Smtp-Source: ABdhPJz212c6bIO5pcJRt/7dotxk7B8rnYFafWa+lVFD1OneJuCDVOBCbMjZldk5pxLeTLKVMNd2b7GJRFES9m/VP9I=
X-Received: by 2002:a62:80c2:0:b0:4bb:47a:6983 with SMTP id
 j185-20020a6280c2000000b004bb047a6983mr1831115pfd.24.1641853459000; Mon, 10
 Jan 2022 14:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-4-dlatypov@google.com>
In-Reply-To: <20220108012304.1049587-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Jan 2022 17:24:07 -0500
Message-ID: <CAFd5g479v4B+p9FOVfGSXQGp99CGx_saBn2w9nz8iPZEdm5rGg@mail.gmail.com>
Subject: Re: [PATCH 3/6] kunit: drop unused kunit* field in kunit_assert
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 8:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The `struct kunit* test` field in kunit_assert is unused.
> Note: we have access to `test` where we need it via the string_stream
> object. I assume `test` in `kunit_assert` predates this and was leftover
> after some refactoring.
>
> This patch removes the field and cleans up the macros to avoid
> needlessly passing around `test`.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Looks good. Thanks!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
