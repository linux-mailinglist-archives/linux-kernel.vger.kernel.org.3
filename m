Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9523A4C6B92
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiB1MEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiB1MD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:03:58 -0500
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 04:03:11 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897AB3ED29;
        Mon, 28 Feb 2022 04:03:11 -0800 (PST)
Received: from [192.168.178.30] ([212.18.30.247]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MYvoW-1nkfdr1Xvc-00UrUA; Mon, 28 Feb 2022 12:57:47 +0100
Message-ID: <9c1abed8-924f-9f88-4a9b-94a9b931c2c3@rdorf.de>
Date:   Mon, 28 Feb 2022 12:57:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] input/i8042: Add TUXEDO/Clevo devices to i8042 quirk
 tables
Content-Language: en-US
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Werner Sembach <wse@tuxedocomputers.com>
References: <20220228114819.32949-1-wse@tuxedocomputers.com>
From:   Werner Sembach <werner@rdorf.de>
In-Reply-To: <20220228114819.32949-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:C2g3jHncCLBEQt6qPrgNQZPzFpBI9COZt4TXhz53q+d2WqEAfxa
 w+t9SshXxw/PVs1iw3VZyRRWxHrE0SkxqhsajaLS7QOLJkov4jTXEJNB1Str9mB1Xk57Rp5
 i4g3gUUtaZW0R0PekfTocAOn8naH583xH+nz8EpXeXEOoHy56L47Tp4OhVNCAEpTOG6+d3N
 gZT8mp/i2y5MOeFLen55A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:56JUor0o0ho=:vD2Qb09ONHOxJdjWrrWRfO
 xmFcGMuAqXWw0ORu9RiWDQvuhtzxZ2HIOpbiYPVXU8twgJBNCf+TCl5NbKvubAnXXNqheIaVN
 BJBd7ah0OiLWM9xJCqZp4dM7KLrZJgNofqNhcI2LZBF+dIl6/dk+30IzLMb/fLm0R/HXCehfA
 LAkubzy5whCXOJcZts6P2DRwzRVcm6t52tqmBjRg9CJYgggGJV3PFfA5mhA6UxhMcdgNEJyAy
 SJHEGhhLpZzWHhqo/YnQdHLNDEdMBAcqfTm0hnOUAWy6vmXsaBV1gRZseTUc6tyPsKjCaBu/i
 xfrOmdyssYHl0LoYNvY5AO2OZd/l6/Jbw8CS2voLiH4t5OPdETEPbbu5omrg/tdgTWIBo8raK
 YNVemWiiwoe/RrPEBaVS541Q+DJRPBEL4qkPRdbdjs+CSKBsmdsp4ti4zcdjJSZoJ1qb3YL3/
 Qyzn2KbvSxs39LYIHkxgnHKqKA+WNpvebrjm0Jjjq1GcbNcg3X4UpCwE/5iRru8iUQXaLSa5n
 RHI35oHFtGGrR/tShyYIJkkLYgFcy7zH56LJ1KCb27OJVU6CKqDm+kU+C78H2G3VKXmJgWDkg
 Wqb/vqL1aRjEQL+2twxuySYiyoKQSmQOeHI9s2PiSYgWKC9dPpRwQGsBSGjJ953lKew7TrTDJ
 IVgFU4+8H/Yr93eKDEmRAU9xLlPLQbnQKqDE2vKIt/zjztPoTlKYECaFEi1toDPRfa8Q=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
> suspend, fixable with reset + nomux + nopnp + noloop. Luckily, none of them
> have an external PS/2 port so this can safely be set for all of them.
>
> I'm not entirely sure if every device listed really needs all four quirks,
> but after testing and production use. No negative effects could be
> observed when setting all four.
>
> The list is quite massive as neither the TUXEDO nor the Clevo dmi strings
> have been very consistent historically. I tried to keep the list as short
> as possible without risking on missing an affected device.
>
> This is revision 2 where the Clevo N150CU barebone is removed again, as it
> might have problems with the fix and needs further investigations. Also
> the SchenkerTechnologiesGmbH System-/Board-Vendor string variations are
> added.

I wonder if I should split this patch on a per device basis? As the diff kinda gets a little bit confused with this
amount of lines added.

