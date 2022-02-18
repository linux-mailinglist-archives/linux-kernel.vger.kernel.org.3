Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD74BBD13
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiBRQLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:11:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbiBRQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:11:05 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3EC2B2FD4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:10:44 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p9so15356235wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lEE7dYL6DVeu4YYIpw0qrf64o8dpD36nUv9K8vPifHE=;
        b=yQZxenO/mK7VEYTdjKTfHhXVvvGUoniBYAAKlI+VujFE0IuM0jQc6NBX+IxdL8P2aO
         hvLnhq5wI3j+3X7X0rSHpMzbYHuP5NEN5Atz/lPZajsv62MjKMmyrfDduXsU+1lnJkLe
         JJVGpmJJSwZxRkQHxV4SpVA8yHkgAsXRGHREILvQrz94FI9Pw1Rat6h8vsJyGfRH7hux
         7n9Ul4sUnY8vMAvNl1u1FXF0UksUBr0LF5eLM6LTBIi8nkqTMPVsVG9ka/o5z5/jrgau
         6Oznwp+TjWaLE/809ukPHgAufz5dC7Rqn/vdOhL2qsmmLayjDm99EZlmlkgFE6BOUt4A
         avFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lEE7dYL6DVeu4YYIpw0qrf64o8dpD36nUv9K8vPifHE=;
        b=JmgKHjDGekPvtk6azRpsVcK23hSe/CRxK7V0OkaYPoY3+ZWQkc5uChKZ2GDkTf5QJl
         AdmNwo6olL4MlXih6pJZyKgYWMrzmca5z7L/DHl+rwkLMZ0Y9pV/d9PyoMjpwOZPRmOU
         b+Kr7oh9VqT/9QWxcc9RiCRL+KLeLtR1RRTqHw088MSkw54Lekew9LPk8AxG9XYK5Hrh
         0T1qbi8v10SLEB3hJ7Kv1eGznyhXQQgNT+bA8E/xiTaKMPdUZSugmqog/knIsDOQIOUj
         5Br1pwfntIPHKIiBA8Gj4syJFbj8ywb4YH6eU6kzSOTBeDzES/yLIwk4vKwnQZlBOsD3
         tzBQ==
X-Gm-Message-State: AOAM531jdLHWZqZ/raw4C532LgzGAq2nvXEWbw6MbTrTqL0FgZkMaNCg
        CAp6FgP31qnthTjV2JW66snvqJ5Y1xUFOyReyrZpSw==
X-Google-Smtp-Source: ABdhPJxVAEM8FheVv0aHRn85lptlhzuGSJtXhZh+8SfzBEiMNrxN3C2HWYYp4SI5S1hNi/dKhRHa4UjhGidwtrWPff4=
X-Received: by 2002:a5d:56cd:0:b0:1e3:2f61:3a20 with SMTP id
 m13-20020a5d56cd000000b001e32f613a20mr6660058wrw.619.1645200643190; Fri, 18
 Feb 2022 08:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com> <20220209105706.18852-11-quic_jinlmao@quicinc.com>
In-Reply-To: <20220209105706.18852-11-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 18 Feb 2022 16:10:32 +0000
Message-ID: <CAJ9a7VgzrKpk3wGfELiYt2uiVHDe3DV9t7u9zk0xvsT96Q3gQw@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] ARM: dts: msm: Add coresight components for SM8250
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It would appear here that normal coresight funnels appear between tpdm
and tpda devices. This is contrary to my understanding of your
hardware and the descriptions and conversations we had in patch 00/10
in this set.

trace path appears to be

tpdm_mm => funnel@6c0b000 =>  funnel@6c2d000 => tpda@6004000 =>
funnel@6005000 => rest of ATB

The documentation states that the TPDA is responsible for for
funneling and packetising - so why do we have extra funnels?

I have no way of knowing if that topology is right or wrong. Are the
funnels between tpdm and tpda actual coresight funnels, a component
that is register compatible with CS funnels but designed for the TPDM
/ TPDA transport, or the funnels are being used, but without driving
ATID from the sources.

It is difficult to review this set without better information on the
hardware represented.

Regards

