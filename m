Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6949D465761
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353163AbhLAUv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353060AbhLAUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:49:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC29C0613F7;
        Wed,  1 Dec 2021 12:45:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73588B82144;
        Wed,  1 Dec 2021 20:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1286DC53FAD;
        Wed,  1 Dec 2021 20:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638391543;
        bh=rnMxgzm8Xi6FvujbwX1uMl8Xyi65bEq/oYN9gamb/wE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jhOp8ZUgPhAnA7ir4hH5iykrc4TjtutxHuEEM7FkCnl15gT/EvGwSsKSpgd8mQQxw
         8AW8i8vLAfYVj7/bCeqCq1NFt5HPiU/1prHP7/ukBDFXKLDXe2+hskiiYyPpc+V5ve
         5EYCm+ex8fJjNfrS2gPt2pp9cnWEhro01VbbUb1tBmtAi6aMlcUFe6tBk17qp5V4h0
         reqt2Jq/CZl8OtQcUpVjELvOFP6nnBqg/mwkGrbVUbReFqJlu0Ync/maNg/3vpaiUS
         OvYT7SGe6EmyT8W+LBr0bBKlKnaz5UH7lQGJxMLlaN3YTB6IQ2XTuSebkot9aoIsuX
         AZDBHd4ZoQJ6A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dee30442-8a78-07f3-1fa1-e5922a510182@somainline.org>
References: <20211114012755.112226-1-konrad.dybcio@somainline.org> <20211114012755.112226-4-konrad.dybcio@somainline.org> <20211130020536.52D0FC53FC7@smtp.kernel.org> <dee30442-8a78-07f3-1fa1-e5922a510182@somainline.org>
Subject: Re: [PATCH 04/16] arm64: dts: qcom: sm8350: Specify clock-frequency for arch timer
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Wed, 01 Dec 2021 12:45:41 -0800
User-Agent: alot/0.9.1
Message-Id: <20211201204543.1286DC53FAD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2021-11-30 11:59:03)
>=20
> On 30/11/2021 03:05, Stephen Boyd wrote:
> > Quoting Konrad Dybcio (2021-11-13 17:27:43)
> >> Arch timer runs at 19.2 MHz. Specify the rate in the timer node.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dt=
s/qcom/sm8350.dtsi
> >> index a30ba3193d84..60866a20a55c 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> >> @@ -2484,5 +2484,6 @@ timer {
> >>                               <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IR=
Q_TYPE_LEVEL_LOW)>,
> >>                               <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IR=
Q_TYPE_LEVEL_LOW)>,
> >>                               <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IR=
Q_TYPE_LEVEL_LOW)>;
> >> +               clock-frequency =3D <19200000>;
> > Does the firmware not set the frequency properly?
>=20
> It does on my device on the current firmware version (it wouldn't really =

> boot if it didn't, no?),
>=20
> but who knows if it always will, or if it always has been..
>=20
>=20
> It's present in downstream too, so I reckon it does not hurt to have it=20
> here too, even
>=20
> for completeness-of-describing-the-machine-properly sake.
>=20

No. We don't want dts files to have this. The property is only there to
workaround bad firmware that doesn't set the frequency. Please drop this
patch.
