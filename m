Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E535577EED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiGRJrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbiGRJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:47:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9BB1AF16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:46:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b11so20150402eju.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=xI9mJnc070F1Cnspd11RMCcRJh74q6YG25IRj9MrGkc=;
        b=Xj9kernYJvIMwvQQsUXQWEltYFWdoipMN+Mq30lz2yfi0zWSUEjABvDAQPTUv2+QLs
         bAt4HWCnG7uF11CbDpxTuiqzBKL0ChaSEcUi2aCLDxY2vd2xw8npZFP8xp+m9PUUOH0b
         welRhmUTLSb81JlwuQ6PNmLGTceHebjWYc0DZ+IRyazkrNLlBIVgi9N0zkeSaNFwK1EO
         ndjoQU/57BldCZM6udrWj2oQF94qCM5E2URlxXarf/BsqakixdHYkN8kwSbU5ZLRWum2
         cJ/qotA5R+Whl96kRZfAoU6KbmCzDEPVUgGBMBJ+bvZPqjmj0tBvBdtppJoy3E31zigI
         Ogkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=xI9mJnc070F1Cnspd11RMCcRJh74q6YG25IRj9MrGkc=;
        b=nqIcOxxeVLon6FeywqEpjShsBUrwujtJlvVXxhhDw5If8WhIPNrkwV3N0ZCIPTMGy9
         c5LRubc8707RSgrBf19O69DbnJ6DaKY8PAwCZwjdJvftwozeLEn5wD3an5gVW/RXxb0T
         N8WPJEXkrXNkox74wxzFyzNsV5XcNIA1BoI72grCFh++l/jIGWWZXYW8cIzAOkUouyHA
         DvO7+ecvEF6QW1vvP9uTfiZM3UDrjW4Sgq+TfaYfuV3SFMX/Nby0Ni/XvlEors3aX9qH
         wn7UEdlRuvTokTFLkktiv8z1hMHXvs3mNSfrUo5FXgdURVHW0cuwpfwfP/kmJ69i+L4M
         w7jQ==
X-Gm-Message-State: AJIora85QezYFdH3LwnXgTw7/LlHcXAckheuTs5FxW6fioTYJRyBKJa+
        tYn7+ZOyAhZ/4Xu07dtXuyluGA==
X-Google-Smtp-Source: AGRyM1tz8gz1LaGnXhk6yS4lXBRV4qKP0KtylAmLK+qLBg+0tm19zLkpKlrOxD5AtYxeSsdonAkZTQ==
X-Received: by 2002:a17:906:e9b:b0:72d:ec31:b037 with SMTP id p27-20020a1709060e9b00b0072dec31b037mr22337393ejf.595.1658137613718;
        Mon, 18 Jul 2022 02:46:53 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id h5-20020a0564020e0500b0043b5adf54b3sm3418090edh.61.2022.07.18.02.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 02:46:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 18 Jul 2022 11:46:52 +0200
Message-Id: <CLIOQ73QARAO.C0NGVX11Q4LN@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sm6350: Add interconnect
 support
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Georgi Djakov" <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>
X-Mailer: aerc 0.9.0
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
 <20220525144404.200390-6-luca.weiss@fairphone.com>
 <22495dc6-0d55-70d0-d9f3-bcfafcae62d1@kernel.org>
In-Reply-To: <22495dc6-0d55-70d0-d9f3-bcfafcae62d1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

