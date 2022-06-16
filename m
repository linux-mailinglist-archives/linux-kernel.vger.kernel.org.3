Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11954E853
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiFPRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiFPRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:06:17 -0400
Received: from smtpq2.tb.ukmail.iss.as9143.net (smtpq2.tb.ukmail.iss.as9143.net [212.54.57.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF75A23175
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:06:15 -0700 (PDT)
Received: from [212.54.57.107] (helo=csmtp3.tb.ukmail.iss.as9143.net)
        by smtpq2.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1o1swg-0000im-85
        for linux-kernel@vger.kernel.org; Thu, 16 Jun 2022 19:06:14 +0200
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id 1swfoFkxh45FH1swgo8XkA; Thu, 16 Jun 2022 19:06:14 +0200
X-SourceIP: 81.97.236.130
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=e64V9Il/ c=1 sm=1 tr=0 ts=62ab6306 cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=QX4gbG5DAAAA:8 a=QyXUC8HyAAAA:8
 a=NLZqzBF-AAAA:8 a=fS49ki5Q-W1sAaxG2SAA:9 a=QEXdDO2ut3YA:10
 a=AbAUZ8qAyYyZVLSsDulk:22 a=wW_WBVUImv98JQXhvVPZ:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1655399174;
        bh=bGgOKyySvPDBIQ0HARYvFv7INGOOP345o5Y06M18/LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=521wBzsIhBiPthrG380iXdJ5B7lYK+xJoCqizjjUUSWVSstmDpNoGUVYmTHZdZpqz
         tFo9jczAr+oOhiAtOGStx7DZQHp67L2rARPfD2x3Hwjl1G4lN1b7oXnqx0yGuXN1/o
         +g9dvLILCcW152J7RlN8ZX4TGdcuaCXPxSbmi9OvtkH7vpkWRdCXhmbVHw85J+9qJH
         0laJrKiyZ9QPEli5RCwQm6GIBNh+mc3sIj9lS4iEdXAvNPQ4IxCdAHbfD0N2QGhsW4
         wTYxSFn1wh9rPJxAcG/zt0+i8DQe8w0bkrZsKfI+6WZZ6zS0YY+1LlgETSJ9zzfniG
         EnQinJU4kXFgQ==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id A91868DB58; Thu, 16 Jun 2022 18:06:13 +0100 (BST)
Date:   Thu, 16 Jun 2022 18:06:13 +0100
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression, 5.19.0-rc1 not powering off when hibernated
Message-ID: <YqtjBdEY59P9JQsx@llamedos.localdomain>
References: <YqE22nS9k2+AldI6@llamedos.localdomain>
 <84d01637-febb-f602-2d03-fe1600e85ae3@leemhuis.info>
 <YqTPlGM9KQ0FqHdc@llamedos.localdomain>
 <YqeUDpo+8RLVKH8r@llamedos.localdomain>
 <YqoLjk8P+fChJ04m@llamedos.localdomain>
 <Yqo4ZTrRZXEvxS36@llamedos.localdomain>
 <65fbe95b-241a-c5c5-4eca-d6932e0fd59d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <65fbe95b-241a-c5c5-4eca-d6932e0fd59d@collabora.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
X-CMAE-Envelope: MS4xfNgKlh3OEABvgXRinkp/fVv/xnQv5XuI2wEFyIuhBAGpa/dBHRPoWZ/a10uHG59LQKkkgIGSiamZkqHuj7MsbcKkVW5YEm6MqLbVqZ5XoQeu4ec8R3VP
 6oASgOBlqT94kaAj0bCzK2mKdljRK9hFcjEGPG3/xwOQdvwXlNSFcCvv9MGr9n/VFQN0sDcpcM+YcPdYndac3s9foWIh2EyVqud1xVs7hHMCd+0MA+gD3qWB
 wouc3cU9JMPQwA21O58froNwr6Y5Fvpu/+xDKVqrGssSNcAuyCctqiSSRhQWgdW4oCBFMuIdrYkBMjZMbcnZ11QrV2VlVHPqSbtwa/+naGI6LwMExwWOEPBR
 u9WjIeAkgf96I+38LG2P/9e/Atlect2vhoEC7tbAT/MHwe9QeJl4zkyu1LBvgmtAWjGknFcu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 05:59:10PM +0300, Dmitry Osipenko wrote:
> Hi,
> 
> On 6/15/22 22:52, Ken Moffat wrote:
> > On Wed, Jun 15, 2022 at 05:40:46PM +0100, Ken Moffat wrote:
> >> On Mon, Jun 13, 2022 at 08:46:22PM +0100, Ken Moffat wrote:
> >>
> >>>>>> But with 5.19.0-rc1 the screen is blank throughtout the hibernation,
> >>>>>> and briefly when restoring (no complaint about that), but when
> >>>>>> hibernating it no longer powers off and I have to hold the on/off
> >>>>>> switch to power off.
> >>>>>>
> >>>>>> Is this a known problem ?
> >>>>>
> > [...]
> >> Indeed, on the second attempt I've got a much more likely commit to
> >> blame:
> >>
> >> 98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71 is the first bad commit
> >> commit 98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71
> >> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> Date:   Tue May 10 02:32:30 2022 +0300
> >>
> >>     ACPI: power: Switch to sys-off handler API
> >>     
> >>     Switch to sys-off API that replaces legacy pm_power_off callbacks,
> >>     allowing us to remove global pm_* variables and support chaining of
> >>     all restart and power-off modes consistently.
> >>     
> >>     Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Unsurprisingly, with this reverted 5.19-rc2 fails to build.
> >>
> > It occurs to me that maybe I'm missing something in my .config.
> > Since that is 117K, here is the gzipped config from the version that
> > git blamed (apart from not powering off, it appears to work ok).
> 
> The patch below likely should fix the problem, please give it a try on
> top of the 5.19-rc2.

Thanks, works like a charm.

Feel free to add

Reported-by: Ken Moffat <zarniwhhop@ntlworld.com>
Tested-by: Ken Moffat <zarniwhoop@ntlworld.com>

if you wish.

Cheers,

ĸen
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 20a66bf9f465..89c71fce225d 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -665,7 +665,7 @@ static void power_down(void)
>  		hibernation_platform_enter();
>  		fallthrough;
>  	case HIBERNATION_SHUTDOWN:
> -		if (pm_power_off)
> +		if (kernel_can_power_off())
>  			kernel_power_off();
>  		break;
>  	}

-- 
     "Happiness isn't happiness without a violin-playing goat."
                             -- Notting Hill
