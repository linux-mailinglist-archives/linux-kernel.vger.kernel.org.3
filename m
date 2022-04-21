Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A985550A4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390320AbiDUPvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390302AbiDUPv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:51:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649F51AF2A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:48:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id s18so11009683ejr.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99zPGQDcBvB2eneXnR+UDPkr2FlkHpg0OSrd18ZV4Fg=;
        b=VLywufJWMlVFxqcfNnZ5LLc0KyAM4UcVKWw+3U/dmyzmkYUl66eNLXln+J8wdYeFib
         TFyQctG/3jB/BbqgBgIkmvyVe+j+kUwysGydwnvXU5g4OFlIiLrRR8CbwW/1kcOqrDS+
         k0cjhjdEuKA9oz6o6ZI4+lhEkSrErxxRSEcNrzW34RIWL52UoIMChNYDRaHpCNE9iMIV
         60vSWFF+QCw7DM/nHF6PHQih9JoZHz7nKTTuQuC2JzA1lYWsULBpVaziblXAfpywWIj6
         7dnAXZKJS1yem3+vHGn6UQEIyt4JSgqGoBuYdFziAgX7DDF3NJAd76xP+qrOxF4jsiZD
         kJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99zPGQDcBvB2eneXnR+UDPkr2FlkHpg0OSrd18ZV4Fg=;
        b=Ha2Dyc4OBQ9hutuCyFNOr/WeQDeIcYv0EwEf+8Rc71uf3CkPbUiRXHsIVHrPztuDV8
         k9dGaHzA5sOMWQ1RIKa9gBvhjV6W8bgfi9PnZ+4ELxoB1ez2ifqiX7c1JGC4O6+xMcpM
         510P8RezuWwQZ2RDOhqA4GT6aM/Ye5csNpiozcfW9/OcV+nrUw1vT0HlxqkgeduNgUz0
         k6BG8qIxdFwJ7gYvb+BEydC0ZRwH+iEXNlVHa+MWvjbERix7CUxMl/q6YmmGHIxiCCCy
         LpIy5tLLQTWe0ZKxH9IzbnYhZTbb/jmnorKeDqSZYiyriySPBRqd5kauED2G0FQgsjFc
         Shlw==
X-Gm-Message-State: AOAM530nN5tC0swClcnxfLwoqR9nrmYhUCTIh2nhdK7X+oSAU2MYWioy
        FEN/RfJ53HoDIFe192dgPr6ptSVJ1jTbdfdqugLph2r3DUxisQ==
X-Google-Smtp-Source: ABdhPJwZmx55dd2ozNjrym2eOBStotYqhCTvy4duFqRmIX0adxyFMMBT3BVbRgBAgiRzqcsobnw2+YrQW3eqbI1gKqU=
X-Received: by 2002:a17:906:1841:b0:6e8:872d:8999 with SMTP id
 w1-20020a170906184100b006e8872d8999mr162746eje.492.1650556113446; Thu, 21 Apr
 2022 08:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220421070631.1273879-1-anshuman.khandual@arm.com>
In-Reply-To: <20220421070631.1273879-1-anshuman.khandual@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 21 Apr 2022 11:47:57 -0400
Message-ID: <CA+CK2bDMqxkzmyaoi8DD7eTRG7bS-6H=U-h_SYRLDy7Y54gOmg@mail.gmail.com>
Subject: Re: [PATCH V2] mm/page_table_check: Drop all redundant EXPORT_SYMBOL()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 3:05 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Function definitions need not be exported via EXPORT_SYMBOL() mechanism. In
> this case these functions just get called only inside their wrappers. Even
> __page_table_check_zero() gets called without such an export. Just drop all
> these redundant EXPORT_SYMBOL().
>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha

> ---
> This applies on v5.18-rc3
>
> Changes in V2:
>
> - Restored EXPORT_SYMBOL for __page_table_check_pte_set() per Pasha
>
>  mm/page_table_check.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 2458281bff89..627c5025d786 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -167,7 +167,6 @@ void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
>                                        PAGE_SIZE >> PAGE_SHIFT);
>         }
>  }
> -EXPORT_SYMBOL(__page_table_check_pte_clear);
>
>  void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
>                                   pmd_t pmd)
> @@ -180,7 +179,6 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
>                                        PMD_PAGE_SIZE >> PAGE_SHIFT);
>         }
>  }
> -EXPORT_SYMBOL(__page_table_check_pmd_clear);
>
>  void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>                                   pud_t pud)
> @@ -193,7 +191,6 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>                                        PUD_PAGE_SIZE >> PAGE_SHIFT);
>         }
>  }
> -EXPORT_SYMBOL(__page_table_check_pud_clear);
>
>  void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
>                                 pte_t *ptep, pte_t pte)
> @@ -223,7 +220,6 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
>                                      pmd_write(pmd));
>         }
>  }
> -EXPORT_SYMBOL(__page_table_check_pmd_set);
>
>  void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
>                                 pud_t *pudp, pud_t pud)
> @@ -238,7 +234,6 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
>                                      pud_write(pud));
>         }
>  }
> -EXPORT_SYMBOL(__page_table_check_pud_set);
>
>  void __page_table_check_pte_clear_range(struct mm_struct *mm,
>                                         unsigned long addr,
> --
> 2.20.1
>
