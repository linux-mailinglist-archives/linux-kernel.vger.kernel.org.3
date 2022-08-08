Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE93858CC06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiHHQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbiHHQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:19:45 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4C213D31
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:19:43 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h22so6866105qta.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=TMxAwwBuDIuNTxYXTvn6eaPztP+oVubZ7rDA0wooS+Q=;
        b=II9WETClrsRAiCDqhnZmFzp1dBw++qogq2DHDbZTVQ6u1MGeIW8LBDr6DuqzJJbmRr
         fEa9bgZTFe1Kl6rpEnyKMRbAEoMxDKm3NQawfMCiPvmDEdM+KYjh3aXWnr/aEIoyfEZf
         lUL6JxZrVrn+VMSQLB1m6LOptKn/U10O5EBdvS3QAcWV1iWuFI2eNgKcEXFCg4i2rVBd
         N/m4/qaF2eY3Da+9tut1Aa6ZwxQ/+bOziUg7Zu5Gio9/kPI+CbZPjCVAPe7vAyZp1UBc
         2nYLWSozLq4iYAtFvyRW5fIevEWig+KzhDxt1Ct7RFKrZkVxVwO9miw6IE2U0/Rez0z0
         IX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=TMxAwwBuDIuNTxYXTvn6eaPztP+oVubZ7rDA0wooS+Q=;
        b=K7RxN955l9B7+Tk+IITtYTNGZn6LETb7TojlK95hTybjb0StmLLs00dUXmYOoOeFTw
         qzOQFR46HW9DkRWvaFilcHfnGVZCsR2Rr1S5YBUUJmJ9K56XDfPR2mij2mEnBPfJRrxO
         1QCxj3aXhlkPpCdOncXL+jVnOaV1/gN3OvvdgPgLS/tMPrBSxXKhrhsfmhpq4N/ykGxk
         wh/M3ZKtrYHfKc1ka+RyYz+NZR9ECiIZzxzukAk2vxdjZ9qf6zRaO3t3kq/Yd51awRbU
         klGJILeVGqnblZfRhLS9V4TabGMd3sWyyv0oKSXjruMm+RHeZ8Indtkyhf48LrUGyFTs
         17AQ==
X-Gm-Message-State: ACgBeo01655E2J4ZeEeHCG0JNxq3A1WUmHadj/oSJvK4q/6XJMrbTnki
        L4RhJUaJPx5worcDHxVsf+qGfQ==
X-Google-Smtp-Source: AA6agR7XpylISJIhNtARrNWh9HAl2hX/LKk2L4+LIK4bFsg8V4DIyTe58ZP2EqdcKK84EuzKnCkQ9w==
X-Received: by 2002:ac8:5ad0:0:b0:342:fc73:2aa4 with SMTP id d16-20020ac85ad0000000b00342fc732aa4mr3071075qtd.207.1659975582802;
        Mon, 08 Aug 2022 09:19:42 -0700 (PDT)
Received: from fedora ([23.82.142.208])
        by smtp.gmail.com with ESMTPSA id y1-20020a05620a44c100b006b8c575ce27sm4105856qkp.109.2022.08.08.09.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:19:41 -0700 (PDT)
Date:   Mon, 8 Aug 2022 12:19:39 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v3 2/2] iio: time: capture-tiecap: capture driver support
 for ECAP
Message-ID: <YvE3m+jLPuLvXXdS@fedora>
References: <20220728175124.468461-1-jpanis@baylibre.com>
 <20220728175124.468461-3-jpanis@baylibre.com>
 <20220731164116.30e91f34@jic23-huawei>
 <11b7436b-5c31-671e-ba77-435fe8e3b767@baylibre.com>
 <98d17617-72b5-6330-d4f5-1bece928ceab@baylibre.com>
 <YvBZQsiAm6f3yxME@fedora>
 <d47c842b-579d-b119-73f9-e8c95984b30b@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6X5vf6Fz1F42Rx02"
