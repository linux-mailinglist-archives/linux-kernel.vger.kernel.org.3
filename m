Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9794948CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiATHp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiATHp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:45:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2856C061574;
        Wed, 19 Jan 2022 23:45:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B2A6616EC;
        Thu, 20 Jan 2022 07:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEBFC340E5;
        Thu, 20 Jan 2022 07:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642664727;
        bh=9ZJSx2TYLXQG4OphMRKHxDWvwvEOpIaayDPvmIc2tQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6T+YmDoljBbludzB8vGmsAYHcDvHYarFkhvb+BbJTriecXwqCQ3nuJL0AWXozWwj
         IDZfbMClYfBhSBnP/mUG6d+C82+1CiUOG2zw1oDfVCddJoUHD3Yn4KO7SngILRNV/n
         qjfsjpL+FM8ROkHwaTmOsKn5Ms+nm/wa8zPf4sAo=
Date:   Thu, 20 Jan 2022 08:45:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v20 2/5] driver core: Export device_is_bound()
Message-ID: <YekTFMnXK87MNMh3@kroah.com>
References: <20220119204345.3769662-1-mka@chromium.org>
 <20220119124327.v20.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
 <YekPTh/G1IkvpSiI@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YekPTh/G1IkvpSiI@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:29:18PM -0800, Christoph Hellwig wrote:
> On Wed, Jan 19, 2022 at 12:43:42PM -0800, Matthias Kaehlcke wrote:
> > Export device_is_bound() to enable its use by drivers that are
> > built as modules.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> Didn't Greg clearly NAK this the last few times it came up?

Yes, which is why this series is _WAY_ on the bottom of my list for
reviews...

greg k-h
