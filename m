Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75037553270
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350547AbiFUMqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbiFUMqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:46:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895FA12ACF;
        Tue, 21 Jun 2022 05:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D69C6144D;
        Tue, 21 Jun 2022 12:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B66C3411D;
        Tue, 21 Jun 2022 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655815597;
        bh=/lJf1g6k/vLlYyh34H6cKOQDaBIETGFyt/Fw9AGyS8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxKixXtz2oKY9+H1+w1iZ4YVxk07FG8wnR1oEGHhNg0aYKv573urCmtVPnYilqOPq
         tRx+0RuJykPGgGWsDIrBJggd3BfCjb6Zsuo7D64qKC/ZD2kEjwM5FAuPaOPc+oQHFx
         9XIV39rI7wQSRlVhhomKct+53id9oZ4UIbke2vxkQyRYHNewBBnSo9vYmsXk9Qo+gM
         brv5gWxxMzb0o7XKV8rrEhMuwHZ7ARgA61HSf9dw4CFNR6Jm2TZiwjJPrmOQv/WD/3
         ub8oJ5RAmQ0sj6nFMuxDy3C6iM8NukqetVUt/okXMqZId5DjMHOGz7EYz8omkMNHpP
         Nz5I/vgUrip2g==
Date:   Tue, 21 Jun 2022 18:16:24 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     loic.poulain@linaro.org, gregkh@linuxfoundation.org,
        quic_hemantk@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v2] bus: mhi: host: Add support for Quectel EM120 FCCL.
Message-ID: <20220621124624.GA17181@thinkpad>
References: <MEYP282MB2374837FFCB18B12BFDEDE80FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MEYP282MB2374837FFCB18B12BFDEDE80FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:38:29PM +0800, Yonglin Tan wrote:
> The product's enumeration align with previous 
> Quectel EM120R-GL, so the EM120 FCCL would use 
> the same config as Quectel EM120R-GL. 
> 
> Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
> 
> V2:
> Fixed the format errors in the patch description.
> 
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

-- 
மணிவண்ணன் சதாசிவம்
