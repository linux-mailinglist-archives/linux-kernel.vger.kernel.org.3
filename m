Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17287555149
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357922AbiFVQZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241588AbiFVQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:25:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DD127CE5;
        Wed, 22 Jun 2022 09:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 96605CE21C5;
        Wed, 22 Jun 2022 16:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B84EC34114;
        Wed, 22 Jun 2022 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655915132;
        bh=wr8H/XPR1kOwD16IrHY0mrY7tliBGunYubB7Rn8wDao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TN4QoDLGAx9uMTaxQ2uFd+UxxVRHlChnFWLc9tsubNyhtv5w9jlHShFr4TdWdbKZT
         DZqw68xKfmFxTvUR74TI8TZawFBBCv2oC0hshj9Z6F9g1ws/SRaH4CpuqJbAvz1rZa
         co6vNjgwVCGcPsweyvJF4vaoweIydbbDiY0EWDGHBQppkIC04DF0nTb/n972D6xZZO
         R8MryKpn7U49K1jtpM3IU6Q2tod+m4xzlCW/vCpI2fRrsOD/3fiRggZBJ2tIaphREu
         5plW3En8TyUUSNjAAMhgqQPKm8DsO/hrgPM1t4CZ82qqZIVcdAaR1mVc38dMymfqa8
         EUZVUo4P9UP/g==
Date:   Wed, 22 Jun 2022 21:55:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     quic_hemantk@quicinc.com, gregkh@linuxfoundation.org,
        loic.poulain@linaro.org, dnlplm@gmail.com, bbhatt@codeaurora.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: host: pci_generic: Add Cinterion MV31-W
 with new baseline
Message-ID: <20220622162519.GD6263@thinkpad>
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

Applied to mhi-next!

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