On Mon Jul 18, 2022 at 9:58 AM CEST, Georgi Djakov wrote:
> On 25.05.22 17:44, Luca Weiss wrote:
> > Add all the different NoC providers that are found in SM6350 and
> > populate different nodes that use the interconnect properties.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > Changes since v2:
> > * none
> >=20
> >   arch/arm64/boot/dts/qcom/sm6350.dtsi | 109 ++++++++++++++++++++++++++=
+
> >   1 file changed, 109 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts=
/qcom/sm6350.dtsi
> > index fb1a0f662575..119073f19285 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > @@ -1,11 +1,13 @@
> >   // SPDX-License-Identifier: BSD-3-Clause
> >   /*
> >    * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
> > + * Copyright (c) 2022, Luca Weiss <luca.weiss@fairphone.com>
> >    */
> >  =20
> >   #include <dt-bindings/clock/qcom,gcc-sm6350.h>
> >   #include <dt-bindings/clock/qcom,rpmh.h>
> >   #include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interconnect/qcom,sm6350.h>
> >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >   #include <dt-bindings/mailbox/qcom-ipcc.h>
> >   #include <dt-bindings/power/qcom-rpmpd.h>
> > @@ -539,6 +541,10 @@ i2c0: i2c@880000 {
> >   				interrupts =3D <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> >   				#address-cells =3D <1>;
> >   				#size-cells =3D <0>;
> > +				interconnects =3D <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_Q=
UP_CORE_0 0>,
> > +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
> > +						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
> > +				interconnect-names =3D "qup-core", "qup-config", "qup-memory";
> >   				status =3D "disabled";
> >   			};
> >  =20
> > @@ -552,6 +558,10 @@ i2c2: i2c@888000 {
> >   				interrupts =3D <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
> >   				#address-cells =3D <1>;
> >   				#size-cells =3D <0>;
> > +				interconnects =3D <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_Q=
UP_CORE_0 0>,
> > +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
> > +						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
> > +				interconnect-names =3D "qup-core", "qup-config", "qup-memory";
> >   				status =3D "disabled";
> >   			};
> >   		};
> > @@ -578,6 +588,10 @@ i2c6: i2c@980000 {
> >   				interrupts =3D <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
> >   				#address-cells =3D <1>;
> >   				#size-cells =3D <0>;
> > +				interconnects =3D <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_Q=
UP_CORE_1 0>,
> > +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
> > +						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
> > +				interconnect-names =3D "qup-core", "qup-config", "qup-memory";
> >   				status =3D "disabled";
> >   			};
> >  =20
> > @@ -591,6 +605,10 @@ i2c7: i2c@984000 {
> >   				interrupts =3D <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> >   				#address-cells =3D <1>;
> >   				#size-cells =3D <0>;
> > +				interconnects =3D <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_Q=
UP_CORE_1 0>,
> > +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
> > +						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
> > +				interconnect-names =3D "qup-core", "qup-config", "qup-memory";
> >   				status =3D "disabled";
> >   			};
> >  =20
> > @@ -604,6 +622,10 @@ i2c8: i2c@988000 {
> >   				interrupts =3D <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
> >   				#address-cells =3D <1>;
> >   				#size-cells =3D <0>;
> > +				interconnects =3D <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_Q=
UP_CORE_1 0>,
> > +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
> > +						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
> > +				interconnect-names =3D "qup-core", "qup-config", "qup-memory";
> >   				status =3D "disabled";
> >   			};
> >  =20
> > @@ -615,6 +637,9 @@ uart9: serial@98c000 {
> >   				pinctrl-names =3D "default";
> >   				pinctrl-0 =3D <&qup_uart9_default>;
> >   				interrupts =3D <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> > +				interconnects =3D <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_Q=
UP_CORE_1 0>,
> > +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
> > +				interconnect-names =3D "qup-core", "qup-config";
> >   				status =3D "disabled";
> >   			};
> >  =20
> > @@ -628,11 +653,62 @@ i2c10: i2c@990000 {
> >   				interrupts =3D <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
> >   				#address-cells =3D <1>;
> >   				#size-cells =3D <0>;
> > +				interconnects =3D <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_Q=
UP_CORE_1 0>,
> > +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
> > +						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
> > +				interconnect-names =3D "qup-core", "qup-config", "qup-memory";
> >   				status =3D "disabled";
> >   			};
> >  =20
> >   		};
> >  =20
> > +		config_noc: interconnect@1500000 {
> > +			compatible =3D "qcom,sm6350-config-noc";
> > +			reg =3D <0 0x01500000 0 0x28000>;
> > +			#interconnect-cells =3D <2>;
> > +			qcom,bcm-voters =3D <&apps_bcm_voter>;
> > +		};
> > +
> > +		system_noc: interconnect@1620000 {
> > +			compatible =3D "qcom,sm6350-system-noc";
> > +			reg =3D <0 0x01620000 0 0x17080>;
> > +			#interconnect-cells =3D <2>;
> > +			qcom,bcm-voters =3D <&apps_bcm_voter>;
> > +
> > +			clk_virt: interconnect-clk-virt {
> > +				compatible =3D "qcom,sm6350-clk-virt";
> > +				#interconnect-cells =3D <2>;
> > +				qcom,bcm-voters =3D <&apps_bcm_voter>;
> > +			};
> > +		};
> > +
> > +		aggre1_noc: interconnect@16e0000 {
> > +			compatible =3D "qcom,sm6350-aggre1-noc";
> > +			reg =3D <0 0x016e0000 0 0x15080>;
> > +			#interconnect-cells =3D <2>;
> > +			qcom,bcm-voters =3D <&apps_bcm_voter>;
> > +		};
> > +
> > +		aggre2_noc: interconnect@1700000 {
> > +			compatible =3D "qcom,sm6350-aggre2-noc";
> > +			reg =3D <0 0x01700000 0 0x1f880>;
> > +			#interconnect-cells =3D <2>;
> > +			qcom,bcm-voters =3D <&apps_bcm_voter>;
> > +
> > +			compute_noc: interconnect-compute-noc {
> > +				compatible =3D "qcom,sm6350-compute-noc";
> > +				#interconnect-cells =3D <2>;
> > +				qcom,bcm-voters =3D <&apps_bcm_voter>;
> > +			};
> > +		};
> > +
> > +		mmss_noc: interconnect@1740000 {
> > +			compatible =3D "qcom,sm6350-mmss-noc";
> > +			reg =3D <0 0x01740000 0 0x1c100>;
> > +			#interconnect-cells =3D <2>;
> > +			qcom,bcm-voters =3D <&apps_bcm_voter>;
> > +		};
> > +
> >   		ufs_mem_hc: ufs@1d84000 {
> >   			compatible =3D "qcom,sm6350-ufshc", "qcom,ufshc",
> >   				     "jedec,ufs-2.0";
> > @@ -933,6 +1009,10 @@ sdhc_2: sdhci@8804000 {
> >   				 <&gcc GCC_SDCC2_APPS_CLK>,
> >   				 <&rpmhcc RPMH_CXO_CLK>;
> >   			clock-names =3D "iface", "core", "xo";
> > +			interconnects =3D <&aggre2_noc MASTER_SDCC_2 0 &clk_virt SLAVE_EBI_=
CH0 0>,
> > +					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_SDCC_2 0>;
> > +			interconnect-names =3D "sdhc-ddr", "cpu-sdhc";
> > +
> >   			qcom,dll-config =3D <0x0007642c>;
> >   			qcom,ddr-config =3D <0x80040868>;
> >   			power-domains =3D <&rpmhpd 0>;
> > @@ -947,11 +1027,15 @@ sdhc2_opp_table: sdhc2-opp-table {
> >   				opp-100000000 {
> >   					opp-hz =3D /bits/ 64 <100000000>;
> >   					required-opps =3D <&rpmhpd_opp_svs_l1>;
> > +					opp-peak-kBps =3D <790000 131000>;
> > +					opp-avg-kBps =3D <50000 50000>;
> >   				};
> >  =20
> >   				opp-202000000 {
> >   					opp-hz =3D /bits/ 64 <202000000>;
> >   					required-opps =3D <&rpmhpd_opp_nom>;
> > +					opp-peak-kBps =3D <3190000 294000>;
> > +					opp-avg-kBps =3D <261438 300000>;
>
> Just wondering where do these values come from? Are they from the downstr=
eam DT?
> The rest looks good to me.

Exactly, the values are part of downstream dtsi[0]. The docs for this
property are:
- qcom,msm-bus,vectors-KBps:
    Arrays of unsigned integers representing:
    * master-id
    * slave-id
    * arbitrated bandwidth in KBps
    * instantaneous bandwidth in KBps

The first two paths downstream are consolidated into one here, the third
downstream is the second one here.

[0] https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/tag=
s/android-12.1.0_r0.15/qcom/lagoon.dtsi#3165

Hope that clears it up!
Regards
Luca

>
> Thanks,
> Georgi
>
> >   				};
> >   			};
> >   		};
> > @@ -1017,12 +1101,33 @@ dp_phy: dp-phy@88ea200 {
> >   			};
> >   		};
> >  =20
> > +		dc_noc: interconnect@9160000 {
> > +			compatible =3D "qcom,sm6350-dc-noc";
> > +			reg =3D <0 0x09160000 0 0x3200>;
> > +			#interconnect-cells =3D <2>;
> > +			qcom,bcm-voters =3D <&apps_bcm_voter>;
> > +		};
> > +
> >   		system-cache-controller@9200000 {
> >   			compatible =3D "qcom,sm6350-llcc";
> >   			reg =3D <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
> >   			reg-names =3D "llcc_base", "llcc_broadcast_base";
> >   		};
> >  =20
> > +		gem_noc: interconnect@9680000 {
> > +			compatible =3D "qcom,sm6350-gem-noc";
> > +			reg =3D <0 0x09680000 0 0x3e200>;
> > +			#interconnect-cells =3D <2>;
> > +			qcom,bcm-voters =3D <&apps_bcm_voter>;
> > +		};
> > +
> > +		npu_noc: interconnect@9990000 {
> > +			compatible =3D "qcom,sm6350-npu-noc";
> > +			reg =3D <0 0x09990000 0 0x1600>;
> > +			#interconnect-cells =3D <2>;
> > +			qcom,bcm-voters =3D <&apps_bcm_voter>;
> > +		};
> > +
> >   		usb_1: usb@a6f8800 {
> >   			compatible =3D "qcom,sm6350-dwc3", "qcom,dwc3";
> >   			reg =3D <0 0x0a6f8800 0 0x400>;
> > @@ -1051,6 +1156,10 @@ usb_1: usb@a6f8800 {
> >  =20
> >   			resets =3D <&gcc GCC_USB30_PRIM_BCR>;
> >  =20
> > +			interconnects =3D <&aggre2_noc MASTER_USB3 0 &clk_virt SLAVE_EBI_CH=
0 0>,
> > +					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3 0>;
> > +			interconnect-names =3D "usb-ddr", "apps-usb";
> > +
> >   			usb_1_dwc3: usb@a600000 {
> >   				compatible =3D "snps,dwc3";
> >   				reg =3D <0 0x0a600000 0 0xcd00>;

