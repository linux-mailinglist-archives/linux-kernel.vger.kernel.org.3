Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5952B0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 05:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiERDhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 23:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiERDhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 23:37:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA66E527C9;
        Tue, 17 May 2022 20:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF87616E1;
        Wed, 18 May 2022 03:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D641C385AA;
        Wed, 18 May 2022 03:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652845060;
        bh=MrXW9qQGHcgZhoXL6m8MOJ4Mp2j6g+aBVXG12fZqKEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBxEuVWeonS5rkVz4n7cTgTveOJLo1FG94xzjjla63iF7DZwYEUdNyoQARSNbv80Y
         7muGJ53TtJO+cwwu57YGEZ2S4sS+OxXXgxQmSaIOvo3SGRpzRI+Q6zMV9H+6TAqSm+
         BphGinIizjaFKziLMijBItXL2WFGDV3SLqMJz5hzi0qqEK0f3SFMQDc3AjJywPSdGV
         12JxKWpdNpiiqyVr3XRbsHXphynSK9NpHmZROg8IN91W0al1QE8c1vNrn2SxaD8H3a
         MSpfQMNYKGbbki3csRpBN1dd57Y5tkhTmdjSDPMraSH3xSjFN9gKEOXQ6OnMim1Ns+
         KsAzIXn8hIoCA==
Date:   Wed, 18 May 2022 11:37:35 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/chrome: Use tables for values lists of
 ChromeOS ACPI sysfs ABI
Message-ID: <YoRp/49OA9tqMd9N@google.com>
References: <20220518031750.21923-1-bagasdotme@gmail.com>
 <20220518031750.21923-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518031750.21923-2-bagasdotme@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 10:17:50AM +0700, Bagas Sanjaya wrote:
>  What:		/sys/bus/platform/devices/GGL0001:*/CHSW
>  Date:		May 2022
>  KernelVersion:	5.19
>  Description:
>  		This file shows the switch position for the Chrome OS specific
> -		hardware switches.
> -		  * 0   - No changes.
> -		  * 2   - Recovery button was pressed when firmware booted.
> -		  * 4   - Recovery button was pressed when EC firmware booted.
> -		  * 32  - Developer switch was enabled when firmware booted.
> -		  * 512 - Firmware write protection was disabled when firmware
> -			  booted.
> +		hardware switches when the firmare is booted.

s/firmare/firmware/.

Could you fix it in v2 and also Cc to <chrome-platform@lists.linux.dev>?
