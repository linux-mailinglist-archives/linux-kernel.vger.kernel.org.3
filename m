Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD24BD210
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 22:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbiBTVhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 16:37:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiBTVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 16:37:02 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E33C26EC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:36:39 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id 3b3c4443-9295-11ec-b2df-0050568cd888;
        Sun, 20 Feb 2022 21:36:58 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 1B50C194B05;
        Sun, 20 Feb 2022 22:36:40 +0100 (CET)
Date:   Sun, 20 Feb 2022 22:36:35 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     tomba@kernel.org, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, maxime@cerno.tech
Subject: Re: [PATCH] drm/omap: switch to drm_of_find_panel_or_bridge
Message-ID: <YhK0Y3D0O87T5fVW@ravnborg.org>
References: <20220220195212.1129437-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220220195212.1129437-1-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi José,

On Sun, Feb 20, 2022 at 08:52:12PM +0100, José Expósito wrote:
> Use the "drm_of_find_panel_or_bridge" function instead of a custom
> version of it to reduce the boilerplate.
Thanks for looking into this.


From the documentation of drm_of_find_panel_or_bridge():

 * This function is deprecated and should not be used in new drivers. Use
 * devm_drm_of_get_bridge() instead.

Are you OK to give this a second try with the above referenced function?

There is a good chance the deprecation happened after you looked into
this first, sometimes things moves fast in the drm sub-system.

	Sam
