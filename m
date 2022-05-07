Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD4D51E579
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383609AbiEGIKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377200AbiEGIKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:10:44 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFFA36148
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 01:06:57 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t13so7912985pgn.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 01:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7mXcdOugvS2QGIiWec5ev758mbqvJnQpjgbeQ1iyVD8=;
        b=Q/KdO6FwaVDvPfl/RlvQ1lDhko5sCJTfQrMGOz5AHfJNL13H/F3AgLYVlJwF5Qm8OB
         5wwUyWHMkl7bUoP/9siCIrxQLf0dD4FU1CLM0kI0xcVjznEoAySXTbgTqR862tXg8B+z
         NEJfPbuxUJx1q/T+K2EomZqDZi9k+e3S+1Xc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mXcdOugvS2QGIiWec5ev758mbqvJnQpjgbeQ1iyVD8=;
        b=Lv5AgQtHhgKF8oH1O1d/hsGseTb81v/7ZEF7lbTSjKl2sz7o9zO9IErWlLPJwdGVAO
         QHCgprIQKVTOD5lpQtUHtoXEFKEUXfj9d5laJMJnemoQl1vefd1tMdbQajyZNWF+SzxG
         7ticafnWXZT0LHVjtyrKioDfHjwzrhdhL9pHdeyh99kT5cI5S7R4+M/Pg00Ob+yHzeCA
         jm2tFQfpcCDWwJIX63SbEkBYsf9zP4S4tSnG9tR/Kw9W6Hmn44r0tvoi9j8LHziZEvYG
         kz1Aiptuz4DK8sXFHtRzRaVFcTaaVysaIOAjSIcwV02kv8Z6cZlh/+LT9gEWZQd8u6fL
         63Eg==
X-Gm-Message-State: AOAM533i2SzZbsZar2HNoPVaebcj+Q+VMPK6NIZJ6fpQbyQaSU/v3mkx
        C7MMHjti6q3oIcxavk45RLitaA==
X-Google-Smtp-Source: ABdhPJxSruKTMm4cbJOoCYHD6srxtd6JM5F1DbeM/heJwHm2znVHf0vCTHdWos7r8EEnwZXdTtoNhg==
X-Received: by 2002:a05:6a00:1590:b0:50d:f473:c346 with SMTP id u16-20020a056a00159000b0050df473c346mr7436177pfk.27.1651910817067;
        Sat, 07 May 2022 01:06:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ng17-20020a17090b1a9100b001da160621d1sm4958072pjb.45.2022.05.07.01.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:06:56 -0700 (PDT)
Date:   Sat, 7 May 2022 01:06:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v6 21/23] MAINTAINERS: Rust
Message-ID: <202205070106.36AD025A7C@keescook>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-22-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507052451.12890-22-ojeda@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 07:24:19AM +0200, Miguel Ojeda wrote:
> Miguel, Alex and Wedson will be maintaining the Rust support.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

This is easy to review. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
