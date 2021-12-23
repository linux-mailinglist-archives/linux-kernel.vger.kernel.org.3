Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF00347E042
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbhLWITk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:19:40 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:39298 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhLWITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640247579; x=1671783579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JRoAnEY3r8cgHd59JP9JgzeC0rdQQn8RTC7yoR73nTo=;
  b=FtxLEB5RX5f9E9QcVVhmpHrsvkLpJrRFRkiaTLFpFYxaRXBQvHEm7lDB
   MQHgRApDYo4KIgG9PpCOFjFXYTb3AgSplXe5bY0eK5rZZV6srH9VRMp6W
   fx2oqz8vYiWmMKJEqs3IuOj2S+nDWS20LpSY6Em4Ixm2cB7wnybp5g6+e
   L5ZTzbzZRCnyY6oV3+2GU9nmE5aFucZoCLmuiGcGd/Ffnav+CcX71t5Vx
   IjoKzrNmkPmEfZ2TjaWGbpaudyMBzUYFVBYuDcqhqa76f+TtnMPLkH3vh
   jA/6gSKxssX0m13UrTrEnqSrH9C4+zWW3p6ooYeFc2Bbyt+slQlusjQGh
   Q==;
IronPort-SDR: WZDh+lJxetnRjEE4izqzl818toaMq8pJDzi/H12mKRCqXDTHWWKa6yGvwOHYZlEXl2wQCkKJQy
 vdDFSfT46mzz1suMCM6/LvrH46+sGKHDHM3F08SSlNsqXiVsYx3wqeOov2bjPQ6IH8u89QSLLp
 m3jcIZDN11fjrETYOl1N2B7pNRcXFdEXx5fcK7VZEOpH6Z7Rl53zD8EPAkhTkDZtzNlRa5hbtg
 70nUSfXVKXOyJpQkTm+oYhyE5nu7V/aLTW3BuHXzHLeiXLapKAc7cnClOtbsfWeRYVnFPqCnlU
 Q5/zFqbmskwKDAJWQwf6cWvY
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="140688299"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 01:19:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 01:19:38 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 23 Dec 2021 01:19:36 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <michael@walle.cc>,
        <vigneshr@ti.com>, <p.yadav@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Constify part specific fixup hooks
Date:   Thu, 23 Dec 2021 10:19:34 +0200
Message-ID: <164024756845.186441.13039859160300606228.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211106102915.153552-1-tudor.ambarus@microchip.com>
References: <20211106102915.153552-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Nov 2021 12:29:15 +0200, Tudor Ambarus wrote:
> Respect flash_info structure declaration.

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: Constify part specific fixup hooks
      https://git.kernel.org/mtd/c/65b54ff67afa

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
