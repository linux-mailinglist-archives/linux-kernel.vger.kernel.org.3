Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665A5473B78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhLNDYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhLNDYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:24:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61965C061574;
        Mon, 13 Dec 2021 19:24:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B1FEB817A3;
        Tue, 14 Dec 2021 03:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129D4C34604;
        Tue, 14 Dec 2021 03:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639452238;
        bh=N7XNSURUo4TDZIjh/3qyE34SFrpjR0/a5OuQEubaecE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWG4QXf7+cYr6SpHOGXSY3z6pKYF09vIXkDws78ZeQ9HbizNIu0eA0umk3MBzPMMK
         bNWGU9hUh10ad7EeU3N6c7I0fDSxBHg5gZuOb9ntpxrnU2dUYNWY8T9rF1aw7mKE17
         HcdKRIEEYNKTeP9CVYYNR1bJVWTNQs9M7kd/NeohfdGFIK++61m+f8WBW7bj+qmLfx
         3yMm98zXmKsQhiqNNAAR+vKQmkYoXE2/AOUz8W0QB/xTqBPjdRlWW/ZWqLeXP3rsp9
         U9g3xEYSGycLPQ0qzTTIAsVvDJplnypA7c2INkg0uF92K4vMLqumN2eKJT/vPZyG3g
         QZLAVZT0FzPzw==
Date:   Tue, 14 Dec 2021 11:23:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jesse Taube <mr.bossman075@gmail.com>
Subject: Re: [PATCH 00/17] Drop useless fsl,imx- compatible strings
Message-ID: <20211214032352.GC10916@dragon>
References: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203004039.48752-1-giulio.benetti@benettiengineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 01:40:22AM +0100, Giulio Benetti wrote:
> This patchset drops the following useless compatible strings:
> "fsl,imx-clk32"
> "fsl,imx-osc"
> "fsl,imx-ckil"
> "fsl,imx-ckih1"
> "fsl,imx-ckih2"
> 
> Giulio Benetti (17):
>   ARM: dts: imx1: drop "fsl,imx-clk32"
>   ARM: dts: imx25: drop "fsl,imx-osc"
>   ARM: dts: imx50: drop "fsl,imx-osc"
>   ARM: dts: imx50: drop "fsl,imx-ckil"
>   ARM: dts: imx50: drop "fsl,imx-ckih1"
>   ARM: dts: imx50: drop "fsl,imx-ckih2"
>   ARM: dts: imx51: drop "fsl,imx-osc"
>   ARM: dts: imx51: drop "fsl,imx-ckil"
>   ARM: dts: imx51: drop "fsl,imx-ckih1"
>   ARM: dts: imx51: drop "fsl,imx-ckih2"
>   ARM: dts: imx53: drop "fsl,imx-osc"
>   ARM: dts: imx53: drop "fsl,imx-ckil"
>   ARM: dts: imx53: drop "fsl,imx-ckih1"
>   ARM: dts: imx53: drop "fsl,imx-ckih2"
>   ARM: dts: imx6qdl: drop "fsl,imx-osc"
>   ARM: dts: imx6qdl: drop "fsl,imx-ckil"
>   ARM: dts: imx6qdl: drop "fsl,imx-ckih1"

Applied all, thanks!
