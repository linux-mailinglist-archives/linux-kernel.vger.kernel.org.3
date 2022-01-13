Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084ED48DCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiAMRJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiAMRJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:09:43 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BF1C061574;
        Thu, 13 Jan 2022 09:09:43 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b127so7927107qkd.0;
        Thu, 13 Jan 2022 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gX2Ig0+jzd2nNFdcRqpgTK+dKvsnFlyqT0cOjDcrDeI=;
        b=a1zwN0atpcvVjLGYvh8qmMjacfOi6F5mDnxtAMDrq6avbukpxfgV12ZeH4BDW1SqgZ
         HVYkOH70/vUT78OUaN42lFe/1AeFtEDgHoj6cPcRrYJkD1ZyrY+PfL9GpVOfn1jRjUg6
         DyoyZklrDZQthm4hx043d/mtTr2Guji/Z31uxRyiCGjIs9XQ8STqnoxuHBjBwEnA+U+0
         k85ptYmY0UfF5IPTdhgzKmje+hmzQJ/Z1ugDKUz//w7MOmDp3NSG6zOu0lvIYathGPfI
         U3r8XIF6xVBH+MCRoilUOAtpwYfYMk9IrS+RM48QfqXCsfmneUdtdMvcU0ZFQSYWiAQ7
         FVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gX2Ig0+jzd2nNFdcRqpgTK+dKvsnFlyqT0cOjDcrDeI=;
        b=v7hDaMJxANT1RusrkiLK5u8NxD9LbMv38eN24rpUw375FR/96Z+qcozUf5TicqXZbD
         xO1h0gY74f1aZ8HtpFawutLYa4gjMNYmpFvx8+VMSLC+9WwufjTPe+jpZhHBc35taf5r
         H4R/HnY86jy37RQ1Puy+UgZajZfsRzLHoqVhDW32Ob/dwPYUJoKwUqH/pXfYZOa6+EjG
         8nVyueWbbmgETlH95mGX5vbEwKowuuq+QaLDAhJyauMUKVIwSqCdXVJu/bbR9lFDK131
         wlKjncux8aKszibkAn9PB9Wor434+mwEme6TC4W7wOrkj2+v9t68J1wdlQflZZ/UXXaN
         iM7Q==
X-Gm-Message-State: AOAM530mxbX5+nB31tsLyDAYQZHHHzeqINstEycqvKBORFcMKXF0Craz
        yogoMiBVwDLJNRaila57LU8=
X-Google-Smtp-Source: ABdhPJywTKp+/gVL0VzmxS8Oy/1n3JQU61uju/LT09bgADOvZVBkMARFZ3K8hUuv8WCc9WptJQrePQ==
X-Received: by 2002:a37:5547:: with SMTP id j68mr3894092qkb.254.1642093782482;
        Thu, 13 Jan 2022 09:09:42 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id u18sm2420059qtw.16.2022.01.13.09.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 09:09:41 -0800 (PST)
Subject: Re: [PATCH v2] scripts/dtc: dtx_diff: remove broken example from help
 text
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220113081918.10387-1-matthias.schiffer@ew.tq-group.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <23ae99a0-a91f-8259-15c2-f9cf051f5ed8@gmail.com>
Date:   Thu, 13 Jan 2022 11:09:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113081918.10387-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/22 2:19 AM, Matthias Schiffer wrote:
> dtx_diff suggests to use <(...) syntax to pipe two inputs into it, but
> this has never worked: The /proc/self/fds/... paths passed by the shell
> will fail the `[ -f "${dtx}" ] && [ -r "${dtx}" ]` check in compile_to_dts,
> but even with this check removed, the function cannot work: hexdump will
> eat up the DTB magic, making the subsequent dtc call fail, as a pipe
> cannot be rewound.
> 
> Simply remove this broken example, as there is already an alternative one
> that works fine.
> 
> Fixes: 10eadc253ddf ("dtc: create tool to diff device trees")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  scripts/dtc/dtx_diff | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
> index d3422ee15e30..f2bbde4bba86 100755
> --- a/scripts/dtc/dtx_diff
> +++ b/scripts/dtc/dtx_diff
> @@ -59,12 +59,8 @@ Otherwise DTx is treated as a dts source file (aka .dts).
>     or '/include/' to be processed.
>  
>     If DTx_1 and DTx_2 are in different architectures, then this script
> -   may not work since \${ARCH} is part of the include path.  Two possible
> -   workarounds:
> -
> -      `basename $0` \\
> -          <(ARCH=arch_of_dtx_1 `basename $0` DTx_1) \\
> -          <(ARCH=arch_of_dtx_2 `basename $0` DTx_2)
> +   may not work since \${ARCH} is part of the include path.  The following
> +   workaround can be used:
>  
>        `basename $0` ARCH=arch_of_dtx_1 DTx_1 >tmp_dtx_1.dts
>        `basename $0` ARCH=arch_of_dtx_2 DTx_2 >tmp_dtx_2.dts
>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
