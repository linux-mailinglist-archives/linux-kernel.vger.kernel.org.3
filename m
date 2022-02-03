Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ECE4A7FA1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349316AbiBCHJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:09:24 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:36820 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbiBCHJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:09:23 -0500
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 87789DA1297;
        Thu,  3 Feb 2022 08:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1643872160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51/7p+IYDkPoRapTW3q5hN1SVWCp2o0jDPo3TcpFpfI=;
        b=v84kzaOqAYv2Igp3oZfOxPPPp1VJQHtfK7eyzGI0v8EuO2OknDeoBOnY2jtYZlnBFKf3yt
        TkTkU6pXPefxiJU4FcAErHN7w0hEmFyo+CN/chTenMjhELhFd2FOGUH2F5PWY4b/mcV7FV
        D8RDZeltlWhU2x2GepDeYnnizoV5kEE=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Guenter Roeck <linux@roeck-us.net>,
        Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [ASUS EC Sensors v8 0/3]
Date:   Thu, 03 Feb 2022 08:09:19 +0100
Message-ID: <8022383.T7Z3S40VBb@natalenko.name>
In-Reply-To: <CAB95QARyz_sp9MoMsakfAK+PRBnVVnyOQzm2ZwJwwLE5vvAUFg@mail.gmail.com>
References: <20220124015658.687309-1-eugene.shalygin@gmail.com> <7c8f311f-a2e4-584f-eb29-7f0d2a335e8f@roeck-us.net> <CAB95QARyz_sp9MoMsakfAK+PRBnVVnyOQzm2ZwJwwLE5vvAUFg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 3. =C3=BAnora 2022 4:48:53 CET Eugene Shalygin wrote:
> > > Oleksandr sent an informal one already.
> > >
> >
> > He wrote:
> >
> > "Given minor changes against v7, I think my "Tested-by:" should have be=
en preserved."
> >
> > which doesn't mean he tested again, only that in his opinion
> > the tags should have been preserved.

This is not what I meant, but my wording could be better, yes.

BTW, the changes were not of that kind to drop Tested-by: tag, really.

> Oleksandre, could you, please, let us know did you actually test the
> v8 code and if so provide us with the Tested-by: tag?

Yes, I do run this version now, and it works fine for me.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

> > That means that I am left with either accepting the series without any
> > Tested-by: and/or Reviewed-by: tags, or I have to wait for some. I guess
> > you are telling me that I won't get any additional tags, so I'll have to
> > go in myself and have a closer look. I'll try to do that in the next we=
ek
> > or two.
>=20
> Thank you, I understand now. If Oleksandr does not reply in a few days
> I will send the update with another board
> (fully duplicating information for its base variant), tested by a
> Libre Hardware Monitor user.

Thanks.

> Best regards,
> Eugene
>=20

=2D-=20
Oleksandr Natalenko (post-factum)


