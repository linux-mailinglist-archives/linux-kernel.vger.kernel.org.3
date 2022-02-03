Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8177C4A7FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbiBCHZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:25:47 -0500
Received: from mail-40140.protonmail.ch ([185.70.40.140]:39972 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiBCHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:25:44 -0500
Date:   Thu, 03 Feb 2022 07:25:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1643873143;
        bh=lOKwV9QwmnGefgwF0yxQqPFeIi3qE0U6ftnrx44o+cI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=mDlMGuLFG3rMbsYJvFNuuiaTTCpH/253YXUCRlLfsx1GE9bAIsmhbuKpofy8dJyLk
         S12XxhD9ip/OJOrFXx0gUbjusUvIO6bz+QpESJeEyrEdShE966PSoASFecwhvvWNje
         7CVPGgEDt/CQJjQlNSo4bpCjgoXN8+BiqCWoNEBIZLHsXWx//hd+dfmQCEVO0b2s2o
         1muHL59vH0396FHELNmzyeKnoMcm/BQ38Tfe9eT+GrMqA1xxIeM7+H3+bbiR3QSr4q
         KGyi6qQP1/bwSY0ZNduk63tsRRSd72zLYQdwOQpkBzj48qqmpuyOtbzF7uhO3/USk6
         CpVSTuDprCijg==
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v3 2/7] arm64: dts: qcom: msm8996-mtp: Add msm8996 compatible
Message-ID: <20220203072226.51482-3-y.oudjana@protonmail.com>
In-Reply-To: <20220203072226.51482-1-y.oudjana@protonmail.com>
References: <20220203072226.51482-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        T_SCC_BODY_TEXT_LINE shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom,msm8996 compatible to match DT schema.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts b/arch/arm64/boot/dts=
/qcom/msm8996-mtp.dts
index 7d9fc35bc7a0..6a1699a96c99 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
@@ -9,7 +9,7 @@
=20
 / {
 =09model =3D "Qualcomm Technologies, Inc. MSM 8996 MTP";
-=09compatible =3D "qcom,msm8996-mtp";
+=09compatible =3D "qcom,msm8996-mtp", "qcom,msm8996";
=20
 =09aliases {
 =09=09serial0 =3D &blsp2_uart2;
--=20
2.34.1


