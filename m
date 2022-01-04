Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5793483D41
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiADHxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiADHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:53:21 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D67C061761;
        Mon,  3 Jan 2022 23:53:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so1298185pjl.0;
        Mon, 03 Jan 2022 23:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yfmsxVwIeHzReYZYAuXrHEPSnFq8YqvOzxGd1jc1pgE=;
        b=mhVXLBrnJ5mz4AAh89cglgwMJRKGk94+Zf3Z7skwSEQ2yiO4oB85IUVFFmvjb12q8e
         tLFfk1tYPJ/mc84ICY0aNfV2UL6Oims2XFlzWPy80vwx5SV+vEa4a6YK46OUASKNSnv+
         47xinofnb/Qxt5EddAoq6Duhmf9j3ZslBG2JASSnG7tcUBd2a0phfBGl3T+ZyHt4XjA1
         qB1yaIDuLlOAMReH7G00Lws7/vyTYTY1tXoBtWtYX6LNEVX0KhICKz9PaICYMRXXXaU3
         r5f3O0a9wSMDA+dQbK+5WOBpaoZFDmgMp+9iSy4XxxzyPzqO5BpeoYywxlUHpyf82S4/
         o+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yfmsxVwIeHzReYZYAuXrHEPSnFq8YqvOzxGd1jc1pgE=;
        b=fZp3Y8QQ/FryzIeRFGZrnXZ01r46mFp0MufgP3pRdut1F0lJQzVthevj5uuucVOzpX
         iIj8507TUNzKLq1JimgItnoVpAU9HjDAJ1jZO2TMVWgtzUzj/TuxPKPYMuRGD4q3drGO
         uOHQIrTTjxgws8Q2tiqSZHTiK3vy1TroPhiiXcPq4djcv9uIxnBFm66ZvjVF2Me1JUJo
         SH4EyM/W84NGV63DVa7yk8O2Vq/I6X4degxNvDn5CyJ3Xnjsl1jnqCM5SPuQwhEaLmII
         J0WIkUJ7TP85XpIU8dcaklZ5AnER/XeoYjso3rKvYKaYxxNKTmTBp8MGKL0TlTo3jp1s
         6Shg==
X-Gm-Message-State: AOAM53310zY0OaOpnmkTBEI21A2usEGzmKv10GvOIcfKASYcFVhmlVCu
        fFRcVSlengZy8QYzj5hLfqM=
X-Google-Smtp-Source: ABdhPJygFGFfdQBdf8MfkznSw7yHtZqAwT5o0FZ9IemaLgQ5L0Byiauo/IQ+E8oOAe9odzJjlJwdaw==
X-Received: by 2002:a17:902:bb8c:b0:149:8f60:a526 with SMTP id m12-20020a170902bb8c00b001498f60a526mr31659967pls.25.1641282800842;
        Mon, 03 Jan 2022 23:53:20 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e7sm21070512pfv.9.2022.01.03.23.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 23:53:20 -0800 (PST)
Subject: Re: make pdfdocs fails on Debian stable
To:     Christoph Hellwig <hch@lst.de>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
References: <20220104064708.GA15446@lst.de>
 <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com>
 <20220104073625.GA16910@lst.de>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <df9183cc-aecb-6b8d-0580-92c2a678d69f@gmail.com>
Date:   Tue, 4 Jan 2022 16:53:15 +0900
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

Hmm, I can't reproduce this on docs-next.
On which tree are you building RCU.pdf?

        Thanks, Akira