Also writing this from my other e-mail address because I wonder if I got spam filtered or something? because my last 2
patches got no reply.

I also just spotted a formatting error, but I will wait for a reply to my first question before I create a v3.

> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 2384 ++++++++++++++++++++++---
>  1 file changed, 2116 insertions(+), 268 deletions(-)
>
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 148a7c5fd0e2..fb8da60d908f 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -226,566 +226,2414 @@ static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "ByteSpeed Laptop C15B"),
>  		},
>  	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with reset + nomux + nopnp + noloop. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for
> +	 * all of them.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{ }
> +};
> +
> +/*
> + * Some Fujitsu notebooks are having trouble with touchpads if
> + * active multiplexing mode is activated. Luckily they don't have
> + * external PS/2 ports so we can safely disable it.
> + * ... apparently some Toshibas don't like MUX mode either and
> + * die horrible death on reboot.
> + */
> +static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
> +	{
> +		/* Fujitsu Lifebook P7010/P7010D */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P7010"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook P7010 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "0000000000"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook P5020D */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P Series"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook S2000 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S Series"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook S6230 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook T725 laptop */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook U745 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
> +		},
> +	},
> +	{
> +		/* Fujitsu T70H */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
> +		},
> +	},
> +	{
> +		/* Fujitsu-Siemens Lifebook T3010 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
> +		},
> +	},
> +	{
> +		/* Fujitsu-Siemens Lifebook E4010 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
> +		},
> +	},
> +	{
> +		/* Fujitsu-Siemens Amilo Pro 2010 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
> +		},
> +	},
> +	{
> +		/* Fujitsu-Siemens Amilo Pro 2030 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
> +		},
> +	},
> +	{
> +		/*
> +		 * No data is coming from the touchscreen unless KBC
> +		 * is in legacy mode.
> +		 */
> +		/* Panasonic CF-29 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "CF-29"),
> +		},
> +	},
> +	{
> +		/*
> +		 * HP Pavilion DV4017EA -
> +		 * errors on MUX ports are reported without raising AUXDATA
> +		 * causing "spurious NAK" messages.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EA032EA#ABF)"),
> +		},
> +	},
> +	{
> +		/*
> +		 * HP Pavilion ZT1000 -
> +		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Notebook PC"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook ZT1000"),
> +		},
> +	},
> +	{
> +		/*
> +		 * HP Pavilion DV4270ca -
> +		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EH476UA#ABL)"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EQUIUM A110"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE C850D"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
> +		},
> +	},
> +	{
> +		/* Sharp Actius MM20 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
> +		},
> +	},
> +	{
> +		/* Sony Vaio FS-115b */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
> +		},
> +	},
> +	{
> +		/*
> +		 * Sony Vaio FZ-240E -
> +		 * reset and GET ID commands issued via KBD port are
> +		 * sometimes being delivered to AUX3.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ240E"),
> +		},
> +	},
> +	{
> +		/*
> +		 * Most (all?) VAIOs do not have external PS/2 ports nor
> +		 * they implement active multiplexing properly, and
> +		 * MUX discovery usually messes up keyboard/touchpad.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
> +		},
> +	},
> +	{
> +		/* Amoi M636/A737 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
> +		},
> +	},
> +	{
> +		/* Lenovo 3000 n100 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "076804U"),
> +		},
> +	},
> +	{
> +		/* Lenovo XiaoXin Air 12 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
> +		},
> +	},
> +	{
> +		/* Acer Aspire 5710 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
> +		},
> +	},
> +	{
> +		/* Acer Aspire 7738 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7738"),
> +		},
> +	},
> +	{
> +		/* Gericom Bellagio */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
> +		},
> +	},
> +	{
> +		/* IBM 2656 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
> +		},
> +	},
> +	{
> +		/* Dell XPS M1530 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
> +		},
> +	},
> +	{
> +		/* Compal HEL80I */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "COMPAL"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
> +		},
> +	},
> +	{
> +		/* Dell Vostro 1510 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
> +		},
> +	},
> +	{
> +		/* Acer Aspire 5536 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
> +		},
> +	},
> +	{
> +		/* Dell Vostro V13 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
> +		},
> +	},
> +	{
> +		/* Newer HP Pavilion dv4 models */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
> +		},
> +	},
> +	{
> +		/* Asus X450LCP */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
> +		},
> +	},
> +	{
> +		/* Avatar AVIU-145A6 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
> +		},
> +	},
> +	{
> +		/* TUXEDO BU1406 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
> +		},
> +	},
> +	{
> +		/* Lenovo LaVie Z */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
> +		},
> +	},
> +	{
> +		/*
> +		 * Acer Aspire 5738z
> +		 * Touchpad stops working in mux mode when dis- + re-enabled
> +		 * with the touchpad enable/disable toggle hotkey
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
> +		},
> +	},
> +	{
> +		/* Entroware Proteus */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
> +		},
> +	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with reset + nomux + nopnp + noloop. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for
> +	 * all of them.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static const struct dmi_system_id i8042_dmi_forcemux_table[] __initconst = {
> +	{
> +		/*
> +		 * Sony Vaio VGN-CS series require MUX or the touch sensor
> +		 * buttons will disturb touchpad operation
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
> +		},
> +	},
> +	{ }
> +};
> +
> +/*
> + * On some Asus laptops, just running self tests cause problems.
> + */
> +static const struct dmi_system_id i8042_dmi_noselftest_table[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> +		},
> +	}, {
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
> +		},
> +	},
> +	{ }
> +};
> +static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
> +	{
> +		/* MSI Wind U-100 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
> +		},
> +	},
> +	{
> +		/* LG Electronics X110 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "X110"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
> +		},
> +	},
> +	{
> +		/* Acer Aspire One 150 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
> +		},
> +	},
> +	{
> +		/* Advent 4211 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
> +		},
> +	},
> +	{
> +		/* Medion Akoya Mini E1210 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
> +		},
> +	},
> +	{
> +		/* Medion Akoya E1222 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
> +		},
> +	},
> +	{
> +		/* Mivvy M310 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
> +		},
> +	},
> +	{
> +		/* Dell Vostro 1320 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1320"),
> +		},
> +	},
> +	{
> +		/* Dell Vostro 1520 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
> +		},
> +	},
> +	{
> +		/* Dell Vostro 1720 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
> +		},
> +	},
> +	{
> +		/* Lenovo Ideapad U455 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
> +		},
> +	},
> +	{
> +		/* Lenovo ThinkPad L460 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
> +		},
> +	},
> +	{
> +		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
> +		},
> +	},
> +	{
> +		/* Lenovo ThinkPad Twist S230u */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "33474HU"),
> +		},
> +	},
> +	{
> +		/* Entroware Proteus */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
> +		},
> +	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with reset + nomux + nopnp + noloop. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for
> +	 * all of them.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
>  	{ }
>  };
>  
> -/*
> - * Some Fujitsu notebooks are having trouble with touchpads if
> - * active multiplexing mode is activated. Luckily they don't have
> - * external PS/2 ports so we can safely disable it.
> - * ... apparently some Toshibas don't like MUX mode either and
> - * die horrible death on reboot.
> - */
> -static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
> +#ifdef CONFIG_PNP
> +static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
>  	{
> -		/* Fujitsu Lifebook P7010/P7010D */
> +		/* Intel MBO Desktop D845PESV */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "P7010"),
> +			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
>  		},
>  	},
>  	{
> -		/* Fujitsu Lifebook P7010 */
> +		/*
> +		 * Intel NUC D54250WYK - does not have i8042 controller but
> +		 * declares PS/2 devices in DSDT.
> +		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "0000000000"),
> +			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
>  		},
>  	},
>  	{
> -		/* Fujitsu Lifebook P5020D */
> +		/* MSI Wind U-100 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P Series"),
> +			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
>  		},
>  	},
>  	{
> -		/* Fujitsu Lifebook S2000 */
> +		/* Acer Aspire 5 A515 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S Series"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
>  		},
>  	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with reset + nomux + nopnp + noloop. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for
> +	 * all of them.
> +	 */
>  	{
> -		/* Fujitsu Lifebook S6230 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>  		},
>  	},
>  	{
> -		/* Fujitsu Lifebook T725 laptop */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>  		},
>  	},
>  	{
> -		/* Fujitsu Lifebook U745 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>  		},
>  	},
>  	{
> -		/* Fujitsu T70H */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>  		},
>  	},
>  	{
> -		/* Fujitsu-Siemens Lifebook T3010 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>  		},
>  	},
>  	{
> -		/* Fujitsu-Siemens Lifebook E4010 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/* Fujitsu-Siemens Amilo Pro 2010 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/* Fujitsu-Siemens Amilo Pro 2030 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/*
> -		 * No data is coming from the touchscreen unless KBC
> -		 * is in legacy mode.
> -		 */
> -		/* Panasonic CF-29 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "CF-29"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/*
> -		 * HP Pavilion DV4017EA -
> -		 * errors on MUX ports are reported without raising AUXDATA
> -		 * causing "spurious NAK" messages.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EA032EA#ABF)"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/*
> -		 * HP Pavilion ZT1000 -
> -		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Notebook PC"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook ZT1000"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/*
> -		 * HP Pavilion DV4270ca -
> -		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EH476UA#ABL)"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "EQUIUM A110"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE C850D"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
> -		/* Sharp Actius MM20 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
> -		/* Sony Vaio FS-115b */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
> -		/*
> -		 * Sony Vaio FZ-240E -
> -		 * reset and GET ID commands issued via KBD port are
> -		 * sometimes being delivered to AUX3.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ240E"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
> -		/*
> -		 * Most (all?) VAIOs do not have external PS/2 ports nor
> -		 * they implement active multiplexing properly, and
> -		 * MUX discovery usually messes up keyboard/touchpad.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> -			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
> -		/* Amoi M636/A737 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
> -		/* Lenovo 3000 n100 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "076804U"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
> -		/* Lenovo XiaoXin Air 12 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Acer Aspire 5710 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Acer Aspire 7738 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7738"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Gericom Bellagio */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
>  		},
>  	},
>  	{
> -		/* IBM 2656 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
>  		},
>  	},
>  	{
> -		/* Dell XPS M1530 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Compal HEL80I */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "COMPAL"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Dell Vostro 1510 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Acer Aspire 5536 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
>  		},
>  	},
>  	{
> -		/* Dell Vostro V13 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
>  		},
>  	},
>  	{
> -		/* Newer HP Pavilion dv4 models */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/* Asus X450LCP */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/* Avatar AVIU-145A6 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/* TUXEDO BU1406 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/* Lenovo LaVie Z */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/*
> -		 * Acer Aspire 5738z
> -		 * Touchpad stops working in mux mode when dis- + re-enabled
> -		 * with the touchpad enable/disable toggle hotkey
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/* Entroware Proteus */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
>  	},
> -	{ }
> -};
> -
> -static const struct dmi_system_id i8042_dmi_forcemux_table[] __initconst = {
>  	{
> -		/*
> -		 * Sony Vaio VGN-CS series require MUX or the touch sensor
> -		 * buttons will disturb touchpad operation
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
>  	},
> -	{ }
> -};
> -
> -/*
> - * On some Asus laptops, just running self tests cause problems.
> - */
> -static const struct dmi_system_id i8042_dmi_noselftest_table[] = {
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
> -	}, {
> +	},
> +	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
>  	},
> -	{ }
> -};
> -static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
>  	{
> -		/* MSI Wind U-100 */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
>  	},
>  	{
> -		/* LG Electronics X110 */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "X110"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
>  	},
>  	{
> -		/* Acer Aspire One 150 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
> -		/* Advent 4211 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
> -		/* Medion Akoya Mini E1210 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
> -		/* Medion Akoya E1222 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
> -		/* Mivvy M310 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
> -		/* Dell Vostro 1320 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1320"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Dell Vostro 1520 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Dell Vostro 1720 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Lenovo Ideapad U455 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Lenovo ThinkPad L460 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Lenovo ThinkPad Twist S230u */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "33474HU"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
>  	{
> -		/* Entroware Proteus */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
> -	{ }
> -};
> -
> -#ifdef CONFIG_PNP
> -static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
>  	{
> -		/* Intel MBO Desktop D845PESV */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
>  	{
> -		/*
> -		 * Intel NUC D54250WYK - does not have i8042 controller but
> -		 * declares PS/2 devices in DSDT.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
>  	{
> -		/* MSI Wind U-100 */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
>  	{
> -		/* Acer Aspire 5 A515 */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
>  	{ }
