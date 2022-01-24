Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D24980B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiAXNOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:14:18 -0500
Received: from h02mx15.reliablemail.org ([185.76.66.168]:62218 "EHLO
        h02mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiAXNOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:14:15 -0500
X-Halon-Out: 86062a3b-7d17-11ec-930f-f5be715b97e5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Hs30SCQ/jWxFUDw4ns4z3eTZCUhu8c8Ibsh6oaOmo7I=; b=skw+mAqvoL6kZ2FCFZ2CnS6/o1
        Vu1P2rMWDSx4Jpy1wFPSu1Vzh8jKXIZTUJS56fSHZxTwUeU/xJxaTefdP8Czb4HdRzFllW3yyuQDf
        7rV7yjfTOsgXiqjB0AXp8T0d8AxjgmLx/L0Rmv2xLdsUaoZF0uzxeRmo10lltMQrbFkPtovuMFEXr
        Jm1GwnysLVNH6HXD7SX1tG/RP4kAas9KtGqIJ80jF8hvUYi4AKxQV3xBhT0hkVZg54yJk46TEi5pD
        QusVetw59GAOUGyY7QWZQwFCC6jx2lFnQIssuOZlMicYKBVXrshnH2V+WP2YSrCLTl6rRw9YXupfi
        QAJZmw3g==;
From:   Henrik Grimler <henrik@grimler.se>
To:     krzysztof.kozlowski@canonical.com, semen.protsenko@linaro.org,
        virag.david003@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 0/2] ARM: dts: exynos: Add support for Samsung Klimt WiFi
Date:   Mon, 24 Jan 2022 14:12:39 +0100
Message-Id: <20220124131241.29946-1-henrik@grimler.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Klimt WiFi has product name Samsung Galaxy Tab S 8.4" and was released
in 2014.  It has similar hardware to exynos5420-chagall-wifi and the
two devices can hence share a common base dtsi. 

Same issues as for Chagall Wifi applies: CCI has to be disabled and
only 4 out of 8 CPUs are brought up at boot (see
https://lore.kernel.org/r/20220118185746.299832-4-henrik@grimler.se).

Henrik Grimler (2):
  dt-bindings: arm: samsung: document Klimt WiFi board binding
  ARM: dts: Add support for Samsung Klimt WiFi

 .../bindings/arm/samsung/samsung-boards.yaml  |  1 +
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/exynos5420-klimt-wifi.dts   | 75 +++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5420-klimt-wifi.dts


base-commit: e758cdb29e81cee1d53e1a06bb3db0a32fc8c347
-- 
2.34.1

