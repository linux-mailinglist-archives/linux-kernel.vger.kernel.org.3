Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38DD47AA38
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhLTNMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:12:32 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:34943 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhLTNMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:12:30 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DC01A223ED;
        Mon, 20 Dec 2021 14:12:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1640005949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOW520ZR05AQHRv9aIyRrqTZK8P5NitE2pvLyK5C/qM=;
        b=CSuZSbeqbS4jI4Sj461a/Je1NBSAg5stv/JguR41ASZ7Zx2pgBuXXyArBQ4MT5+/HlamZG
        /lPGHSmRIiKGzVmTJEvisibKsSRGzdcn27jLd2kBGvs3XOPfwVBsBhSmQ/3gdwisxFWmlU
        zYYAgrTYUZJup0Pm3EuFFVraiDve+tk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Dec 2021 14:12:28 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v4 1/2] mtd: spi-nor: core: Introduce SPI_NOR_SOFT_RESET
 flash_info fixup_flag
In-Reply-To: <20211217173329.553293-1-tudor.ambarus@microchip.com>
References: <20211217173329.553293-1-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <11ba36ee085bb9e3e262dd5bbef4dd23@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-12-17 18:33, schrieb Tudor Ambarus:
> The Soft Reset and Rescue Sequence Support is defined in BFPT_DWORD(16)
> starting with JESD216A. The first version of SFDP, JESD216 (April 
> 2011),
> defines just the first 9 BFPT DWORDS, thus it does not contain 
> information
> about the Software Reset and Rescue Support. Since this support can not
> be discovered by parsing the first SFDP version, introduce a flash_info
> fixup_flag that will be used either by flashes that define
> JESD216 (April 2011) or by flashes that do not define SFDP at all.
> In case a flash defines BFPT_DWORD(16) but with wrong values, one 
> should
> instead use a post_bfpt() hook and set SNOR_F_SOFT_RESET.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Michael Walle <michael@walle.cc>
