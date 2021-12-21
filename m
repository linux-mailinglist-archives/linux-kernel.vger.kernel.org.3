Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6047BB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhLUHv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhLUHv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:51:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7BC061574;
        Mon, 20 Dec 2021 23:51:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95A4661154;
        Tue, 21 Dec 2021 07:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1B6C36AE7;
        Tue, 21 Dec 2021 07:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640073117;
        bh=cypPDxSfVxgOOboAL2pFSKiinIHAewVmcNUvWE/4nEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maexsRSHcmReHiEI7Xjz+5SnMlFU7vOn5qNK5cqeoYgheLb5KMey9m1OJ8JKFBQaN
         I7gkE0hD7FzEAK5GEhrOatB7utI9xcpT21JNpc9Zqj1nB7Cl7AYiQtxWaggzecUn7C
         qI9bqezJnHFbmbC0j4tgYSp+JxysYbR7HFEjGkIU=
Date:   Tue, 21 Dec 2021 08:51:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Bin Liu <b-liu@ti.com>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 0/6] usb: sound/soc: Use platform_get_irq*() variants to
 fetch IRQ's
Message-ID: <YcGHmhDWppgtLcTS@kroah.com>
References: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 01:04:05AM +0000, Lad Prabhakar wrote:
> Hi All,
> 
> This patch series aims to drop using platform_get_resource() for IRQ types
> in preparation for removal of static setup of IRQ resource from DT core
> code.
> 
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Note: I have just build tested the patches.

I don't think "sound/soc" mattered here in your subject line :)

I'll go queue these up now, thanks.

greg k-h
