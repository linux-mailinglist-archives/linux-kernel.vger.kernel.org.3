Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DC24F4C90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578867AbiDEXZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443612AbiDEPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:39:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87C613CA2C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:57:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j21so11151062qta.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooVTJG6qHCp0yXAPzRm26+nzLP9pRyshNnyYCdC2/cI=;
        b=IjO1lAYG9dMjEoFuBKubL4solYQl93gBLvk38hPySmUXvALA+uoqB5JW6jq462kv3w
         XAv4VTxdhTe/Ar+F3ht8PctXXH1Z/CEFWL8rIGHVVnKhc8NrYKoeNDSb+gwniYzUwdqy
         cPCbAw7DBwC9H/iGurSWWopq5BX213OioWQjNpms7RtaNWffKommNV11P0techfv+VWq
         jmsl/Xrr/T99SAhsTZABhIAE2rf0H6z4BIeaC/xRBzZudWiZxfRd5sdUll3mUyKzmwBM
         mhubX3e2dDLaS2a/nEk3lBLHP4BdREc3DkUve465WChVkkGjPKvW4m2oQ5IIZOJ7aAL6
         m6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooVTJG6qHCp0yXAPzRm26+nzLP9pRyshNnyYCdC2/cI=;
        b=blDb588nXSl2mSjy5zqLWgFQIU00zpMDYdSbA/seiYPbwVBU2HO964+M3se0CuHyox
         5gpUVlBnj6a4hmRtNwQe619JCY//cASrrg/J7RB03zsjkpq1XlhnlOdpxYeRkcAQWwzo
         vW9h77I8CcfUMuYBValAgfEm5Tyg/zy8SMaj9KLhHuV246nPFIoike9caD/Z0a6LY5CC
         /hgOSMNXN+hQsDrJJ9FiwjlKRlGUuFMkLrt3xRoy1JHKsAm7WfFbBJPrjbfFOIoQFsln
         1WUn3AgcbkeZRgTxGNlrS/7eYyKMtkNk6m6LFcM1y61gTXoIrdWm3AJ3xRwAnJFCaBH6
         O9cw==
X-Gm-Message-State: AOAM531mj0Llp2AG6xsu4rLswF3sidN9X6R8VLZgCa6lIinlvPb6VQUR
        1Ajn6JwjLkME5WEjzHv54yHyYr5AAwQ9P7PF0peqJA==
X-Google-Smtp-Source: ABdhPJyvUqZgngY2xTxFZn28xhxZyEZiZ6UDJJnFxcDrOQUW4IEe+56aagmVfjuPhPAcWrPVD5R+J8V5qHnj4OpopWI=
X-Received: by 2002:ac8:4e52:0:b0:2e1:dad8:5141 with SMTP id
 e18-20020ac84e52000000b002e1dad85141mr3050575qtw.62.1649167033885; Tue, 05
 Apr 2022 06:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220404163436.956875-1-vkoul@kernel.org> <20220404163436.956875-14-vkoul@kernel.org>
