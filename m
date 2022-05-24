Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA4532B86
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbiEXNog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiEXNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F8A9549D;
        Tue, 24 May 2022 06:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E09F61605;
        Tue, 24 May 2022 13:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3846C385AA;
        Tue, 24 May 2022 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653399865;
        bh=6tzj2bQqziY/R4MbzyX8Q5MPCotBU7hx6/IHvu6e0Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mV1IjR+iyqSgo8y7KGs2vyJNaPo+/6PQlc0uU9kQsGFNzfhxTc8QpTIkEmodH7dmH
         Fy0FEJ6e2bfbka70QNqu9w2BhBZWgtFSJYguXFQuEv9MmZ1wbNE28WQf+2A0NHi1Fk
         0MN0qOyQWL8GNp7MjIGo7tPyiz1eF/swdAp6tE2zIE75KmU1yYFWd41zHQXleA5iyM
         se99C2dczn6CodqYhRyXH3whpOwnGbSxTS5usMktPJOsY+UlKlGSCPVEYTk0f9v1fy
         T1DRdGans1uM4jDFyC2GvUPlcAiU0HhvwFSZOOXwbIfXHUCU9VPSn/qZdxq3KSOuHS
         Mo7sIBC93LzXg==
Date:   Tue, 24 May 2022 19:14:18 +0530
From:   "mani@kernel.org" <mani@kernel.org>
To:     =?utf-8?B?6LCtIOawuOaelw==?= <yonglin.tan@outlook.com>
Cc:     "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_hemantk@quicinc.com" <quic_hemantk@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhi@lists.linux.dev" <mhi@lists.linux.dev>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v2] bus: mhi:
 host: Add support for Quectel EM120 FCCL.
Message-ID: <20220524134418.GB5745@thinkpad>
References: <MEYP282MB2374837FFCB18B12BFDEDE80FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <MEYP282MB23746F19B1CF42D811D43AFCFDD49@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MEYP282MB23746F19B1CF42D811D43AFCFDD49@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 02:14:15AM +0000, 谭 永林 wrote:
> Hi Mani,
> 
> Do you have any concern about this patch? 

Merge window for 5.19 is open now. I'll start picking up patches once it
closes (approx. 2 weeks).

Thanks for the patience!

Thanks,
Mani

> 
> -----邮件原件-----
> 发件人: Yonglin Tan <yonglin.tan@outlook.com> 
> 发送时间: 2022年5月16日 14:38
> 收件人: mani@kernel.org; loic.poulain@linaro.org; gregkh@linuxfoundation.org; quic_hemantk@quicinc.com
> 抄送: linux-arm-msm@vger.kernel.org; linux-kernel@vger.kernel.org; mhi@lists.linux.dev; Yonglin Tan <yonglin.tan@outlook.com>
> 主题: [PATCH v2] bus: mhi: host: Add support for Quectel EM120 FCCL.
> 
> The product's enumeration align with previous 
> Quectel EM120R-GL, so the EM120 FCCL would use 
> the same config as Quectel EM120R-GL. 
> 
> Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
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
