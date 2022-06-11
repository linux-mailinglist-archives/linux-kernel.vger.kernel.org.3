Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAFA5474BD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiFKNLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiFKNLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:11:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91347B7EA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 06:11:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so38875pjl.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9lcw6+L9rwWR7Ii67lcFO473GdASBeniK84TeW/0fFk=;
        b=2h23qFVQOs/3gUcklwx1Bo7bP9z1L1GR7MQvE5Kzmob7Y4F20F3yDiI95bBo+XY+FI
         14pxGnSPNp5NhzMRiixib2yZAPd9Y+mpPVSkbR7ivGtiYudo2JLb08LZ+zNeFBjL/Z1U
         hYqsuJ3b97CKrrfHdOYCXGQGbIWiRftgkLt1nJMgJ99gJpWYDLdXNmEjEVwgEW7Q+dmB
         kq6LpfVfNnk/h2tZY9wyMDnXFIq9m6kw2TjmlnuuZS7AaZafu0xAI1ST0C3CP86H7SjM
         pz5FhELkfKuHe25TP+1H/BwmUFcfIGRt65UB/XTbmFglsrBzzbfceLb510d6qjYC59PC
         anHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9lcw6+L9rwWR7Ii67lcFO473GdASBeniK84TeW/0fFk=;
        b=HqgMrb0GYPrZQmrPKF62+JIvNiHF1kxxnfUULvpe3NCFOP37ZvWyrWlB+1PQWalp4C
         Hh/V8NO1dMX8K5GlK34F1H6xRGQ6TyDE6JATNu6jKcitNG6bHUDDDcLXNljOehtGG8WN
         3HZi+uNxIV1JBsegA+ANJOD43BQf7HCQVMzJO82jh1pUq/bInEg9vRhfbQNoC8ejk69S
         vxaybrCjuwEXtkPMrq5Xt+jq/Q1H6siO3I8BJyf08u5LsIsbA6RT+QEccm4veCwBIkYe
         gfia23aFFSAaaVODLrFWrnKH/doQTLymaoEE136NAIB5QXj38jMDuxd2jJ+75SHI/W6Q
         FZjw==
X-Gm-Message-State: AOAM530LQUT27KIH4Tc2uxVaZ4HjO7vnjWrs0iV/hOPHWZ/ByYROSXRZ
        zmBmHTfPf9qbz3/Nn+smTDXq+A==
X-Google-Smtp-Source: ABdhPJxjNqO+yHjwKDsS7pMYTqzvGjVhlT6fW4ccUMAZbUYFHWFDKc2RD3OvohtbbfJsEWGXg0ifaA==
X-Received: by 2002:a17:90a:b894:b0:1e2:d8f8:41e9 with SMTP id o20-20020a17090ab89400b001e2d8f841e9mr5118789pjr.20.1654953067120;
        Sat, 11 Jun 2022 06:11:07 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:b578:d876:f8fd:d57e])
        by smtp.gmail.com with ESMTPSA id q13-20020a17090a68cd00b001e0abbc3a74sm1423092pjj.5.2022.06.11.06.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 06:11:06 -0700 (PDT)
Date:   Sat, 11 Jun 2022 21:11:00 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
Message-ID: <YqSUZMVxrIWMUAEM@FVFYT0MHHV2J.googleapis.com>
References: <20220610101258.75738-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610101258.75738-1-david@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:12:58PM +0200, David Hildenbrand wrote:
> There are certainly a lot more files that partially fall into the memory
> hot(un)plug category, including parts of mm/sparse.c, mm/page_isolation.c
> and mm/page_alloc.c. Let's only add what's almost completely memory
> hot(un)plug related.
> 
> Add myself as reviewer so it's easier for contributors to figure out
> whom to CC.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

You are really awesome. Thank for your work on this.

Acked-by: Muchun Song <songmuchun@bytedance.com>

