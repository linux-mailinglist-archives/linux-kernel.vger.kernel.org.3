Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CAF52D037
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiESKMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiESKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:12:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECFA5A92;
        Thu, 19 May 2022 03:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652955149;
        bh=OPdP5IIMcN9fBxqMri4kI953iSbKa5P+IdL25Vzrksc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Wym7vJ+4MH8ZqHKuSB8e8hDDvFm8IeDztTxsz8DMGmFK2VZ72EV7FLuQxAiQBBcrP
         PM7Kp30BM4IPHM9b4ynQb4GTDOg1IeypiCfsNYFlm78nf5wJkitBKaj8c3l4iZ5r+K
         Sv1iCR8kc6t7BpXW6ZNnX6ZDZQC0b2/ScvNRF+9c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfYw-1o2ehh2Bjc-00B7l7; Thu, 19
 May 2022 12:12:29 +0200
Date:   Thu, 19 May 2022 12:12:28 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Kun-Fa Lin <milkfafa@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, CS20 KWLiu <kwliu@nuvoton.com>,
        tmaimon77@gmail.com, avifishman70@gmail.com,
        openbmc@lists.ozlabs.org, tali.perry1@gmail.com,
        Marvin Lin <kflin@nuvoton.com>
Subject: Re: [PATCH v2 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
Message-ID: <YoYYDPHPjSUefbAg@latitude>
References: <20220513033450.7038-1-kflin@nuvoton.com>
 <20220513033450.7038-6-kflin@nuvoton.com>
 <YoOje2L13q7d7KeI@latitude>
 <CADnNmFoa6=BWs74oQxEtP4TO-mL_vc0py4+4V1wjdtetW4Vy5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OETo/OdLKGpLORLY"
Content-Disposition: inline
In-Reply-To: <CADnNmFoa6=BWs74oQxEtP4TO-mL_vc0py4+4V1wjdtetW4Vy5w@mail.gmail.com>
X-Provags-ID: V03:K1:GXL75oMM104pMaA0156vPkd1685uZ4OdSHAyF6TOOXcGi7Facg+
 KHVn2WswayORkpSpMAFN8jqdA0HJKNToBwaxjqib46spLsHHwBaTZ+2xbBxAVg8lL5CN9zz
 4X1EAyLHY6IP1J8+ntwdBiXSJKl3AiwQDVoAi10ZiHq7mxphyAHGYDyoMl90WHJ3ZvstMxl
 +cZz+bfsSUxCFNxcMyY8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oM9aJgrAhB0=:iMl4+K42OCw82rNHjDHRgl
 wqftQnjGOzcNaCpejU3YcQ0eVcXInRg7Z9UMU9tBm0jT/8L4lo1zFcVXoa3e/X2zX8nD7se85
 z6QUW0JTrUKDgVI9c8FyBdbeIxSd5BcgSv2CaCjf7JynCb6KGLsG0kex0j5vX3iN6LhEbrGNS
 vjTsWRlSPN2H3UvMDg2leY+V5+1EzJeFhSTUlfWrghr/s8XzA6tTHLvV0ZGd+8UhQS6TEi0Q/
 d230vT4/T+wK/kRVG/VRLXTZMQGsAUkqL65FvYazqQHE7DvN/IkIaAxTqvzbtjL25BT2KScml
 PduJGLMKO5NcmuHoYjyVKZ3NjQs9WYSY52hYZDvnhF2sftD2gragCnMpVVUA/CsHtZFu17RHL
 ztQCscTZRjEX+wMpxFL+7d/lU00vkW9zlJUKop+KWMOZXtRBu8S/8ZGnsu/xmh2IYWE06qM1E
 rq3vXx1RQvZxTc5lgqi2ctLbxFPGv/NmCOkdhlVLIQtVRUgQbAciEnmmwwJwZMqkHK5dADENy
 PRXWDJCqvIwiH0hV9YWdaiFP9zC/QeF+w0s87eA4Cr/zA4+6WqqZxbZPOnX7drSx0aT1h95qp
 KkayoIzb+bXnwBy0izbbejPMVQQnRKK3+ViFbnoBYd+X6iDK+X9ZGGTmLBh/eo31ElAVi3BgM
 Kz/hOODSRrBuSVruiwq5vFQA6TEVUMCPnt0NESYGPO2BCE+SqeMS8BYZjW1KfKzD3qEr1ZPTb
 DGu+Po7Le+QpACbQJgbbYGr3Q4FKsivpgpYWMbC1jVLOhA8K4Y4ljknmfUrUvF+49FU0aIt1P
 xZOZXVOyFNKtscQ4fSEwIcLt2K1lR1cX0ZUzeUj0JWLGdLndDRm9piqe9Irv6Jiz7N9ZfA6Iy
 9ZB2RkWyIeJARPgmLAKZaYbMs7MWO9hmgC/6grFOUtEk829NeEmAEZ64C2+Lz7aO5ww7KY3HY
 4JjgXeh4jw9ma+iAKOFV5QuV+rnYwGNevkkEB8x5SIJu1Rq6TjFOrDgHKt01ax025Yw9T5cxP
 32eg9WxIinsLB7JZDEq6P0SfMgEyJOfcHiPyNohTPyfjsXyoMcUnqkzq1NwYpx8cMadyY34O4
 d2StwsxLCB9ztJCg8+XdSX9Vor35/97sxVelCfWmDj4YohXihIxCNiedw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OETo/OdLKGpLORLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Marvin,

On Thu, May 19, 2022 at 01:39:01PM +0800, Kun-Fa Lin wrote:
[...]
> In this architecture, for the case of WPCM450 (though it's in EOL for
> several years), I'd prefer to try to let ECE be an optional node
> instead of separating ECE code from this V4L2 video driver. However,
> this patch series could be the base version and keep reviewing, and
> afterwards we could make another patch for optional ECE, is it OK for
> you?

That's OK for me.

I will wait until the driver is ready and merged, and then start working
on WPCM450 integration and making ECE optional.

Regarding WPCM450 being EOL, I'm aware, and I don't want to hold up your
team's work on newer SoCs. But I personally find this old SoC interesting
and I want to share driver code with newer SoCs where possible.


Thank you,
Jonathan

--OETo/OdLKGpLORLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmKGF+QACgkQCDBEmo7z
X9t0LRAAranUgQMvjypAouXTtgrde1IicjtSlp9n9g9lrRSuwJ3SPyYfI1OCr7Ac
shd7clvanfcZq0Ti//rGDn+DnYsLv5OVWpUKx8mKBLtiRkmDl8DIcvupdDQPqrux
7BPO9DLkj4QpgHym+4/2PLffEXVNkjpaf8uxRCnGmMrkMCgtaJSU+0f4txR+P5dF
vKOfp0mz/VJfoX4zMSGqjd1WbStTTHAhx07XOOZtzmuoxkTIfrQNZoo77KBb4Wzk
gqXIAGJhO/MOoJ4npzJeR2aKALVjGk48Xq1nxQDAFYnf4AkV1BW3LsbGWT3nt0hN
suMVMqLhAeSFP6pH1vxSw0u5VZJ5NPXM6Brwp1q9caV4kL+GZuguutKBEWVXodrT
JuOLz05JSp2osTS4029je9dXmF9IFoIAKFR7DpMERgAAekim0tBlllO2ITbuu6Dh
bd1VKO6RKJgaf3UOzJ7iTh+wkyc+HHnc+6KUgas7J//ThY+6w1tRK2y1Zl+1h3fc
3pdRUOSvFM2aDo3+Mx33LAK85tI19o09cn2PirukmmOLh4C2FDg11ByZkS9pDq+H
HXMXvB0O4UHhwYPN/XN/4mgYgA4CuRDuj+MGgnCYy7x/AZ5AVHC4Eg3MlFBCpyaJ
d7jL9dW/xxUv6zlW3vvTFLpWjPL9+6dxK8WN8knFmsoPJfsNSWM=
=DvvF
-----END PGP SIGNATURE-----

--OETo/OdLKGpLORLY--
