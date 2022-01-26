Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E442B49C508
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiAZIPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:15:10 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49606 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiAZIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:15:08 -0500
Received: from isilmar-4.linta.de (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTP id 49081200230;
        Wed, 26 Jan 2022 08:15:05 +0000 (UTC)
Date:   Wed, 26 Jan 2022 09:14:47 +0100
From:   Helmut Grohne <helmut@subdivi.de>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] tty: serial: Add earlycon driver for Tegra Combined UART
Message-ID: <YfEC97fmxvVwpNV+@alf.mars>
Mail-Followup-To: Helmut Grohne <helmut@subdivi.de>,
        Mikko Perttunen <mperttunen@nvidia.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210213115824.3306965-1-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213115824.3306965-1-mperttunen@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 01:58:24PM +0200, Mikko Perttunen wrote:
> Add an earlycon driver for platforms with TCU, namely Tegra194.
> The driver is compatible with boot parameters passed by NVIDIA
> boot chains.

I confirm that this patch applies mostly cleanly (modulo minor Makefile
issue) to v5.16 and that it works with the vendor cboot on a Xavier AGX
device. I assume that it is expected that the earlycon output comes out
twice (once from the earlycon driver and another time from the real
driver).

Tested-by: Helmut Grohne <helmut.grohne@intenta.de>

Some of the concerns from Thierry Reding remain unaddressed though.

Helmut

