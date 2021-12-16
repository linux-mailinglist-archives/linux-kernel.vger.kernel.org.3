Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B54775E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbhLPP01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhLPP01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:26:27 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CD3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:26:26 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id p65so35717287iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=67Vem47B3H5J53wS2N0qozARJFT1k4nkQO4G+jjqa7I=;
        b=GObEAzKftb43qpUL73PButovyPOh9C5lB41PdNrBN/OTPkAwQ6lk/xd+y2ZzJNK0tI
         iTj8rJlzlSOCC3VAZoIRa4dSS5DQOFhyIjwPeC8s5D2q1HIaIfUjdNTXuKnV4aft4+JR
         GjiRSCau5rxjLrGdzjJTgvqpvNpV4IWnWzfoGhzp3Ycs5W8AY6zyxpNFnCS/h8bc9lw+
         Ystm9naMQLwsCaIfQ0/WLgmXlaukLswdc5aP7a+S0QBo+T13YT+dIeFnPrE8FhEKUghI
         6Hlt0nKKwvLiA9/H3wGhFlWgQW2VdsB/p8oRd9/egzsggwzVLFd+TwkYxg81hbnvZ/rp
         ZUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=67Vem47B3H5J53wS2N0qozARJFT1k4nkQO4G+jjqa7I=;
        b=Ht0SfzgFTooWC8r9GNFyju83y3IgKQ7LeNoqstB4N47duPpX5pVoBRHgJYLk4DTtRL
         s7xSAv/t9wynBVTPysk3kfGxz3CaIrq6pLfBMW2rKsTXs/GYZKk850HInwnKOe8wtpIT
         tKE/9Vo2Ct9dXSHx9i9uyTjZbh4Lhz+7n8hp6Mk6tk+chD2p43et+WY++0OHDBKc7/HI
         djimmSe4Dpze5hZG9QFsj/FuFCJJF8cSm7BiD4VSm33oW6MLtt3ervekqAXuVwuwJZyM
         ukdWb4bfTbrdDOr1GK74vjOHwg40Xfux0JUoodNw7KeMTdn5bg1KGcYYj9b4aA8JzjQM
         PKGw==
X-Gm-Message-State: AOAM530t/HXqyiM4vvD0zJ3/c0+QTSlfRKT6UUpAXYEGuL/6HYuKmqQo
        EbWWNzDr2CbswVa6EMJyyDTq
X-Google-Smtp-Source: ABdhPJx2k0X5637koIrqrnqkX80APdsdYn245W/07/3XnqocWSxif/WrCZxIL+OW6N1iLXxJ2kSZxA==
X-Received: by 2002:a05:6638:2183:: with SMTP id s3mr9640953jaj.297.1639668384768;
        Thu, 16 Dec 2021 07:26:24 -0800 (PST)
Received: from bixby.lan (c-73-181-115-211.hsd1.co.comcast.net. [73.181.115.211])
        by smtp.gmail.com with ESMTPSA id d137sm2720024iof.16.2021.12.16.07.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:26:23 -0800 (PST)
Message-ID: <938a54814087ca8c4b4011c2f418e773baf2b228.camel@egauge.net>
Subject: Re: [PATCH v5 1/2] wilc1000: Add reset/enable GPIO support to SPI
 driver
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Claudiu.Beznea@microchip.com, Ajay.Kathat@microchip.com,
        adham.abozaeid@microchip.com, davem@davemloft.net,
        devicetree@vger.kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, robh+dt@kernel.org
Date:   Thu, 16 Dec 2021 08:26:22 -0700
In-Reply-To: <87zgp1c6lz.fsf@codeaurora.org>
References: <20211215030501.3779911-1-davidm@egauge.net>
         <20211215030501.3779911-2-davidm@egauge.net>
         <d55a2558-b05d-5995-b0f0-f234cb3b50aa@microchip.com>
         <9cfbcc99f8a70ba2c03a9ad99f273f12e237e09f.camel@egauge.net>
         <87zgp1c6lz.fsf@codeaurora.org>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-16 at 10:10 +0200, Kalle Valo wrote:
> David Mosberger-Tang <davidm@egauge.net> writes:
> 
> > > > +       } else {
> > > > +               gpiod_set_value(gpios->reset, 1);       /* assert RESET */
> > > > +               gpiod_set_value(gpios->enable, 0);      /* deassert ENABLE */
> > > 
> > > I don't usually see comments near the code line in kernel. Maybe move them
> > > before the actual code line or remove them at all as the code is impler enough?
> > 
> > You're kidding, right?
> 
> I agree with Claudiu, the comments are not really providing more
> information from what can be seen from the code. And the style of having
> the comment in the same line is not commonly used in upstream.

The code is obvious if you think of 1 as "assert" and 0 as "deassert".  It looks
utterly wrong if you think of 1 as outputting 3.3V and 0 as outputting 0V.

But if you insist, I'll remove the comments.

  --david


