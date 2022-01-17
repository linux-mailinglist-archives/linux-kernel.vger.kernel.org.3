Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE98D4903F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbiAQIek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbiAQIeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:34:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE586C061574;
        Mon, 17 Jan 2022 00:34:36 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id B4D1B1F4135B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642408475;
        bh=xoK0jv3NtU8ZkFPzIzfvCTtQcjyKWM9goIUF47mzE/o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IqPEoxEtxahmxn6slrmLI5kbao8z63Jjv3ia08ySyB2cwgvYAjuXWtX/zfe6H8SVu
         LVU6yeTfN5PyztamR8/+VsrtSEok9fHjGiQKH/Q4VQD9k+eO3ktHcOimWf9KPHA/tJ
         35gFyCbIUM2qBZgGg0rjph6PN1V7dqTh2/ukELJ8pcrqXjaTITDGaTZZIJyC1NHSGR
         yfOEyKC5i1RUhzJeePiBaWs/vG2NG2RXQ8bmKxDzt+WdoGX/79A3IxpjQmZQXZ0Nga
         ZyFxn3DJ55nAST/jHMH4Woogxhc79M2UKW7WOexmE/UBYqDKp+QqCJ4xTkOihpaKBb
         VmRwclfcTAidQ==
Message-ID: <b5b69eac10039de1b287df90279f464bd70e1de0.camel@collabora.com>
Subject: Re: [PATCH] iio: frequency: admv1013: remove the always true
 condition
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Date:   Mon, 17 Jan 2022 13:34:28 +0500
In-Reply-To: <20220115180941.709a667a@jic23-huawei>
References: <YdS3gJYtECMaDDjA@debian-BULLSEYE-live-builder-AMD64>
         <20220115180941.709a667a@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-01-15 at 18:09 +0000, Jonathan Cameron wrote:
> On Wed, 5 Jan 2022 02:09:20 +0500
> Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> 
> > unsigned int variable is always greater than or equal to zero. Make the
> > if condition simple.
> > 
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Hi,
> 
> + CC Antoniu and this should have a Fixes tag.
> 
> Thanks,
> 
> Jonathan
> 
Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")

Please let me know if I should send a V2 with this tag included.

Thanks,
Usama
> > ---
> >  drivers/iio/frequency/admv1013.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
> > index 6cdeb50143af..3f3c478e9baa 100644
> > --- a/drivers/iio/frequency/admv1013.c
> > +++ b/drivers/iio/frequency/admv1013.c
> > @@ -348,7 +348,7 @@ static int admv1013_update_mixer_vgate(struct admv1013_state *st)
> >  
> > 
> > 
> > 
> >  	vcm = regulator_get_voltage(st->reg);
> >  
> > 
> > 
> > 
> > -	if (vcm >= 0 && vcm < 1800000)
> > +	if (vcm < 1800000)
> >  		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
> >  	else if (vcm > 1800000 && vcm < 2600000)
> >  		mixer_vgate = (2375 * vcm / 1000000 + 125) / 100;
> 


