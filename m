Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B0557700
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiFWJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiFWJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:46:40 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFC4992A;
        Thu, 23 Jun 2022 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VN/gxItLj1S4pTmaQgxml09ZgFAlkRuvprfFlWHnIfo=; b=brZEy544A3rz3ffLawbOmH7MPr
        J0IdOW78utzh9lSM1tj5ZkqmcvdKNIfhtCsa5AB7JQqVZUC5HMNcRgKG8gokZPXxqJAApzbHGkCml
        m08pdtA8McEkjHWfYYX9bIvgCkIAbY1YZrbsKwdqnIDobVtTRKAmHSTSS0HFsZJAd1ub3Jumd/uz1
        omTdFZLLlIiQcfezbfsSfmJ2Tz2JC7+2CNeFLc4Po63Jef1bTm+5j/ZxQCfbpcmlle9z9xlRbLrMN
        Cc/8JmbzW6Xj5V8z6ACcgOGetueSvj4SYsCZludKyGZHsOz5qZOFYMLMGsAq6k9Zlaxn0i1N6J2n9
        kk6x+O5w==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o4JPy-005qg2-NK; Thu, 23 Jun 2022 11:46:30 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 0/3] regulator: qcom_smd: Add PM8909 and fix pm8916_pldo range
Date:   Thu, 23 Jun 2022 11:46:11 +0200
Message-Id: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the voltage range for the pm8916_pldo in the qcom_smd-regulator
driver and add definitions for the regulators available in PM8909.

Stephan Gerhold (3):
  regulator: qcom_smd: Fix pm8916_pldo range
  regulator: dt-bindings: qcom,smd-rpm: Add PM8909
  regulator: qcom_smd: Add PM8909 RPM regulators

 .../regulator/qcom,smd-rpm-regulator.yaml     |  4 +++
 drivers/regulator/qcom_smd-regulator.c        | 28 +++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.30.2

