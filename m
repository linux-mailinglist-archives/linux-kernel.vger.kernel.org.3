Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E9A4766EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhLPAXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:23:48 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37796
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhLPAXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:23:47 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 06496402FC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639614223;
        bh=NXEpqs11wJhxLhr2hGFsp1gTWREU+GIpmQhxyJLCwqQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=wDxYX7ksFU7BovcMcNLoLPdzrp8jSTdPdYzZAA8nB3Ah28RkIBQUfsEDEK9GAT0ha
         5+nW1GqtIfYoGCCcSa1W+5VgGbt5PVtul32UlQFeXqLHHPkZJ0inUskT1EYdzv7l/Z
         yshDyB/V0eqlN2akcXcP7YyJX5V9fVcK9z8dpDNqIxlNN5LGtA1yBu4EsQ/2WudEFi
         CW/I6UAPbBwChHcEQpJ9wpl+O06l+8MUXYU3E+ssHP2bpUEftF/FAk7+EC6GFFdw8d
         c/otahGEruB/RqtDbep7rsQH8ncEPMKG6McN8rKqHnxchiXXLGTg0vthqfpoMfRnKn
         wSXb0dB5UB+jg==
Received: by mail-oi1-f199.google.com with SMTP id bi9-20020a056808188900b002bc4f64083aso14841707oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXEpqs11wJhxLhr2hGFsp1gTWREU+GIpmQhxyJLCwqQ=;
        b=WvCtFkqhIFlc8qxqzF5j08QVRFn9DXKl5RnRVpfEsLIqTcakQ2yX8MzxZIdhfk0GwD
         0YYHxUJw7m+hZXpef091muZd9e/QBgR3PByaZhRzIvuHFz2hO9P/FWmoCy5xEKzpTsqW
         s/1pm5zmZ0590BurCRh77aJ3FZa4B+Uu3ieWLXCyV1hTe6B9PybIYevr1IkOetmwizHj
         10HuT5rSMtmm/nOe5hwN6MJEF4uQr6MiZStjMyGk/QaZ/4+0ZGbN92pMBT0ZULGWkk5N
         92ymDkJ5ehkyfzCfWbE19akGep8iCQsvFTUIJhQULmeVH1gL5VLfg8jty3BLhY7rSde0
         d69w==
X-Gm-Message-State: AOAM530P0vubv7Kzxk1LN1iGHI90rg7ysNdrGKOr+s00hOE88qaKozfb
        2bLMXQPh4GhIvcp28CyUEFlbx4sfbG5BdNgpdRbvr11xf6VvrNEGwKPwooA+QqP0UNCDniYR2Z3
        a8hatH8/603X9B2g7EinHIkRJmrU/exIyGWOR25/BuVb3WZFnOyuOvIwf+Q==
X-Received: by 2002:a9d:292a:: with SMTP id d39mr10790972otb.11.1639614221819;
        Wed, 15 Dec 2021 16:23:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzv/g29ju733vLu9DeNRCfIyC6Jv43aGjLqrwu/CBmKeZ3xs9KlDPgDwcOM9akcjDvZAtedKp4MD0nEvspnCGo=
X-Received: by 2002:a9d:292a:: with SMTP id d39mr10790957otb.11.1639614221546;
 Wed, 15 Dec 2021 16:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20211215120108.336597-1-kai.heng.feng@canonical.com> <YboN+GmeyeoypV1D@rowland.harvard.edu>
