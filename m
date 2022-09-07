Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3805B0516
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIGN1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIGN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:27:02 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBF878BFD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:26:58 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220907132652epoutp043ffae99b46b38505e0cabc177a0b561d~SlvnuPRyA1156211562epoutp04k
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:26:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220907132652epoutp043ffae99b46b38505e0cabc177a0b561d~SlvnuPRyA1156211562epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662557212;
        bh=+RiMUm1DRh8uWdpGnfbNgmdw1fBy5kFiKoPWMaL8sfY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JGbBDMX0QWLdGE+Z0II+0uZYbk6VLyX2zD2YN9ILFPxoj2jSDrIhHBTeMnqvFOtZN
         G6ZttUqT+Sbcje3Fs+di1qqHZbSw7xSR4h4DcIqBUPDkFotRGiONwVI6ImOoDlT6N/
         8/ECyycT/xxCbzZpnOgZfTSylwGxH6DwfxmHIVII=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220907132651epcas5p420447b118a4782c5b0fc506db6c59d7d~SlvnFMEWi2320623206epcas5p4V;
        Wed,  7 Sep 2022 13:26:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MN3211nhlz4x9Pr; Wed,  7 Sep
        2022 13:26:49 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.D7.53458.91C98136; Wed,  7 Sep 2022 22:26:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220907121647epcas5p2d35c37079e03f8bc248cee3bbb61b929~SkybQ5vnT0100601006epcas5p2B;
        Wed,  7 Sep 2022 12:16:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220907121647epsmtrp15f2c973ab7b35844b3a046bd57d43ad9~SkybN6evt1492014920epsmtrp1L;
        Wed,  7 Sep 2022 12:16:47 +0000 (GMT)
