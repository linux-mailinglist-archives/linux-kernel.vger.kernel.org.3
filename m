Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E75248C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351897AbiELJUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiELJT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:19:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC87205F2C;
        Thu, 12 May 2022 02:19:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso4393075pjg.0;
        Thu, 12 May 2022 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=Nt7/SSWoDR75mNb090rQF4WPuNxt+chmnIAsdE3g0kU=;
        b=DNYILr4tgb7B9qV1VlNAdEpvqH3F+SqP+ET2/g5ncLo8iz06RbruAy51IZE5Bk9NGy
         wCDvMSh9kPQZRe1cZoo53E4sVMe1kioKYuFBG1WjDspni5PB+ge02KFuwmuxNXNgRQ8h
         FoRDRUbWMHXMXrN4XG67616ksfG9TyN1bvtRkowskjUkaUOCnDldBCYw6D2ESSOwhjVJ
         bF5qAugGnoUizdMKPj1rP4Ui/JK6gO0WTttZKjb6ljm0Qk5s8+fBuogPIxEpUzDv2orp
         VU8OetHGA1ov34kXAjs2OUfouPlK3/Hgj6Ee+x8hIyLefueG4YjzxP4n9nrjMxqCvdM2
         66JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=Nt7/SSWoDR75mNb090rQF4WPuNxt+chmnIAsdE3g0kU=;
        b=tr0sx6OAgFJT+UdZC1dyG2CXWjDwDSPSJF9D+Z9ixheVXINSFuH38VcjQTxip2IV/z
         xsp68RaVU9IAvwu/o28UlvIk2hszWvHPn7wB2mmb3MMsvP+DqsnIzuTCVTSR9zldBiw/
         unr9hlQf5Eh28eYKP2hgL2i1Hyngw+xz/fgC4F/OfFY1UgULCpMlMgM0p1WOPRF8mBk/
         QC/vAmcwha1P6m3tocYbQwHxR/jfSH37fg0/3utZComtfS5PfzuX5XEqo40wZIh8xdgj
         Oc+I7PNM+eP0NVYCmtfyQv9eb51U0DuEgTYhMiLjXreFF1+vhhKgDmfsTpgqIBYNSots
         rvVw==
X-Gm-Message-State: AOAM532aPgiszejeKGsq64jkGdaCCRpHT6V5h4CGdidAjAvOMfBUFI2V
        UBZkT8eLlDRLlvAE0wt2mjW0UrAehuT2HQgH
X-Google-Smtp-Source: ABdhPJynQCNJ9zZfkhh1IFBs8j6FfkoVhqJ9UhqYNRqVm1u9en9mfrs+O1kzL+x5hL+YtLV1RAG5uw==
X-Received: by 2002:a17:902:b7cb:b0:15c:6650:a58a with SMTP id v11-20020a170902b7cb00b0015c6650a58amr29866078plz.63.1652347195964;
        Thu, 12 May 2022 02:19:55 -0700 (PDT)
Received: from localhost ([49.204.239.218])
        by smtp.gmail.com with ESMTPSA id gc1-20020a17090b310100b001cd4989ff61sm1383206pjb.40.2022.05.12.02.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 02:19:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 May 2022 14:49:49 +0530
Message-Id: <CJXO6ZMZ454X.M3N9HDKNA5HB@skynet-linux>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <phone-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 9/9] arm64: dts: qcom: msm8953: Add remote processor
 nodes
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
X-Mailer: aerc 0.9.0
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-10-sireeshkodali1@gmail.com>
 <2d68e610-e8ae-9e08-257a-3c94c3697334@linaro.org>
