Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1475E50055E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiDNFTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiDNFTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:19:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DEA2C656;
        Wed, 13 Apr 2022 22:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1791CE27C1;
        Thu, 14 Apr 2022 05:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF68C385A5;
        Thu, 14 Apr 2022 05:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649913393;
        bh=OJIo8H9wFfSlFFeLP9Vsli+k2plT4Hit7hRYD5uhZfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vIVUmXsxGJiqZj969VskWIDwSaP4lhMP3rxNV/7lDU++H+60R0BBpQ6ZZ7BQSQdZn
         ZjEAzlyigxJDEqi7BRILysSqn/kaXvWTHRqVpgHnt2id82JpCqv8XSBEPoWI0Fg7E2
         c6llVhQ7FX1mEZ75gerA3KDWbq/Bu/pcaSsWJUtqu8IxW1uBpnprJCugTRWzHlUfVZ
         xDYoPW3xNFgHq8bIuB9Xzu6uqxB37CnYWM81OYkz8qXQkS1LhE/VzLoQjIrsRQCgvB
         KeYxvmkOcpYw7FcQlvZrnOqCF3wCYIxs6MQv5Tu0jkr+h/kxJb1fNrS7MgtrABfCw/
         OotQ+Zedt39lQ==
Date:   Thu, 14 Apr 2022 10:46:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the phy tree
Message-ID: <YleuLWpFl02Mqeex@matsya>
References: <20220414073236.1f955bff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414073236.1f955bff@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-04-22, 07:32, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   8724489e5ffc ("phy: ti: Add missing pm_runtime_disable() in serdes_am654_probe")
> 
> Fixes tag
> 
>   Fixes: 71e2f5c ("phy: ti: Add a new SERDES driver for TI's AM654x SoC")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").
> 
> In commit
> 
>   19974ef56750 ("phy: mapphone-mdm6600: Fix PM error handling in phy_mdm6600_probe")
> 
> Fixes tag
> 
>   Fixes: f7f50b2 ("phy: mapphone-mdm6600: Add runtime PM support for n_gsm on USB suspend")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").

Thanks fixed that..

Btw I am sure you have a script for this, can I get that. It would be
good to run that as part of patch tests before applying


-- 
~Vinod
