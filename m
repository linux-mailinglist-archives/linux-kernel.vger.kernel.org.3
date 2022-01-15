Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7617748F736
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 14:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiAON6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 08:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiAON6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 08:58:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52342C061574;
        Sat, 15 Jan 2022 05:58:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id t24so45076969edi.8;
        Sat, 15 Jan 2022 05:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yT8KUGxi4exkIhe1AED8YmuobGkreLqJ60t3R1ZZfI0=;
        b=n/k6ZAmn4FgcgUoeAJsgdcZuigv2v+H+wL8C9WFwMLrPoyyKmWXoawmnq55m/IThVM
         VAXwxZAFY8ibELMRRz33OBd5oY4lpncptHV6MyoGQAYJw8bcYUUbcRTvdpFNlvzsQ+1V
         zBwv/2s09qrDsY+YLz9mONGkxG/K061oFH2M6+fQUf0iadHzm7ai1fqgg8dPUGQeDln8
         NghbRF4RjqJllI/HwIt6FvCoB9HfPC3S9kFeoMdm/PMHfidSLZqpRx2y9iDuvrUuj4RR
         +yHt7YlsETijOfZO/qKhFMt4gunRFeA99xDmVgMLgjxbYZDA9J6xTL8wESaMGOuCI/NU
         TQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yT8KUGxi4exkIhe1AED8YmuobGkreLqJ60t3R1ZZfI0=;
        b=Q6YaA0Q+srlSX7d1njGBlMqLhXbh5IyYCdMjjQ8ReoaKh2f43EBsftmqGzxPCRhhb/
         KZUw1ol9z5aVfi6g2KnxO/22lc6AqDN/uSpyw13zbwAhFXBLu3ihV29O9DOME/G+gf+s
         ZX/sKYUFymBLG1naJIoOdUeXYFWKPXOGXwRHyFaFmsp+THXGMGOuGDc9hana+ECy9Fyx
         qRRk+cXVO1W86ZKs/ZE2MKF+zaGgJSqfLBUc3+h1Drazxhw3jn/MkCqd9jduoGSp4w41
         zsrLHcgLTYrqZvC7jatmqAkmySFLcXIqMd9+vi9UF7Y4CkS3BtiT9PotcDutDYVlGauj
         InhA==
X-Gm-Message-State: AOAM532DTpjyuohB8kLwWAXqlRY9FJc8yJnWwIn1humpX9nom9i3BCoW
        IvwRbjMAipT5J6rDM144P21IHqQFW3o=
X-Google-Smtp-Source: ABdhPJwfxEbgpAWc9f0xihPaZo/OQ96NlhiJ29L/K3i73tmHTCgo/6DnJ3KASqyctbsvfAOIoFrY6Q==
X-Received: by 2002:a17:907:6d20:: with SMTP id sa32mr11327017ejc.35.1642255085567;
        Sat, 15 Jan 2022 05:58:05 -0800 (PST)
Received: from ?IPv6:2a00:a040:197:458f:2395:a31f:2f8b:a545? ([2a00:a040:197:458f:2395:a31f:2f8b:a545])
        by smtp.gmail.com with ESMTPSA id c1sm2595804ejf.92.2022.01.15.05.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 05:58:05 -0800 (PST)
Subject: Re: [PATCH 0/2] kconfig: Improve comment blocks in the .config file
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211213100043.45645-1-arielmarcovitch@gmail.com>
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
Message-ID: <a968c750-9226-4530-7acd-3e498d567f3f@gmail.com>
Date:   Sat, 15 Jan 2022 15:58:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213100043.45645-1-arielmarcovitch@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping (would really like some feedback on this)

On 13/12/2021 12:00, Ariel Marcovitch wrote:
> Hi there!
>
> This series attempts to make the .config file format make more sense.
> Currently menuconfig blocks look exactly like regular configs while
> comment blocks look almost exactly like menu blocks.
>
> The first patch makes menuconfig blocks look the same as menu blocks.
>
> The second makes comment blocks look different than menu blocks.
>
> The format for comment blocks in the second patch is a suggestion. I
> realize some people will think the '###' prefix is distasteful. I'm open
> to other options as well, I just couldn't think of a better option that
> starts with '#', looks different from a menu and can't be confused with
> a disabled config.
>
> Ariel Marcovitch (2):
>    kconfig: Show menuconfigs as menus in the .config file
>    kconfig: Make comments look different than menus in .config
>
>   scripts/kconfig/confdata.c | 34 +++++++++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 11 deletions(-)
>
>
> base-commit: e06a61a89ccd3edda046c78f9d08aa045b8c4d32
