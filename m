Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FFD4B76C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiBOTgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:36:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243697AbiBOTgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:36:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2833C24A2;
        Tue, 15 Feb 2022 11:36:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78E81B818F3;
        Tue, 15 Feb 2022 19:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE494C340EB;
        Tue, 15 Feb 2022 19:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644953761;
        bh=mXUYdWjAyAGnzfunbLEvRbzhk1LQeTeub57on144Gog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQoUEG2PH9XDgvj9VgWfsiL+cXnmIUszgtgnX63DIOexHgyIxzm547vKPwBi55Rrg
         PlTl+2N2Su3Hhflt3+9AF6yjE0fPI+yWtvhvMsuQxAQdq0VjXg7PF9IDrlTrGcj4fU
         ss1Bl+2fP8Y0FobCLBxm7cUocwNLkc39f1vA8C9TmP1+LsMwU8aGEMg95cA2R4Rplc
         SfFCbWyQK7eeSqhYbdqJGdqQ0qW2EbDgfB3/WGJiearA3RcOwaOLM44eHqM17duxDJ
         PZ8MymJ/Y7F7EZmIZSt/ANDUP9lBpgIE3HPC/cQVNPgmAe3+wvA2u0U4i2Lm7sioQp
         cc7rhegLmsd4A==
Received: by pali.im (Postfix)
        id D05BCF13; Tue, 15 Feb 2022 20:35:58 +0100 (CET)
Date:   Tue, 15 Feb 2022 20:35:58 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] hwmon: (dell-smm) Reword and mark parameter "force"
 as unsafe
Message-ID: <20220215193558.rorm3vrwyxa4gkj7@pali>
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-8-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215191113.16640-8-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2022 20:11:13 Armin Wolf wrote:
> When enabling said module parameter, the driver ignores
> all feature blacklists on relevant models, which has the
> potential for strange side effects. Also there seems to
> be a slight chance for unsupported devices to behave
> badly when probed for features.
> In such cases, the kernel should be tainted to inform
> people that these issues might have been caused by
> the dell_smm_hwmon driver with "force" enabled.
> Also reword the parameter description to remind users
> that enabling "force" also enables blacklisted features.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 04a41d59da60..67d63932b48a 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -87,8 +87,8 @@ MODULE_LICENSE("GPL");
>  MODULE_ALIAS("i8k");
> 
>  static bool force;
> -module_param(force, bool, 0);
> -MODULE_PARM_DESC(force, "Force loading without checking for supported models");
> +module_param_unsafe(force, bool, 0);
> +MODULE_PARM_DESC(force, "Force loading without checking for supported models and features");
> 
>  static bool ignore_dmi;
>  module_param(ignore_dmi, bool, 0);
> --
> 2.30.2
> 
