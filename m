Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D530477BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhLPShr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhLPShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:37:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F30C061574;
        Thu, 16 Dec 2021 10:37:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c32so51487535lfv.4;
        Thu, 16 Dec 2021 10:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WoCFEsPptoGaxL0DQ4MIe889FRgum0E7Gj+FoxAQ4Y=;
        b=KyZJLiH6LKqYwwi55coZukwsGK+6cepBegf44ZWGRiuWeBC1UJVxanswvWEH+5yhqj
         j+qBi+PPYMtAvULsYW5rT1SV+KfEK2Yj8gpEMk1PLsYAGI8OywDLLFl5pcFm0FYSDL/7
         CXVaHYVyKac0co/3+yV2Xz6ZovzfOURZFbDPJS9pSNgGffA9H3GSNCoiHPeq/FiHDk1v
         3eWxVHdbe9ibvys1M+fwevRl+AeRJRCFRB1zUNaUzUPtvqEV4JAgS6JgOh1og9gN0sbl
         M66SPI0PSnl8+WK7nOitQ72RGVwnyHTVDD433rzUagWm95DfJ5piEDK1tkCfedmlwoG2
         tUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WoCFEsPptoGaxL0DQ4MIe889FRgum0E7Gj+FoxAQ4Y=;
        b=SPGbsSK7WqeGoK0eN0kfV3Gvb/IOyJMezxXhbaQisaLPq8HIB/qnuA/Bl5drQVjOh5
         uS9nLD/ZIk3w3ib8KiB5QRfMMv43lmAe5Bae5tV2BU9PANTs8nKQQG6wATMjwIXFoJGm
         tRN9j0rX3rPT/vtpC/ej2dEeHl9V3qn2ogqH/GFGZiTbYUloOFUILJDRb6s22QHWjA8n
         LMKI1KX0BQ1zvNzqIB8TP9EV4w06m26EST8Oyr23fGVGJbiFr2loIix+Y9TQnNp+XPT3
         /7HVc1MMHHJFwTT+iUCBusw/YqV9hyW0zG1D8WnzhFA5k7OuoeJKvfNJbf5stmEcApre
         jbfQ==
X-Gm-Message-State: AOAM532b2a+7KNrpqQRLjz3le5MCJK20LPNC0pkzYKVkwWGWvD5IwsZJ
        Iws6lBN60XV1Vs9u4Oru9udVteOG5daKcJqj6I+Yyovl
X-Google-Smtp-Source: ABdhPJxt6QpKP+gJtlgQ2gqzmYJoulQEwKSBL+Y8fEgiGgUqPE4Z7tBC4uAQTwmYE4WZ+J/qTET7r0OavemC6wvDlX8=
X-Received: by 2002:a05:6512:11e5:: with SMTP id p5mr15524007lfs.537.1639679864835;
 Thu, 16 Dec 2021 10:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20211217053511.45b50bc9@canb.auug.org.au>
In-Reply-To: <20211217053511.45b50bc9@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 16 Dec 2021 12:37:33 -0600
Message-ID: <CAH2r5mtb9BmjK8kAcC9imE82PdgkjRA=62wqDmRCqKYicwzM1g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the ksmbd tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed

On Thu, Dec 16, 2021 at 12:35 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   4ff2d94444b2 ("ksmbd: fix uninitialized symbol 'pntsd_size'")
>   2ac388a188ae ("ksmbd: fix error code in ndr_read_int32()")
>
> are missing a Signed-off-by from their committers.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
