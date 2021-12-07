Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3846C61D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbhLGVJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241276AbhLGVJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:09:20 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD3C0698C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:05:47 -0800 (PST)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1muheh-00060K-Ah; Tue, 07 Dec 2021 22:05:43 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/3] staging: r8188eu: remove unused led1
Date:   Tue,  7 Dec 2021 22:05:34 +0100
Message-Id: <20211207210537.23382-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The r8188eu driver uses only led0. Remove code for led1.

Martin Kaiser (3):
  staging: r8188eu: remove SwLed1
  staging: r8188eu: remove code to set led1 registers
  staging: r8188eu: remove LedPin from struct struct LED_871x

 drivers/staging/r8188eu/core/rtw_led.c      |  3 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c | 42 ++++-----------------
 drivers/staging/r8188eu/include/rtw_led.h   | 12 +-----
 3 files changed, 10 insertions(+), 47 deletions(-)

-- 
2.20.1

