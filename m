Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032DB4C6880
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiB1Kym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiB1Kxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:53:35 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B658B6662D;
        Mon, 28 Feb 2022 02:51:43 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1F6FD580272;
        Mon, 28 Feb 2022 05:51:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Feb 2022 05:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=CVV/FYiagZabkUSFBdzimqho0tyD8t54QWCRsx
        SiA/4=; b=BpGnFStaHo1d/eOGvhZtY0UB7XWUsy4MUYujb2tbTC2HAaGLaEXjTX
        M6HnisywIXRsg4+/biO8DDKcrghJl5ttdrtYUUbDoLgrkBIOVXYamEGnbsDopWsI
        RzXqwyZPQZMzHoePbFikdsa83SF5QYweWJItA0TWGwc+6r4NYicdq5FH+MJPxEkB
        djqI+9HGbRkBjEXbEET+VR7DntOPVJaxTeEPe472wWDR2GVURsL9IPRt5r1NEsQ0
        HZguG4oREsF6xtZPif8rOiON0FWspctgD/p9D5BBSxrMFTNe1md4+8TQndj9vKxC
        lxlcj0ch7cQ9cfYpbQXMEBT0AwXuiOig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CVV/FYiagZabkUSFB
        dzimqho0tyD8t54QWCRsxSiA/4=; b=PgSWRXuhoUJJH5NYUqfD/XCDRX5uHR20J
        /ni7MR7GGw0DODiPJHILHXPxmh74GFzfRpU4ZicZYiofEeBU/xebXwJVvAcSRiZn
        mKvXj0v8skxoCEX4XKgbeckpyDV0YIKDATNpEvKMHFvf4Y0qdvlkHuyqR5y6SFET
        TwPQE/KhuTi9/GP3jUfLXBx8dkenXi0DS7oEYbuWMA1T6AdNgp3VJSvTd/sYnKXG
        69mrCtSZRH2YR5pfV60elRUjA+QTfpk4KuKxBqdExutlC2isNbHbcZ6w5r13TM1y
        fMf+iaIIDPMUdnZrNq5XZZBQhB4/HbuAxlf2QnLGJmXqjSR5DJ+7A==
X-ME-Sender: <xms:PqkcYnI33Jx1Elr4ziWVwCa3i9NR2MA6RP9RX4XTGGc-UQYk15TjMg>
    <xme:PqkcYrIjouSQyy14A8nQSo4GRD42Qeb81BKqYR1xeUfTg5q55JSpkrHyNAVO2Oarv
    Ta4RaEj7qoxVQ>
X-ME-Received: <xmr:PqkcYvt2k0At9bmwAsf0MgTEWbfiR2bsPzUvHzvMqQ-auAzZFlRW64BfPzxxkuAunAwIhOQYhO6mqJ-2QqmAjxBr9K0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddttddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:PqkcYgaX9pkmjFFiWEIxoi4ovItnC5xm1taQOhDuhZ6Exat6pN_O7g>
    <xmx:PqkcYuZ1ecM1dDINYS9SBKCTSVhQZuKdoSoDHb7goVoVifK2ohL2fg>
    <xmx:PqkcYkBzkv-6_kfKJGPJ_Lh_8mdwodoMd89NGIkZxl13iizu9bBltA>
    <xmx:P6kcYuKj9_VkEsCJXsTn1jsuxPksSaqWehaiExcIZZSvUgGHhThJjA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Feb 2022 05:51:42 -0500 (EST)
Date:   Mon, 28 Feb 2022 11:51:40 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the spi and
 tty trees
Message-ID: <YhypPL9HsxTKOJyA@kroah.com>
References: <20220228193630.2e079d89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228193630.2e079d89@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 07:36:30PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commits:
> 
>   f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")
>   b48b9f6deacf ("dt-bindings: serial: Add bindings doc for Sunplus SoC UART Driver")
>   9e8d5470325f ("serial: sunplus-uart: Add Sunplus SoC UART Driver")
> 
> from the spi and tty trees and commits:
> 
>   9e8d5470325f ("serial: sunplus-uart: Add Sunplus SoC UART Driver")
>   8fb29b450182 ("dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver")
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc MAINTAINERS
> index d1e56ec04e14,37ea1436fc62..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -18642,19 -18578,12 +18678,25 @@@ S:	Maintaine
>   F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
>   F:	drivers/rtc/rtc-sunplus.c
>   
> + SUNPLUS OCOTP DRIVER
> + M:	Vincent Shih <vincent.sunplus@gmail.com>
> + S:	Maintained
> + F:	Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
> + F:	drivers/nvmem/sunplus-ocotp.c
> + 
>  +SUNPLUS SPI CONTROLLER INTERFACE DRIVER
>  +M:	Li-hao Kuo <lhjeff911@gmail.com>
>  +L:	linux-spi@vger.kernel.org
>  +S:	Maintained
>  +F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
>  +F:	drivers/spi/spi-sunplus-sp7021.c
>  +
>  +SUNPLUS UART DRIVER
>  +M:	Hammer Hsieh <hammerh0314@gmail.com>
>  +S:	Maintained
>  +F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
>  +F:	drivers/tty/serial/sunplus-uart.c
>  +
>   SUPERH
>   M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>   M:	Rich Felker <dalias@libc.org>

Fix looks good, thanks.

greg k-h
