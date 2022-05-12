Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333C852543D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357381AbiELR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357382AbiELR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:56:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E5BA9A1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:56:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s11so3381107edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qf/cKy/vzkmiMQPaxcYazd7i7GNGNfcW6oongi1e2pY=;
        b=aBk5ImdIj1iisdv/vbNTJ1oIW/fNvamlu+XDItZ0rJaeajo2BApQRQskjVOPMKIaEu
         cpPumuTa0f4i/GtGm1oEaClBbVL3sLpOiBx6zHO4feYYBwk1insiqs+5v0HEPJBlRETC
         9CUUoAzrNwa1Hbu+awusjyUUa3WZ1h65kMohgppGpXuvLjOzz2mw0ei8Hnj09wBOiIoG
         lBURzELdyT8X90Mji49/bAyBAzLwoR10ZAMHfl3i9ZFtO6uMVx6/Dg7eI5HoFgU1Ayqt
         8dbKVQZ4RSgPWt9x4SqmSMZBEomhHvkVPrXZPY+zRjbPIkiOdR9LdpjGYgcn+tBVK7xV
         /5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qf/cKy/vzkmiMQPaxcYazd7i7GNGNfcW6oongi1e2pY=;
        b=y/E66+wIqRRAVlKl6Y47n5uS6jM7wOZErkt0QFeoRbJsG1BtiUegujKuuNslLDK6WT
         CE1D/lvx6mr2JoftJKIJnim0doYxDROdEjjfnOXOh1QLykNLudwhbUs4bCoDlur7st0V
         Gwco3Bb1OnS2dZ6QjOmagjV1FjXuuMsPuOYFOeSSmamcm9PZnkOdYPj144+C/Ktj27g+
         dhPhKgiHN1OfJIvbkJWGz/+hYikyIJbZwCvj7RJEw0/RBIg+keFdnixaAVmuOtmx9sgy
         whDCOTIB30SXiwwZpyFlcZ2QN61LJJ59ArAaSYSSFcmWcgh19hZt4TqEDlWepz04J/aU
         o7lg==
X-Gm-Message-State: AOAM532PX7A+meekFAtXf0GT/ikS9hfAM70u2h3G49vQknAgo1T4pCw/
        Df2BnR9ZVbn4KY+jPQh79tlMxiKDBzMX/2h9A3wbwnzsybm4QBZf
X-Google-Smtp-Source: ABdhPJwhgwFV6BFyOwYx89UMqKZLAh/Gm3/1LRZTEnXL3E7WSv0RNG+EnONBKrBGzScs2UFKJksJ0yRhpTPtmaqlLR8=
X-Received: by 2002:aa7:c54d:0:b0:425:d8c9:efc6 with SMTP id
 s13-20020aa7c54d000000b00425d8c9efc6mr36388495edr.48.1652378175132; Thu, 12
 May 2022 10:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220426173334.3871399-1-dlatypov@google.com> <20220426173334.3871399-3-dlatypov@google.com>
In-Reply-To: <20220426173334.3871399-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 May 2022 13:56:03 -0400
Message-ID: <CAFd5g45E6KYNv=ZACtBpKg45KOS=D4=7FH5HDbZAXSjA6+g6Zw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: minor cosmetic cleanups in kunit_parser.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 1:33 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> There should be no behavioral changes from this patch.
>
> This patch removes redundant comment text, inlines a function used in
> only one place, and other such minor tweaks.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
