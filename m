Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56B746D791
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhLHQBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhLHQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:01:42 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59322C061746;
        Wed,  8 Dec 2021 07:58:10 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b40so6424012lfv.10;
        Wed, 08 Dec 2021 07:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=itzT9b9xcxAMgbIBHDRk8S7CZMk+weB3I8iE7l5FbcI=;
        b=F+9H0Veesl4+ZWQUDDKxojkO79M45ZQBBdkoGgueHD6G9aie/c0AroFcz4NJ0X1X7i
         947z5gRyw74N3uT1vyhWQWMFu2GFIpCO/8nBVhIy9nSdn11hmG+DF2A0WgL6EFv13Oea
         LXT8KlTeAxfO0SGdzA28TOYej8AO6yHMFwcWxn2Yr8UvpR+aqvFOhtlkzwD0LZIde6x/
         XvgJv1+xHjy4liFurIncl3/U+p7SvCQD8TOP5cUqldY/QOSFebRjOpkWayl/oMk7aX1w
         BTT/jrufO/Ym0cz/ABtwRm3mZxflD8pB4EQoUUgyBsSN8eQjH2VkhJfqugbMiMSxYfou
         /XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=itzT9b9xcxAMgbIBHDRk8S7CZMk+weB3I8iE7l5FbcI=;
        b=s5BWTkPBQiK5gxFMH/0zeWsBJaAkZLSX98/hQ2qVC8P0vS9vPNeAwZE2QPg7X0fLRl
         8XT0ngdMJZczPXsBN7+gwVXlb5cKP//FHoFlNE5fUWb89kuXh6Py+/yvWJH0JCLvghHp
         qX9Qk2PwUAwINtUQgYKPqLhKhP3mJRXvacWtpSO24yuMGcdC9QCr+CLPZHC2uqpcQmZg
         pMLBIihy2NzRq5HPPdvlIER+630D3UjnZjWE/JDsuwpo46vpUXUv4PJ1MW5N02e5eRjX
         Ap1MRhIsKLXdRIJWGDEBZGQ6PbeuKJ6BpU7COIkLZAbU7vzYOGRgwO6ObhNrEwFW+hLj
         F56w==
X-Gm-Message-State: AOAM531dJRpZlYxOL0sV+6XffdTODlnVYIlZfYacIQvGPR1rWC66bZtc
        s+hS3iR3DURxsMkc09ol97tw7XulCVkffzQ+Id8=
X-Google-Smtp-Source: ABdhPJz4lC3SNQSDLzASZyEzONDA4JkupkPezFue2aBnBln5KAlAio0jqvELL4NrsvzIkzCMVTKh8oZRObFbnyrtoN4=
X-Received: by 2002:a05:6512:33c4:: with SMTP id d4mr313689lfg.182.1638979088418;
 Wed, 08 Dec 2021 07:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20211207015446.1250854-1-aford173@gmail.com> <f85da774-ccb3-85de-edd6-5333ed8d0503@collabora.com>
 <5a8b84e91bd8e7670a0d0108e4affe9b964202cb.camel@pengutronix.de>
 <4cc3404b-7f8a-6c87-8c1c-ace399f9edd3@collabora.com> <CAHCN7xJJfBXdK6B1tHXjmja4Lr=Q-Uony+QWcvVqoQp36RLY=w@mail.gmail.com>
 <7bbcee7d8d52cab00635037c35c81b43ce34ec76.camel@pengutronix.de>
In-Reply-To: <7bbcee7d8d52cab00635037c35c81b43ce34ec76.camel@pengutronix.de>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 8 Dec 2021 07:57:57 -0800
Message-ID: <CAFXsbZpq-X=MC2ZXsMx0175SHxeHJQ88wOm9reEJqQfm_bw43A@mail.gmail.com>
Subject: Re: [RFC V2 0/6] media: Hantro: Split iMX8MQ VPU into G1 and G2 with
 blk-ctrl support
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Adam Ford <aford173@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media <linux-media@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 7:39 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Mittwoch, dem 08.12.2021 um 09:13 -0600 schrieb Adam Ford:
> > On Wed, Dec 8, 2021 at 7:36 AM Benjamin Gaignard
> > <benjamin.gaignard@collabora.com> wrote:
> > >
> > >
> > > Le 08/12/2021 =C3=A0 11:32, Lucas Stach a =C3=A9crit :
> > > > Am Mittwoch, dem 08.12.2021 um 10:32 +0100 schrieb Benjamin Gaignar=
d:
> > > > > Le 07/12/2021 =C3=A0 02:54, Adam Ford a =C3=A9crit :
> > > > >
> > > > > > Currently, the VPU in the i.MQ8MQ is appearing as one codec, bu=
t in
> > > > > > reality, it's two IP blocks called G1 and G2.  There is initial=
ization
> > > > > > code in VPU code to pull some clocks, resets and other features=
 which
