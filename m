Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118B847A7E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhLTKsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:48:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59320 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLTKsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:48:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F88DB80E33;
        Mon, 20 Dec 2021 10:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AFAC36AE8;
        Mon, 20 Dec 2021 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639997284;
        bh=biq3Oji5lH9jv5ZgoieqKXMSnbQGIYrxkITVZ1ZAKtc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZEwAYaU/VDlIdTKT9TuGq57nryAlU7tYBWTUtnkuZF6j+nP2CGF1oVFGF6vLsR0SE
         wzudqobroQ6jwu65GNCIHpsiYntG4qvS728CaR/1hLW4dNniO0V3jWvG0WBjpRPkpj
         kOfHbTxnmIrZDfvaizQA4HKNeQ3AhvG/GJ1QhST+H/+N3U65oEiBtUzmLS8+zoHtkW
         gNjXcrBNCYXHFn4KH0Vu6vDCJNsqkS5QtpkHQFmSxum4B6VK4tPJjwG2OoiGNWMH6j
         nmp9rAkq+RhHNus39lYBHPoWS7JLjD3N76SosRM/gk48N2kk7XEOsyb+qwaf9PaujB
         xL806ojzThULg==
Subject: Re: [PATCH 3/6] usb: dwc3: Drop unneeded calls to
 platform_get_resource_byname()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211220010411.12075-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <0dce4df3-5c44-62ab-97a4-93a523e08076@kernel.org>
Date:   Mon, 20 Dec 2021 12:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211220010411.12075-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/12/2021 03:04, Lad Prabhakar wrote:
> Drop unneeded calls to platform_get_resource_byname() from
> dwc3_host_init(). dwc3_host_init() already calls dwc3_host_get_irq()
> which gets the irq number, just use this to get the IRQ resource data
> and fill the xhci_resources[1]
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

--
cheers,
-roger
