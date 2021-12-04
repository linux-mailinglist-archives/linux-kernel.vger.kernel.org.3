Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0604686D2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385322AbhLDR54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344904AbhLDR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:57:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C714AC061751;
        Sat,  4 Dec 2021 09:54:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60CCE60ECE;
        Sat,  4 Dec 2021 17:54:29 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 6EC69C341C0;
        Sat,  4 Dec 2021 17:54:25 +0000 (UTC)
Date:   Sat, 4 Dec 2021 17:59:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v6 2/2] drivers:iio:dac: Add AD3552R driver support
Message-ID: <20211204175933.4fa698b7@jic23-huawei>
In-Reply-To: <20211129152254.1645-3-mihail.chindris@analog.com>
References: <20211129152254.1645-1-mihail.chindris@analog.com>
        <20211129152254.1645-3-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 15:22:54 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> The AD3552R-16 is a low drift ultrafast, 16-bit accuracy,
> current output digital-to-analog converter (DAC) designed
> to generate multiple output voltage span ranges.
> The AD3552R-16 operates with a fixed 2.5V reference.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>

Hi Mihail,

I took another quick look and all looks good to me.  So just resend including
the dt list + Rob H and hopefully they will be fine with the binding.

Thanks,

Jonathan