> > > > > > has been integrated into the vpu-blk-ctrl for the i.MX8M Mini a=
nd a
> > > > > > similar method can be used to make the VPU codec's operate as
> > > > > > stand-alone cores without having to know the details of each ot=
her
> > > > > > or the quirks unique to the i.MX8MQ, so the remaining code can =
be
> > > > > > left more generic.
> > > > > >
> > > > > > This series was started by Lucas Stach with one by Benjamin Gai=
gnard.
> > > > > > Most patches have been modified slightly by me.  It's in an RFC=
 state
> > > > > > because I wasn't sure how to best handle the signatures and was=
n't sure
> > > > > > if I could base it off the branch I did.
> > > > > >
> > > > > > Since the g-streamer and media trees are in a constant state of
> > > > > > change, this series is based on
> > > > > >
> > > > > > git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
> > > > > >
> > > > > > The downstream code from NXP shows the G1 and G2 clocks running
> > > > > > at 600MHz, but between the TRM and the datasheet, there is some
> > > > > > discrepancy.  Because the NXP reference code used 600MHz, that =
is
> > > > > > what was chosen here.  Users who need to adjust their G1 and G2
> > > > > > clocks can do so in their board files.
> > > > > Hi Adam,
> > > > >
> > > > > Thanks for your patches, I have been able to reproduce VP9 result=
s on my side (Fluster 147/303).
> > > > > In past I have notice spurious errors when using 600MHz clock on =
HEVC decode but not with 300MHz.
> > >
> > > The results for Fluster HEVC are 77/147 so no regressions :-)
> > >
> > > Regards,
> > > Benjamin
> > >
> > > > > The max supported G2 clock frequency is 660MHz but needs a higher
> > > > > voltage. The maximum supported  frequency at the default 0.9V is
> > > > > 550MHz. We should not configure the clocks for the higher than th=
at, as
> > > > > long as there is no support in the VPU driver to scale the voltag=
e
> > > > > along with the frequency. Same as with the GPU we should stick to=
 base
> > > > > frequency levels for the nominal operating mode.
> >
> > Lucas,
> >
> > After reviewing the comments from Benjamin, I re-ran the VP9 tests
> > with the G2 running at 300MHz,and the number of passing VP9 tests
> > increased to 148 from 144 with an increase of time to 250.502 secs
> > from 162.665 secs.
> >
> > While the datasheet reads that the G2 can run faster, the i.MX 8M
> > Dual/8M QuadLite/8M Quad Applications Processors Reference Manual,
> > Rev. 3.1, 06/2021, table 5-1  shows the VPU_G2_CLK_ROOT has a max
> > clock of 300MHz.  I might be inclined to agree with Benjamin on the
> > 300MHz and let people who want to push their hardware overwrite the
> > default clocks since it increases functionality.
> >
> I'm quite surprised that the G2 codec should have such a much lower max
> frequency compared with the G1. While the table from the RM hasn't been
> obviously incorrect for any other clock, I'm still inclined to believe
> the frequencies stated in the datasheet.
>
> > I wonder if someone from NXP can comment
> >
> Yea, not sure how to proceed here. 300MHz is the safe bet, but we are
> leaving quite some performance on the table if the datasheet is
> correct. Without some help from NXP it's probably hard to validate
> which max frequency statement is correct. It doesn't really help that
> the NXP downstream kernel seems to drive the G2 at 600MHz, which is
> neither the 550MHz nominal mode max, nor the 660MHz overdrive mode max.

According to the NXP i.MX8MQ docs, "The G2 decoder conforms to the
HEVC Main/Main 10 profiles and can decode streams up to level 5.1."

If I'm reading the levels correctly, level 5.1 =3D 4,096=C3=972,160@60.0.  =
If
the decoder can achieve this throughput at 300MHz, then there should
be no reason to go higher?  My speculation though is that when run at
300MHz, the decoder is not able to decode this fast.

Adam, can you determine the throughput at the different frequencies to
see if 300MHz can support 4K60 decode?

>
> Regards,
> Lucas
>
