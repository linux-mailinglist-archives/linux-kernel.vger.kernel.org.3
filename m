Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84A9468E69
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhLFBHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244142AbhLFBCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:02:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B75CC061751;
        Sun,  5 Dec 2021 16:58:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61E47B80EEE;
        Mon,  6 Dec 2021 00:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD08C00446;
        Mon,  6 Dec 2021 00:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638752325;
        bh=MDhBLLuYmMDTTSezpWr9qft1BlQ/oH22cO1owWQ3d6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iO6jgHgs+gC3vK/yX+sbOnqKSW5kmZ6TELHtDbeZwnKhgHEhqbHlth6AOWj4witBm
         5ZfRVigcMZ7HAhB+gK6GOsJdxt6JPzvAR1KmyZmMdqUE3SkT9PHzslwawzrn2YLhkL
         e0psbOThaLZpKVK//zT2aHqri40CbnkTbhixnWyobaoLBDy24BQ6al+gRVTfsvDKRh
         bGylQa5nwkfGzllQ9Q3+W5k/9ryHfLofY9Ip1ge/nMx9qn3JUP7Ew6278h3zSJGDcM
         1ade0eGO+RnmS2VMyC75SlyNm8voUY/v12wSUJNx5u6gK5O/A3yi5NsLlvUYV4LuMD
         PKOlq0i99Ugtw==
Date:   Mon, 6 Dec 2021 08:58:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: add TQ-Systems boards
 based on i.MX6Q/QP/DL
Message-ID: <20211206005838.GI4216@dragon>
References: <20211122113740.2348-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122113740.2348-1-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 12:37:38PM +0100, Matthias Schiffer wrote:
> The TQ-Systems MBa6x mainboard can be used with TQMa6 variants with
> i.MX6Q/QP/DL SoCs (TQMa6Q/QP/DL). The TQMa6Q and DL exist in two variants:
> The newer variants "A" have a hardware workaround for Erratum ERR006687,
> while variants "B" are missing such a workaround, so it needs to be
> handled in software. The erratum was fixed in i.MX6QP, so no "A" variant
> of the TQMa6QP exists.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied all, thanks!
