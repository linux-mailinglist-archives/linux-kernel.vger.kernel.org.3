Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC31248C3E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353131AbiALMZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353124AbiALMZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:25:14 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2FFC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 04:25:14 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i82so3340412ioa.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 04:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0Ed94N6PJ1HQvpwsTDcBAz1gPfqabvU1XtB9N89ivo=;
        b=i9YELGkPrF9QildKnEB0Dl461a8mPFeJ9M7JKTP5U2yLPD5Qyis0LkkhVGUzbd0RpI
         /P9zvBLoXiB15zji+qwH/xUWw+pRZlU1+I1m4SRLHwC6H8/GEBbhK+sL4dz43TxBPrHP
         fdSDxAOsL7O3hf1tG/sWVsfWRSmoMvMLYA4Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0Ed94N6PJ1HQvpwsTDcBAz1gPfqabvU1XtB9N89ivo=;
        b=kRlm9RZ6eCKaWn/hvwSfbgfaKWIQHRXPUf2wYVpc847qNptzBJ7rcJH/1XU9ULQ6v9
         Q05towokwQUqmEHjztbKUXvZxTstHIJ6KNtqLvjH0CYb9pFV7Yz5osVDYzBvhv6BKOGO
         jAnw5ujYKpeZXSVktEIxeNNA1b4jb+yEkKlYm0qY/5Ozhuw2cXU9KVoliL1xRAX/6e2J
         nw9nENmDhSkyEllmqidf13Vq2UO/eqIlwhfaUNEYe4QkbbvQ7lYizsSRtIFfp0+vxTVp
         iD9T0BUnSx9QAB+jfkuvYZcx2YtLuul1a3wcyh4ozrgffMPOE9hsP7S96QhpY7LllNtg
         JsAg==
X-Gm-Message-State: AOAM532aROAz4GE226DTYIZUuM75GspNXG8PbpTh7a1/IN+Qq2rT+EmW
        XvGERsdDqpeQw4Nevy5MwJQ27FsH9DPxJ8PwUiujMA==
X-Google-Smtp-Source: ABdhPJz3aWTJ6YHXl+DNpQfRBduYGsa3dA2FrH3qublefl99BTefVU7PwBsvrZTCfAWITEprI8dsA0VWgDMC1jSTU/M=
X-Received: by 2002:a05:6602:17d0:: with SMTP id z16mr4259571iox.204.1641990313893;
 Wed, 12 Jan 2022 04:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20220106122452.18719-1-wsa@kernel.org> <Yd6gRR0jtqhRLwtB@ninjato>
 <98ed8d6d16a3d472d9432eb169aa2da44b66b5cc.camel@yandex.ru>
 <4dfbee97-14c2-718b-9cbd-fdeeace96f59@yahoo.com> <CAJMQK-h38XdN=QD6ozVNk+wxmpp1DKj21pkFZ+kY31+Lb8ot6Q@mail.gmail.com>
In-Reply-To: <CAJMQK-h38XdN=QD6ozVNk+wxmpp1DKj21pkFZ+kY31+Lb8ot6Q@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 12 Jan 2022 20:24:48 +0800
Message-ID: <CAJMQK-g1pqg05K+ZL0R3i67gitEVoZQ2jbOuL=Q2djBr45soAg@mail.gmail.com>
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in adapter"
To:     Tareque Md Hanif <tarequemd.hanif@yahoo.com>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 6:58 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> hi Konstantin and Tareque,
>
> Can you help provide logs if we apply
> 5a7b95fb993ec399c8a685552aa6a8fc995c40bd but revert
> 8d35a2596164c1c9d34d4656fd42b445cd1e247f?
>
Another thing might be helpful to test with:

after apply 5a7b95fb993ec399c8a685552aa6a8fc995c40bd
1. delete SET_LATE_SYSTEM_SLEEP_PM_OPS(i2c_suspend_late,
i2c_resume_early) and function i2c_suspend_late() and
i2c_resume_early().
2. delete SET_RUNTIME_PM_OPS(i2c_runtime_suspend, i2c_runtime_resume,
NULL) and function i2c_runtime_suspend() and i2c_runtime_resume().

Does it still fail if we do 1 or 2?

Sorry that we don't have a platform with intel CPU and amd GPU
combination to test with.


> Thanks
>
> On Wed, Jan 12, 2022 at 6:02 PM Tareque Md Hanif
> <tarequemd.hanif@yahoo.com> wrote:
> >
> >
> > On 1/12/22 15:51, Wolfram Sang wrote:
> > > would the reporters of the
> > > regression be available for further testing?
> > Sure. I am available.
