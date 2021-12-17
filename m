Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D79E47968F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhLQVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhLQVvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:51:50 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0797C061574;
        Fri, 17 Dec 2021 13:51:50 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id y22so6908774uap.2;
        Fri, 17 Dec 2021 13:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2n81BHcQENwCQ3YEUE98CV3ubhZaf5BOJMeyRLoCPw=;
        b=EPeAGhC7PjnOwghy82y4jkT8FX7habfMPn71bNpD7uEB0aAh831KSuXLues+XWrm9r
         0O7uGakXxVIwRuRK9937fb8zm6Yj+y3GkUS3P3OlDYUDRC7Jz4/hxaEbgJAKCby6y0P6
         FyAs3CXV8WLcHwufpg5ftaH4zd7avsc0E7IOP5+OFmO26eEWeBH6v0d4zsiMrvvHuVM5
         qIa6bDx2TWmR7s8w/w3tzj2xtfYwDfWlzTgegdnwqUwihp8B/9mjzm314/kcDzZowrZy
         2IMm7L2wpfGb0PmuYfFFz27eQOnpaUHEWjqoEKaRm4QzsjEl6wpnhDljjzWDKajR3sVF
         jI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2n81BHcQENwCQ3YEUE98CV3ubhZaf5BOJMeyRLoCPw=;
        b=aF13JvBbcw1w0Y4yDVGJWFljjGk9wSqyojwMoPk0I6fVVDzERQ99ILcEPEb9OqDeh6
         MGC8cGSGC4VVw+LVkunrLxe5ubTSPSCZhv3DS6QtCLZmqZiIWcYjkkKwaSdRlIZ4S3Bq
         inQypu4raVwBHKtUiidLsVQmOYUes8G50TRpKOtfB43+MsCmMiV2vQLR/MQWb49hcS2v
         VhiWQYh9kkbb6hBExaOBgkytknIJ9MmNvzZ2DN2CEklTOHel7ULX1jJBIR6aRUt5kNKQ
         2WXBpXzXPx4nU1oDgC+a/WKZQ2pPYWX9FjI+1qMtQLiKeem+NMwPrPTjbeAb01fXSgWO
         RVaw==
X-Gm-Message-State: AOAM5308fm3Og3GsSYn5UX2x74hTmhVyS9cV6nc5nAIfomHj3oFRQyzO
        rcEgkALyP0MBz7jrP4IuwVYLObAoaoInsLqti002Nk5YpiA=
X-Google-Smtp-Source: ABdhPJxJDQQzndQl4PQEsT6k0Z0vfJU1hu/u0NuoyuW8h8PbSpwF8KKS5BJu4z1xK667tv61DFz7OPncbF1llp165eA=
X-Received: by 2002:ab0:2545:: with SMTP id l5mr1976547uan.103.1639777909847;
 Fri, 17 Dec 2021 13:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20211214031553.16435-1-yajun.deng@linux.dev> <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
 <0d07e13a5454dfb03b22e5223d101a1b@linux.dev> <CAPhsuW6T_nqqfOtj_dVn9KV+iUbki2X3WU3pxfo25Ewj3i5ZjA@mail.gmail.com>
 <3ed867e06f7f9bb9d89beaafc50905c8@linux.dev> <CAPhsuW63KawpM0vBPo9gXjgELKMtUtsL0M4DkbwWZTkub2ZDSw@mail.gmail.com>
In-Reply-To: <CAPhsuW63KawpM0vBPo9gXjgELKMtUtsL0M4DkbwWZTkub2ZDSw@mail.gmail.com>
From:   Daniel Vacek <neelx.g@gmail.com>
Date:   Fri, 17 Dec 2021 22:51:38 +0100
Message-ID: <CAA7rmPGOL0vGg_6xxyTx5fNHP75ZYYXukF737ycqyLgmYpqoVA@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: fix abnormally high latency
To:     Song Liu <song@kernel.org>
Cc:     Yajun Deng <yajun.deng@linux.dev>, stockhausen@collogia.de,
        open list <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>, masahiroy@kernel.org,
        williams@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 1:19 PM Song Liu <song@kernel.org> wrote:
> I think allowing preempt may still affect the speed comparison. But
> such discrepancy
> should be acceptable. I will apply this to md-next.

No, please. This could eventually result with people starting to
report 'sometimes the storage does not perform' or 'random high CPU
usage on some boots' kind of issues.

We should not touch this. See my other email with detailed explanation.

--nX

> Thanks,
> Song
