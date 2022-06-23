Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C455753A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiFWIU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiFWIU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:20:26 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA784831A;
        Thu, 23 Jun 2022 01:20:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A60B332005BC;
        Thu, 23 Jun 2022 04:20:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 23 Jun 2022 04:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655972422; x=1656058822; bh=0FnSDZexd3
        j+GVV1oAly9wToaT3q8Au41jX8R+iDFoY=; b=Udf/IBCz2MEH+8wwyVoFkoeCRD
        EOOCa9I8SuQ4GcS0DWAegV3G421E6Q08+qARjOZFVlyxL8cRetP8U56Aq/PzP+PP
        FQdvKbOzPDAJEldM5nXqQ86J8jc4g/Bw4HDCFRh6ZAk/9pV4rkt2MM4zyhvZPxJj
        kMI94lkYPToZ0rAOqa+ACmlV56hHFV0ItI0GYIASNmVgUtOBwVCfy2wXlI1892R6
        lYAtO7LmWIkCCLNeY9Kjc+KagYglMxtQr1DL0BHlHlJn6Pl1RkQWD1r52IkRSzKg
        lhA0C86JQWAg7O9FwebdG1M5Dwhb+A1GczzD3Ebtm4an8XmsTOR857YKovDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655972422; x=1656058822; bh=0FnSDZexd3j+GVV1oAly9wToaT3q
        8Au41jX8R+iDFoY=; b=uZB7MbEMkJRllbDcqzqF+ko1w5TFmavWFhIIgWikrOnF
        vzQwHqL4wJlT7nqnrA+o5vVuB8c2EzwEvxCW7eo5zznHdJ1f2OgxZWsaAJr6mGub
        jyskvUzMvuN6ZMd4/JAlWdr5RXNaH0bswwLlZopQ/jRo2zZET8CLxJBYIFCQ6dGB
        2jmZnrjFB8t5+vIku6h/NRhEtMGtuhDYxE3+jW/1LKK7mwTO3JNFIWuuHD3bNTt4
        mu7eN/IFcfOIiS3GpGImjiT35N62oMb3P53sMrwb2JpGsdJDkAHgMSFw4dL1tdOW
        UgZ8Kf2dSSjiMMValbxJUuzs8BgsvkIXirGGV9Cpaw==
X-ME-Sender: <xms:RSK0YnCK9oJHGF6-p9SKUXKptYtHjyHJdk51tEkM37oReyq2tk7VSQ>
    <xme:RSK0Ytitj0rwPvy6pfRluRXOTqosqAXW3E5453pIfIITu7w27OC8VmMI1izqMDvsG
    gKQiMFjtC7Myw>
X-ME-Received: <xmr:RSK0Yilt3V-oGJwW56WSVVgk1DeH2txHJcYhdZ1hJ0B560G8-cUV19kQfOrGPWVnsZLxvTvJEDhNCBv_vauSP8MWMTSAWYGq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefjedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:RSK0Ypy8CTZQ49TzOiSWiTOZe7cIzdRV8UQ1QQXwM3SzF9cDGK_YSw>
    <xmx:RSK0YsQ6rSWQfj0aD2c-TjtoyMzw8847xSuyD_QYeWCP8yNJtGg2Kw>
    <xmx:RSK0Ysa5JFMWYTFJEdKmZMHoqILGLZ4M25tjW8bD54okS-qpCuWT5w>
    <xmx:RiK0YvHxVSAyDMuPHEurnxS-0ktAaO74hqEh0i_0bPRGQmnQLUK1yA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jun 2022 04:20:21 -0400 (EDT)
Date:   Thu, 23 Jun 2022 10:20:17 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the spi tree
Message-ID: <YrQiQYRSEjRwj/2t@kroah.com>
References: <20220623134259.03af40f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623134259.03af40f6@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:42:59PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   f303c6b26ced ("MAINTAINERS: add spi to PolarFire SoC entry")
> 
> from the spi tree and commit:
> 
>   4a691b8c157a ("MAINTAINERS: add musb to PolarFire SoC entry")
> 
> from the usb tree.
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
> index fcaa66ea848b,e73c77d479bb..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -17225,7 -17169,7 +17232,8 @@@ S:	Supporte
>   F:	arch/riscv/boot/dts/microchip/
>   F:	drivers/mailbox/mailbox-mpfs.c
>   F:	drivers/soc/microchip/
>  +F:	drivers/spi/spi-microchip-core.c
> + F:	drivers/usb/musb/mpfs.c
>   F:	include/soc/microchip/mpfs.h
>   
>   RNBD BLOCK DRIVERS

Merge looks good, thanks!

greg k-h
