Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037BA5B2DD3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiIIEys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIIEyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:54:46 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F46D2528B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 21:54:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BDA8E5C00E5;
        Fri,  9 Sep 2022 00:54:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 09 Sep 2022 00:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662699284; x=
        1662785684; bh=amv9ICltjZk+eIYa+llWaKBwwrexAvmDG285zE+xSs4=; b=U
        Bepp5EnGejqtxUrflkxrG2bfdX6wWVkuEr6E5JnQgq+bVXY+r90c6/JLTVkQNSSI
        6y3NRGAIt+ViAnXdMBAHJqcCduYN6Gb4QKsxEZpYdYRzzzYv4o0h3q4bzNgoAbOM
        m3hV7uKDO5h9Rnbl4gLMC5xnHNJ/9ynneNFEWGaWR7FZ0oCaqLLQV+cnwTWWezBi
        OKoOLtdEiIczsuycfbq7rx5hi967OXSl25gFYzwMA8tcNYwkPwBU3INOAcfsM3jo
        M0CIHUcpxTT/7ZHqArKmvX4Xf7cgJZVu7N1+p1s2DZx8i44tbaVdCh8RsoEQ9v2C
        WFfH3t4Oy2I5AwWhLBNAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662699284; x=
        1662785684; bh=amv9ICltjZk+eIYa+llWaKBwwrexAvmDG285zE+xSs4=; b=m
        qZQEF/A34CRE9SqJEHjn/J3BnC+MEwhtVSjNObo/Re7gfIQYRUbPt4HZ1Kk2hlpe
        dRDVgR0T7NEzSgzBxvZXtSaOWb82/1fgWzDXv/7dZAT4BiZ6S6r54Q8H1GM/cKli
        3pCzqoUUp6FXfs6J4pVvoNMl8U4s8g5fbEAKZzEgINvrUUP2+6IU8qrUDQ4zH0xu
        zbmTjhAGd9mX8MJ7Jcs3+rmDng43TOkppOEQwMdgrpYFx0XkV+xXTzWzxS8x38uV
        O56B7Q6bBcUzSLqvRKdvrdB8uDFT03oe6Ddn5t2V5l2j6DzLqW9G10AxZIe0Nl70
        HAbiXY3IEehfAF5aOsHKg==
X-ME-Sender: <xms:FMcaY3rDW-O_HgBHCJCb6hgT_Y8e573Oy_1BHFc0NWY3L8Pqw87ppQ>
    <xme:FMcaYxrzH4imNxLTJt_WXmoWOzpo_hugEmnua_G-4NfDUsSH2vJO-aMd7dDQkv4I5
    eFSW27riT_disZWSA>
X-ME-Received: <xmr:FMcaY0M2XEn1s8BDKWSKJ7W8WPKD27XAgJ-qaQJFGCReOSH8EhCmxhpYo_JjSBUTjD-a95XiNe0D818pv2wauOGkJY7PZcfzmUZ7KgmQM93lSbP2NYHRgRQ2gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtgedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfevfhfhkffffgggjggtgfesth
    ejredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghl
    sehshhholhhlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepffdtveekvdegkeeuue
    etgfetffeileevudekuefhheelvdfhiedtheduhfduhefhnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnug
    drohhrgh
X-ME-Proxy: <xmx:FMcaY664qnk1pDT8q_nKVVrHilvpdVsGEIhCM7ukH2eBeuu0XpEmCQ>
    <xmx:FMcaY266SJD-Rg_ff8h-41H76Ms_czO8xdOR-GGfdKDqTvOt2c6t4A>
    <xmx:FMcaYyjRxIhM7PDeRc3bTCT-b_BycRvVG_UmRlzyaE5tVCOAG7GCvw>
    <xmx:FMcaY_Fgt0WpstGGPYE-nzc_VuDsaTOxlLxjJGwP0WQj2g1ZKHDfaw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Sep 2022 00:54:43 -0400 (EDT)
Subject: Re: [PATCH v9 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
To:     Ban Tao <fengzheng923@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com, wens@csie.org,
        jernej.skrabec@gmail.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <1661870696-31042-1-git-send-email-fengzheng923@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <2e7a0006-00c9-c85a-8d05-144bed24dfba@sholland.org>
Date:   Thu, 8 Sep 2022 23:54:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1661870696-31042-1-git-send-email-fengzheng923@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 9:44 AM, Ban Tao wrote:
> The Allwinner H6 and later SoCs have an DMIC block
> which is capable of capture.
> 
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> Tested-by: Samuel Holland <samuel@sholland.org>

Looks good, thanks!

Reviewed-by: Samuel Holland <samuel@sholland.org>
