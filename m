Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5DE4720E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhLMGBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:01:13 -0500
Received: from muru.com ([72.249.23.125]:37936 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhLMGBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:01:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 736E3809F;
        Mon, 13 Dec 2021 06:01:53 +0000 (UTC)
Date:   Mon, 13 Dec 2021 08:01:09 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Merlijn Wajer <merlijn@wizzup.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] Droid3: add initial DTS
Message-ID: <Ybbhpahp20tlwEdH@atomide.com>
References: <20211212230459.13579-1-merlijn@wizzup.org>
 <20211212230459.13579-3-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212230459.13579-3-merlijn@wizzup.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Merlijn Wajer <merlijn@wizzup.org> [211212 23:00]:
> @@ -35,7 +35,7 @@ reserved-memory {
>  		 * first 512K of that and just overwrite the rest and configure
>  		 * only 384K instead of 2M.
>  		 */
> -		ramoops@a0080000 {
> +		ramoops0: ramoops@a0080000 {
>  			compatible = "ramoops";
>  			reg = <0xa0080000 0x60000>;
>  			record-size = <0x20000>;

The stock kernel ramoops range might be different here because of less
memory. If the stock kernel has it, it should be in the platform data
somewhere in the stock kernel sources. Probably best to just leave it
out for now.

> +// Do don't know if pstore is supported, but the current config causes panics,
> +// so delete the node for now
> +/delete-node/ &ramoops0;

Just leave this out too, I don't think we have the ramoops configured in
the mainline kernel.

Otherwise looks good to me.

Regards,

Tony
