Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE10B49F68A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347672AbiA1Jjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243799AbiA1Jjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:39:33 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AB4C061714;
        Fri, 28 Jan 2022 01:39:32 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id d188so6987855iof.7;
        Fri, 28 Jan 2022 01:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOWNK48mEIZNTEIU7X2S+zCbDX4zoirQGUmKxIAmRuY=;
        b=dYsqpb0VN19LiiHn0Ftk9MiBf8mLuwmItMaty3MbxyFbZsMAprnM3GLwYQMQizXEde
         OXUdAouUsM70Dc4jnK61YRQjw3xCjt2tyvts4oByrKh8WeBqLuW/0zMEhjo5zJjn/maz
         2gqEuVK9StCfUcp0QWSBnaMkrJpBmIDqrIAvDjqgo33CVzzKz49I07l1H/emAMyU/CFf
         Ep/7ufX3WJdoBL9KGTvqzN7NAg77FAo8WeSLjjf1Vz5sC3mDPUWoNfiiyA/IvyRml2Ki
         w5SXy/DhkQZhKnJ9YCkkBLIM0uXaxiz56Cz/skvyda28JMRfIBuA1dXf0LiBFsmHbTjM
         eckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOWNK48mEIZNTEIU7X2S+zCbDX4zoirQGUmKxIAmRuY=;
        b=fiX18102lf5fpk4c2cSMThhQx++ZUfdFF3MjX3Me7gfe9q1fmaiZ2/BIivZmuQUGR8
         gwd3nWq58nNs5IOwXw+eKZPZY8igZXyZi1VrV/MTu/MZT1isvvAHbdpDtiMrAjbR0zu3
         COisBZnZUnN4YNcCOZyr73kL5XNRn7+bLiTEpOBxeeNlc0EXTG/Nr6+r6CRN/Le1FonW
         LUmIFYFWtOXPGyg7oX9ki2yA2e5DG2b+K3fFuygcgwhr1x9k8lUP3wbWSc+pJdiGP5i1
         9riWlLCQE/wbBpLpW9Fb5+KAsAiYHXSbWYxI9mxynthkz3lmLBbG/3sNlHz1BI/lSjFr
         aFzw==
X-Gm-Message-State: AOAM533+9QptSnq0tdNjfiJva4NRLNcXGAWdSEB89ZpKik7Jq3PETziW
        PhR6n5SPNrKF+nrjln3Gm3V00VzJhnvM0Azhhis=
X-Google-Smtp-Source: ABdhPJyRd+01JR5slNdfK/hcvj1Z2MmaGnoA6OcUp5mGkvnMhpK2nOyd9h65xhRei/JqMCZ7vgEv9TSAUFET9ewfa1A=
X-Received: by 2002:a05:6638:380f:: with SMTP id i15mr3355679jav.308.1643362772321;
 Fri, 28 Jan 2022 01:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20220127151945.1244439-1-trix@redhat.com> <953eb015-4b78-f7b-5dc1-6491c6bf27e@linux-m68k.org>
 <CAKwvOdnWHVV+3s8SO=Q8FfZ7hVekRVDL5q+7CwAk_z44xaex8w@mail.gmail.com>
In-Reply-To: <CAKwvOdnWHVV+3s8SO=Q8FfZ7hVekRVDL5q+7CwAk_z44xaex8w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 28 Jan 2022 10:39:21 +0100
Message-ID: <CANiq72mjngfR8-y9B_yHXVXpm5zFOo1dP=nNd-j+Ge8RtoEfTA@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Nathan Chancellor <nathan@kernel.org>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 11:47 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Miguel (the clang-format maintainer), Joe (checkpatch maintainer)
> These criticisms are worth reviewing.

Indeed, thanks Nick. In my upgrade to clang-format 11 (from the
current clang-format 4), I will check whether some of these improve.

Cheers,
Miguel
