Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F25648624D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbiAFJqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:46:02 -0500
Received: from muru.com ([72.249.23.125]:46572 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237427AbiAFJqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:46:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D59C680B5;
        Thu,  6 Jan 2022 09:46:46 +0000 (UTC)
Date:   Thu, 6 Jan 2022 11:45:58 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     OpenPVRSGX Linux Driver Group <openpvrsgx-devgroup@letux.org>
Cc:     tomba@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com, philipp@uvos.xyz, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, linux-omap@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [Openpvrsgx-devgroup] [PATCH] drm: omapdrm: Fix implicit dma_buf
 fencing
Message-ID: <Yda6VhRLHw06yVst@atomide.com>
References: <1641397018-29872-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641397018-29872-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [220105 15:38]:
> Fix that by initializing dma_buf resv to the resv of the gem object being
> exported.

Nice find! This also fixes my wlroots test case with termite running on
sway where termite would only partially update when switching between
desktops, so:

Tested-by: Tony Lindgren <tony@atomide.com>
