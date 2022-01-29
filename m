Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7994A2D2B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352555AbiA2Ici (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242166AbiA2Icd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:32:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AED2C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:32:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9E17DCE284C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AC4C340E5;
        Sat, 29 Jan 2022 08:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643445150;
        bh=3ekBSUf3XpJYgU1w4+4Uzq8+Tw7omrg/rrrMVHvU9+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwwwFkTn1Y9dipsCk6jDkrYiIa4lZSTUypnip7Ydsg1jP6Igijb/OEMgy58DX5otZ
         tbCdbcR0QB4HuoZgjLprXJUSsr13LK0ivw2/HNAZcKcwZ/8DJlArv/zcwWIETQMgPH
         RP37klQCZrpZYUqA/2AkQNmKfylxp1VF23IN/ui8=
Date:   Sat, 29 Jan 2022 09:32:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Zhou Qingyang <zhou1615@umn.edu>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Kangjie Lu <kjlu@umn.edu>, LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] drm/nouveau/acr: Fix undefined behavior in
 nvkm_acr_hsfw_load_bl()
Message-ID: <YfT7m3muMAFzCooc@kroah.com>
References: <20220124165856.57022-1-zhou1615@umn.edu>
 <YfPC3N+H9Fu/gqpz@kroah.com>
 <536c833413ccbe0b8ad653a50c5ea867bf975290.camel@redhat.com>
 <CADnq5_MtMPNHbs92OMHEzvPYSHGt=nPJMdrny6Siuvj3SYTAXQ@mail.gmail.com>
 <9457f3e139bdf3938e829e1affd01300c11c67dc.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9457f3e139bdf3938e829e1affd01300c11c67dc.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:57:36PM -0500, Lyude Paul wrote:
> On Fri, 2022-01-28 at 14:53 -0500, Alex Deucher wrote:
> > On Fri, Jan 28, 2022 at 2:20 PM Lyude Paul <lyude@redhat.com> wrote:
> > > 
> > > Sigh-thank you for catching this - I had totally forgot about the umn.edu
> > > ban.
> > > I pushed this already but I will go ahead and send a revert for this
> > > patch.
> > > Will cc you on it as well.
> > 
> > This seems short-sighted.  If the patch is valid I see no reason to
> > not accept it.  I'm not trying to downplay the mess umn got into, but
> > as long as the patch is well scrutinized and fixes a valid issue, it
> > should be applied rather than leaving potential bugs in place.
> > 
> 
> Yeah - I sent a revert for this, but that was mainly just to make sure I
> didn't cause problems with Linus or something like that. If it's all the same
> I'd much rather just leave this patch in, as looking at the code the fix seems
> completely valid.

You will not cause any problem at all, don't worry about this, it's not
your fault or responsibility.  If you think the patch is fine, that's
great, no problems.  But be extra careful here, treat these developers
as you would with any other "they are known to send bad patches so are
safe to ignore if I don't want to deal with it" group that many of us
maintainers already have to defend against.

thanks,

greg k-h
