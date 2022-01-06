Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1130B486602
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbiAFO05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbiAFO04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:26:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA7C061245;
        Thu,  6 Jan 2022 06:26:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A6CA61CB4;
        Thu,  6 Jan 2022 14:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C66C36AE3;
        Thu,  6 Jan 2022 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641479215;
        bh=78/vdvKcVGZ25jU0FPtGZ8k+wbBGo8m7h4ytePO5ckU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2r9RHDq5gRf6cr3P9XhVMk0gJLxRvZn3pQLeFAI1grMvbH7DAfII3U7hB/JcUu1D
         sP1p+4IsItyg22vBiSpakvOpf9MMxtnN63q+38KxgWs1QmLNr4ns2QdpGfo4YCou9d
         zEN8f7DeTLAo6iiYQ6lk0D9qcMslTXpBmAFnxRto=
Date:   Thu, 6 Jan 2022 15:26:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     vladimir.zapolskiy@linaro.org, agross@kernel.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: dwc3-qcom: Add missing
 platform_device_put() in dwc3_qcom_acpi_register_core
Message-ID: <Ydb8LIgZ/xGZ/lYX@kroah.com>
References: <83d55401-d8b3-f709-c77a-fa0e09fda27f@linaro.org>
 <20220105065517.6967-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105065517.6967-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:55:17AM +0000, Miaoqian Lin wrote:
> Fix the missing platform_device_put() before return from
> dwc3_qcom_acpi_register_core in the error handling case.
> 
> Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Changes in v2:
> - add fixes tag.
> - do error handling in a unified way.
> - add necessary blank line.
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)


Does not apply to my tree at all :(

Please rebase and resend.

thanks,

greg k-h
