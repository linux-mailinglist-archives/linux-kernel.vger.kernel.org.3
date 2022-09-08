Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4B5B1D48
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiIHMkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiIHMkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:40:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C9BC59D3;
        Thu,  8 Sep 2022 05:40:38 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MNdsT3ZPFz67n8d;
        Thu,  8 Sep 2022 20:36:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:40:36 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 8 Sep
 2022 13:40:36 +0100
Date:   Thu, 8 Sep 2022 13:40:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     <andrea.merello@gmail.com>, <andrea.merello@iit.it>,
        <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <robh+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        <matt.ranostay@konsulko.com>, <ardeleanalex@gmail.com>,
        <jacopo@jmondi.org>
Subject: Re: [v7 00/14] Add support for Bosch BNO055 IMU
Message-ID: <20220908134035.000027ca@huawei.com>
In-Reply-To: <dda8346f-2cfb-4d85-607c-553625cc98d4@gmail.com>
References: <20220907132205.28021-1-andrea.merello@iit.it>
        <1b30d814-3570-1cb7-573b-9bca90d5d3fd@gmail.com>
        <CAN8YU5P1qjKtmSskA_+vLMnC6wHFmhk4ZvP+a-9KLr0OsY0FdA@mail.gmail.com>
        <dda8346f-2cfb-4d85-607c-553625cc98d4@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 14:32:49 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On 9/8/22 13:51, Andrea Merello wrote:
> >> Rebased on what tree (and what commit)? I can't cleanly apply patch
> >> [05/14].  
> > 
> > Sorry, it looks like I've raced against recent updates on iio-togreg
> > branch (i.e. I've rebased, then I've got preemped by something else,
> > then I've tested and sent the series some days later - I should have
> > rebased again).
> > 
> > BTW patches can be applied on the top of this
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=2bc9cd66eb25d0fefbb081421d6586495e25840e
> > 
> > I'll prepare a v8 anyway.
For minor stuff like Doc updates, don't about rebase if everything else
is fine. I can fix little merge conflicts whilst applying.

Thanks,

Jonathan

> >   
> 
> OK.
> 
> Don't forget to pass --base to git-format-patch(1) when preparing v8.
> 

