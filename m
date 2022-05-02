Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D804F516F4E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384897AbiEBMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384899AbiEBMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:11:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186E1408C;
        Mon,  2 May 2022 05:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E6A1612D7;
        Mon,  2 May 2022 12:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03CBC385A4;
        Mon,  2 May 2022 12:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651493259;
        bh=sJXieSVRsz56iZSyGii84Vw0Us2jqDW13RO84kCuKOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JoQw5TiAQURkNdHO4MZgVjgAVeTgmVNo5zpOtwQk43ny4Rtw4EBa3WXLDJLjoOkVa
         2GJY+w0UFNh8NdgZxN8FU9j2D2bLIzRl1uyZXhB7rdCF1P5F+40IK7u1Feu7NwK/ke
         PfRqIsgLhM/NiRErKLf0AP9PHQ3D2Kecag+0xXGw=
Date:   Mon, 2 May 2022 14:07:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        jirislaby@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH 1/2] soc: qcom: geni: Disable MMIO tracing
Message-ID: <Ym/JiTlRPPlD+1AP@kroah.com>
References: <1651488314-19382-1-git-send-email-quic_vnivarth@quicinc.com>
 <1651488314-19382-2-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651488314-19382-2-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 04:15:13PM +0530, Vijaya Krishna Nivarthi wrote:
> Register read/write tracing is causing excessive
> logging and filling the rtb buffer and effecting
> performance.
> 
> Disabled MMIO tracing to disable register
> read/write tracing.
> 
> Signed-off-by: Visweswara Tanuku <quic_vtanuku@quicinc.com>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 28a8c0d..40e11c3 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -1,5 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> +/*
> + * Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.

As stated before, I do not think this is a copyrightable change, and
will be glad to discuss that with your corporate lawyers if they insist.

thanks,

greg k-h
