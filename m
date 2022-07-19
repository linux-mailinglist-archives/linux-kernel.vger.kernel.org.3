Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43735797BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbiGSKex convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jul 2022 06:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiGSKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:34:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCB623FA28
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:34:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-153-WfVlpVyTM_qbYoROTtpk1A-1; Tue, 19 Jul 2022 11:34:46 +0100
X-MC-Unique: WfVlpVyTM_qbYoROTtpk1A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 19 Jul 2022 11:34:45 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 19 Jul 2022 11:34:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Brown' <broonie@kernel.org>
CC:     'Shengjiu Wang' <shengjiu.wang@nxp.com>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next 2/5] ASoC: fsl_asrc: force cast the asrc_format type
Thread-Topic: [PATCH -next 2/5] ASoC: fsl_asrc: force cast the asrc_format
 type
Thread-Index: AQHYm1RF9VBLG0gK5ky/ItlmeeUnS62FdfSA///0CICAABRvQA==
Date:   Tue, 19 Jul 2022 10:34:44 +0000
Message-ID: <20cfcc8e59a74166846cff028cd2c4e8@AcuMS.aculab.com>
References: <1658222864-25378-1-git-send-email-shengjiu.wang@nxp.com>
 <1658222864-25378-3-git-send-email-shengjiu.wang@nxp.com>
 <f2609401c8834e8bbe926200bfc87971@AcuMS.aculab.com>
 <YtaEpf6Cd7KH7wH4@sirena.org.uk>
In-Reply-To: <YtaEpf6Cd7KH7wH4@sirena.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown
> Sent: 19 July 2022 11:17
> 
> On Tue, Jul 19, 2022 at 10:01:54AM +0000, David Laight wrote:
> > From: Shengjiu Wang
> 
> > > -	ret = of_property_read_u32(np, "fsl,asrc-format", &asrc->asrc_format);
> > > +	ret = of_property_read_u32(np, "fsl,asrc-format", (u32 *)&asrc->asrc_format);
> 
> > Ugg, you really shouldn't need to do that.
> > It means that something is badly wrong somewhere.
> > Casting pointers to integer types is just asking for a bug.
> 
> That's casting one pointer type to another pointer type.

It is casting the address of some type to a 'u32 *'.
This will then be dereferenced by the called function.
So the original type better be 32 bits.

I'm also guessing that sparse was complaining about endianness?
It isn't at all clear that these casts actually fix it.

(Mark: You'll be glad to hear that the office aircon is
broken again - two weeks lead time on the spare part.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

