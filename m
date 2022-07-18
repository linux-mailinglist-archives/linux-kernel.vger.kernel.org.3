Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59613578E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiGRXwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiGRXwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:52:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE68AA1B3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:52:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id b21so6867900qte.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pe5b/6eC5VODqzAUqLI58n4QjDC/aAW54DRJEazG65A=;
        b=ocXwkZiMb0Ur+i0gJXarYn9o4kxQjGtulFdoGang2nF9yms5ShP+RcFixFtP0mv3GD
         56y8xLQzF7FXc22gbk1kQPiD2+wyyrywkNIPb3KoVSOzE+x/mjYqUQf+81inwdNYb3CC
         AF8ammBcfhYWhHz//MsKxzaABWQIVVXNuntau03dhoocuP56EjuHWlAr55pJrXupKtNg
         bUnOvJM+ygUpPQTGo1ppzQ+V5sTPhUWhHHcrP8L/KJK1c4f0gIRIoVRsLswwo/2/67PT
         vYYVNyNsh3gjd72PbKxfVqXOvGDier5ItD0g3BqS4VbyEcp68J9fvOgQ8MI5gBwZBSdM
         yBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pe5b/6eC5VODqzAUqLI58n4QjDC/aAW54DRJEazG65A=;
        b=snMUr1OFDoY3kwMeBl7SADndYt/BGyJZfbjymixPs9mhuh3BPYfxXFsLwcHgWP8hA+
         7rSP0+WkMViebflg7x4jrUjTeokAL79sB5XYsoUugvigZuWm5F2TNcLkLBiNM/G+BIMW
         ngYwavzwzSXc8PYPvgL07IxImbb21AF74vz3eV1WBCYipZkUbvl8uw6TDS3FRHa2+PIP
         FKRUgy2j7YD5orou4+r1/5hcPVG/XApjkpZJuTZggh2F2zn1IlVHIxvpjI4hG+m6YlF+
         xSvLH5SDIvz47DSphM/OZF6kLmgYxg9McjPFE9fKaXW2giMDsobkZpJzhE/ms7p1/eyH
         1Wpw==
X-Gm-Message-State: AJIora+8G+vdngEKjMptJ7QruEuJxsWDvTh4v8TI5KhaQY9BVkbi5qD9
        4rc5qe15SW+WTf1sX7jevxbwW0kmLsVvbZGyj5o=
X-Google-Smtp-Source: AGRyM1tU0/sLKAjHDSjcErgXAQOd4NirQ8QdAZyeGQBOZXTDNEgSdhR6C89muEpv3oyNXuiSE1SUIFEQLlyrpdZUKQY=
X-Received: by 2002:a05:622a:1911:b0:31e:eef1:9d5a with SMTP id
 w17-20020a05622a191100b0031eeef19d5amr5676831qtc.233.1658188331648; Mon, 18
 Jul 2022 16:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsP920dX-gFOHjk0Xo-yTaQfoFwP7YT2VsG1=b9X6kYhHg@mail.gmail.com>
 <CABXGCsOywmEoKC1Gt4JMSAH5C=E9Rvjj+X+X8FY7QeBV-13YWQ@mail.gmail.com>
 <8876a42f-aef0-8322-b95d-704ac6476333@gmail.com> <CABXGCsNrnYZO6NfF624j0xrBkdF9vjZhcyF8iZrEr4eGcjpSCA@mail.gmail.com>
 <CABXGCsMSRg251use+9ZzgXZ_2xreNUh96GQsfDPdkh=xU6QGgA@mail.gmail.com>
In-Reply-To: <CABXGCsMSRg251use+9ZzgXZ_2xreNUh96GQsfDPdkh=xU6QGgA@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 19 Jul 2022 04:52:00 +0500
Message-ID: <CABXGCsP0V5SRhsyJvvS9PCK9JUo4XSbf1KSUESUwqE6EmBygjw@mail.gmail.com>
Subject: Re: [Bug][5.19-rc0] Between commits fdaf9a5840ac and babf0bb978e3 GPU
 stopped entering in graphic mode.
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        tzimmermann@suse.de
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

On Wed, Jul 13, 2022 at 5:38 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
> # first bad commit: [9cbbd694a58bdf24def2462276514c90cab7cf80] Merge
> drm/drm-next into drm-misc-next
>

Don't know who to thank but the issue disappeared in 5.19 rc7.

-- 
Best Regards,
Mike Gavrilov.
