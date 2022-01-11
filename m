Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D63048B289
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbiAKQpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:45:45 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:53626 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240793AbiAKQpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:45:44 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BBoJgU024713;
        Tue, 11 Jan 2022 17:45:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=IN9ceG9HgeMhT60YAmViP0IH3j3ce+PtYoMrQL69pyY=;
 b=aM8Te+X1D5uu1hxdZjH3li1a+pzjU9Gs3a7F9dBKOuY/nmQjb1lQVKOdCG3g2F3inpRy
 kyuLVh1MjbJ1TI7LWNBDTqC6i35XaZgBm7UVs0QlclPeeEi7TLMOg1VRiMYbB9qXQ+9Q
 7IhtynAsEL1AhuNCTVT15UiwfG5dAgc/VFQLglTKTEDT33ogwuEXKCinwAvSwFuir8bo
 pn2zjHJcTtRfrW+uigunYNSdEPUAMnIlVKYrX/FUQ8ywtuHV4beX1delfVdCFlP7OCY2
 m22HyFJWLM3vVxD4FE7vsE/JNZfXJXYNWxWLeWP5TL/2/VMeXgWYSW5ej/0HKTEa9OTA Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dh9cb9c63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 17:45:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E19C10002A;
        Tue, 11 Jan 2022 17:45:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 02154245FC8;
        Tue, 11 Jan 2022 17:45:22 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 17:45:21
 +0100
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] serial: stm32: fix software flow control
Date:   Tue, 11 Jan 2022 17:44:39 +0100
Message-ID: <20220111164441.6178-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie fix issues on STM32 USART driver when using software flow control.

Valentin Caron (2):
  serial: stm32: prevent TDR register overwrite when sending x_char
  serial: stm32: fix software flow control transfer

 drivers/tty/serial/stm32-usart.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.17.1

