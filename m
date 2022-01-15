Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB81348F8E6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiAOSxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:53:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50572 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiAOSxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:53:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 911F160EF9;
        Sat, 15 Jan 2022 18:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422ABC36AE5;
        Sat, 15 Jan 2022 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642272830;
        bh=kNMj2XNx6e+EyWPVtoxRGWoy6MV3BxoY4ZrP5yulyUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K8FX4oqFjxEibIsb9+Vvt4db3oM5l/egCOvmKLAfQ70ERYWreybe+Ikclse8eM9wV
         lCRBYBBTo13qYKJ/V5qP4BWcV16/bwHmn1Ay/8HPaujogbuVpeIQU4/xi+1BRQDKi/
         xv5zxd8MEN9OMbxJbjy5EurHna17eOcTxSEEW+cQ+V4WEDf/dlf2FtFyWX+qdF24FQ
         cQyLdD3KkzjbBAk7OGHtQXjCLkbAu8T6U6uaSrj7BR895VYHI0XBUfvXZaTsqLCdma
         BmZM/RZDijsx8+L+xYP24yXql3PqL6efoy5WQ3rcU8IxUmQNIMjBRExUFIQlOco2DS
         Ax+g2zZ3HUKqQ==
Date:   Sat, 15 Jan 2022 18:59:48 +0000
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
Message-ID: <20220115185948.56f227df@jic23-huawei>
In-Reply-To: <CAHp75VeVRwbMhQp-oBYM7yVzL_ma0jRu3ESEjz19zLQDFWyzkA@mail.gmail.com>
References: <20220111074703.3677392-1-cosmin.tanislav@analog.com>
        <20220111074703.3677392-3-cosmin.tanislav@analog.com>
        <CAHp75VeVRwbMhQp-oBYM7yVzL_ma0jRu3ESEjz19zLQDFWyzkA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 11:22:23 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jan 11, 2022 at 9:47 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >
> > The starting bit is always zero, it doesn't make much sense to
> > use for_each_set_bit_from. Replace it with for_each_set_bit
> > which doesn't start from a particular bit.  
> 
> We refer to the function() like this.
> But no need to resend, I hope Jonathan may amend this when applying.
> 

I'll need to wait for rc1 to have the relevant code in my fixes-togreg
branch to pick these up.

They look fine to me and hopefully I'll remember to cleanup the above ;)

Thanks,

Jonathan
