Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0E649076E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbiAQLwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiAQLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:52:14 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDD9C061574;
        Mon, 17 Jan 2022 03:52:13 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id k9so2663435qvv.9;
        Mon, 17 Jan 2022 03:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6hXXL8mWv5GPh/P7bia7mTJEIDbamCBVNF8AerKYLU=;
        b=IPLMgGuS+1UjluWsmuEHT2OaUU67wTfGSvPbx9hAcWXbS+enlwgTazh/02MniWvPHg
         wtBft3uLM9tqgF5w76wxg1jxilmXKdE/R+i/a06kF2Gw3xgZYhMmM+SjF0ltxus3qfTx
         Fr4h3NXjHIrKt21+UvuK1RdlIcJXWRIUQHD47LRAH531hbleEwQoMOqzeE0tyJuJCLH4
         V1sAmhIQofFOG+GnxFrP2lDi5DRqhImENDCxyngQlx/+mnlN4NPvsz8z1/yTMGrU+ozt
         o/IWAfHFCtyZAWVyxvr6BDA/2oO1HCq4ZUvk+pvqHSKa7ncoloT+AQ2AeUVvaRUbU5BL
         Cy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6hXXL8mWv5GPh/P7bia7mTJEIDbamCBVNF8AerKYLU=;
        b=YMkwuzqrcPHi5KjHeO0D5g07BXKYOIGrRyox0FORi64yaVpdE88csk/nFLRxGJcrpz
         djAJi/zekPPpFnubSypGPkMlDR9tgYAahPaDN31yalydlr70hlUpuvbk98oJUXp+rGTm
         vdGzj44RWMy/GlJoupSYk24vIwKX501SOvlLTwuv2UivXCCf6mWQsP97Y4uvPfoWBELZ
         b6hozY2JeHReEkTgyd6ShiWCLnaBGwy3saPOavagFHoNT4y6wq4eZur/qDFHXb30vumH
         NdjgjiAluciT9bD3ghX50Rm9SC9bJFLIHKS7wzdz4epyyLoId8zRDERAZX+O4kkj5gsY
         XpDg==
X-Gm-Message-State: AOAM533ofRXKBIib7/Uj/SOjEH3NNb9mhf8E3lbN8RBGP+DDEySScRB6
        9ii9FakiMRTfLNZ8m/ITCr57YWg/gB8U4J17ghDoLP7L9V4=
X-Google-Smtp-Source: ABdhPJwnjXgkRURCg4ZgaWtHhVV5jaYYzQ0xFci9AJZCm9KfbMKc/MQsnmT4DzE77FRogVfqa0jxFsosgHleT5QaXkU=
X-Received: by 2002:a05:6214:2528:: with SMTP id gg8mr18130557qvb.62.1642420332804;
 Mon, 17 Jan 2022 03:52:12 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNb22JCJ4AyR1sYqFtF4QUnvM3B2zQcc1svcm2mquWxoA@mail.gmail.com>
 <YeUvvIaVJnJrrpYe@kuha.fi.intel.com> <CABXGCsO5PYBuZ11YR16NLLa0H07Jom1JQhWHFuETfotfBfzkMw@mail.gmail.com>
 <YeVQsRp7aDMcQKs7@kuha.fi.intel.com>
In-Reply-To: <YeVQsRp7aDMcQKs7@kuha.fi.intel.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 17 Jan 2022 16:52:02 +0500
Message-ID: <CABXGCsMWXFFQY3L8ixK9K-gYX41_gTjqHRBXNp6gDpUgdnvFfg@mail.gmail.com>
Subject: Re: [Bug][5.17-rc0] Between commits daadb3bd0e8d and 455e73a07f6e,
 the kernel stops loading on my devices.
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 at 16:19, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> I don't know which tree you are working on top of, but the patch
> applies just fine on top of Linus' latest master branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>

Same here.

$ git remote -v
origin    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
(fetch)
origin    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
(push)

$ git show
commit 0c947b893d69231a9add855939da7c66237ab44f (HEAD -> master,
origin/master, origin/HEAD)
Merge: a6097180d884 9bbf8662a27b
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Jan 17 09:53:21 2022 +0200

    Merge tag '5.17-rc-part1-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6

    Pull cifs updates from Steve French:

     - multichannel patches mostly related to improving reconnect behavior

     - minor cleanup patches

    * tag '5.17-rc-part1-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6:
      cifs: fix FILE_BOTH_DIRECTORY_INFO definition
      cifs: move superblock magic defitions to magic.h
      cifs: Fix smb311_update_preauth_hash() kernel-doc comment
      cifs: avoid race during socket reconnect between send and recv
      cifs: maintain a state machine for tcp/smb/tcon sessions
      cifs: fix hang on cifs_get_next_mid()
      cifs: take cifs_tcp_ses_lock for status checks
      cifs: reconnect only the connection and not smb session where possible
      cifs: add WARN_ON for when chan_count goes below minimum
      cifs: adjust DebugData to use chans_need_reconnect for conn status
      cifs: use the chans_need_reconnect bitmap for reconnect status
      cifs: track individual channel status using chans_need_reconnect
      cifs: remove redundant assignment to pointer p

$ cat 0001-usb-typec-Test-fix.patch | git apply
error: patch failed: drivers/usb/typec/port-mapper.c:56
error: drivers/usb/typec/port-mapper.c: patch does not apply

> Thanks. I can see UCSI in your laptop dump, but not in the workstation
> dump. The laptop has the device nodes also for the ports as expected.
>
> Which machine is failing?

Both.

-- 
Best Regards,
Mike Gavrilov.
