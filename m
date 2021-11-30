Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF824632A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbhK3Lpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:45:41 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54358 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbhK3Lpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:45:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6E992CE1410;
        Tue, 30 Nov 2021 11:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E450FC53FC7;
        Tue, 30 Nov 2021 11:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638272536;
        bh=1fo5SlI+JcFkyn8y9UYJZhdMEAS3/IN2zErDxlT3R6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVgPQwhB+RvX54u6XOyxcbwWihfw2yPIBfCR1wkOqBVwJrIqQdMBlfRao4594Ojk/
         acG2BOBJXnlIQTf+InAKvIq5l3v6Lvl6ElahcEYhKngk4sEli8Qi6eWI9tZYgT6zb3
         Ub88TzfjZAzb8QAG8oaVWcxbrv/mIGvg3N/rtFSA=
Date:   Tue, 30 Nov 2021 12:42:13 +0100
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
Subject: Re: [PATCH v2 0/4] Refactor Aspeed USB vhub driver
Message-ID: <YaYOFTmLLUJpPug1@kroah.com>
References: <20211130113847.1405873-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130113847.1405873-1-neal_liu@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 07:38:43PM +0800, Neal Liu wrote:
> +Ben.
> ---
> 
> These patch series include 2 parts. One is adding more features
> to pass USB30CV compliance test, the other is fixing hw issues.
> More detail descriptions are included below patchsets.
> 
> Change since v1:
> - Remove unnecessary configs for SET_CONFIGURATION.
> - Separate supporting test mode to new patch.
> 
> *** BLURB HERE ***

No blurb?
