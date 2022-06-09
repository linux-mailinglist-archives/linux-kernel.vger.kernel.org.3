Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADD5446BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiFII53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiFII4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:56:49 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E2B14AA50
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:56:17 -0700 (PDT)
Date:   Thu, 09 Jun 2022 08:56:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail3; t=1654764975; x=1655024175;
        bh=0fGVsCOsJ783x4T1usRFr8i+QZzgtmK7SsF2ZzEkCqM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=G46JYp0go5QwvIJ0K9+zx1ct3gJsf+sUOOHXsGc6Gz03a1zVTwxHUA8VJ3IPopPqQ
         DzQxx40+iMLv1EzAI1nsXawAK0oMQN8u+nMMzJccbQDf69zL//Q7+GbzRE4T8w8guz
         lRVZxYcjR88U/fy3d09mhftdMBz9Oz+r5/3Dy6so28Pgjwc+EMuJt+GbjVtTEPyLSg
         GSF3gYAA/9IrRTMefyke3veBaX64H75WXG8GiMTf9pDDsB9YeE25ZQuKNvd6Qd/Lbf
         gxlBm5ON82OTMjwBHvfPjVBmvh9UoIK86XKuwUFvXx7kzP6N3GWZ2RD9nANCX+FM7Z
         Sp4WS+HHEFhog==
To:     Marcel Holtmann <marcel@holtmann.org>
From:   Juerg Haefliger <juergh@proton.me>
Cc:     Juerg Haefliger <juergh@protonmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Reply-To: Juerg Haefliger <juergh@proton.me>
Subject: Re: [PATCH RESEND] Bluetooth: ath3k: Add MODULE_FIRMWARE for patch and config files
Message-ID: <20220609104941.46bda87f@smeagol>
In-Reply-To: <20220505080744.0343a857@smeagol>
References: <20220504074606.15505-1-juergh@protonmail.com> <6A323366-2AB3-443E-A605-C18EA7A2E161@holtmann.org> <20220505080744.0343a857@smeagol>
Feedback-ID: 45149698:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_X5QaQZmVeY2aDI7edktz7aPJvWCC92D1dICoI1MbEM"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--b1_X5QaQZmVeY2aDI7edktz7aPJvWCC92D1dICoI1MbEM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 May 2022 06:07:52 +0000
"Juerg Haefliger" <juergh@protonmail.com> wrote:

> Hi Marcel,
>
>
> > Hi Juerg,
> >
> > > The ath3k driver loads patch and configuration files so add MODULE_FI=
RMWARE
> > > macros to povide that information via modinfo.
> > >
> > > Signed-off-by: Juerg Haefliger <juergh@protonmail.com>
> > > ---
> > > RESEND:
> > >  Resend from protonmail email account to please the test bot.
> > > ---
> > > drivers/bluetooth/ath3k.c | 2 ++
> > > 1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> > > index 88262d3a9392..56e9a64177ae 100644
> > > --- a/drivers/bluetooth/ath3k.c
> > > +++ b/drivers/bluetooth/ath3k.c
> > > @@ -538,3 +538,5 @@ MODULE_DESCRIPTION("Atheros AR30xx firmware drive=
r");
> > > MODULE_VERSION(VERSION);
> > > MODULE_LICENSE("GPL");
> > > MODULE_FIRMWARE(ATH3K_FIRMWARE);
> > > +MODULE_FIRMWARE("ar3k/AthrBT_0x*.dfu");
> > > +MODULE_FIRMWARE("ar3k/ramps_0x*_*.dfu");
> >
> > I am still not convinced by the glob file matching. How would that actu=
ally work?
>
> In my case I need to remove firmware blobs that the kernel doesn't need t=
o
> reduce disk usage. This information helps. While it might retain unneeded
> versions it's still better than nothing.

Ping. So what do you suggest? Hard-code all filenames based on what's
currently in linux-firmware? Given the HW is quite old that might not chang=
e
very often...

...Juerg

>
> ...Juerg
>
>
> > Regards
> >
> > Marcel
> >
>


--b1_X5QaQZmVeY2aDI7edktz7aPJvWCC92D1dICoI1MbEM
Content-Type: application/pgp-signature; name=attachment.sig
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=attachment.sig

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFJekJBRUJDZ0FkRmlFRWhaZlU5Nkl1
cHJ2aUxkZUxEOU9MQ1F1bVFyY0ZBbUtodFowQUNna1FEOU9MQ1F1bQ0KUXJjNHZCQUFnVDI2bXpE
TnYwL0FXRzMyTElXdnBGZ3BtUEhKMVdmT0kyRFJDbVd0ZGJDTk0yMFVCNnRMc1VYRQ0KU1VhSExt
VC96QlFTMzdaNStId2VPc3J0SXJGbVhQbmxuTTVDVnhWNHhQVGFnaURndGNaNm51QTFSUDB0S29v
Yg0KK0N5Q2lDb0VNMWFTY3VCREJVbnVsWjU3YSt0R3VERTN5cUZxdkdodWNneENHYTZUTHpBKytz
ZEkxQkx2Z0ZYeg0KZGU1OGE0UW5ET1Z4ZXh6YzZJMlhjRFB6UDQ2N0FDSGZlR2xMSEZTaUNWYmh3
N3BVNGt0SjBVbkswaGcyZDZuQg0KQUgvVHhwTm42WWU1SWRJNVpmVHYyYllheVZLaGZCOGUzYWRF
a2drblNwYS90UWJOaE51cEUyblhzcjdPUlBhMw0KWnhQZE1zOVFERlZZbEYwelNQci9DNzdBT1Z2
T3ZkUTdDNUpBN204bXc1eStYano4TWJweHdRUEJFZURXOUZqRQ0Kb3RqemQyM2NIaEptTkM3eU1O
bWJpUzZXdmsrMThkWWtZZ1BMSGhVVHlaUUJaMnFXcmovdU1KKyt1S3NMT0hZdA0KOTV3NVpMV0hs
dFdnMTlsOENObEI1RWFEbEJqOTZjSkRaNmU2M3BJQ1owT3Ria0w5bUVTRGhOTk5zNnJDbHdMeA0K
azEvMnhlQWVnOE5ISmtXL2lTUzJMcjhWemRlZ3o1SXpNclNocUhqSkFpbFl0STY0Vys2WkVpQ1dD
RGRlQWQ5Zg0KVCtNLzVZZW9xd1h5RkNWT096TFJFaVJuVGV3TExNdTNQSXQrSVZiTzdFNmRWZHNT
aVNYOGQ0YjZROFhmT0V2dg0KQXgwYUYwN2s4U3o4S1NVKzZFRDVqRXNGYnYrRHVqQm1hVStoSFQw
MEl5L0RJVzNBZGlrPQ0KPWhveW8NCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0K

--b1_X5QaQZmVeY2aDI7edktz7aPJvWCC92D1dICoI1MbEM--

