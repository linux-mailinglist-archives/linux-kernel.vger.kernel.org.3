Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE5518773
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiECO7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiECO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:59:41 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA77535A9B;
        Tue,  3 May 2022 07:56:08 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2439XtPB026397;
        Tue, 3 May 2022 16:55:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=ZMxFA8J6k2ZHjDdGldD6Mpf4+zfmwkih2pJgfqKGO2o=;
 b=WbbqGKLfLCcvGWX1NExy7bQjJsyXoqze5LhRXHgdcf351cszLxOPwSVL824Dhzdv5CDu
 Pq9ZCZO+sN6vF4co4dmOwDugZg/EHnNJXT1VYHRp8mFLXas4GsIze+hAdkQ/JMdM6rmy
 nyc6BFgF/aT/rJrig3Oy2cgGBjPsmz/Gfzrmbe60qJTmeaU95yGSkVJ+TW8JgN2t4cdS
 u/UlO9k8HfTG2SYhYFPWp5XgtvH8b2IobizcSRfdQCSF63hb5mbqXukp0XUBUyKE420t
 lqNRlgxvnuj/ktG09xEjlMVYh5R11+A4TmeUgDEAxFGP/f5Yk/pM40cQJNjREF5OsA7A Gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frthjq1t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 16:55:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4BA8310002A;
        Tue,  3 May 2022 16:55:55 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 453F9226FB4;
        Tue,  3 May 2022 16:55:55 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 3 May 2022 16:55:54
 +0200
From:   Fabien Dessenne <fabien.dessenne@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Subject: [PATCH 0/2] dt-bindings/ stm32 dts: remove the IPCC "wakeup" IRQ
Date:   Tue, 3 May 2022 16:55:52 +0200
Message-ID: <20220503145552.525733-1-fabien.dessenne@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_06,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stm32 mailbox (ipcc) dt-bindings and dts define a "wakeup" interrupt which
is not used by the ipcc driver, so remove it.

Fabien Dessenne (2):
  dt-bindings: mailbox: remove the IPCC "wakeup" IRQ
  ARM: dts: stm32: remove the IPCC "wakeup" IRQ on stm32mp151

 .../devicetree/bindings/mailbox/st,stm32-ipcc.yaml    | 11 +++--------
 arch/arm/boot/dts/stm32mp151.dtsi                     |  7 +++----
 2 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.25.1

