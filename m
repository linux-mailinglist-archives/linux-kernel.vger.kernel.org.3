Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861245370DF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiE2LyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiE2LyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:54:07 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FB64B840;
        Sun, 29 May 2022 04:54:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A7B713200344;
        Sun, 29 May 2022 07:54:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 29 May 2022 07:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1653825243; x=1653911643; bh=TyMkJ9S3FIKXSrx+MW8UBtd0k
        Xmm/kUUdF7+pxja3NY=; b=tRuEE1q1RsrhQULFDbRCFLBbltENYtBnOvTAeaVol
        qmw/xZOl2hfLQAE551FeSZ3CNeC8XSZNVoTscnCLNPLjcpcuCzzRrnvAHhu8JJHv
        OwqcYoNVACriqMmjJfr1QWserF79PsIPVSBbx1QCrHTpGlmyiKSW3ZnCT/HFxcKi
        rnMzbGBBQfiZhKWR3ZYT+DD+4hvdIhKG0/eJs34GElALn4+DnEB/av7ooS+AxQ1g
        E0C3nofSsasyXfxH5psvChlxcZKPJFCwLzCEB56UF8Ice9i/cN7TVy9NusTlNQVD
        00RzPIga0qG7Np8uKt7WdcMBTyUxFCVDSmyRrTROMKolA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1653825243; x=1653911643; bh=T
        yMkJ9S3FIKXSrx+MW8UBtd0kXmm/kUUdF7+pxja3NY=; b=yMv7jd+l+N7duKaUP
        spA1Ssicv4zAjj8OdSYNdFRuv3XL6bosaIqYFgSx9rzOjRsCltJovv0zGXq6UPQs
        mAIYBGIg3QP7qVCJyhZFOyJQDFxlkN8GaNa39GOMRkK/q389J+giLQ0/GUmivKex
        TsvvU2KjS9bGzMp+uKxBR49zZtxX74rdLB0yhFR4plz78Z4t7+eGmv8V5aWf7aGu
        P4mTTaBSEld6hKYRWjF7qW09ej6XXdZjHHeHPpnBLlumLg1b9demHquhHR8jtFxQ
        jDGuPT1Hik84LdFHV3jYk6X+BOapgIPQIYi0ilzky/fj3KY6j4sZPc4dLOXTe8Po
        D6TbA==
X-ME-Sender: <xms:2l6TYj0cpGRJ52HuKYi2ApYY8oFlp4QplMpuMA0-JaGTNBAYbLLjkQ>
    <xme:2l6TYiHwcIGgR5uhNdmM9hh4uveM6I_gm25xuNjhef02_3a9NHXxtNDYuQtEo8v2d
    PL8R2EltgZu4UPNCg>
X-ME-Received: <xmr:2l6TYj48oIgFPX-fHvxLkBZnofGWSLbKhisPDRjC05WHLuLuwYEM5T-L5zjJ3dZndKk_WvjgWpViQh-OTp2KjwyZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeeggdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefvohhmucfh
    ihhtiihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqne
    cuggftrfgrthhtvghrnhepfeffuedtjeelteffheegudekudetvdejgfejieekteeutdfh
    lefhtdeuffduueehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepthhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:2l6TYo3GZLQCAIPzlMCPynJiRrVeLIfQO1ZW-uHkZzW8xkqRp9qzPA>
    <xmx:2l6TYmH8iuVqMuVF1_3Qo0W7spEXuF_qrkoY-SyUO_TLsUNj0kCpcw>
    <xmx:2l6TYp83P-N6d8R3njAYyCh5F5JHno2mBLpsbQ8WH9bfdIZMB45aUQ>
    <xmx:216TYtcaEIFWK0nCgJisHuah0FkQsZn0mT5J_aK0S6C8tcqt7Ur1NQ>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 May 2022 07:53:59 -0400 (EDT)
Message-ID: <11f38463-1e3f-8fda-c54f-77c4065b06fc@tom-fitzhenry.me.uk>
Date:   Sun, 29 May 2022 21:53:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add initial support for Pine64
 PinePhone Pro
Content-Language: en-US
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>
References: <20220529031705.278631-1-tom@tom-fitzhenry.me.uk>
 <20220529031705.278631-3-tom@tom-fitzhenry.me.uk>
 <20220529113309.imsy7j3cnl4ihc52@core>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <20220529113309.imsy7j3cnl4ihc52@core>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/5/22 21:33, Ondřej Jirman wrote:
> I suggest to wait for the original author's submission.

SGTM. I will happily withdraw the patch series.
