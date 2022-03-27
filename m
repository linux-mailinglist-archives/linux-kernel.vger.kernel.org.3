Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5C04E89CA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiC0Tj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiC0Tjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:39:55 -0400
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B90BB8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:38:13 -0700 (PDT)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id 706f5c1a-ae05-11ec-9ac0-0050568cd888;
        Sun, 27 Mar 2022 19:38:12 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 2BB79194B68;
        Sun, 27 Mar 2022 21:38:11 +0200 (CEST)
Date:   Sun, 27 Mar 2022 21:38:07 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/3] drm/panel: Add panel driver for NewVision NV3052C
 based LCDs
Message-ID: <YkC9H7Gap3vCv6Bz@ravnborg.org>
References: <20220321133651.291592-1-cbranchereau@gmail.com>
 <20220321133651.291592-3-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321133651.291592-3-cbranchereau@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

On Mon, Mar 21, 2022 at 02:36:50PM +0100, Christophe Branchereau wrote:
> This driver supports the NewVision NV3052C based LCDs. Right now, it
> only supports the LeadTek LTK035C5444T 2.4" 640x480 TFT LCD panel, which
> can be found in the Anbernic RG-350M handheld console.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
Please add:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

from the previous review round.

	Sam
