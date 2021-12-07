Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D01246B88F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhLGKRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhLGKRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:17:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17283C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 02:14:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEE27B81741
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 10:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172AFC341C6;
        Tue,  7 Dec 2021 10:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638872048;
        bh=Z8xush+cX8bTg2aCb5eefwuAA4McOR4w4Faqf8Lgiig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nif0DAAJw/awo+c5HYkVrfiwK9YLJarN10nfQ2IePFO4B8njicClTVoYtUKhrxCah
         M0KCrba5Dok0oQDdaRXtvJUoxkX4y2uqx+hzZBsjreHnSagFftm/3VkNUeN0KLTUZc
         t4NCxbY7o1my1XiJwoYSgdKHbi1HmURpX1FCG2UA=
Date:   Tue, 7 Dec 2021 11:14:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: convert type of HalData in struct
 adapter
Message-ID: <Ya8z7q+ufy30MaOw@kroah.com>
References: <20211206092258.3765-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206092258.3765-1-straube.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:22:58AM +0100, Michael Straube wrote:
> adapter->HalData is used in the GET_HAL_DATA macro all across the
> driver code but nobody checks if its allocation in
> rtl188eu_alloc_haldata() was successful or not.
> 
> To avoid errors when the allocation fails convert the type of field
> HalData from void pointer to struct hal_data_8188eu. Remove
> GET_HAL_DATA, rtl8188eu_alloc_haldata(), rtl8188e_free_hal_data().
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> Tested on x86_64 with InterTech DMG-02.

This doesn't apply to my tree anymore, due to the other changes that
were submitted for this driver.  Can you rebase and resend please?

thanks,

greg k-h
