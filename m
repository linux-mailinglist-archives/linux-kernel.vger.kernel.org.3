Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE974B07D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiBJILA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:11:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbiBJIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:10:58 -0500
X-Greylist: delayed 534 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 00:11:00 PST
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC63D275;
        Thu, 10 Feb 2022 00:10:59 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id AF52F580150;
        Thu, 10 Feb 2022 03:02:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 10 Feb 2022 03:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=PnpDbCRZGPp5ifSTERgTXRQM9Rv/E2SdB0qFWY
        wi/Og=; b=lEWBuaBgH31hd8rrTx0Bn0MN0c4ro+u0VouYcY/OrlrSIQKI73aLqE
        Yrl/6w4fYlKVeGpwUlHdE9Y3GFYbd8Zoh2sH24nU62YDlRwyVOB61QiANaKn4qxS
        rvbC8wiNxjbzuZYkIrVA3xlIcwEc3EoyiJOi+4iy8x6B4ImXM967VLsvfVXpO4XH
        tj0iSGn1itCtyE+K55qaJdtjdR7128K5tcflVH3epTN6ktq6lMyAVqb2sGVWE94G
        B2HgmsIyyOpETtwV/brGfpE2XBdy2XhqC39x14IMphHDjyBBC7dXh2fizoRlAvb4
        yV436j0X1ILlE2hdkpEpS8vP0cZZBgUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PnpDbCRZGPp5ifSTE
        RgTXRQM9Rv/E2SdB0qFWYwi/Og=; b=i1WSoUtaNV7reSiJbZ1/TSFQMNbI31mCa
        YlP+ZE+iMxCt810dwPBtlzm/AtxhQb1WkqTfd00bjokbNa9vzrvQjs0xQd6ESG5Y
        2Mq6lyTCMrOnInsfoTRiXQHkAFlo1lbwnVGZPDeCbJg5C9XG/TKvzk5gN2dx8Bk5
        AcuB4kmevueR7OPaLXLtyvnKJn99gb+SrxqrHLe3Z66GVkxPT5gXGU45f6tnMhoe
        HvKAoPCPjf8AsJazcUAn3Okmii05ez39ZS7KkKLPNrqHjKVbNYDXd45PyFvdXRwb
        bm2fTDsG0+Vg/VLgGoQgGQwrDFtvkpx4xxlyk/QjP56oKbHrtZjgA==
X-ME-Sender: <xms:ecYEYpSXKXVPeqIVpKsfEKW2ulsThyPHfeNXCTkq5FVsJ3YQCjMQ2Q>
    <xme:ecYEYiyeSp3gEwD0NxwBuJ0vss3YXrw8ehVDarAWGn2BZs-hCw5gqUTDi1Nkwq1OM
    NMLNxD8DheOZg>
X-ME-Received: <xmr:ecYEYu040fLlnwX54F-jfP3YIroxfksS-m_XdBCKuuXemqXsJCk70KhbMgmQK0d7KgyfG9BpKfht4lvgkCyi7jmYHoybRzrh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedtgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:esYEYhCXmaFHaVRgFmqEt0HfR9eAJk0oDdXfeUgA4sLLVxttcfltKw>
    <xmx:esYEYih2ISucqOfIQ3EnDiHyCNg8W7mfMZg3tCT9F4swzWwopMJcqQ>
    <xmx:esYEYlrbLYvQq1RcaF8rYoBjto9csFa1Pk2NhlrnnX-oqhJAZ7hETg>
    <xmx:esYEYjY5FYVI15as4LdLkyW0-lViFRog4RNSzLQ1cgG9uyBBwlrJSw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Feb 2022 03:02:01 -0500 (EST)
Date:   Thu, 10 Feb 2022 09:01:59 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michal Simek <monstr@monstr.eu>, David Heidelberg <david@ixit.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: Re: linux-next: manual merge of the usb tree with the xilinx tree
Message-ID: <YgTGdwkTkDgx+pan@kroah.com>
References: <20220210141550.56359523@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210141550.56359523@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:15:50PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> 
> between commit:
> 
>   eceb6f8677d3 ("arm64: xilinx: dts: drop legacy property #stream-id-cells")
> 
> from the xilinx tree and commit:
> 
>   d8b1c3d0d700 ("arm64: dts: zynqmp: Move USB clocks to dwc3 node")
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
> diff --cc arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 056761c974fd,ba68fb8529ee..000000000000
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@@ -823,6 -824,8 +822,7 @@@
>   				interrupt-parent = <&gic>;
>   				interrupt-names = "dwc_usb3", "otg";
>   				interrupts = <0 65 4>, <0 69 4>;
> + 				clock-names = "bus_early", "ref";
>  -				#stream-id-cells = <1>;
>   				iommus = <&smmu 0x860>;
>   				snps,quirk-frame-length-adjustment = <0x20>;
>   				/* dma-coherent; */
> @@@ -849,6 -851,8 +848,7 @@@
>   				interrupt-parent = <&gic>;
>   				interrupt-names = "dwc_usb3", "otg";
>   				interrupts = <0 70 4>, <0 74 4>;
> + 				clock-names = "bus_early", "ref";
>  -				#stream-id-cells = <1>;
>   				iommus = <&smmu 0x861>;
>   				snps,quirk-frame-length-adjustment = <0x20>;
>   				/* dma-coherent; */
> -- 
> Cheers,
> Stephen Rothwell



Looks good, thanks!

greg k-h
