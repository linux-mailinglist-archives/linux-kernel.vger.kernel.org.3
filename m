Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8D24806EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 08:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhL1HMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 02:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbhL1HMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 02:12:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CD5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 23:12:20 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso7400153pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NXYVCRlkl1arj3e8WvF9NDZ27UwRswxMzQ9HSWmcWkI=;
        b=skfkrXnoE6gcXNsZO24JsoWju8VO7ddjO/I2mgv+T/TCep2bZbtmSO1O6ccPFzd5sD
         eFevQpVM1RXH/UkCEKzds05KO+5Kw14kClxop8CYk0tOqi8JG1EZboFb1FRhnmZ46gSx
         njV/5Nc+WWANbyAfOxa0uNzAy4a2qQ93p9JCAUyFVV4Sm/YCLhmuw2UFMPOq/YYslhzn
         lVDGd2co3ae6ImuSAbr8bUHlNJ58xtdeMLBRNgy7xL/ecBfYwcqD53//q2/QyMlWRmQK
         hkYw8wmshBE/+X1bq37jhosbWYqdBFPviHqGqAOqSzvrzYm9T9jQQOT92N7BVJam27Eo
         JvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NXYVCRlkl1arj3e8WvF9NDZ27UwRswxMzQ9HSWmcWkI=;
        b=uqK2YJz3nGSlNflefnSgW+7CpQUtiI/zd1Wl8SqPzaCcMoDkWXHt9cYtqe9S3tRs7q
         5/Lm+LQRkLF06aoBtbqfxwU6c+G9azd34EgQ+G8jPJmKssKecRwlTLrjjk0Fo/XPSEv6
         J9vEHqz+JJOGZnVgKcGqofbVQA4LK5LTT0Vi5kgT3wOGJQYZ2e+AScr7KHq6wNRcxxiS
         UFwhHif1x2LR8A2P2EhCTGavnwFf71sJD9EGXksQbq1Vv0WuouLXxRrHxOK1S0+vo4HH
         vQwQ1un0tBVeWySs7ybGbLuVw0UTI8pCwF9esEO5BptMWaV2M+oW6rlhoncgN2Jg8TSB
         199A==
X-Gm-Message-State: AOAM531FyJIspkWxxTrZu4MzC4yk5GnfBya+VgEsy8w9tUonhioEtR4L
        39QXhTnuHz2ZX+y+KDwQD+ThjUervvWoXQ==
X-Google-Smtp-Source: ABdhPJxgKDjojCITnOzByiXyEFe4d2LD2wr+DhASX8KwbIQB+3HttKHl2m/2SwjrTuCWYzRRF+QSYA==
X-Received: by 2002:a17:90a:5d13:: with SMTP id s19mr25373225pji.117.1640675540049;
        Mon, 27 Dec 2021 23:12:20 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:a817:45ab:1beb:f01a])
        by smtp.gmail.com with ESMTPSA id a4sm21708498pjw.30.2021.12.27.23.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 23:12:19 -0800 (PST)
Date:   Tue, 28 Dec 2021 15:12:16 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jiaxin.yu@mediatek.com,
        shumingf@realtek.com
Subject: Re: [PATCH v2] ASoC: mediatek: mt8195: update control for RT5682
 series
Message-ID: <Ycq40KwY8SxUslXC@google.com>
References: <20211228064821.27865-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228064821.27865-1-trevor.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 02:48:21PM +0800, Trevor Wu wrote:
> Playback pop is observed and the root cause is the reference clock
> provided by MT8195 is diabled before RT5682 finishes the control flow.
> 
> To ensure the reference clock supplied to RT5682 is disabled after RT5682
> finishes all register controls. We replace BCLK with MCLK for RT5682
> reference clock, and makes use of set_bias_level_post to handle MCLK
> which guarantees MCLK is off after all RT5682 register access.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
