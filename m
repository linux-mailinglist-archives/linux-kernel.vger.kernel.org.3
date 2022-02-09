Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548AA4AF75D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiBIQ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiBIQ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:57:54 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6F6C05CB86;
        Wed,  9 Feb 2022 08:57:57 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id s1so2317798qtw.9;
        Wed, 09 Feb 2022 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c8ITlZ0TIJQYeuae8LzwclVS/gPvsuuD8tI1DH//ZB0=;
        b=Alj2+fWNY3w/xeBfw85sJE1/xxD0ShOPbSBvLdKBwssQQsn0birtT5YpUpPp62/q+l
         PTUpJ0ZQ1uHP87p3d9T/d9M5Q5vwW7sarhGKiaREvbGURzo4mZaWUx7BNsSDumcLfqKv
         WzzSzvl7PymNUz6YlyRWx1uOQ2Oz6mecincQhr/0uocFitMryIEtHsrSwCUBNx3dFBk9
         vh5Rn1ZV0Sy1LNax+QkgzRY2v5vHE+TXczdfIfiwxNJkSi2OTgEvuBn6KnnTCbjn7Anf
         MhCCHghukYiJxUMI/0aIMbGGN0nA89YZiXQuS1fEEKoW+9/qj9d7mwh2/ThmJaR6rUMb
         tPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c8ITlZ0TIJQYeuae8LzwclVS/gPvsuuD8tI1DH//ZB0=;
        b=NFwU0xHifaPENHCIQdjQr87rH4pstEEoRV6LBLLFOh1mU3+KYSivb3rwAuzU6oC6Pr
         e8wSqCLYPJzhaYUCJBDMPZIoO+SgKs4MBb5zitxUhUGZmPZf5XPBeC4OUBQdPTfhQPHI
         x22JEZXO1mlZFSALCmgSQsLKSMRAtmE/T0LsxFRBtev3rlUbS51PvoNRvmxNWJLJa6qI
         OnRAg/ovwcFDpbK6YYXwU/x0MOA3JhMtNFR1ylDTEBHEnJzJOaFE+lFcn6P3xdbXNVOP
         EXh2d7QD2Aw3h6i5TqZRmIaz3ipGaJHG43wbSy8A3p3ZvjoJ6EBpktu3nT52gEV+zBfZ
         ENzw==
X-Gm-Message-State: AOAM530wIi3I3LhVV3nDo7ELqD69fNv2KaeiilraT87+z5Zh0nMhThNe
        SGxTryg0UKo9n0I6Frkuz9o=
X-Google-Smtp-Source: ABdhPJwB5PRL11twhgVtT0TwmaAdjTIgn1YAjllT+KDbjpY+nLqyxDe2O1PYeY4gdan0ISECuelYdw==
X-Received: by 2002:ac8:7cab:: with SMTP id z11mr2004416qtv.384.1644425876371;
        Wed, 09 Feb 2022 08:57:56 -0800 (PST)
Received: from lumia-dev.localdomain. (pool-96-225-98-253.nwrknj.fios.verizon.net. [96.225.98.253])
        by smtp.googlemail.com with ESMTPSA id z19sm9629019qtj.77.2022.02.09.08.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:57:55 -0800 (PST)
From:   Jack Matthews <jm5112356@gmail.com>
Cc:     jm5112356@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: qcom: pm8226: add node for RTC
Date:   Wed,  9 Feb 2022 16:57:41 +0000
Message-Id: <20220209165742.652890-1-jm5112356@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209052929.651881-1-jm5112356@gmail.com>
References: <20220209052929.651881-1-jm5112356@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for PM8226's real time clock.

Signed-off-by: Jack Matthews <jm5112356@gmail.com>
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 872724490a5d..8ee628ce88a9 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -73,6 +73,13 @@ adc-chan@f {
 			};
 		};
 
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		pm8226_mpps: mpps@a000 {
 			compatible = "qcom,pm8226-mpp", "qcom,spmi-mpp";
 			reg = <0xa000>;
-- 
2.25.1

