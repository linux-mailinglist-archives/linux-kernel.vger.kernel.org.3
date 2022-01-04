Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9161B48487B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiADTYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbiADTYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:24:15 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D4EC061799
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 11:24:15 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id m18so34713159qtk.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 11:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZnN/ekIiFI7YDu1RJ14VoHgg/SvWeBKADvtqP6Xvao=;
        b=o3IVc42jFcW61803tFE5FwNQYrOrcDJBt+DpBKR5uHBrh1bIaC2CvcRT7+xRjVDY1C
         eNlSlKEPNweadCMc6tJLqAaW1gqfZru+NpeL4riqX7HJ/S4uztwgpm8heGbsidc/arJC
         h4hc3LJxW3BBrSxLZtvU8vGZIlgFHVLsx4/p3KyiyBOMu1NUvUrUQ75OWdBA3+LSrCkK
         14G9Sbev6IUGfziyQihxNOLBjUeSKoTfJVh8dKRPE6nKfHH+PFHeLEEHSXj8ECfygki8
         bxKohZwJjhj6MkPkOzGM/FpkjSbIh1l6ZLymV4fqCCxrmDRqa89Ge+vdfMRk331ptkG0
         qxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZnN/ekIiFI7YDu1RJ14VoHgg/SvWeBKADvtqP6Xvao=;
        b=0NXdp+unIibJn9Z7BztlOtQAbx1yw6sVjFznbTgTAzBc5Voyg4DqZOoxKRq1WVxoqL
         Jrt4qrIBMjSPPkJREg81iCJaIf13fHTgDAOSryELeRypeDZeo5xaec0vTwtXYlmbpgDy
         NMyzLU6ucRdVKKbv9jWa8+V3jEE2r/A0PaUG5P84QN6I+ZBoAT6olI4KzAHhqa0hKTd/
         b6K+c7M7OZz1YHZ5y8bbSBLMLafpBCyYQM643WLX0uKCHp8I0uxRZ3fnATJ7N28bgKDA
         kkxsSHbZpC7bKKbZu5fcW4RmA1Yth7gsJnhb1NEjvIAnndVAHEWO66r8ACApxwyMlih+
         XHBg==
X-Gm-Message-State: AOAM530XcIubm+BDPY/w9h0TlcQGfbhcvr3dpiJ+xknZSg3ObiBkrmIu
        FeByS3GxYbl8BeFMCczWJ5yGepTDCDQCmsBCY3TOLQAarzQ=
X-Google-Smtp-Source: ABdhPJzRhX3wsj4n4S42GkZmHF+WEnhBS9Xn3mENJeyyFeJGSZffN5l0EXkco/7DwanHHZ3LfAye1yMqBCcJxrDdO/M=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr46178448qtr.72.1641324254143;
 Tue, 04 Jan 2022 11:24:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641288286.git.quic_schowdhu@quicinc.com> <baf41480be71bd4472fe09c2993e43a780554d94.1641288286.git.quic_schowdhu@quicinc.com>
In-Reply-To: <baf41480be71bd4472fe09c2993e43a780554d94.1641288286.git.quic_schowdhu@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 4 Jan 2022 22:24:03 +0300
Message-ID: <CAA8EJpo-pLbWH3t0MN-pV0RV=0+wt47qcU3oDbaXcDG1NQq6ow@mail.gmail.com>
Subject: Re: [PATCH V3 5/7] arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, greg@kroah.com,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, satyap@codeaurora.org,
        pheragu@codeaurora.org, rnayak@codeaurora.org,
        sibis@codeaurora.org, saiprakash.ranjan@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 at 15:00, Souradeep Chowdhury
<quic_schowdhu@quicinc.com> wrote:
>
> Add the Embedded USB Debugger(EUD) device tree node. The
> node contains EUD base register region and EUD mode
> manager register regions along with the interrupt entry.
> Also add the connector to EUD which is mapped as the child
> of dwc3. The connector is attached to EUD via port. Also add
> the role-switch property to dwc3 node.
>
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 53a21d0..2d14e5c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1315,6 +1315,18 @@
>                                 phys = <&usb_2_hsphy>;
>                                 phy-names = "usb2-phy";
>                                 maximum-speed = "high-speed";
> +                               usb-role-switch;
> +                               usb_con: eud_usb_connector {

Is this node meant to be named connector instead?

> +                                       compatible = "qcom,usb-connector-eud",
> +                                                    "usb-c-connector";
> +                                       ports {
> +                                               port@0 {
> +                                                       usb2_role_switch: endpoint {
> +                                                               remote-endpoint = <&eud_ep>;
> +                                                       };
> +                                               };
> +                                       };
> +                               };
>                         };
>                 };
>
> @@ -1339,6 +1351,19 @@
>                         interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
> +               eud:  eud@88e0000 {
> +                       compatible = "qcom,sc7280-eud","qcom,eud";
> +                       reg = <0 0x88e0000 0 0x2000>,
> +                             <0 0x88e2000 0 0x1000>;
> +                       interrupt-parent = <&pdc>;
> +                       interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> +                       port {
> +                               eud_ep: endpoint {
> +                                       remote-endpoint = <&usb2_role_switch>;
> +                               };
> +                       };
> +               };
> +
>                 nsp_noc: interconnect@a0c0000 {
>                         reg = <0 0x0a0c0000 0 0x10000>;
>                         compatible = "qcom,sc7280-nsp-noc";
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
