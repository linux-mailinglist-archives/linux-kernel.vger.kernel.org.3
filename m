Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3505645A4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 09:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiGCHrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 03:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGCHrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 03:47:14 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01046470;
        Sun,  3 Jul 2022 00:47:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 488705C00AB;
        Sun,  3 Jul 2022 03:47:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jul 2022 03:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656834433; x=
        1656920833; bh=q7xFVKw+pnU3N3bfvFQJh/csLKrqR85Ga+dbzzZjpME=; b=L
        lYykUMBxJdu+JS8YR7oH0sHFa0UkkjmrdKpqvxJkjC8WULkTkQQ6+br16PqK+NfU
        QyJttfgiFQKw2Ad6fWfdSk07FJMa7jYk8nbcy+PhehEK+CBuGdRbfJWyWudzPvXp
        +TsI+7md4313vilF2a8pzBdybpfikTRouhiX5sUcRwpHNvoIvP43UnuTBrRw+RgL
        SPayP4IqSDMBgDxrKr4UjM2iuTgPxU0/w5S031LCp7jf5m0F9FP7Kbxmdlaje6Tb
        KNsDrqI21mSdwa+Vz1MdmitwPnfMHv97pPHThn0xaqPYPgKevH0LYY6gGMPzwWZw
        IWowGICuVo+BZbksOkt8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656834433; x=
        1656920833; bh=q7xFVKw+pnU3N3bfvFQJh/csLKrqR85Ga+dbzzZjpME=; b=E
        DhJPakOO7QVrK1CUNeynJ8tJCCQkLlTngXzj0/yAVxJlFU4P7yKdtn5yCKLf879r
        sO+CqyVmWAI44xdiYd+3lm+zDTSK60TA0sKMxC+ydbT7J0aKG3wKC9z76gNyl1YD
        31SK/FDdcxS3C4BYLm8JKkXsQdyHXnyO+1rf0Xh4ywsJ3of0AyWJVLi3WOeznS3q
        jrWgNQKpZJqdyjxJSQUSy957lVYYAO5IVUtSc1r1ZBVBQeXL17iHoWX/HWp7tVdn
        kWAulaBvACr/trVBgZ3LsfqTeN14+Dp57JYEOh99GHjSgSK4DasXZkAu/3AdhX7K
        CZ+MLkEFKAUgqU5nbWWLg==
X-ME-Sender: <xms:gUnBYg_06Lyq13esrxJJPENR6z4b0eJ_JTZ8nZ-sgWuTUYhlPbfD2w>
    <xme:gUnBYouAPwI3m88LQ8Dxgj1xzUJpuyRJgAp15u7sZYpMWA0tVfkY0QgDAVHBBHjTx
    5DqAAoOcp51nbUVEA>
X-ME-Received: <xmr:gUnBYmD1CgROOraYXWO-NjLQsB7C6JQkY_O_mnAIkW7D5l9XZWfLfN7Dcq6h23h_1zIPe7ASkhPxXcIboGrNaq_hqJB7P7W62NnKvCjrHeNjuP7UFK-dqmTiYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehiedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepleetjeffvdegheektdekveeuueetffetffehudefueejvddu
    feduteeiieejveelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:gUnBYgcmgkpr4XjDtr68U7-BRDBuR-hTWnf_H9qt7CdX4u6O60CnVQ>
    <xmx:gUnBYlM_TASXSf1UiDq2OMm-B9uQK_2bN6bco2SVcYtrhMrMyoYQcQ>
    <xmx:gUnBYqkkxjDe6oHFvT8d4d1VAM-X18pSaqSXXSZ_jjVmYFRbyAAn0g>
    <xmx:gUnBYpnY5suVGWTcyGT2HQayO0ocLQgQ7Fl6Tj3imOK_IiSidB4qqg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 03:47:12 -0400 (EDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: sunxi: Add binding for
 RenewWorldOutReach R16-Vista-E board
To:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christopher Vollo <chris@renewoutreach.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-amarula@amarulasolutions.com
References: <20220615093900.344726-1-sunil@amarulasolutions.com>
 <20220615093900.344726-2-sunil@amarulasolutions.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <e65211d3-110b-3f25-57b7-6f65c45cf9ea@sholland.org>
Date:   Sun, 3 Jul 2022 02:47:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220615093900.344726-2-sunil@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 4:38 AM, Suniel Mahesh wrote:
> Add a binding for the RenewWorldOutReach R16-Vista-E board based on
> allwinner R16.
> 
> Signed-off-by: Christopher Vollo <chris@renewoutreach.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>

The primary author of the commit (the From:) should be the first signer, unless
you are using Co-developed-by:. See the examples here:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> ---
> Changes for v2:
> - Add missing compatible string
> - insert missing signatures of contributors
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 95278a6a9a8e..52b8c9aba6f3 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -787,6 +787,12 @@ properties:
>            - const: allwinner,r7-tv-dongle
>            - const: allwinner,sun5i-a10s
>  
> +      - description: RenewWorldOutreach R16-Vista-E
> +        items:
> +          - const: renewworldoutreach,r16-vista-e

This vendor prefix should be documented.

Regards,
Samuel

> +          - const: allwinner,sun8i-r16
> +          - const: allwinner,sun8i-a33
> +
>        - description: RerVision H3-DVK
>          items:
>            - const: rervision,h3-dvk
> 

