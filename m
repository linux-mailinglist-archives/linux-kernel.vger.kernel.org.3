Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D014346E378
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhLIHtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhLIHta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:49:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE8BC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 23:45:57 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 8so4680344pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 23:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S6sljBlTTFv4LyM3w/XYfSB/y8cuCgv6qRRvYOM58bo=;
        b=bTTq3Fc8zqIWiPIv0qyowDZ02fTob/teqhwg5s1M+8upNrw6f6A7/H7BhIbjGTUI3i
         9O7uP9Q7vqtDuY7xp/fO3yVuxhfr3MYcVYj03X5KVsGH1K+jQIPHILMrAccfL97yn8Fe
         LtCjk9Gk+6VOiX1Pb1bjQlFNDukElregC8rqGEIFwpf3LAEcZ4bPyaGajNz7C1hF/fex
         GB4JfcFWKklvnpig+PJ3WswnxelColuNpVWC+ifWgRlWFhoDTu4QoEKooD/3e4AJTFkq
         cMuX+ZfNLjLAhWhRmWHTeyNyXJ+taEpl9uvVvktx7gBZBvrScpxmsNM2zgP/u9B9bD/T
         Rx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S6sljBlTTFv4LyM3w/XYfSB/y8cuCgv6qRRvYOM58bo=;
        b=R7nQkeXXylkd/MwF9K57hqKNxIEeCUQA6i0aSmHD+JDfC+UylENRBS63ILlzNdKNCP
         BnXAfG+Vfzbwnwhpo8G0q6k89WLVl/bgcn1Gehm9xfDL2DYGmC8ReGMnmm5Q4RG9lkeJ
         2eBPXt9e2oaPIcaosWk3uaUUa+hmqJWgwL+znI+vSvX/FIlPJPPzhjqtrBon4Sq67uCq
         pEQufgfGO3KIkgat6YhaI6vKyp2/whprG/gB6VMZnUdmIo97Tz67x8orrAW4RdFdHcB3
         3IOyIWgRU+sXkmdkqs3w4rR7VSAYsuOiDzhqCcQeuTf8wabmA6tqIT+nshzM7qkrrhGY
         zX6A==
X-Gm-Message-State: AOAM533iVurU/a3kRHDepGH3m3ZDhP+mRJXdPsEdDAoRHxneoCcKOKn/
        IMdr7ILKyKUZqoKOoYGAAUNwdQ==
X-Google-Smtp-Source: ABdhPJy4vLVK4vNJiSv25VuTqdUwuEzS7XUOtNkjDw/CRuoa3MUT3oLkzCtaNr74NgLOMeqWqbReOw==
X-Received: by 2002:a63:2b03:: with SMTP id r3mr32170691pgr.328.1639035956433;
        Wed, 08 Dec 2021 23:45:56 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:636e:d54:3de7:fbc7])
        by smtp.gmail.com with ESMTPSA id a23sm4571889pgh.35.2021.12.08.23.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 23:45:56 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:45:53 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        trevor.wu@mediatek.com, yc.hung@mediatek.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: mediatek: assign correct type to argument
Message-ID: <YbG0MRKHi0VrYD1A@google.com>
References: <20211209073224.21793-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209073224.21793-1-jiaxin.yu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:32:24PM +0800, Jiaxin Yu wrote:
> Fix the following sparse warning: (new ones prefixed by >>)
> >> sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33:
>      sparse: sparse: incorrect type in argument 3 (different base types)
>    sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse:
>      expected unsigned int to
>    sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse:
>      got restricted snd_pcm_format_t [usertype]
> 
> Correct discription of format, use S32_LE and S24_LE to distinguish the
> different 32bit.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