Content-Disposition: inline
In-Reply-To: <d47c842b-579d-b119-73f9-e8c95984b30b@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6X5vf6Fz1F42Rx02
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 08, 2022 at 10:58:22AM +0200, Julien Panis wrote:
> On 08/08/2022 02:30, William Breathitt Gray wrote:
> > Hi Julien,
> >=20
> > I've taken a cursory look over the TI ECAP reference guide and your
> > descriptions in this thread. I think a device driver for this would fit
> > better in the Counter subsystem than IIO.
> >=20
> > First I want to correct a minor misunderstanding: the "timestamp"
> > member of struct counter_event is simply a way to identify Counter
> > events on the system as a way of grouping multiple Counter watches. In
> > other words, the "timestamp" member here represents when a Counter event
> > was detected by the system, not when an event was logged on the counter
> > device hardware. Instead, hardware timestamps such as the CAPx registers
> > would be provided by the "value" member of struct counter_event.
> >=20
> > Now, I have a few ideas for how we could expose the timestamps using a
> > Counter device driver, but first I want to make sure I understand
> > correctly what's happening in this device. If I understand correctly, we
> > have the following device components:
> >=20
> > * CTR: 32-bit counter timer
> > * Mod4: 2-bit counter
> > * CAP1-CAP4: four 32-bit registers, each indepedently store a timestamp
> > * ECAP: input signal providing event trigger edges
> >=20
> > Four edge polarities are configured corresponding to each CAPx register,
> > yet the input signal is still the same single ECAP pin. The event that
> > is fired is instead determined by the Mod4 counter: when Mod4 is 0 and
> > the edge of ECAP matches the polarity configured for CAP1 then an event
> > is triggered which saves the current CTR value to CAP1 and increments
> > Mod4 to 1, etc.
> >=20
> > Is my understanding of how this device behaves correct?
>=20
> Hi William. Thank you for your help.
> Yes, your understanding of how this device behaves is correct.
>=20
> >=20
> > If so, then one possible way to represent this device in the Counter
> > sysfs tree is something like this:
> >=20
> > * CTR: /sys/bus/counter/devices/counterX/count0/count
> > * Mod4: /sys/bus/counter/devices/counterX/count1/count
> > * CAP1: /sys/bus/counter/devices/counterX/count1/cap1
> > * CAP2: /sys/bus/counter/devices/counterX/count1/cap2
> > * CAP3: /sys/bus/counter/devices/counterX/count1/cap3
> > * CAP4: /sys/bus/counter/devices/counterX/count1/cap4
> > * ECAP: /sys/bus/counter/devices/counterX/signal0/signal
> > * polarity1: /sys/bus/counter/devices/counterX/signal0/cap1_polarity
> > * polarity2: /sys/bus/counter/devices/counterX/signal0/cap2_polarity
> > * polarity3: /sys/bus/counter/devices/counterX/signal0/cap3_polarity
> > * polarity4: /sys/bus/counter/devices/counterX/signal0/cap4_polarity
> >=20
> > This is just a tentative arrangement (you could also include "enable"
> > attributes as well), but it should give you an idea of how it could be
> > organized.
> >=20
> > In your driver, you could then use counter_push_event() whenever you get
> > an event triggered. In userspace, your application will add Counter
> > watches for the CAPx registers they want. When an event triggers,
> > userspace can then received all four CAP register values at the same
> > time via the respective /dev/counterX character device node.
> >=20
> > Would this design work for your needs?
>=20
> Yes, that would work for my needs.
> The "how" is not fully clear to me yet, since I never used counter
> subsystem. But the
> best way to understand better how it works is probably to start working w=
ith
> it. :-)
> So, next patch version will be based on counter subsystem.

The Counter subsystem is relatively nascent so the number of existing
Counter device drivers to study is unfortunately sparse. If you
encounter any trouble along the way as you work on this, please don't
hestitate to reach out and I'll be happy to answer any questions you may
have. That said, here are some more hints that can help guide you. :-)

Although we've been using CAPx to refer to these registers, in the
context of sysfs it'll be better to call the attributes "capture1",
"capture2", etc.; that will make their use as capture buffers more
obvious. Furthermore, despite my previous example, I think it's better
to have these exist underneath the CTR hierarchy rather than Mod4
because they are captures of the CTR value:

