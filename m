Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD054D6D8C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 09:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiCLI2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 03:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiCLI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:28:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B91BD059;
        Sat, 12 Mar 2022 00:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647073591;
        bh=PzOAE5rXR+jIsiQ5R3ZR6h3y+9g+I2HOnQam+rWR1ow=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=JKbUtuisOiDU63bEHeVHPU9udH2LIL+zhJe4AI3xGdDR8BGNJHnYnk5xI9Wkw9Avs
         wFlMq2asg8voxb1a1MJ5JQIB83e7gE8WesvQXw7sH0v1sReZlOHHIAW3jCp+X1i3z1
         gjTEbrq/5YH1jV6zCSkoaSuHIJcLMkki6SUfm960=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([157.180.227.225]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1oIiqx152y-00s8vb; Sat, 12
 Mar 2022 09:26:31 +0100
Date:   Sat, 12 Mar 2022 09:26:22 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <05309a59-85cd-2434-6435-6fd956fa75d6@opensource.wdc.com>
References: <20220311210357.222830-1-linux@fw-web.de> <05309a59-85cd-2434-6435-6fd956fa75d6@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/6] Add sata nodes to rk356x
Reply-to: frank-w@public-files.de
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <8CEEC721-CA8F-41C9-8EB4-DBBB7CB0726F@public-files.de>
X-Provags-ID: V03:K1:kn5t/XFc+F6nThuScJ4bfueIMNUqBrgI3e1gtB3B/iZp1moNrVq
 I7MfyYsM9m+p1RWSJnqlAuesYb/H3Q+Mc8mMDEW00DHrnAMJUle3qGGIeDwXXdoTl6TGcEu
 Ct8LGLn7WJfV8bJakNHZWZddM+az4X7kYZ9q9OwPDH6LVx47OrqXiJtrpXwAQC2XLuwc4GH
 iwMOhZbtih402k4K3/5ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SeXzE6ppK/U=:q+9ZYBG+jx9Jo2XXHol5R+
 OtNZOsKQMXfidpgp3V7YyWjwWjSembGr/Y8800nhZ8FDuRaqQUQQI32BkBg4W3sBW/69V8EHD
 fzEuMD0YqhkEQKXLBUOxlJ53zD5dCsrh9TljZ0w0YY4ZUfmvkQFDebjQGYbaHIS3EMTs9MDH/
 3ecWzcjfdLJ1/XhM+Jrr6o7zdreWy2e6GJPz5CGoN1Aa0MQgod5aP4F3K6KBAcisTwzd77HMK
 NYyWpt9y8g/OG04ldFUbmsCbn+VS4K3ZGyYVArjxBwxLZQnPMCzjdSHn1adE95jcLdIiW9xtk
 P9x8VEXk38L0PndNgNsHQzTDreJQCUmX3Jj51ItlKNt3Fk0PBwTg7+0JBay+YpPGBPiPkJRP0
 kar63jBF02niFSER43zXsJD9gnXSn4mMpiVQ6aj6GGzWcx2IahqmFSKYe1PMZXsOK7c1mxNRo
 seDmDB0E3hJ7QtQRbUakdkuK/ONS1hGaMFK0lii77J26FmpesG0d5Gf/txFn92RFedXwmGUJU
 ZDGQaSsLjlDNCvhPJwnRjnUeZ+StxsFxqiZ6yAfwwjFqaDwXI5GRMPlAAmEvLRGwnkpGc1Bn1
 BsY+jPPRTYYIt8/PXQg+nnGnc7nXhCvZ4BO1Kn8jcbhDZ+lOvs/Umx/PpfkdV7YUDQuNKUz/4
 1O6Vzb7EBvl5q0iQplYbPTSimmb+33Gok8giMUZxmYFztIn+JzO+Zwke4iOR/VkjXDjxz0d0D
 u5xSCFJXpI8KZ2mCRxftXLgFZH14RjfEeQVN0rl0YUViBshRDyGcgjzxQc0nPmCzuzbtSe3rn
 +r/dtSOZzTc/8kDYNfe1sAd60D4CHC37QD7vxGZunFLSALIijxDmexL5Bm0hItLFYCK5ORxaD
 UHHEyiWi3BYF+KXhYaJAfbcOb7nrz/Vyuyl+6qDNQndVh/3yR5rQ6aYNNUZsWQMbTLRVhli1O
 U6yhsm4kmwXTF2OUoMYjEWCH2CezLY8Zdi9nyQyWiuLm86YbpFB2qgsMypL2HzCksli2Rgop0
 iGq+IkjG7c11ibFMjdGHWi5dHWAtKUeFbMoLhbTfhGV+0rx66UjS/dsV9EafHVRs5HKqg4wGR
 QR9C4zyXoh9044=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

Am 12=2E M=C3=A4rz 2022 09:00:53 MEZ schrieb Damien Le Moal <damien=2Elemo=
al@opensource=2Ewdc=2Ecom>:
>On 3/12/22 06:03, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> This Series converts the binding for ahci-platform to yaml and adds
>> sata nodes to rockchip rk356x device trees=2E
>
>Rob,
>
>I saw you took patches 1, 4 and 5=2E What about the others ? Are you
>taking them or should I take them through the ATA tree ?

Imho the dts "fixes" should be tested by someone having such board or at l=
east be reviewed=2E

I only fixed the binding warnings,but i'm not sure it breaks hardware as i=
 cannot test function=2E

Afaik last part should go through Heikos tree=2E

regards Frank
