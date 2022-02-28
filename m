Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF044C677F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiB1Kt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiB1Ktj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:49:39 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3B15D1B5;
        Mon, 28 Feb 2022 02:48:59 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4376458027D;
        Mon, 28 Feb 2022 05:48:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Feb 2022 05:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=1vVga+h9htbpuVX4XD8VlM10uiiq7ZO3+UmFQE
        c01vQ=; b=G+ZJOtIyw2/WazvvDKJTEgXHqoMoF3VJv2oKOGq4HDeWkTpOd8WBaT
        4rHcpBbDc+9Q40E3VRnQZVyZ/TnAHgiMv+n0jHOCoqgKJb3y5c2rfx6jE89SIb6V
        wuJl+VrQBakHz1bRaiUzukCY3YwHyArUCT2bEJjwBw4fBaNLxo87f39svsg6rW4M
        FrMUpwRPrVgJt2SgGfjXyh4rTUGiwuracGqh9pypGThpKvggMHATxHjho+kSf+Pw
        heMa0F3/JUt9L4e2D7WaaUrptrbQLO8XFLDibfMwypC1vdK9qeVxb0NoqswZmsY8
        Z8Mrhat28uTSDyacKEGujZRc9zr/khHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1vVga+h9htbpuVX4X
        D8VlM10uiiq7ZO3+UmFQEc01vQ=; b=Nh+yscHoWuHDO/JIgKuLzs9zoLl0tZ1mY
        ytVar5473XvqOezOvfLch4dZ8miNo2Z2FCrbhGra/iXZZdTGj82hJZ68h7V5YRmO
        qktlxsL8Cx7Lvz3+2nygzNzE9AHjwGj87qTX5C+amkmj2In5kCJolrxtOIDvYkTY
        Tbue0a8O+ceonP7NqFL1vPkI3KRKftK+bVsX/cJM7Lr7z8vJZIBiSrvH46HxZ7Ra
        lJGmWt7sv13cPZClOiB/gFeqAjLI33HUDPddiy2dFm1uZyNwtg3B/aQgCLLlC4PB
        A1DMifsXZpaLTCmKf/PeqVXgw6O28YXpIKL45K2B4I2vA+2RFg9IA==
X-ME-Sender: <xms:m6gcYpgoaOlXM9gadUBqEGIAviqtLOe-Nbf7EFYWzlYEpnLZERGT7A>
    <xme:m6gcYuD053lZfrxnnUQtlFblUFSPo_WOMfaqeXe9XLBvJjrhtJz_Lx2q8W_-Pv2RD
    uGpitA8Be-iJw>
X-ME-Received: <xmr:m6gcYpHbpEOohqqrGSPr4j0Eli8Xd9nAJL7TGNVlr2KLUHVHL91HzCLHWwCMO9LUARfDg-L3EYLU869VfSBzFb25Y3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddttddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:m6gcYuQuBVdHYfmN6Kvl3QfdijgiNSdtGgbI1hwtxnedBylDivM-Pw>
    <xmx:m6gcYmyTyePgk8ZBswPOe7HUw3YRsapruwGegxM362ndjbrUM4N_ZQ>
    <xmx:m6gcYk5pvScL-ey9GzG6KyC7NFnr5xGHbFmsISqoiWWB8gRNSWUiqg>
    <xmx:m6gcYrrYq0YcPQnLfgZ3tW_Y0OF1eHNO5snpJM6jCnDUonnH4CWn_Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Feb 2022 05:48:58 -0500 (EST)
Date:   Mon, 28 Feb 2022 11:48:56 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the spi tree
Message-ID: <YhyomKViVd3iPYDE@kroah.com>
References: <20220228191316.411f1475@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228191316.411f1475@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 07:13:16PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")
> 
> from the spi tree and commits:
> 
>   b48b9f6deacf ("dt-bindings: serial: Add bindings doc for Sunplus SoC UART Driver")
>   9e8d5470325f ("serial: sunplus-uart: Add Sunplus SoC UART Driver")
> 
> from the tty tree.
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
> index e6b3e94de842,4a30001f6d7b..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -18635,13 -18549,12 +18642,19 @@@ S:	Maintaine
>   F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
>   F:	drivers/rtc/rtc-sunplus.c
>   
>  +SUNPLUS SPI CONTROLLER INTERFACE DRIVER
>  +M:	Li-hao Kuo <lhjeff911@gmail.com>
>  +L:	linux-spi@vger.kernel.org
>  +S:	Maintained
>  +F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
>  +F:	drivers/spi/spi-sunplus-sp7021.c
>  +
> + SUNPLUS UART DRIVER
> + M:	Hammer Hsieh <hammerh0314@gmail.com>
> + S:	Maintained
> + F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> + F:	drivers/tty/serial/sunplus-uart.c
> + 
>   SUPERH
>   M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>   M:	Rich Felker <dalias@libc.org>

Looks correct, thanks!

greg k-h
