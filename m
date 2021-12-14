Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EC0473AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244309AbhLNCra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:47:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52314 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLNCr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:47:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26764B817D4;
        Tue, 14 Dec 2021 02:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7780C34603;
        Tue, 14 Dec 2021 02:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639450046;
        bh=lGHEPwKNgI4T/glFuPmcU0U4AGuegZldQcnrkItl/4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JE2vxbLR/VbqkAqODkIgJirZC6vK9t0XBSDemPWAXzzBz06xe9qa800axwMNBmay0
         tdUZKCDpg5zrd2rQKgSXUvdRDY9pq3dnhZcoKH5XcZtem3Mw2Sly5MprQgL3sZpt/0
         1xYYHgO+hOdk3hsmHoXWlG7hBje1mBcc5jc3wdHrNbWFr6bGjXekSi3NFfmAKGv8W4
         qVTNNljfIiCFvfTA3gjsDyKbBfB5lmsahcq/MM9luIrlgAjMRxVPI91OiwRDMLwtR0
         9i7O82VnWEXew/LWOHz7HpMDqsy3MOyBuQFerY1la0CzGxQQyPtjj0Wt7mJePCfHDf
         GTUWZuIHN0eEw==
Date:   Tue, 14 Dec 2021 10:47:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 2/2] arm: dts: imx25/31/50/51/53/6qdl: Change spba to
 spba-bus
Message-ID: <20211214024719.GO4216@dragon>
References: <20211202143828.3335-1-aford173@gmail.com>
 <20211202143828.3335-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202143828.3335-2-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 08:38:27AM -0600, Adam Ford wrote:
> With the updated dt-bindings for the spba-bus, rename spba@xxxx
> to spba-bus@xxxx.  There are no functional changes.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

I updated the subject prefix like below.

 ARM: dts: imx: ...

Applied both, thanks!

Shawn
