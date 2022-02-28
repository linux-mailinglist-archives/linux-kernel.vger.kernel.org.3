Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E84C64A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiB1IO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiB1IOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:14:31 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF57E4DF6E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:13:41 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id d3so11718135qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjU0aFLU81J7x3+xreJKb7q7VvFD5zjHGbYMGBTbZiI=;
        b=vOEm3/8NROInhW5wkSI1sTjn3qTNLqX8Hmvff+eQvOYSwustZxbn6MRueIdQd6nlfC
         kHXPAz7zQM5e1XDFDNgOoHZJccAxfUV8TMUfDfMslarY6k+nRWU1x6X8tn9P1ALMjmt2
         Xlld1b2lVGxdhiOPRaJ+K1bB5d5gDwfuxty3RDD4OFZu8kSnQkFOTiDVA5+DRVr1X3Q4
         bPjGtXAcakxauQLJ9ACzwdoUsD30TNUKPZaNiDZSGOdz/7Gk2TQvHtq0gDq0iWVfRB22
         WviHrneSPclLj2FF88oyBuTtHVi3C6XYafe6UoNxtqGN0l/Q1uidtKnVR3NUTYqZdg3W
         kpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjU0aFLU81J7x3+xreJKb7q7VvFD5zjHGbYMGBTbZiI=;
        b=ZJg42kJzuq0hDmZWQp/kovL8PLIpDiXb1ka0fBc2fePDSG0tkaP57nd4iCXp323Q4o
         WBiwKDdtwkkqm5uJBQiYzdsEw7Mb8VnBmwKp7+cOL70UWyOfEsPfPbsPt+dgKa5mPhcV
         E2n8AaKC+Ck8ViqYZslFJPF3EaBtCWiR9t6U3GqyKw/JMe2VKEfQOMD/TjvVtZ7bv3B4
         a5DsB+q3/mSE5TC+BeBIwsRliV4ri7vu21kPuzlpyBvVvGPTYx2prsvnTGE7nmJ2Xodt
         MYINWh85cBNMb1yncOwcg9osbdt2pooxnGUr1oLAmp0Zw25E5GrEAHmdMXDRKFWHiMKR
         OtkQ==
X-Gm-Message-State: AOAM532hw/qZS7pc/7F/K9Q4jGQvSfg3IA8y8HahZkZEWI/Jxxxs4TfL
        NmilE/93CZqY7dvmou8VVhSlRpXu/LO9wQJ7yw4GGQ==
X-Google-Smtp-Source: ABdhPJzsE+xw064/+plf2ba3aI2QPpiUZZeLlNOwsJ/usR8wujbOQkvdC+yFVuHfYX8y3C5q7FRsNBHFGugOv5CXziM=
X-Received: by 2002:ad4:4490:0:b0:432:fe1b:6e66 with SMTP id
 m16-20020ad44490000000b00432fe1b6e66mr4732864qvt.122.1646036020854; Mon, 28
 Feb 2022 00:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20220128025513.97188-1-bjorn.andersson@linaro.org> <20220128025513.97188-13-bjorn.andersson@linaro.org>
