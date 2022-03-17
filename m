Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B724DCEBA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbiCQTWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbiCQTWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:22:35 -0400
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E62E2296FE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:21:13 -0700 (PDT)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id 67a4b5b8-a627-11ec-9ac0-0050568cd888;
        Thu, 17 Mar 2022 19:21:11 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 86B53194B05;
        Thu, 17 Mar 2022 20:21:10 +0100 (CET)
Date:   Thu, 17 Mar 2022 20:21:06 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lu Wei <luwei32@huawei.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        marijn.suijten@somainline.org,
        angelogioacchino.delregno@somainline.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH,v2] drm/panel: Fix return value check in nt35950_probe()
Message-ID: <YjOKIhGhZ8Rm+SQ+@ravnborg.org>
References: <20220317083707.237039-1-luwei32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317083707.237039-1-luwei32@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:37:07PM +0800, Lu Wei wrote:
> In function nt35950_probe(), mipi_dsi_device_register_full() is called
> to create a MIPI DSI device. If it fails, a pointer encoded with an error
> will be returned, so use IS_ERR() to check the return value. Besides, use
> PTR_ERR to return the actual errno.
> 
> Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
> Signed-off-by: Lu Wei <luwei32@huawei.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
