Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EE64BF2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiBVHpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiBVHpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:45:06 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC26135481;
        Mon, 21 Feb 2022 23:44:40 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A57915801FC;
        Tue, 22 Feb 2022 02:44:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 22 Feb 2022 02:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=WvrsQIm859hrAtjh+vD0sEGLBd9repiWMpdfcn
        Z3fdY=; b=AY5IzTLrQf0fZcgzx+mCmeD8ZhmcMfR249XQ27Ecam+W5+zEB8XNsi
        YnvL3mx0iBJbFDmHG699gmnO0zTiiIfP1hf3N9y8AJssCO3Vepx/oVQH653ddtyr
        lvbRN4xAtMTueJX1rpaAexXzP/jdwTAKQr8y3xyg/BWCQ610kLFK5sd9tzNOFuJv
        N+HqI4ISMVdjRWb4G/gDIrgC3gwG+DtdnNsLQnYfT7XD8kZK8K1NaFMKbPsYrCSL
        HZOYlYu7t/AdEcMoRK5tTKAnldncg/FHE1KVfUrdoXaM52RAbffXd4P6NrZ14/Hx
        UZwQRqc2QdSuufuvENEt16EB3eeClQlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WvrsQIm859hrAtjh+
        vD0sEGLBd9repiWMpdfcnZ3fdY=; b=QIo4pu+SgSMbqBhHHSLsg7xlZM0PgOOJg
        Hiq4KanJ9LmK5oVuobsKfISPKuGY/1CkdIeReQ65l7HPc7XBkYFhylxqbpXfU+zz
        RfC1NYyYuxoiypSsZfT4XbEcP8O4VJMlsyxv8VeRJzO5OpUahjMYfQWt3EQxLOTk
        wPfy/U94IKAro0QNrcxLhQhXBTEzcOD4dyWFnkZc5ryGHhI8cVesmCxhtIX0Ju+k
        LmI0T5iruOrllnYj4qRzfrvmy/OcH27RvPcUslvPno8coes5kA0oDekmHOWmvUaL
        fBTsm0Kn/ya1aFAY07K1qoSQUldq2FKdeNrFDgJOMdFyJmdOiZlkA==
X-ME-Sender: <xms:ZpQUYkfIJlJU6S7_770EaQRGi6kNlq9SsawPlp3nqEce3z9J73n2gQ>
    <xme:ZpQUYmMs3U0Hl57g2Is2QW8WmjZk1lRMHr3oPnfTHjA_qJldKKPwNe_YkJMQveta8
    X6wv4JU0KJ3bw>
X-ME-Received: <xmr:ZpQUYlgwsZkuZ8mx3gViQ7ZvYKDD7M-L4YGNEyDHlYysyGvwv95s6Qi9FZasBRK7IRbMfNScQ6UfxAGn8_QPbYdCsESSmp8C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeejgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:ZpQUYp8R5MePBtK7FsNqU41nSkCf19pclzJIU6TUO049nNaVXbEiWQ>
    <xmx:ZpQUYgsfyGBZvB0MBIgof-ZpBx55X9sCNEG-9jlcypiI5gyHLnzSzQ>
    <xmx:ZpQUYgG2I6pUodxCXebsmXmfJfO3Qnggc7Hgx-Ey73UGYH7C5eC5nA>
    <xmx:Z5QUYhmKcOSYPxCuXnE1RpQWd3PrXZ7zXmTrbVyaPfXNT595quymRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 02:44:38 -0500 (EST)
Date:   Tue, 22 Feb 2022 08:44:36 +0100
From:   Greg KH <greg@kroah.com>
To:     broonie@kernel.org
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: Re: linux-next: manual merge of the usb tree with the qcom tree
Message-ID: <YhSUZGqjtzV32tDV@kroah.com>
References: <20220221191641.1661387-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221191641.1661387-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 07:16:41PM +0000, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi
> 
> between commit:
> 
>   d1c10ab1494f0 ("arm64: dts: qcom: ipq6018: fix usb reference period")
> 
> from the qcom tree and commit:
> 
>   5726079cd4860 ("arm64: dts: ipq6018: Use reference clock to set dwc3 period")
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
> 
> (deleted the property updated by the qcom patch)

Deleted files are good :)
