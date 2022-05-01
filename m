Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69045167CC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354623AbiEAUdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 16:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbiEAUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 16:33:01 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CDE4579D
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 13:29:34 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m23so16343614ljb.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WCdfVPEiIZbfwmSuN4pUHlfdRjDkBGXXq+S9mIzLMw=;
        b=aBHtGzDZ4qi+VE9Rk91uFJa58dwO9qAdJDh6FRARUFdk71fL/zPNFxPSkRoP9NeGmh
         s9YO/oxx/Ryl4lRK21Q6tW951kP/GrzfpZH1lTBoQ7lbQzLLSuxJCp6C7aOPJXlCO6Ne
         mDj53KCXjFDgtdoxLNONkrBR+GF1izY1YvzO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WCdfVPEiIZbfwmSuN4pUHlfdRjDkBGXXq+S9mIzLMw=;
        b=BFrQYXQcwljPSBHV2mZ5iQgz9mn2xFtLunBLK94ADsBxj8AgZjbsJ23mvZ+SgfJ9w3
         ETEGD7XutVR/xRhGEeB8J4KfdOFcF3Lzw/biCDo+V+aYZfdiLgAowpDj2GUsukpk3f+w
         CxtmLxInfAAJh4CdHPzjJzg4ava6uCzgUt7mjHE0T5htdOfds0sS+ZbfPpqlzDtxlreP
         tEX8RU0bBh57/zL0bSw5Dv7vw89vKECOUpuFs5ZReuTdtxAJKlcL8if2RvkconO8nNH5
         gDp7lnn+aSEH9+n6D9TFoA+BlHD89ocvkKIw0Xcvqpi3T82khLbXYtpQ9xQGNVPcf5pQ
         nNkg==
X-Gm-Message-State: AOAM5302HHJZUW4AJEn4OvLLBKbnkeGdXRiJxIJTCCNZNYMHpIM5XB3/
        C8PINjugzS9yF2z/TKQMhE6bZfsj15mPT843gjkvBxCzaUTT+9Xx
X-Google-Smtp-Source: ABdhPJwq0bqP3CIpf7H7b5QMwov+3I4DdcADmIkwqdINAd18fkcLIrD4+yERs89l89xgBUyELXGd+WMuVUjSjvUU+fA=
X-Received: by 2002:a05:651c:890:b0:248:5819:b949 with SMTP id
 d16-20020a05651c089000b002485819b949mr6240103ljq.476.1651436973033; Sun, 01
 May 2022 13:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOFRbG=mGdbR72moLtW87ZQW_T1HkhZtcpHRGzZy3NZ7afGVqQ@mail.gmail.com>
 <CAHk-=whXp7Ps9ML5ThsX1tvdRg6SKRH3r6MM1-EA_Y8-n+6v2A@mail.gmail.com>
In-Reply-To: <CAHk-=whXp7Ps9ML5ThsX1tvdRg6SKRH3r6MM1-EA_Y8-n+6v2A@mail.gmail.com>
From:   Ozgur Karatas <ozgurk@ieee.org>
Date:   Mon, 2 May 2022 00:29:21 +0400
Message-ID: <CAADfD8wdze1z4UX4w54hkumziwD0huJTxYVY+ojkOAXuVa1E=Q@mail.gmail.com>
Subject: Re: [5.18.0-rc4+] report: kernel compile
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ozgur Kara <zgrieee@gmail.com>, linux-staging@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 12:13 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, May 1, 2022 at 12:44 PM Ozgur Kara <zgrieee@gmail.com> wrote:
> >
> > Samsung RC530 (notebook) - FAIL (1)
> > Raspberry PI Model B - FAIL (2)
> >
> > Fail Log:
> >
> > + nvidia driver fail.
> > + scripts/Makefile.build:497: recipe for target 'arch/arm/kernel' failed
>
> Is there full information available somewhere?

Hi Linus,

this was an e-mail that automatically tests and informs on existing
hardware now i'm interested understanding issues because i wanted to
see if its kernel related or not, both seem to be caused by drivers
and in both of them driver was used with dkms (nvidia and rtl8812au
wireless).

I will be setting up the bot to send mail with details only in the
perpetrator and perpetrator logs.
Sorry, Regards.


  NVIDIA driver fail output:

nvidia-legacy-390xx-uvm.ko:
 - Uninstallation
   - Deleting from: /lib/modules/5.10.0-13-amd64/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.

depmod....

DKMS: uninstall completed.

------------------------------
Deleting module version: 390.144
completely from the DKMS tree.
------------------------------
Done.
Loading new nvidia-legacy-390xx-390.144 DKMS files...
Building for 5.18.0-rc4+
Building initial module for 5.18.0-rc4+
Error! Bad return status for module build on kernel: 5.18.0-rc4+ (x86_64)
Consult /var/lib/dkms/nvidia-legacy-390xx/390.144/build/make.log for
more information

   Raspberry PI fail output:

dkms build -m 8812au -v 5.6.4.2_35491.20191025

Kernel preparation unnecessary for this kernel. Skipping...

Building module:
cleaning build area...
'make' -j4 KVER=5.18.0-rc4+
KSRC=/lib/modules/5.18.0.-rc4+/build..........................................(bad
exit status: 2)
Error! Bad return status for module build on kernel: 5.18.0-rc4+
make: *** [Makefile:2304: dkms_install] Error 10

>
>             Linus
