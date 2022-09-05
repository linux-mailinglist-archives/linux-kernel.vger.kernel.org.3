Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2A5AD8F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiIESXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIESXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:23:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D336C24BD6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 11:23:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEC1D139F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 11:23:39 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49C543F534
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 11:23:33 -0700 (PDT)
Date:   Mon, 5 Sep 2022 19:23:25 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND drm-misc-next 0/8] drm/arm/malidp: use drm managed
 resources
Message-ID: <YxY+nbuKB74WfSNv@e110455-lin.cambridge.arm.com>
References: <20220905151910.98279-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905151910.98279-1-dakr@redhat.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 05:19:02PM +0200, Danilo Krummrich wrote:
> Hi,

Hi Danilo,

> 
> This patch series converts the driver to use drm managed resources to prevent
> potential use-after-free issues on driver unbind/rebind and to get rid of the
> usage of deprecated APIs.

Appologies for the extended silence, I was on holiday for 3 weeks and stayed away
from mailing lists. Will review the two series this week.

Best regards,
Liviu


> 
> Danilo Krummrich (8):
>   drm/arm/malidp: use drmm_* to allocate driver structures
>   drm/arm/malidp: replace drm->dev_private with drm_to_malidp()
>   drm/arm/malidp: crtc: use drmm_crtc_init_with_planes()
>   drm/arm/malidp: plane: use drm managed resources
>   drm/arm/malidp: use drm_dev_unplug()
>   drm/arm/malidp: plane: protect device resources after removal
>   drm/arm/malidp: crtc: protect device resources after removal
>   drm/arm/malidp: drv: protect device resources after removal
> 
>  drivers/gpu/drm/arm/malidp_crtc.c   | 48 +++++++++++++++++++++---
>  drivers/gpu/drm/arm/malidp_drv.c    | 58 ++++++++++++++---------------
>  drivers/gpu/drm/arm/malidp_drv.h    |  2 +
>  drivers/gpu/drm/arm/malidp_hw.c     | 10 ++---
>  drivers/gpu/drm/arm/malidp_mw.c     |  6 +--
>  drivers/gpu/drm/arm/malidp_planes.c | 45 +++++++++++-----------
>  6 files changed, 100 insertions(+), 69 deletions(-)
> 
> 
> base-commit: 8fe444eb326869823f3788a4b4da5dca03339d10
> -- 
> 2.37.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