In-Reply-To: <2d68e610-e8ae-9e08-257a-3c94c3697334@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 11, 2022 at 11:25 PM IST, Krzysztof Kozlowski wrote:
> On 11/05/2022 18:16, Sireesh Kodali wrote:
> > This commit adds the modem (q6v5_mss), WiFi (wcnss-pil) and audio DSP
> > (q6v5_pas) remote processor nodes for the MSM8953 platform. It also add=
s
> > the coresponding SMP2P, SMSM and pinctrl nodes that are needed by these
> > remote processors.
> >=20
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > +			};
> > +
> > +			wcnss_sleep: wcnss-sleep-pins {
> > +				wcss_wlan2 {
>
> No underscores in node names, unless something needs it?
>

wcnss_sleep is used by the pronto node defined below

> > +					pins =3D "gpio76";
> > +					function =3D "wcss_wlan2";
> > +				};
> > +				wcss_wlan1 {
> > +					pins =3D "gpio77";
> > +					function =3D "wcss_wlan1";
> > +				};
> > +				wcss_wlan0 {
> > +					pins =3D "gpio78";
> > +					function =3D "wcss_wlan0";
> > +				};
> > +				wcss_wlan {
> > +					pins =3D "gpio79", "gpio80";
> > +					function =3D "wcss_wlan";
> > +				};
> > +
> > +				pinconf {
> > +					pins =3D "gpio76", "gpio77",
> > +					     "gpio78", "gpio79",
> > +					     "gpio80";
> > +					drive-strength =3D <2>;
> > +					bias-pull-down;
> > +				};
> > +			};
> >  		};
> > =20
> >  		gcc: clock-controller@1800000 {
> > @@ -745,6 +892,59 @@ spmi_bus: spmi@200f000 {
> >  			#size-cells =3D <0>;
> >  		};
> > =20
> > +		modem: remoteproc@4080000 {
> > +			compatible =3D "qcom,msm8953-mss-pil";
> > +			reg =3D <0x4080000 0x100>,
> > +			    <0x4020000 0x040>;
> > +
> > +			reg-names =3D "qdsp6", "rmb";
> > +
> > +			interrupts-extended =3D <&intc 0 24 1>,
> > +					      <&modem_smp2p_in 0 0>,
> > +					      <&modem_smp2p_in 1 0>,
> > +					      <&modem_smp2p_in 2 0>,
> > +					      <&modem_smp2p_in 3 0>;
> > +			interrupt-names =3D "wdog", "fatal", "ready",
> > +					  "handover", "stop-ack";
> > +
> > +			clocks =3D <&gcc GCC_MSS_CFG_AHB_CLK>,
> > +				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
> > +				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
> > +				 <&xo_board>;
> > +			clock-names =3D "iface", "bus", "mem", "xo";
> > +
> > +			power-domains =3D <&rpmpd MSM8953_VDDCX>, <&rpmpd MSM8953_VDDMX>;
> > +			power-domain-names =3D "cx", "mx";
> > +
> > +			qcom,smem-states =3D <&modem_smp2p_out 0>;
> > +			qcom,smem-state-names =3D "stop";
> > +
> > +			resets =3D <&gcc GCC_MSS_BCR>;
> > +			reset-names =3D "mss_restart";
> > +
> > +			qcom,halt-regs =3D <&tcsr 0x18000 0x19000 0x1a000>;
> > +
> > +			status =3D "okay";
>
> No need for okay.

I'll drop it in v2
>
> > +
> > +			mba {
> > +				memory-region =3D <&mba_mem>;
> > +			};
> > +
> > +			mpss {
> > +				memory-region =3D <&mpss_mem>;
> > +			};
> > +
> > +			smd-edge {
> > +				interrupts =3D <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
> > +
> > +				qcom,smd-edge =3D <0>;
> > +				qcom,ipc =3D <&apcs 8 12>;
> > +				qcom,remote-pid =3D <1>;
> > +
> > +				label =3D "modem";
> > +			};
> > +		};
> > +
> >  		usb3: usb@70f8800 {
> >  			compatible =3D "qcom,msm8953-dwc3", "qcom,dwc3";
> >  			reg =3D <0x70f8800 0x400>;
> > @@ -1057,6 +1257,74 @@ i2c_8: i2c@7af8000 {
> >  			status =3D "disabled";
> >  		};
> > =20
> > +		pronto: remoteproc@a21b000 {
> > +			compatible =3D "qcom,pronto-v3-pil", "qcom,pronto";
> > +			reg =3D <0xa204000 0x2000>,
> > +			      <0xa202000 0x1000>,
> > +			      <0xa21b000 0x3000>;
> > +			reg-names =3D "ccu", "dxe", "pmu";
> > +
> > +			memory-region =3D <&wcnss_fw_mem>;
> > +
> > +			interrupts-extended =3D <&intc 0 149 IRQ_TYPE_EDGE_RISING>,
> > +					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> > +					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> > +					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> > +					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> > +			interrupt-names =3D "wdog", "fatal", "ready", "handover", "stop-ack=
";
> > +
> > +			power-domains =3D <&rpmpd MSM8953_VDDCX>, <&rpmpd MSM8953_VDDMX>;
> > +			power-domain-names =3D "cx", "mx";
> > +
> > +			qcom,state =3D <&wcnss_smp2p_out 0>;
> > +			qcom,state-names =3D "stop";
> > +
> > +			pinctrl-names =3D "default", "sleep";
> > +			pinctrl-0 =3D <&wcnss_default>;
> > +			pinctrl-1 =3D <&wcnss_sleep>;
> > +
> > +			status =3D "okay";
>
> No need for status.

Will be dropped in v2
>
> > +
> > +			iris: iris {
> > +				compatible =3D "qcom,wcn3660b";
> > +
> > +				clocks =3D <&rpmcc RPM_SMD_RF_CLK2>;
> > +				clock-names =3D "xo";
> > +			};
> > +
> > +			smd-edge {
> > +				interrupts =3D <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
> > +
> > +				qcom,ipc =3D <&apcs 8 17>;
> > +				qcom,smd-edge =3D <6>;
> > +				qcom,remote-pid =3D <4>;
> > +
> > +				label =3D "pronto";
> > +
> > +				wcnss {
> > +					compatible =3D "qcom,wcnss";
> > +					qcom,smd-channels =3D "WCNSS_CTRL";
> > +
> > +					qcom,mmio =3D <&pronto>;
> > +
> > +					bt {
> > +						compatible =3D "qcom,wcnss-bt";
> > +					};
> > +
> > +					wifi {
> > +						compatible =3D "qcom,wcnss-wlan";
> > +
> > +						interrupts =3D <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> > +							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> > +						interrupt-names =3D "tx", "rx";
> > +
> > +						qcom,smem-states =3D <&apps_smsm 10>, <&apps_smsm 9>;
> > +						qcom,smem-state-names =3D "tx-enable", "tx-rings-empty";
> > +					};
> > +				};
> > +			};
> > +		};
> > +
> >  		intc: interrupt-controller@b000000 {
> >  			compatible =3D "qcom,msm-qgic2";
> >  			interrupt-controller;
> > @@ -1070,6 +1338,116 @@ apcs: mailbox@b011000 {
> >  			#mbox-cells =3D <1>;
> >  		};
> > =20
> > +		lpass: remoteproc@c200000 {
> > +			compatible =3D "qcom,msm8953-adsp-pil";
> > +			reg =3D <0xc200000 0x100>;
> > +
> > +			interrupts-extended =3D <&intc 0 293 IRQ_TYPE_EDGE_RISING>,
> > +					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> > +					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> > +					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> > +					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> > +			interrupt-names =3D "wdog", "fatal", "ready",
> > +					  "handover", "stop-ack";
> > +			clocks =3D <&xo_board>;
> > +			clock-names =3D "xo";
> > +
> > +			power-domains =3D <&rpmpd MSM8953_VDDCX>;
> > +			power-domain-names =3D "cx";
> > +
> > +			memory-region =3D <&adsp_fw_mem>;
> > +
> > +			qcom,smem-states =3D <&smp2p_adsp_out 0>;
> > +			qcom,smem-state-names =3D "stop";
> > +
> > +			smd-edge {
> > +				interrupts =3D <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
> > +
> > +				label =3D "lpass";
> > +				mboxes =3D <&apcs 8>;
> > +				qcom,smd-edge =3D <1>;
> > +				qcom,remote-pid =3D <2>;
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +
> > +				apr {
> > +					compatible =3D "qcom,apr-v2";
> > +					qcom,smd-channels =3D "apr_audio_svc";
> > +					qcom,apr-domain =3D <APR_DOMAIN_ADSP>;
> > +					#address-cells =3D <1>;
> > +					#size-cells =3D <0>;
> > +
> > +					q6core {
> > +						reg =3D <APR_SVC_ADSP_CORE>;
> > +						compatible =3D "qcom,q6core";
> > +					};
> > +
> > +					q6afe: q6afe {
> > +						compatible =3D "qcom,q6afe";
> > +						reg =3D <APR_SVC_AFE>;
> > +						q6afedai: dais {
> > +							compatible =3D "qcom,q6afe-dais";
> > +							#address-cells =3D <1>;
> > +							#size-cells =3D <0>;
> > +							#sound-dai-cells =3D <1>;
> > +
> > +							dai@16 {
> > +								reg =3D <PRIMARY_MI2S_RX>;
> > +								qcom,sd-lines =3D <0 1>;
> > +							};
> > +
> > +							dai@21 {
> > +								reg =3D <TERTIARY_MI2S_TX>;
> > +								qcom,sd-lines =3D <0 1>;
> > +							};
> > +						};
> > +						q6afecc: clock-controller {
> > +							compatible =3D "qcom,q6afe-clocks";
> > +							#clock-cells =3D <2>;
> > +						};
> > +					};
> > +
> > +					q6asm: q6asm {
> > +						compatible =3D "qcom,q6asm";
> > +						reg =3D <APR_SVC_ASM>;
> > +						q6asmdai: dais {
> > +							compatible =3D "qcom,q6asm-dais";
> > +							#address-cells =3D <1>;
> > +							#size-cells =3D <0>;
> > +							#sound-dai-cells =3D <1>;
> > +
> > +							dai@0 {
> > +								reg =3D <MSM_FRONTEND_DAI_MULTIMEDIA1>;
> > +							};
> > +
> > +							dai@1 {
> > +								reg =3D <MSM_FRONTEND_DAI_MULTIMEDIA2>;
> > +							};
> > +
> > +							dai@2 {
> > +								reg =3D <MSM_FRONTEND_DAI_MULTIMEDIA3>;
> > +							};
> > +
> > +							dai@3 {
> > +								reg =3D <MSM_FRONTEND_DAI_MULTIMEDIA4>;
> > +								is-compress-dai;
> > +							};
> > +						};
> > +					};
> > +
> > +					q6adm: q6adm {
> > +						compatible =3D "qcom,q6adm";
> > +						reg =3D <APR_SVC_ADM>;
> > +						q6routing: routing {
> > +							compatible =3D "qcom,q6adm-routing";
> > +							#sound-dai-cells =3D <0>;
> > +						};
> > +					};
> > +				};
> > +			};
> > +
>
> Remove unneeded blank lines.

Will be fixed in v2
>
> > +		};
> > +
> >  		timer@b120000 {
> >  			compatible =3D "arm,armv7-timer-mem";
> >  			reg =3D <0xb120000 0x1000>;
>
>
> Best regards,
> Krzysztof

Thanks,
Sireesh Kodali