Mike


On Wed, 9 Feb 2022 at 10:58, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Add coresight device tree for sm8250. STM/ETM/TPDM are added.
>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../arm64/boot/dts/qcom/sm8250-coresight.dtsi | 690 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +
>  2 files changed, 692 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi b/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
> new file mode 100644
> index 000000000000..732dab7f8674
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
> @@ -0,0 +1,690 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +&soc {
> +
> +       stm@6002000 {
> +               compatible = "arm,coresight-stm", "arm,primecell";
> +               reg = <0 0x06002000 0 0x1000>,
> +                     <0 0x16280000 0 0x180000>;
> +               reg-names = "stm-base", "stm-stimulus-base";
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               stm_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&funnel0_in7>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       funnel@6041000 {
> +               compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +               reg = <0 0x06041000 0 0x1000>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               funnel0_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&merge_funnel_in0>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@6 {
> +                               reg = <6>;
> +                               funnel_in0_in_funnel_qatb: endpoint {
> +                                       remote-endpoint =
> +                                               <&funnel_qatb_out_funnel_in0>;
> +                               };
> +                       };
> +
> +                       port@7 {
> +                               reg = <7>;
> +                               funnel0_in7: endpoint {
> +                                       remote-endpoint = <&stm_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       funnel@6042000 {
> +               compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +               reg = <0 0x06042000 0 0x1000>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               funnel2_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&merge_funnel_in2>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@2 {
> +                               reg = <4>;
> +                               funnel2_in5: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_merge_funnel_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       funnel@6b04000 {
> +               compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +               arm,primecell-periphid = <0x000bb908>;
> +
> +               reg = <0 0x6b04000 0 0x1000>;
> +               reg-names = "funnel-base";
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               merge_funnel_out: endpoint {
> +                                       remote-endpoint =
> +                                               <&etf_in>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@7 {
> +                               reg = <7>;
> +                               funnel_swao_in_funnel_merg: endpoint {
> +                                       remote-endpoint=
> +                                               <&funnel_merg_out_funnel_swao>;
> +                               };
> +                       };
> +               };
> +
> +       };
> +
> +       funnel@6045000 {
> +               compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +               reg = <0 0x06045000 0 0x1000>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               funnel_merg_out_funnel_swao: endpoint {
> +                                       remote-endpoint = <&funnel_swao_in_funnel_merg>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@1 {
> +                               reg = <0>;
> +                               merge_funnel_in0: endpoint {
> +                                       remote-endpoint =
> +                                         <&funnel0_out>;
> +                               };
> +                       };
> +
> +                       port@2 {
> +                               reg = <1>;
> +                               merge_funnel_in2: endpoint {
> +                                       remote-endpoint =
> +                                         <&funnel2_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       replicator@6046000 {
> +               compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +               reg = <0 0x06046000 0 0x1000>;
> +
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               replicator_out: endpoint {
> +                                       remote-endpoint = <&etr_in>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       port {
> +                               replicator_cx_in_swao_out: endpoint {
> +                                       remote-endpoint = <&replicator_swao_out_cx_in>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       replicator@6b06000 {
> +               compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +               reg = <0 0x06b06000 0 0x1000>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               replicator_swao_out_cx_in: endpoint {
> +                                       remote-endpoint = <&replicator_cx_in_swao_out>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       port {
> +                               replicator_in: endpoint {
> +                                       remote-endpoint = <&etf_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       etf@6b05000 {
> +               compatible = "arm,coresight-tmc", "arm,primecell";
> +               reg = <0 0x6b05000 0 0x1000>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               etf_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&replicator_in>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@1 {
> +                               reg = <0>;
> +                               etf_in: endpoint {
> +                                       remote-endpoint =
> +                                         <&merge_funnel_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       etr@6048000 {
> +               compatible = "arm,coresight-tmc", "arm,primecell";
> +               reg = <0 0x06048000 0 0x1000>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +               arm,scatter-gather;
> +
> +               in-ports {
> +                       port {
> +                               etr_in: endpoint {
> +                                       remote-endpoint =
> +                                         <&replicator_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       etm@7040000 {
> +               compatible = "arm,coresight-etm4x", "arm,primecell";
> +               reg = <0 0x07040000 0 0x1000>;
> +
> +               cpu = <&CPU0>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +               arm,coresight-loses-context-with-cpu;
> +
> +               out-ports {
> +                       port {
> +                               etm0_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_funnel_in0>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       etm@7140000 {
> +               compatible = "arm,coresight-etm4x", "arm,primecell";
> +               reg = <0 0x07140000 0 0x1000>;
> +
> +               cpu = <&CPU1>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +               arm,coresight-loses-context-with-cpu;
> +
> +               out-ports {
> +                       port {
> +                               etm1_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_funnel_in1>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       etm@7240000 {
> +               compatible = "arm,coresight-etm4x", "arm,primecell";
> +               reg = <0 0x07240000 0 0x1000>;
> +
> +               cpu = <&CPU2>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +               arm,coresight-loses-context-with-cpu;
> +
> +               out-ports {
> +                       port {
> +                               etm2_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_funnel_in2>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       etm@7340000 {
> +               compatible = "arm,coresight-etm4x", "arm,primecell";
> +               reg = <0 0x07340000 0 0x1000>;
> +
> +               cpu = <&CPU3>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +               arm,coresight-loses-context-with-cpu;
> +
> +               out-ports {
> +                       port {
> +                               etm3_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_funnel_in3>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       etm@7440000 {
> +               compatible = "arm,coresight-etm4x", "arm,primecell";
> +               reg = <0 0x07440000 0 0x1000>;
> +
> +               cpu = <&CPU4>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +               arm,coresight-loses-context-with-cpu;
> +
> +               out-ports {
> +                       port {
> +                               etm4_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_funnel_in4>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       etm@7540000 {
> +               compatible = "arm,coresight-etm4x", "arm,primecell";
> +               reg = <0 0x07540000 0 0x1000>;
> +
> +               cpu = <&CPU5>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +               arm,coresight-loses-context-with-cpu;
> +
> +               out-ports {
> +                       port {
> +                               etm5_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_funnel_in5>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       etm@7640000 {
> +               compatible = "arm,coresight-etm4x", "arm,primecell";
> +               reg = <0 0x07640000 0 0x1000>;
> +
> +               cpu = <&CPU6>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +               arm,coresight-loses-context-with-cpu;
> +
> +               out-ports {
> +                       port {
> +                               etm6_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_funnel_in6>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       etm@7740000 {
> +               compatible = "arm,coresight-etm4x", "arm,primecell";
> +               reg = <0 0x07740000 0 0x1000>;
> +
> +               cpu = <&CPU7>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +               arm,coresight-loses-context-with-cpu;
> +
> +               out-ports {
> +                       port {
> +                               etm7_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_funnel_in7>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       funnel@7800000 {
> +               compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +               reg = <0 0x07800000 0 0x1000>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               apss_funnel_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_merge_funnel_in>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +                               apss_funnel_in0: endpoint {
> +                                       remote-endpoint =
> +                                         <&etm0_out>;
> +                               };
> +                       };
> +
> +                       port@1 {
> +                               reg = <1>;
> +                               apss_funnel_in1: endpoint {
> +                                       remote-endpoint =
> +                                         <&etm1_out>;
> +                               };
> +                       };
> +
> +                       port@2 {
> +                               reg = <2>;
> +                               apss_funnel_in2: endpoint {
> +                                       remote-endpoint =
> +                                         <&etm2_out>;
> +                               };
> +                       };
> +
> +                       port@3 {
> +                               reg = <3>;
> +                               apss_funnel_in3: endpoint {
> +                                       remote-endpoint =
> +                                         <&etm3_out>;
> +                               };
> +                       };
> +
> +                       port@4 {
> +                               reg = <4>;
> +                               apss_funnel_in4: endpoint {
> +                                       remote-endpoint =
> +                                         <&etm4_out>;
> +                               };
> +                       };
> +
> +                       port@5 {
> +                               reg = <5>;
> +                               apss_funnel_in5: endpoint {
> +                                       remote-endpoint =
> +                                         <&etm5_out>;
> +                               };
> +                       };
> +
> +                       port@6 {
> +                               reg = <6>;
> +                               apss_funnel_in6: endpoint {
> +                                       remote-endpoint =
> +                                         <&etm6_out>;
> +                               };
> +                       };
> +
> +                       port@7 {
> +                               reg = <7>;
> +                               apss_funnel_in7: endpoint {
> +                                       remote-endpoint =
> +                                         <&etm7_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       funnel@7810000 {
> +               compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +               reg = <0 0x07810000 0 0x1000>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               apss_merge_funnel_out: endpoint {
> +                                       remote-endpoint =
> +                                         <&funnel2_in5>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       port@1 {
> +                               reg = <0>;
> +                               apss_merge_funnel_in: endpoint {
> +                                       remote-endpoint =
> +                                         <&apss_funnel_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       tpdm_mm: mm.tpdm@6c08000 {
> +               compatible = "arm,primecell";
> +               reg = <0 0x6c08000 0 0x1000>;
> +               reg-names = "tpdm-base";
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               qcom,msr-fix-req;
> +
> +               out-ports {
> +                       port {
> +                               tpdm_mm_out_funnel_dl_mm: endpoint {
> +                                       remote-endpoint =
> +                                               <&funnel_dl_mm_in_tpdm_mm>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       funnel@6c0b000 {
> +               compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +
> +               reg = <0 0x6c0b000 0 0x1000>;
> +               reg-names = "funnel-base";
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               funnel_dl_mm_out_funnel_dl_center: endpoint {
> +                                       remote-endpoint =
> +                                         <&funnel_dl_center_in_funnel_dl_mm>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@3 {
> +                               reg = <3>;
> +                               funnel_dl_mm_in_tpdm_mm: endpoint {
> +                                       remote-endpoint =
> +                                           <&tpdm_mm_out_funnel_dl_mm>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       funnel@6c2d000 {
> +               compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +
> +               reg = <0 0x6c2d000 0 0x1000>;
> +               reg-names = "funnel-base";
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       port {
> +                               tpdm_mm_out_tpda9: endpoint {
> +                                       remote-endpoint =
> +                                           <&tpda_9_in_tpdm_mm>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@2 {
> +                               reg = <2>;
> +                               funnel_dl_center_in_funnel_dl_mm: endpoint {
> +                                       remote-endpoint =
> +                                       <&funnel_dl_mm_out_funnel_dl_center>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       tpda@6004000 {
> +               compatible = "arm,primecell";
> +               reg = <0 0x6004000 0 0x1000>;
> +               reg-names = "tpda-base";
> +
> +               qcom,tpda-atid = <65>;
> +
> +               qcom,dsb-elem-size = <9 32>,
> +                                    <10 32>,
> +                                    <14 32>;
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               reg = <0>;
> +                               tpda_out_funnel_qatb: endpoint {
> +                                       remote-endpoint =
> +                                               <&funnel_qatb_in_tpda>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@9 {
> +                               reg = <9>;
> +                               tpda_9_in_tpdm_mm: endpoint {
> +                                       remote-endpoint =
> +                                               <&tpdm_mm_out_tpda9>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       funnel@6005000 {
> +               compatible = "arm,primecell";
> +
> +               reg = <0 0x6005000 0 0x1000>;
> +               reg-names = "funnel-base";
> +
> +               clocks = <&aoss_qmp>;
> +               clock-names = "apb_pclk";
> +
> +               out-ports {
> +                       port {
> +                               funnel_qatb_out_funnel_in0: endpoint {
> +                                       remote-endpoint =
> +                                               <&funnel_in0_in_funnel_qatb>;
> +                               };
> +                       };
> +               };
> +
> +               in-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +                               funnel_qatb_in_tpda: endpoint {
> +                                       remote-endpoint =
> +                                               <&tpda_out_funnel_qatb>;
> +                               };
> +                       };
> +               };
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 5617a46e5ccd..d1837e3df30a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -5323,3 +5323,5 @@
>                 };
>         };
>  };
> +
> +#include "sm8250-coresight.dtsi"
> --
> 2.17.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
