Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9F4B07D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiBJILD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:11:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiBJIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:10:58 -0500
X-Greylist: delayed 534 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 00:10:59 PST
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC723108D;
        Thu, 10 Feb 2022 00:10:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id CB91958014D;
        Thu, 10 Feb 2022 03:02:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 10 Feb 2022 03:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=wZgdoN3qVkzQTVuivbiZ1IEaB82Lu0qyPYhhG9
        ODyp4=; b=Itcxq9NQ3p5sndAgAZqmMkDruIFfizrYPEI0yuB3bL7HbjHe/M3c2m
        BOTtfLi40QvZ+kOV9IRbA+0NGcca4cqSlytudsuSVK6D4ag//J/23xGVSiqMbrPT
        mfaFKUFCF/C+HPwnhFXYlkpS+9xX5hyI2DLI8o2SicMDdfaA6vN40opctzD53hsM
        rN7W/YRKC5528c0+sB9P9iUK+5aGoZ7zllP6PsDgov/BLZ4Tw0Im9nKYje2AIIgG
        Eu+1dxf4rk+tgpB5eXInlOtY4YArYmmot39sS67aH/u1ZiSvFWrELYt0qyp7Jyl7
        e7uUbE10Z1l7EzRR5iagx4DwdCf3iedw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wZgdoN3qVkzQTVuiv
        biZ1IEaB82Lu0qyPYhhG9ODyp4=; b=S13AuPUAZIB97OC79mHV8m/iMoZm2CtGm
        Ll8IeDhfWVa/XZD5c1QFuY2VxtYPkttyCByc0j7rs5JCySWmSCtGybuKJUEr9ABf
        K7VOV4XKZCkQOFRMUJusCWBN7KdXPsVYZlMDgK2VKMt0lV5If1xYvTK7ypzgzdRg
        H9XdyTh4E9BHdmOKhs5HfS2rGeyqvPc0HoI3lBrX/jBT/4AW89Vc91fJfFisnPZc
        D7NGQRg8oWS0ye9bowxJBaxNah6q9W8aZVv2oKQLnTzOJbdS8SfFJHOJi88/gTIB
        yIGCBFx2I6voeVtrj78ztSzOZsfn/KvV0pG4KrO+CpxPw9u7cAalA==
X-ME-Sender: <xms:jMYEYmHA33qtyrCMh-UGoMynEPUtMpLoqIed6rdvDOItmKtLMvGIWQ>
    <xme:jMYEYnUrfhdoX7ek4TIZi9dSvPfHbJRtouJF3Q6iGy0xX2mXusDMhtmMZAzf8dAwh
    iWkKLa66lxC1A>
X-ME-Received: <xmr:jMYEYgL3_9jPqBflCA78dKqVEOiOvAYY95Mulw3EAS8cNtVdnMcpaGgN7uxxhfED07m3Ily57L2BzvFhFgPb1Ti5A5PcU4Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedtgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:jcYEYgFkoxOLicfM_5hhgnAAaBSElrEecYugB2Uefiy2MTVr7xRECg>
    <xmx:jcYEYsU-mnNiUugt7jJW-988VeNLcdjpqKAKhX_jdP5Gx-mMtkwS_Q>
    <xmx:jcYEYjNUlAFOw7ZJRiKzfuJymwmetvIx9rTsDLhggPv0gRSkhQEwUQ>
    <xmx:jcYEYtsGCTx2NcKrTLRQCAeEnrhtB97q0HCSmise3FwRLw85L796Tg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Feb 2022 03:02:20 -0500 (EST)
Date:   Thu, 10 Feb 2022 09:02:18 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: Re: linux-next: manual merge of the usb tree with the qcom tree
Message-ID: <YgTGihSrtlRR3DPC@kroah.com>
References: <20220210141100.715b13e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210141100.715b13e9@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:11:00PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi
> 
> between commit:
> 
>   d1c10ab1494f ("arm64: dts: qcom: ipq6018: fix usb reference period")
> 
> from the qcom tree and commit:
> 
>   5726079cd486 ("arm64: dts: ipq6018: Use reference clock to set dwc3 period")
> 
> from the usb tree.
> 
> I fixed it up (I just use the latter) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell


That is fine, thanks.

greg k-h
