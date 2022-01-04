Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B90484796
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiADSNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiADSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:13:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3559C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:13:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so77863753wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tq/rDftsObQfvSRPH80FancJA7G4hDd6gx/fOvyV3es=;
        b=uIXdfs1/7JH68k3Wz2PeMCTpn7DHDz3TflgvLE66s/e9qPBymA/dISIAEEG/Rz+2NK
         w64cUenmWv0CSkJHEz5i8WKMqdPJtpnLZ9tvByGWhWMiVE0NkuSfDG8e/X/jNjb7OxZ6
         akaHvplE9bG4KWHd/V69UYPCzDxP2dPLNceEi1U4e9KgrSz/YsB8/sjGXaECq/z2we53
         mvWnkCa+rGd1D65ZjUbfftvc7F+0JqUe0UCq/f5zZVrMxYmDlysTEQiFtOGnLP51raI2
         /jZUR+IQHwFu6ZjLglblMf53VQLLshudfimKVfo8RkG4pONCxeHtBUucYA0wNrjjrrGE
         zvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tq/rDftsObQfvSRPH80FancJA7G4hDd6gx/fOvyV3es=;
        b=bVgvXW88kTXtvV8gClpmYzyIhrQC5GKgFqBivR1KmHR/qga0VpejMq9RbooItUxviV
         f9NMMW3s61TGzrI2RPdqwZtnrHBmEYxy8d43jjWZxJqfVxWp8mvOl8ag18PQok5bBl2B
         AJpcWcS9q171/3bprnHzsvocljW5GLfaOJFkclzjs2H1kEC47WNTfmBzGzuAAROyLSD0
         aXrwsG3QtQtMNgufAL4BJpFBrmytBDEXfQdLCRLLxCccOv3sEpsMgLSYVX7H59w9BW7d
         zTGxOe2aViZEvquGh0qAPJIzimUNpK1qRC1GVN7m+S/pGwjBZbte/2/rU7jwlf7IXwCK
         s8DQ==
X-Gm-Message-State: AOAM531e7okFDOX/5EeAiWiaE3BEokjWUKwTvHy8jKlQ1D59KZhhHjDK
        Iev+FXRAj2JUrr3ckVpwRn3ANQ==
X-Google-Smtp-Source: ABdhPJzDtNxqWTb1FZnIvsklomGU5Qb0sIMun7griucJllmVkcsS1lodLhtkLGZbVpsa+AQmCGBniQ==
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr43276931wry.406.1641320022642;
        Tue, 04 Jan 2022 10:13:42 -0800 (PST)
Received: from ?IPV6:2003:d9:9708:b800:49a3:330d:2aba:c4a2? (p200300d99708b80049a3330d2abac4a2.dip0.t-ipconnect.de. [2003:d9:9708:b800:49a3:330d:2aba:c4a2])
        by smtp.googlemail.com with ESMTPSA id g1sm39029132wri.103.2022.01.04.10.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:13:42 -0800 (PST)
Message-ID: <c8edba64-9b4b-1ef8-f0b3-1b4beacf1551@colorfullife.com>
Date:   Tue, 4 Jan 2022 19:13:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ipc: Store mqueue sysctls in the ipc namespace
Content-Language: en-US
To:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        kernel test robot <lkp@intel.com>
References: <0f0408bb7fbf3187966a9bf19a98642a5d9669fe.1641225760.git.legion@kernel.org>
 <792dcae82bc228cd0bec1fa80ed4d2c9340b0f8f.1641296947.git.legion@kernel.org>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <792dcae82bc228cd0bec1fa80ed4d2c9340b0f8f.1641296947.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On 1/4/22 12:51, Alexey Gladkov wrote:
> Right now, the mqueue sysctls take ipc namespaces into account in a
> rather hacky way. This works in most cases, but does not respect the
> user namespace.
>
> Within the user namespace, the user cannot change the /proc/sys/fs/mqueue/*
> parametres. This poses a problem in the rootless containers.
>
> To solve this I changed the implementation of the mqueue sysctls just
> like some other sysctls.
>
> Before this change:
>
> $ echo 5 | unshare -r -U -i tee /proc/sys/fs/mqueue/msg_max
> tee: /proc/sys/fs/mqueue/msg_max: Permission denied
> 5

Could you crosscheck that all (relevant) allocations in ipc/mqueue.c use 
GFP_KERNEL_ACCOUNT?

We should not allow normal users to use up all memory.

Otherwise:
The idea is good, the limits do not really prevent using up all memory, 
_ACCOUNT is the better approach.
And with _ACCOUNT, it doesn't hurt that the namespace root is able to 
set limits.


--

     Manfred

