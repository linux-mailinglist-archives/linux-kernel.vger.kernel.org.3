Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3014C3C85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbiBYDlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiBYDlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:41:46 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17020C1B6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:41:13 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220225034110epoutp03cff1ea468a063bea5c8caba92dd8aa1c~W6m2avAAV2884028840epoutp03p
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:41:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220225034110epoutp03cff1ea468a063bea5c8caba92dd8aa1c~W6m2avAAV2884028840epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645760470;
        bh=N29ZPBUvHaycT8Q+Gi7ECEqEaEFqzrCe8lxP7zqrdck=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=EKzlBB4RcQC5K1aLwJmJMSryleevYMzvF4HoBxl+nyMRscY1OV6yB2UMKhHNeEztl
         kAZWVJtYreYv6UnRT5WJmxWfFTmAUPKxhalQApKBMCcltojkXqsn8TFbEGPTFO+mMB
         VjuuRml6y3yOGMJ5LaCJ4DcZs/bFDA8+HAorzLU4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220225034109epcas1p4768d7173c899ae70bcdc768510a25ce3~W6m1qW15b1588915889epcas1p4k;
        Fri, 25 Feb 2022 03:41:09 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.145]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4K4bCh6bLBz4x9Pw; Fri, 25 Feb
        2022 03:41:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.CE.64085.0DF48126; Fri, 25 Feb 2022 12:41:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220225034104epcas1p428e4367c678c7345d33367053df14202~W6mw7mRca0250902509epcas1p4S;
        Fri, 25 Feb 2022 03:41:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220225034104epsmtrp28f5b49ac96de9f8becbb82afe68d3fe7~W6mw4CnJK1475114751epsmtrp2Q;
        Fri, 25 Feb 2022 03:41:04 +0000 (GMT)
X-AuditID: b6c32a35-9adff7000000fa55-d2-62184fd073d8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.61.29871.0DF48126; Fri, 25 Feb 2022 12:41:04 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220225034104epsmtip1eda220f5d467a155c6be26c1c65d9be7~W6mwij-kS1876518765epsmtip1R;
        Fri, 25 Feb 2022 03:41:03 +0000 (GMT)
