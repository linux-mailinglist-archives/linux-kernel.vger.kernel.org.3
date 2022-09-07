Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806AD5AFFC6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiIGJBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:01:05 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 02:01:03 PDT
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9325A9E2E2;
        Wed,  7 Sep 2022 02:01:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id A66422B058C3;
        Wed,  7 Sep 2022 04:42:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 07 Sep 2022 04:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662540121; x=1662543721; bh=CwqfKMH8rF
        Jq0n8MfKf64/LLnkipF2ZC6faLaJQYssI=; b=iFbH69DPSIHen642gkFD6Df4Zc
        hvxltbsETwdEtCI7uJxGWG+E58xlt1mLUM87ZlfIr0xQJzkQ6GpwL/1C79P+hFUG
        HGAoRqamU1F5k7ZsvRELKOYF3gcAFccsMlCE2x+aLBGWBOLiWXrKi7OUyX2eNbkN
        COTBF7g7lS4s8LbLwWHQ6L1IvxOBrZJtRajiEa7Meq8kMxaVBjqIf3bsOA6VYinz
        vKnWur+5+2McBsE2hcSxYXJZ6mut+T4mrdAl0LgNyTBd1uHl9hqR6AkpEn9vgkmC
        Ou1+WiIR6PUE3FcaPPIO3NKoDs43b9fe4E6R4atR/ghDap5NcAQPvaQAukVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662540121; x=1662543721; bh=CwqfKMH8rFJq0n8MfKf64/LLnkip
        F2ZC6faLaJQYssI=; b=CAy84ntWnJCf1x+Ik4W8I4eDBhM+IJW3yRGscigfGxPp
        sW8yEM1pXDHGQF13EEiCUYVA4+FlkhsiUPNmBWrswZhfl+VKcVtz/E/drabhO3eJ
        be5rk6oBtaOj99sElD/uTu1VszaGsykIlDFRrUcQbQJLlvDaF5wK1iAQ1tz9uMK9
        zFR9+r+q4s+MtbS+90jrBqvQrAA5H1T6Yw68M2GVORmJY9VCmVAT/XA9Cn63yj7P
        bs9/v+uj1kxrEC45xHlXEzEmeNfzdM5hUiI6XyNQ2Rad4uU+qWt6dvK9J0NI7JOr
        rlq2LR3ZgTD2//XD3Z2J6I05QxVQEw4N/vsw3hLL7g==
X-ME-Sender: <xms:WFkYY_5WoLxuHstEPz3dFmgk10HXsMyVhQMMQL2NS7d0qfH_XMTtyg>
    <xme:WFkYY05aixySBJZI-F8Rf34EiYtu70hbvwnpr3sPTJDde15-BLUEEN01elG8qIuaE
    cQwvKy33ekME1RCqYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:WFkYY2ffvzUcraSjfGbccJpOVIRcEkKF_nU2nhNkUkDYWHdSBT3d7Q>
    <xmx:WFkYYwIVQM8sUZ18dCbyqQbmz3KXMzOJ3olYkeYBpGTeV28kJlhe7Q>
    <xmx:WFkYYzKCRCcmFzWivKUssrV0smQau_QWIvLEsuz05FY4PiwSY9LkhA>
    <xmx:WVkYY700gHe4BIxy75yuW2HAWAom3WMC6vVUqJZq9PbYGR7MVF-Zmoze08g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C7651B60083; Wed,  7 Sep 2022 04:42:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <77b0aa7b-3183-4a05-85ff-b278aa7f8f11@www.fastmail.com>
In-Reply-To: <CADVatmNSGSZZNXF7k7YmMqfcoOAiM6JhEfksjoVqoBOLUXfbPQ@mail.gmail.com>
References: <YxdX2l88PSFGe1r4@debian> <YxeAOgEoUffHudv/@kroah.com>
 <CADVatmNSGSZZNXF7k7YmMqfcoOAiM6JhEfksjoVqoBOLUXfbPQ@mail.gmail.com>
Date:   Wed, 07 Sep 2022 10:41:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Kumaravel Thiagarajan" <kumaravel.thiagarajan@microchip.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: build failure of next-20220906 due to 4ec7ac90ff39 ("misc: microchip:
 pci1xxxx: Add power management functions - suspend & resume handlers.")
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022, at 11:07 PM, Sudip Mukherjee wrote:
> On Tue, Sep 6, 2022 at 6:15 PM Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>> On Tue, Sep 06, 2022 at 03:23:22PM +0100, Sudip Mukherjee (Codethink) wrote:
>> >
>> > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error: 'pci1xxxx_gpio_resume' defined but not used [-Werror=unused-function]
>> >   311 | static int pci1xxxx_gpio_resume(struct device *dev)
>> >       |            ^~~~~~~~~~~~~~~~~~~~
>> > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error: 'pci1xxxx_gpio_suspend' defined but not used [-Werror=unused-function]
>> >   295 | static int pci1xxxx_gpio_suspend(struct device *dev)
>> >       |            ^~~~~~~~~~~~~~~~~~~~~
>> >
>> >
>> > git bisect pointed to 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.").
>> >
>
> Looking at other drivers which uses SIMPLE_DEV_PM_OPS, I think
> pci1xxxx_gpio_suspend() and pci1xxxx_gpio_resume() needs to be under
> "#ifdef CONFIG_PM_SLEEP".

That would work, but a better fix is to use DEFINE_SIMPLE_DEV_PM_OPS()
in place of the deprecated SIMPLE_DEV_PM_OPS().

     Arnd
