Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12974B3CD2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiBMSVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:21:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBMSVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:21:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA15717C;
        Sun, 13 Feb 2022 10:21:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A80961221;
        Sun, 13 Feb 2022 18:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CCFC004E1;
        Sun, 13 Feb 2022 18:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644776489;
        bh=Z4JsTbMUMjpHsmFygjZDeXmvGBzAO2NqeJ89Qij/jFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mEKVwT5APORAPkd9ErZ81Tp5FfsrFPahetC0GUNE7iM+BOYBuPzbotgxsf75+Ic55
         rUpNbH8s5nk94W6HkMTDZ+OE6GNDPp5+Q1esJjqceeoTYuYJfpe/iLXC8NQurNL+Rp
         GsVhYiiHM8zMDP5cio/s47V3uxPq6iZDBUsyXLLMvbaIDAB5sRnRjRAtYH/M+R16oq
         w8t6E9nkVxhDNMIxaNrnBBdAYDvpdQfi9oLtMsr4waxWy0MqflX5Bf85oK9RDHnHIK
         yqOm/oBCx+AxIAwm7GclVzMtAm0yeYMiEjH42tyl11XjRSiAAJehA/rl5JKBZIIBaP
         o1xq2GiN+2DSg==
Date:   Sun, 13 Feb 2022 18:28:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] Documentation:ABI:testing:admv1014: add ABI docs
Message-ID: <20220213182810.2246581b@jic23-huawei>
In-Reply-To: <CY4PR03MB339929F700810DA7BB36D43D9B2C9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20220207130549.98415-1-antoniu.miclaus@analog.com>
        <20220207130549.98415-3-antoniu.miclaus@analog.com>
        <CY4PR03MB339929F700810DA7BB36D43D9B2C9@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 14:55:36 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> --
> Antoniu Micl=C4=83u=C5=9F
>=20
> > -----Original Message-----
> > From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Sent: Monday, February 7, 2022 3:06 PM
> > To: jic23@kernel.org; robh+dt@kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Subject: [PATCH v6 3/4] Documentation:ABI:testing:admv1014: add ABI docs
> >=20
> > Add documentation for the use of the Digital Attenuator gain.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com> =20
> Forgot to add in v6:
> Reviewed-by: Rob Herring <robh@kernel.org>
Ah. That will break b4 trying to pick this up (as it's in the wrong
patch as you noted).

Please resend as v7 with fixed up tags.

I'm waiting to give Andy another chance to look at this if he wants
anyway.

Thanks,

Jonathan

> > ---
> > no changes in v6.
> >  Documentation/ABI/testing/sysfs-bus-iio       |  1 +
> >  .../testing/sysfs-bus-iio-frequency-admv1014  | 23 +++++++++++++++++++
> >  2 files changed, 24 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-
> > admv1014
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> > b/Documentation/ABI/testing/sysfs-bus-iio
> > index c551301b33f1..2b5770017a84 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -476,6 +476,7 @@ What:
> > 	/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> > b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> > new file mode 100644
> > index 000000000000..395010a0ef8b
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
> > @@ -0,0 +1,23 @@
> > +What:
> > 	/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_coarse
> > +KernelVersion: 5.18
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Read/write value for the digital attenuator gain (IF_I) with
> > coarse steps.
> > +
> > +What:
> > 	/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_coarse
> > +KernelVersion: 5.18
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Read/write value for the digital attenuator gain (IF_Q) with
> > coarse steps.
> > +
> > +What:
> > 	/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_fine
> > +KernelVersion: 5.18
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Read/write value for the digital attenuator gain (IF_I) with
> > fine steps.
> > +
> > +What:
> > 	/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_fine
> > +KernelVersion: 5.18
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Read/write value for the digital attenuator gain (IF_Q) with
> > fine steps.
> > --
> > 2.35.1 =20
>=20

