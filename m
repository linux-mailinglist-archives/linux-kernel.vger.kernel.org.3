Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA537566A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiGELxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiGELwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:52:47 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA954175BE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:52:45 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220705115244epoutp03b65b7e066ef3add0e0916706a12232e0~_7LJ_uLMg0454304543epoutp03g
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:52:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220705115244epoutp03b65b7e066ef3add0e0916706a12232e0~_7LJ_uLMg0454304543epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657021964;
        bh=0hIUvgoDZes3ir+8OQinMYK+kR0LHpWkLed4oXgVasw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=mG4sfs3OpoDbjm9i9hWpBOx9uBZrhTbLFSG0YYQ2OfUD+E3AbIcxO43jwTTSQn18R
         OZx4FRIe5iQ7TRWXRyHb8dFXbdtWx+fnsPrKbbo/97qfop7nJZ8anyCYm8KiHg4HqB
         YA8APQel3BX27cfXhWx4rgMGm6EclewHy0gC+yeU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220705115243epcas5p1d3d5f7394569f9a4e65fc8479320ebd1~_7LJbKgEQ1745317453epcas5p1V;
        Tue,  5 Jul 2022 11:52:43 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lcgyw2NK6z4x9Q5; Tue,  5 Jul
        2022 11:52:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.C4.09639.40624C26; Tue,  5 Jul 2022 20:52:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220705114931epcas5p47c6436621f751b7db2ccba25cee79ac0~_7IWLuA7l2005520055epcas5p4k;
        Tue,  5 Jul 2022 11:49:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220705114931epsmtrp16df32d7003a87d474a3c785df5b0621f~_7IWKrbdu2735727357epsmtrp1d;
        Tue,  5 Jul 2022 11:49:31 +0000 (GMT)
