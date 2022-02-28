Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29D54C6744
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiB1Kqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiB1Kqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:46:52 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8D657B3E;
        Mon, 28 Feb 2022 02:46:13 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 95D2358025B;
        Mon, 28 Feb 2022 05:46:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 28 Feb 2022 05:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=feVj5PTVg+Alvboej1oYXFjSRH9S+YW1b1Xb8Q
        QaQPc=; b=bGJWYiJv7fV9kVLNaDdOg1JT9KrAiyOBxvzIfjNWGrjV6P8pGmyE8m
        ZjVmWnmhkZVJ2HL06VIDY7V+b4AoD82hSYUZ9Aw4AM3tECWCNl8fxeqEjHWBEIq0
        EY8Th4aGQzuDesHVw/XBA0k1qZCxu0WRwYqjzvwtwOJwBeFzDwjM68iGybNyZFmr
        kR0BREZFG/9qBY++9iszRhCPZBATvxEzC050vbSHEkOvGYd8kN9ubYkgjIb2XFGw
        xOO5SNrxdRjX5kX2+gLzttkQez1KhsmcoaJCJBi0qNuj4uQs10DflbO0Cefbhg/j
        g9BOmKa2Fc3rGZ9SKN5OAPFV5sH6kwxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=feVj5PTVg+Alvboej
        1oYXFjSRH9S+YW1b1Xb8QQaQPc=; b=c7KElXrnqnPUfuHZk64XXpktPPkEGrC0/
        6f2+7c6K23R/v+b6FukYLKm4OoNrJGJd/l0+vPw4+Kf1qLsJDzNjqbp/F4/7amgs
        T3/WbLT1GrMHSM1ubtg5ESJ46BBIUOKZ+zWPYwfKqRNJQbBCbousNS9951X7zEf/
        sFKylsL9zAi03YS/yvwWx7addRQHQgSd6j2chRSFh3R+9m9rJLY+JFXAi4LrjgkQ
        AESGGwkIPmkgIKqOcEBINN9H7HAEKA0l7g59+YcNg2ga4E5+BhXL4qwBTKzfpZYD
        3ZrNFrNCFD7qC/pfnIa4dgqe6Mux1/b4Z3C8eHHYfGN977ig9A8Mg==
X-ME-Sender: <xms:8qccYojSGPhpsK-uM6EwszLoreUFXPcq5d6UwazAjBh7HaGhtk9dLw>
    <xme:8qccYhDwDT0WYOQfYq_D9GW06i23hvAhhembdcy6_CX08giWX5o6KPV9yVqdJMRdW
    38-LIdpcokwKA>
X-ME-Received: <xmr:8qccYgHvvarNLMkQW6BM7SQ3Cx3vEYEE_3cQ8wr1Yit28injU3EIcsBIJVdS1Y3mgHEj3jqXWOl-40sS0EeBZoLTMIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddttddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:8qccYpQVac_7ndlD2z8vYgSpat-_-b1Vd-jI_SEamHOkSSEDN2ogiw>
    <xmx:8qccYlzs1DGNM0vIh1LoQ2QUWY-KGruqbP2UETrPjXm7U-ZRkShs3Q>
    <xmx:8qccYn7nubE893oGmogyrLq7VjC21ZgUKf6EQHB7NfslrkKUBJ5Y9Q>
    <xmx:8qccYoo5Rg5fKLbhFn6t9BhA23mX_8PaTeXJjifWgmiYSG6y5Y4hDQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Feb 2022 05:46:09 -0500 (EST)
Date:   Mon, 28 Feb 2022 11:46:07 +0100
From:   Greg KH <greg@kroah.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <Yhyn72NO/roH1gA8@kroah.com>
References: <20220228193928.3ec6ee98@canb.auug.org.au>
 <YhyPfcjJtIKNQtF8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhyPfcjJtIKNQtF8@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 09:01:49AM +0000, Lee Jones wrote:
> On Mon, 28 Feb 2022, Stephen Rothwell wrote:
> 
> > Hi all,
> > 
> > Today's linux-next merge of the char-misc tree got a conflict in:
> 
> I did ask for this *not* to be merged when it was in -testing.

Sorry, I missed that, I saw your ack on the patch so that's why I took
it.

> I'll follow-up with Greg.

Should I revert this from my tree?

thanks,

greg k-h
