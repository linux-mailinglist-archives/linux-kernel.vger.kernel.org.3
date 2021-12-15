Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3BE476179
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbhLOTRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbhLOTRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:17:41 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41FBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:17:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso12105pjf.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MpRIgCk4ZJFF/gJ1HZ9vdVtdls/QLNUpGwB7jCQSxBw=;
        b=Uv+JuA27vFuhLd999/sNMMjAcYN5ZKNg+NcPZi4IQZmlR7NmiI07/NjTkoML9ICt0J
         erOe5NfO0cDBsejWpmdJj5Z0Qb4QWD6ixKdbRGkfHbb4WwXaGx8LmQOtnu0BMwzTRpPn
         8Ps4GO+SWpbfd0MhszStnT3ntE83PeutLQYDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MpRIgCk4ZJFF/gJ1HZ9vdVtdls/QLNUpGwB7jCQSxBw=;
        b=Unh3XEhqnpTaDxO6ccvcnDaGfZ3Knx5QeJbonqKDjyLz2mhsB6MjGIOegYz5IZ43Uf
         1YBWx7ZZciPcD23lBlfPn7xGMOBUj+72f6yMa+/TXQb6cu50cJnRQPCXjiPR39CG0ARB
         xTSE0O1xWhHw1Z4epuiak3auYoOXZy/gzGcOXzHKbVYhEfTJn++RDamcuk5ExlxKyqaP
         PeDdzKpjNHxXLHKfjbcxIn3yNRbllcWobnIJtHYvLFRjsIyE3ow+IEKS2uQqFOK0WLHH
         xaWPVtIJWjQzC9WTcJy+0SCw0T26MnzFzcQRbrEeiEkfcZyMulDcNill9iB/ZHr9dP1Q
         UYnA==
X-Gm-Message-State: AOAM530YNAapHbfGqMAjhwB55slC1mNdcRWrdOEyshLeP0CwhFVabu4v
        QM6W+ZqRvItvcC2Jj/3OiDErXQ==
X-Google-Smtp-Source: ABdhPJxQqy4FmTEIwI7XqlNswZgdMWatFHXVHSW2fc4GQRSVKmKS29lary1WxSUz/TQYr33z2muoxA==
X-Received: by 2002:a17:902:f54f:b0:148:a2e8:276c with SMTP id h15-20020a170902f54f00b00148a2e8276cmr5725798plf.115.1639595861348;
        Wed, 15 Dec 2021 11:17:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j1sm3700060pfu.47.2021.12.15.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:17:41 -0800 (PST)
Date:   Wed, 15 Dec 2021 11:17:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Joe Perches <joe@perches.com>,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH] arc: Replace lkml.org links with lore
Message-ID: <202112151117.804C398D1@keescook>
References: <20210210232849.1358703-1-keescook@chromium.org>
 <8d0dd35a-4bc2-6762-3ae9-a0bf38961f5a@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d0dd35a-4bc2-6762-3ae9-a0bf38961f5a@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:03:54PM -0800, Vineet Gupta wrote:
> On 2/10/21 3:28 PM, Kees Cook wrote:
> > As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> > links with lore"), replace lkml.org links with lore to better use a
> > single source that's more likely to stay available long-term.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: Vineet Gupta <vgupta@synopsys.com>
> 
> Let me know if you want me to pick this up.

Hi!

Oops, sorry, I never replied to this. Yes, can you pick this up please?

Thanks!

-Kees

-- 
Kees Cook
