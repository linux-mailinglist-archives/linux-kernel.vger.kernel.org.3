Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3247A949
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhLTMOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhLTMOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:14:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2014EC061574;
        Mon, 20 Dec 2021 04:14:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B144960F47;
        Mon, 20 Dec 2021 12:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F4BC36AE7;
        Mon, 20 Dec 2021 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640002479;
        bh=5UkfDTwp4WqfU+BpkynEqDwHwN6hjn/WV7GvjtLIvY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNHLyqNYkL9CUrDhjORK7hbtSZ2xqrqL9SZUcYPNssBqgzdIHkKoA+RvINAq+itkl
         FN4SfdY4C9+da7f8cEkndSWXZD6wfLj/DpPy6iemELBRRDygMPH1oIoDNh9mIJQ6Tp
         DWiA9i7la3HaNnLs/HooDfW6QdQEg1hQlwCNqxz4=
Date:   Mon, 20 Dec 2021 13:14:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, agross@kernel.org,
        bjorn.andersson@linaro.org, balbi@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: qcom: Check for null irq pointer
Message-ID: <YcBzrN2Y7++Iephs@kroah.com>
References: <20211220101520.930658-1-jiasheng@iscas.ac.cn>
 <d7974f16-74b1-4d8a-2c28-8acb710d6310@omp.ru>
 <4dcc204a-ba68-ebb8-021d-fd4b54be2729@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dcc204a-ba68-ebb8-021d-fd4b54be2729@omp.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 02:48:12PM +0300, Sergey Shtylyov wrote:
> On 20.12.2021 14:25, Sergey Shtylyov wrote:
> 
> > > The return value of platform_get_irq() needs to be checked.
> > > To avoid use of null pointer
> > 
> >    What null pointer, could you please clarify?
> > 
> > > in case that there is no irq.
> > > 
> > > Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
> > > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> 
>    This has already been addressed by this (yet unmerged) patch:
> 
> https://marc.info/?l=linux-usb&m=162854066430255

Why not wait until that patch is actually merged?  Otherwise all of this
work is moot.

greg k-h
