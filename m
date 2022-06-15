Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F252B54D0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350345AbiFOSRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbiFOSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:17:49 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850AC13F40;
        Wed, 15 Jun 2022 11:17:48 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id i25so3527900oii.7;
        Wed, 15 Jun 2022 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfW4+MFPGYeBUUr9P3m8Mr/ICDd1RbPLolMwpeyHPXw=;
        b=LLXs0L+hC2JKEo/iJb6wyEmAI4PvVxBlb4jdgsUbSFsLQyIxiT5rdaa7Or4WLWzzy6
         oa/AQSOsQvMayo/+fttKFCsn0oIII9lUTBvF3K30555B1FJKxN2x0+G/IE3z0A55ET8J
         UaVLLh86CUGGDO0leJax6pH3QcjdR7xX+3hJBLHav2XAeKAVSwq1x59hmuuEYSZwcbbQ
         aebNjE0CfRLWa9VX7dqAiqTfPe5XXZGZ0pNRzjf0Gou7c6Rq730MSqmnT9+sl9aD5f6y
         yC9yAuZrxwm4V1BkSJxw+fq8GIgdoC3EfYRD5tZPkouZYpFI2wwiwiMkgGxRgygO26im
         pOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfW4+MFPGYeBUUr9P3m8Mr/ICDd1RbPLolMwpeyHPXw=;
        b=DH2HgkCeAbzmjsXCKBxmL/0iMaYO08wNUCNsSs51c3VDCD6tNQx7/UPUgnKGjWlKXg
         IEb3jKPzO0coXLSl7jR+yaSMj3UCswm0FOzHO9+QEstyXzd633SraiR41uRs/SpsdpTW
         E9UibThX56YZabjoJZcmkABW9eEB7w42sakU4SWxIKZao04jyjovkD9h+xxdChfc+d40
         UZ+M+cIeAo/Cc0xltDG5fXDZuVqXfI3XjAScwoWhv4tpIrLingwsP26jiGEXyWX+mP+A
         MoHJ4A/hjfpxHLoHvS/ofXY7DYHf4U7amQF6vGgYw2oXwWKZh9dN0AZMnTkhO8eTEtcX
         +uVA==
X-Gm-Message-State: AJIora90HSnv76B4pnpzPx/cJi8fJEOvbYVg7vo6vQ+v8dtAUlhxzcn2
        pTBVWuR/a6ITdurONG8TBwGFv7kNhdIvzpiu5vg=
X-Google-Smtp-Source: AGRyM1traN0gacOxob9SpEeyGEaRItKOhsSsdeU9jcXCJziZD7bVNJHk7waH6kB659qzEWw3GHyGSXrCQGdpzLdsPmU=
X-Received: by 2002:a05:6808:23c6:b0:331:3ab2:6fb9 with SMTP id
 bq6-20020a05680823c600b003313ab26fb9mr436913oib.200.1655317067646; Wed, 15
 Jun 2022 11:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220615143758.6139959f@canb.auug.org.au>
In-Reply-To: <20220615143758.6139959f@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 15 Jun 2022 14:17:36 -0400
Message-ID: <CADnq5_OXYpzdWk+x3SsKDVF1rFNJ2UWXwA+cLQSjX1L3zeP=cw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 12:38 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1835:13: error: 'remove_hpo_dp_link_enc_from_ctx' defined but not used [-Werror=unused-function]
>  1835 | static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   4e1db0119c64 ("Revert "drm/amdgpu/display: Protect some functions with CONFIG_DRM_AMD_DC_DCN"")
>
> That function is only used when CONFIG_DRM_AMD_DC_DCN is set.

Sorry, I had the fix in my tree, but forgot to push it.  It's there now.

Alex

>
> I have reverted that commit for today.
>
> Could you please add an x86_64 allmodconfig build to your CI?
>
> --
> Cheers,
> Stephen Rothwell
