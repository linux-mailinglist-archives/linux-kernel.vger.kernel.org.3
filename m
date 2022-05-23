Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46C6531018
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiEWMnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiEWMnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:43:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2054.outbound.protection.outlook.com [40.92.107.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9205C50E32;
        Mon, 23 May 2022 05:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYcwIDVWVFUJRHE0fG7NvDFkaQoANWTtLzQunOjW2tHh+Rkn8eZqEpU5Ln1XJi+Fd1hWtWlZn4CikLhCeuBIDjVbKdzRC5XF+zvYp55sRsBSd0Pujuy1nqnbjIttFdkUYGtu22aOiRBp4DfDhO23C+QNpuhT5+lwYw8mtfCOwCc0+vpPFM6sTLlH6i0IyHySmmQ9Kqaa2CgpZpfejaxb+0wtvQ9nJv69TZ0sBUnUTw/ejKmrzonz0a6NL1qLl+hOkiZyoOJBKVjQimhPFP4otcqiOIkEKs3rfIBrt9dKHFcEtKPYzyNClEKC/8DDzZ4i+P6qirc0qJhnI8lYk4aP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G09Bp/zfflsXo4dEpBYIOw7hab95TLwL5QUyis5+1Jc=;
 b=PYBJPmklffjjFk4VAtGQOneSAfvC9ebo0E/cdtLIJGztBKq4ToVS9MhCKUc7zaJT4nMOmy5Yxgjyb9LJf4UD62TucfWpr197jZahPjc2pMXhm+J4phEBmROfHfzaWWR58GfQsnWlK4YDW+exb+V5mbXtVU/DfjGoMJZC9D0mA1M42/1Lj0QerOREjXaKjACUJzkWZBrLpeDOX8ohpHG39Wf81Jf5B7IvJHx9/Goilm+Lm0DFKPpoVEbP33LT1/5GpbNl8jvx91rGBeR00ANJ76Z2N7zpBtbcUdD1VZMWC6ypi5QZgFsMbx/yuxy6jfP/XbwHLWmmGUUg7yT4eSHXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G09Bp/zfflsXo4dEpBYIOw7hab95TLwL5QUyis5+1Jc=;
 b=SQrghsSagLysv5PPlMPBDkOJcXYMCu9rQG6cg37kGnc/IPhVtuVVSZKHDn8xDmWsuNqzSWPGj3vPiFqRwQ9myGwkFKxkagWHw9UiM14dvgMl/JdifW1inA7itjvYMuavgaeZDMesA05tdIuL1vcICLLe+FEwbIDmOgD/aMYuYMMH0eU4N7/k+sLU+9SN0M8cT7kHTRWV4zj6MWmi81Eb9pzvXStU9rzD/0EbvlukVl6ku5jahsB0gWHWthpyybhyFw/dMS3IJiLtwRr/k/0azPb8Cfvh5iBDtfM/b/kjQs2IsN/nAugDAjQ5kqT/oT3LR4JgLcSKyga79w5ja8mN9g==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by SG2PR01MB2013.apcprd01.prod.exchangelabs.com
 (2603:1096:3:1c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 12:43:38 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 12:43:36 +0000
Message-ID: <HK0PR01MB28018563577A29D4FE074964F8D49@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Subject: Re: [PATCH] USB / dwc3: remove the use of -ENOSYS from core.c
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 18:13:25 +0530
In-Reply-To: <YodQRpxKA55g5Mt+@kroah.com>
References: <HK0PR01MB280106E1D78EF51A5B8ED8BFF8CE9@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
         <YoZpcqDCwoXIvI5q@kroah.com>
         <HK0PR01MB2801E9A6A53F346BC3436845F8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
         <YodQRpxKA55g5Mt+@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
X-TMN:  [scQ/4GRYEUTA/BfLb6HTVOC0+36bSr+WYtAkzP9rmJ52e2JF3pPlp8ksHnQvoi3U7mh9JbVcJSA=]
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To HK0PR01MB2801.apcprd01.prod.exchangelabs.com (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <46f90c2aa3aad5d5fa80b00015d6f4b583753c0d.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74af2da6-e3c9-4238-25c3-08da3cb9d8b7
X-MS-TrafficTypeDiagnostic: SG2PR01MB2013:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfR9j5pw/QqauiFh/cr1xPnhpiALayth3owE8C457Ui+JSgOmicttIdegxJmMecNj/dAsc3MzbCet3PbleviZYVfEWEdhU87K8b/LBe8fo2BdhC/G3wcYgxb+jvCxKpTyyRp5yxMjuCF1oGbX4cu7kAJ3ejp5Qhv/SZvtJCjIsyyjIXGFJSORW8LDbgVnXaOCbLHjwTWd/klaxCcooRIZl+2x4cuzic0fHnXMaA2cRh7qxNRynJFOueDWGadB/pQ8Sqx3DV0MNgbhIzmkI3Zr6r3LQGUmhws6Uj1V8vYuMsCehoJTfw6kdQCMaL3ux3NF73zl3RIJDnGDJp4aUQWXlpWVuI2Xcyu4bnzfeHRShRBGDFG9BH6xAeqEIRWetqhij1meiqcjY9+CeqC2qPoVPoExdnjj13rtN0TnsaKTgYAhNYqmz3qz9BrGtJ0hrmx/QqrR66ZfTrjJr53jNvpTqO5DHRFuTnZOUCYWcFYlAwWbi6xiP6y1wSiiPRffx/NUaaTvTHPPNuqxID33/eG9zp6bVTxJL2NdUabs8VqUI5qmPiH6ZTNkb4s7gND9iw2yIU6WYqT+KKZhcoRRucFYw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZHamhXVHp6KzBIMVBNdVhnS1VOQnAxOWdYcFBWUVBHcEtDNmpNWE5Cc0M2?=
 =?utf-8?B?S3JiNmtkRkI0MDkxcmlSVCtJZUdmeUowTlJRdTQvSFhNb0NXdHljSDhhbllv?=
 =?utf-8?B?WXJNRXd1UkhzWmM1UVlaY3pkd0x0N0x2aWZBbzdkK3AydDhKYlY0OWJVa0NJ?=
 =?utf-8?B?dy9XeUlDbWVKMGM0ek1wM0dHKzRQYkRsSklZUjFGaDBkMzRxNVZQdmNkdVNw?=
 =?utf-8?B?MFl4eWE2d0Q4RjVNazJ1aWpmTFdoNTRGeVdMNGFIY2lLNFM3OW1lRjBGVzFw?=
 =?utf-8?B?STdud3JzdEpXbzZOMXVBL2o2cUJMVkNoanloU0pQYTh6MjZGZXJ4RzEvZmVs?=
 =?utf-8?B?Z1A1SXdxaHMySGQ1eFIrN1k0ay8xWEFtT09ueTVJOHpka25lSUlQNEFxZnhU?=
 =?utf-8?B?aGdvZFRLVlNYSk5ZdHRqWW9hcFV0RWtnK2ZRT3VlUGt3Q3ZtVjlJWEY4ZTEw?=
 =?utf-8?B?dWtIRDBSeFFiUm5KVFhnemRNSkQ0bmhDc0tBdW5ZZ2NqdHNsdS8xcGxiNDZy?=
 =?utf-8?B?R3BFKzFjTmZ6SzR1eDBIVHRKZTVwRExCejY4dHZ2UnJ1MWdabXRxeFZxcEJN?=
 =?utf-8?B?NnYySW9rcUtId2lKZnA5SGg4VFJjNzJDQXgrL0g0ck9QWlpuWnZtZW5DNytL?=
 =?utf-8?B?czNKZzZwbGEwQkRwSSt2bGxhRVhPNGlheEx4Kyt5aFlRNDdUTWNmK2JoV0JL?=
 =?utf-8?B?Smg5YzBZUnN1Vm00NWl0S0dVbVRRQU5uMVpkbWFuNVZJdDRaVStsd2pscGRo?=
 =?utf-8?B?Y3NOd280RW90ZWdMdDFoUWErTG0xTWZBUzhFS0hiL1RFNUs5SUxJWkV4aDNQ?=
 =?utf-8?B?U2J3b1I3N1k0S2JOSkcyeFJ0QWpLb3FEOUhRUUQ0OVNac2FWazRuSjg3bGY3?=
 =?utf-8?B?K25hTHdPcXRBTjFwNDBjd0U0dUtjN01WMEtDb0VybkpnbG9IOHVhdHNJNmE1?=
 =?utf-8?B?ZmFqSTJodjJIeU1oNHV4MTVseng1STRGUlBRVlVwYm5Sa2NjNWZnNjNuanB0?=
 =?utf-8?B?SHBmeWtGNG0vbHRLSjNGZk1qTGdhbzJEejJ3TjR0SVJDamRIWEpUdFdmTTcy?=
 =?utf-8?B?T1lISWVYQmxadDR4K1lJd05uSXovWk9aVzhoWms4RzRaMHl1dXlrZVh3VjQ4?=
 =?utf-8?B?NzhtaUcyYjJ1Vk5RdTNqWTdSSFVVTDlkOWpNNDhoZHp3cm5YOExaME1xaTlK?=
 =?utf-8?B?RnZRZzhDOXFVZWQwMWZXc05ua0xKWUlpSjNGOUVSZ1l1VWxOQ21xa0hyYWFX?=
 =?utf-8?B?Yy9OT09qMXF4dnhiMndpckZ4VWtjQloxQ1hqbVJvZ3h2SHBtaG1YRU9zNXc0?=
 =?utf-8?B?Zy80bE5DN0dBMmhVYjlvaDAwSjZZcFduM2JwRnZYU3ZGTEN1anVXQmw0YlNI?=
 =?utf-8?B?VWk0cjZmVWhPbGRzUzJYb3ZHcUNodjcvWGVrZHJOa1Jsb052dzA1R1Bqdkhx?=
 =?utf-8?B?Q3dtWHFqb1dHZHFQRkpvMWdDY2NlME9hekFiOW5ROFpRcUV6dW1ZMlRPbUE3?=
 =?utf-8?B?bWxEdzhTUXpXVENXT2dMVldvL2VtdE44bWRkTENwY3lFZGNkLzd2NXJMWXg5?=
 =?utf-8?B?YTduS1lQdDdRZlFCNVBXZ2JQT3NjeDRYeE1aQVV3UStYS0pwaU02WmgvYktK?=
 =?utf-8?B?ZzZpVlFtMnh4dmJ1NDQvcXVSVEZIL0FLay9ZWTJYWE1vanhxcGtLODRZY2hB?=
 =?utf-8?B?eCtOSy9RZ3NyaXBFVG5GeXBpdmlGWWI1UU5IWGQ4VUVsQ0t4RURhbGV0V0FV?=
 =?utf-8?B?Vk8xUFplWGdMUWdwMmUyS1VUNTBFanlvRVF4UjF6YzVXOXlJTWxsd00vLzlz?=
 =?utf-8?B?QUZUQWtiTWY4ZVVqOHdVekcxdm5ERzBpNkl5a1N1YTBJVml2NE9rVVpZUGda?=
 =?utf-8?B?SEdocER5TmNXSFNSUTVKdFhQSWxNbFpWNkZ3d0pCOG5ReXhZMDl4cWJvaUtt?=
 =?utf-8?B?eE1yeWplb0syb1RhbldMTW1aYm5XakdhZTFCd1BOTlFaVnZRMXpKYlZORUtx?=
 =?utf-8?B?cENxcFpPeXlJR25zaEh1dHNCNytDV0JJd2l1TCtQWmFnRUY4YkVIQW44V0Ja?=
 =?utf-8?Q?xulOlC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74af2da6-e3c9-4238-25c3-08da3cb9d8b7
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 12:43:35.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2013
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 10:24 +0200, Greg KH wrote:
> On Fri, May 20, 2022 at 12:16:29PM +0530, Kushagra Verma wrote:
> > On Thu, 2022-05-19 at 17:59 +0200, Greg KH wrote:
> > > On Tue, May 17, 2022 at 08:22:00PM +0530, Kushagra Verma wrote:
> > > > This patch removes the use of -ENOSYS as it is used when users try
> > > > to call a
> > > > syscall that doesn't exist. So, we don't need to check if 'ret =3D=
=3D -
> > > > ENOSYS'.
> > >=20
> > > ENOSYS is also used internally in the kernel for other things.
> > >=20
> > > >=20
> > > > Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
> > > > ---
> > > > =C2=A0drivers/usb/dwc3/core.c | 4 ++--
> > > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index c78205c5e19f..3c1a877d5183 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -1283,7 +1283,7 @@ static int dwc3_core_get_phy(struct dwc3
> > > > *dwc)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dwc->usb2_generic_p=
hy =3D devm_phy_get(dev, "usb2-phy");
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(dwc->usb=
2_generic_phy)) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D PTR_ERR(dwc->usb2_generic_phy);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D -ENOSYS || ret =3D=3D -ENODEV)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D -ENODEV)
> > >=20
> > > Did you validate that no callers can ever set this to ENOSYS?
> > Yes, I think no callers should ever set ret to ENOSYS unless it comes u=
nder the other things ENOSYS is used for.
>=20
> Please audit the code to verify this and document it in the changelog
> text when you resend this.
I have audited the code and none of the callers return -ENOSYS. The devm_ph=
y_get function calls phy_get to
lookup and obtain a reference to a phy. This function returns the phy drive=
r or -ENODEV if there is no such
phy (according to the comments above it).
>=20
> > > Why was this added in the first place?=C2=A0 What commit added it?
> > This was added by commit 57303488cd37d ("usb: dwc3: adapt dwc3 core to =
use Generic PHY Framework").
>=20
> Great, please also include that information.
Ok.
>=20
> thanks,
>=20
> greg k-h

Thanks,

Kushagra
