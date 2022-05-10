Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F218521508
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241614AbiEJMTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239373AbiEJMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:19:21 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8561E2498BC;
        Tue, 10 May 2022 05:15:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A67173200974;
        Tue, 10 May 2022 08:15:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 10 May 2022 08:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652184920; x=
        1652271320; bh=achtEq3Cjhbongjo3uD3uyw7O+KFl9lQyt1JsKzzN88=; b=r
        7RvBjWT2rLKDHkgw3b/hLu48nmCJjXdaUeTXT10M4FXaGTH3Q9XaraDGukECmtzr
        Qr7kHqX+lxkTPYUoJ9qT6j7DJ1BHvih/Goss4lrMs8Gz8VU+vW1/Hgl6ZpegcJME
        uv4WAbv8RlybSwcNreZtrmh4vs5d78viUhzmzG8ajuEWzNWhORD6GBPqOuhGuDih
        qszKB4jBSwFP8i6CFjFt7kZ874SLQBqKOzIdTUgH7kFZhNRjd6MbFG/NTa775T6X
        myRhMQD/7Sxh2f47b1wJw6Vr/ADBALL+35S9A+74Wpyw6vn8lHyRj9dHGMG/fUUo
        p8mT40ag/ea2Efc0dLlBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652184920; x=1652271320; bh=achtEq3Cjhbon
        gjo3uD3uyw7O+KFl9lQyt1JsKzzN88=; b=zeTgWOxUR22vwa7ctidfg86lI0BDa
        O500IUA3WuzpV8qXvoh4dxqvdJLKT9FIDtt2q5BIkLq2stngz6zihM0lazY7ORmX
        bVszK/D6IL6JxA6nyp/DjmitRuZeBshvhkULSc2/19DwYPzDzwieGAcSl7eKSKma
        xhv6UZsvlEPOLY8Rtd7Kdae3heI7kdwyPLUQOwI8YrB+vczkJ7AgwWJhLsfBpibk
        G+zLL9d1StKaB3KVQlhgh+/Q3Bp9HtS//1RVL0lGb+HmBMTtDmQm/9MjD3ei8l8p
        J3Y30Nzy3GP/n6vCPh1bwh4OLm5mUA9cLC6gdN9SySzPbXRw9t6TcE+Ow==
X-ME-Sender: <xms:V1d6YiGPA2aL9IrydBC-vVK62kv3mMCGZSImj8G4L_lkus_iBphqeg>
    <xme:V1d6YjWzfXqqX_iJfm1FzP9hw56mS5HH0Or51ixSSPCaJkGkiiOWgLvV0C6AY9qDS
    fedStZoojYeOYtbk38>
X-ME-Received: <xmr:V1d6YsJDwzhjkKKQCZdXJp4x7FoEf7n3WljBJAC3xl10WhvPP5bnLzLqSTRMDNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduhfekvedvtdeukeeffefgteelgfeugeeuledttdeijeegieeh
    vefghefgvdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:V1d6YsGRv5Fivm4p8AY0TK4e2V9KV-AEOpvNF2-LR7nIPfQvPQ1T0g>
    <xmx:V1d6YoU5tCPDP285gee4ErT-UGcGiIuktU8-LiwgwaRt_WDTFMzsFg>
    <xmx:V1d6YvOX7Pz8prr9gr1r0H2NE0cB0y5DfPqJY3xV8MezUo-X8Jog-g>
    <xmx:WFd6YmwH4J7ecfXEDHLs4jLBcikDzBX43G6sR7NDyvLnfcnkJatWVw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 May 2022 08:15:18 -0400 (EDT)
Message-ID: <21bb46ea-6a36-b426-2ca9-4471af5879a1@flygoat.com>
Date:   Tue, 10 May 2022 13:15:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] irqchip/loongson-liointc: 4 cores correspond to different
 interrupt status registers
Content-Language: en-GB
To:     Haoran Jiang <jianghaoran@kylinos.cn>, chenhuacai@kernel.org
Cc:     tglx@linutronix.de, maz@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220510055303.1907165-1-jianghaoran@kylinos.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20220510055303.1907165-1-jianghaoran@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/10 6:53, Haoran Jiang 写道:
> According to the loongson cpu manual,different cpu cores
> correspond to different interrupt status registers
NAK!

It is intentional to do so.

The per-core ISR register is broken on 3B1500. So we use general ISR 
register here.
The per-core variable is left for LS2K.

Thanks
- Jiaxun
>
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> ---
>   drivers/irqchip/irq-loongson-liointc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> index 649c58391618..f4e015b50af0 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -195,7 +195,7 @@ static int __init liointc_of_init(struct device_node *node,
>   		}
>   
>   		for (i = 0; i < LIOINTC_NUM_CORES; i++)
> -			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
> +			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS + i*8;
>   	}
>   
>   	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {

