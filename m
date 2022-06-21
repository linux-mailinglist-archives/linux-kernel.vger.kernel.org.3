Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96FD5532E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349196AbiFUND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiFUND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:03:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B289923144;
        Tue, 21 Jun 2022 06:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76E95B817BD;
        Tue, 21 Jun 2022 13:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7273AC3411C;
        Tue, 21 Jun 2022 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655816633;
        bh=yU2FDDGFDTea3DLAGG9Ffx4cVTtY6ouJpsUwcAUdLBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcwNaJlI15fyhDQpRsTQynt7W0m6i+/menTIQ1NF3Tchqta8YYmljYFLC6ODWIbQX
         zs17IJ+Xzgfh6Uqq400Lzf3w/4QxBeNXAunbfkiPcYgK5tQpwAHNIcpWD+SBIHXtGg
         SgxziGLx/O+6kKwKJoq/SuBw7TK5/IRCGkoKfKrhxAjpQjOW8toEzZ28EZxPhiKOtj
         THTqItaLfd1T/QGnmUbKuLkhyNSeY/0sO0qyMbmuoy3iLPnPeW6rN79LDFZuCyn5kB
         4h3yRq5pLh29vH7ZLNOkAlrn8f34OHezrDPg6oF0oRrWM3UUMs05o0tufhOpU8VVKe
         3RnhNmDFID44w==
Date:   Tue, 21 Jun 2022 18:33:42 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     loic.poulain@linaro.org, gregkh@linuxfoundation.org,
        quic_hemantk@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v2] bus: mhi: host: Add support for Quectel EM120 FCCL.
Message-ID: <20220621130342.GC17181@thinkpad>
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

Applied to mhi-next!

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
