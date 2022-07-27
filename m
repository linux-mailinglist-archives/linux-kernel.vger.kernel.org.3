Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6111D581CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbiG0BBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiG0BBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:01:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80F826104
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:01:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q16so14596805pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ybnW84+9fU0djWw7Bzv1kh+nG/qx0MoaGmMNsPV0veo=;
        b=WF1CTk1SsbSN+7ulkJSfQJzUJ62LNFcU3ifvQIRKrzsZ8Nrh4BFayFyNIiBP34UKkq
         bpzsjrUiLSAmvh/WvtMz2vkmUMmTvzOryOrgxwWq4BWg0zOc+p+qhdEPX7QFNwUU0v12
         64X+IgI3MxPbKM/PEOzJ0i0WoudvOqngUQ0+wwT+KbCmjU6X8PwekS+OUCfcT644UmCS
         DQqGUsQ+DQbSoYM7A+X3/DhjAy/vmWU4bo7qyzENfK48DxLT5tGm7AlC10Oeg2ApALgd
         hUfoD+sAbpS/k8uygttfiBkiqMcJdVmqarxyuaWdLrG1DGbe+ej+fE6AB9FLGtrcn2q3
         ngbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ybnW84+9fU0djWw7Bzv1kh+nG/qx0MoaGmMNsPV0veo=;
        b=Q/qkVcIscDc1Q5MRfxgsdihc64Eu+24d+saNo+0aN9UFJsGZC0HeU8bPDK8LCL1b0z
         DKksWQFGtsE0Ms5/loJQQceHRb127+wgGWLmehmHxFuzz9bj9RYQyFZQyv9fcyfiGvK0
         0lU69BYj+Eio+/hWcvbsj1cq9R/7gpMvZRoUnvat/5M/nXPOw5tbRgC5mbnIgkPWob4h
         3eDctpgi6uW9oy8W1S7AfURdlWEF953XnBAdXPJd55udKKLoDxXk32HCZ0m5ybCSUE6O
         3KJjezmwEMwTBUy/+SMF5WxlYy/o/WhJZerDAo1f51mrb4wbhKEknf6pNTmw6KzBPKSI
         Id/w==
X-Gm-Message-State: AJIora8p34q+azNoZxP9em60/bRYjTwL8hwhd/zwq0XAKwgW3DAbaR7M
        l1ywMWq7iB3f4COWq1v5iw1xeWgXfKUXMCueEGY=
X-Google-Smtp-Source: AGRyM1sTpO3gAdvfQvGquMPitWW6Cw68KBvDTWmxOQJpaD6f0bjztwZCe/tSBWJo92n5W2IN4Hm/wqK/Lia7vW/aG1Q=
X-Received: by 2002:a65:49c8:0:b0:41a:eb36:d1a7 with SMTP id
 t8-20020a6549c8000000b0041aeb36d1a7mr11083365pgs.66.1658883695238; Tue, 26
 Jul 2022 18:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <1658804705-16996-1-git-send-email-liuxp11@chinatelecom.cn>
In-Reply-To: <1658804705-16996-1-git-send-email-liuxp11@chinatelecom.cn>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 27 Jul 2022 06:31:23 +0530
Message-ID: <CAFqt6zabgY6DgCQBe0HCsMYScNEnKbm-0nH4ghhALZpF14rm4g@mail.gmail.com>
Subject: Re: [PATCH] memblock tests: compiling error
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     Mike Rapoport <rppt@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 8:35 AM Liu Xinpeng <liuxp11@chinatelecom.cn> wrote:
>
> memblock.o: In function `memblock_find_in_range.constprop.9':
> memblock.c:(.text+0x4651): undefined reference to `pr_warn_ratelimited'
> memblock.o: In function `memblock_mark_mirror':
> memblock.c:(.text+0x7171): undefined reference to `mirrored_kernelcore'
>

what is the steps to hit this compile error ?

> Fixs: 902c2d91582 ("memblock: Disable mirror feature if kernelcore is not
> specified")
> Fixs: 14d9a675fd0 ("mm: Ratelimited mirrored memory related warning")
>
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
> ---
>  tools/testing/memblock/internal.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
> index c2a492c..cf67e6e 100644
> --- a/tools/testing/memblock/internal.h
> +++ b/tools/testing/memblock/internal.h
> @@ -9,6 +9,9 @@
>  static int memblock_debug = 1;
>  #endif
>
> +#define pr_warn_ratelimited(fmt, ...)    printf(fmt, ##__VA_ARGS__);
> +
> +bool mirrored_kernelcore = false;
>  struct page {};
>
>  void memblock_free_pages(struct page *page, unsigned long pfn,
> --
> 1.8.3.1
>
>
