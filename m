Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3155DBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245578AbiF1G2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245171AbiF1G2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:28:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E73237D5;
        Mon, 27 Jun 2022 23:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F1E761851;
        Tue, 28 Jun 2022 06:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD2FC3411D;
        Tue, 28 Jun 2022 06:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656397718;
        bh=Vy0GziIPpq894+tq94uKIFEgfuZdympsxpYcHvbf2g0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dM3rWCMgqh8lBMYBzMUbuCxkpq03n+8sEhax4f8bTC/XeT1Fvz5ZC4cvMdjv3uSoT
         Fnuh30WhgwF0PZY6rmhxheLnzXqPEPar7jzrkR2GrbCfSZx53c7wxqoqbHNSHNxIP7
         Mmz5WqNskMGUM07KprfUB0Yr+GnI8MeL2YMdy2yiw/Scob4A0UVYkw58gCq31+YdiP
         SqWRhVfTYxNdYkrKrwRPgqealHIWaa7UivoNDGOe+bQIv8y7GuUBRt1KOfgCRWUYwH
         VkimCDDBJs6c/+iMEhKEmE/gZUxp63uqbig26Ejf+CS464VyKipC4pVNz95rhqXT/0
         nFImOWjM3N1mw==
Date:   Tue, 28 Jun 2022 11:58:32 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Hemant Kumar <quic_hemantk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@linaro.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Add another Foxconn T99W175
Message-ID: <20220628062832.GA23601@thinkpad>
References: <20220627170717.2252335-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220627170717.2252335-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:07:17AM -0700, Bjorn Andersson wrote:
> The Foxconn e0c3 device identifies itself as a T99W175 X55, add support
> for this to the pci_generic driver.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 57d5f611a979..bf82d90f9ca9 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -571,6 +571,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* T99W175 (sdx55), Based on Qualcomm new baseline */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0bf),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +	/* T99W175 (sdx55) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0c3),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
>  	/* T99W368 (sdx65) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d8),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
