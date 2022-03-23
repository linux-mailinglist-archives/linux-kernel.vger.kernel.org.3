Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89DE4E5A76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344495AbiCWVKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbiCWVKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:10:49 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926045F4E2;
        Wed, 23 Mar 2022 14:09:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A1F45C0209;
        Wed, 23 Mar 2022 17:09:16 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute3.internal (MEProxy); Wed, 23 Mar 2022 17:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=yMBJ76WhKgdMHhWkyFbX2/uDoE2hlT
        Hf5GOeRZgK5ic=; b=dhaFZfl+DscAC2FMO+Jye26iArtt8431/d1PK9ud15/4ik
        WHhjOf1jVFJv9QE6C9VmAbI4udK1nDp29i/Ddi2imbg31tNPJrG0dSPIvYFJDru8
        zDEo8PN+jpIXXhYapSy1609oeiTZngS1FrOEsHMcoeYHzgy/trXLLW4PVOBsAeZ6
        YJpbPMG0o0T2aeNpLpW3BKdJhceQvoDPALo/mu3F4Q43xPjjNGoM6VLIcb6dluzX
        CeR1bA4lxewbqqATw10r14CyZxQdbKamJw7Vz2gqKs1k3rIibNrvyM5/ehWOU6/e
        3fMU7L+7wed0M9fBmfmx5DzBi1t1KbysBRZCVS0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=yMBJ76WhKgdMHhWky
        FbX2/uDoE2hlTHf5GOeRZgK5ic=; b=SOwhAgCxCC4rimN2ZATdd5QSzALrlsuo9
        NtVqIZZol/9MqWfbOhdiB7XG9g8SBBID18fuK3sQUs2BEivft6hXniZzpQVuJgOv
        4hIrVy8PACR3nD7Mic3ax9uq3Fqy+YjMTVzyEM56/QnQre3+tVufqTF3xHE8GOjH
        pCJMoN+4XhkR0HgHzhzBKjR7msum01K5cUfnp7JXSK7jDzeqkeCdjfyYTVdNrQVm
        RDbTLk2qfuG1/zme/j3Y6MVYt7f+MLZYTvq6n/zqZHhmt3kxANhZ9fMH3wr/gDdZ
        AZMSq8sV9avCm2oCaCeL1oTz/yr7GcrrvAVC1BnytetZIKWPvlnBQ==
X-ME-Sender: <xms:e4w7YkZixPhJK9cnbBLY6UEz_POOj41rYQcComgfX7wANj22_GQvsQ>
    <xme:e4w7YvbXZvDB3tzBZQSZy_M40vh7uGknlGVwHgdPzOJ17DEBfhkyRu_V7DU8YavTc
    mFF6YU2ldWICaG4Ujc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegjedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpeetlhhi
    shhtrghirhcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrf
    grthhtvghrnhepueffkeevheejledtueevieekleekjefhjeehudfhtdfgtdfgjeejkedv
    veejveeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:e4w7Yu9P-SOqS-nvVaB5e7JkgUVpuJb6Khzc6EoyNnpqbFS6NOfuqw>
    <xmx:e4w7YuouL4bxuT5fW-_ca_yWKpeOL7OenNy1MR9TZJ9niIxNvXD7Ag>
    <xmx:e4w7Yvr5OO7dEjnLG38hK5DSZTvGpZLCVwAZFxKdnvUACvms-6FWUQ>
    <xmx:fIw7Yi3edY9PpJ2LybwAOyDyjUcdR_PvKBuK9EcPI3Pl42F_J9_SHg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 53AC8AC0E98; Wed, 23 Mar 2022 17:09:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4911-g925b585eab-fm-20220323.003-g925b585e
Mime-Version: 1.0
Message-Id: <38779286-d176-4f2e-8908-d82bf8d60f07@www.fastmail.com>
In-Reply-To: <d6c61a10-e671-3543-5653-ceb3d9ed60cf@roeck-us.net>
References: <20220323115752.360409-1-alistair@alistair23.me>
 <d6c61a10-e671-3543-5653-ceb3d9ed60cf@roeck-us.net>
Date:   Thu, 24 Mar 2022 07:08:53 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Guenter Roeck" <linux@roeck-us.net>, shawnguo@kernel.org,
        linux-watchdog@vger.kernel.org, s.hauer@pengutronix.de,
        wim@linux-watchdog.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, festevam@gmail.com,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH v4] watchdog: imx2_wdg: Allow ping on suspend
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022, at 11:07 PM, Guenter Roeck wrote:
> On 3/23/22 04:57, Alistair Francis wrote:
> > The i.MX watchdog cannot be disabled by software once it has been
> > enabled. This means that it can't be stopped before suspend.
> > 
> > For systems that enter low power mode this is fine, as the watchdog will
> > be automatically stopped by hardware in low power mode. Not all i.MX
> > platforms support low power mode in the mainline kernel. For example the
> > i.MX7D does not enter low power mode and so will be rebooted 2 minutes
> > after entering sleep states.
> > 
> > This patch introduces a device tree property "fsl,ping-during-suspend"
> > that can be used to enable ping on suspend support for these systems.
> > 
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> What is the difference to earlier versions ?

Sorry, I should have included a changelog.

I just fixed the spelling of alow/allow in the title

Alistair

> 
> Guenter
> 
