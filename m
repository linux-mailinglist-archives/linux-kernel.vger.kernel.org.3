Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F884AAC64
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 21:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377652AbiBEUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 15:15:08 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57447 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243682AbiBEUPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 15:15:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7BD35580138;
        Sat,  5 Feb 2022 15:15:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 05 Feb 2022 15:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=o+YT8dM65eINM7
        uU12V7S7CiGbJyTBQ0DTTXbszDH5A=; b=h54tOPJ+R6s9s6BX7rxDpJGJusl6Cn
        xOA9NZHxingpnUQxIPCuN2Q+1xUvkcfjI1oewBOseZnmGJWMBkKtFewJWWFVJT9G
        LM3Zs+0br5NdmhiLTbyy+h5fZDRR6zWwePRgWf7Vg7pGkGxqbS9W7uEzi40Ji1uh
        Hz7XwueelqGrLCVdqDaupJ62V7FpsSUDHrob0iFOKDNkgGpMZznJUL3z7zC3hheo
        NX3eWnUI7ZwIiDdjnH2Y3DHycxb2Tc7IlYZde2XfyZLBgP1jGhMSFAzSHBaiCuul
        NBgZNTWHJ7UPnSE3GEslBh7nNGhGav8o83IJOU6PikBr/jF29gts0ckw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=o+YT8dM65eINM7uU12V7S7CiGbJyTBQ0DTTXbszDH
        5A=; b=F6SKmv1B2f8Q6PEKJhn+l6Mmr4L3KXkfLRGDhxcfzEp8OaBquZH/z3lyV
        apkOd/Q8fCqwHvnxAksFDOdl0icttpS1MCJ5vnYAo8sIAHJZSiXE5bmrvRlcFD4U
        lTuA/BMkSnwBi1vYSrl178w2Lw6ddqctacgYcTAMrgvAdWgGKBwqrOkmrHMV208y
        4yCPPwuWAxQI9S9OX3rnFCo81f0wvfuyJSIxm1wvcYiIwW5QPFwKxxeeR72Bvqa5
        B5JgIvjO8+35rudcOHLc0KYroeGc0AXNjytBA9zG48XANQjAW3GwwTHg90kqfDzW
        Ig7l6HKJlFZIsyb/tj2ouHX3CzZUg==
X-ME-Sender: <xms:xdr-YRuEELIwf6C_80xflXTojQpWZPP3IgLorcryiRsKcCKGYZJ6PQ>
    <xme:xdr-YaedkiIpdSYlMu7C3msF6F0NlJE3n8aY0E1G4npN5ySFTZDKeuYfXXkja33T9
    KAWjFRT6Lb1Sb1VYg>
X-ME-Received: <xmr:xdr-YUyCZZHO9ZVZNHXwigPCP391GD2dt19Y8zU-Wg9mK55XwRjpA9QNA_qxhciZtRuu3Di6rVsekP4RUZNvZeazexkqXhTKhG2KR4i8LohvNeb1f14WUF5m_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrhedugddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffefvdfhhefhkeefteeiheeftdevuddvleeileegtedtfeejhfej
    kedtffdtjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:xdr-YYMuPGb3RKzPx2sCF7P1sx9DpQlivNqFahdzXwfCohVlFoYh2g>
    <xmx:xdr-YR9EcVCQoWMzpuGQJKWk1SWfUIwTsxiCcQzD1MMBxatkHu6azA>
    <xmx:xdr-YYV36DLjVoTDTvXq26BuxeBcAuJDtdKSApyC-z6cAuq_XBB-_A>
    <xmx:x9r-YYiSTR_JsUoQ0tmyE1mpu4vuyi0XqXo5g-70QG1FqRMHi6isXA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Feb 2022 15:15:00 -0500 (EST)
Subject: Re: [PATCH v2 02/66] dt-bindings: interconnect: sunxi: Add V3s mbus
 compatible
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-3-paul.kocialkowski@bootlin.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <5386b1f5-9e75-4ce3-6641-bd7667c85d42@sholland.org>
Date:   Sat, 5 Feb 2022 14:14:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220205185429.2278860-3-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/22 12:53 PM, Paul Kocialkowski wrote:
> Since the V3s uses the internal mbus, document its compatible.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> index 29c9961ee2d8..b67bf9261a6a 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> @@ -31,6 +31,7 @@ properties:
>        - allwinner,sun5i-a13-mbus
>        - allwinner,sun8i-h3-mbus
>        - allwinner,sun8i-r40-mbus
> +      - allwinner,sun8i-v3s-mbus

Please enable the expanded binding added in commit 245578ba9f03 ("dt-bindings:
arm: sunxi: Expand MBUS binding")[1] by adding the new compatible to the "if"
block lower in the file. That way we can add V3S devfreq support in the future
without changing that binding.

Regards,
Samuel

[1]: https://git.kernel.org/torvalds/c/245578ba9f03

>        - allwinner,sun50i-a64-mbus
>  
>    reg:
> 

