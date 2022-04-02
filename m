Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F144EFF86
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiDBICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiDBICc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69FA12757
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 679216106D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 08:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AAFC340EE;
        Sat,  2 Apr 2022 08:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648886439;
        bh=wq71YjT4VK4NpO8aXHJFi/aLVMrLZFB2XCi5LUTwopE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=h3ACeUYNzpeH6caC6qbaNu6bBEfb6YMB9EM520Xz9BWMbMiICgClavXffLoGsxDjE
         FOhruj6Ca/3/KMqrl6IiXqMi5f23RzxL4xPNZpCrtcWgAHWiev/eKyHchMOhzbuTq5
         BGevzVtSXk+tDCeV6q1l546ZplpogRRj4DXUXFoJufSlm0AAor5u8NnhXJGUFxDBeI
         v3km8T9gQVhPL/LtZWqyLS4MlXirqLT99wm6mO+vjSDuJnwQ7qALq6YPUMkQFEuFk4
         Li9W3oIYOQ8xrI5i/GmQ5FF+fQAfutuFBy4IGfhcdmSrLQApmv2oty2SAK3r48Zlp2
         F5R3ThNKTtrdg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
References: <20220401212639.GA131100@bhelgaas>
Date:   Sat, 02 Apr 2022 11:00:33 +0300
In-Reply-To: <20220401212639.GA131100@bhelgaas> (Bjorn Helgaas's message of
        "Fri, 1 Apr 2022 16:26:39 -0500")
Message-ID: <87ilrrud7i.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> [+cc David, Marc for possibly archiving linux-afs on lore]
>
> On Fri, Apr 01, 2022 at 01:50:12PM -0700, Randy Dunlap wrote:
>
>> There seem to be some mailing lists from lists.infradead.org that are not (yet?)
>> archived on lore.
>> Is there a plan to add more list archives from infradead to lore?
>
> Good question.  I don't know how to find out what things are hosted at
> infradead (it redirects to https://lists.openwrt.org/mailman/listinfo),
> but in the linux git history, I found URLs for these lists that are
> not on lore:
>
>   barebox             1 link from 2014
>   kexec               5 links, most recent from 2021
>   lede-commits        1 link from 2017
>   linux-afs          16 links, most recent 2021
>   linux-parport       1 link from 2005
>   linux-pcmcia        6 links, most recent 2010
>   linux-rpi-kernel    1 link from 2019
>   linux-um            1 link from 2020
>
> linux-afs looks like a good candidate for lore.  Possibly kexec, too.
>
> linux-rpi-kernel seems like it might be of interest and
> https://lists.infradead.org/pipermail/linux-rpi-kernel/ still shows
> some activity.  Unfortunately the only URL I see in the git logs
> (http://lists.infradead.org/pipermail/linux-rpi-kernel/2019-March/008615.html)
> is already dead.
>
> The following infradead lists appear to be archived on lore already:
>
>   ath10k
>   b43-dev
>   linux-amlogic
>   linux-arm-kernel
>   linux-mediatek
>   linux-mtd
>   linux-nvme
>   linux-riscv
>   linux-snps-arc

FWIW, ath11k list is also archived on lore. Thanks to your suggestion :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