X-AuditID: b6c32a4a-caffb7000000d0d2-76-63189c1943d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.EC.14392.FAB88136; Wed,  7 Sep 2022 21:16:47 +0900 (KST)
Received: from smithat07 (unknown [107.122.12.13]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220907121643epsmtip2b4276c0c7453b84d50ab4f86943cbb09~SkyYFeXyj2686126861epsmtip24;
        Wed,  7 Sep 2022 12:16:43 +0000 (GMT)
From:   "Smitha T Murthy" <smitha.t@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <andi@etezian.org>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, <aakarsh.jain@samsung.com>
In-Reply-To: <783df4f0-0b7e-8604-d61f-f78e0375c321@linaro.org>
Subject: RE: [Patch v2 15/15] arm64: dts: fsd: Add MFC related DT enteries
Date:   Wed, 7 Sep 2022 17:46:42 +0530
Message-ID: <001601d8c2b3$b33e2ac0$19ba8040$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwYET59QqMDNmfP0SYfUTdtmHMHgExQ0QVAaYMvCgBZ+7aQq0CrI9A
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01TeUyTZxzO2369dLiPw/GWZNh8M1nAAK1CeUs5dhj2hW2BqDgjW1htvxRG
        r7Rlou5gOnAQD5gio+NQQWYYx2jLsQIbYBmTbAtmBdRxDhhrAeMsXoiylpaN/57f+zzP73rz
        Y9P9KlhB7EyVntKqJAqCuQlrvRYSEsYth1L+7ZMcNNtexkCTla1MVP1ojoYmqp0Y6jW1sJDZ
        9jUdfdPfzUBV1t8YqK3nTww1/+1ib5SNYWiuqhEgu2GcibrmXWLj9DADTTneQb9bypno1Hct
        DNRgHWOhKyM3aKjWuEJDl1uWWCivy8pCn+dbaa9Asr6yHpDtYzWAHKm5Rye/N4yxyOpOO400
        1hUwydHhTiZpqvmUzOtbxsgz5jpAPjtewSILrSNM0mkMJgfuO1kpWw5mxWZQEhml5VEqqVqW
        qZLHEW/uTX89PUrIF4QJRCia4KkkSiqO2P1WSlhipsK1BoL3oUSR7XpKkeh0RER8rFadrad4
        GWqdPo6gNDKFJlITrpModdkqebiK0scI+PydUS7h+1kZHXW1NE0RN2fhioWZC576FwIOG+KR
        cKn7B6wQbGL74R0ALn7xpTe4B+CPo4PAEzwAsODpIG3dsjr6l5foAtDx2UOvZQ7A1oUKplvF
        xMOhw1rNcBMBeB+Ak+Ypupug4yUY7BnmujEHj4fdIzbMjf3xJHhhaHVNg+Hb4U+tc2vYBxdB
        x8Q08GBfeL1sBvPk2QbbFsvpnpZ48PFsLcONA/BE2FxkZnk0gdDeZ2W5m4D4MAc6Lc8wj2E3
        vGAuAh7sDx39HgPEg6D9bL4Xy+GE84RXo4EVuWbv/Amw21buysN2FQiBTZYIz/OLsGSgkeap
        uwWefjLjlfvA9sp1TMDLv/zsTQ/h0GILowgQhg2jGTaMZtgwguH/ahcBVge4lEanlFO6KM1O
        FXX4vy+XqpVGsHYnoUntYGrybngvoLFBL4BsOhHgI2sPkPr5yCRHjlJadbo2W0HpekGUa9/F
        9KCtUrXr0FT6dEGkiB8pFAojRbuEAiLQ5/wOIPXD5RI9lUVRGkq77qOxOUG5tKv7DtT4RZ9K
        O5bxgM/fZTqYkGD/IDQieH6HfLjHF+L1hhMN0nF26pA470xyov3b3uSzOUuch7qZd53K1Y9X
        TEN9aW8f6Ij5JO35beJAVXCQomHvP9GlN48O3rI4q1TjH9kOyZbVJTG21CedHQPvnQq5mj+/
        rOx+LuCYOAe9fD31SEWPjC07nT9Yu2oQL7ex0yx6IY/EublNd223fVNXRvf00w7fqYl4NfbS
        dBMymvefO9e4L3dr4h+M5jCxOnvhZnFLsaS0/LzJ9NWd0hd+3UNtPh6c+NKjN7aL7idbZh8X
        VhpPqi8WOLgr4ZdeM21m6Kry9osP5dwSSeJFBbK0jMKkawSmy5AIQulaneRfWEv0UbAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZdlhJXnd9t0SywdRuLounO2ayWjyYt43N
        YvGP50wW9xd/ZrE4tHkru8WWK7OZLZYfP8BqMf/IOVaL7QcfsVhsfAGUvTjzLovF8/nrGC1e
        zrrHZrH3NVDxpsfXWC0evgq3uLxrDptFz4atrBZrj9xlt1h6/SKTxbJNf5gsFm39wm7RuvcI
        u0VL2xEmBwmPNfPWMHrsuLuE0eP6kk/MHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j9egv
        Fo++LasYPf41zWX36Dpync3j8yY5j1NfP7MH8EVx2aSk5mSWpRbp2yVwZexetYypYIJkxZul
        u9gaGP8KdzFyckgImEj8v/OMEcQWEtjNKLHsCx9EXEJi5e9JjBC2sMTKf8/ZIWqeMkrcPRkB
        YrMJ6Em8OrKYtYuRi0NE4CSjRP+ZFjCHWWAli8TdW10sII6QwBtGiatdB8DaOQXsJA5cv8IC
        YgsLeElMu/qfGcRmEVCROLbtOZjNK2Ap8er+Y0YIW1Di5MwnYPXMAtoSvQ9bGSFseYntb+cw
        Q5ynIPHz6TJWEFtEwE1i44Qt7BA14hIvjx5hn8AoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz
        03OLDQsM81LL9YoTc4tL89L1kvNzNzGCE4qW5g7G7as+6B1iZOJgPMQowcGsJMKbskMkWYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmA5Y9xg+KyovV
        vRe/+dPMt99aa3d9e+G01aflQhkn2zI/S+CZJP22Yf/VjvtzSvv0b/1IM+8UMO9MOp/wpFxZ
        YlML3+W3C2ZFWftXBIcd0GJrkLMuv7qO94xJ2XuF05tO+71buiy/q+z2If+AFdLG3b/bP9/8
        8ab4OutxHW+l4w93HDOafrvWf5ap1YuZlWcLXXcvudC9TeKr0CWxnSuLd/Uuy58bdq7vwOVu
        8bMTGXLTf8lp+b/49E3vwinHbNNTcyVf8pYKvuNjzeLZO3P+G9mOKW9UzydcSL3D77bQSqZv
        3akGi2u1z5lea1ctvTLNwfDPugjVWefeK81nPxHX6mqm0x9Qfjnt5v233yOklViKMxINtZiL
        ihMBnCgR75cDAAA=
X-CMS-MailID: 20220907121647epcas5p2d35c37079e03f8bc248cee3bbb61b929
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063413epcas5p3df6d22933ba2884730c52b6a3af2cb09
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063413epcas5p3df6d22933ba2884730c52b6a3af2cb09@epcas5p3.samsung.com>
        <20220907064715.55778-16-smitha.t@samsung.com>
        <783df4f0-0b7e-8604-d61f-f78e0375c321@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: Wednesday, September 7, 2022 4:56 PM
> To: Smitha T Murthy <smitha.t@samsung.com>; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
> benjamin.gaignard@collabora.com; stanimir.varbanov@linaro.org;
> dillon.minfei@gmail.com; david.plowman@raspberrypi.com;
> mark.rutland@arm.com; robh+dt@kernel.org; krzk+dt@kernel.org;
> andi@etezian.org; alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> pankaj.dubey@samsung.com; linux-fsd@tesla.com;
> aakarsh.jain@samsung.com
> Subject: Re: [Patch v2 15/15] arm64: dts: fsd: Add MFC related DT enteries
> 
> On 07/09/2022 08:47, Smitha T Murthy wrote:
> > Add MFC DT node and reserve memory node for MFC usage.
> >
> > Cc: linux-fsd@tesla.com
> > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd-evb.dts |  4 ++++
> >  arch/arm64/boot/dts/tesla/fsd.dtsi    | 22 ++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > index 1db6ddf03f01..17bb048f9d47 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > @@ -30,6 +30,10 @@
> >  	};
> >  };
> >
> > +&clock_mfc {
> > +	status = "okay";
> 
> clock node was never disabled, so there is no need to enable it.
> 

Ok I will remove it in the next series.
 
> > +};
> > +
> >  &fin_pll {
> >  	clock-frequency = <24000000>;
> >  };
> > diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > index f35bc5a288c2..bca0ba030ee7 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > @@ -340,6 +340,18 @@
> >  		#clock-cells = <0>;
> >  	};
> >
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		mfc_left: region@84000000 {
> > +			compatible = "shared-dma-pool";
> > +			no-map;
> > +			reg = <0 0x84000000 0 0x8000000>;
> > +		};
> > +	};
> > +
> >  	soc: soc@0 {
> >  		compatible = "simple-bus";
> >  		#address-cells = <2>;
> > @@ -832,6 +844,16 @@
> >  			clock-names = "fin_pll", "mct";
> >  		};
> >
> > +		mfc: mfc@12880000 {
> > +			compatible = "samsung,fsd-mfc";
> > +			reg = <0x0 0x12880000 0x0 0x10000>;
> > +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> > +			clock-names = "mfc";
> > +			clocks = <&clock_mfc MFC_MFC_IPCLKPORT_ACLK>;
> > +			memory-region = <&mfc_left>;
> > +			status = "okay";
> 
> Okay is by default, don't add it.
> 

I will remove this in the next series.

> > +		};
> > +
> >  		ufs: ufs@15120000 {
> >  			compatible = "tesla,fsd-ufs";
> >  			reg = <0x0 0x15120000 0x0 0x200>,  /* 0: HCI standard
> */
> 
> 
> Best regards,
> Krzysztof

Thank you for the review.

Regards,
Smitha

