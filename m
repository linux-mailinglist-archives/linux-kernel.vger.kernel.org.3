Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354924AC8FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiBGS7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiBGS5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:57:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2CCC0401F4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:57:20 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF1601EC02B9;
        Mon,  7 Feb 2022 19:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644260234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PPFoq/KfBO2kowrqfUfB0TFIrcrDCEWeUZ4fipD381w=;
        b=g31qGmHOW9+Y86dMxZ3u2lfC7Rc6TLQA4ocDZ1uCP24sEBgPz/ODaXfQ2P7DWSVrcjW6wW
        nfED86Z5aROr6s8U/0Krw+L0Q+LW4qisQc2QBgzhXdVaefLnuBIuyaiJVzz5uRaC5rSZZn
        whRZn8AsqTe2TGeZE5aboySxs8SQXGc=
Date:   Mon, 7 Feb 2022 19:57:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH 1/2] x86/Kconfig: move and modify CONFIG_I8K
Message-ID: <YgFrieUmgaw1yGkf@zn.tnic>
References: <20220207182940.242838-1-mat.jonczyk@o2.pl>
 <43bfd6d9-58a3-6f9c-0848-4ef147552afb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43bfd6d9-58a3-6f9c-0848-4ef147552afb@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:51:10PM +0100, Hans de Goede wrote:
> For other reviewers, the only consumer of the CONFIG_I8K
> option is drivers/hwmon/dell-smm-hwmon.c
> which has a couple of:
> "#if IS_ENABLED(CONFIG_I8K)" checks to enable its old
> legacy /proc/i8k interface.
> 
> So this move definitely makes sense.

I love patches removing code from arch/x86/ so for the move:

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
