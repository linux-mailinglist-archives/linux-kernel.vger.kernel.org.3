Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0015253DB6F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbiFEMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFEMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 08:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F410720BE9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 05:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5389660F5B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 12:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ECAC385A5;
        Sun,  5 Jun 2022 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654433386;
        bh=qyt9JnXemheP08AsHBbA/zU+SP65oO3v9kYatWQpzGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPuc2fKMtPdkuSGH9RKg6oCteiiqqFLXaNTuXRpro4x+Z2FJUBHFOHjLF35+sB7Gl
         Lm6gfLa/OFNnK6Lpza8NIZjq/QLIlZ7pS1d+LETWA8VtAc1JYgE9+0X95UDQkp2zo1
         3sOVePmT+dTo2TQ+8S724jp7aw9CK70qr896/hX0=
Date:   Sun, 5 Jun 2022 14:49:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] comedi: ni_usb6501: fix transfer-buffer overflows
Message-ID: <YpymZ674wOEZaYmC@kroah.com>
References: <20220605124322.33148-1-ruc_zhangxiaohui@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605124322.33148-1-ruc_zhangxiaohui@163.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 08:43:22PM +0800, Xiaohui Zhang wrote:
> From: xiaohuizhang98 <ruc_zhangxiaohui@163.com>
> 
> We detected a suspected bug with our code clone detection tool.

What tool exactly?

Please read Documentation/process/researcher-guidelines.rst for how to
write a good changelog when you are using automated tools like this.

> 
> Similar to the handling of vmk80xx_alloc_usb_buffers in commit
> a23461c47482("comedi: vmk80xx: fix transfer-buffer overflows"),
> we thought a patch might be needed here as well.
> 
> The driver uses endpoint-sized USB transfer buffers but up until
> recently had no sanity checks on the sizes.
> 
> Signed-off-by: xiaohuizhang98 <ruc_zhangxiaohui@163.com>

I strongly doubt you sign legal documents like "xiaohuizhang98", right?

thanks,

greg k-h
