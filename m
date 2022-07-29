Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF6584D57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiG2I2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiG2I15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:27:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5540F2980A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:26:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h8so5119671wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2u5OrUHUpOMO5fEyAlLsIDOLs93NcMBXwRg6aSJD9DA=;
        b=IRfHBuNRCPf3dfAa/Oe7k94E+8lxZitlK7DOyEhPW7X/zOUQk6SxKaid/iofF3vADw
         NtfIUq06xahkXxOKmIY2MXoaEeNzbBDh2fZ551x/yKuxVezuHgrj5KEgbXK5aOyzZx5g
         t48eXZsjmqkNVR8sRdkKD5Yj9Q6KE863bfutg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2u5OrUHUpOMO5fEyAlLsIDOLs93NcMBXwRg6aSJD9DA=;
        b=Az1BktOq6w59c0cS3KMql3k9dlglLJgCT+zlesZh4rFrydNoXWOvaAcqru+TvbJnMa
         bWkt4WwGMqeC1WXmi0LWJry9PXF5c328+Lbt5K74ML1Ar+ZObwls/lMB+XB4EKxp+MT1
         12SruHxfqpukIxIM6noOHKGlFPNOQns8dD1psnr3d3D30tnIgQVvhWjkZ0131Y2EgnUG
         Eimr+f8UCuuYQ+reLmomD21GaX6c2pR/Ck164jaZQusxHbt+zlBlysPW6oo3T/8IGwRh
         svQCXFMY4JTrvCXeeqgwZzbdLt9n61alTW180Ti6eHL20UGsKcpVMWMHXNKzUWINYJ2i
         KbKw==
X-Gm-Message-State: ACgBeo0JcpQs+G6m7Cu+cFHChv2LbT6bOf5hHdHMa4SXQXLHDCaRLgF8
        D66rpQQMKpn1q7seAabd+dERYJans8K+RBbAcCKASQ==
X-Google-Smtp-Source: AA6agR5FXdxHYMSCOAf3XvPso/HOt+pVRXDTIBRgpFGW9U0fv50u3omwYjhK7izsNPIcvrt0bqrPsE1OPlpLIy8gEnk=
X-Received: by 2002:a5d:4d0b:0:b0:21e:c456:e565 with SMTP id
 z11-20020a5d4d0b000000b0021ec456e565mr1582022wrt.3.1659083206728; Fri, 29 Jul
 2022 01:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220729032423.157144-1-treapking@chromium.org> <2719519a-4690-4cc8-42c3-f6089d888cce@collabora.com>
In-Reply-To: <2719519a-4690-4cc8-42c3-f6089d888cce@collabora.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 29 Jul 2022 16:26:35 +0800
Message-ID: <CAEXTbpfRWX_RfR6DU31NweLrGTOZTi_hCs-515xaW6x_McnJ5Q@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: mt8173-elm: Switch to SMC watchdog
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 4:01 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/07/22 05:24, Pin-yen Lin ha scritto:
> > Switch to SMC watchdog because we need direct control of HW watchdog
> > registers from kernel. The corresponding firmware was uploaded in
> > https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Rename the watchdog node (smc_watchdog -> watchdog)
> > - Correct the patch summary (mt8173-oak -> mt8173-elm)
> >
> > Changes in v3:
> > - Remove /delete-node/ and create a new node for SMC watchdog.
> >
> > Changes in v2:
> > - Move the modifications to mt8173-elm.dtsi and add some comments.
> >
> >   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > index e21feb85d822..421bb2945135 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > @@ -161,6 +161,19 @@ hdmi_connector_in: endpoint {
> >                       };
> >               };
> >       };
> > +
> > +
>
> You don't need two blank lines, just one is enough (please fix).

This is already addressed in v5. Thanks for the review though.
>
> After which:
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> > +     watchdog {
> > +             compatible = "arm,smc-wdt";
> > +     };
> > +};
> > +
> > +/*
> > + * Disable the original MMIO watch dog and switch to the SMC watchdog, which
> > + * operates on the same MMIO.
> > + */
> > +&watchdog {
> > +     status = "disabled";
> >   };
> >
> >   &mfg_async {
> >
>
>
