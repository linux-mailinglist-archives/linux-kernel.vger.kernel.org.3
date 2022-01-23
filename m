Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BBD497252
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiAWPBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiAWPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:01:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFDC06173D;
        Sun, 23 Jan 2022 07:01:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A45EA60E2C;
        Sun, 23 Jan 2022 15:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604EEC340E4;
        Sun, 23 Jan 2022 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642950104;
        bh=+09ouqzathO+JbmwWmDWWRrVGVWvxpyzzOynvE0HHfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5Etl1Y6sxf+WRL0A8P/JqlYexRgF21vNGeFsHdKrXnYxGm6gvxRoBAfzWthoKJlo
         5vIp22vuJhBOwVPLXEGt9XI75RLAGUZ8wFrL0iSU8IPf4uuBnbnrIZoOvs09J2q/g4
         V+xEB/e5kG5sUb0Xm6F1sZW2pyeGJqydpRkRN3r8SFRSDh5n9QpSaYXGSGy7XyD8zd
         lWpyEsxkTCnuhN6h/BzmyNFGfNufdt+qcypytGfE8SpVSSImal8O/kQWn0m24hQupk
         vG2HuTXao5anJSzhwAQrNLT2b8sTVFwi2XVmvaRTPZPhuBWSlFSza3JjcNdwwy1B7W
         hEkADpqv5iUqA==
Date:   Sun, 23 Jan 2022 20:31:36 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     hemantk@codeaurora.org, jarvis.w.jiang@gmail.com,
        loic.poulain@linaro.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] bus: mhi: Add mru_default for Foxconn SDX55
Message-ID: <20220123150136.GA11636@thinkpad>
References: <20220119101213.5008-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119101213.5008-1-slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:12:13PM +0800, Slark Xiao wrote:
> For default mechanism, product would use default MRU 3500 if
> they didn't define it. But for Foxconn SDX55, there is a known
> issue which MRU 3500 would lead to data connection lost.
> So we align it with Qualcomm default MRU settings.
> 
> Fixes: aac426562f56 ("bus: mhi: pci_generic: Introduce Foxconn T99W175 support")
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Applied to mhi-next!

Thanks,
Mani

> ---
>  drivers/bus/mhi/pci_generic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
> index 3a258a677df8..74e8fc342cfd 100644
> --- a/drivers/bus/mhi/pci_generic.c
> +++ b/drivers/bus/mhi/pci_generic.c
> @@ -366,6 +366,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> +	.mru_default = 32768,
>  	.sideband_wake = false,
>  };
>  
> -- 
> 2.25.1
> 
