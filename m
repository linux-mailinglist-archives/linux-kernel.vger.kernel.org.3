Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF04698AA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343987AbhLFO0x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Dec 2021 09:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbhLFO0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:26:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B2C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 06:23:24 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1muEtk-0006pc-H0; Mon, 06 Dec 2021 15:23:20 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1muEtj-000G3N-Nb; Mon, 06 Dec 2021 15:23:19 +0100
Message-ID: <5596ad7c0e83398e3e065f95a789375f9d9a9ed2.camel@pengutronix.de>
Subject: Re: [PATCH] reset: tegra-bpmp: Revert Handle errors in BPMP response
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Dec 2021 15:23:19 +0100
In-Reply-To: <3c3c9bf9-4276-1eec-af65-143f97bcd620@nvidia.com>
References: <20211112112712.21587-1-jonathanh@nvidia.com>
         <3975fcc5ebc31761d513f1961ee054f5fe76431c.camel@pengutronix.de>
         <3c3c9bf9-4276-1eec-af65-143f97bcd620@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Mon, 2021-12-06 at 11:37 +0000, Jon Hunter wrote:
> Hi Philipp,
> 
> On 17/11/2021 16:23, Philipp Zabel wrote:
> > On Fri, 2021-11-12 at 11:27 +0000, Jon Hunter wrote:
> > > Commit c045ceb5a145 ("reset: tegra-bpmp: Handle errors in BPMP
> > > response") fixed an issue in the Tegra BPMP error handling but has
> > > exposed an issue in the Tegra194 HDA driver and now resetting the
> > > Tegra194 HDA controller is failing. For now revert the commit
> > > c045ceb5a145 ("reset: tegra-bpmp: Handle errors in BPMP response")
> > > while a fix for the Tegra HDA driver is created.
> > > 
> > > Fixes: c045ceb5a145 ("reset: tegra-bpmp: Handle errors in BPMP response")
> > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > 
> > Thank you, applied to reset/fixes.
>
> I see this has not been picked up yet for v5.16 and so I just wanted to 
> check that you are planning to submit for v5.16.

Thank you for the reminder, I forgot to Cc: you on the pull request:

https://lore.kernel.org/linux-arm-kernel/5383deda141721643419e98c485fb510be56fb61.camel@pengutronix.de/

regards
Philipp
