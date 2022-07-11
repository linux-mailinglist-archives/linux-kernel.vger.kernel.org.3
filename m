Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A6A570005
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiGKLSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiGKLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:18:19 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C796D2725
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:40:51 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F0CE983FDE;
        Mon, 11 Jul 2022 12:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1657536049;
        bh=Y3VSNfDo1U4WELqZYyRvbjK9Z7Pojdt8Qu8UkXieSGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J9nFsjZlyIT4XLSdiWM/wHQj8KGLlUk+kKQ4ub3CvZ5AjbnECl0zQKxq/PlYGvlBe
         IpNXRvwK5Mj0ihZBCdQ9V2WLl2pLOIJb/hckdKbMSAd2gWCgen2mKGnWFpHeJCHtIQ
         QqxKur9DlC2JKzQpCDrBKRdwhtNcrdOh5nCxyGxkLFLQa6BDU0OHs0+3lOWnubdrPE
         Q35yaxvM7W0H4VyPFshJfEY82IscZDQYvACAncr4bAb7NNlF/5QB1a0+99Pj6MDU0W
         IfE8DyuaqTmqjBULRFsqIToqyx1CYlT00qbqHYAV5TvBgrHNJfNGDPbx9DmZziqM/6
         pNitLQwDXQt9g==
Message-ID: <3b4a1bec-24aa-da62-79ba-8438987299b3@denx.de>
Date:   Mon, 11 Jul 2022 12:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] drm: mxsfb: DRM_MXSFB should depend on ARCH_MXS ||
 ARCH_MXC
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <379f49058c7455802302c42bfbf615aaf3400f2c.1657530040.git.geert+renesas@glider.be>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <379f49058c7455802302c42bfbf615aaf3400f2c.1657530040.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 11:01, Geert Uytterhoeven wrote:
> Freescale/NXP i.MX LCDIF and eLCDIF LCD controllers are only present on
> Freescale/NXP i.MX SoCs.  Hence add a dependency on ARCH_MXS ||
> ARCH_MXC, to prevent asking the user about this driver when configuring
> a kernel without Freescale/NXP i.MX support.
> 
> Fixes: 45d59d704080cc0c ("drm: Add new driver for MXSFB controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Is the Fixes tag really justified in this case ?

Otherwise

Reviewed-by: Marek Vasut <marex@denx.de>
