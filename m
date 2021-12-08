Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2E46D11A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhLHKhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:37:15 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:50810 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231719AbhLHKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:37:14 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B87q3lr026303;
        Wed, 8 Dec 2021 11:33:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=P36ACckomRJzc3ICzuCqXxXmZ50KyTa2Lr3uk/ttIpE=;
 b=tD2sZLFMRHB3Xy+QWKXT2RQSNRzyjkwaniZPp0R+ZIPra/u99V116iowJpFUXpglP3Fl
 XTnMR4xurk6w5XDlGByyTgtZGf1P5VyJNpeyutCO6OtSGNy9sdYP1M611X5fuginuf8B
 TaBVF6hRV8jNFAnjqDMJi8p/4N7l17vxEVwXbioSwjheKuTu2/ah4Ob3EWJ9beL4FMb7
 9xt7O+Mktbo9RdnvXFBHyRf0+KsS502A9eSbO4lKoDdRx8VeYXJr7ZXNLo2TMuY1INTG
 12ryU2qR7cJc9J4GXw1DR3KcFPnFLvEg1f5KZ+XKI4TM+oHKjptgFyMIv6og5Nr4G2n7 cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ctrpq8x4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 11:33:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 75EAD10002A;
        Wed,  8 Dec 2021 11:33:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6AF8E23153B;
        Wed,  8 Dec 2021 11:33:23 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 8 Dec 2021 11:33:23
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>
CC:     <olivier.moysan@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/2] ARM: dts: stm32: remove timer duplicate unit-address on stm32f4 series
Date:   Wed, 8 Dec 2021 11:33:14 +0100
Message-ID: <1638959596-6656-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_03,2021-12-08_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a series of warnings seen when building with W=1, like:
Warning (unique_unit_address): /soc/timer@40000c00: duplicate unit-address
(also used in node /soc/timers@40000c00)

This approach is based on some discussions[1], to restructure the dtsi
and dts files.
[1] https://lore.kernel.org/linux-arm-kernel/Yaf4jiZIp8+ndaXs@robh.at.kernel.org/

Fabrice Gasnier (2):
  ARM: dts: stm32: remove some timer duplicate unit-address on stm32f4
    series
  ARM: dts: stm32: remove timer5 duplicate unit-address on stm32f4
    series

 arch/arm/boot/dts/stm32429i-eval.dts  | 12 +++++++++
 arch/arm/boot/dts/stm32f429-disco.dts | 12 +++++++++
 arch/arm/boot/dts/stm32f429.dtsi      | 47 -----------------------------------
 arch/arm/boot/dts/stm32f469-disco.dts | 12 +++++++++
 4 files changed, 36 insertions(+), 47 deletions(-)

-- 
2.7.4

