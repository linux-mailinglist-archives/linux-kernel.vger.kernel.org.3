Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623EF4CFCE6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbiCGLa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbiCGLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:30:32 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7857E586;
        Mon,  7 Mar 2022 03:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646651750;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=hktw6t1krlzOZcT2H0EHEcrlvvIfvEU5uMHbwsbvvjQ=;
    b=cJCDiuY8NXjLPyI0EaX0lkTFKxaV2gS5SD50GaI5rxjmN5hKMBr8ViHi6GizO+xjCt
    ZnmtxdSXeu9RH3mylwfq6LzSbGCneHnJLNnUVAl8mIfXF1PovCBSFzdzwzQ2LP0eBj2u
    X8wlyGiPaHS1XjGJp5lzY5fiv4BRUINQI0d7R8uMY0YVLDdghzn1efCIQsCzNeB1hzic
    QXpkuzW/BA9k7Mu7IH0+7xBYfXQ13GzVQHHk2GAPmQvccrxWu8k1J7Nrd8S0VCjJCDOH
    cmp9h0HRH8IWYITOs2O92ev9Bxni1/p2cWj1KJu6kW8vDt1ZYxQujjv6SPVxFjH7JjNn
    GX8Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw43pw1w="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id n729cey27BFoJ4I
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 7 Mar 2022 12:15:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v6 14/48] mfd: ti_am335x_tscadc: Don't search the tree for
 our clock
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20220307121033.5630fee7@xps13>
Date:   Mon, 7 Mar 2022 12:15:49 +0100
Cc:     Tony Lindgren <tony@atomide.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <62BABFD2-3B63-40B7-AA49-A4824C5DD46F@goldelico.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
 <20211015081506.933180-15-miquel.raynal@bootlin.com>
 <7336E356-57E3-4BC5-B098-0A791C2CB360@goldelico.com>
 <20220307121033.5630fee7@xps13>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

> Am 07.03.2022 um 12:10 schrieb Miquel Raynal =
<miquel.raynal@bootlin.com>:
>=20
> Hi Nikolaus,
>=20
> hns@goldelico.com wrote on Fri, 4 Mar 2022 23:38:25 +0100:
>=20
>> Hi Miquel,
>> I recently found that our BeagleBoneBlack with external touch screen =
stopped
>> to find it.
>>=20
>> A git bisect revealed this patch (merged into v5.16-rc1) as the first =
bad:
>>=20
>>> Am 15.10.2021 um 10:14 schrieb Miquel Raynal =
<miquel.raynal@bootlin.com>:
>>>=20
>>> There is a single clock available in our node, which is named
>>> "fck". The clock handler then points to adc_tsc_fck but no need to =
point
>>> directly to it and do a full tree search.
>>>=20
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> ---
>>> drivers/mfd/ti_am335x_tscadc.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/mfd/ti_am335x_tscadc.c =
b/drivers/mfd/ti_am335x_tscadc.c
>>> index e2c4416f192d..8af44c08d925 100644
>>> --- a/drivers/mfd/ti_am335x_tscadc.c
>>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>>> @@ -206,7 +206,7 @@ static	int ti_tscadc_probe(struct =
platform_device *pdev)
>>> 	 * This frequency is valid since TSC_ADC_SS controller design
>>> 	 * assumes the OCP clock is at least 6x faster than the ADC =
clock.
>>> 	 */
>>> -	clk =3D devm_clk_get(&pdev->dev, "adc_tsc_fck");
>>> +	clk =3D devm_clk_get(&pdev->dev, NULL);
>>> 	if (IS_ERR(clk)) {
>>> 		dev_err(&pdev->dev, "failed to get TSC fck\n");
>>> 		err =3D PTR_ERR(clk);
>>> --=20
>>> 2.27.0
>>>=20
>>=20
>> While I understand the reasons for this change there seems to be =
something
>> missing now in the device tree because the clock isn't found any =
more.
>>=20
>> After knowing about the problem I could also locate the log entry:
>>=20
>> [    4.456680] ti_am3359-tscadc 44e0d000.tscadc: failed to get TSC =
fck
>>=20
>> Reverting your patch makes it work again.
>=20
> Sorry for the wrong behavior on your side and thanks for the
> investigation.
>=20
>> Is there missing a change in the am335x-boneblack or am335x DTS?
>=20
> I've looked at the code and indeed the am33xx-clock.dtsi file defines
> the touchscreen clock, but unfortunately the am33xx-l4.dtsi file which
> defines the touchscreen node does not reference the clock. The =
bindings
> clearly require the clocks to be referenced but I believe this was not
> noticed until now because the clock exist and clk_get() did a lookup
> across the tree.

I had expected something like this.

>=20
> On my side I tested it with an am437x SoC which uses another base
> device tree, which properly references the touchscreen clock where =
it's
> needed.
>=20
> I will send a patch (untested), can you give it a try and report if it
> fixes your issue?

Yes, please.

BR and thanks,
Nikolaus

