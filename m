Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE347E032
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243140AbhLWIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:12:44 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53308 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbhLWIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640247163; x=1671783163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BwrzrJ/6YTXQmVhunDbHM6brVHrDnTmV495Q4TrLTv4=;
  b=z1b9tY5Gzwkpja59Ojvnr58p/THUCkh4Bhtyw6m6AxD14xwGlF+aJ3oc
   CujAUBRxUczIJZ1VdtCyb3tJNFLRjGSiv0sfEJ/eDhpfUb9k1l1vqgRJ4
   LWrj0XOatkmIxlxRe932MEl8c1dZIhlIn14gZiWNmGbRwpACjPvpKYCJ4
   yATLlM3KCufbl4gnRkmch8AfRktr9ttnhZeDG0XmcXnSr1jyTqZS6UMJ1
   zST6R79lHOkxlKgRij3SN7SH49XzUHLs3a6Uz5cWJElNs8wKOzAB4kvn/
   H8PVbj8HuIPYQQHWT8JilIgiKy2YSAd0uHa1mJK0PuztzHw+pz+QhIAL1
   w==;
IronPort-SDR: la91+brDhCpArHicl38FM/x6yPp5p0SdcjoKhDBiQD0KepCaZEZkJ7cANjNY9mNa9CVbrh+3b6
 TialqdHfnq/faCTqgXnnY1mlCVpuFDeLOaCoovu0mPsJTg5roqaFkMrGdDvMOPuYZRc0ifDmjd
 qe+mfGejOpdimcbHsMPtG2lv8EneOV6ujhtfQ2k8BFPdmOUVWJRRlilFF78Q//Y3sytuI7Cn5K
 KJu7uUniHsDCyDh0BvTfPdZr/EWeY7RqS1yZhpzDaZZ7Mt/GjutNUNXG9dryUPFjCX2hA+Akj/
 2KgMdIrqvxdtaPpb+QGuGOIA
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="80469813"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 01:12:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 01:12:41 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 23 Dec 2021 01:12:39 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Neuschaefer <j.neuschaefer@gmx.net>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Jonathan Corbet <corbet@lwn.net>,
        "Vignesh Raghavendra" <vigneshr@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v1] mtd: spi-nor: core: fix/remove references to spi-nor.c
Date:   Thu, 23 Dec 2021 10:12:38 +0200
Message-ID: <164024714527.182368.2854659880404058320.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126092516.1431913-1-f.suligoi@asem.it>
References: <20210126092516.1431913-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 10:25:16 +0100, Flavio Suligoi wrote:
> The old file:
> 
> drivers/mtd/spi-nor/spi-nor.c
> 
> is not more present and now some of its code is
> contained in:
> 
> [...]

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: core: fix/remove references to spi-nor.c
      https://git.kernel.org/mtd/c/e7ad9f59f746

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
