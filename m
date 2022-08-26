Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15285A1F79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 05:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbiHZDfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 23:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHZDfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:35:40 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432BAC7412
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 20:35:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 048F53200A5A;
        Thu, 25 Aug 2022 23:35:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Aug 2022 23:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661484935; x=
        1661571335; bh=ml0QXgJ11ruYlZ5YBTcNNwBdbFxRHL+i328CjCLIyDQ=; b=E
        rudUJeoAWxjsiGudYFg/YqyOI1UcDJYDuAlZvPjSs/8nnR+3qtXp0cqbzV5QjLgY
        6Bn/1zavNXJegVdtEWVuBt5Hhe2DU6xpmkiOmkCynMN/zIr55nh51mANZBC6cxFe
        0MVugqYnZRc4aDAVy1+hiapL4FfN2ShEzvK1tMG3z3ma1ZZSW3HPG8BExmtZ86Ly
        EdAlJpVJrW22Wr9WzFj+XTNNLt7nUzO2FlbpUvxscxdOXDyyHXO3dRHfV3W+ESwf
        v3MVVREIx3lRwbo9KYHTw0rX+bItIR9CLZTqpffcAsACXeXXd4zuPJIHAPM75275
        osI3e2wyd4XuK1yMCqAjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661484935; x=
        1661571335; bh=ml0QXgJ11ruYlZ5YBTcNNwBdbFxRHL+i328CjCLIyDQ=; b=k
        7jTPLkA1GPCOeTF315UggtQcrak/RA7HRfKj+M6s5YwS0fVDo9M9Q33hGbASCCV2
        pWPdtYOabfbGXyzBZ3rNGZWXiRSKpYtOVT8y0Q7IKFBghFlLNb7wYmI0bdudixRZ
        opE4/iC5qfes23b2iSGKs8z6rqND+EVLi7Nk7NGkfWX0M7uGvWdilr/3+/Jtez0z
        Leo0hDndSftiUlEACjaHJpIFjjB6hcheWukJqMK5+MR3E6Dfn8oPOfRFEEZuHq3j
        Ls7af1+rMsfC9s1UX8pBI31ogw7+ZlI7gv4wXNpDYs4wd4bKnqvxxV6esvn/KdPk
        dSbTzH5NEkHeENDstf6DA==
X-ME-Sender: <xms:hj8IYx2jLPdY01J7fBuycr5CoyzUqALP10wfY_IIyLHQTyQguABCqA>
    <xme:hj8IY4GdPyXCaPniZoMYyM8pchTQVUpK69fBuDVKBS8SQpotv1UsNpUCw7q6O_Cn0
    forb8BBejgGwVQexg>
X-ME-Received: <xmr:hj8IYx5O5AutYUSEanpcTm5aA-16d5lnWIBmxVj-kpe4Rwn-5PXIqUUDxC62guVCWOxHwuG-Fgp7_QhduUs7DqEoNishu6bI4fOzhRblWInADF1DXHG6ENV4TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfevfhfhkffffgggjggtgfesth
    ekredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghl
    sehshhholhhlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepleeiheeggedtieeugf
    effffhvdelkefgheetheehffevteffheejiefgffehtdehnecuffhomhgrihhnpehlihhn
    uhigqdhsuhhngihirdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:hj8IY-2i73q8zn_wt-Wb1Fo896455wFu9JfcSCTIfmE3uBJX8l-oiw>
    <xmx:hj8IY0ERKZmBwqX01GbY0q0TRKDeBeAlb7Y2J7mbr59ShiDrYa24kA>
    <xmx:hj8IY_9az-L6uVcr5r_l7GXpQ7pn_CysvjFBHD77q7zbA-_TGhfF6Q>
    <xmx:hz8IY_BYl-btqlxHbQ0yed6dZqtz2hFG1a_oIkzCxsnQAc85N_gPgA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 23:35:34 -0400 (EDT)
Subject: Re: [PATCH v8 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
To:     =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, wens@csie.org, jernej.skrabec@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <1660229343-14133-1-git-send-email-fengzheng923@gmail.com>
 <3fb9adb7-96ef-c85e-069d-ef7f7ff09bc3@sholland.org>
 <CAE=m618gz8mzRnvX-w6fpNmTc=5Bd0KTKeR1NvpNZkbj29=ayg@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <b36262df-9324-6cd3-b74c-5b93840dabb0@sholland.org>
Date:   Thu, 25 Aug 2022 22:35:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE=m618gz8mzRnvX-w6fpNmTc=5Bd0KTKeR1NvpNZkbj29=ayg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 10:08 AM, 班涛 wrote:
> Samuel Holland <samuel@sholland.org> 于2022年8月20 日周六 14:57写道：
>     On 8/11/22 9:49 AM, Ban Tao wrote:
>     > +     switch (params_format(params)) {
>     > +     case SNDRV_PCM_FORMAT_S16_LE:
>     > +             regmap_update_bits(host->regmap, SUN50I_DMIC_RXFIFO_CTL,
>     > +                                SUN50I_DMIC_RXFIFO_CTL_SAMPLE_MASK,
>     > +                                SUN50I_DMIC_RXFIFO_CTL_SAMPLE_16);
>     > +             break;
>     > +     case SNDRV_PCM_FORMAT_S24_LE:
>     > +             regmap_update_bits(host->regmap, SUN50I_DMIC_RXFIFO_CTL,
>     > +                                SUN50I_DMIC_RXFIFO_CTL_SAMPLE_MASK,
>     > +                                SUN50I_DMIC_RXFIFO_CTL_SAMPLE_24);
>     > +             break;
>     > +     default:
>     > +             dev_err(cpu_dai->dev, "Invalid format!\n");
>     > +             return -EINVAL;
>     > +     }
>     > +     regmap_update_bits(host->regmap, SUN50I_DMIC_RXFIFO_CTL,
>     > +                        SUN50I_DMIC_RXFIFO_CTL_MODE_MASK,
>     > +                        SUN50I_DMIC_RXFIFO_CTL_MODE_MSB);
> 
>     I checked the manuals again, and I may have given you bad information. There
>     appear to be two variants of the DMIC hardware.
> 
>     A63, H6, V5 V100, and V5x6 manuals list Mode 1 as "reserved" for a 24-bit sample
>     resolution. The newer SoCs (A50, A133, D1, H616, and R329) describe Mode 1 as
>     extending the 21-bit sample with three zeros at the LSB to make 24 bits, which
>     is what we want.
> 
>     On my D1 board, recording in S24_LE gives me good audio data, with equivalent
>     loudness to S16_LE, as I would expect. If this also works on older SoCs like H6,
>     then the manual is wrong, and the driver is fine.
> 
>  
> I checked the H6 manual, DMIC also supports 24bits. The H6 SoC works fine in
> mode 1. I don't know where your manual came from, mine is provided by SUNXI. 

I am referencing the manual linked from the linux-sunxi wiki, section 7.4.5.7:

https://linux-sunxi.org/images/4/46/Allwinner_H6_V200_User_Manual_V1.1.pdf

    For 24-bit received audio sample:
    Mode 0: RXDATA[31:0] = {FIFO_O[23:0], 8'h0}
    Mode 1: Reserved

Since the manual is wrong, could you please add a comment? Something like "The
hardware supports FIFO mode 1 for 24-bit samples, even though the H6 manual
describes that combination as reserved."

Regards,
Samuel
