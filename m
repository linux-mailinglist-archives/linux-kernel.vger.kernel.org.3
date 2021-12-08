Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8404246D332
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhLHMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:25:23 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34970 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhLHMZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:25:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 728A6CE2103;
        Wed,  8 Dec 2021 12:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70E0C00446;
        Wed,  8 Dec 2021 12:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638966105;
        bh=PVkkQFXWG4umRf60V6w6ydbBF3YnqKZE9jz7TAb1A80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSwMKS6ex2UKlsVAIL5RSkL4Y5cXPshRcPxd192LvWwy23FWPJ+Q6PDbsCO0XvxpI
         BGxDr8dznjq1Dm2C9qBxZWoPNxGFsNZgoWVVRAa4C0M+2w5GCiPyFNEBCE5ZVHPAV2
         jd3SuRMCVKElMUfTI07tokL3ggrs4UXX8XzJUXM0=
Date:   Wed, 8 Dec 2021 13:21:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, benh@kernel.crashing.org,
        BMC-SW@aspeedtech.com
Subject: Re: [PATCH v3 0/4] Refactor Aspeed USB vhub driver
Message-ID: <YbCjVqAie/d84oBm@kroah.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 06:05:41PM +0800, Neal Liu wrote:
> These patch series include 2 parts. One is adding more features
> to pass USB30CV compliance test, the other is fixing hw issues.
> More detail descriptions are included below patchsets.
> 
> Change since v2:
> - Add more description in changelog.
> - Fix remote wakeup issue patch and make it more configurable.
> 
> Change since v1:
> - Remove unnecessary configs for SET_CONFIGURATION.
> - Separate supporting test mode to new patch.
> 
> *** BLURB HERE ***

Blurb is missing :(
