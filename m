Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F524F62BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiDFPQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiDFPQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9260F50D273;
        Wed,  6 Apr 2022 05:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 883EB618FE;
        Wed,  6 Apr 2022 12:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D07C385A3;
        Wed,  6 Apr 2022 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649247376;
        bh=5v3AQnHZZ8jEjcXCDtZexiGNzFftZWLppjBWO3R2KuU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mlS6d76xWO6f1K1NJN8KAHaBgeFeoW1ngVzPLNoaRrMPJUM6K7EXfN6zpssWCigIQ
         keYVreceYWtCZdqFdrEmRPQLFCSVtWxRW3//TbRnjDVW3CBE60OUwWwDo52keC8VM4
         29K7fw4L5SzmKnSHBZGVvPNvoWZ1Vmh3KmToHJXd84K9GKFbEVanRTEPy86kFVt+/o
         nusvFUfhmmUD79Eb/W8BXg5biYec8M05IZY5mAPNgQq3zlrJIMvVnA06RRb2C6lj/7
         8OcPh/owNxeudOn3NwJtbayH/juYEREIuF8FXQbim0PPNAT2qgzBaYgbAWrc29TDaA
         ijI8rmy8i4xiA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] orinoco: Prepare cleanup of powerpc's asm/prom.h
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <4e3bfd4ffe2ed6b713ddd99b69dcc3d96adffe34.1648833427.git.christophe.leroy@csgroup.eu>
References: <4e3bfd4ffe2ed6b713ddd99b69dcc3d96adffe34.1648833427.git.christophe.leroy@csgroup.eu>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164924737245.19026.5653169967927981259.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 12:16:14 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Patch applied to wireless-next.git, thanks.

3223e922ccf8 orinoco: Prepare cleanup of powerpc's asm/prom.h

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/4e3bfd4ffe2ed6b713ddd99b69dcc3d96adffe34.1648833427.git.christophe.leroy@csgroup.eu/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

