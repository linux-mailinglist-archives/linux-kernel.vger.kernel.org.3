Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509054F0066
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbiDBKSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354271AbiDBKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:17:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E27D1A8C15;
        Sat,  2 Apr 2022 03:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A206E61239;
        Sat,  2 Apr 2022 10:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68767C340EC;
        Sat,  2 Apr 2022 10:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648894561;
        bh=DkcXIedyA5WoWD32Wfb0ixzTbuY09aixGrQDXb2pWC4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ubyq+QT4nm5P5Q5jYMYqHGm9WwTMjgbKsyVVjNgMFWMHNbJS2QAto+N13XfwbUGQ5
         E9Cw+1xNlRSRJo1dz2ufaEaviqxRvbpnOggN/BG/X7QcB5g/mOBWeBlxdYW4Opit9h
         eQRyWfKOWWZvM1vnKw7kY792vP4/SQm5M4QlyrtfHhY2qx/H+0+oPU56HnMFrbYR6H
         4btd8Ny9o9VB0BEYnpplH8+CPyvNaz39SKDKNiwxEP7uUvvreHJ5X9oyL1ZgKNMpS6
         iUv66Ozt8HeIcE13uCoRA0PxZUAUclSnr3gyA+gXU79l7Mty5oLwYAwC7GtMblmmGZ
         3iNzO2UFdz/ow==
From:   Kalle Valo <kvalo@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next] orinoco: Prepare cleanup of powerpc's asm/prom.h
In-Reply-To: <4e3bfd4ffe2ed6b713ddd99b69dcc3d96adffe34.1648833427.git.christophe.leroy@csgroup.eu>
        (Christophe Leroy's message of "Sat, 2 Apr 2022 12:10:37 +0200")
References: <4e3bfd4ffe2ed6b713ddd99b69dcc3d96adffe34.1648833427.git.christophe.leroy@csgroup.eu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Sat, 02 Apr 2022 13:15:55 +0300
Message-ID: <878rsnu6xw.fsf@kernel.org>
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
>
> In order to clean it up, first add missing headers in
> users of asm/prom.h
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/net/wireless/intersil/orinoco/airport.c | 1 +
>  1 file changed, 1 insertion(+)

orinoco patches are applied to wireless-next, not net-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
