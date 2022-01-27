Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0963649DB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiA0G4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiA0G4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:56:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8132C061714;
        Wed, 26 Jan 2022 22:56:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85DE8B81EDD;
        Thu, 27 Jan 2022 06:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F01C340E4;
        Thu, 27 Jan 2022 06:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643266574;
        bh=Bk/ODDsDukInU2AbtJrdGihYhKViotZzVIRZSDiAAZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2ULnNAWI/jgz5yl4AbaijDYmReI+YvOOHvJ9bILRbSw79Kdiquxyni1VMUpSii43
         5Ba58KaDGsuBRVxdGfhw9BgDItq/OCdIWCu4Vg1F7olfy8Cyuz6dNJ1LpW5uqOzkVt
         FmyBtUkiymestYCsswyzCXqrCvp3d7Lv4It48uC4=
Date:   Thu, 27 Jan 2022 07:56:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, jsarha@ti.com,
        tomi.valkeinen@ti.com, linux@dominikbrodowski.net,
        Peter.Chen@nxp.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] drivers: Fix typo in comment
Message-ID: <YfJCBZuc9mOZkIVJ@kroah.com>
References: <20220127065156.22372-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127065156.22372-1-tangmeng@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:51:56PM +0800, tangmeng wrote:
> Replace disbale with disable and replace unavaibale with unavailable.
> 
> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 2 +-
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c  | 2 +-
>  drivers/pcmcia/rsrc_nonstatic.c       | 2 +-
>  drivers/usb/chipidea/udc.c            | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

This needs to be broken up per-subsystem, thanks.

greg k-h
