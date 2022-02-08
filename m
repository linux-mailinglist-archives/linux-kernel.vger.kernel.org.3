Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17C04AD6C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349575AbiBHL3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbiBHKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:47:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A714BC03FEC0;
        Tue,  8 Feb 2022 02:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58C57B819AC;
        Tue,  8 Feb 2022 10:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDE7C004E1;
        Tue,  8 Feb 2022 10:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644317246;
        bh=PVTw2r0OXFjvjt94d456GInBC+FByeJffOgTJjxViSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cP0L5NT2OXZNsxnxJeUwd6zsAk+QYbuwqGUW+k50nq1fPvdjXh3Fr8FuVWcVGPqrt
         gEtsyaKa0ntKma2AtDb/vD7vB3NEByLjIHtQnUNoD1EBBrR+QSQRCGX2bH1tcd993D
         Uh1h9jnGRb7TT0czOqAeR+vXsfjIQRD7lqVT4jRk=
Date:   Tue, 8 Feb 2022 11:47:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v20 3/5] usb: misc: Add onboard_usb_hub driver
Message-ID: <YgJKOxGKlpS9PgvL@kroah.com>
References: <20220119204345.3769662-1-mka@chromium.org>
 <20220119124327.v20.3.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119124327.v20.3.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 12:43:43PM -0800, Matthias Kaehlcke wrote:
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
> @@ -0,0 +1,8 @@
> +What:		/sys/bus/platform/devices/<dev>/always_powered_in_suspend
> +Date:		November 2021
> +KernelVersion:	5.17

Nit, these are out of date now :(
