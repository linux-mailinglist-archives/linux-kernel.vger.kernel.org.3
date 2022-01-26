Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7542249CAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiAZNVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:21:46 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55408 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238021AbiAZNVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=4S7Abn8zJxsoYP0XMMfY9AkdmxvTRt4hHIFTWvcLTF4=; b=5zsVAfZIayY6a22GgeCUD6qGWY
        u7cWnuD4DHkApJt9LqJLmN7WmJoTc5W3r7kosnYYvtRBgTcHeak1vC/QIXtYeQh7fA4VsYJanJT4m
        atCHm47qu6sKqvkZla+A2eR+77Za6gqhxuOEtSMAL36zYwGslm6ucA22hciP+XDFjfzM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nCiF1-002oJ8-Kb; Wed, 26 Jan 2022 14:21:39 +0100
Date:   Wed, 26 Jan 2022 14:21:39 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Marginean <alexandru.marginean@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a-qds: define mdio slots for
 networking options
Message-ID: <YfFK426N+0Y/UTEI@lunn.ch>
References: <20220126092650.19962-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126092650.19962-1-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:26:50AM -0600, Li Yang wrote:
> The ls1028a QDS board support different pluggable PHY cards.  Define the
> nodes for these slots to be updated at boot time with overlay according
> to board setup.
> 
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
