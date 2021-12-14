Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08C474AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhLNS2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:28:34 -0500
Received: from ip-16.mailobj.net ([213.182.54.16]:43750 "EHLO msg-6.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234322AbhLNS2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1639506500; bh=BR2qDXNKNKVk8yQ0KG1Y9Y1xpHQPnJBpsphvzPigeUg=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:MIME-Version:Content-Transfer-Encoding;
        b=kfNOwJNJvSgyOpXQBzdxLUqrgIsJxPamOrfMzG0VvgoAglXw/PnX6SGekEKT7UQ9L
         2Qn6S4tWoSllN3lArrcFLx1p3ZXbwuWW1UoIUkmWw8+ejIHnDM3Ji7IwC2Xd3t6DYA
         q5nK4dtpl/6DOWDM9lJF54CfshXUCpeXTASCV1Jk=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Tue, 14 Dec 2021 19:28:20 +0100 (CET)
X-EA-Auth: ZrbCefZvrR0MW3Fdl0zMedxelWrqSsj6Ao2YUQhL2yMarudqVTdrpgzaD7ksuVv62skx57agflarrPJkttU06rOjdpD0+L6FbsKpzqyunx4=
Message-ID: <fa40932c2dfbfcbdefa976f9609bdfca10fdd9cf.camel@mailoo.org>
Subject: Re: [PATCH 2/2] ASoC: Add AK4375 support
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        obayerd@eurocomposant.fr, phone-devel@vger.kernel.org,
        stephan@gerhold.net, linux-kernel@vger.kernel.org, tiwai@suse.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Tue, 14 Dec 2021 19:28:19 +0100
In-Reply-To: <YbeZ37FLnAsMfrDl@sirena.org.uk>
References: <20211213155914.2558902-1-vincent.knecht@mailoo.org>
         <20211213155914.2558902-2-vincent.knecht@mailoo.org>
         <YbeZ37FLnAsMfrDl@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 13 d=C3=A9cembre 2021 =C3=A0 19:07 +0000, Mark Brown a =C3=A9crit=
=C2=A0:
> On Mon, Dec 13, 2021 at 04:59:12PM +0100, Vincent Knecht wrote:
>=20
> > AK4375 is a 32-bit stereo DAC with headphones amplifier.
> > There's no documentation for it on akm.com, and only a brief
> > datasheet can be found floating on the internets [1].
>=20
> This driver looks relatively clean but it's in *serious* need of
> modernisation, there's issues here that haven't been present upstream
> for a very long time.=C2=A0 Fortunately they're mostly style things so it
> should be relatively easy to handle.

Thank you Mark for this review, hopefully I'll fix all points
and submit a v2 within a week or so.



