Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8638511297
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358886AbiD0HhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358872AbiD0HhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:37:10 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396748D6AC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:34:00 -0700 (PDT)
Date:   Wed, 27 Apr 2022 07:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1651044838;
        bh=piUpAc0wGe60Avq75CM5bLwVBo2lSgqrOZtXltVybnw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=p5TANCxWDN0iWpN28SVEjXN5FOsv0HnWN0jkP8EzNU7VQ3k4FHpfhTDHYZbusqW1I
         QSEKXWs3y3ROFkOIkVYN3/HBbZpgjUDRY8rwdWT0neQfuB+uPCIsuS1vNigmatzbIz
         ve5aIKNnBb8W1o0+592wRjya+EPvbTrCkWZoBLpD8+iXoLuPGfwZ5SfuNhnJVL6slm
         P9fQe+2kBAG61MPiQrIDCDJITmA55lmTjLOweohHWGmSU4zbeVPXcxnS4d+RQIFvvR
         74hNiU2XMxGgM06UAkHGux0MF9PbIBw5Nvr5hiCzHg9OaB9kRYxUKWd9P+5FESAJV1
         MQZJ6REW/w6JA==
To:     Antoine Tenart <atenart@kernel.org>
From:   Juerg Haefliger <juergh@protonmail.com>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Juerg Haefliger <juergh@protonmail.com>
Subject: Re: [PATCH] crypto: inside-secure - Add MODULE_FIRMWARE macros
Message-ID: <20220427093252.00d013c9@smeagol>
In-Reply-To: <165104455443.3327.8052402101857118285@kwain>
References: <20220427070349.388246-1-juergh@protonmail.com> <165104455443.3327.8052402101857118285@kwain>
Feedback-ID: 10260306:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_xJCHnbO4zpyNtxSqi4ebN97ZiN1dTAelSXPpKazELCM"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--b1_xJCHnbO4zpyNtxSqi4ebN97ZiN1dTAelSXPpKazELCM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Apr 2022 09:29:14 +0200
"Antoine Tenart" <atenart@kernel.org> wrote:

> Hello Juerg,
>
> Quoting Juerg Haefliger (2022-04-27 09:03:49)
> > +
> > +MODULE_FIRMWARE("inside-secure/eip197b/ifpp.bin");
> > +MODULE_FIRMWARE("inside-secure/eip197b/ipue.bin");
> > +MODULE_FIRMWARE("inside-secure/eip197d/ifpp.bin");
> > +MODULE_FIRMWARE("inside-secure/eip197d/ipue.bin");
> > +MODULE_FIRMWARE("inside-secure/eip197_minifw/ifpp.bin");
> > +MODULE_FIRMWARE("inside-secure/eip197_minifw/ipue.bin");
>
> There's also the old location when the EIP197b firmwares were at the
> root of the linux-firmware repo. The driver still supports it, so I
> guess those two should have a MODULE_FIRMWARE entry too.

Hi Antoine,

Yeah, I was wondering about that myself but wasn't sure if it should be add=
ed.
Will add it then and send a v2.

...Juerg


> Thanks,
> Antoine


--b1_xJCHnbO4zpyNtxSqi4ebN97ZiN1dTAelSXPpKazELCM
Content-Type: application/pgp-signature; name=attachment.sig
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=attachment.sig

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFJekJBRUJDZ0FkRmlFRWhaZlU5Nkl1
cHJ2aUxkZUxEOU9MQ1F1bVFyY0ZBbUpvOGFRQUNna1FEOU9MQ1F1bQ0KUXJlYm1BLzlHeDV5M2NG
V1Uvd3dsUXQrM3dQcUlXNndJWEV4UWxLdEdueVJiMEhka1gwakxBWXJna29OYldaTw0KbC9GdXZz
RVg5T0Qya3JWWUFEWElLSExFdVVVbnc1bHlGT3Vvd2UzalE0YWhYSGVJc3FPYmp2ZEpKQUh3OWd4
Yw0KeGpXYmpIRC9kQ0dtcmpaNjZUWHBzY0hhRmN4YnQvVXBxVjRLd1BiRzRoY0U4cFduV2ZSYis3
eG9Ib0NhaGg3ZA0KVVY2RVVBS0pZNWg0bFNsWG40T2ttWW9tRXlDT2RKbXM2bmluZDNTbXZWV1lw
TlZxU1diRmtQWTRqOFpIenVrTQ0KMXVXNHpaYityL01CaGprUTV5Q3VGbmYwcys5NnR5OVRBVnoz
VGdmdWwvUTl1bGlPTmJVenBoNHRrRm9MenRoeg0KOVpmT3RHODFHbnpjRGczL3E3b0pwRXYvUzNq
K1NxQ2FUUWRIVzJZSFBKSmMrbzFoQ3J4OFNYdUVhbDNHdHlueA0Kc1MzQkh0eUtEdUhrYmt4b1Qw
dXJtZkdDYW1HVDlEM21tOEptd0tXdy81aFlHSWwrdzFIZ3B5Qm92eno1Y0cveg0KL2gyN3l4bUli
YkVEdHFnZFVQVS9XcjNaL2s1cWZCQjFDZGE5L0g5dWx1Zmw2bzRUZ3RUdzl5d3k4QkQ2L3BuYw0K
V1VZSjdLRHJZU1pwZ3ZQRlR2Um40N3NhbHpBbmt2RHZ2a2krN0x5ZlV1dkJObVBLUEVhL2t4Ymlm
UW9tNW9ScA0KNUE0eHJhRm5OY2FhTDVaMmU1YzlKSDlwRzVGQWJsK1VmVmI2MkJKeGovMlEzVVBE
ZmVkSUtpa0J0WUNUc2VDTg0Kc1pySGZBMTN1QmRNaTM3R1VVRDZVNGE1dy94NFdXTHVBUENIZEhs
WVk5YlNYb0VObEE0PQ0KPVczZ04NCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0K

--b1_xJCHnbO4zpyNtxSqi4ebN97ZiN1dTAelSXPpKazELCM--

