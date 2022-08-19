Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF77759A050
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 18:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351237AbiHSQEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351358AbiHSQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:01:23 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FA114D27
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:53:12 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11c5505dba2so5637546fac.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CBON6wUUJtdJ7sqqMZwarBOptDuvgv0pQ4ftADp75o0=;
        b=YKOAsmwkDqDfvM20l4Lh6uuwgDuwW7cbK+4jA+LC7iAC7meCT0NLSwnFPDnXi74eKl
         yVhD9IJ6AXVgUicEgtUGAcPukBcGTY1AdT1i4dMw8651aIkYmCS7rKLH/zQ8mm6PYkCb
         TPWMzLwuSRty3pM7RepGWoCOSLr1tg1dzv56uwlo8OnjUbxQe5dlHusAnOA3yMFzEN2m
         ngkIqcz4HoP1u6ravMguyNkYFqXF56iJ+YvV8+ES25bLsODdYingqBTet9m9RHy+vVTo
         Zm84LgwjvGV7i1NbIsl+4g6GODiI0yXKVhRHFBA+x7XO12bYN25vg+Yf2BOW4s3YzS93
         oIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CBON6wUUJtdJ7sqqMZwarBOptDuvgv0pQ4ftADp75o0=;
        b=NBskXrnOYTNZwZhQfPvHvK3jTdFFTc0zKf+CY/KQvCdBgSMar01LcpAVBmPOOOvCGY
         R6v99uBtR1jQ1GYui7qPbDp1u9vJ0nOzN3yTqO5pJTj3NOq1n1I2krf7JW+Qobgqtzb5
         7ENSUpNycYJLUrRu4Vrw0jHOD7pfrNcMqh6AK9gsKuaABXKbXPNDteQduWxIeRVWV8TZ
         4XOfW1xDDdAGzD7Qzaxqj6hsutz3RR1CGQmGNpwVYcgPdJ0XLN/qfP7owQdOS1LMhpYe
         7jdQPTf0zVTV3mGK4rDfMTxNf0hf12ABwC9DX6B7ftwMdMm8nUfkOy9x73O6wsMs5t4t
         jCcg==
X-Gm-Message-State: ACgBeo2JabclN76Ois8rXGrQYBDHBks+ciE4WHKFumzaZ4bNqGCAb3+i
        sEpjxj7yYOWZ1U8h0Z+cN1J4Pbf55nyYcD/JNjXn0iWV
X-Google-Smtp-Source: AA6agR7z0K2xqOKY94O/LSE9XZ82/tt5Bd4MR7meWJb+VTDodOAj64+SBqVf088mUrfo8YbPdneQyp78d6KcSKDTmi8=
X-Received: by 2002:a05:6870:e98b:b0:10d:fe5c:f818 with SMTP id
 r11-20020a056870e98b00b0010dfe5cf818mr4094491oao.106.1660924391783; Fri, 19
 Aug 2022 08:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220819015302.1731088-1-magalilemes00@gmail.com>
In-Reply-To: <20220819015302.1731088-1-magalilemes00@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Aug 2022 11:53:00 -0400
Message-ID: <CADnq5_MzPN2mRhKxrEtm86WOjjgp1MTBk6RGWqd=VjQRqQf6DA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unused header
To:     Magali Lemes <magalilemes00@gmail.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, tales.aparecida@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mwen@igalia.com, mairacanal@riseup.net,
        dri-devel@lists.freedesktop.org, isabbasso@riseup.net,
        andrealmeid@riseup.net
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

Applied.  Thanks!

Alex

On Thu, Aug 18, 2022 at 9:53 PM Magali Lemes <magalilemes00@gmail.com> wrote:
>
> dml_wrapper* files were removed in commit 724449e30433
> ("drm/amd/display: Remove unused code"), as they are not used anywhere.
> However, the header file wasn't removed, so remove the header as well.
>
> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
> ---
>  .../gpu/drm/amd/display/dc/inc/dml_wrapper.h  | 34 -------------------
>  1 file changed, 34 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/inc/dml_wrapper.h
>
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/dml_wrapper.h b/drivers/gpu/drm/amd/display/dc/inc/dml_wrapper.h
> deleted file mode 100644
> index 5dcfbd8e2697..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/inc/dml_wrapper.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/*
> - * Copyright 2015 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -#ifndef DML_WRAPPER_H_
> -#define DML_WRAPPER_H_
> -
> -#include "dc.h"
> -#include "dml/display_mode_vba.h"
> -
> -bool dml_validate(struct dc *dc, struct dc_state *context, bool fast_validate);
> -
> -#endif
> --
> 2.37.1
>
