Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B443F487054
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbiAGC0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:26:01 -0500
Received: from mail-qv1-f45.google.com ([209.85.219.45]:33311 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344468AbiAGCZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:25:59 -0500
Received: by mail-qv1-f45.google.com with SMTP id kk22so4254331qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87V7qqVxSV9ymSZhSZ8xp9p8szVy6J09JVmD0DH7rzE=;
        b=w1zaNdYfzx0WGXjHO9rQqAm3NhJx1S5wIQIe05S9TDLOk19q5VkWqlUq2WZhjK6ZDA
         Fw2Hx1a56HgyyA6ZqXTvsfChu/fd773r/J6BP/DPWGQLv196lmSHM0SZx+tm/hfv9/gk
         bdJtKlUjo9aTSiDxe3T66Gy++BPnZtnlWvhrMFdZDaAUV1aVMwbVRDmT0no2Ijao5Un0
         StY8109URrG27u9ctwEeOLgO5DNntdNJsbqG4un1Tqb4hRbdrvKpS7UEOR41g+pv1Z4v
         spsUChQIljeMc9PNRuUxWHOj06kHmvP8L3t3yStZtLt34AwXBNJutjY6KQl5Ud1tVxe6
         NTBg==
X-Gm-Message-State: AOAM530fA3IQKB5hcGPvsd/ZsCA4iQdPV4o3LuVozcI53xIVsfh8j3iW
        /Achf3/bZTWkiSjVpeY3d2XRElJ0a8miOGRH
X-Google-Smtp-Source: ABdhPJwfQYwEP8Iw4ioYsijR0jBQHCbQXFUFfCO1goKcqM6eq3bgFgUpybMmhIx9drnFWKzPyuGEmQ==
X-Received: by 2002:ad4:5969:: with SMTP id eq9mr56396745qvb.108.1641522358874;
        Thu, 06 Jan 2022 18:25:58 -0800 (PST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id t204sm2439353qka.127.2022.01.06.18.25.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 18:25:58 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id q4so4191433qvh.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:25:57 -0800 (PST)
X-Received: by 2002:a05:6214:252a:: with SMTP id gg10mr57453503qvb.19.1641522357806;
 Thu, 06 Jan 2022 18:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20211211090845.252700-1-wangborong@cdjrlc.com>
In-Reply-To: <20211211090845.252700-1-wangborong@cdjrlc.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 7 Jan 2022 10:25:46 +0800
X-Gmail-Original-Message-ID: <CADRPPNRe=qgH0n2XMTEro2+dYXcz82x=PcvhjiPX1GRGkkbfjg@mail.gmail.com>
Message-ID: <CADRPPNRe=qgH0n2XMTEro2+dYXcz82x=PcvhjiPX1GRGkkbfjg@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: fix typo in a comment
To:     wangborong@cdjrlc.com
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhao Qiang <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 5:12 PM Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The double `is' in the comment in line 150 is repeated. Remove one
> of them from the comment.

Looks like you also removed a redundant tab in a new line.  We
probably can squeeze this trivial cleanup in, but we need to mention
it.

>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Applied for next with commit message updated.

> ---
>  drivers/soc/fsl/qe/qe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 4d38c80f8be8..b3c226eb5292 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -147,7 +147,7 @@ EXPORT_SYMBOL(qe_issue_cmd);
>   * memory mapped space.
>   * The BRG clock is the QE clock divided by 2.
>   * It was set up long ago during the initial boot phase and is
> - * is given to us.
> + * given to us.
>   * Baud rate clocks are zero-based in the driver code (as that maps
>   * to port numbers). Documentation uses 1-based numbering.
>   */
> @@ -421,7 +421,7 @@ static void qe_upload_microcode(const void *base,
>
>         for (i = 0; i < be32_to_cpu(ucode->count); i++)
>                 iowrite32be(be32_to_cpu(code[i]), &qe_immr->iram.idata);
> -
> +
>         /* Set I-RAM Ready Register */
>         iowrite32be(QE_IRAM_READY, &qe_immr->iram.iready);
>  }
> --
> 2.34.1
>
