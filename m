Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52614842C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiADNrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiADNrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:47:01 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F07C061761;
        Tue,  4 Jan 2022 05:47:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h1so23910257pls.11;
        Tue, 04 Jan 2022 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQOF5vS3HBSUhcL77hQkVBmz3ZXM6pBjrfqG+fc93jE=;
        b=c2n1Ki/0YbiVQ2MCdIgW5bxS1ZjKWf+dz6YC/ygYqy8+A5HWKZ0ZS8GmFqYwOu97j1
         iynZJndQPvzFMZH9HG00nPf2yErP3QMtFeSzDgYhfp0YOIpB5ix4Xvot0/mzALEeBouY
         mQtXuhvr6EREh9ksqZSY5Tj8NVeCO7tbGJewLyL3adovmxCNLgmIRxiCJ7OWeDbd2UWW
         2N/hJokjQT0P64UCnDsKM1yCXSsFDA+ROqy5DSi4vmN8O228cSVDkj2EXWG5u9vjiBLZ
         khjpXVehavz5ElVvmUENbBuBHQPQF+VkJ3IXE1Q95klQQFK7CaB4/IJkyL7c8aOCNmo1
         UdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQOF5vS3HBSUhcL77hQkVBmz3ZXM6pBjrfqG+fc93jE=;
        b=dyJFnLG2pF0l5F6P32pRUOeP2+9qNF3k6pS1NlHDP+eHYp+q1Yk2GuD1nfV28h2C67
         AJkqFYOtOTxjVuFcAjquPoYSvsZqMt6gujkZDvJcz4G4wkClSZH+JA+vbwoqar1cg1iJ
         9taf1kGsPGSxZbXuS6QbL0ocMIhKoKEwGUbvYR1kfITijsRXkCfnqH9c6FKUhjw7Dqwg
         QW+G1Gfvnf4KXyfIRmRsWE6NRon+6cEeY9q45g1xID9OZceNOShmEw94KAaLqdRIrKJ/
         Fnw+3ZcXBPdLB4fwAvCDmVG8GSrdL9X4tUBuiJPArR665QybtiwsF00yJTLd+lNY5XFw
         qq5A==
X-Gm-Message-State: AOAM532tMRGa3onhwgx/la7N77GVNuix61A52lZimIY3rjQ8giEH9U0r
        CNPPb9dYDWNtIMEVEEBL7GJLDs6hFyo=
X-Google-Smtp-Source: ABdhPJxp3RuXRNKMOIcyykDW0s8eShR0vdvg5w0hvKYHvKjxriFVnwkOPKvfp/JNqEE23KkWd0yElg==
X-Received: by 2002:a17:90a:cc1:: with SMTP id 1mr22715575pjt.124.1641304021059;
        Tue, 04 Jan 2022 05:47:01 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l11sm8744456pfu.115.2022.01.04.05.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 05:47:00 -0800 (PST)
Subject: Re: make pdfdocs fails on Debian stable
To:     Christoph Hellwig <hch@lst.de>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
References: <20220104064708.GA15446@lst.de>
 <8f21b702-abc2-c9aa-7593-9aff17e61ed1@gmail.com>
 <20220104073625.GA16910@lst.de>
 <02f6aa77-17b7-ed23-8f39-34239ec6e724@gmail.com>
 <20220104131952.GA21933@lst.de>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <2fb003aa-545c-31a4-1466-8c3c3fc708fb@gmail.com>
Date:   Tue, 4 Jan 2022 22:46:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104131952.GA21933@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 14:19:52 +0100, Christoph Hellwig wrote:
> On Tue, Jan 04, 2022 at 06:31:01PM +0900, Akira Yokosawa wrote:
>> Hi, getting back to the error message, I remember seeing a similar error
>> when I failed to permit PDF output of ImageMagick.
>>
>> What I did back then was this (as root):
>>
>>  # cd /etc/ImageMagick-6  
>>  # sed -i 's+policy domain="coder" rights="none" pattern="PDF"+policy domain="coder" rights="read|write" pattern="PDF"+' policy.xml ; \
>>
>> In case this resolves your issue.
> 
> I've definitively seen permission denied errors earlier in the (rather
> noisy) build log.  But I absolutely do not feel comfortable changing
> global security policies for a kernel build, especially for something
> like ImageMagic that had its fair share of security issues.  Is there any
> way to side step this by using a different tool?
> 

See my pending patch set at:

    https://lore.kernel.org/linux-doc/e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com
    [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF

This uses Inkscape if it is available instead of ImageMagick.
No imagemagick nor librsvg2-bin is required.
As long as if you can trust Inkscape...

Good luck!

        Thanks, Akira
