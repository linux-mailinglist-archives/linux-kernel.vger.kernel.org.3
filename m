Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA4547B050
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhLTPbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbhLTPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:30:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C551EC0619D8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:27:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so39849014edu.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elastic.co; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXpj1vp629gSs0ATSB+0fWXF2SHKFQXC0D6SE9fulsc=;
        b=HV5k2bEXzHRsIEW2knQNwXLdcLEhJ7QCZyTOHKHwiHLU7Vr1frm0j/3ct7MEi+TbAL
         auzpm+V+ijQ9uQ+CB1nDGDbzcGhhw62IBfOKo+yPFvQbucPjdnD01hYN1nKlHJxp+PI/
         hdDyhdzeOvVKxDZ8NAddL4hv3hlTzbzTn9ckM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AXpj1vp629gSs0ATSB+0fWXF2SHKFQXC0D6SE9fulsc=;
        b=UVuDBWffSP4iCewLKkuxqhwoxLsHSO8Ml849Ud8/1141fIFiaMMYvoYW1LWrEmRTRi
         L/FLr7tIlMYISGZbU91/VYouUOSVa1ZlNRq7WCjGJwuHlYpODkv7/iq9WZAUz104OEVW
         QzVcrIPMSUJUOlzjFh+8x2pZwmxjXWR1/A72u4/bQv3WEr+N7XyzMIEDQ9+aphXqVza1
         3/ch68Cj1OmzZuNmlhtvi/XiIJ9vLgXxKasu4tGFqvRIQrmaqCBPtjJOXPLsey/7YSkY
         0he9grh4XyXU2+4NtEmxW0ATZdKZ8iQUtJ2wNTM9l02x9Mc4j53jurEmWxo8sww//2aM
         zCnA==
X-Gm-Message-State: AOAM533iw2rfvJBQo1b6IJH0OZUk4HHDyT+0S1CX/yGcb3ZaEXSj5M6W
        9cXa7vX+M2lwUdUyCLTp5PI6Ig==
X-Google-Smtp-Source: ABdhPJwJGOV7KbK/D+HPi6v2dyWHGDUeD4dpoDpmquJ7tdFLpPw4IowXj6TxuLKTZEH04k2nSfcoEw==
X-Received: by 2002:a17:907:1c9c:: with SMTP id nb28mr13152129ejc.184.1640014024301;
        Mon, 20 Dec 2021 07:27:04 -0800 (PST)
Received: from localhost (host-82-50-106-104.retail.telecomitalia.it. [82.50.106.104])
        by smtp.gmail.com with ESMTPSA id f5sm5597778edu.38.2021.12.20.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:27:03 -0800 (PST)
Date:   Mon, 20 Dec 2021 16:27:01 +0100
From:   Lorenzo Fontana <lorenzo.fontana@elastic.co>
To:     Pu Lehui <pulehui@huawei.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Correct the INDEX address in
 vmtest.sh
Message-ID: <YcCgxQiEGLOd130m@workstation>
Mail-Followup-To: Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Pu Lehui <pulehui@huawei.com>, shuah@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211220050803.2670677-1-pulehui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220050803.2670677-1-pulehui@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 05:08:03AM +0000, Pu Lehui wrote:
> Migration of vmtest to libbpf/ci will change the address
> of INDEX in vmtest.sh, which will cause vmtest.sh to not
> work due to the failure of rootfs fetching.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/testing/selftests/bpf/vmtest.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index 5e43c79ddc6e..b3afd43549fa 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -32,7 +32,7 @@ ROOTFS_IMAGE="root.img"
>  OUTPUT_DIR="$HOME/.bpf_selftests"
>  KCONFIG_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/config-latest.${ARCH}"
>  KCONFIG_API_URL="https://api.github.com/repos/libbpf/libbpf/contents/travis-ci/vmtest/configs/config-latest.${ARCH}"
> -INDEX_URL="https://raw.githubusercontent.com/libbpf/libbpf/master/travis-ci/vmtest/configs/INDEX"
> +INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
>  NUM_COMPILE_JOBS="$(nproc)"
>  LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
>  LOG_FILE="${LOG_FILE_BASE}.log"
> -- 
> 2.25.1
> 

I was testing some failures with another patch and was about to do the
same.

Tested this in my environment.

Tested-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>

Thanks!

-Lore
