Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196384D10B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344487AbiCHHHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiCHHHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:07:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD883D4B6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:06:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC16861610
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F96C340EB;
        Tue,  8 Mar 2022 07:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646723166;
        bh=SsdHusTl3QI8L9Ly+y53eKxrZbMr6a0OkOwSEoD9JVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mqfig3KDabrKxjUQH4fbAy3ai5Rig5TC0dONyPe8WoLOMcDB9GjViUgDzd4pAyjeR
         lSoX8erYqF9i8dU14DAhKvxxqHsU/RP90DcsochSvcJwiMpUpzQr4IS3er65NlUW7S
         wiDizF0RwKMY6XOzFfeTtYw4o8bd/hZ66cAqktoI=
Date:   Tue, 8 Mar 2022 08:06:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 2/2] misc: Add power-efuse driver
Message-ID: <YicAWbGN74F6SSNs@kroah.com>
References: <20220308011811.10353-1-zev@bewilderbeest.net>
 <20220308011811.10353-3-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308011811.10353-3-zev@bewilderbeest.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 05:18:10PM -0800, Zev Weiss wrote:
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7058,6 +7058,11 @@ S:	Orphan
>  W:	http://aeschi.ch.eu.org/efs/
>  F:	fs/efs/
>  
> +POWER EFUSE DRIVER
> +M:	Zev Weiss <zev@bewilderbeest.net>
> +S:	Maintained
> +F:	drivers/misc/power-efuse.c
> +
>  EHEA (IBM pSeries eHEA 10Gb ethernet adapter) DRIVER
>  M:	Douglas Miller <dougmill@linux.ibm.com>
>  L:	netdev@vger.kernel.org

Entries need to be in sorted order :(