In-Reply-To: <20220404163436.956875-14-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 5 Apr 2022 16:57:02 +0300
Message-ID: <CAA8EJprGaix=6q0X4HVb2-yFb1LoF9M7qJE3Vgr5oxZZFp6tFQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/14] drm/msm: Update generated headers
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022 at 19:35, Vinod Koul <vkoul@kernel.org> wrote:
>
> Update headers from mesa commit:
>
>   commit 28ae397be111c37c6ced397e12d453a7695701bd
>   Author: Vinod Koul <vkoul@kernel.org>
>   Date:   Fri Apr 1 16:53:04 2022 +0530
>
>       freedreno/registers: update dsi registers to support dsc
>
>       Display Stream compression (DSC) compresses the display stream in
>       host which is later decoded by panel. This requires addition of 3 new
>       DSI registers to support DSC over DSI.
>
>       Signed-off-by: Vinod Koul <vkoul@kernel.org>
>       Part-of: <https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/14967>
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>  drivers/gpu/drm/msm/dsi/dsi.xml.h | 80 +++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> index 4dee6f0bdda6..d1b2a17b0a66 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> @@ -704,5 +704,85 @@ static inline uint32_t DSI_VERSION_MAJOR(uint32_t val)
>
>  #define REG_DSI_CPHY_MODE_CTRL                                 0x000002d4
>
> +#define REG_DSI_VIDEO_COMPRESSION_MODE_CTRL                    0x0000029c
> +#define DSI_VIDEO_COMPRESSION_MODE_CTRL_WC__MASK               0xffff0000
> +#define DSI_VIDEO_COMPRESSION_MODE_CTRL_WC__SHIFT              16
> +static inline uint32_t DSI_VIDEO_COMPRESSION_MODE_CTRL_WC(uint32_t val)
> +{
> +       return ((val) << DSI_VIDEO_COMPRESSION_MODE_CTRL_WC__SHIFT) & DSI_VIDEO_COMPRESSION_MODE_CTRL_WC__MASK;
> +}
> +#define DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE__MASK         0x00003f00
> +#define DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE__SHIFT                8
> +static inline uint32_t DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE(uint32_t val)
> +{
> +       return ((val) << DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE__SHIFT) & DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE__MASK;
> +}
> +#define DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE__MASK     0x000000c0
> +#define DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE__SHIFT    6
> +static inline uint32_t DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(uint32_t val)
> +{
> +       return ((val) << DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE__SHIFT) & DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE__MASK;
> +}
> +#define DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM__MASK     0x00000030
> +#define DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM__SHIFT    4
> +static inline uint32_t DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(uint32_t val)
> +{
> +       return ((val) << DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM__SHIFT) & DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM__MASK;
> +}
> +#define DSI_VIDEO_COMPRESSION_MODE_CTRL_EN                     0x00000001
> +
> +#define REG_DSI_COMMAND_COMPRESSION_MODE_CTRL                  0x000002a4
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_DATATYPE__MASK       0x3f000000
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_DATATYPE__SHIFT      24
> +static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_DATATYPE(uint32_t val)
> +{
> +       return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_DATATYPE__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_DATATYPE__MASK;
> +}
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_PKT_PER_LINE__MASK   0x00c00000
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_PKT_PER_LINE__SHIFT  22
> +static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_PKT_PER_LINE(uint32_t val)
> +{
> +       return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_PKT_PER_LINE__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_PKT_PER_LINE__MASK;
> +}
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EOL_BYTE_NUM__MASK   0x00300000
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EOL_BYTE_NUM__SHIFT  20
> +static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EOL_BYTE_NUM(uint32_t val)
> +{
> +       return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EOL_BYTE_NUM__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EOL_BYTE_NUM__MASK;
> +}
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM1_EN           0x00010000
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE__MASK       0x00003f00
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE__SHIFT      8
> +static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(uint32_t val)
> +{
> +       return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE__MASK;
> +}
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_PKT_PER_LINE__MASK   0x000000c0
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_PKT_PER_LINE__SHIFT  6
> +static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_PKT_PER_LINE(uint32_t val)
> +{
> +       return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_PKT_PER_LINE__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_PKT_PER_LINE__MASK;
> +}
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EOL_BYTE_NUM__MASK   0x00000030
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EOL_BYTE_NUM__SHIFT  4
> +static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EOL_BYTE_NUM(uint32_t val)
> +{
> +       return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EOL_BYTE_NUM__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EOL_BYTE_NUM__MASK;
> +}
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_EN           0x00000001
> +
> +#define REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2                 0x000002a8
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM1_SLICE_WIDTH__MASK   0xffff0000
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM1_SLICE_WIDTH__SHIFT  16
> +static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM1_SLICE_WIDTH(uint32_t val)
> +{
> +       return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM1_SLICE_WIDTH__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM1_SLICE_WIDTH__MASK;
> +}
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH__MASK   0x0000ffff
> +#define DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH__SHIFT  0
> +static inline uint32_t DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH(uint32_t val)
> +{
> +       return ((val) << DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH__SHIFT) & DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH__MASK;
> +}
>
>  #endif /* DSI_XML */
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
