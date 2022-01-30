Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0509A4A36A2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354980AbiA3OTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354964AbiA3OTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:19:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B81C061714;
        Sun, 30 Jan 2022 06:19:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C03F611CC;
        Sun, 30 Jan 2022 14:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7F0C340E4;
        Sun, 30 Jan 2022 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643552375;
        bh=FXqdfvlHdxXHs0sfXOkYGblZu370Bn3tuKiBuBJhrvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K5zafbIJOAiS5oaIZlg6JzyAH9thIIPX5vEez4qWoI3RMVTtkqcybHAgcReojW/U/
         qRgYr8MH9RVeJ1gHuVIACZl0nfFVfOS9E4NbDN/41Rvff8fTgWGiSNaKhRiTrHcqh/
         7qigUnziJe0kDNu/fmVARZ7TZjH9pZkr7cZj3NYcPRf7ZkDcDYx+0eWCl1HAkmwwDt
         ZrcXRbIDML5IjEOfL4SYcsxQDRThAEwVSyUE83pxdOy+y/BTi1+LriYSBlFiwN/YaQ
         8b/hIxAD5qY4an4Y5NmWs7S1Am4gVEcxGmcbQdPjznMujrmF11uhmdMkcW9nhVl91l
         jN1gR3sZbFgNQ==
Date:   Sun, 30 Jan 2022 14:25:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iio: addac: ad74413r: for_each_set_bit_from ->
 for_each_set_bit
Message-ID: <20220130142558.7601722c@jic23-huawei>
In-Reply-To: <20220115185948.56f227df@jic23-huawei>
References: <20220111074703.3677392-1-cosmin.tanislav@analog.com>
        <20220111074703.3677392-3-cosmin.tanislav@analog.com>
        <CAHp75VeVRwbMhQp-oBYM7yVzL_ma0jRu3ESEjz19zLQDFWyzkA@mail.gmail.com>
        <20220115185948.56f227df@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 18:59:48 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 11 Jan 2022 11:22:23 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Tue, Jan 11, 2022 at 9:47 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:  
> > >
> > > The starting bit is always zero, it doesn't make much sense to
> > > use for_each_set_bit_from. Replace it with for_each_set_bit
> > > which doesn't start from a particular bit.    
> > 
> > We refer to the function() like this.
> > But no need to resend, I hope Jonathan may amend this when applying.
> >   
> 
> I'll need to wait for rc1 to have the relevant code in my fixes-togreg
> branch to pick these up.
> 
> They look fine to me and hopefully I'll remember to cleanup the above ;)
> 
First 2 applied to the fixes-togreg branch of iio.git.

This 3rd one isn't a fix so will have to wait for those to end up in
my togreg branch.  Give me a shout if I seem to have lost this once that
is true.

Thanks,

Jonathan

> Thanks,
> 
> Jonathan

