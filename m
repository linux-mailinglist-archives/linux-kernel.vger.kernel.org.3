Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCAF539C56
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 06:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349521AbiFAEmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 00:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiFAEmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 00:42:42 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33DC50E37;
        Tue, 31 May 2022 21:42:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1004032000D7;
        Wed,  1 Jun 2022 00:42:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 01 Jun 2022 00:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654058556; x=
        1654144956; bh=MqKm1T3VhwChELMNhJiWU54GYv7cli4AIoO4d1HHU5c=; b=S
        Y2Br8phdarVHJQwnRRVFPncv2X41yg7BNw1dJtJuDkmGd2VLfm6djnXuehZGpThH
        rNd+80nPqawM6MqN/hmhyoZ2VElogT2TtJ4lClVY19cnfBhb17MDMptHD2VoC7ys
        RSE9LXMuwqoCyB8vLQCrp+Rna6qzwpB+GBT/Dhdv1Pwk9EMRT5qdgCUHqqgQJzT8
        7c6kZHjQAvA+Zmelk13NAbV6M2uoAAOy5hr4yQjnk1TyhHcTYpyLWhTbLXaLHyCB
        YTm4kOt7P0K/aX3A7Lw2XkL+mzlAQC/eKphRzdHgsCUMVmhqW+oj4BGKrhIMNbJQ
        xkVt6Ee8JuoRroAYsQZUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654058556; x=
        1654144956; bh=MqKm1T3VhwChELMNhJiWU54GYv7cli4AIoO4d1HHU5c=; b=g
        zT88VczoX1HXe82zPqhmep4QQvouAYbfXpVOEYI0eCPhQS9fWzd4N7LF9GNlK8eo
        PXD8vprEQFpDkMiQ69fCTrxIuXY4NerTmY1lhcpsXsA7OqzXgPDb0ZDOT4fQ0siR
        L+wk6x4cOHHKKpYUTRDdnZ92tzlyp7djIr7d8TfpmP9wepKLIZLWBOUe0I17qKXT
        Vq45BZGNM7aBQ1o9SQUSGm4Pu2oIYzvDArxqywwYopWExzmWoDo5ilq2v4m2XjR2
        YqXT+DWfyr6CI5ge7D6jJ1pXAYAxZgAnxIZhP3C3MKY5DfUKNUrl6AEy5gvI70v4
        J8Th/XuRPe2ObxdgDFnbQ==
X-ME-Sender: <xms:O-6WYt7-s4pDVXWIi0jA72vLK2aiLZpGWz42jAgS_ptmaaQS1JkiYA>
    <xme:O-6WYq4UPYbNjjdCDxMtF723cuNTxnW4hPbp-4yQX2rB0y1mcVueuDiDs9lB5W4B7
    pziwa8bA7zzWeHeQA>
X-ME-Received: <xmr:O-6WYkd6XvQ3lUKvQscJjVuNVsQUg2OO9TAx6-PiSpo2c8Z0WBOnmBDIlgfaU4jqvKy4RmeyK7Cf-rwXCuzxpyNR1Pu8oRHlX2cCxflL3KLhdZ-zB21Xqiyqiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeelgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdevhfehhefgvdekteffleduueduheduuedvtdevleelkeevvdeu
    vdeihfekueehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:O-6WYmJGbX4W8_HMxelFk3pY-tg1hd9YkjTfIdP0U3JU6BZ_2zDuPA>
    <xmx:O-6WYhLIXhzd9gQDEWm2BnkVyVUSfJ6gzYvRZatWbig97jBqtXHQNA>
    <xmx:O-6WYvz3mckQcAKb28DkX02-eNlOaJfcClbxiGB_1DWnd062uESwZA>
    <xmx:PO6WYrwBzoC_VEB71MJXNEgTZF2Dioqsv-0xo6QxiircO4l-SLtoJQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jun 2022 00:42:35 -0400 (EDT)
Subject: Re: [PATCH 0/3] pinctrl: sunxi: Remove non-existent reset line
 references
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220531053623.43851-1-samuel@sholland.org>
 <4400164.LvFx2qVVIh@kista>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <48570ec3-8159-11ae-8069-7f001081fd56@sholland.org>
Date:   Tue, 31 May 2022 23:42:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4400164.LvFx2qVVIh@kista>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On 5/31/22 10:22 AM, Jernej Škrabec wrote:
> Dne torek, 31. maj 2022 ob 07:36:20 CEST je Samuel Holland napisal(a):
>> I assume these properties came from a lack of documentation, and the
>> very reasonable assumption that where there's a clock gate bit in the
>> CCU, there's a reset bit. But the pin controllers are special and don't
>> have a module reset line. The only way to reset the pin controller is to
>> reset the whole VDD_SYS power domain.
>>
>> This series is preparation for converting the PRCM MFD and legacy clock
>> drivers to a CCU clock/reset driver like all of the other Allwinner
>> SoCs. I don't plan to add reset lines that don't actually exist to the
>> new CCU driver. So we might as well get rid of the references now.
>> Technically this breaks devicetree compatibility, since the old drivers
>> expect the reset. But the CCU conversion will be a compatibility break
>> anyway, so it's a bit of a moot point.
> 
> If I understand correclty, this would cause only DT forward compatibility 
> issue, which happens now and then anyway. Kernel would still be compatible 
> with older DTs, it would just ignore that reset, right?

Right, this only prevents older kernels from working with newer devicetrees. I
brought it up because I'm generally trying to minimize how much we do that.

Regards,
Samuel
