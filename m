Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57A8496D46
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiAVS2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 13:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231531AbiAVS2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 13:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642876115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ucv0aOeTl0qY0LIW0rR1qOQJXa96wvP2HU03hO2vqUI=;
        b=dFh7fMtR1WRPpjB9ZBI06OoElZgxdCJVEA26SzN3mveCVLa7DuyNlQLO+BTbT4XHJjkvQf
        3Km0DFjBTTWWWuD5zsfGuKFvuESAdx8ogxZarRA6UuG3MWKjoQFi3F/m5cnxkNT4jEhQco
        m4BMEfg8aRYUKBCLLNRH3Kv0il7fY/8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-A1eCbTLgPLq_sumZlTzsuQ-1; Sat, 22 Jan 2022 13:28:32 -0500
X-MC-Unique: A1eCbTLgPLq_sumZlTzsuQ-1
Received: by mail-qk1-f198.google.com with SMTP id h10-20020a05620a284a00b0047649c94bc7so9548167qkp.20
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 10:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ucv0aOeTl0qY0LIW0rR1qOQJXa96wvP2HU03hO2vqUI=;
        b=UopZKNC3BtH2PRXI5XsHR4POHuCa1DI90u6iBhBtIJPYoYp/4X1G21An4aM/l+vb7s
         K8iKn5Fjr45eCpg4hWhIzlVHS2qzHXVWA5lUQEx6Uau9t3W9LtDDaWiCAkk0Z/33Gk2s
         1SZODblfGEJJGqqxlWyuZpk0BnOu0BTqWdz+Po/arhmxcefgSCjvXNLpn7IR6wlMMqC5
         Bc2y5GEnYDdQFSm2bfizbPmhWxUoUrIqwMK/Uys0rwYgADkmJZ79cizYVJ8TMOVaO9u9
         0kMkoIHeFuhCy1uRFMb58r3IhXKYjfsj0SU8YdzdNrNoinJ6zdejrfNBZWw5yBh1DH4d
         7l5A==
X-Gm-Message-State: AOAM531dBv/D+4r1gZuIk/g4yQFSeBjCgIOygq9z42kl2dMu+I3TU/Lv
        ttPa4n6StYYKbltYIW3S0btnv1RtYiWnv0fzdOc7klB7llcVDiJ2/+NsSU1+n3OooTOJfruqO1v
        7OC3k9VFNtU9GAyCV4JUZ4eKeNKmJKDjdbejbURS2
X-Received: by 2002:a05:622a:154:: with SMTP id v20mr7424961qtw.291.1642876111882;
        Sat, 22 Jan 2022 10:28:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIoGUAu6bpFbODt3HNOc9I4zp+34EQICGP/ho2BjV+qObmlj30UPR4WKnhMWKC4nAp+ZQQuSoZ2A3Y9UpV0qs=
X-Received: by 2002:a05:622a:154:: with SMTP id v20mr7424947qtw.291.1642876111635;
 Sat, 22 Jan 2022 10:28:31 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com>
In-Reply-To: <202201221028.YKA8kSdm-lkp@intel.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 22 Jan 2022 13:28:20 -0500
Message-ID: <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 21, 2022 at 9:45 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9b57f458985742bd1c585f4c7f36d04634ce1143
> commit: 658bd576f95ed597e519cdadf1c86ac87c17aea5 fs: dlm: move version conversion to compile time
> date:   3 months ago
> config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220122/202201221028.YKA8kSdm-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=658bd576f95ed597e519cdadf1c86ac87c17aea5
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 658bd576f95ed597e519cdadf1c86ac87c17aea5
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate

I have it on my list but it isn't easy to make sparse happy here...
this is the second time the robot reported this issue. Is there a way
to turn the robot off in that case?

Maybe some human who reads that knows the answer?

Thanks.

- Alex

