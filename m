Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B293E473E83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhLNInr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:43:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47906 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhLNInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:43:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C1C611B0;
        Tue, 14 Dec 2021 08:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C091C34604;
        Tue, 14 Dec 2021 08:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639471425;
        bh=GxNRyBzpiN5pyIT5z+o+BVMY35bN1XReLxLH5hlP8rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTOhnW9jC42YDu6bxo2d/DiD9HEdrMlBep9JLJhxAYmbKVQYKJsRyUpfSBEhWqE9t
         8vk/kEExGy3w0ybu4csV23wmARjAkIraKOmi0ui0678ZzgKsQREEiCRigfCT4C+fZl
         pbHqeTJwX1rZWcDxpo0ixukhKSs1FqeUDoCnsNQCSUMtVxP7kGoyLgDii9lvghCeSK
         MzAbB9cyZReKsi7mw+3It9ECVE3wE95p5QLoT88EOF6mOzrYmtF4EGmVkA8kKyVYQH
         LDGblJo60TFpeyQZDL+byFLfu0DLmTlgQF7Q58YqDWdJ207hV5ajyb0AdJt1hramPd
         VKgeFL5CrEibg==
Date:   Tue, 14 Dec 2021 16:43:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        tharvey@gateworks.com, robh@kernel.org
Subject: Re: [PATCH v4 0/5] Add support for BSH SMM M2 and S2 boards
Message-ID: <20211214084337.GI14056@dragon>
References: <20211210132319.61196-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210132319.61196-1-ariel.dalessandro@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:23:14AM -0300, Ariel D'Alessandro wrote:
> Introduce BSH SystemMaster (SMM) M2 and S2 board family.
> 
> Changes in v4:
> * Fixed typo in patch 5/5 subject: s/imx8ulz/imx6ulz
> * Added "fsl,imx6ulz" to SMM M2 compatible.
> 
> Changes in v3:
> * Fixed node names to use hyphens.
> * Reorder nodes in alphabetical order.
> * Removed unneeded newlines.
> * Removed vendor wifi properties.
> * Renamed labels and nodes consistently.
> 
> Changes in v2:
> * Added M2 board support.
> * Added dt-bindings for vendor prefix and board compatible.
> * Fixed pmic dt entry.
> 
> Ariel D'Alessandro (4):
>   dt-bindings: Add vendor prefix for BSH Hausgeraete GmbH
>   dt-bindings: arm: fsl: Add iMX8MN BSH SMM S2 boards
>   arm64: dts: imx8mn-bsh-smm-s2/pro: Add iMX8MN BSH SMM S2 boards
>   dt-bindings: arm: fsl: Add BSH SMM-M2 IMX6ULZ SystemMaster board
> 
> Michael Trimarchi (1):
>   arm: dts: imx6ulz-bsh-smm-m2: Add BSH SMM-M2 IMX6ULZ SystemMaster

Applied all, thanks!
