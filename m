Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2125146E374
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhLIHsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:48:10 -0500
Received: from muru.com ([72.249.23.125]:36412 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhLIHsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:48:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8008680A3;
        Thu,  9 Dec 2021 07:45:17 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:44:34 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2] ARM: dts: motorola-mapphone: Drop second ti,wlcore
 compatible value
Message-ID: <YbGz4j+Iw6Jfhlaz@atomide.com>
References: <17693a54a471c50d2d091d7a65f6571e7b0f7c51.1638540458.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17693a54a471c50d2d091d7a65f6571e7b0f7c51.1638540458.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Geert Uytterhoeven <geert+renesas@glider.be> [211203 16:11]:
> The TI wlcore DT bindings specify using a single compatible value for
> each variant, and the Linux kernel driver matches against the first
> compatible value since commit 078b30da3f074f2e ("wlcore: add wl1285
> compatible") in v4.13.

Thanks applying into omap-for-v5.17/dt.

Tony