X-AuditID: b6c32a4b-e83ff700000025a7-2c-62c426045db0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.F4.08905.B4524C26; Tue,  5 Jul 2022 20:49:31 +0900 (KST)
Received: from smithat07 (unknown [107.122.12.13]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220705114927epsmtip2778e56b396e5aa2a1b47c490e9a98548~_7ITKm_QK1024410244epsmtip2g;
        Tue,  5 Jul 2022 11:49:27 +0000 (GMT)
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
        <linux-fsd@tesla.com>
In-Reply-To: <60219d61-a39c-554f-af71-07cf7e6c40b0@linaro.org>
Subject: RE: [PATCH 19/20] arm64: dts: fsd: Add MFC related DT enteries
Date:   Tue, 5 Jul 2022 17:19:26 +0530
Message-ID: <01e901d89065$49a47180$dced5480$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJFyDoizuFNEw0PhIpG3eTqugJ4BwH5pXIMATdG0GABysfSd6xtXCKw
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH97u3vS1s3S4dkx8Qsd6ZEYYwOtp6awCNI+MKPlBGnJuCBa6F
        UNqmL4X9YeOEBPZym9tCR4ENBq6yB6UFHLBBV5w0CwPlISrjMQgDRAXGgLmHLS3Kf59zzvf8
        zuOXw0a5Z1gB7Cy5hlbJJTIC82bU3wwJCWNss6dF3OsTk8Ol9RhZsTSBkEMV8wzSVmdlkZae
        syhZfauVSZbZO5lkQ9sog6y974x2Fw8yyImyy4CcNNzFyJZpp9h8r49Jjkx9QP58rQQjD1+1
        MslL9kEWeaG/GyGrzI8R8rz1AYvMb7GzyK8K7MjrflRNaQ2gGgcrAdVfOYdS3xsGWVRF8yRC
        mU2FGPV7XzNG1VV+QeW3P2JQRy0mQD390siiiuz9GDVvDqIcC/OsxI37sqMyaUkGreLR8nRF
        RpZcGk0kJKXuShWKIvhhfDH5CsGTS3LoaCL2rcSw3Vky5wYInk4i0zpdiRK1mtgRE6VSaDU0
        L1Oh1kQTtDJDphQow9WSHLVWLg2X05pX+RERO4VO4SfZmc8c3ZjS5P957cI5lh4c9S0CXmyI
        C2BtVzNSBLzZXLwJwB/GFjG3MQfgzfF64DYeAjh7p521mmIs/pXlDrQAeMFcw3QFuPgEgNYy
        nYsxPBxO2SuYLpEv3g7gsGUEdRkovojC8RtjmEvlhcfAq6esK7wZj4N1vU8QFzPwl+CN+46V
        Vzm4GP5WOo242Qd2FI8xXIziL8CGmRLU3RIPLo9XMd1+PzjZbl9p1RffDfXPTng0nV6wsyHU
        zbGw59sGzzib4dQti4cD4OSxAg9L4dD8QeBmJTTqLYibX4OtPSXOHtjOWiHwyrUdbvfz8JTj
        MuJuYSM88s+YR86BjaWrTMDzt3/0PA9h74yV+TUgDGsmM6yZzLBmGsP/1coBwwT8aaU6R0qr
        hcpIOf3Zfz+ersgxg5UL2Z7QCEaH/w63AYQNbACyUcKXYzrRlsblZEhy82iVIlWlldFqGxA6
        130cDdiSrnCemFyTyheIIwQikUggjhTxCT9OfK85jYtLJRo6m6aVtGo1D2F7BeiRw/FP4x6H
        Rs5FV8d/F9h0/GJr+V/vGoM/bTP8JC8+PXOsIOVI3XMvX0oOXBAZtwod5hbdgL5zVJGcGLNl
        f9dCVVzknutE0vqgbdcbtjp89osTNIXYw4veJ2ejx6e5WZJhyzen96TEFtztWH87D+EHFYPG
        95NNvAHOmcKmxT/7m8ZMueUVgcRcdcmycNPykwdVNSKRtjFlQGrTtuXuzXlvcmh2tu2Xk6Fn
        d/lfITkvKtg6hW5nwdtxGz7Ez/nMencFZ6WXvPFxqTIMjIy3LnGWjPmZXRb9R7sO2dgbBAnc
        TfsO1mpC8u5YdYck6yhs3R/J2W8mNYd2RD1yVL+D7j1wQBZcQzDUmRL+dlSllvwLTD3UCqoE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZdlhJXtdb9UiSwbqdrBYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVns
        fQ1UvOnxNVaLh6/CLS7vmsNm0bNhK6vF2iN32S2WXr/IZLFs0x8mi0Vbv7BbtO49wm7R0naE
        yUHcY828NYweO+4uYfS4vuQTs8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n3aD36i8Wjb8sq
        Ro9/TXPZPbqOXGfz+LxJzuPU18/sAXxRXDYpqTmZZalF+nYJXBn/T11kK1glWbHx60L2BsY+
        kS5GTg4JAROJuTNvsXcxcnEICexmlOj+c5AFIiEhsfL3JEYIW1hi5b/nUEVPGSW2tjczgyTY
        BPQkXh1ZzAqSEBE4ySjRf6YFzGEW6GaRaHzVygTR8oZR4mX3arC5nAJ2EhumbmUDsYUF3CU2
        X/3LBGKzCKhI7H9xihXE5hWwlLg97zUThC0ocXLmE7BeZgFtid6HrYwQtrzE9rdzmCHuU5D4
        +XQZK0RcXOLl0SPsILaIgJtEw/9JzBMYhWchGTULyahZSEbNQtK+gJFlFaNkakFxbnpusWGB
        YV5quV5xYm5xaV66XnJ+7iZGcCrR0tzBuH3VB71DjEwcjIcYJTiYlUR4V006mCTEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU5jwtYwU18+FGW5bdzCc
        CYuJXyxrZO7ntyT70SmrY0eezROQc3HJ7/o86YWLw+nPPaUzSleXFYjKxvKfq/j8vK3aurPI
        fu9J3lpzCb+7zL3ysnM/7FiuEuokKV96QGfWJr2pFjMUu6R0JhzrkYuKTz6adOz6Am5BGdYJ
        TxP4DDr5Os/6pCm9KlL8yXvpqNAPzbCF/ZIqX35PZ+fOvfVehvHrjfLazQ8v+nv9WrrIRsD5
        q6KojnSV3e5Xj7x/qT9nmnuDP+Xz9YBA81hXhpU56tzzPnafyV+xxG3ixrunTC/sy9OsYHLN
        ryxzWnhtpUNx7NnEnPX9W3ceMllr1Mjx3GhWn939qgUNnIfln6xUYinOSDTUYi4qTgQAazpt
        7ZQDAAA=
X-CMS-MailID: 20220705114931epcas5p47c6436621f751b7db2ccba25cee79ac0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125656epcas5p1cc1296b200ff8801f24243aa47de8fe1
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125656epcas5p1cc1296b200ff8801f24243aa47de8fe1@epcas5p1.samsung.com>
        <20220517125548.14746-20-smitha.t@samsung.com>
        <60219d61-a39c-554f-af71-07cf7e6c40b0@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: Tuesday, May 17, 2022 7:32 PM
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
> pankaj.dubey@samsung.com; linux-fsd@tesla.com
> Subject: Re: [PATCH 19/20] arm64: dts: fsd: Add MFC related DT enteries
> 
> On 17/05/2022 14:55, Smitha T Murthy wrote:
> > Add MFC DT node and reserve memory node for MFC usage.
> >
> > Cc: linux-fsd@tesla.com
> > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd-evb.dts |  8 ++++++++
> >  arch/arm64/boot/dts/tesla/fsd.dtsi    | 22 ++++++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > index 5af560c1b5e6..36f6b013ce99 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> > @@ -37,3 +37,11 @@
> >  &serial_0 {
> >  	status = "okay";
> >  };
> > +
> > +&clock_mfc {
> > +	status = "okay";
> > +};
> > +
> > +&mfc_0 {
> > +	status = "okay";
> > +};
> 
> Labels are ordered by name.
> 

Ok, I will re-order.

> > diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > index 9a652abcbcac..434ae75421d8 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > @@ -249,6 +249,18 @@
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
> > @@ -748,6 +760,16 @@
> >  			clocks = <&fin_pll>, <&clock_imem
> IMEM_MCT_PCLK>;
> >  			clock-names = "fin_pll", "mct";
> >  		};
> > +
> > +		mfc_0: mfc0@12880000 {
> 
> Generic node names, so mfc.
> 

Ok I will change.

> > +			compatible = "samsung,mfc-v12";
> > +			reg = <0x0 0x12880000 0x0 0x10000>;
> > +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> > +			clock-names = "mfc";
> > +			clocks = <&clock_mfc MFC_MFC_IPCLKPORT_ACLK>;
> > +			memory-region = <&mfc_left>;
> > +			status = "disabled";
> 
> Why exactly this is disabled? Usually we disable nodes which needs
> resources from the boards, but this is not the case here. Unless it is?
> 

I will change this in next patch series.

Regards,
Smitha

> > +		};
> >  	};
> >  };
> >
> 
> 
> Best regards,
> Krzysztof

