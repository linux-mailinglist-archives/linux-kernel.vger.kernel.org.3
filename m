Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378DF546717
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbiFJNHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345716AbiFJNHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C09433B8;
        Fri, 10 Jun 2022 06:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75B6EB83500;
        Fri, 10 Jun 2022 13:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DACC34114;
        Fri, 10 Jun 2022 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654866449;
        bh=v40DT+mYnONXrA044LlI8G52B2Gvk53cS0nDRgA7ak4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wIEFnEBUOkrARWiEcgO4jqbUeLMCzOp6fGIJJo6Kdn3rg+Z7CMHVEz4nqG7+s5NcP
         Y31siN0Ta1HViHfmBlGztR8dzth7sMoe2x1X8rDgb9ELN07qMDSlXbwPW5S4uVadIo
         qQTL9WC3U80XHjRwbNNcpmC+5G9ECi1qs2C9H87c=
Date:   Fri, 10 Jun 2022 15:07:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
        mchehab+huawei@kernel.org, eugenis@google.com, tony.luck@intel.com,
        pcc@google.com, peterz@infradead.org, marcos@orca.pet,
        marcan@marcan.st, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        arnd@arndb.de, ast@kernel.org, peter.chen@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX
 and x86
Message-ID: <YqNCDrqcp9t8HlUJ@kroah.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:05:24PM +0900, Kohei Tarumizu wrote:
> This patch series add sysfs interface to control CPU's hardware
> prefetch behavior for performance tuning from userspace for the
> processor A64FX and x86 (on supported CPU).

Why does userspace want to even do this?

How will they do this?

What programs will do this?

And why isn't just automatic and why does this hardware require manual
intervention to work properly?

thanks,

greg k-h
