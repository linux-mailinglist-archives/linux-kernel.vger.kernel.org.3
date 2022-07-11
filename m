Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8DA56D709
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiGKHts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiGKHtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:49:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022FA167D7;
        Mon, 11 Jul 2022 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657525776;
        bh=X8TyN9CyILknghhxouhGz5KDBpMuUPkomyRmVP6/WJQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ciFgp6FFpYmKHdsOciitwiLjRv9x7YktwFfuh5UWVTvq1CzT4eYHq6d7043zQY7Cj
         QoaKzXmpz7GYs5QEbYkBB4Z9nybNZUqYKdjaPpULhn27jW74MuM6dfhRXkYUhqk6aD
         B2+3DelqMhTZus1IOwd0Py8Nqq71qpeJYqwOOkNk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.101.2.47] ([185.104.136.29]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJmKh-1nqfx8429p-00KBVE; Mon, 11
 Jul 2022 09:49:36 +0200
Message-ID: <df7313597d2ac3212f10c05aa3d369728f030c86.camel@gmx.co.uk>
Subject: Re: input/i8042: Malfunctioning brightness keys on HP Elite
 Dragonfly G2
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     Hans de Goede <hdegoede@redhat.com>, dmitry.torokhov@gmail.com,
        tiwai@suse.de, markgross@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Mon, 11 Jul 2022 08:49:27 +0100
In-Reply-To: <8b893c42-e514-bcef-0513-070b3723cdcc@redhat.com>
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
         <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
         <8b893c42-e514-bcef-0513-070b3723cdcc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Provags-ID: V03:K1:VwGkmh3JaBEWCVMCW8dyte5COe3jDZpDWSZrT1/KhFIj1pj71LG
 KMYdeiAzn5grTZRJ0CcwVeFzlonTahgV+1Fnc4IqtuG7qAQ/Squc+M1lyP5k8c4MLQgOqEg
 AYW9fyt49xlzipdwla8Q3HlX+JleIAWJYAQgBwQTLEynIHtq9X7xE1JsPq4iIOTd2TkTmpi
 JAH+dsjlUMWgM6iD35gRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qkZG5VY/jvc=:3evydC3xMAcZQb3g3dkQwS
 /YTSc/PNcdiu3DeC0Mn8j4aY6SHeZqIyhF/IUs0uIwMqaugjyj8UkrI2sK5ipzVSYuOt8Tq2J
 1j6Oq6cCTjh2EPzJpX3AdE0DRoxTMXCUkb6ehc20zM9wvxExg0OVWXuLsFgnAXLQKT8rSEhT8
 ghVyPyADz/WbvFE3Z9SWY9l7da7L7wEzu6TLdQVeLbgSRTNyW2m0xFxPZsw7a50NjAfOBTXch
 JPufTW4H8XbmZjpdfR92eiAQ9J7NPO2k7lBkzi87156EuQndJfCVnITOfZ4TTB/c/2Vb7LHF4
 zm+PvH7ISDo2ENnNV189LlNICpXHLKyzRKzgvgELrMW3qNP83CFfCSdZtCrKT5lY/jkO/VZKR
 6oCV7WMCoH1Ujcn82gTDSOrFAUJoTFzrq2I7X8JgBt/DKQ2A7Veir2tg+EwU51vmlnfSoodjw
 kCbLLfoRuzwbjqHpoB5TzNcHFPpV3xU/+WfkvpGJshFrToUGwh4kJVsGhMxXSd0qpctZHBS7f
 LWvdSD/qEYe/5svIVgSuyz9uZJdriKIUmJds2T9m+J7Jz4hrcRczpkWKQ+MZmSWtizkaKaeBu
 50SZraeKvqZdd3SgfcNnu/mLA/BbAGRaM/Ny28D+GoNvKSIfes9vIgCT0Dqn+dSqHEVZ91kOd
 31daldwNCUiLCiWMYP4I3v0Eyouso5FZ7mJeReuZujc5Rf/YZ2Er4Xtjf+WYrU9+xwmH2gEPw
 yGwjPiOliOp8R92Y0eYWPlXUMWCRZ+ah2X/w4G/FwaE0Cxk0XavQXEGVTuZeyrzs4B0jQTnuf
 v+hB+Hk4w6J6akLdpFQAx2nQs2ve3L+BS36VW1eBypddc8xOCEZza0hfscHl4nY5lasGzej8U
 5f4PbZf3hnLiAIKycXeIo4QfRbGtpvgfTLmvr/Zn/2sKa4qdvBFEtDPSgBkAMh0WxfpPR15ff
 dpF4zDzUv7yQVdfHVQhrZbNuLxv14lM7lH2lZlW0z8gHx4k7FcWPEzhiNCzHzmnwNF5XEN3Rb
 bSALeodXVZH7ihWvRWfwYz7Kd88aJDzgLoTLePLqmHosDO6F1teFPW8+oTLrlmN0mhWVKQuT8
 Ye+VfqWoqXINbWgIPrcJswYZnUMh9LUN22u21rdk3NJn1lKzK0ZbqkWHw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Sat, 2022-07-09 at 16:56 +0200, Hans de Goede wrote:
> Hi,
>=20
> On 7/5/22 19:25, Alex Dewar wrote:
> > Friendly ping? =F0=9F=99=82
> >=20
> > I'm also CC'ing the x86 platform people into this, as I'm not sure
> > whether this problem is something more within their remit.
>=20
> Please test the atbkd device with "sudo evemu-record" or "sudo
> evtest"
> and if the brightness keys generate events there, write down the
> raw event codes (MSC events).

I tried this but unfortunately this doesn't seem to be the whole story.
If I press "decrease brightness" I get:
Event: time 1657525393.922727, -------------- SYN_REPORT ------------
Event: time 1657525397.043348, type 4 (EV_MSC), code 4 (MSC_SCAN),
value 81
Event: time 1657525397.043348, type 1 (EV_KEY), code 190 (KEY_F20),
value 1
Event: time 1657525397.043348, -------------- SYN_REPORT ------------
Event: time 1657525397.050384, type 4 (EV_MSC), code 4 (MSC_SCAN),
value 81
Event: time 1657525397.050384, type 1 (EV_KEY), code 190 (KEY_F20),
value 0

And if I press "increase brightness" I get:
Event: time 1657525397.050384, -------------- SYN_REPORT ------------
Event: time 1657525398.607184, type 4 (EV_MSC), code 4 (MSC_SCAN),
value 81
Event: time 1657525398.607184, type 1 (EV_KEY), code 190 (KEY_F20),
value 1
Event: time 1657525398.607184, -------------- SYN_REPORT ------------
Event: time 1657525398.614190, type 4 (EV_MSC), code 4 (MSC_SCAN),
value 81
Event: time 1657525398.614190, type 1 (EV_KEY), code 190 (KEY_F20),
value 0

There's no difference! And I also get the same thing if I press the
*actual* mute mic button =F0=9F=98=9E.

Any ideas?

Best,
Alex

