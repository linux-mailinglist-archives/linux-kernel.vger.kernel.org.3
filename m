Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CAB483567
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiACRMc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jan 2022 12:12:32 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57957 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiACRMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:12:31 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D1362FF80C;
        Mon,  3 Jan 2022 17:12:26 +0000 (UTC)
Date:   Mon, 3 Jan 2022 18:12:25 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:BROADCOM SPECIFIC AMBA DRIVER
        (BCMA)),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER)
Subject: Re: [PATCH 9/9] mtd: rawnand: brcmnand: Add BCMA shim
Message-ID: <20220103181225.20a60d82@xps13>
In-Reply-To: <20211223002225.3738385-10-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
        <20211223002225.3738385-10-f.fainelli@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Braodcom");

Small typo here :)

> +MODULE_DESCRIPTION("NAND driver for BCMA chips");

NAND controller driver, I want to enforce this *controller* word
because NAND is way too vague and refers to nothing specific.

Plus, it's not really a controller driver that we have here, more like
a glue interface.

Thanks,
Miquèl
