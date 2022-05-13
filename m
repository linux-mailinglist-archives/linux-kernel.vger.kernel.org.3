Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A21525E55
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378478AbiEMIni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378459AbiEMInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:43:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B2527E3FA;
        Fri, 13 May 2022 01:43:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2E34B82CCE;
        Fri, 13 May 2022 08:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F7BC34100;
        Fri, 13 May 2022 08:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652431398;
        bh=m5hEaD38XvulXp5Ft+b02q9wrVDs2Em7z/q4wkUKtpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRNx3Y0EjpZrvDM+AsJLl6aiU3C+X691nsy6rTtMSMBhGgexBErRwzlwLZdu2RKou
         3NxUIEDrKo4ZUAR/6H8FaimK8VhDJnQzK5zozxBO6W2EJMRtRRbiW5JfQU919ABOQf
         TZQzJnF3gmgBQWg1+n8kCvG7Bsfx7rNCcEnp58NZkgR39KugEpr5k+n7vTr7KEYFPM
         CF0/goyMY7Q8QqRrEMuMc/EGh0kSO9rEvhwHjKWkJA3qzs4AOcCEQrDrlxNREaivQy
         IQzOLKyNcr2BFfe78F1SPon0zHokGmZEqQ7KBQJfvp96kcZitR7he2Ppq+EhuEmaXT
         c0/jE6AI/j2mw==
Date:   Fri, 13 May 2022 14:13:11 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     mani@kernel.org, quic_hemantk@quicinc.com,
        gregkh@linuxfoundation.org, loic.poulain@linaro.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]     bus: mhi: host: Add support for Quectel EM120 FCCL
 project.
Message-ID: <20220513084311.GA7659@thinkpad>
References: <MEYP282MB23742A3646D681AF27BED85EFDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MEYP282MB23742A3646D681AF27BED85EFDCA9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 03:00:25PM +0800, Yonglin Tan wrote:
> From: ylintan <yonglin.tan@outlook.com>
> 
>     This patch add VendorID/DeviceID definitions for EM120 FCCL project.
>     It has the same configration as Quectel EM160R-GL and EM120R-GL.
> 
>     Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
>     Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>     Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>

On top of what Greg said, you don't need to CC Greg for MHI patches. I will
review and apply the patches to MHI tree and submit a cumulative PR to Greg.

Let's give some air to him ;)

Thanks,
Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 8416267..0a6469c 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -557,6 +557,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>  	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> +	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> +		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>  	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
