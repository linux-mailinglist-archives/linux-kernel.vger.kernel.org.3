Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580785548B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbiFVIOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiFVIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE26837AAF;
        Wed, 22 Jun 2022 01:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4981C617CF;
        Wed, 22 Jun 2022 08:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C0CC34114;
        Wed, 22 Jun 2022 08:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655885654;
        bh=H/Z/L8MiVmpkhuhNiZ0YLz7K84HAGPmdn7jyCa4MN9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqcmkzqIgiPhDuCL3zs7tDTdyNhdcSW7JZxHf6IhQLOSjKp7meg0v7Z72fPP/OiGn
         tQP3yW3HoD3vSE3x8Ieuo/O2JJJj62iRITfSm2fVE2ySUUGb3xBsbHk8dWOutDYLUD
         +vcDU8dw/mXuzHKcw15ZcNrPN867vnR9giTeHR301feC4arHge9ZYppJVSWPQmCM1x
         2/o45zw2zLszpOcxSi31lk2dv4VvXRNt35c/lYfqMoOIHqPuPwyGrjx+8ucBBP4XfD
         Rwxx1ol6qnf07b/1vo9W2ijeWrtkHx1h6QBh19ISSqWbv+l9x3OMMJjFxpwwmRuBHp
         pwF/N/wv5n2jw==
Date:   Wed, 22 Jun 2022 13:44:03 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     quic_hemantk@quicinc.com, gregkh@linuxfoundation.org,
        loic.poulain@linaro.org, dnlplm@gmail.com, bbhatt@codeaurora.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: host: pci_generic: Add Cinterion MV31-W
 with new baseline
Message-ID: <20220622081403.GA6263@thinkpad>
References: <20220622032544.17713-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220622032544.17713-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:25:44AM +0800, Slark Xiao wrote:
> Cinterion MV31-W modem with a new baseline (firmware) is sold as a separate
> product with different device ID. So add support for the same reusing the
> config.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 841626727f6b..062662b3778b 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -578,6 +578,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* MV31-W (Cinterion) */
>  	{ PCI_DEVICE(0x1269, 0x00b3),
>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> +	/* MV31-W (Cinterion), based on new baseline */
> +	{ PCI_DEVICE(0x1269, 0x00b4),
> +		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
>  	/* MV32-WA (Cinterion) */
>  	{ PCI_DEVICE(0x1269, 0x00ba),
>  		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
