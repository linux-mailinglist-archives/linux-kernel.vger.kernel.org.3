Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAA4468E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhLFBOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:14:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53298 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhLFBOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:14:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50FC5B80EF5;
        Mon,  6 Dec 2021 01:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C51CC341C5;
        Mon,  6 Dec 2021 01:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638753082;
        bh=iT2vY0sTQnnDw4K8+LJItynOyEYqfinZLS7VKqI2MNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRDY/9k2ut2qx5hGj4klMltJ8fiI2pH0WE6FbDFfRF8TlGMDFM5E7BsMSzQmYTWQ1
         Gp7FotKpZrz+/EZbvgWuxjdUuqec/SyjVquFL0Pr0jF8WX2w+2v6OBMlR7q0+ueSm+
         mezCirukXDhYYJwtSvloWxMI6IuSqwayX1n4WyyEbEH18zQQA4X/Dsn67J/rMMlP/E
         PXCaqnjedx4BUhAnnl3EyG8N+hp9OAGjdM+cJ5y+rlPZNBQW/gBSlXR04LtqF4cvYn
         cv5HguDmdyPZnksjBdF3jbGD3mmb1ux7swabToBGJeeNu08NAeO2l0llVmcMsbWs4g
         0WZO94F0nb2SA==
Date:   Mon, 6 Dec 2021 09:11:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add Y Soft IOTA Crux/Crux+
 boards
Message-ID: <20211206011115.GL4216@dragon>
References: <20211122162520.90211-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211122162520.90211-1-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 05:25:19PM +0100, Michal Vokáč wrote:
> Add devicetree binding for Crux/Crux+ boards from the IOTA family.
> These boards have the very same HW configuration as the Orion board
> except the usage of Quad/QuadPlus SoC.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied both, thanks!
