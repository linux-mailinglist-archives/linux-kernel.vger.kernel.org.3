Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFBB55C763
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbiF1EhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbiF1Egz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:36:55 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F39181CFF5;
        Mon, 27 Jun 2022 21:36:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 96B228106;
        Tue, 28 Jun 2022 04:31:39 +0000 (UTC)
Date:   Tue, 28 Jun 2022 07:36:50 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Fix refcount leak in omapdss_init_of
Message-ID: <YrqFYqem4t/oM0ys@atomide.com>
References: <20220601044858.3352-1-linmq006@gmail.com>
 <YpcMU9o8w/zoDE+J@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpcMU9o8w/zoDE+J@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [220601 06:46]:
> Hello Lin,
> 
> Thank you for the patch.
> 
> On Wed, Jun 01, 2022 at 08:48:58AM +0400, Miaoqian Lin wrote:
> > omapdss_find_dss_of_node() calls of_find_compatible_node() to get device
> > node. of_find_compatible_node() returns a node pointer with refcount
> > incremented, we should use of_node_put() on it when done.
> > Add missing of_node_put() in later error path and normal path.
> > 
> > Fixes: e0c827aca0730 ("drm/omap: Populate DSS children in omapdss driver")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks applying this into omap-for-v5.20/soc.

Regards,

Tony