Message-ID: <b9650211-2e98-5e1f-1dc9-9c5c3571f359@samsung.com>
Date:   Fri, 25 Feb 2022 12:52:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH] drm/exynos: fimd: add BGR support for exynos4/5
Content-Language: en-US
To:     =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>
Cc:     Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Inki Dae <inki.dae@samsung.com>
In-Reply-To: <20220224232723.GA133007@adroid>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVCTdRz39zx7Hh7IeU8T4Rd1Ck+nJt7eBNZDJ7s6OG8RHlye1lnXfBjP
        wdpre+mgy4S4aZGYA+lomy8FmlKJDRqwYnrDAzlKQGYSiXIh3mYO8AUylWrbo8V/n+/nPp/v
        6+9HoAIvnkKo9RbWpGe0FJ7A8/SskwiHCmGxxDcgoWvP9yP0Px47SgfmZnA6eGWYR38XvofQ
        P394M452T/6C0SNeF043DvoQ+qe/G3h0Y30If/EJhaOyFld0zx/hKboc43GKjvkJTHH1kz5E
        0da8S7GvvQUo7rhXFhHbNRvLWKaENaWyepWhRK0vzaFe2aLMVWbJJFKhNJt+nkrVMzo2h8or
        KBJuUmsjjVKp7zJaa4QqYsxmSizfaDJYLWxqmcFsyaFYY4nWmGUUmRmd2aovFelZywtSiWRD
        VkS4Q1PmnA6jxtHscn/1LKgE/aIaEE9AMhO23r2A1YAEQkB2Ahiw/cbjgtsAToSccVGVgJwH
        0OPOfezo/PEuwom6AfzKWYVzohkA9w/G1wCC4JNy+INHFqV55GpoOxfkRTGffBL2f34thleQ
        r8PQ2QUkipeTedD1ZU+MR8lkOHbtcIxPJHPg4Jl9se5Qci8Kvd6vY7XwSFL78asxHE8Koa9j
        D86ZV8Hq751o1ADJcwT8fWQ+jus6D47/WYdxeDm80df+iE+Bd6a7cc5QD+DlS8d5XNAIYM9f
        lwCnyoCnj9Yj0dFQch1s9Yo5Og12PTgIuMrL4PTcXiwqgSQffrRbwEko2Ds8+igLhEPNdpzD
        Cniv9zy2H6Q5Fi3GsWgBjkXzOP4vfATwWkASazTrSlmz1Cj979oqg84NYo84PasT2MOzIj9A
        COAHkECpRP7kzuRiAb+EqXiPNRmUJquWNftBVuQ8djRlhcoQ+QV6i1KamS3JlG3IyKSlMimV
        zG/5bIARkKWMhdWwrJE1PfYhRHxKJcK+DFerXhotrDjkO6BxySTbR074jeqxpcdM/Nqn/TW/
        2qiVJ2/lna0QL2Tk13S23vdu6kya8N26vay/DqSHuzDM415owo61ZHcVVPSu8vjHnn3tG9JU
        NPxQVP7QZa+qs5VPJbW3YxcnZgdOPpXfHHr1waG3lODtrW9+gGlyT+vQtoBi4vCAsqc4fa6t
        akotnrwhH5o3vX8lWLh1/XOX39m8Oz2wpKmjO3/bUn+LTZXonfn04y27jk4r0/b4do4Pn6IS
        Ck4l1r/R4D3T5yxef9Mll/9ReREi1hOOb8XMF2uEiRVrG2oD9NogCN4fncGqrz/TEQqv2bGt
        IHyhaep6s3AJxTOXMdJ01GRm/gXVxv+GTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnO4Ff4kkg9lXBC16z51ksvi/bSKz
        xZWv79ksXty7yGKx8e0PJouzTW/YLTY9vsZqcXnXHDaLGef3MVmc+TeVxWLG5JdsDtwesxp6
        2Tz2flvA4rFz1l12j+3fHrB63O8+zuSxeUm9R9+WVYwenzfJBXBEcdmkpOZklqUW6dslcGXM
        fveWueCGZcWh5g+MDYwn9boYOTkkBEwkduz5wtTFyMUhJLCbUeLkuwfsXYwcQAkJiS1bOSBM
        YYnDh4tByoUE3jJKdPwIAQnzCthJ7N5mBhJmEVCVaD3xggXE5hUQlDg58wmYLSoQIdG2bAoz
        iC0s4CIxZ9FhsDizgLjErSfzmUBsEQFbifMH+lhBLmAW6GOWODVnCQvEOdcZJVqu3ASrYgPa
        MHHFfTYQm1NAV2Lf9nY2kCOYBdQl1s8TghgqL9G8dTbzBEahWUjumIVk3yyEjllIOhYwsqxi
        lEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOOS3NHYzbV33QO8TIxMF4iFGCg1lJhPdx
        rXiSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxLuRQ/
        LZf+ofd1cq3D6gk2lYlWJkFLmr1eZgQqpT3OKtv3TabN+fS241MTBBUW3Ne/pXjojc8Wj/Qv
        35jNOtOv/9tn8fv032f/q891HOCyn3OwdrFEjvXLrXsLP17nXdayQyz3rqvRpdayHV+MZvYL
        96T2F/9fOSPxG5e99iv9ZZrHYxPjTpgmRWubNbCe4j84TbImkOmgVrzElWmCRQ/jA6+KyOYq
        21c+Y5LnCmXUNhH7ckD7X19wSM6G32tfHHUv3hSteEDmQsCtBy/W854UU/vR8m/ChIR1219u
        vHZUJOH5Zd45bxyOZGt+lUlpS2ZReLzn3h2p5A/JX4/+Tl0rxztxS6lo4Lc9rr0WfxYqsRRn
        JBpqMRcVJwIAw3lWJSgDAAA=
X-CMS-MailID: 20220225034104epcas1p428e4367c678c7345d33367053df14202
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220129220203epcas1p25b1704191dd7babfb8d5b8dc6704d566
References: <CGME20220129220203epcas1p25b1704191dd7babfb8d5b8dc6704d566@epcas1p2.samsung.com>
        <20220129220153.GA33165@adroid>
        <5e18705f-79c1-18a7-57f2-74866abe21e9@samsung.com>
        <20220224232723.GA133007@adroid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

22. 2. 25. 08:27에 Martin Jücker 이(가) 쓴 글:
> Hello Inki,
> 
> On Thu, Feb 24, 2022 at 10:41:04AM +0900, Inki Dae wrote:
>> Hi Martin.
>>
>> I found that exynos4 and 5 data sheet include documented same register.
>> RGB_ORDER_E field of VIDCONx registers will do same thing.
> 
> If I read the manual correctly, this register combined with the
> RGB_ORDER_O makes it possible to map the whole RGB interface output to a
> different order. What my patch provides is a way to configure each
> hardware plane separately while maintaining a consistent output on the
> RGB interface.
> 

