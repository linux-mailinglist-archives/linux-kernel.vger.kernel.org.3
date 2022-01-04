Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB31483F32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiADJbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiADJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:31:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27C1C061761;
        Tue,  4 Jan 2022 01:31:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w24so26680751ply.12;
        Tue, 04 Jan 2022 01:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8wSLVbJ788bSEMelyfDlg7YVDiyBwIDDEcwu25/fZFo=;
        b=qeWDEkGEUOMyQ2Gus0WGkOV7Xj5eW7E9/OX975v2yEILkvaFm2FqgTz9bdYwYS4vGq
         JqvlmSCl/442VAuvNd0tkKqJkfqtDx7vO3EBu+6YT4V83qZkO61hz6MSjDFP/7RMggJN
         nSEMqT27UZ8uLBozAPtD/6EKp0GgEReA2OfCNe21vofN3u9M9oE/94hE0XMbv9qKSt6h
         tuSnJ8FTcypIfepHEvMg6HnlQa8qsFE1zgLioiOYSjj9Ym+cemjPLYvN5nDr1vDstZ/6
         njMj515pSauXzo+ddPQuMcNKCAI5WxJGyLhgxf+EMGvamkoDBtklJ9pfY54rMJ6+a38t
         hglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8wSLVbJ788bSEMelyfDlg7YVDiyBwIDDEcwu25/fZFo=;
        b=Zt9MB0bjFSnWKvP8gFtIrI0z4OsDp+WMerVj8PgKE4doVHYN8Db83VEuI6GiSbQNzs
         bQlmi8abSpYl8WIaEKP4tAJCUG6T+bC2M3oHABgnreaZkJG9HSVlPmmq9yY/SSEF+9Cg
         7VerXUWFQcbzkXhaE9D9lN1LZO4TEdxhM/fty8Qb+QxtmTrbYCqyl3P0XxzNEjt6Bsez
         ok1w0Wwa9sG1kY0pFY5xGhAgAC3FAMjvVhYosrzfmorHALw9cPqv6Ur4O8WYSILHfR9K
         wEmNLZNqMIaWeqUA08UA73Kf/yFAwSdfOmO5qZzHbsA5uctnD46bapAZxSyEErxhH4xl
         v0Yw==
X-Gm-Message-State: AOAM531peN+O4uLvDpSir7I0W+c5GF3QEth7R7BB5h1UAxe6ghj4hKmI
        +ufCqtm0TVxuMXd/jjiS0RgevhdhaJk=
X-Google-Smtp-Source: ABdhPJzZoR81j8zpFR8ti1ie+tdCtihatEvBXfCeTZVOYxC4st3/lH3gwawdX9AcwM+pqYsS7iTPdQ==
X-Received: by 2002:a17:902:ced2:b0:148:a3e6:b48d with SMTP id d18-20020a170902ced200b00148a3e6b48dmr48532802plg.103.1641288665316;
        Tue, 04 Jan 2022 01:31:05 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d34sm22016403pgl.16.2022.01.04.01.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 01:31:05 -0800 (PST)
Subject: Re: make pdfdocs fails on Debian stable
To:     Christoph Hellwig <hch@lst.de>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
References: <20220104064708.GA15446@lst.de>
 <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com>
 <20220104073625.GA16910@lst.de>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <02f6aa77-17b7-ed23-8f39-34239ec6e724@gmail.com>
Date:   Tue, 4 Jan 2022 18:31:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104073625.GA16910@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 08:36:25 +0100, Christoph Hellwig wrote:
> On Tue, Jan 04, 2022 at 04:32:14PM +0900, Akira Yokosawa wrote:
>> I suspect you are suffering from corrupt RCU.aux (or whatever other
>> intermediate files xelatex generates).
>>
>> What happens you run
>>
>>     $ make cleandocs
>>
>> before
>>
>>     $ make SPHINXDIRS=RCU LATEXOPTS="-interaction=interactive" pdfdocs
>>
>> ?
> 
> The last lines of that below:
> 
> LaTeX Warning: Float too large for page by 8477.29312pt on input line 10581.
> 
> 
> LaTeX Warning: Hyper reference `Design/Memory-Ordering/Tree-RCU-Memory-Ordering
> :forcing-quiescent-states' on page 104 undefined on input line 10593.
> 
> 
> LaTeX Warning: Float too large for page by 9533.29312pt on input line 11384.
> 
> 
> LaTeX Warning: Hyper reference `Design/Memory-Ordering/Tree-RCU-Memory-Ordering
> :forcing-quiescent-states' on page 104 undefined on input line 11394.
> 
> [104] [105] [106]
> ! Dimension too large.
> \color@b@x ... #3}\kern \fboxsep }\dimen@ \ht \z@ 
>                                                   \advance \dimen@ \fboxsep ...
> l.12718 \end{sphinxVerbatim}
> 
> ? 
> 

Hi, getting back to the error message, I remember seeing a similar error
when I failed to permit PDF output of ImageMagick.

What I did back then was this (as root):

 # cd /etc/ImageMagick-6  
 # sed -i 's+policy domain="coder" rights="none" pattern="PDF"+policy domain="coder" rights="read|write" pattern="PDF"+' policy.xml ; \

In case this resolves your issue.

        Thanks, Akira
