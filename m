Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C291949C5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiAZJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiAZJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:04:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EB1C06161C;
        Wed, 26 Jan 2022 01:04:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E579E61544;
        Wed, 26 Jan 2022 09:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A60C340E3;
        Wed, 26 Jan 2022 09:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643187869;
        bh=JDNYGgFq0hXvSiYlcEMl78MdyOJggHk5HGuIPpl0S8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8wsdZC0ssMnnVzL5VKTn1r4jWwvucnbkLC3pCLnQfNlcdB2VjoreHNNbSbl29wia
         0AkpBjc/UTuREr/uh7UN7+u+Igd+7duHCe4FtQVAM2zZHOS7cU+dSf7rHo+YJ/bL/e
         UC3wmm1d+vHc3OxXxwWXEpZTQRcWJcfYJa7gdx58=
Date:   Wed, 26 Jan 2022 10:04:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Driver for Open Profile for DICE
Message-ID: <YfEOlN8Wshoa/aaB@kroah.com>
References: <20220104100645.1810028-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104100645.1810028-1-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 10:06:43AM +0000, David Brazdil wrote:
> Open Profile for DICE is an open protocol for measured boot compatible
> with the Trusted Computing Group's Device Identifier Composition
> Engine (DICE) specification. The generated Compound Device Identifier
> (CDI) certificates represent the measured hardware/software combination
> and can be used by userspace for remote attestation and sealing.
> 
> This patchset adds DeviceTree bindings for the DICE device referencing
> a reserved memory region containing the CDIs, and a driver that exposes
> the memory region to userspace via a misc device.
> 
> See https://pigweed.googlesource.com/open-dice for more details.
> 
> The patches are based on top of v5.16-rc8 and can also be found here:
>   https://android-kvm.googlesource.com/linux topic/dice_v6
> 
> Changes since v5:
>   * replaced 'additionalProperties' with 'unevaluatedProperties' in DT YAML

I am going to drop this version from my review queue as I think you have
a new one instead, right?

thanks,

greg k-h
