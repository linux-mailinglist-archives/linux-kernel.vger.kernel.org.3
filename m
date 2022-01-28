Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6849F75F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiA1KgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:36:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4542 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiA1KgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:36:04 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JlYfK20Qjz6892T;
        Fri, 28 Jan 2022 18:31:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 11:36:02 +0100
Received: from localhost (10.47.76.156) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 10:36:01 +0000
Date:   Fri, 28 Jan 2022 10:35:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     jagath jogj <jagathjog1996@gmail.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <andriy.shevchenko@linux.intel.com>, <aardelean@deviqon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: IIO Device Driver for Maxim DS3502 potentiometer
Message-ID: <20220128103554.000028ff@Huawei.com>
In-Reply-To: <CAM+2Eu+G2YK-O4ioYCBTJOs9VV9k5fVfQSii+m3kcyouJRg_vA@mail.gmail.com>
References: <CAM+2Eu+G2YK-O4ioYCBTJOs9VV9k5fVfQSii+m3kcyouJRg_vA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.76.156]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 09:11:28 +0530
jagath jogj <jagathjog1996@gmail.com> wrote:

> Hello,
> 
> I have a Maxim DS3502 potentiometer breakout and I have written an IIO
> driver for learning purposes and tested with Raspberry pi and wanted
> to send patches of the driver for the IIO sub-system.
> 
> Can I send the patches for DS3502 POT for review?
> 
> The setup used to write driver
> Raspberry pi 3b
> DS3502 breakout board
> Raspberry pi latest kernel branch - https://github.com/raspberrypi/linux
> 
> Regards,
> Jagath

Hi Jagath,

Welcome to IIO.

Absolutely on sending the patches for review.
You'll need to rebase them on latest mainline from kernel.org
(pick a tagged version which would currently be 5.17-rc1_

and then follow the documentation for how to submit a patch in
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Feel free to ask if you have any questions about the process.

Looking forwards to seeing your code.

Thanks,

Jonathan
