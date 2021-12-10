Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC33946FCEB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbhLJIqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhLJIqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:46:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC87C061746;
        Fri, 10 Dec 2021 00:42:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o20so27906116eds.10;
        Fri, 10 Dec 2021 00:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjp7trcWfJyJK01y2ql41SX0hmC1hQH0mrMXyHW+2Hs=;
        b=NqRQ7yb7DNbmcDX0xULVOpdF14Ke+Eq71Bsf5R6opbNMHc/bwBWBT9iMsG9BLurMK4
         illARVTpym3Y1cCMbon8sC7kD9K7EVJFKIgPNNVxZF4+JthUutRKvxL6k9Eu9rpFa3mN
         ytpn25V88JVwPfI6OgBvmzNWa4sDM9dyzMC6K+ShOzQC4RQL/YDhxKE6lezzaaAmfnNL
         mNV6yfNcpqvscsJmt0iu6r1ufB1XngCciJlB6kJBDNYQICxmqAiNkX5Zmj+SVcjIVirV
         f9kvOCuscHcczZo0pfXHc7W6NOWL+qytYtWF3CZP2ZGZfhl0b73ixenYUc+a9WLEsPrc
         o46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjp7trcWfJyJK01y2ql41SX0hmC1hQH0mrMXyHW+2Hs=;
        b=40Sbb8iZPCTSpmrmFJGqGbpVOXqli5PuZ8fd/1TIiA/spXmA8Qc6l+eTPhkrKwUquL
         fqCCmwaWEK6EODj0P8TgZvTprKH9VkirRKbb7Gewkdr4RWYZJ+zJFYCjfcPSWe1vpceX
         B3+IA5IfVU0ng201b8eiiXu8r/J7Pb/MRqotV4ABRJZX/MemNKLy8ZJ6T7KEWJ6EAQnt
         jyWVOlHUkWxwrhmNLFzwAyragkMAiyQSyDTAM7VSxykgCepY8YhGxjPVRt1ByRecliOm
         9WGham4ePpalQF9F4jJIx9u0ZUAo77wMPWY+Uy1F7sujfMQZLyQZXM5s4lNR/mAe4iel
         Lodg==
X-Gm-Message-State: AOAM533jyPIGa1xnsTFr6Fcmr2YGOmMO14gWFr6+Zb9VWHaXcaMuhtTV
        6mZOmzsYjy5ltPJ0EVxpGGtt8bHtltzZKz68jMY=
X-Google-Smtp-Source: ABdhPJyBq4sqMdV9YOgX2LPfg7v0r1TyKLPSCgNFE9WC5dr6x7nuG0vtpTjgac6McvvCGXMKFokOKQeKqW5/o5klD8Y=
X-Received: by 2002:a17:906:9b92:: with SMTP id dd18mr21874490ejc.425.1639125776074;
 Fri, 10 Dec 2021 00:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20211209143519.60498-1-andriy.shevchenko@linux.intel.com>
 <20211209143519.60498-2-andriy.shevchenko@linux.intel.com> <5d98df66-a1fb-a2cf-f780-963bf26f6d1e@opensource.wdc.com>
In-Reply-To: <5d98df66-a1fb-a2cf-f780-963bf26f6d1e@opensource.wdc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Dec 2021 10:42:19 +0200
Message-ID: <CAHp75Vezco85W+TG+ehtMwtUyFubb+fbnn5XuyNQiNX4mJczXg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] ata: sata_dwc_460ex: Use temporary variable for
 struct device
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 4:25 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2021/12/09 23:35, Andy Shevchenko wrote:
> > Use temporary variable for struct device to make code neater.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> What is this based on ? Is this on top of Hannes series ?

Nope, on latest (available) Linux Next.
Hannes, can you incorporate this to yours maybe? I see one conflict
with the last patch.

-- 
With Best Regards,
Andy Shevchenko
