Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DB24A859E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350936AbiBCN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiBCN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:58:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36395C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 05:58:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id z19so6073963lfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 05:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J5ajnrFHB2Itynjvb8zArw+50BJi/x0Eej9kTRNExuQ=;
        b=hPwDZRyjA9txtxuG+5/cTuFGbSUc2fcWxGgS1ejgy07ob3tcGH200w0Aqj/q3x4Dl7
         lc+zXOvZQyLgh/xP+nnIe/dnJfaTWhwTG20PXsa5Z2Z9/BN3qtCE/unCOC4VVpxk95ti
         xdf88IG+x3gl9AbrSHVKgvcMv2MEJXxiE83DIDneZINppKaHKkG7fbVGchzlYl6i/9Aj
         Jb8P9TTHKKlT2PVJhhehQa7RQgeZXwn+VHMugpK3TSyuu1DMLJ+LbKlOKgZVaqagVQpK
         ASks1OPp9LZga9EhyfU+9cqxsW3pmMgl5tqJO4xjcVRJSN8suWjxwx95+JQUDz7RXx+n
         9bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J5ajnrFHB2Itynjvb8zArw+50BJi/x0Eej9kTRNExuQ=;
        b=W1PsK0Tqzde+lhoJdH0DCUSF3B+1bxDKCuQwfULa/zM25NCo3eBwfb29DyJGesVOfZ
         39Z9BW60UFC+DY+M8P6CxAiHDm47y6Xbs1ZxpV/SBpU2jrBrKMuODVrO92hPyutDvWZR
         jp1+ZTFW7NvrUyMVgbchOsjBv6tiIfYebiwPGTzPGzpn2S1mFMWj1tjerWQwNo3apAG8
         HQ0avFiBWdK1dYr/UeVvf72BxWhh+xmi/wmjQQ61suzPyT1FzTJ53fcLXMjH6SIpy6Ar
         oem1AraLV9ArqaugaeBYKN7vY04+Nk9RiLO4JE9izldIRQMRSaKejsaoqk+fxfrB572v
         KSFQ==
X-Gm-Message-State: AOAM530brkGsG6Av7g/TypjFqyMohdnXE/61alBLP+b1uIufXhvg34ZP
        2wN0nfe8aufRQDZMqlpasPE=
X-Google-Smtp-Source: ABdhPJyuhFv/OFce48B1/qo4kUyUlmpXlBHEkqfwAjcb3ui8pvzKNu1ezVfGSF/a/3pLJdY7P0XJyQ==
X-Received: by 2002:a05:6512:33cf:: with SMTP id d15mr26471232lfg.544.1643896701426;
        Thu, 03 Feb 2022 05:58:21 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id z15sm3532246ljm.64.2022.02.03.05.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 05:58:20 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 8602A5A0020; Thu,  3 Feb 2022 16:58:19 +0300 (MSK)
Date:   Thu, 3 Feb 2022 16:58:19 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] kcmp: Comment get_file_raw_ptr() RCU usage
Message-ID: <Yfvfe+TmR1WIuj/U@grain>
References: <20220203133134.6949-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203133134.6949-1-jandryuk@gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 08:31:34AM -0500, Jason Andryuk wrote:
> This usage of RCU appears wrong since the pointer is passed outside the
> RCU region.  However, it is only used as a number and not dereferenced,
> so it is okay.  Leave a comment for the next reader.
> 
> Without a reference, these comparisons are racy, but even with their use
> inside an RCU region, the result could go stale.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Looks ok to me, thanks a lot! I should put somthing similar a way
earlier when this code been developed. I must confess I'm not a big
fan of merging comments-only commits (since they affect git history),
but since it brings more understanding into what the code is doing

Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>
