Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378B9497727
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiAXCFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiAXCFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:05:36 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332FAC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 18:05:36 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id p37so14409780pfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 18:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVbTRaI7NqeGyphZGZTim5h2yHTmZlRh1x8O4EUfCFw=;
        b=8R7GJa3d94IQdQ/rsG5ye0R1Qv8+YVhsjeHqLVsKe7iAUhomBKGspz4eD14Wxtz4jr
         zLYIG7FUygNj6lhfiefddT4tpRIYyx9ixD2JUoMj1tC7z5QBGW5kNFn1NULc9IbQh1jh
         udtkHd/LLhci1Bwai83qYECNGxmsz5CIQjrlzelUR1gni1XruKriNDp6zc0unp5MwX4L
         ab1MdQsniSSbt44n4D94Vr/Lpy6TiH8qvijtdQuelCzRvx9ghhQtUlvhJSPXIc+pKBB5
         0btNbc7LHzhdwpE5EY8oZFrCrQvqIXRth632NyuXqmzgEDEUOhHZPkSc7kO/zLyRFDTA
         i0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVbTRaI7NqeGyphZGZTim5h2yHTmZlRh1x8O4EUfCFw=;
        b=qYdp+PrOVS07GuPs0i9k5vKWT6pj+jsIilCJFWwzFJez66UhMsph3TYqLnjLrKAnao
         G4HJE6uNaqMMguK1C+M0rH7VHdE6b9bxEDPqPKBa7xW1/Gvz7z7bAEacpgzvWpuMvRdk
         pMo4v27D3u0YY75LBjYsYD/do1DxROgbcLa3ac3Ck4r/ASRJxU3+lMKHtOLBV8iFLG+s
         zALV/3o+gcMc0v51/DBuvmDhggaOHRmSIiKkENy8STGbm0D8Njx06qEO7rXJ/gUKY3ol
         G9MKcxO7B/Oi27Ke0oYaR9CqPBFQZhE1OFkNaXiMI0pXfdYeSvCS+NGhuU5XbRN6/W8E
         +pcg==
X-Gm-Message-State: AOAM530ihvu+xRFM24Y+2zeYXsc0r160m6iB4Wq5NT467rM/oLYd4EQJ
        /xFEDa9c7cmhFFB2fJCUHaocjlyyT+Wshy1ffHDE9dnDPxY=
X-Google-Smtp-Source: ABdhPJzOy2CpTn0sciVChu5umB+ipagLLGcCCZ5I3s8r/PYSJm7gfKWQzEebtndZaP+2DPpy/o1S++BC4taGA4aH2Xc=
X-Received: by 2002:a62:1aca:0:b0:4c8:f0b7:48ac with SMTP id
 a193-20020a621aca000000b004c8f0b748acmr4195076pfa.64.1642989935546; Sun, 23
 Jan 2022 18:05:35 -0800 (PST)
MIME-Version: 1.0
References: <sq0965$aed$1@ciao.gmane.io>
In-Reply-To: <sq0965$aed$1@ciao.gmane.io>
From:   Jon Masters <jcm@jonmasters.org>
Date:   Sun, 23 Jan 2022 21:05:24 -0500
Message-ID: <CACCGGCfQp7W3dCPNDh9sWTBCpC-adFwhhDaoHhwx8dyXa3UBeA@mail.gmail.com>
Subject: Re: Selecting MMU page size for an architecture
To:     Sergey Organov <sorganov@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sergey,

On Thu, Dec 23, 2021 at 8:15 AM Sergey Organov <sorganov@gmail.com> wrote:

> We are building custom CPU and have an option to choose either 4K or 16K
> MMU minimum page size that will then be fixed in the hardware. For
> reasons unrelated to the Linux kernel we'd prefer 16K, but I have some
> doubts.
>
> What pros and cons for kernel and user-space operation 16K pages will
> have over more usual 4K pages? Anything we should worry about?

If you want maximum compatibility with existing source written for
industry at large (e.g. x86/Arm) and even the assumptions in other
devices (and their firmware) you might connect (PCI, or even on-SoC)
then you'll want to go with 4K. However, if I were designing a brand
new architecture today and didn't care about legacy, I would
definitely consider following Apple into 16K.

Jon.

-- 
Computer Architect
