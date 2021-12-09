Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3446E1BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbhLIFCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLIFCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:02:12 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F771C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:58:39 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 13so7105796ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 20:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JUzwZmVW79PQfIwn4LI60O/qzTJ2A/TwGcmTY9URtCo=;
        b=KtSxBlNxuWrfhm326HzjLd8CxvfDxye407sy21FHPaEo9JQfvWhGiH1QHOIunMmzZn
         AN/mVXAtmnlIVVqFaxyErfHi4mbXv46uIt9fltzjMlXgW2roTjzvC4NeUEDW0g6UIaea
         hjJDt5UXb0/eEiwksiIu+LDTIlCoLZ0tjJoNRUJRQdOhZ22terIWzwur9bFDJqHoOBfh
         JNfDr+Dzvlt0jHVb32LVa4MmwYc475E3Bb2wDNBuD39njjM49apkyLsbYodTfu0KhC0G
         /3TtnhjdujT79OdSHQoAJi9z8ZlFwvwSxd5lPgFR9uCVeiCYTUzkCKMx2prLlROK3HSM
         xzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JUzwZmVW79PQfIwn4LI60O/qzTJ2A/TwGcmTY9URtCo=;
        b=TiBq7peMbs73E52Aq20B2VMrSLU4iI1i/G8y+jn5qBaZK3ob6Vy1mN4ylYSp73oE7W
         Rs1GHHGxjynGxRoA6y1vGZYhpn7BpXfk4LKjOGSVaAR4gHnUveEGHQUaKPFgt5C6inYc
         gCfEANRXOlEundiLCXCwiae/kY3i+yKtxcGQ2nGbEZj31yM4nZY8SxELHFGPErvzvFbW
         OAsQc5hcsTNGEkVmAfArhRj3RR1cRXe5oBgk4/62M/fnt9zaMz0J5EgKDPWqNYuOUHYN
         QRJDJj1KdhCotQGxEA3SYQaWDs6Vkfj6jWqpqOMp+CX2rzXYLt8t2XgqZRKYMpW2AIS+
         VitQ==
X-Gm-Message-State: AOAM531BPrrKs5iwP0vdLoYsnXW0kI7/3M+JjAJRPJi59Gh1J9dpxQTP
        tXuHbpPFAFnSuBN5BVd7udMVWmZTK+wT7/YrMES5DA==
X-Google-Smtp-Source: ABdhPJz4I5bEAQekx8ajIWDuPktNAOdSwNoIPraWxk1286240rpG8n1J0is6bhpp+6w5szFI4t+nAYF/uRRS14WFE1c=
X-Received: by 2002:a2e:4a0a:: with SMTP id x10mr4033582lja.322.1639025916967;
 Wed, 08 Dec 2021 20:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20211207225458.622282-1-labbott@kernel.org>
In-Reply-To: <20211207225458.622282-1-labbott@kernel.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 9 Dec 2021 10:28:25 +0530
Message-ID: <CAO_48GHxfeC0Kq4j62BiJ7Xk_vQP0vXYBvuK6+bCczXOYJnGzw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail addresses for Laura Abbott
To:     labbott@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laura,

On Wed, 8 Dec 2021 at 04:25, <labbott@kernel.org> wrote:
>
> From: Laura Abbott <labbott@kernel.org>
>
> Consolodate everything under an @kernel.org address.
>
> Signed-off-by: Laura Abbott <labbott@kernel.org>
> ---
> Sumit, can you take this through your tree?
Thanks for the patch; sure I will!
> ---
>  .mailmap    | 3 +++
>  MAINTAINERS | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 6277bb27b4bf..e7a5bb0c35ae 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -203,6 +203,9 @@ Koushik <raghavendra.koushik@neterion.com>
>  Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
>  Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
>  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +Laura Abbott <labbott@kernel.org> <lauraa@codeaurora.org>
> +Laura Abbott <labbott@kernel.org> <labbott@redhat.com>
> +Laura Abbott <labobtt@kernel.org> <laura@labbott.name>
>  Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
>  Leonid I Ananiev <leonid.i.ananiev@intel.com>
>  Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 43007f2d29e0..21ab7c9d1bee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5715,7 +5715,7 @@ DMA-BUF HEAPS FRAMEWORK
>  M:     Sumit Semwal <sumit.semwal@linaro.org>
>  R:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
>  R:     Liam Mark <lmark@codeaurora.org>
> -R:     Laura Abbott <labbott@redhat.com>
> +R:     Laura Abbott <labbott@kernel.org>
>  R:     Brian Starkey <Brian.Starkey@arm.com>
>  R:     John Stultz <john.stultz@linaro.org>
>  L:     linux-media@vger.kernel.org
> --
> 2.33.1
>

Best,
Sumit.

--=20
Thanks and regards,

Sumit Semwal (he / him)
Tech Lead - LCG, Vertical Technologies
Linaro.org =E2=94=82 Open source software for ARM SoCs
