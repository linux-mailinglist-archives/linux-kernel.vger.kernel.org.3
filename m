Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE4584529
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiG1RpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiG1RpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:45:17 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA14222A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:45:16 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l24so1892218ion.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XMhsccwz/nLMW9ck/oyxCfFkSihYBvdOAxkZvBNHpi4=;
        b=FgteHhN+UJrhX3e715BQO771QNANiL+OCQOxJF/s70uTOF5Wgi2t6xG8cKDcp9QAlR
         15fV2neoyV7NdyYmRrwkh7WRQt1hcYOjg+OjegKXZvDi57n4wWC1f9Sg3kqaghsmuNs0
         ojfcedpRNtxDOE2fJxBQhyI7SRyn3YYUElz98KgDtRz9gpNAfHxFetaUkMi70saSfMfM
         ckPkdVQTPgq3O87cEudHt0rKyZ5YuVGobreOClX/kZx8IgD+hZJXiK+sa56wN0Bcnj7M
         9srZ265QQgNP9BGTCdtnsdSQPN0MHyK4MHr/EIkucRaB9y4u9z+SjCDvjH8NTwqZuYjG
         phHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XMhsccwz/nLMW9ck/oyxCfFkSihYBvdOAxkZvBNHpi4=;
        b=aKO47TBfGnkEznMvOUtTHgIvvZuCqvrRUvc2Hsv5kGbkBucMj6MSL+rgj345Ao3wx+
         ScTag2b7jJtO3dL8iAD0yyRiCDy/LSCQ3L2t+OPqcZpptIzfrg2ZgCG/zNlsyxNCNF5I
         kDzEJxSml1j9zAPk6S/ybZWHeHWgRVrGG03fchg3ZvSIf/EH7ynG+Sl9qX574sBi9t6a
         FYd9gaYzMzmDzF5IX8RJVvjZJYUdoeDsdZ6Aq4JhufhHXWm4GJzEsLl559izqcJ9IZaM
         swlfbI8tlNsVINiqXHdY7Z9sKhitPGal9c0EWVISesIIbYlWYaAZ6NvPKlzbn1WSDCjU
         d+cA==
X-Gm-Message-State: AJIora/2+FYX3Qj8EsDioYsfUOOxfz2c6wn95I1uxiE/7gayncac7eFh
        +NLWxWl8J9AdVfmxQuAReJEsgd3oAShQ8ffTQjXBgK6R+oo=
X-Google-Smtp-Source: AGRyM1tKsPD+fwJsMF2gN/B1ml1GbMUf7LmbxqNifxEDAdHr7YyUOsf7hqZ6/HAQA6Y2/FkgW+83t1/cXvBkwnXNVjc=
X-Received: by 2002:a05:6638:2391:b0:341:48b3:29c5 with SMTP id
 q17-20020a056638239100b0034148b329c5mr10950354jat.293.1659030315872; Thu, 28
 Jul 2022 10:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220728121949.20985-1-linmiaohe@huawei.com> <20220728121949.20985-3-linmiaohe@huawei.com>
In-Reply-To: <20220728121949.20985-3-linmiaohe@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 28 Jul 2022 10:45:04 -0700
Message-ID: <CAHS8izNM8aPdus_EVygtug+8b6CUNozz_se+mpqRe7SUZEcOwQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] hugetlb_cgroup: remove unneeded header file
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 5:20 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The header file slab.h is unneeded now. Remove it.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/hugetlb_cgroup.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index d16eb00c947d..99e9a367e1e5 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -19,7 +19,6 @@
>
>  #include <linux/cgroup.h>
>  #include <linux/page_counter.h>
> -#include <linux/slab.h>
>  #include <linux/hugetlb.h>
>  #include <linux/hugetlb_cgroup.h>
>
> --
> 2.23.0
>
