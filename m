Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CED4AF6BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiBIQbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiBIQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:31:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F79C0612BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:31:35 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u12so2645680plq.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f18zhjNA/1oePndK5dfsZn2r6JnfT2DoIKaTV1UU+J0=;
        b=2sVnnSBwxhgFlh+U1Zk8St2FmWoyRonVGWeOy1DyA+M6q+sqWhARdchnOEZsUycKeP
         DxgI6Qfy795n43SEMakuXQYcficNKrhTiHeciPFcQNdKYQDWU/nWWsDbQ3I6ftPlwGZ1
         HtZNSwk6kKpsllijI+8Yj9WxngExCltZghVwIsHlvKo8Oo6m8f8dypsDcIK2ovGB9rwf
         EkSvwhjoQ6bU01UYIUSGQdKc/S8PxfT/rp+nVVAVCxssTahcbN6AXnb/kobXDibDmIaU
         jV1kHAmmjV9iwGyAh+qdGPyfI0lGjMx3Tu6J51htzyd6WFLOq8ZUBF2IJqxRHG1apwSk
         Wh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f18zhjNA/1oePndK5dfsZn2r6JnfT2DoIKaTV1UU+J0=;
        b=baonj0ZvFb5WtBYPMgx+wzxQKtVTYFGKkFblBys9gOhyy1FUV4MnKPRAall37q5o8W
         f3M1yDEY+bcdWz/SSVbaKGSp6WPMI1p70ZJbsV6WNhC+fR77+Jy0+j+2+9BKEunDbVmr
         vMhwi9x2BQQkEcHAFNbSlAYfZjSRjOp/+/Z6woo+/HqkFN8LOzeObUA0tImSHFKvKwD5
         yexvJd7BLCYQ6DA6onS6C+v4X/RgsS1+8cop9u9oXu3KMLtmjqqLL99zxkXj33GX7v2N
         YV9PR5dNQuUjox2rkzxFCWSWcudzzve6s3aEb4lSw4NQ+g8NbKAuoGiFG6JNVT9GpZty
         ILuQ==
X-Gm-Message-State: AOAM531vENaZJ1iGkOIL67z/WrJ3Bw0R/SFBbVAK1cbvPsW8wFNYu7iW
        bY3QPrRbBPFxhLDzNH5hjnC2ozWhYgoCKJoHKTtS6A==
X-Google-Smtp-Source: ABdhPJxF3yvL4j70OAESSKqp6CPknT56/uTzkqGgr/AJaHoa1k+VCeL/+SKVyl5kGWq2ZEIsoTRHHdMfo+wouOVXPlg=
X-Received: by 2002:a17:903:1210:: with SMTP id l16mr2952959plh.63.1644424295180;
 Wed, 09 Feb 2022 08:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20210421055047.22858-1-ms@dev.tdt.de> <CAJ+vNU1=4sDmGXEzPwp0SCq4_p0J-odw-GLM=Qyi7zQnVHwQRA@mail.gmail.com>
 <YfspazpWoKuHEwPU@lunn.ch> <CAJ+vNU2v9WD2kzB9uTD5j6DqnBBKhv-XOttKLoZ-VzkwdzwjXw@mail.gmail.com>
 <YfwEvgerYddIUp1V@lunn.ch> <CAJ+vNU1qY1VJgw1QRsbmED6-TLQP2wwxSYb+bXfqZ3wiObLgHg@mail.gmail.com>
 <YfxtglvVDx2JJM9w@lunn.ch> <CAJ+vNU1td9aizbws-uZ-p-fEzsD8rJVS-mZn4TT2YFn9PY2n_w@mail.gmail.com>
 <Yf2usAHGZSUDvLln@lunn.ch>
In-Reply-To: <Yf2usAHGZSUDvLln@lunn.ch>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 9 Feb 2022 08:31:23 -0800
Message-ID: <CAJ+vNU3EY0qp-6oQ6Bjd4mZCKv9AeqiaJp=FSrN84P=8atKLrw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: phy: intel-xway: enable integrated led functions
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Martin Schiller <ms@dev.tdt.de>, Hauke Mehrtens <hauke@hauke-m.de>,
        martin.blumenstingl@googlemail.com,
        Florian Fainelli <f.fainelli@gmail.com>, hkallweit1@gmail.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 2:54 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > The PHY_INTERRFACE_MODE_NA is a neat trick that I will remember but it
> > would only help with the rgmii delay issue and not the LED issue (this
> > patch). The GPY111 has some really nasty errata that is going to cause
> > me to have a very hackish work-around anyway and I will be disabling
> > the PHY driver to stay out of the way of that workaround
>
> Well, ideally we want the workaround for the erratas in the kernel
> drivers. In the long run, you will get less surprises if you add what
> you need to Linux, not hide stuff away in the bootloader.

Andrew,

I agree it is best to get workarounds for errata in the kernel where
possible but this one is going to be a mess. There are 3 errata for
this part and 2 of them require a toggle of the reset pin as a work
around. Even if the mii bus can export a function for the phy to call
to toggle reset in my case one of my boards has 2 of these PHY's (1 on
a RGMII MAC and 1 on a SGMII MAC) on different MDIO busses that share
a reset pin so if I trigger a reset I have to re-configure the other
phy as well.

The errata can be summarized as:
- 1 out of 100 boots or cable plug events RGMII GbE link will end up
going down and up 3 to 4 times then resort to a 100m link; workaround
has been found to require a pin level reset
- 1 out of 100 boots or cable plug events (varies per board) SGMII
will fail link between the MAC and PHY; workaround has been found to
require a pin level reset
- occasionally the phy will come up with a high bit error rate between
the MAC and PHY; workaround has been found to require a soft reset or
ANEG restart

>
> > As far as changing a driver to force a LED configuration with no dt
> > binding input (like this patch does) it feels wrong for exactly the
> > same reason - LED configuration for this PHY can be done via
> > pin-strapping and this driver now undoes that with this patch.
>
> Is it possible to read the pin strapping pins? If we know it has been
> pin strapped, then a patch to detect this and not change the LED
> configuration seems very likely to be accepted.
>

No, you can read the current LED configuration but you don't know if
it was set via strapping or boot firmware.

Best regards,

Tim
