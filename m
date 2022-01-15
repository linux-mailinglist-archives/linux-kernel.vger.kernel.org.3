Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5348F878
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 18:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiAOR1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 12:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiAOR1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 12:27:07 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A73FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 09:27:07 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id v6so16274856iom.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 09:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mu52mCpV2nrQW+DvvGvGXwkA9rgLAwESwOW831oZMnE=;
        b=d3c2rEAUTq64Y+w6197B+rfX3aaLSZ92yWel7tJ5VZaQnn0VPZTAewMBNDS0Tmud85
         KH5j5drTQzOAbIhxudKiZaXo9wwa46OCq2FVaGILXJmQ2lCLgWHDsnVykCSCjIeCHTY/
         ZQXHtXE3g9CAUtVdt2NYw02fZ7pg8W1ftQR0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mu52mCpV2nrQW+DvvGvGXwkA9rgLAwESwOW831oZMnE=;
        b=PPxljUrrA2uAwt2O4cnaVsECbW+fWN63hyAJuSTmgF6wvI4zsH2VGWSltVRSt7hs8e
         axI7VVRsVKPwPS6K2NP+ZIQZBjz/4lqicG2vF9UM723RbSwZ1nBNdQj7CYZZ14Ago6Q+
         sDGwGeQapU+gYSpXXWu2OMZHzg2e6mAH2Ci35J7wFpzfGnBwXaH8AFUX0YGRwDfqylZD
         Got6kSwb8DMzxipmpUY3Kb2mvneYXgwBcQu2Gs1QkFjX+jpYBvSdzYnR0lAYKOUUpiu+
         Ecetaj3sFrUWfcgh7Ne9cNZypAmK+c68ELSTTvvP3DTdkdAVgVLthiTs6TfDf8qv+DhB
         cX+Q==
X-Gm-Message-State: AOAM532NV1l8OswRlP+dwcF5DUIt6kKrDQ48AF1EtKEqZhSH2de0uVah
        uD33T3abDxSybIoVCQiQyNjUUzsKn5E4MQntCvrA6g==
X-Google-Smtp-Source: ABdhPJyR3JZ53vXZtEgCpx9pT/ydRQnd5TmsZ9xh4WkPiq1Hsx2lP0NtdPS27LZu4ouZ2C9SZTB2oznIMinprrNekro=
X-Received: by 2002:a05:6638:3012:: with SMTP id r18mr6621186jak.282.1642267626434;
 Sat, 15 Jan 2022 09:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20220106122452.18719-1-wsa@kernel.org> <Yd6gRR0jtqhRLwtB@ninjato>
 <98ed8d6d16a3d472d9432eb169aa2da44b66b5cc.camel@yandex.ru>
 <4dfbee97-14c2-718b-9cbd-fdeeace96f59@yahoo.com> <CAJMQK-h38XdN=QD6ozVNk+wxmpp1DKj21pkFZ+kY31+Lb8ot6Q@mail.gmail.com>
 <6121a782-6927-f033-1c09-ffe4ad7700ae@yahoo.com>
In-Reply-To: <6121a782-6927-f033-1c09-ffe4ad7700ae@yahoo.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Sun, 16 Jan 2022 01:26:40 +0800
Message-ID: <CAJMQK-j5YYqen78Vgng_5jhja-YKSTRut7f7vJ4wWufVfbZy6w@mail.gmail.com>
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

hi Tareque,


On Fri, Jan 14, 2022 at 6:09 PM Tareque Md Hanif
<tarequemd.hanif@yahoo.com> wrote:
>
> Hi Hsin-Yi,
>
> On 1/12/22 16:58, Hsin-Yi Wang wrote:
>
> Can you help provide logs if we apply
> 5a7b95fb993ec399c8a685552aa6a8fc995c40bd but revert
> 8d35a2596164c1c9d34d4656fd42b445cd1e247f?
>
> Issue still exists. journalctl log attached in revert_8d.txt
>
>
> > after apply 5a7b95fb993ec399c8a685552aa6a8fc995c40bd
> > 1. delete SET_LATE_SYSTEM_SLEEP_PM_OPS(i2c_suspend_late,
> > i2c_resume_early) and function i2c_suspend_late() and
> > i2c_resume_early().
>
> No issues. journalctl log attached in test1.txt
>
>
> > 2. delete SET_RUNTIME_PM_OPS(i2c_runtime_suspend, i2c_runtime_resume,
> > NULL) and function i2c_runtime_suspend() and i2c_runtime_resume().
>
> Issue exists. journalctl log attached in test2.txt

Thanks for the testing.
Can you help us test if applying the following patch on top of
5a7b95fb993ec399c8a685552aa6a8fc995c40bd works? Thanks

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9eb4009cb250..6b046012aa08 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -484,7 +484,7 @@ static int i2c_resume_early(struct device *dev)
        struct i2c_client *client = i2c_verify_client(dev);
        int err;

-       if (!client)
+       if (!client || dev_pm_skip_resume(dev))
                return 0;

        if (pm_runtime_status_suspended(&client->dev) &&
@@ -502,7 +502,7 @@ static int i2c_suspend_late(struct device *dev)
        struct i2c_client *client = i2c_verify_client(dev);
        int err;

-       if (!client)
+       if (!client || dev_pm_skip_suspend(dev))
                return 0;

        err = pm_generic_suspend_late(&client->dev);
