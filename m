Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B2E58B375
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 04:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbiHFChn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 22:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241760AbiHFCh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 22:37:27 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD57D79F;
        Fri,  5 Aug 2022 19:37:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 90A6A3200258;
        Fri,  5 Aug 2022 22:37:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 05 Aug 2022 22:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659753436; x=1659839836; bh=J9ezvZ0JQJ
        O1dlJa837b0h4jTt/Hm/8CN8x0Zq+RNAU=; b=WSZ/yw6DPDwosQZySxLcFrjyk+
        kxZjH2XICwKYkFX0ctlMfqdyj26hNrW31YtgHXizkF6s7BG6kHvHjvNeW2wAuRRD
        Tr/lFQRRTva3Zb0Vb33a4GPTcMZcJKQUCIQYmEYHckXoDsS+MRsnhXLkPlg4UnNI
        Pc5W9lZtrnMPrZ/UKea/bIkQGI7k39MY1ddMTjEL3f8AwAPHjcNgk5jUldR7xv7U
        N/tyxy3KB8upkEh1/Lv/qNv628MIARS8Y+qZhpieXdmCDHfc5Pzfm7ZV2XOwjl2C
        7ZzEG5XgWjL4ZGcBMN74c/1w1U48h9n4Kd1IEWT6mAyCT+ws1y6WLnHOthFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659753436; x=
        1659839836; bh=J9ezvZ0JQJO1dlJa837b0h4jTt/Hm/8CN8x0Zq+RNAU=; b=e
        gsWMca+5cPdJrEDfZ0xJxrp6qNDLiCWBffbmp4sFvXMmOYtgd2VgYVbS+bYoFWv1
        op5CI4pux6HweZSHL286N1uvA3TMKiFMBN1md5UGiRDxO2vghXzrq8oTgyav1Two
        Byi12Omr0sGfUiGF6adw41+Gufsfp5mQVN0y0PmTwkvOJZGKua2DJapgJYpgPz6x
        ranh3u3NUTmu5D+UrO+d5laOdt36iHxkBL860pOXnJcOlkgNd11dwjwJ5wqsoxsj
        kU2u3TpceTyuLdmfRu044KRn0vt+WXLoIrmZhNOW3ROhbMxpQ6R6ux8JlVcVrCWv
        Eq0Y74QyrNVhvRtBEG1ng==
X-ME-Sender: <xms:29PtYp2lRbPuku9hB3T-GEiYsjzaaKOntivDIUuyJMFxw7g9U_bdtg>
    <xme:29PtYgGuJAKNfBsU5lfNx5c5S5fJYFHuq_qPlIFGbu0iLiMoXBGckXTSBbwKwjQpf
    VF4-d7JKvq5a6ndzw>
X-ME-Received: <xmr:29PtYp5UPxxqPmDbfpHqOtjaz0H6j9seo5uvXiBJhojVRQSsvB4_FanMCPPzBFV4Y0OlkME91X3kUxgLqY2MuK5L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefvddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfvvehfhffujggtgfesth
    ejredttdefjeenucfhrhhomhepvfhomhcuhfhithiihhgvnhhrhicuoehtohhmsehtohhm
    qdhfihhtiihhvghnrhihrdhmvgdruhhkqeenucggtffrrghtthgvrhhnpeetudelveejvd
    ffjeevvdelvdffhefgueefgedtffevgeevudfgieegleeikeetudenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohhmsehtohhmqdhfihhtii
    hhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:29PtYm1niDcVEXwJEQRnR63eQLB1iSITm9RPck6poEGsrkAnp5xypQ>
    <xmx:29PtYsG7v0zu8fSbN0JgDqBVBZ70LcXxm-NKsqHr7Hn3KIDfRq5qow>
    <xmx:29PtYn_zJOU_cnitYdQD1SU0dBZwgoslUmyxcFtLdPCXk4QusCWxZA>
    <xmx:3NPtYgFacL4aJRTiYAfH8lIFBZMeqfbQWjN3r2iyhja_H7Y31i0f3w>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 22:37:11 -0400 (EDT)
Message-ID: <9a168a20-1fd1-5d73-1d33-bd2f054d60d7@tom-fitzhenry.me.uk>
Date:   Sat, 6 Aug 2022 12:37:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
To:     Caleb Connolly <kc@postmarketos.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     megi@xff.cz, martijn@brixit.nl, ayufan@ayufan.eu,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
 <f9cbc047-f30f-e711-3213-56fcbb7bbc8a@postmarketos.org>
Content-Language: en-US
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
In-Reply-To: <f9cbc047-f30f-e711-3213-56fcbb7bbc8a@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/8/22 12:10, Caleb Connolly wrote:
> I was surprised to see this series, and this patch especially.
> An almost ready to submit version of this patch with considerably more 
> functionality has been sat around for a while but unfortunately never 
> sent [1].

Firstly, thank you for your review!

I'm not sure why that other patch series has never been submitted. It 
was prepared 3 months ago (unbeknownst to me, at the time of v1), but 
since then has not been submitted.

I would feel uncomfortable submitting that patch series, since I am not 
familiar with parts of the full DT. In time I intend to be, but for now 
I think we'd benefit from having a base DT mainlined, on top of which we 
can iterate and parallelise.

> According to the link below (and my own knowledge of PPP development) 
> Kamil is the original author of this patch, both Kamil and Martijn 
> created the initial version of the devicetree. Given that you're using 
> their work as a base, Kamil's authorship should be respected in the 
> patch you submit.

I agree authorship is important, and thus Kamil, Martijn and Megi are 
listed as Co-developed-by in this patch.

> Their original patch [2] contained SoBs from them and Martijn, those are 
> both missing below. Both of their signed-off-by tags should be added 
> before this patch hits the mailing list, and the same for Ondrej. The 
> order also seems wrong (Ondrej should be last before you).

Yes, this patch's acceptance is blocked until all Co-developed-by 
authors (Kamil, Martjin, Megi) provide their Signed-off-by to this patch.

> Support for the volume keys, accelerometer, magnetometer, GPIO LEDs, 
> touchscreen, modem codec and audio support are all missing here, but 
> they're included in the patches you referenced. In their current state 
> (see Martijn's commit [1] or my 5.19 rebase [3]) the DT for these 
> components has been worked on by several people, tested by the larger 
> user community, and are already supported in mainline. It seems strange 
> not to include them and just leads to a bunch of extra busywork to add 
> them back later. It's easy enough to drop any of these nodes during 
> review if they become an issue.

To keep this patch series light and easy-to-review, I'd be keen to keep 
it as small as possible for now. This DT is >18 months old out-of-tree 
(across multiple repos), so I think this minimal DT being mainlined is 
an improvement over the status quo.

The existing work that the community has done will still be useful, 
albeit in future patch series. This DT just allows that future work to 
be done iteratively, and in parallel.

> With that being said, I've left some feedback below, with it addressed 
> and the authorship/SoB situation sorted out:
> 
> Reviewed-by: Caleb Connolly <kc@postmarketos.org>

Thank you for your comments, I appreciate your review! I will ensure v3 
addresses those.
