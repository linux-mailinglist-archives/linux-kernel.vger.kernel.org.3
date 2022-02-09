Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF504AF0FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiBIMI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiBIMGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:47 -0500
X-Greylist: delayed 1455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 03:13:35 PST
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BACE016CD9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:13:34 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2199DowN018111;
        Wed, 9 Feb 2022 11:49:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=u3Ts4w97nsDuGCr+80FPyJOW2YzAPlQD8H3fZwIxWAU=;
 b=Pa/oW3uTKrrtWhibPtsrT+x/X36RFvJ51q9y4y1G3b/gIynruduKpPXKQJkzocepXlSI
 8k6VQW+AMlbxF6IqNiDe3/CGh26ZXdGLFQPH8STiXMDlePV23vUepIMWC2IYuIRAjq/3
 P4Ret2x6+tXgQsXCYUgm+bfUmRvZjcn0owZV6oGvdXyADl7W3bkzXDfe4Lj+eZXBKP94
 FM6M6oe9M/Gq/CVgnuRKAp6XkjzRxoTKO0AA3aPLtEm5VhTNPrDnHI3h2oU2s/BqvCSb
 Vj2yRuYRpORUnEe6pLXidh4tvHjs7tnNCRWJUFqG06Udhb0zsvj58SLUhoBx4W5NIcst qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4asygkya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 11:49:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 943A110002A;
        Wed,  9 Feb 2022 11:48:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88CC0215126;
        Wed,  9 Feb 2022 11:48:59 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 9 Feb 2022 11:48:59
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>
CC:     <olivier.moysan@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/2] ARM: dts: stm32: remove timer duplicate unit-address on stm32f7 series
Date:   Wed, 9 Feb 2022 11:48:47 +0100
Message-ID: <1644403729-22665-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_05,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a series of warnings seen when building with W=1, like:
Warning (unique_unit_address): /soc/timer@40000c00: duplicate unit-address
(also used in node /soc/timers@40000c00)

This approach is based on some discussions[1], to restructure the dtsi
and dts files.
[1] https://lore.kernel.org/linux-arm-kernel/Yaf4jiZIp8+ndaXs@robh.at.kernel.org/

 arch/arm/boot/dts/stm32746g-eval.dts  | 12 +++++++++
 arch/arm/boot/dts/stm32f746-disco.dts | 12 +++++++++
 arch/arm/boot/dts/stm32f746.dtsi      | 47 -----------------------------------
 arch/arm/boot/dts/stm32f769-disco.dts | 12 +++++++++
 4 files changed, 36 insertions(+), 47 deletions(-)

-- 
2.7.4

