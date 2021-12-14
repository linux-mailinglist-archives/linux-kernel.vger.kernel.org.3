Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA6473AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbhLNCgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLNCgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:36:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E076DC061574;
        Mon, 13 Dec 2021 18:36:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6F1CB817D4;
        Tue, 14 Dec 2021 02:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FB8C34600;
        Tue, 14 Dec 2021 02:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639449361;
        bh=R+6J5sbcvGI2/EnyovyGDGX20vE9Ml5/ua0UKUYEnnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwaisp9l+pnYGwF6nBHNhmHUEep07ZwWblz4QO4EvuF5UL8iP183YwV9WDjA8ROpY
         Bh+poYgMqgjXMfEXaCXt7R+cXZUwB8+Pf/YEZKAhvq4KN/iM7NihaoYqb32w2MaYJz
         4c3w9w659xe+5aXlElerLygL+VGoVeWC8o706zOaw1tbu40LI1PZn0O9JxCPB+7fL1
         7v2OTUp+y5QEun8rnlFnSmtL0bAprMMdG9yKEs1UFb9h1QU+4ca5pt/FIJxo6sWtGP
         wTy1D4NQyABituVNwYJeh/0ZybwBTKIFo6TPQyeBONvZidEvaprW2bKntLGkhtMEib
         hqjGauCyVX85w==
Date:   Tue, 14 Dec 2021 10:35:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     system@metrotek.ru, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] bus: imx-weim: optionally enable continuous burst
 clock
Message-ID: <20211214023553.GM4216@dragon>
References: <20211202055724.4416-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202055724.4416-1-i.bornyakov@metrotek.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 08:57:22AM +0300, Ivan Bornyakov wrote:
> Introduce option to enable continuous burst clock, if burst clock itself
> is enabled.
> 
> Changelog:
>   v1 -> v2:
>     * documentation about this option added to
>       Documentation/devicetree/bindings/bus/imx-weim.txt
>   v2 -> v3:
>     * added missing Signed-off-by line
> 
> 
> Ivan Bornyakov (2):
>   bus: imx-weim: optionally enable continuous burst clock
>   dt-bindings: bus: imx-weim: add words about continuous bclk

Applied both, thanks!