In-Reply-To: <20220128025513.97188-13-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 28 Feb 2022 11:13:30 +0300
Message-ID: <CAA8EJpq8hV3+EggEYwMnJMh8BKbsvbi_Y-PCFUniXM=cMtpqvg@mail.gmail.com>
Subject: Re: [PATCH 12/13] arm64: dts: qcom: sm8450: Add remoteproc enablers
 and instances
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 at 05:55, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The Qualcomm SM8450 carries the familiar set of audio, compute, sensor
> and modem remoteprocs. Add these and their dependencies.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 297 +++++++++++++++++++++++++++
>  1 file changed, 297 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 10c25ad2d0c7..24fb3d3e667b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/clock/qcom,gcc-sm8450.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>
> @@ -460,6 +461,15 @@ cvp_mem: memory@9ee00000 {
>                         no-map;
>                 };
>
> +               rmtfs_mem: memory@9fd00000 {
> +                       compatible = "qcom,rmtfs-mem";
> +                       reg = <0x0 0x9fd00000 0x0 0x280000>;
> +                       no-map;
> +
> +                       qcom,client-id = <1>;
> +                       qcom,vmid = <15>;
> +               };
> +
>                 global_sync_mem: memory@a6f00000 {
>                         reg = <0x0 0xa6f00000 0x0 0x100000>;
>                         no-map;
> @@ -540,6 +550,113 @@ trusted_apps_ext_mem: memory@ed900000 {
>                 };
>         };
>
> +       smp2p-adsp {
> +               compatible = "qcom,smp2p";
> +               qcom,smem = <443>, <429>;
> +               interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +                                            IPCC_MPROC_SIGNAL_SMP2P
> +                                            IRQ_TYPE_EDGE_RISING>;
> +               mboxes = <&ipcc IPCC_CLIENT_LPASS
> +                               IPCC_MPROC_SIGNAL_SMP2P>;
> +
> +               qcom,local-pid = <0>;
> +               qcom,remote-pid = <2>;
> +
> +               smp2p_adsp_out: master-kernel {
> +                       qcom,entry-name = "master-kernel";
> +                       #qcom,smem-state-cells = <1>;
> +               };
> +
> +               smp2p_adsp_in: slave-kernel {
> +                       qcom,entry-name = "slave-kernel";
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +       };
> +
> +       smp2p-cdsp {
> +               compatible = "qcom,smp2p";
> +               qcom,smem = <94>, <432>;
> +               interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
> +                                            IPCC_MPROC_SIGNAL_SMP2P
> +                                            IRQ_TYPE_EDGE_RISING>;
> +               mboxes = <&ipcc IPCC_CLIENT_CDSP
> +                               IPCC_MPROC_SIGNAL_SMP2P>;
> +
> +               qcom,local-pid = <0>;
> +               qcom,remote-pid = <5>;
> +
> +               smp2p_cdsp_out: master-kernel {
> +                       qcom,entry-name = "master-kernel";
> +                       #qcom,smem-state-cells = <1>;
> +               };
> +
> +               smp2p_cdsp_in: slave-kernel {
> +                       qcom,entry-name = "slave-kernel";
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +       };
> +
> +       smp2p-modem {
> +               compatible = "qcom,smp2p";
> +               qcom,smem = <435>, <428>;
> +               interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
> +                                            IPCC_MPROC_SIGNAL_SMP2P
> +                                            IRQ_TYPE_EDGE_RISING>;
> +               mboxes = <&ipcc IPCC_CLIENT_MPSS
> +                               IPCC_MPROC_SIGNAL_SMP2P>;
> +
> +               qcom,local-pid = <0>;
> +               qcom,remote-pid = <1>;
> +
> +               smp2p_modem_out: master-kernel {
> +                       qcom,entry-name = "master-kernel";
> +                       #qcom,smem-state-cells = <1>;
> +               };
> +
> +               smp2p_modem_in: slave-kernel {
> +                       qcom,entry-name = "slave-kernel";
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               ipa_smp2p_out: ipa-ap-to-modem {
> +                       qcom,entry-name = "ipa";
> +                       #qcom,smem-state-cells = <1>;
> +               };
> +
> +               ipa_smp2p_in: ipa-modem-to-ap {
> +                       qcom,entry-name = "ipa";
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +       };
> +
> +       smp2p-slpi {
> +               compatible = "qcom,smp2p";
> +               qcom,smem = <481>, <430>;
> +               interrupts-extended = <&ipcc IPCC_CLIENT_SLPI
> +                                            IPCC_MPROC_SIGNAL_SMP2P
> +                                            IRQ_TYPE_EDGE_RISING>;
> +               mboxes = <&ipcc IPCC_CLIENT_SLPI
> +                               IPCC_MPROC_SIGNAL_SMP2P>;
> +
> +               qcom,local-pid = <0>;
> +               qcom,remote-pid = <3>;
> +
> +               smp2p_slpi_out: master-kernel {
> +                       qcom,entry-name = "master-kernel";
> +                       #qcom,smem-state-cells = <1>;
> +               };
> +
> +               smp2p_slpi_in: slave-kernel {
> +                       qcom,entry-name = "slave-kernel";
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +       };
> +
>         soc: soc@0 {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
> @@ -672,6 +789,167 @@ usb_1_ssphy: phy@88e9200 {
>                         };
>                 };
>
> +               remoteproc_slpi: remoteproc@2400000 {
> +                       compatible = "qcom,sm8350-slpi-pas";

I think this should be sm8450-slpi-pas.

Otherwise:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +                       reg = <0 0x02400000 0 0x4000>;
> +
> +                       interrupts-extended = <&pdc 9 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&smp2p_slpi_in 0 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_slpi_in 1 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_slpi_in 2 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_slpi_in 3 IRQ_TYPE_EDGE_RISING>;
> +                       interrupt-names = "wdog", "fatal", "ready",
> +                                         "handover", "stop-ack";
> +
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>;
> +                       clock-names = "xo";
> +
> +                       power-domains = <&rpmhpd SM8450_LCX>,
> +                                       <&rpmhpd SM8450_LMX>;
> +                       power-domain-names = "lcx", "lmx";
> +
> +                       memory-region = <&slpi_mem>;
> +
> +                       qcom,qmp = <&aoss_qmp>;
> +
> +                       qcom,smem-states = <&smp2p_slpi_out 0>;
> +                       qcom,smem-state-names = "stop";
> +
> +                       status = "disabled";
> +
> +                       glink-edge {
> +                               interrupts-extended = <&ipcc IPCC_CLIENT_SLPI
> +                                                            IPCC_MPROC_SIGNAL_GLINK_QMP
> +                                                            IRQ_TYPE_EDGE_RISING>;
> +                               mboxes = <&ipcc IPCC_CLIENT_SLPI
> +                                               IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +                               label = "slpi";
> +                               qcom,remote-pid = <3>;
> +                       };
> +               };
> +
> +               remoteproc_adsp: remoteproc@30000000 {
> +                       compatible = "qcom,sm8450-adsp-pas";
> +                       reg = <0 0x030000000 0 0x100>;
> +
> +                       interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +                       interrupt-names = "wdog", "fatal", "ready",
> +                                         "handover", "stop-ack";
> +
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>;
> +                       clock-names = "xo";
> +
> +                       power-domains = <&rpmhpd SM8450_LCX>,
> +                                       <&rpmhpd SM8450_LMX>;
> +                       power-domain-names = "lcx", "lmx";
> +
> +                       memory-region = <&adsp_mem>;
> +
> +                       qcom,qmp = <&aoss_qmp>;
> +
> +                       qcom,smem-states = <&smp2p_adsp_out 0>;
> +                       qcom,smem-state-names = "stop";
> +
> +                       status = "disabled";
> +
> +                       remoteproc_adsp_glink: glink-edge {
> +                               interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
> +                                                            IPCC_MPROC_SIGNAL_GLINK_QMP
> +                                                            IRQ_TYPE_EDGE_RISING>;
> +                               mboxes = <&ipcc IPCC_CLIENT_LPASS
> +                                               IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +                               label = "lpass";
> +                               qcom,remote-pid = <2>;
> +                       };
> +               };
> +
> +               remoteproc_cdsp: remoteproc@32300000 {
> +                       compatible = "qcom,sm8450-cdsp-pas";
> +                       reg = <0 0x032300000 0 0x1400000>;
> +
> +                       interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +                       interrupt-names = "wdog", "fatal", "ready",
> +                                         "handover", "stop-ack";
> +
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>;
> +                       clock-names = "xo";
> +
> +                       power-domains = <&rpmhpd SM8450_CX>,
> +                                       <&rpmhpd SM8450_MXC>;
> +                       power-domain-names = "cx", "mxc";
> +
> +                       memory-region = <&cdsp_mem>;
> +
> +                       qcom,qmp = <&aoss_qmp>;
> +
> +                       qcom,smem-states = <&smp2p_cdsp_out 0>;
> +                       qcom,smem-state-names = "stop";
> +
> +                       status = "disabled";
> +
> +                       glink-edge {
> +                               interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
> +                                                            IPCC_MPROC_SIGNAL_GLINK_QMP
> +                                                            IRQ_TYPE_EDGE_RISING>;
> +                               mboxes = <&ipcc IPCC_CLIENT_CDSP
> +                                               IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +                               label = "cdsp";
> +                               qcom,remote-pid = <5>;
> +                       };
> +               };
> +
> +               remoteproc_mpss: remoteproc@4080000 {
> +                       compatible = "qcom,sm8450-mpss-pas";
> +                       reg = <0x0 0x04080000 0x0 0x4040>;
> +
> +                       interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
> +                                             <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
> +                       interrupt-names = "wdog", "fatal", "ready", "handover",
> +                                         "stop-ack", "shutdown-ack";
> +
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>;
> +                       clock-names = "xo";
> +
> +                       power-domains = <&rpmhpd 0>,
> +                                       <&rpmhpd 12>;
> +                       power-domain-names = "cx", "mss";
> +
> +                       memory-region = <&mpss_mem>;
> +
> +                       qcom,qmp = <&aoss_qmp>;
> +
> +                       qcom,smem-states = <&smp2p_modem_out 0>;
> +                       qcom,smem-state-names = "stop";
> +
> +                       status = "disabled";
> +
> +                       glink-edge {
> +                               interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
> +                                                            IPCC_MPROC_SIGNAL_GLINK_QMP
> +                                                            IRQ_TYPE_EDGE_RISING>;
> +                               mboxes = <&ipcc IPCC_CLIENT_MPSS
> +                                               IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +                               interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
> +                               label = "modem";
> +                               qcom,remote-pid = <1>;
> +                       };
> +               };
> +
>                 pdc: interrupt-controller@b220000 {
>                         compatible = "qcom,sm8450-pdc", "qcom,pdc";
>                         reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
> @@ -682,6 +960,25 @@ pdc: interrupt-controller@b220000 {
>                         interrupt-controller;
>                 };
>
> +               aoss_qmp: power-controller@c300000 {
> +                       compatible = "qcom,sm8450-aoss-qmp", "qcom,aoss-qmp";
> +                       reg = <0 0x0c300000 0 0x400>;
> +                       interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
> +                                                    IRQ_TYPE_EDGE_RISING>;
> +                       mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +                       #clock-cells = <0>;
> +               };
> +
> +               ipcc: mailbox@ed18000 {
> +                       compatible = "qcom,sm8450-ipcc", "qcom,ipcc";
> +                       reg = <0 0x0ed18000 0 0x1000>;
> +                       interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <3>;
> +                       #mbox-cells = <2>;
> +               };
> +
>                 tlmm: pinctrl@f100000 {
>                         compatible = "qcom,sm8450-tlmm";
>                         reg = <0 0x0f100000 0 0x300000>;
> --
> 2.33.1
>


-- 
With best wishes
Dmitry
