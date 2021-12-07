Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4A46C81D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhLGXVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:21:21 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46678 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhLGXVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:21:20 -0500
Received: from thelio.attlocal.net (107-203-255-60.lightspeed.sntcca.sbcglobal.net [107.203.255.60])
        by linux.microsoft.com (Postfix) with ESMTPSA id EE0A420B717A;
        Tue,  7 Dec 2021 15:17:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE0A420B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638919069;
        bh=oha1VeSwUeFUa2B9cR0SR6HEB75tFmVVaPn/zPq+B+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVyptJ25UDcJyQlt6TB6f8eexUMmyXAdnG88Xvum1B1ERQTfTcOPGMhUY7mGaE2/7
         hlCIXOXan6U26W2CY8Ye7RlVTJPB3K6dOrOFw2/pvmYbZqhNO5LXFrKFxFUk1dPHue
         X5PsodW5qhBGOp8vJat3qlqWd2RWcU7yDKram8pY=
From:   Katherine Perez <kaperez@linux.microsoft.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: qcom: sm8350-duo2: enable battery charger
Date:   Tue,  7 Dec 2021 15:17:36 -0800
Message-Id: <20211207231736.1762503-2-kaperez@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211207231736.1762503-1-kaperez@linux.microsoft.com>
References: <20211207231736.1762503-1-kaperez@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the relevant qup and I2C nodes to enable the battery charger.

Signed-off-by: Katherine Perez <kaperez@linux.microsoft.com>
---

This patch depends on:
- https://lore.kernel.org/linux-arm-msm/20211122190552.74073-2-kaperez@linux.microsoft.com/
- https://lore.kernel.org/linux-arm-msm/20211114012755.112226-10-konrad.dybcio@somainline.org/

 .../boot/dts/qcom/sm8350-microsoft-surface-duo2.dts  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
index d4963c9015cb..00e2129cec22 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
@@ -282,6 +282,14 @@ &cdsp {
 	firmware-name = "qcom/sm8350/microsoft/cdsp.mbn";
 };

+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
 &ipa {
 	status = "okay";

@@ -297,6 +305,10 @@ &qupv3_id_0 {
 	status = "okay";
 };

+&qupv3_id_1 {
+	status = "okay";
+};
+
 &slpi {
 	status = "okay";
 	firmware-name = "qcom/sm8350/microsoft/slpi.mbn";
--
2.31.1