In-Reply-To: <YboN+GmeyeoypV1D@rowland.harvard.edu>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 16 Dec 2021 08:23:29 +0800
Message-ID: <CAAd53p5thAHXdmmEn9VV7nrWGu7W6UaEsB7hx7k9WYTBMG2GqQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: hub: Add delay for SuperSpeed hub resume to let
 links transit to U0
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Rajat Jain <rajatja@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:47 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Dec 15, 2021 at 08:01:06PM +0800, Kai-Heng Feng wrote:
> > When a new USB device gets plugged to nested hubs, the affected hub,
> > which connects to usb 2-1.4-port2, doesn't report there's any change,
> > hence the nested hubs go back to runtime suspend like nothing happened:
> > [  281.032951] usb usb2: usb wakeup-resume
> > [  281.032959] usb usb2: usb auto-resume
> > [  281.032974] hub 2-0:1.0: hub_resume
> > [  281.033011] usb usb2-port1: status 0263 change 0000
> > [  281.033077] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  281.049797] usb 2-1: usb wakeup-resume
> > [  281.069800] usb 2-1: Waited 0ms for CONNECT
> > [  281.069810] usb 2-1: finish resume
> > [  281.070026] hub 2-1:1.0: hub_resume
> > [  281.070250] usb 2-1-port4: status 0203 change 0000
> > [  281.070272] usb usb2-port1: resume, status 0
> > [  281.070282] hub 2-1:1.0: state 7 ports 4 chg 0010 evt 0000
> > [  281.089813] usb 2-1.4: usb wakeup-resume
> > [  281.109792] usb 2-1.4: Waited 0ms for CONNECT
> > [  281.109801] usb 2-1.4: finish resume
> > [  281.109991] hub 2-1.4:1.0: hub_resume
> > [  281.110147] usb 2-1.4-port2: status 0263 change 0000
> > [  281.110234] usb 2-1-port4: resume, status 0
> > [  281.110239] usb 2-1-port4: status 0203, change 0000, 10.0 Gb/s
> > [  281.110266] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  281.110426] hub 2-1.4:1.0: hub_suspend
> > [  281.110565] usb 2-1.4: usb auto-suspend, wakeup 1
> > [  281.130998] hub 2-1:1.0: hub_suspend
> > [  281.137788] usb 2-1: usb auto-suspend, wakeup 1
> > [  281.142935] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  281.177828] usb 2-1: usb wakeup-resume
> > [  281.197839] usb 2-1: Waited 0ms for CONNECT
> > [  281.197850] usb 2-1: finish resume
> > [  281.197984] hub 2-1:1.0: hub_resume
> > [  281.198203] usb 2-1-port4: status 0203 change 0000
> > [  281.198228] usb usb2-port1: resume, status 0
> > [  281.198237] hub 2-1:1.0: state 7 ports 4 chg 0010 evt 0000
> > [  281.217835] usb 2-1.4: usb wakeup-resume
> > [  281.237834] usb 2-1.4: Waited 0ms for CONNECT
> > [  281.237845] usb 2-1.4: finish resume
> > [  281.237990] hub 2-1.4:1.0: hub_resume
> > [  281.238067] usb 2-1.4-port2: status 0263 change 0000
> > [  281.238148] usb 2-1-port4: resume, status 0
> > [  281.238152] usb 2-1-port4: status 0203, change 0000, 10.0 Gb/s
> > [  281.238166] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  281.238385] hub 2-1.4:1.0: hub_suspend
> > [  281.238523] usb 2-1.4: usb auto-suspend, wakeup 1
> > [  281.258076] hub 2-1:1.0: hub_suspend
> > [  281.265744] usb 2-1: usb auto-suspend, wakeup 1
> > [  281.285976] hub 2-0:1.0: hub_suspend
> > [  281.285988] usb usb2: bus auto-suspend, wakeup 1
> >
> > USB 3.2 spec, 9.2.5.4 "Changing Function Suspend State" says that "If
> > the link is in a non-U0 state, then the device must transition the link
> > to U0 prior to sending the remote wake message", but the hub only
> > transits the link to U0 after signaling remote wakeup.
> >
> > So be more forgiving and use a 20ms delay to let the link transit to U0
> > for remote wakeup.
> >
> > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  - Add a small delay instead of waking up all hubs.
> >
> >  drivers/usb/core/hub.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 00070a8a65079..576fdf2c9f3c8 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -1110,7 +1110,10 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
> >               } else {
> >                       hub_power_on(hub, true);
> >               }
> > -     }
> > +     /* Give some time on remote wakeup to let links to transit to U0 */
> > +     } else if (hub_is_superspeed(hub->hdev))
> > +             msleep(20);
>
> Where did the 20-ms number come from?  Is it mentioned in the spec as
> the time required for a port to switch from U3 to U0?

The 20ms is the minimal time the device take to bring link back to U0 reliably.
The spec mentioned device has to transit the link to U0 before
signaling remote wakeup.
So do you think this requires a new quirk?

Kai-Heng

>
> Alan Stern
