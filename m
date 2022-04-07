Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6855D4F8889
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiDGUa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiDGUac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:30:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236462E0F33;
        Thu,  7 Apr 2022 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649362493;
        bh=N6/FEyVpcVAz4B+dz6VLJs5njSr6wfG1FKLDFl/Zz78=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YMpmWNQm2OdUv19j7O4H83V2BjrmoSr3pRMxdw1SfkJ3AGeFUf4uHe1sHid2daq2o
         MCJsEn+j5zXjz4e0B8G+2gtdKQUlvAk5eGbMl5sxCxSkTPmQxbEwXCiv+DcQGZWfFx
         eKCz04B9QadiWiTAqWhPvmj2Q2Q9A0DrNwHRwTLY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.161.122]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1nYRQ20Y2B-004BOi; Thu, 07
 Apr 2022 21:50:45 +0200
Message-ID: <eb2edc5a-afad-f0c9-012f-9b9f226d2e5a@gmx.de>
Date:   Thu, 7 Apr 2022 21:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/7] video: fbdev: i740fb: Error out if 'pixclock' equals
 zero
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220404084723.79089-1-zheyuma97@gmail.com>
 <20220404084723.79089-2-zheyuma97@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220404084723.79089-2-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XxvmZy8oYHEoPKTe6X2SYk0Pjr8XeAjoK1SV6d6GPPRKYzfl92j
 4mENiOhlREipIcFBpaEyuyq4T/upzS8fU2vT8q0RJJMgI4yc5/vQWvPaWZvMmu6Cm2xlZXy
 6nDRqB2J2mlNs05MzmcULprxcIGyOVwxdD4TnYt3q088BbkH56pExHZjsdgwhWzLlBCpYU4
 QIykXMIP/DCNAllnteMnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XzunuzazY+I=:FtKKRBnvFXRuGBImamICcS
 oHZmmQJQeuBnRbEj0mwVBLNln6Mh6kUd+kmPF7OJ+5lEf7rsR5ifbhpFd3BWFFz+6y/4SzuB/
 hojIGzBerQKR9hSWaWLsfEy2/JSo4kKgy8BJKQN24QV1E6iPWtxzG8j5MJnnDBXUBxUrEU70a
 2dxHARhJPXX5b7BlndjoR0lXL2QjK/obqoHs4U1O+v9lySTcRk7hkZiM35H/JpmXI7fsaDZpi
 xYjRg9dHYoMGAFUpy24ZEkM74bOeKrKT2pdWeQnrv7bTQ1YWDv+nVokqg54m5rzJ7jz9toPGz
 uSlD8JAw36lr0qepK9drnAnb6nxpeD0Sk7T1niAsf5AFWPiydbXl+aUta4Lpe9VKw4Tx9FY7g
 6bE8hzn1o/6sH4ZykQKfyqimFb3b/dyrh3km2YvV4krqPusWvcACC5ib4XAlwgEjj9GxjPndj
 P+rLIHNiWG/GzYWjKhlVc1DLFbruDdjZwMDKrQr898ankBz5Q2Nlwm2w1VcCmY9KSrmSu4Xnd
 9w+hfO2KFZCbTIKNuQwOGZuzDbhBYgWL/lbRlp0hkH8PQceos8fnoOeGeNzPzXVqA9ZXpRkJJ
 C9Emz90FBcajJE7vdDGGnjVjCUBPD/879xXMuJV1YpBStYfaOXW+EfMnuaKRLKqrlwq1Vk8KO
 99y6pAJFsC1gTkrqX70ZU95PN/SFHo5X2rbXsRYC1MnuaFyjpIWAb0NtXoS8TXPIK8O8tSgRi
 RZJ/wT6p5/rcYqgmT2UrE/IdZRlbGKut46un+xBdV7egTYQe1XBvQmDhlpCmewMLGL4nzLc1k
 vGRKrUk6UvEpW1VdqZ5jNIKOXmMajAKLwioYwVD9yeuLS5N4ujn5E1ThNCf+vCFldrRpW4/p1
 8EMd7QmcrBxk1ThZEDdG7pjtjpvK5Lk/BNHkPw0KhHYDoYj28aSjhT2TTUmNzvFmhs99o9NvN
 roAbtOu6kSSD6ZeHx4o/WZWodgqZUPhm3ISR+tAN0lfp6y3CIsxEWtRdZcLzz2eWrW2gL4V/E
 mPkvD/BsdgCyAZLr4VSMRGAXSBGNREnVRlhKQOxDMB4TG5HbaIw9kTA3pFFt50I+ymySWddLx
 wRRGTCsjSDu2Nc=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 10:47, Zheyu Ma wrote:
> The userspace program could pass any values to the driver through
> ioctl() interface. If the driver doesn't check the value of 'pixclock',
> it may cause divide error.
>
> Fix this by checking whether 'pixclock' is zero in the function
> i740fb_check_var().
>
> The following log reveals it:
>
> divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> RIP: 0010:i740fb_decode_var drivers/video/fbdev/i740fb.c:444 [inline]
> RIP: 0010:i740fb_set_par+0x272f/0x3bb0 drivers/video/fbdev/i740fb.c:739
> Call Trace:
>     fb_set_var+0x604/0xeb0 drivers/video/fbdev/core/fbmem.c:1036
>     do_fb_ioctl+0x234/0x670 drivers/video/fbdev/core/fbmem.c:1112
>     fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1191
>     vfs_ioctl fs/ioctl.c:51 [inline]
>     __do_sys_ioctl fs/ioctl.c:874 [inline]
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Hello Zheyu,

I've applied the patches #2-#7 of this series, but left
out this specific patch (for now).
As discussed on the mailing list we can try to come up with a
better fix (to round up the pixclock when it's invalid).
If not, I will apply this one later.

Thanks!
Helge


> ---
>  drivers/video/fbdev/i740fb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
> index 52cce0db8bd3..b595437a5752 100644
> --- a/drivers/video/fbdev/i740fb.c
> +++ b/drivers/video/fbdev/i740fb.c
> @@ -657,6 +657,9 @@ static int i740fb_decode_var(const struct fb_var_scr=
eeninfo *var,
>
>  static int i740fb_check_var(struct fb_var_screeninfo *var, struct fb_in=
fo *info)
>  {
> +	if (!var->pixclock)
> +		return -EINVAL;
> +
>  	switch (var->bits_per_pixel) {
>  	case 8:
>  		var->red.offset	=3D var->green.offset =3D var->blue.offset =3D 0;

