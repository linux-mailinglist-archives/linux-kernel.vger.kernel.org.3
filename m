Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED34D9568
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345487AbiCOHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345441AbiCOHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:36:35 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EFC4B402;
        Tue, 15 Mar 2022 00:35:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id CBAD52B0027A;
        Tue, 15 Mar 2022 03:35:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 15 Mar 2022 03:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=ubawkBmLuFdDoYfaoCVnBwQxX9PkjVdJcQJYxT
        fyHSE=; b=IzRypaCoM503hRgXKoW3c3+hh4jRyteFLwmytI/WWvEUKb5TDxg8/u
        c6pNGNghxf4rHrUIT/WVJ7G2SS65QZiUlRMsZHCLkmpHVVlPDBBqaMYcH5nDR/ed
        dt3/8gRGMRBBcl7c4F6ygCEl1JYNqaHQJ+DKV/lgC0w+LOka7umiCqaR3wpCYbrN
        lZKauj2K/sS57pqIh1nZE1oAY9oH+RkNQ4xwgQieLvtY5IVTkhXLbnqyWkKngixa
        TftmC7dvPMKh4NZ1/wxtasMhPajU5lP4zKf+CIB3ldpkse9nLVWx97BQo+081pp7
        T3aKGErLjxHAfToXZU/aLv83qPa3eLlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ubawkBmLuFdDoYfao
        CVnBwQxX9PkjVdJcQJYxTfyHSE=; b=RS0qvdrurxYbY6h/yVR2AK8xFlx+lz9NP
        ZcVAFg9prtLTlVHm6qVK5ihYH6zy3thS3KJtFPPBCz0JCmhRDMKXujyBq5iL0iSX
        5NWiaQWdAr1ihDB1ehlR9J1SzLxJtXYWr1sOGzrOQ/Up09zvxIIoYRYaBq/iH2Ej
        mp3SzbMoxZCv6CARjhnC2WCkBjk1CtdZs+A58sISKLEITNUYBoBt89JnL68bUoIf
        xnPs8CTqw2aNGhU67Wdu3NEp37ui+3iQxTipSd5rx8uvdWTB71aShx8FKAS9IVlu
        8VRvvzqGL/ASYtaLXzvN38P6zdgW0flGasDayns1pa/lfUPpJ/vtw==
X-ME-Sender: <xms:t0EwYrmF21PFJ69czIjiuVo8R5RCEtKNCe3rZ9fjEWYzs8kYvNoNrg>
    <xme:t0EwYu1BHuuyE_zNQrqoJT90iCyDRpLmYM10cBadQIbuFO-OGza802zGpiRRECVu7
    yhXvSMB_BN5vA>
X-ME-Received: <xmr:t0EwYhpY-Y5zVBa_TlsdzdvhwGucQYgNu93iSUkMYSa52dQSeDTyF-j8_8B_NfvVlyKMiniL3klqJmWRGMiJWloTkTdXSxCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:t0EwYjlLLe40TYm8DfZHc68n5Og1Kffy7hKxGcLNIbcuKJ7j3IuuiQ>
    <xmx:t0EwYp0Brh2zom38aJb1BRWAIRazssP5G9cL-w8hK7o0ep13NsbkOw>
    <xmx:t0EwYitaLBwn5Jl1K1aFMVWcXFVOmH6H-daGbaSD3_JDc63jZszfZQ>
    <xmx:uEEwYguBRNIhicgPWNJzUy07z6mhMUpe80v1GDngkS-d7kpZPWDvfCfnpWU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Mar 2022 03:35:18 -0400 (EDT)
Date:   Tue, 15 Mar 2022 08:35:08 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>, Vinod Koul <vkoul@kernel.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the arm-soc
 tree
Message-ID: <YjBBrIlZkn7dGm9y@kroah.com>
References: <20220315165133.5b720984@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315165133.5b720984@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:51:33PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
> 
> between commit:
> 
>   c04421c68fd4 ("dt-bindings: phy: qcom,usb-hs-phy: add MSM8226 compatible")
> 
> from the arm-soc tree and commit:
> 
>   e7393b60a14f ("dt-bindings: phy: convert Qualcomm USB HS phy to yaml")
> 
> from the char-misc tree.
> 
> I fixed it up (I removed the file and added the following patch) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 15 Mar 2022 16:48:51 +1100
> Subject: [PATCH] fixup for "dt-bindings: phy: convert Qualcomm USB HS phy to yaml"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> index a60386bd19b2..e23e5590eaa3 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> @@ -38,6 +38,7 @@ properties:
>      items:
>        - enum:
>            - qcom,usb-hs-phy-apq8064
> +          - qcom,usb-hs-phy-msm8226
>            - qcom,usb-hs-phy-msm8916
>            - qcom,usb-hs-phy-msm8974
>        - const: qcom,usb-hs-phy
> -- 
> 2.34.1
> 
> -- 
> Cheers,
> Stephen Rothwell



Looks good, thanks!
