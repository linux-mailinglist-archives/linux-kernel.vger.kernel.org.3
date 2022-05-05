Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1E51C517
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381950AbiEEQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiEEQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:29:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE1913D41
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:25:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id r9so4638195pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AMszwqVGUUkRlqT3bH9KZgvoJEDUJqYcdmFvwR43CTQ=;
        b=nqkUAGbObnsBEq0E+RdFzEBv9xuAOfg+/oONK+DfcjkFJ+Lqbk1Lxsyuf4E2dI9W0p
         wL4xpitBmfFa56MgN1186scmSSm3YB/7qrUEctUAW/Fk6aTk2AAkifz9WkeNpn+XaQUH
         SdP5hM0JRdmsjkaCO7o5uz9TiBKRdlWD+/Djg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AMszwqVGUUkRlqT3bH9KZgvoJEDUJqYcdmFvwR43CTQ=;
        b=l+8kk/3jbUYdOEKWWAefkcTGkw9FJYlKPJ5iQi4NWpm2g2eqOT9d2uJKKv4TGWy6q7
         vP+LS2RGXORQGlfc23M+zccJW7Vcfo+Y/PGNe+XVhtpjbW3OcAQQ7I+mHiA64+Why0SJ
         7Ul5+CAC/p2tq+IQyOWrosk8BkjFKwHR2G9qSCebwwmmcf02jreltSKufePcxVuMJVCN
         hU0gacJvb2dzqLfoCi3B+K40CeMXPjzOLV6tHFihvJ9y4ERewXY04KOFzfzTdNB3ttx0
         gSM+cQ0BKY1Duo9WiBXyBT8sZj3TTzzmnp/ybXjS4P4W6fTkC4n4prXWJVI3HtxYFAs+
         B7Tg==
X-Gm-Message-State: AOAM532btAZMPl3LrDQ1Yn7WSLAigEYDxOajBa46TbBi/XRrs+EO6R/G
        3tpU4iCYbQrKgtaI9zEMsK+0dw==
X-Google-Smtp-Source: ABdhPJx6wPVrYHxsa68KRgQKpBYm+86c0ZSHTSAAubzPSZ9HEe2FvIzxPyT8mlJ1clOyQ1w2FcrXkQ==
X-Received: by 2002:a17:903:2312:b0:15e:a6c8:a313 with SMTP id d18-20020a170903231200b0015ea6c8a313mr20672636plh.122.1651767940456;
        Thu, 05 May 2022 09:25:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c23-20020a170902849700b0015e8d4eb287sm1749040plo.209.2022.05.05.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 09:25:40 -0700 (PDT)
Date:   Thu, 5 May 2022 09:25:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [kees:for-next/kspp 21/25] drivers/misc/lkdtm/stackleak.c:17:39:
 error: call to undeclared function 'stackleak_task_low_bound'; ISO C99 and
 later do not support implicit function declarations
Message-ID: <202205050924.7D219E774@keescook>
References: <202205050943.HDgeO9iV-lkp@intel.com>
 <YnPG8dGulGqxMHt6@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnPG8dGulGqxMHt6@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 01:45:37PM +0100, Mark Rutland wrote:
> Hi Kees,
> 
> I hadn't realised the LKDTM STACKLEAK test could be built with
> CONFIG_STACKLEAK=n, and my rework of that depends upon helpers that only exist
> when CONFIG_STACKLEAK=y.
> 
> IMO the test is nonsensical for CONFIG_STACKLEAK=n, and I reckon we should
> either:
> 
> a) Not build the stackleak test at all when CONFIG_STACKLEAK=n
> 
> b) Have a small stub that just logs that CONFIG_STACKLEAK=n and the test is
>    being skipped.
> 
> Do you have any preference between the two?

Since it's looking for a specific poison, it doesn't make sense to look
for this property as magically appearing (where as this kind of thing
sometimes exists for other tests: did the hypervisor block it instead of
the kernel, etc)

So, yeah, I'd wrap it in an ifdef with an else: XFAIL.

-- 
Kees Cook
