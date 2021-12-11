Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31244711BC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhLKF2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229597AbhLKF2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639200281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vEoBWvfKJezafb/gz8qOuM9H17UzU01X5cgIQsGVem0=;
        b=TR6VDql1UKqaraLoZ1DlUzDZEZIgR4Ko5Yz0LQBcysIcULGkLJPxXmwQLIVscaghHR7+us
        CUnMlkjiX7zfVGtMsT/07q+W29KXXfNewNBJDW+b649Jmp/UsMCpSLYgZF2cJj4bt57mmE
        jQi2ycNWZVpuGhraGn3+8YeM+I8UhT8=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-Q7QXfV4zOES8UVYIdEvPSg-1; Sat, 11 Dec 2021 00:24:37 -0500
X-MC-Unique: Q7QXfV4zOES8UVYIdEvPSg-1
Received: by mail-ua1-f70.google.com with SMTP id u15-20020ab0458f000000b002ef82056c39so7709158uau.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 21:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEoBWvfKJezafb/gz8qOuM9H17UzU01X5cgIQsGVem0=;
        b=7CYaKvb0eAUhJ1r8iMF3dA8u5nVnV9fDInrUy1FwbEQOC3mNg2zyMKS7URb5nZKD8h
         wfrOEqE/7QKJACyqI5frgKKU+GudQJIEIIUGygy6lhz8zn3rYooX7KoJu70S6rbB7Y7Y
         I1XUzNhiasjAoE5TEeESYbZqzMmvwFAYKB3LJ5k63gfc+MnXaMsWAEKcwMWZpdp96fFf
         /PfIHUReWo/Gv3ek8Ey7sa8WNcLx+2BP19yQQ9DVzxk16zYpCXgN9T4hGC44K+Zxy1pv
         r0ATwK+wQ090BIi9BMdUx9Tcj4axLTyWXPxaryIsTRUKrqgmmhuD0Z93gP3rJHaCcYkp
         DlmQ==
X-Gm-Message-State: AOAM530PUnJ6G3YnBQHw8DV6pBhRQtWZfZEZfhxS47dPIv48Klg+KbPk
        /btavqGeaGE/+HZiMwKZevvEclv+ihGZu/+rdBf1ElgicMVv6uHikrdSgjJkL3YpnFNa49GxhOR
        TUUXjKzozh/Kb4lFlcV6XHc3mv6ZbwDCrwLyXRL+f
X-Received: by 2002:a05:6102:2910:: with SMTP id cz16mr21266833vsb.9.1639200277314;
        Fri, 10 Dec 2021 21:24:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYuTo+cFn0Ym+OeF+CcyKc83VT49otL8gLNPTOMiwVV425TmLj+Cp1WxDVtcutyVADxYR1xNwNuwfmYUW4Meo=
X-Received: by 2002:a05:6102:2910:: with SMTP id cz16mr21266819vsb.9.1639200277130;
 Fri, 10 Dec 2021 21:24:37 -0800 (PST)
MIME-Version: 1.0
References: <163697618022.414.12673958553611696646.tip-bot2@tip-bot2>
 <20211209143810.452527-1-jdorminy@redhat.com> <YbIeYIM6JEBgO3tG@zn.tnic>
 <50f25412-d616-1cc6-f07f-a29d80b4bd3b@suse.com> <YbIgsO/7oQW9h6wv@zn.tnic>
 <YbIu55LZKoK3IVaF@kernel.org> <YbIw1nUYJ3KlkjJQ@zn.tnic> <YbM5yR+Hy+kwmMFU@zn.tnic>
In-Reply-To: <YbM5yR+Hy+kwmMFU@zn.tnic>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Sat, 11 Dec 2021 00:24:25 -0500
Message-ID: <CAMeeMh9DVNJC+Q1HSB+DJzy_YKto=j=3iGUiCgseqmx9qjVCUg@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/boot: Pull up cmdline preparation and early
 param parsing
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mike Rapoport <rppt@kernel.org>, Juergen Gross <jgross@suse.com>,
        tip-bot2@linutronix.de, anjaneya.chagam@intel.com,
        dan.j.williams@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org, stable@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        "Patrick J. Volkerding" <volkerdi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for delay; my dev machine was broken much of today. But I
have tested this patch under the same conditions as previously, and
agree with Hugh that the patches make mem= work correctly.

Thanks!

John Dorminy

