Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70944A7FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiBCH1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:27:03 -0500
Received: from mail-4318.protonmail.ch ([185.70.43.18]:14491 "EHLO
        mail-4318.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiBCH0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:26:53 -0500
Date:   Thu, 03 Feb 2022 07:26:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1643873212;
        bh=ddOT8Uc+zAx4EeLE9VJ+W8yoFZ2uDF6RSAmpP8fOn38=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=GktgZuwNBhPEcmiAj46GnQIzzlfVCFT1cWQ8/pOe3btNIWqFD1/X1VQb92XU+IxsE
         1gcj6feRF3gFQ/dBRWkvqGG0VNOM03tYDhwLRBtq32LCGK0dUYz3X4rdxi+u16Rxpz
         1yFOdIY5qkPkO8dBuwMeSJpAffRjUzq3jc/XfbGimk6MePVPbwYGk5U6gyHBNVWHn2
         Kkz1jBws2fxMPM7+Xq8xrXVZckeutoZ/M30Ao+eON4LKr148sNZI+QMGDFG/EdHle4
         AoPb40U+tj0KUV9WTT3vFYOzhLLumG1ZiYS8JfDUXxdFPxtrAlSZkznvX8boRiDSgX
         MP2qLVTdQ/Wrw==
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v3 6/7] arm64: dts: qcom: qcs404: Rename CPU and CPR OPP tables
Message-ID: <20220203072226.51482-7-y.oudjana@protonmail.com>
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

Rename CPU and CPR OPP table node names to match the nodename pattern
defined in the opp-v2-base DT schema.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qco=
m/qcs404.dtsi
index 6db753b49326..3f06f7cd3cf2 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -110,7 +110,7 @@ CPU_SLEEP_0: cpu-sleep-0 {
 =09=09};
 =09};
=20
-=09cpu_opp_table: cpu-opp-table {
+=09cpu_opp_table: opp-table-cpu {
 =09=09compatible =3D "operating-points-v2-kryo-cpu";
 =09=09opp-shared;
=20
@@ -128,7 +128,7 @@ opp-1401600000 {
 =09=09};
 =09};
=20
-=09cpr_opp_table: cpr-opp-table {
+=09cpr_opp_table: opp-table-cpr {
 =09=09compatible =3D "operating-points-v2-qcom-level";
=20
 =09=09cpr_opp1: opp1 {
--=20
2.34.1


