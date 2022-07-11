Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3F157000A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiGKLSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGKLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:18:19 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FEF2AF6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:40:52 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4B68483E60;
        Mon, 11 Jul 2022 12:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1657536050;
        bh=9zk1bsjnS5hxzBFUrq5GBjTb5jqpnX60mpGnUiXtU48=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IifqAZdmZQPmS0/ISMDYStqN2xo8COBBlltMu/OX8nZaAYvFZ6YWCjYV76sg04St/
         c78UKOroXLh0eECSdRPI0gPTr0FOPfcRB450CboLLeLLHRXvi1WxpHLx0Pphd5ac6d
         2NQn8V2keAze36Qif8KahZPyfk7GZ1pgyVbqQSjbvdPUZSaP0AjyFMRZp731A3Z029
         PbSO9CezR2ZxLIgu7lsB4hXqzJh9awlIgfWF899GCokmlDl7UyJ5TT8npv+KqdMBEQ
         nBep4qx3KpAZGmsO0R4Y4DjvxtOGDBT1KS7VmMxh2p1BobkOBQX3cYqBfE7zYQyzEy
         bwX/mGx5BdQ0A==
Message-ID: <e7c9e1ad-21d2-6a53-0766-a5a947664de4@denx.de>
Date:   Mon, 11 Jul 2022 12:36:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] drm: mxsfb: DRM_IMX_LCDIF should depend on ARCH_MXC
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <379f49058c7455802302c42bfbf615aaf3400f2c.1657530040.git.geert+renesas@glider.be>
 <5689170a22b3e2a76f0989dd3993a2b132ade8b6.1657530040.git.geert+renesas@glider.be>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <5689170a22b3e2a76f0989dd3993a2b132ade8b6.1657530040.git.geert+renesas@glider.be>
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
> The Freescale/NXP i.MX LCDIFv3 LCD controller is only present on
> Freescale/NXP i.MX SoCs.  Hence add a dependency on ARCH_MXC, to prevent
> asking the user about this driver when configuring a kernel without
> Freescale/NXP i.MX support.
> 
> Fixes: 9db35bb349a0ef32 ("drm: lcdif: Add support for i.MX8MP LCDIF variant")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Marek Vasut <marex@denx.de>
