Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8B54ADA80
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377047AbiBHN4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376885AbiBHN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:56:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70664C03FED5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:56:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30BD4210F6;
        Tue,  8 Feb 2022 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644328605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzbH78aaKbEWQFzxiM0uYcTtkPHS6I5wXZbs6gQ3Etk=;
        b=dDGsNpsbDmpdLeAwmFR/N/y7NXeY4UkTHeZDPG2HRr8kRG2jpICs1zKE9Kw5ruC68r6owJ
        ZcUNXl/4+O4jot4MNd+P2KtsKMyhOd4dLwbGkS4s5V/tHzG6u4VTvOqalhv7EuQLCrbt5V
        TXubF6Z7cpcPhrlvowxH/BIdvKeHYNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644328605;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzbH78aaKbEWQFzxiM0uYcTtkPHS6I5wXZbs6gQ3Etk=;
        b=a/7JYFruBUNmIBavhT4iOMTwORBOJigP9LfXrCE/DhiZRjcbO1qs3dmimbjAbtl6ywvr15
        8UnZmggUkn/jpFBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1C5613C99;
        Tue,  8 Feb 2022 13:56:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o01UOZx2AmLNcQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 08 Feb 2022 13:56:44 +0000
Date:   Tue, 8 Feb 2022 14:56:43 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Florian =?UTF-8?B?c3Axcml04oCL?= <sp1rit@disroot.org>
Cc:     sp1rit@national.shitposting.agency, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/dmi: Allow overriding vendor provided DMIIDs
Message-ID: <20220208145643.604338d8@endymion.delvare>
In-Reply-To: <20220206104636.19146-1-sp1rit@disroot.org>
References: <20220206104636.19146-1-sp1rit@disroot.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Sun, 06 Feb 2022 11:46:36 +0100, Florian sp1rit=E2=80=8B wrote:
> Various device vendors do not properly fill out the SMBIOS/DMI
> information in the bios firmware of their devices. This leads to
> issues, like finding "System manufacturer System Product Name" under
> "Hardware Information" in GNOME Settings, which made it's way there
> (over a few dbus detours) from DMIIDs provided from the kernel.
>=20
> This patch intoduces a handful kernel parameters that allow
> overriding these values with user defined ones, similar to changing
> values in HKLM\HARDWARE\DESCRPTION\System\Bios or
> $WINDIR/system32/OEMINFO.ini on Microsoft Windows.
>=20
> The alternative would either be patching the vendor provided bios
> CAP file, which seems quite dangerous and might not even work if
> the update has to be signed. Or introducing some kind of
> configuration file to systemd-hostnamed to allow the overriding of
> the values from userspace. However that might work for this usecase,
> but most software will not use hostnamed, since simply reading a
> file is a lot simpler that having to rely on dbus to query system
> information.

I'm absolutely not convinced by the idea. This is fixing the problem at
the wrong place. If the BIOS is reporting wrong information, and you
really care about it, then complain to the manufacturer and have them
provide a BIOS update to fix it. If they can't be bothered (which I
know is often the case) then this might be a good reason to consider a
different manufacturer next time.

To be honest, GNOME Settings displaying invalid system information on
crappy systems is the least of my concerns. Even if this happened on a
system I was running, I wouldn't bother passing kernel parameters to
work around that.

Furthermore this is creating a lot of room for risk and abuse. Such as
using the UUID of one system on another, or accidentally claiming that a
given system is a completely different one and getting unrelated kernel
drivers loaded and probing hardware in unexpected ways. I don't want to
have to deal with the fallout of that.

So this is a no from me, sorry.

--=20
Jean Delvare
SUSE L3 Support
