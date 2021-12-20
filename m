Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B436647AA1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhLTNGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:06:00 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39987 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhLTNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:06:00 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 53C87223ED;
        Mon, 20 Dec 2021 14:05:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1640005557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dTY1s8xROZ8eZkA1A8ctnHjL2GpMHeZVdIQO7kot2X0=;
        b=i5vE1Jo8GK/6GI2L3R56z2AfVIbnr8IAvac2n4bkuLDzPzcfMuE+OqqURvhExSdy+T+cjg
        4lnyOiNJb8KwXlIjf90s8+Hh7MAgn0S3Sb8qe20tqDujXveTPehf1q0dLvmYxPe3fPOaBX
        A9Q6DhxDCnp3s44BxzII7MGnK3Ai+f4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Dec 2021 14:05:57 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        zhuohao@chromium.org, p.yadav@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mtd: core: Remove partid and partname debugfs files
In-Reply-To: <20211217122636.474976-1-tudor.ambarus@microchip.com>
References: <20211217122636.474976-1-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <4fb031eee886f1e88b4f0bab6a55c2bd@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-12-17 13:26, schrieb Tudor Ambarus:
> SPI NOR has equivalent sysfs device attributes, thus let's remove the
> duplicated debugfs entries. There's no one else using partid and 
> partname
> debugfs files, thus remove them from the mtd core as well.
> 
> If you find the idea acceptable, I would like to queue these through
> spi-nor/next, I'll have some other patches that will depend on these.

I'm fine with it.

-michael
