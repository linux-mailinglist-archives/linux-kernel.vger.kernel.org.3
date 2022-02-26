Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA654C5463
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 08:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiBZH1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 02:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiBZH1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 02:27:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B607C28E20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 23:26:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DBE060E9C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689B7C340E8;
        Sat, 26 Feb 2022 07:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645860406;
        bh=xsIIxtqrLCpjMVzNtUoZ5eMada8c+j8JoG2CvIgeeMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZnKcxT+M+g/P+XPOrqHbOAer3vapA9Ky2QbuBhRqo12L5AYbOAO6p7EH82/ado3H
         W7bKWh2HWK8M/KpSWTYSIMGR2ttxUSlleuCly5777+nj5CrobP/IAMcD/JCGQzdR5j
         efX1o5EUDaG53/zTcEBj7NRrEC77RCF9qx9kz2IM=
Date:   Sat, 26 Feb 2022 08:26:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, javier@javigon.com,
        arnd@arndb.de, will@kernel.org, axboe@kernel.dk,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v2] drivers: ddcci: upstream DDCCI driver
Message-ID: <YhnWMbYyOhKIRxa3@kroah.com>
References: <20220226040429.1035368-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226040429.1035368-1-yusisamerican@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:04:29PM -0800, Yusuf Khan wrote:
> --- /dev/null
> +++ b/drivers/ddcci/Kconfig
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig DDCCI
> +	tristate "DDCCI display protocol support"
> +	help
> +	  Say Y here if you want to have DDCCI

You need to explain what this is, what uses it, and why anyone would
want to enable it.  We have no idea what this driver is supposed to do
:(