Understood. Your patch will allow BGR pixel order per a plane. Seems to be useful because a framebuffer with BGR pixel format can be displayed on screen without any color space conversion. :)

> Implementing the RGB_ORDER_O and E would need some logic to make sure
> that all planes are always using the same RGB order.
> 
>>
>> I'm not sure whether the use of undocumented register is safe or not - maybe some HW bug exists.
> 
> I see, that makes sense. Would it be possible then to introduce a new
> compatible, e.g. samsung,exynos4210-fimd-ext which can be used on tested

Seems providing a new compatible is not a good idea.

> devices? I know that some other Galaxy Note and S devices with the
> exynos4 chip have the same problem (and solution).

Could you give me more details about the same problem and its solution on the devices?
It would be useful for us to decide the upstream direction.

If necessary then we may need to contact HW engineer for clarity.

Thanks,
Inki Dae

> 
>>
>> Anyway, I'd like to recommend you to use documented register only.
>>
>> Sorry for late and thanks,
>> Inki Dae
> 
> Kind Regards
> Martin
> 
>>
>> 22. 1. 30. 07:01에 Martin Jücker 이(가) 쓴 글:
>>> In the downstream kernels for exynos4 and exynos5 devices, there is an
>>> undocumented register that controls the order of the RGB output. It can
>>> be set to either normal order or reversed, which enables BGR support for
>>> those SoCs.
>>>
>>> This patch enables the BGR support for all the SoCs that were found to
>>> have at least one device with this logic in the corresponding downstream
>>> kernels.
>>>
>>> Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
>>> ---
>>>  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 42 ++++++++++++++++++++++--
>>>  include/video/samsung_fimd.h             |  4 +++
>>>  2 files changed, 44 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
>>> index c735e53939d8..cb632360c968 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
>>> @@ -109,6 +109,7 @@ struct fimd_driver_data {
>>>  	unsigned int has_dp_clk:1;
>>>  	unsigned int has_hw_trigger:1;
>>>  	unsigned int has_trigger_per_te:1;
>>> +	unsigned int has_bgr_support:1;
>>>  };
>>>  
>>>  static struct fimd_driver_data s3c64xx_fimd_driver_data = {
>>> @@ -138,6 +139,7 @@ static struct fimd_driver_data exynos4_fimd_driver_data = {
>>>  	.lcdblk_bypass_shift = 1,
>>>  	.has_shadowcon = 1,
>>>  	.has_vtsel = 1,
>>> +	.has_bgr_support = 1,
>>>  };
>>>  
>>>  static struct fimd_driver_data exynos5_fimd_driver_data = {
>>> @@ -149,6 +151,7 @@ static struct fimd_driver_data exynos5_fimd_driver_data = {
>>>  	.has_vidoutcon = 1,
>>>  	.has_vtsel = 1,
>>>  	.has_dp_clk = 1,
>>> +	.has_bgr_support = 1,
>>>  };
>>>  
>>>  static struct fimd_driver_data exynos5420_fimd_driver_data = {
>>> @@ -162,6 +165,7 @@ static struct fimd_driver_data exynos5420_fimd_driver_data = {
>>>  	.has_vtsel = 1,
>>>  	.has_mic_bypass = 1,
>>>  	.has_dp_clk = 1,
>>> +	.has_bgr_support = 1,
>>>  };
>>>  
>>>  struct fimd_context {
>>> @@ -226,6 +230,18 @@ static const uint32_t fimd_formats[] = {
>>>  	DRM_FORMAT_ARGB8888,
>>>  };
>>>  
>>> +static const uint32_t fimd_extended_formats[] = {
>>> +	DRM_FORMAT_C8,
>>> +	DRM_FORMAT_XRGB1555,
>>> +	DRM_FORMAT_XBGR1555,
>>> +	DRM_FORMAT_RGB565,
>>> +	DRM_FORMAT_BGR565,
>>> +	DRM_FORMAT_XRGB8888,
>>> +	DRM_FORMAT_XBGR8888,
>>> +	DRM_FORMAT_ARGB8888,
>>> +	DRM_FORMAT_ABGR8888,
>>> +};
>>> +
>>>  static const unsigned int capabilities[WINDOWS_NR] = {
>>>  	0,
>>>  	EXYNOS_DRM_PLANE_CAP_WIN_BLEND | EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
>>> @@ -673,21 +689,25 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
>>>  		val |= WINCONx_BYTSWP;
>>>  		break;
>>>  	case DRM_FORMAT_XRGB1555:
>>> +	case DRM_FORMAT_XBGR1555:
>>>  		val |= WINCON0_BPPMODE_16BPP_1555;
>>>  		val |= WINCONx_HAWSWP;
>>>  		val |= WINCONx_BURSTLEN_16WORD;
>>>  		break;
>>>  	case DRM_FORMAT_RGB565:
>>> +	case DRM_FORMAT_BGR565:
>>>  		val |= WINCON0_BPPMODE_16BPP_565;
>>>  		val |= WINCONx_HAWSWP;
>>>  		val |= WINCONx_BURSTLEN_16WORD;
>>>  		break;
>>>  	case DRM_FORMAT_XRGB8888:
>>> +	case DRM_FORMAT_XBGR8888:
>>>  		val |= WINCON0_BPPMODE_24BPP_888;
>>>  		val |= WINCONx_WSWP;
>>>  		val |= WINCONx_BURSTLEN_16WORD;
>>>  		break;
>>>  	case DRM_FORMAT_ARGB8888:
>>> +	case DRM_FORMAT_ABGR8888:
>>>  	default:
>>>  		val |= WINCON1_BPPMODE_25BPP_A1888;
>>>  		val |= WINCONx_WSWP;
>>> @@ -695,6 +715,18 @@ static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
>>>  		break;
>>>  	}
>>>  
>>> +	switch (pixel_format) {
>>> +	case DRM_FORMAT_XBGR1555:
>>> +	case DRM_FORMAT_XBGR8888:
>>> +	case DRM_FORMAT_ABGR8888:
>>> +	case DRM_FORMAT_BGR565:
>>> +		writel(WIN_RGB_ORDER_REVERSE, ctx->regs + WIN_RGB_ORDER(win));
>>> +		break;
>>> +	default:
>>> +		writel(WIN_RGB_ORDER_FORWARD, ctx->regs + WIN_RGB_ORDER(win));
>>> +		break;
>>> +	}
>>> +
>>>  	/*
>>>  	 * Setting dma-burst to 16Word causes permanent tearing for very small
>>>  	 * buffers, e.g. cursor buffer. Burst Mode switching which based on
>>> @@ -1074,8 +1106,14 @@ static int fimd_bind(struct device *dev, struct device *master, void *data)
>>>  	ctx->drm_dev = drm_dev;
>>>  
>>>  	for (i = 0; i < WINDOWS_NR; i++) {
>>> -		ctx->configs[i].pixel_formats = fimd_formats;
>>> -		ctx->configs[i].num_pixel_formats = ARRAY_SIZE(fimd_formats);
>>> +		if (ctx->driver_data->has_bgr_support) {
>>> +			ctx->configs[i].pixel_formats = fimd_extended_formats;
>>> +			ctx->configs[i].num_pixel_formats = ARRAY_SIZE(fimd_extended_formats);
>>> +		} else {
>>> +			ctx->configs[i].pixel_formats = fimd_formats;
>>> +			ctx->configs[i].num_pixel_formats = ARRAY_SIZE(fimd_formats);
>>> +		}
>>> +
>>>  		ctx->configs[i].zpos = i;
>>>  		ctx->configs[i].type = fimd_win_types[i];
>>>  		ctx->configs[i].capabilities = capabilities[i];
>>> diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
>>> index c4a93ce1de48..e6966d187591 100644
>>> --- a/include/video/samsung_fimd.h
>>> +++ b/include/video/samsung_fimd.h
>>> @@ -476,6 +476,10 @@
>>>   * 1111		-none-	 -none-   -none-   -none-    -none-
>>>  */
>>>  
>>> +#define WIN_RGB_ORDER(_win)			(0x2020 + ((_win) * 4))
>>> +#define WIN_RGB_ORDER_FORWARD			(0 << 11)
>>> +#define WIN_RGB_ORDER_REVERSE			(1 << 11)
>>> +
>>>  /* FIMD Version 8 register offset definitions */
>>>  #define FIMD_V8_VIDTCON0	0x20010
>>>  #define FIMD_V8_VIDTCON1	0x20014
> 
