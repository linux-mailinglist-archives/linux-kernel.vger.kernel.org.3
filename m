Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6446FC19
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhLJH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbhLJH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:57:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0FC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 23:53:43 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g18so7754148pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 23:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mJmmV17V4GqEpcKpliLXYPaRRnl952JuoJAtDoU5wX8=;
        b=KpGsh35qG074zspucC5/tttr2xImfhgK6xeclO/jIK+uh8oGcuMlU0gctYClhQsyR6
         RHkQne0c7wtceo51mXJZoVZhv55fcYG2K5cXhK51LJc5GBELhcCkkIVftmGwuE3TAG/4
         nWxmgi66cLT6ngZ18NHZLTg9N8Hn7Jtj9ShR8YLPSivpRzpNAHnpymDR1SpdnPGbl/4+
         mYlh5RrAnebcAYHdqGU7kZwCuA4pdlb1+fbpK0hLBzdnlp/w89dI/sNq/9YtJ4tkvksL
         PXHvjva3lYtxFm3lL4vBlpS+SPzyG7VCDqR8k19wrbo3aIUkmgz70YUhaGnwCPxwMyf9
         Yjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJmmV17V4GqEpcKpliLXYPaRRnl952JuoJAtDoU5wX8=;
        b=bUbpCY0CaljVzPfm1A5cht2IrV5tS8ZtQJfWVih9bfreJQOHwgGUUUraDbeOudu88I
         6+fVOjUp8Gn5mfSULjmtldEWVZN9r8TR6NZXFvaSb+Cwv8TvGZTTuf8GqFuk1pkTol8X
         UhwaLejRi//elth6b9xpHi8sFVFNMK88y40PhGVUNWbm3zXpEZmnlRoYZ5Bb7AJqsl+A
         q/wkNCmI7JRhi+KoH5/K1h6+RRUPi5dDl/j7l3plqOCvVhOLHBT6MjsTTmljiBMR3J/q
         LzUTI/YmXOfCsdHj4LNTfbQBUbxQLR++nyIgkRGzBh9pxpta/i1JrZnzfIh6jrBCEbzU
         cPzg==
X-Gm-Message-State: AOAM5329miClM71yattNEfDTiikHiDRrWYyKZmtP6+IiBTXiZ5oGxtq4
        rMvMQV2Sj40H3+5bN6DZXOnw6Q==
X-Google-Smtp-Source: ABdhPJyFZ5NC0bEPoezW7x/sYUWkU2IvA/4QqqzZpR7AeY1ioHFOCiUytzlpI/kl0W13hFp9IqqMiw==
X-Received: by 2002:a63:d354:: with SMTP id u20mr38051850pgi.366.1639122822857;
        Thu, 09 Dec 2021 23:53:42 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:7fdb:7edf:3c09:a8eb])
        by smtp.gmail.com with ESMTPSA id m6sm1446947pfh.87.2021.12.09.23.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 23:53:42 -0800 (PST)
Date:   Fri, 10 Dec 2021 15:53:38 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, nancy.lin@mediatek.com,
        singo.chang@mediatek.com
Subject: Re: [PATCH] mailbox: add control_by_sw for mt8195
Message-ID: <YbMHgkG/MwKNu0v1@google.com>
References: <20211210061138.9943-1-jason-jh.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210061138.9943-1-jason-jh.lin@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 02:11:38PM +0800, jason-jh.lin wrote:
> To make sure the GCE request signal to SPM is not trigger by
> other HW modules and cause suspend premature wake.
> 
> Set 0x7 (the bit 0~2 as 1) to GCE_GCTL_VALUE, to configure the
> request signal control by SW and release the request to SPM.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
