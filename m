Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58894A2D0F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352477AbiA2IYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:24:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37778 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbiA2IYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:24:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA7B4B80D6D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B513DC340E5;
        Sat, 29 Jan 2022 08:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643444653;
        bh=5/jUt8ZFuRMy8Nor9Tbm4UlQ71QvAjZvWIkQVMS0w+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jV+GPyQ/QnCVacCVf10kLM2EN1ewkqhgONba2tC6mSynzPXeibT4qxfg3p1QS7BS2
         tjQLiTycRMSfcyZiaH692Vu6zfsbIqWJBdL+aKkveGlAy5iuJ8vg+ktCGYp3Hykkm4
         JVCc4Z9VrPjPugzyDhwU+5xubCVpDUwr2V1bCUow=
Date:   Sat, 29 Jan 2022 09:24:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Zhou Qingyang <zhou1615@umn.edu>, kjlu@umn.edu,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/acr: Fix undefined behavior in
 nvkm_acr_hsfw_load_bl()
Message-ID: <YfT5pf5hGwhnE+AK@kroah.com>
References: <20220124165856.57022-1-zhou1615@umn.edu>
 <YfPC3N+H9Fu/gqpz@kroah.com>
 <536c833413ccbe0b8ad653a50c5ea867bf975290.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536c833413ccbe0b8ad653a50c5ea867bf975290.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:20:24PM -0500, Lyude Paul wrote:
> Sigh-thank you for catching this - I had totally forgot about the umn.edu ban.
> I pushed this already but I will go ahead and send a revert for this patch.

No worries, thanks for doing this.

greg k-h
