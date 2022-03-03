Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AD04CBBC7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiCCKzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiCCKyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:54:55 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EB8177D2F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:54:10 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id bm39so3605836qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 02:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIefTN+GemVOVXkSfBDQV0l1OlBF1itqeVJSos9zGnI=;
        b=YKtddxe0PfExEg+BiPTVdLq9D28WqcBtufOi+nKN4E/QQJgX5KRMkbf7x6EG4rOSQn
         9X0jYXUB+/FQ+AJt8n4Ak9xEPi1XBjG9+OF8WcSQ/KrDQRM1a38GAg096jpVHodTiFvq
         aci53REgCZIU7TSI3D5TwRnK9hdpEWvQaSQqmCUEg4Qv4uSJiyYw0mu/2co247lpAslK
         uBhHtRaggKJ2+/HTePm6qL6DItGHXGA3/cJBxcARAohCEWVrmdVv3UFS+eK81fH01lPr
         heuBhMDTHiCIuVE41EOvc2OavosXrINkXR14S7S6h4ScKEHppJam8Zoaypp2XzVfOJxn
         aHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIefTN+GemVOVXkSfBDQV0l1OlBF1itqeVJSos9zGnI=;
        b=2RfROAX3DtMiPwy/fcfejOTLsypkh/NLCglkbnl+uWf76auUKMtajxRVv5Fe+wW0NW
         PODOdaO4z4qOR4lJ7GdviAU6mI5CwQqTjKzuEOH/MUCFkVJoCyf8mXCgVTGuOU1Q8ZiK
         0sKw/LD2PhKw9SJoP1Ft4aHKFWEOxW44uVd8wnT7NFe2cxZtewGE9z92lsnSw5p/3hYb
         1rdSJq1u4t/rx0DXS5ZcM/EMbg3rjT4rxM3xdDW2DVqU9/iYMCwvPk82CrHpw/P9pdYa
         Nt1KFNnHnbbe29G5qpIbc8B8gr2zTYOAqZ8EUExGR0VfTpBQlEUyskYQoJ2O3TL8GE3E
         eRxg==
X-Gm-Message-State: AOAM531Uc51WJ6KMQSj5U7fVbbrf2m/Mt1JasW3tmaf3wZHmp0XYila8
        ngZe5IclAcQgHpdKhFxaWXDVd6u0L5db3OyczLk=
X-Google-Smtp-Source: ABdhPJzuHpHWvVPwgfmz8pJX2uSoMtMpldkb14GicavfxYn+pQMAbEF3+eDap1cU1alYRlUk1Py4rqeNIBY2Y3IefFA=
X-Received: by 2002:a05:620a:170f:b0:663:406e:e03a with SMTP id
 az15-20020a05620a170f00b00663406ee03amr5915535qkb.593.1646304849211; Thu, 03
 Mar 2022 02:54:09 -0800 (PST)
MIME-Version: 1.0
References: <tencent_7E4716854F78B812C4FF16C83573486E1806@qq.com>
In-Reply-To: <tencent_7E4716854F78B812C4FF16C83573486E1806@qq.com>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Thu, 3 Mar 2022 10:53:42 +0000
Message-ID: <CAM0jSHO=yudjZeWbVCwdVnaJ1kJ7k34unQVvyCBxTji=u3WnWQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/selftests: check the return value of kstrdup()
To:     xkernel.wang@foxmail.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
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

On Tue, 22 Feb 2022 at 13:32, <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> kstrdup() is a memory allocation function which can return NULL when
> some internaly memory errors happen. It is better to check the return
> value of it to prevent further wrong memory access.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
