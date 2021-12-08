Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B0846D361
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhLHMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:37:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39842 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhLHMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:37:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1936CE1FCB;
        Wed,  8 Dec 2021 12:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE5AC00446;
        Wed,  8 Dec 2021 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638966864;
        bh=zqmFWgeSsu2Lf8ivAqpIogjZ+EweMK4Re1qHpp/FbKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9ImSDYgg2lWXmB2xXVnHlSvlD9mK+5jGarMy6R5zXG82i0SZsmfN3FP8LWDYgSR8
         5W76r8Ge5u2yYfAWdsTqbT8YJc4ACWRjouVmO3nN0PFMVx83GUCTjHZXmMPhWtrcd5
         H0UTYCqGs0dBVlQ8X+vAue9ChHoYCnzm+qr/uwUaCqjnUpONPlJhy/tGUd+qslfdOb
         rZKhxLRPar3Jb47CQryqiIL3ARoRhOz3OIChWtB43p0fWqTCUKPmvm6VT2s3a0PzmJ
         LnfrnWfVTj4jce2RPzQyC1eR89gVO0asNlY/t9Pa+yeIBRWWUaPd4s+VDPvTdadaeW
         klmmMdTNze1Jg==
Date:   Wed, 8 Dec 2021 20:34:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Remove not-yet added support for
 sound from Crux
Message-ID: <20211208123417.GJ4216@dragon>
References: <202112061855.SidQyicE-lkp@intel.com>
 <20211206142601.373807-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211206142601.373807-1-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:26:01PM +0100, Michal Vokáč wrote:
> Remove mistakingly added support for audio codec. We support the coded
> by our downstream patches but the appropriate driver and bindings are not
> in mainline yet.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: a4d744ac2bab ("ARM: dts: imx6dl-yapp4: Add Y Soft IOTA Crux/Crux+ board")
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Amended, thanks!
