Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395FA4CB99E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiCCIxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCCIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:53:28 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F522513;
        Thu,  3 Mar 2022 00:52:42 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c4so4026701qtx.1;
        Thu, 03 Mar 2022 00:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3YwZrIa1hnk4V8mHJmIK2SN5I6btSlJmKT0fdYrMXk=;
        b=Gz/mjzbyYfOVzRYClOrl/oyLlSXePDrUzU5Tt1UNSLl0QuI5SttrDXkbM7pmQXqSF8
         6jqor/+j/mYgaUfwVT7dXXSiZbcSgJrel08vkujji3dil/SbdNQ6nm7pyq4hmjrrbvJP
         m691AfNnSoKx6EMcIVoctPebz/Gkj0vIXbz30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3YwZrIa1hnk4V8mHJmIK2SN5I6btSlJmKT0fdYrMXk=;
        b=0P1SmQlBTIiil7f1byZVp8xqNBdN24UKaXzRyy+V2vHvmNT7FAooP7B8+GGIiJLqul
         u/iQzSY5nTcAjeijuHNcgZ31B7WpZtINUB/+EOQHL77NGpG1En3LvHVThwu6yNMfvS0j
         Sr4QZNq4bkA/nZbXB3O12xnsk+VJPUXfk5RUfvHfrCoJiZn3dcWEACLdKDNUv+E2rsiw
         JUZAxS4qQewUZjC+75bNWSOWI2A+4dODABJWhBZvfVjlYDV0oc2+IXlLoyCPZMdmLTfI
         cwn2qg/sEmigWpYbrf9bxA/axR3V+Sr3ulUaSph/BrG5EvIHkGKvDZ1FTpWNQ31PlGle
         5YNQ==
X-Gm-Message-State: AOAM533FUVQ9MB8H2lAj7qjsBk5cRmOFgzMjgXynMTDXVRJ7o+nWc1YM
        wHooHRruB2ZLrsZmYfbU0st93PbgcC+nfETqWsw=
X-Google-Smtp-Source: ABdhPJzwz+Ngz65boCEemD+fRKPQrTxsbFiMK6xQltfABMfoEWApCyZjYRtn/H7SDZ4Vs+t6ywXdg+xYBGqcPwmyB4Y=
X-Received: by 2002:a05:622a:1b8d:b0:2c6:59a9:360e with SMTP id
 bp13-20020a05622a1b8d00b002c659a9360emr26590611qtb.678.1646297561365; Thu, 03
 Mar 2022 00:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20220301224446.21236-1-eajames@linux.ibm.com> <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
In-Reply-To: <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 3 Mar 2022 08:52:29 +0000
Message-ID: <CACPK8XfoCXisL=udkuO-x4LZ3r-9iKA2d7oLb7KmXs3+LkQgnQ@mail.gmail.com>
Subject: Re: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
To:     Johan Hovold <johan@kernel.org>
Cc:     Eddie James <eajames@linux.ibm.com>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 at 08:25, Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Mar 01, 2022 at 04:44:46PM -0600, Eddie James wrote:
> > IBM manufactures a PL2303 device for UPS communications. Add the vendor
> > and product IDs so that the PL2303 driver binds to the device.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > ---
> > Changes since v1:
> >  - Fix commit message Signed-off-by ordering.
>
> Almost there. You're still missing a Co-developed-by tag, a From line,
> or both.

It's neither. This patch was applied to a tree by myself, and I asked
Eddie to send it to mainline for merging.

Given it's come through me, and now has been sent to you, I think the
chain of s-o-b is appropriate.

Cheers,

Joel


>
> Please take another look at the documentation I pointed to.
>
> Johan
