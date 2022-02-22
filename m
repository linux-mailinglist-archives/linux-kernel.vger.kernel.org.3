Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748AD4BF2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiBVHpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiBVHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:45:04 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1B2133966;
        Mon, 21 Feb 2022 23:44:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 636185C0154;
        Tue, 22 Feb 2022 02:44:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 22 Feb 2022 02:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=yfRp+YUFI/2FMxEFyLbvDWA7xuEPRQXxUvM5Ey
        G2eSw=; b=eCj08t+VA37FE46gUvOLnZwouqcohh6wP21mmjBrD1zQTZBRL3Mvlo
        RRbsQmsMpi6qOVCvDSZoC55QILNLiGWNluAZLUeEylTcNz8npVsklxO+L5BCx884
        Ru3ATtKuIaAgT+AZ1Ib2wnIieXtqFY1ZxBYrp+7SmVR2Zw5mxl+2Sg3GS6S1Fd47
        ej8/WeIOEFcvw3O+Q9nCbJpqEU+cu3Vdt9dZtx9Bxrx1kn19iaZrYcu2LMoUnPBG
        3bmTvGR6mftjxcRUbcqkEcSm14WZaE0oN2Dm9mQZkSm16YShQDo39bkX/9Hr8ZM6
        E2FifGUMsEv6QB53LnI/rWhq6GCJZsEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yfRp+YUFI/2FMxEFy
        LbvDWA7xuEPRQXxUvM5EyG2eSw=; b=B3UFwwF1JJKl1U+UQUqzteo7azATfEOwH
        nX+ec47d0VaH/fGr6IvaozijawxsJeE9Z3GKKSbcC6YaEExX7J8I/lTqHp5rxGmd
        EyRmm3EHCdNkEzhNUVGrtQGLPQc6i/y286hCQapMnMB1HZUKmOhRKNRmiocG7g+B
        yZT52ANhuvvrDOuARDUwSDE0j2BdNrydU7g8O1Ja4n+bIqV1wc2UFcHPUwMeeSHV
        88OjdAuNcTNVakMkDfXi0Ve8ObtoU9YomzheJgX5PbOAdfM+eN4GULlotQT6a0Zc
        G3A5g2Bc2Hjf2GWne0ZL6ZhjXsNrbsMwmyo2yEc5Ao4OFCzHLNSkA==
X-ME-Sender: <xms:WZQUYplkFnjm8d2n-TmJ1hl81z3rW7HHZyqtopj3HdZpAsEjifQX4w>
    <xme:WZQUYk1n7PK1TYKf9CQ91aqC5xrAgc3iIGLV4BhN-G8no-A0m6FDGwEhYavSYaYi4
    gqugZw1lY2v7w>
X-ME-Received: <xmr:WZQUYvqB08vSfg3ZlfhGyHq1Mz_P6LX264nydNkQjltPL397K4UBsqPIF8-2db-5CNKzhZJnKTSMYDz1K1BPb4gMqyXHAJ48>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeejgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:WZQUYplfMLMMDUMhUv1glyF_TByhiPdMsI50ofGhByaA7VOgzPO_iw>
    <xmx:WZQUYn3uy8z7NB6meP4GMnVwW-BMituosVoQMMBGT0i5Brogb4MjCw>
    <xmx:WZQUYot1Oy2CmE7vBtywTl5BVJvgN5CSqRQwbrnlh4Nos2CZYUr9Xg>
    <xmx:WZQUYhoiOkvsEc4dt7u1NTrocvrGVqEgQaw9w8olCG4Mzr31NZDjNg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 02:44:24 -0500 (EST)
Date:   Tue, 22 Feb 2022 08:44:22 +0100
From:   Greg KH <greg@kroah.com>
To:     broonie@kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <YhSUVkm/lIm1x3ks@kroah.com>
References: <20220221203917.1899359-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221203917.1899359-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 08:39:17PM +0000, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/dwc3/dwc3-pci.c
> 
> between commit:
> 
>   d7c93a903f33f ("usb: dwc3: pci: Add "snps,dis_u2_susphy_quirk" for Intel Bay Trail")
> 
> from the usb.current tree and commit:
> 
>   582ab24e096fd ("usb: dwc3: pci: Set "linux,phy_charger_detect" property on some Bay Trail boards")
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
> diff --cc arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 4e7efa97724bd,a614b9f73e2cd..0000000000000
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> diff --cc drivers/usb/dwc3/dwc3-pci.c
> index 06d0e88ec8af9,4330c974b31ba..0000000000000
> --- a/drivers/usb/dwc3/dwc3-pci.c
> +++ b/drivers/usb/dwc3/dwc3-pci.c
> @@@ -120,13 -119,14 +120,21 @@@ static const struct property_entry dwc3
>   	{}
>   };
>   
>  +static const struct property_entry dwc3_pci_intel_byt_properties[] = {
>  +	PROPERTY_ENTRY_STRING("dr_mode", "peripheral"),
>  +	PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
>  +	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
>  +	{}
>  +};
>  +
> + static const struct property_entry dwc3_pci_intel_phy_charger_detect_properties[] = {
> + 	PROPERTY_ENTRY_STRING("dr_mode", "peripheral"),
> + 	PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
> + 	PROPERTY_ENTRY_BOOL("linux,phy_charger_detect"),
> + 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
> + 	{}
> + };
> + 
>   static const struct property_entry dwc3_pci_mrfld_properties[] = {
>   	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
>   	PROPERTY_ENTRY_STRING("linux,extcon-name", "mrfld_bcove_pwrsrc"),
> @@@ -169,10 -169,10 +177,14 @@@ static const struct software_node dwc3_
>   	.properties = dwc3_pci_intel_properties,
>   };
>   
>  +static const struct software_node dwc3_pci_intel_byt_swnode = {
>  +	.properties = dwc3_pci_intel_byt_properties,
>  +};
>  +
> + static const struct software_node dwc3_pci_intel_phy_charger_detect_swnode = {
> + 	.properties = dwc3_pci_intel_phy_charger_detect_properties,
> + };
> + 
>   static const struct software_node dwc3_pci_intel_mrfld_swnode = {
>   	.properties = dwc3_pci_mrfld_properties,
>   };

Looks good, thanks!

greg k-h
