Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6DB4A2D2F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352602AbiA2IdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:33:22 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58034 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242166AbiA2IdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:33:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AC306CE009A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BA6C340E5;
        Sat, 29 Jan 2022 08:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643445183;
        bh=qYtXeLAkgSSnf9W7arwFjXpYcJVeJmHx7Z6ifsGLxh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtFEs+7zy1Beu8UwRQUXnpvGLbi3PhO3WDCd6W7iEE1fbcUQNs01ZczlZ3AkbzbgS
         cyQRjxTS3ULqARCcmsgN8BZaULAJl/Ev/+xHYRhF/VRlx7+HnbkAxEsQBnP9DBwrhZ
         aRdkvMFa9eYhNsOUcC+QUIUWO06QxMDtsUZxelrg=
Date:   Sat, 29 Jan 2022 09:33:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhou Qingyang <zhou1615@umn.edu>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "drm/nouveau/acr: Fix undefined behavior in
 nvkm_acr_hsfw_load_bl()"
Message-ID: <YfT7vMmd8TdhzLVH@kroah.com>
References: <20220128192951.626532-1-lyude@redhat.com>
 <8a01bf1d367a702cd41e6cb1281294e82a48f541.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a01bf1d367a702cd41e6cb1281294e82a48f541.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:59:42PM -0500, Lyude Paul wrote:
> on further reconsideration: Self-NAKing this. I don't see any issues with
> those patches.

I agree, the original change looks correct here.  Thanks for the
re-review.

greg k-h
