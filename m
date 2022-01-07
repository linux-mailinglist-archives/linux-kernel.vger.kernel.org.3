Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8981148746E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346329AbiAGJFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:05:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53500 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbiAGJFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:05:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1973B80B29;
        Fri,  7 Jan 2022 09:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD694C36AE9;
        Fri,  7 Jan 2022 09:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641546302;
        bh=xTq42ywxf/zC38gO2EAc6K6Hy163Ci7B/HsTe1JVSbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPmRtmZPWrVVfmNvmMeUDSxbr5n9h1iqdcDipYH8mJirrJj0xIet8IDE7YrG8qgey
         6kVcsLI1gzqL4wm8iJK2wkCBKRyU3SSzcVBSlEes6fzsESHiRTsYFEvFrCjszaUv0T
         qzSpqVWmegkC6eYFtWVmyd+zlRmbD3BTMa8X2foM=
Date:   Fri, 7 Jan 2022 10:04:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     vladimir.zapolskiy@linaro.org, agross@kernel.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: dwc3-qcom: Add missing
 platform_device_put() in dwc3_qcom_acpi_register_core
Message-ID: <YdgCOpYZWEV2SA80@kroah.com>
References: <83d55401-d8b3-f709-c77a-fa0e09fda27f@linaro.org>
 <20220105065517.6967-1-linmq006@gmail.com>
 <Ydb8LIgZ/xGZ/lYX@kroah.com>
 <20220107030719.GA1972@VICKYMQLIN-NB1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107030719.GA1972@VICKYMQLIN-NB1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 11:07:19AM +0800, Miaoqian Lin wrote:
> Hi greg k-h:
> > > Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
> > > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > > ---
> > > Changes in v2:
> > > - add fixes tag.
> > > - do error handling in a unified way.
> > > - add necessary blank line.
> > > ---
> > >  drivers/usb/dwc3/dwc3-qcom.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > 
> > Does not apply to my tree at all :(
> > 
> > Please rebase and resend.
> 
> I see the v1 of this patch has been applied to usb-next branch.
> v2 has some format fixes. I am unsure should I rebase v2 on the top of usb-next?
> I am afraid to introduce more inconvenience.

If v1 was incorrect, please submit a patch to either fix it, or revert
it entirely.

thanks,

greg k-h
