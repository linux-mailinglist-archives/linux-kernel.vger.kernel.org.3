Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89381517F01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiECHhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiECHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:37:44 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E82369FF;
        Tue,  3 May 2022 00:34:12 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2E2B822247;
        Tue,  3 May 2022 09:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651563250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2yo6GH2XKa0DiBlPl7lcA/IqHOj0HQP3yysuqJpBBA=;
        b=Z3aFubNjF7TrVAgDTACB55MhH2XMj2PBfA6aMiJWDyQKF8FYjSWeYNomLUy3O/spDRogsm
        I2HZvN7SsGi10cUADDqmTjeZTq7G/CoGtvtJ9SYqaT8dRldfERLQPYEUgrHh2mSW4+JPUR
        FS/QaEREX7XHkZJTNDKDVBfOqFLzLsY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 May 2022 09:34:09 +0200
From:   Michael Walle <michael@walle.cc>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
In-Reply-To: <20220503172259.294a15a1@canb.auug.org.au>
References: <20220503172259.294a15a1@canb.auug.org.au>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <02ca2b24427d1ad4a8cb84cbf131c64e@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-05-03 09:22, schrieb Stephen Rothwell:
> After merging the hwmon-staging tree, today's linux-next build 
> (htmldocs)
> produced this warning:
> 
> Documentation/hwmon/lan966x.rst: WARNING: document isn't included in 
> any toctree
> 
> Introduced by commit
> 
>   14ed2cdb02e0 ("hwmon: add driver for the Microchip LAN966x SoC")

Ouch. Guenter, should I send a fix on top or will you fix it in
your tree?

-michael
