Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB857D869
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGVCQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiGVCPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:15:51 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1919B97A2E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:14:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D03033200A0F;
        Thu, 21 Jul 2022 22:14:53 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 21 Jul 2022 22:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658456093; x=1658542493; bh=H0tl7PYIst
        6EluLo0kFgVp0YPK66a1VCVK0YVnBYtdQ=; b=XMr/vzsqtjUhx4qJ6nIKZoOgwx
        Il101nyVf4Qawew0CVXD+BdBg004WJPtgMwIrK/iT6+dp35c30ma9CifwhqMqdc3
        G/D3kl8lONv4B28QYi/poVspfW7QqNRDHKLDYQNPM8nEHAbcUlrMYlIYpbZOLTnk
        sZRp6J9418yZYy7bOQ1c2ULYUBWE5IJDg/WMInq3JPfZefZ7+kMcGQCk/VXzyVNw
        YhansR1LXwbbZqAxXZkcToqpUv+3YP6mh099TfJS/LM9dajL/cPFqjXmQ0DBXJAj
        gR62K+7BloTkG+MeKNbXiM7NrAMnNIcKEn3JAqFQxDlRbafrMTAmg8KG/e6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658456093; x=1658542493; bh=H0tl7PYIst6EluLo0kFgVp0YPK66
        a1VCVK0YVnBYtdQ=; b=29tyYDOZyrky5oAbH/mdbhoNzxgmajpnmN4F2I1bsfZE
        bos/mYrXPSTtP3HD629aitLHz4HxnIHNsDU9T5dO2ta469bAOOqxcH5Y7UzStPjx
        wcK53Qy7Ter9VBb+PinjLGVqlRXfWIUJPnU8mBTrKyn7dhJkYhZvj7sRKGIqME8z
        PaGYEIuQN8EELkcFQcAqDPIw+KkgWlzZ7k8uqDI8J7jQEnk7/LdkCeWl6IaiDZws
        6O7oMILMhG8EcIGcjCtHIKpdn+d/xKMyQK0z8UUtwePKS4ailyQlVykqiRLDAByD
        mcRGcEvriesLdJHcAbOKDd2tHJJ/PmpTaJHytxRoww==
X-ME-Sender: <xms:GwjaYicYlejJwx799R_14Wvpol1rns_pOpQZ1xi3Ef7WX9TCnA_cyA>
    <xme:GwjaYsNuGFmGkRBraQ50Z5p_fj1M5PG3iGEN_nsjdmR8t3k3wO1UyZCFZGcoKSU8a
    TWUUpGH8KNFF5odWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:GwjaYjizDhAVIdpkkVpWfm54-tDyei5hQuTDjmaD1EP5C6Kq5-T1eg>
    <xmx:GwjaYv8Kyhf-GyJIiErN0oYjYV-9nzzxD_yzRpj41HLchsAZ8nV-wA>
    <xmx:GwjaYuuMPyiW2-Ohp796VPmZFuVD4UJNGyATHMr7HokYZvUKJvMTOQ>
    <xmx:HQjaYijVJHWT_PaZ2jlGAtYQIjoCb74kL9xJS2QOG1aXtbAaRnBzDw>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7007E1700082; Thu, 21 Jul 2022 22:14:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <0503175d-944d-4ffa-ba39-ff99797e78a1@www.fastmail.com>
In-Reply-To: <20220603123904.30714-1-linmq006@gmail.com>
References: <20220603123904.30714-1-linmq006@gmail.com>
Date:   Fri, 22 Jul 2022 11:44:31 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Miaoqian Lin" <linmq006@gmail.com>,
        "Joel Stanley" <joel@jms.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        "Patrick Venture" <venture@google.com>,
        "Robert Lippert" <roblip@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: aspeed: Fix IRQ check in aspeed_lpc_snoop_config_irq
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Jun 2022, at 22:09, Miaoqian Lin wrote:
> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
>
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
>
> Fix the check of return value to catch errors correctly.
>
> Fixes: 9f4f9ae81d0a ("drivers/misc: add Aspeed LPC snoop driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
