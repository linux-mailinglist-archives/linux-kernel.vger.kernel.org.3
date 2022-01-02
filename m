Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524FD482C87
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 19:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiABSGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 13:06:47 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:39784 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiABSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 13:06:36 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A2D4F20140E;
        Sun,  2 Jan 2022 18:06:30 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id DF49480637; Sun,  2 Jan 2022 18:35:41 +0100 (CET)
Date:   Sun, 2 Jan 2022 18:35:41 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: clean up dead drivers for CompuLab
 CM-X255/CM-X270 boards
Message-ID: <YdHibXIuQiBD/TM1@owl.dominikbrodowski.net>
References: <20210816150115.12889-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816150115.12889-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Aug 16, 2021 at 05:01:15PM +0200 schrieb Lukas Bulwahn:
> Commit 9d3239147d6d ("ARM: pxa: remove Compulab pxa2xx boards") removes
> the config MACH_ARMCORE in ./arch/arm/mach-pxa/Kconfig.
> 
> Hence, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
> 
> MACH_ARMCORE
> Referencing files: drivers/pcmcia/Kconfig, drivers/pcmcia/Makefile
> 
> Clean up the dead remains of pcmcia drivers for Compulab pxa2xx boards.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied to pcmcia-next.

Thanks,
	Dominik
