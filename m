Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20F2534305
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbiEYSdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343734AbiEYSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:33:14 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE4B2244;
        Wed, 25 May 2022 11:33:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 68863320095C;
        Wed, 25 May 2022 14:33:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 25 May 2022 14:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1653503587; x=
        1653589987; bh=XLpxWonmRq/QNBq/fkI4YPPckQU+cClBjO26u6WbxLY=; b=R
        duT0S70ogz23s1DW4MwE8/UjTcbotvH6+5M/D7H47QszgjJNIg65/dbsUB+dvQ10
        25qL54EAq2ECaiFHbrA53bLpTV0oMHIk48HshNL194GFQGimQPgCVectL5BwTs7I
        InZqQiwXONnw2HIOjxIpyUSArvFDnrfXMiQ+C6L4xtxLTd8Zlg2ChvZC3aoE15XZ
        X2YYQ3yiZx++zLhS0ctz/kvKDMat4hdbybHC715flEEmUiY1XpMokcFUK5Ys8CL6
        7APDrRTF3bt5WA9s7t3ILdr45z7g9FKpnx4Lv90ojc0eNU+X3h8VYvXWxNbG5dPL
        U35DUVSvftnkOHcbiuG3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1653503587; x=
        1653589987; bh=XLpxWonmRq/QNBq/fkI4YPPckQU+cClBjO26u6WbxLY=; b=o
        k282z8NEnxPIrLE1dxkSstBjQHLUzSIoAUn8IsvBe+D7zhDU9nlwdtzZWEtTuuBE
        CplGM5qC+hnvZBXaUQlFlK1CvnhQW+Ui3/cM8LKV8WT7F5PD/+vvSoNdqwSRbysQ
        ICj0C0/pPOZ+D+qZjHM6K/gKZgR2xbwM9Iq4QyrjyEs2CRs4BrQLkyK9x0AJIyox
        koubErTsUSz0sJgs9mLfy3BVUrnNGwv0wtcVHA+Q8tNf6kMS10a6pf4AHXVR8kV+
        Lqq3FusF4E+QAz8XKogxgFK1+Me5Iz99Rbp7O20EElLXbK/9+d5z+kToHuItH0z2
        98W6OsedT/w+f+uqOS7pQ==
X-ME-Sender: <xms:YnaOYpPtKWXe1ftBib8JI0WiskLvtZ73EKgzGxW0EIg5Dfl5azKdQQ>
    <xme:YnaOYr9VxoPC_WXnnzU-tYlxd6pksIi8C9k29z1GEr1HQR-bbPkgtyije_ZZDlGXx
    pqKI_Ma4_2XUkCjC20>
X-ME-Received: <xmr:YnaOYoR08PErLcXic581ig10Bbqv4nm0IBIOHwnhx-g-2d3JvB3hDyf6KX6Aj20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeehgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepudfhkeevvddtueekfeefgfetlefgueegueeltddtieejgeei
    heevgfehgfdvfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:YnaOYlugozItnvff7q0FALVsg3xYhqPw6Hv31ciuwuOKRehdBBMBmA>
    <xmx:YnaOYhfN5IuIoSSr5n5WLg7TWhqZraxdDg9t-k0bmDTMhczUHhYTFg>
    <xmx:YnaOYh2ZyKRMJYJ_rJfp_2rbrLBPkQJ4gt8_tc7_HZyeE1HDMuycCA>
    <xmx:Y3aOYs1ju-f2-jOhKdTCGYqCa-cB8yXDn4jBGonfJ4j7ubBB9CIUCQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 14:33:04 -0400 (EDT)
Message-ID: <fe7ca417-6c0f-1558-f5b1-a5ebc31e93c1@flygoat.com>
Date:   Wed, 25 May 2022 19:33:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 02/12] MIPS: GIC: Generate redirect block accessors
Content-Language: en-GB
To:     Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
 <20220525121030.16054-3-Dragan.Mladjenovic@syrmia.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20220525121030.16054-3-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/25 13:10, Dragan Mladjenovic 写道:
> From: Paul Burton <paulburton@kernel.org>
>
> With CM 3.5 the "core-other" register block evolves into the "redirect"
> register block, which is capable of accessing not only the core local
> registers of other cores but also the shared/global registers of other
> clusters.
>
> This patch generates accessor functions for shared/global registers
> accessed via the redirect block, with "redir_" inserted after "gic_" in
> their names. For example the accessor function:
>
>    read_gic_config()
>
> ...accesses the GIC_CONFIG register of the GIC in the local cluster.
> With this patch a new function:
>
>    read_gic_redir_config()
>
> ...is added which accesses the GIC_CONFIG register of the GIC in
> whichever cluster the GCR_CL_REDIRECT register is configured to access.
>
> This mirrors the similar redirect block accessors already provided for
> the CM & CPC.
>
> Signed-off-by: Paul Burton <paulburton@kernel.org>
> Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
> Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Checked against I6500 system programming manual.

