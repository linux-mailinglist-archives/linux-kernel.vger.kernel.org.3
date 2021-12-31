Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B34825AC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 20:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhLaTxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 14:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhLaTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 14:53:23 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0AC061574;
        Fri, 31 Dec 2021 11:53:22 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id o185so55278451ybo.12;
        Fri, 31 Dec 2021 11:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tofT5X8Ky8VJjrU9fps9vvYs2udpY1ZJrRJIJqMy6Xo=;
        b=NC4vE1NIbAFpDTLHljHkXgMQuL7lEZUUymJVoPwb3jSqhCFWkgfCRmLY7m2S5ls2FO
         juBIc1sAfpnF1DbKSQDi8pcMbte/mKuXXAuU7o5REjq1Ps3tNAkqEjhrA+gDKkTzuikh
         VY37rLSpyeN5TcAzv67obqiAEarJLMBxAxV5LhOD5PKvFCr4/LyKcLhWqMM4BCtls1Ya
         DPqoDut/qVi9IrkknkG4CATrMZRsJoctf4jn7lOIKAhYgS5hOvErR20D2LlONR32Tk3I
         BPlOTUJmDHmDBsnsuHvbN5J/xHLmXNDzyT/qH5FbN2D7/g/7OK/xuJ4mgsrUffsnj0qh
         EPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tofT5X8Ky8VJjrU9fps9vvYs2udpY1ZJrRJIJqMy6Xo=;
        b=FcyiNXT+ANpZG+6Xl2dvQ7RSDPOf9T2Mp8e/5nd64b3TAUiZAbkDY6d7W1xUTboQrH
         Q+DMrFMnOi3ft6XShQdpmymbr8yzeQEfEpKXKQiJvN21vd5wfjiPoKgFPbJ1tztvhyVe
         fgkg6wBN+a6alP0e97GDSlQRYJD0YeLzfHt/AZU7H4EGXDw/p/+HcGu1x96gLcD5P7Q/
         fvmGvC0S9qVHneaQ1ITeW4HBQ5sZhjxfBPnnb9n/elwbvXO/pQV4if+zGPdujHTKX3rs
         NOvQq3zDDlVFK74WF+kBEkt8lqsGke56cbiMDUEOX4XGQjHvN5VMv3+fr19yC5HhxBGy
         agjg==
X-Gm-Message-State: AOAM533dyzsiorfW9NJ/YKSRPDGcBonpVmlTxTPUx4KKKE2RBwIc6RQY
        ksnKQIXvBsoYyyjtIKhbqKSzff0yDdJtuOu8nmjyd7gv
X-Google-Smtp-Source: ABdhPJz4cAKTyeEHqZWTKvD4UAeWmRla7uiIwmyJVVxkalWZF1wyxJOuJE7ox45U2Vkf6wGIx5FNMVbupUCGSeGMi7k=
X-Received: by 2002:a05:6902:1149:: with SMTP id p9mr17360342ybu.398.1640980401917;
 Fri, 31 Dec 2021 11:53:21 -0800 (PST)
MIME-Version: 1.0
References: <02077a37-46d6-c94f-fa08-9da7ee99e42c@googlemail.com> <50ea1b0e-28d7-6d04-9c03-4becc4db143b@googlemail.com>
In-Reply-To: <50ea1b0e-28d7-6d04-9c03-4becc4db143b@googlemail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 31 Dec 2021 11:53:11 -0800
Message-ID: <CABBYNZLc9Pj=LYhL5MUUVkhenHb_xfT59aDDkdk14k7+ojeUzw@mail.gmail.com>
Subject: Re: 5.16.0-rc7+ Bluetooth error
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Fri, Dec 31, 2021 at 2:35 AM Chris Clayton <chris2553@googlemail.com> wrote:
>
> On 30/12/2021 09:21, Chris Clayton wrote:
> > Hi,
> >
> > I pulled the latest changes into my clone of Linus' tree and built and installed the kernel. (git describe gives
> > v5.16-rc7-9-ge7c124bd0463). I'm seeing errors reported by the bluetooth subsystem that i don't see in 5.15.12 or 5.10.89
> >
> > The problem seems to occur twice during system startup and on each occasion I see a batch of identical error messages:
> >
> > [    3.980822] Bluetooth: hci0: Failed to read codec capabilities (-56)
> > [    3.982812] Bluetooth: hci0: Failed to read codec capabilities (-56)
> > [    3.984812] Bluetooth: hci0: Failed to read codec capabilities (-56)
> > [    3.986608] Bluetooth: hci0: Failed to read codec capabilities (-56)
> > [    3.987621] Bluetooth: hci0: Failed to read codec capabilities (-56)
> > [    3.988606] Bluetooth: hci0: Failed to read codec capabilities (-56)
> > [    3.989650] Bluetooth: hci0: Failed to read codec capabilities (-56)
> >
>
> Sorry, I should have said that despite the above errors, my bluetooth devices still work fine.

Would be great to have the HCI trace (btmon).

@Kiran K Is this to be expected?

>
> > A full dmesg log is attached. I've also attached Two files containing the output from "lsusb -v" run on 5.10.89 and
> > 5.16-rc7.
> >
> > Please let me know if I can provide any other diagnostic information or test any patches. You'll need to cc me on
> > replies because I'm not subscribed to LKML or linux-bluetooth.
> >
> > Thanks



-- 
Luiz Augusto von Dentz
