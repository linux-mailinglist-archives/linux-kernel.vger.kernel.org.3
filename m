Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F824662C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346625AbhLBLyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbhLBLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:54:00 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20FC061757;
        Thu,  2 Dec 2021 03:50:37 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c3so34874023iob.6;
        Thu, 02 Dec 2021 03:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZISskjc5oXX2lYsdOdBbcSsQiG48S/v64w/aU2Vkts=;
        b=G35r2bFRGVPnMAAuMBKGadKvHYo8/Y6sbRXIdZ5LUKeuE4Ib01CKZdAFlXwWKwc1kH
         DvNFQIXAGfSstyhlA9CgIFJM4DA46Ta9fCCVivRknnStzOiXjBiRnMBtHc4YDxlQ/VPG
         OYlfvD4nnp5lq0yHOux6CwhLSrbXkXtmYUAh09EBufr9hEAfjfSS2txIaxApxJrprt8R
         wSU0bqAHcYxASJCzlwbgou5u3WjlrlPxUZcTMx+JgsmmrdAy6tkthiLKic5CIQx+A6qS
         zH6cGb68KDreW7bDDoh8V9xWVbWyYJTQ9NVlXRdY2K/9ZsYQ9VNLXwKeGs0uYS0zPd0J
         Fviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZISskjc5oXX2lYsdOdBbcSsQiG48S/v64w/aU2Vkts=;
        b=H/EEmvVlvWTUpJ4IrFC3g+6Bvfm0+44qUV4CQy3idLZtIQyy38Y28jxXwK2uRhhOnw
         N1B/cuEgDKxzh6kk2J3XhQZL6BkMgBQE73KxF3FNBZbXMWSJY7qzEDMNAn3xCZrezbV9
         yeuN4arPDPFN/80ZmTd5Tzc1udSv01N/vjTJBQXIp0sLPEYtIj5txNyfLSNEnbSTEL26
         nKVv7FAtRwzU2MgNyn/78/ldTBbUa03YNNXe2vHTodBAV5Hss/TIBn3THCcbCk1k6X7K
         fRHi4r/fmtJNXL0zkUBLH23FlEJelFaM8kaH+J5xVTlssxRoK0Sv3cI/7Zlr4tKuyZAg
         /bUQ==
X-Gm-Message-State: AOAM5309FK0soEfjPiYH8USClVFZuNtVl9VEpO3srMDMakUDAFbtfqTm
        SHCidOyH1LNpMlxT0CqSL/O82+RdjMa40gOlxeQ=
X-Google-Smtp-Source: ABdhPJxcgyA+9Lafi669c+KxxrDP4+zJQpI89maaFyMYPCCP4+Nksn032jwjJA0X6w+d5G9wV7oCkzXf0ldZCDJv7B4=
X-Received: by 2002:a05:6602:1581:: with SMTP id e1mr15176090iow.64.1638445837371;
 Thu, 02 Dec 2021 03:50:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638369365.git.mchehab+huawei@kernel.org>
 <eb4e49b9a701643b07a56f1863005ba8216ef694.1638369365.git.mchehab+huawei@kernel.org>
 <CANiq72nu9TvLzxxj64b+EwFicwGexT7VTmVYVnVDzQgwkk+9ZA@mail.gmail.com> <20211202124700.7e395897@coco.lan>
In-Reply-To: <20211202124700.7e395897@coco.lan>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 2 Dec 2021 12:50:26 +0100
Message-ID: <CANiq72=JVG3kVcsfQJx-owBfSpL=OY+O8jhJ7WXBLciiDfJWQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] docs: allow selecting a Sphinx theme
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 12:47 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The RTD dark theme allows that. It basically places a <sun>/<moon>
> icon. When such icon is clicked, it switches between light/dark.

Ah, that is great! Thanks!

Cheers,
Miguel
