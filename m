Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997CA582066
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiG0GsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiG0Gro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:47:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E718422DF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:45:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so1232424pjf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z8A+nu3fKA9DO1gA5N1VDoAS7yTnkMRT1Hz7Y/o6t48=;
        b=VqSh4SpKVl0spyLB8zPfJGAOcfzfFCs3jbLcyXO3/F2tkm85k+aERoERxhyGXWhfXH
         9nqyoAyPkSKc1oi1TWwquiU7Co2ZS1ZKMI2EaLanjk3/SM5DuWYWh+ozJl7aVUvPiIsM
         rAD3pBUvokJ2R6s1nQJGCOCZkKoZnR6rJr/D8LHit92Q5iuV6O3inYdM4alsZrsI6yGP
         X58x3EAlgfymsxB+4efln7bTUPw7fP7hSaN9GM27lr8zRUyx8XYAm/B3JUpGWlwKeOz3
         lnkdkqcjRNRi6WwUY8JtVfpP9/z3cAigGfT3RWxiGUFjb8C8ahRrgYmlg7tX0SHvTyqg
         dvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z8A+nu3fKA9DO1gA5N1VDoAS7yTnkMRT1Hz7Y/o6t48=;
        b=D/xAh9aL+ll60X3wRi1JaTCEKNenYf8/S9XgiufsT4rOdaxOZTeVDJ9vfoybfjiIls
         pY9DDmtfq0dgjA2m8yOwSPiM/Fs3JfIjCeiy31uOpQiSm5b81DYyGy2Xg8+5oIzNq/NV
         e373MI1iXqRfoPh4almlARorDGRXnwzVZNhi103mpN2LddMB5Y+xTlOSDzGJb9J3mmcn
         dLEOFkfyI9RcJGQcf8e1k6AVap6L3kSXhgJFRFFaT2STkwS7Xa4OK/WXWrPFX3kAdfOI
         zDYoWgv9DKow8HQVcbVyImgYX4ko1uRaaXXKEWTvlJCFL1L7GQES2EpkzZ7GjENG0s+z
         PT8w==
X-Gm-Message-State: AJIora9MvdRo/Z6IHOsGa6TcTX+lVTmaB+lN/R67UgAjRZGMv9bdTzeY
        DeDoBWuIdGJv1daVqij8U41cjw==
X-Google-Smtp-Source: AGRyM1tuXVBiTOmNHlAo6TBUD8efHtPT6iwmofSElMHotZRQW3B6A87WrugJKf9uOQ7OAZNoTSrhwg==
X-Received: by 2002:a17:90a:2e16:b0:1f2:f54c:c6a0 with SMTP id q22-20020a17090a2e1600b001f2f54cc6a0mr2887732pjd.10.1658904336952;
        Tue, 26 Jul 2022 23:45:36 -0700 (PDT)
Received: from localhost ([2404:9dc0:cd01::3])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902b58c00b0016d88f68dbfsm4776539pls.63.2022.07.26.23.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:45:36 -0700 (PDT)
Date:   Wed, 27 Jul 2022 14:45:32 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] hugetlbfs: cleanup some comments in inode.c
Message-ID: <YuDfDO2y9xK2hkEA@FVFYT0MHHV2J.usts.net>
References: <20220726142918.51693-1-linmiaohe@huawei.com>
 <20220726142918.51693-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726142918.51693-5-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:29:17PM +0800, Miaohe Lin wrote:
> The function generic_file_buffered_read has been renamed to filemap_read
> since commit 87fa0f3eb267 ("mm/filemap: rename generic_file_buffered_read
> to filemap_read"). Update the corresponding comment. And duplicated taken
> in hugetlbfs_fill_super is removed.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