* CTR: /sys/bus/counter/devices/counterX/count0/count
* CAP1: /sys/bus/counter/devices/counterX/count0/capture1
* CAP2: /sys/bus/counter/devices/counterX/count0/capture2
* CAP3: /sys/bus/counter/devices/counterX/count0/capture3
* CAP4: /sys/bus/counter/devices/counterX/count0/capture4

In your device driver, you would define a struct counter_count to
represent CTR. In this struct counter_count there is an "ext" member
where you provide an array of struct count_comp. Each CAPx will have a
corresponding struct count_comp; it'll look something like this::

        static struct counter_comp ctr_count_ext[] =3D {
                COUNTER_COMP_COUNT_U64("capture1", cap1_read, NULL),
                COUNTER_COMP_COUNT_U64("capture2", cap2_read, NULL),
                COUNTER_COMP_COUNT_U64("capture3", cap3_read, NULL),
                COUNTER_COMP_COUNT_U64("capture4", cap4_read, NULL),
        };

As you already know, counter_push_event() lets you push Counter events
in your interrupt handler. I recommend introducing a new event type
under enum counter_event_type in the include/uapi/linux/counter.h header
file; something like COUNTER_EVENT_CAPTURE should be descriptive enough.

The "channel" member of struct counter_watch refers to Counter event
channels; The purpose here is to allow us to support concurrent events
of the same type (e.g. two COUNTER_EVENT_OVERFLOW but for different
Counts). If I understand the TI ECAP device correctly, we'll be getting
a COUNTER_EVENT_CAPTURE event whenever a CAPx register is updated with a
new capture. It's up to you if you want to group them under the same
channel or separate channels for each CAPx; you would just pass the
channel in counter_push_event() to indicate which COUNTER_EVENT_CAPTURE
event is being handled.

Finally, you can take a look at tools/counter/counter_example.c as an
example userspace application. The interesting bits for you are
COUNTER_ADD_WATCH_IOCTL/COUNTER_ENABLE_EVENTS_IOCTL ioctl calls and
reading the event data out of the queue. You will need to first define
an array of struct counter_watch indicating that you want to watch the
"capture" attributes of the CTR count; something like this (assuming
event channel 0)::

        /* assuming capture attributes are under the count0 directory */
        #define CAPTURE_WATCH(_id, _channel) \
        { \
                .component.type =3D COUNTER_COMPONENT_EXTENSION, \
                .component.scope =3D COUNTER_SCOPE_COUNT, \
                .component.parent =3D 0, \
                .component.id =3D _id, \
                .event =3D COUNTER_EVENT_CAPTURE, \
                .channel =3D _channel, \
        }
        /* get id from respective "captureX_component_id" attributes */
        static struct counter_watch watches[4] =3D {
                CAPTURE_WATCH(42, 0),
                CAPTURE_WATCH(43, 0),
                CAPTURE_WATCH(44, 0),
                CAPTURE_WATCH(45, 0),
        };

Later you add the watches, enable events, and finally read the event
data as it arrives::

	struct counter_event event_data[4];
       =20
        ioctl(fd, COUNTER_ADD_WATCH_IOCTL, &watches[0]);
        ioctl(fd, COUNTER_ADD_WATCH_IOCTL, &watches[1]);
        ioctl(fd, COUNTER_ADD_WATCH_IOCTL, &watches[2]);
        ioctl(fd, COUNTER_ADD_WATCH_IOCTL, &watches[3]);
	ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
       =20
	for (;;) {
	        read(fd, event_data, sizeof(event_data));
		printf("cap1: %llu", event_data[0].value);
		printf("cap2: %llu", event_data[1].value);
		printf("cap3: %llu", event_data[2].value);
		printf("cap4: %llu", event_data[3].value);
	}

If you want to keep track of channel, you can take a look under the
event_data[i].watch.channel member.

William Breathitt Gray

--6X5vf6Fz1F42Rx02
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYvE3mwAKCRC1SFbKvhIj
K/WxAP0RwkJd1BCye6EEjgg5pbBwk0uqoySGkHk/jt05NIx7nQD9Hl45FUL/NSy1
vPrsUe9n5lcrJ4pR8w+USLnvPkCfJQ8=
=Swu5
-----END PGP SIGNATURE-----

--6X5vf6Fz1F42Rx02--
