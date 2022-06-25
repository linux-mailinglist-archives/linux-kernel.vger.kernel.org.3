Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC255A967
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiFYLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiFYLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818EF275FD;
        Sat, 25 Jun 2022 04:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31000B80833;
        Sat, 25 Jun 2022 11:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E23CC3411C;
        Sat, 25 Jun 2022 11:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656156219;
        bh=qBDpm802bzU8sZg03E6rrUKaEZy2P/IPC2ps7uaBNI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qYQ6J5T2nTGBYxfYrTlhStpkh9aMvKOL1brs6IzQPjiEsR4vbKkYassHJC1gMFTkr
         E84TgjHMlKIeixhvUxXKNi/DpKq2F73cm6ojyuyq87q+HosSKL4rVs5bNJ8iG0mhZf
         8d6sRepbQGHwoNmz59rj/G9wdWRsIKRTgR2dDfw9fRbGzGRtMyBQMKm53VXmsvEwpG
         tEpS7emtzM/reOT8uuUdM1o2w97AwN9MQZVlrhJ75mk0ymnqJGOOT8cMg+1f2ZEKr7
         X1fSzylLwE8XrZnArPALixJuV1Hmcjx2J5fvkUqypKjBp4U8KAC8ot42pLQIfn5l9R
         e/oiCnmGb8lwA==
Date:   Sat, 25 Jun 2022 12:33:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] iio: adc: mcp3911: add support for phase
Message-ID: <20220625123306.676a4f49@jic23-huawei>
In-Reply-To: <YrWnzh0cH70rlb+M@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
        <20220623170844.2189814-8-marcus.folkesson@gmail.com>
        <CAHp75Vff8Avpxany=5j3e+4gmAAefJgDVX3riONN-=VLwj1HNQ@mail.gmail.com>
        <YrWnzh0cH70rlb+M@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 14:02:22 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> On Thu, Jun 23, 2022 at 09:07:21PM +0200, Andy Shevchenko wrote:
> > > +               ret = mcp3911_write(adc, MCP3911_REG_PHASE, val,
> > > +                                   2);  
> > 
> > One line.  
> 
> Fixed
Hi Marcus,

Grumpy maintainer moment: If you've accepted feedback don't send yet
more email.  Just have it incorporated in next version + in changes
logs.  It's on a few seconds for people to open each email, but it
adds up over time!

Jonathan

> 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko  
> 
> 
> Thanks,
> Marcus Folkesson

