Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F106539426
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbiEaPkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345663AbiEaPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:40:14 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1D8BD1A;
        Tue, 31 May 2022 08:40:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D535E3200938;
        Tue, 31 May 2022 11:40:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 31 May 2022 11:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654011611; x=
        1654098011; bh=Zcj/r1clfv533pxHCEgYX485weAeVVQ7YWF9px8Y20M=; b=P
        tBmw8yntsvkYQyIETqzRdLCQ7mfPIlMiw3xGIZ40GW6ywBE8EPvatD4q4L4zCL7s
        SSf+24zsoTegwFK0RxhYzE04/+HVK0E2ETqtBQrmVHeUEcjhBodzGFR7CY0GIP1c
        kPMkagQdIjUP51s6wtKVeDSn4V3rwVPWqPbWr7XngdUr0sD94CCx02D1pLVYXIN+
        etASS6mNZ6umkzoJs+Wuy9UML73xkZdajKBZD2OisFoUZzMaNqkpEKqYRfjUVUiO
        AYV3aEActNykvPkuwHS/aEiAfGmgtJBSvsIE9QViU91+GJdqbiy4bARUp2gylQ9S
        +ggpjvP4qJod+kYkuvVsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654011611; x=
        1654098011; bh=Zcj/r1clfv533pxHCEgYX485weAeVVQ7YWF9px8Y20M=; b=j
        sofJUnds361JQGwYeRPpx9YGRhCwwtYUg5duQ26uu1ONlmBaIVUIVaOubixk7BD9
        tP7EC/jmXCa8DHzvMR3EmK+evGpCBFrkjmH6v9KSezl1ss9lQ5DoWUDJh1OUc2C8
        oqPPe1qXJiZ7vV8EYEm+0R4XVm2WPn2tJaz/H3SZL85V83k6c7MkNJ5cLLm0zyw7
        sep+Cd9pHYYtLjsWxgTytqWWgN29m37R5vG5J3Q6dSIDS66xrKhemvZqwueXLyhf
        Kf3RR2edW0AzPJgID4WAKR9xIohbEZ+KDb/JDZr7TGwV0ux308rGXv+vwbPcq3+K
        2rwuE5OMlPuQCi2YlBWvw==
X-ME-Sender: <xms:2jaWYunxF6uc6E9FNKTZ8_IzSrQTJAmBfayS-UtqP0GWIBTtxD04Dw>
    <xme:2jaWYl1yS7VAECFNnQPptW3kMHoFPG9319MXBiMXH5CcfF1mE2sHqAskrZ5GxyVJC
    USlyQps82_wYB21f5A>
X-ME-Received: <xmr:2jaWYsqX-wRyd6r4_ECgncombix3Rh-bwUGW-2-Xi67t2FRZZxdZn0uc4LfFNag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeekgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduhfekvedvtdeukeeffefgteelgfeugeeuledttdeijeegieeh
    vefghefgvdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:2jaWYimJmoj4BZ6mpWe4tkmaDX7dRO8Xel2IAzmrSH6ROxgqT84q_g>
    <xmx:2jaWYs0AFz0HV-NmB2cZHa8RzhyYfkmJKiDwuC8dRxQT9-yDlrYlIw>
    <xmx:2jaWYpshZrHU2yx7LjPk80_dIz-nvYUZAlyiY8Avg771m5IIVgwdMA>
    <xmx:2zaWYvScrpueCLw6YPcgypbU2vMP43taWHnnjbhNuA4-HgcGenELIA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 11:40:09 -0400 (EDT)
Message-ID: <e8cca5c1-2db1-840e-609b-4ae98791ba80@flygoat.com>
Date:   Tue, 31 May 2022 16:40:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MIPS: fix pmd_mkinvalid
Content-Language: en-GB
To:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zhaolong Zhang <zhangzl2013@126.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1653971769-14152-1-git-send-email-zhanghongchen@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <1653971769-14152-1-git-send-email-zhanghongchen@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



在 2022/5/31 5:36, Hongchen Zhang 写道:
> pmd_mkinvalid should not clear dirty flag,otherwise the pmd
> dirty flag,it's ok to just clear _PAGE_VALID.
Hi Hongcheng,

Sorry, what is meant by "otherwise the pmd dirty flag"? Could you please
elaborate?
In my humble opinion _PAGE_PRESENT must be cleared in mkinvalid as it
nolonger present here. And thus it lose the dirty status.

Thanks
- Jiaxun

> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>   arch/mips/include/asm/pgtable.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 374c632..d30a186 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -698,7 +698,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>   
>   static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>   {
> -	pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY);
> +	pmd_val(pmd) &= ~_PAGE_VALID;
>   
>   	return pmd;
>   }