Thanks.
- Jiaxun
>
> diff --git a/arch/mips/include/asm/mips-gic.h b/arch/mips/include/asm/mips-gic.h
> index 084cac1c5ea2..fd9da5e3beaa 100644
> --- a/arch/mips/include/asm/mips-gic.h
> +++ b/arch/mips/include/asm/mips-gic.h
> @@ -28,11 +28,13 @@ extern void __iomem *mips_gic_base;
>   
>   /* For read-only shared registers */
>   #define GIC_ACCESSOR_RO(sz, off, name)					\
> -	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
> +	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_SHARED_OFS + off, name)	\
> +	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_REDIR_OFS + off, redir_##name)
>   
>   /* For read-write shared registers */
>   #define GIC_ACCESSOR_RW(sz, off, name)					\
> -	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
> +	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)	\
> +	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_REDIR_OFS + off, redir_##name)
>   
>   /* For read-only local registers */
>   #define GIC_VX_ACCESSOR_RO(sz, off, name)				\
> @@ -45,7 +47,7 @@ extern void __iomem *mips_gic_base;
>   	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
>   
>   /* For read-only shared per-interrupt registers */
> -#define GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
> +#define _GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
>   static inline void __iomem *addr_gic_##name(unsigned int intr)		\
>   {									\
>   	return mips_gic_base + (off) + (intr * (stride));		\
> @@ -58,8 +60,8 @@ static inline unsigned int read_gic_##name(unsigned int intr)		\
>   }
>   
>   /* For read-write shared per-interrupt registers */
> -#define GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)			\
> -	GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
> +#define _GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
> +	_GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
>   									\
>   static inline void write_gic_##name(unsigned int intr,			\
>   				    unsigned int val)			\
> @@ -68,22 +70,30 @@ static inline void write_gic_##name(unsigned int intr,			\
>   	__raw_writel(val, addr_gic_##name(intr));			\
>   }
>   
> +#define GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
> +	_GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
> +	_GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off, stride, redir_##name)
> +
> +#define GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)			\
> +	_GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
> +	_GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off, stride, redir_##name)
> +
>   /* For read-only local per-interrupt registers */
>   #define GIC_VX_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
> -	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
> +	_GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
>   				 stride, vl_##name)			\
> -	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
> +	_GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
>   				 stride, vo_##name)
>   
>   /* For read-write local per-interrupt registers */
>   #define GIC_VX_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
> -	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
> +	_GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
>   				 stride, vl_##name)			\
> -	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
> +	_GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
>   				 stride, vo_##name)
>   
>   /* For read-only shared bit-per-interrupt registers */
> -#define GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
> +#define _GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
>   static inline void __iomem *addr_gic_##name(void)			\
>   {									\
>   	return mips_gic_base + (off);					\
> @@ -106,8 +116,8 @@ static inline unsigned int read_gic_##name(unsigned int intr)		\
>   }
>   
>   /* For read-write shared bit-per-interrupt registers */
> -#define GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
> -	GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
> +#define _GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
> +	_GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
>   									\
>   static inline void write_gic_##name(unsigned int intr)			\
>   {									\
> @@ -146,6 +156,14 @@ static inline void change_gic_##name(unsigned int intr,			\
>   	}								\
>   }
>   
> +#define GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
> +	_GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
> +	_GIC_ACCESSOR_RO_INTR_BIT(MIPS_GIC_REDIR_OFS + off, redir_##name)
> +
> +#define GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
> +	_GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
> +	_GIC_ACCESSOR_RW_INTR_BIT(MIPS_GIC_REDIR_OFS + off, redir_##name)
> +
>   /* For read-only local bit-per-interrupt registers */
>   #define GIC_VX_ACCESSOR_RO_INTR_BIT(sz, off, name)			\
>   	GIC_ACCESSOR_RO_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
> @@ -155,10 +173,10 @@ static inline void change_gic_##name(unsigned int intr,			\
>   
>   /* For read-write local bit-per-interrupt registers */
>   #define GIC_VX_ACCESSOR_RW_INTR_BIT(sz, off, name)			\
> -	GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
> -				 vl_##name)				\
> -	GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_REDIR_OFS + off,		\
> -				 vo_##name)
> +	_GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
> +				  vl_##name)				\
> +	_GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_REDIR_OFS + off,		\
> +				  vo_##name)
>   
>   /* GIC_SH_CONFIG - Information about the GIC configuration */
>   GIC_ACCESSOR_RW(32, 0x000, config)

