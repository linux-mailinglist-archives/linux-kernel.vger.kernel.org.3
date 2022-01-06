Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69522485E73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbiAFCLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:11:04 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55514
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344590AbiAFCKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:10:55 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0503A3F1A4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 02:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641435048;
        bh=kCp8BU9jFTwzHT3B2Mn0sWuhrSLvpFWxrZu1tCP3WDA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KnBoUjDjiK3yLGSfnaxgRZVy1+NJ1DhMBu2EoeiuAWGaMLXE6EH9uYaoljHAKiLG9
         JZqnYO/9UZUa3fCNIav7WNTs2gAgbrRlvdUqdmVhX6tOCEYI2foCIVs0eItOkD0UOm
         IvolQJOomwxQ0IaHpnwK9tQxDPrHAXCNhlX3kJBfLFGCJqLnUXW72RkUkcZ/2Xsq92
         wdKg9YVu0S04pZuR9QYi02rXpr4AsKRXkUs1k39SyXya0agigq/wmwsyHGo5sHtlYX
         xlC3g9fdbk7cqsho0/LRonIkQOd/RaDogGAmM6QtJkczTA6vPWMan4CBlHePBhSzTN
         zsDdnmY8uLGtA==
Received: by mail-oi1-f198.google.com with SMTP id w133-20020acadf8b000000b002c6c86f4afbso842555oig.16
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 18:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCp8BU9jFTwzHT3B2Mn0sWuhrSLvpFWxrZu1tCP3WDA=;
        b=GfaiwrUwa6dJwF+kcgjZTBn65axP9BkFs8hIen3IOZwnYsu8P90kNkw3gbe3fgc/ry
         7tHWVU4G134Elt3A5eg1qKd2bk4GOmWZcTZCuVOQe7BD7TTdCLsFjWoSpRwbGFmjYxUn
         +0LRqCJrdpQU3e1hStHU2f8SE5Rpj8mWpKHoHoXaZkBJbZvgrjgFsnAuMHtnCnT+7E/e
         vDBK+0+Z9fkvLFn1ymWhW4jNvH7mCajpbw85N11YzdOMEUM8DbEo6fRrqZeXm0pnEcfM
         hq3HXvv7iVEtIeNdUZGVw7GnU+BiwCc+Tri+CUCXVBuavB5ejnSbSNUBI9dTrhrGsoux
         PvMQ==
X-Gm-Message-State: AOAM531xPsy9UsHN4wW/OkOcaeg5hVJs6+bTpaOPcWQcwSBATmqGJXe1
        zamowb6ZSF7lDNXTNPKZMrMxDAgzEdl0mXzfPTetVzGhjjQ0v+RzN8t2GVbps+IoVbAevMNnSyj
        iTWjNuiKYkehPEuQtCwBELX2M1GONBD+zcyBojP8+D2iUqVKNqF9AUVqyyg==
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr40165441ota.11.1641435046793;
        Wed, 05 Jan 2022 18:10:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxT8mA1RVuvMHANTIBtNwGuaoR73dzilRpdJyf0qMP2d/UoeS6lSFs6LwXWDZ0zwXeqNM4Dms4BFbsHVuK1d5U=
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr40165426ota.11.1641435046492;
 Wed, 05 Jan 2022 18:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20220105151427.8373-1-aaron.ma@canonical.com> <YdXVoNFB/Asq6bc/@lunn.ch>
 <bb6d8bc4-abee-8536-ca5b-bac11d1ecd53@suse.com> <YdYbZne6pBZzxSxA@lunn.ch>
In-Reply-To: <YdYbZne6pBZzxSxA@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 6 Jan 2022 10:10:34 +0800
Message-ID: <CAAd53p52uGFjbiuOWAA-1dN7mTqQ0KFe9PxWvPL+fjfQb9K5vQ@mail.gmail.com>
Subject: Re: [PATCH 1/3 v3] net: usb: r8152: Check used MAC passthrough address
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Aaron Ma <aaron.ma@canonical.com>, kuba@kernel.org,
        henning.schild@siemens.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, hayeswang@realtek.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 6:27 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jan 05, 2022 at 10:49:56PM +0100, Oliver Neukum wrote:
> >
> > On 05.01.22 18:30, Andrew Lunn wrote:
> > > On Wed, Jan 05, 2022 at 11:14:25PM +0800, Aaron Ma wrote:
> > >> When plugin multiple r8152 ethernet dongles to Lenovo Docks
> > >> or USB hub, MAC passthrough address from BIOS should be
> > >> checked if it had been used to avoid using on other dongles.
> > >>
> > >> Currently builtin r8152 on Dock still can't be identified.
> > >> First detected r8152 will use the MAC passthrough address.
> > > I do have to wonder why you are doing this in the kernel, and not
> > > using a udev rule? This seems to be policy, and policy does not belong
> > > in the kernel.
> > Debatable. An ethernet NIC has to have a MAC. The kernel must
> > provide one. That we should always take the one found in the
> > device's ROM rather than the host's ROM is already a policy decision.
>
> In general, it is a much longer list of places to find the MAC address
> from. It could be in three different places in device tree, it could
> be in ACPI in a similar number of places, it could be in NVMEM,
> pointed to by device tree, the bootloader might of already programmed
> the controller with its MAC address, etc, or if everything else fails,
> it could be random.
>
> So yes, the kernel will give it one. But if you want the interface to
> have a specific MAC address, you probably should not be trusting the
> kernel, given it has so many options.

Can udev in current form really handle the MAC race? Unless there's a
new uevent right before ndo_open() so udev can decide which MAC to
assign? Even with that, the race can still happen...

So what if we keep the existing behavior (i.e. copy MAC from ACPI),
and let userspace daemon like NetworkManager to give the second NIC
(r8152 in this case) a random MAC if the main NIC (I219 in this case)
is already in use? Considering the userspace daemon has the all the
information required and it's the policy maker here.

Kai-Heng

>
>         Andrew
>
>
