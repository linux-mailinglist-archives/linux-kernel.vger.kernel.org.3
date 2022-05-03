Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEE4518BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbiECSQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiECSQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:16:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770C92A711
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:12:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso1713088wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y+egqV9L8y3eFeMhv6ZutKK7T1tzLZ/rfNLG3LUNd6o=;
        b=W/34bzAh1lhBtzos8guCHd0/zX3bWvWbYuVth3hcTxYYkHVy8oT27vW0JoTNYnIj56
         ppYRvJPq7OyzwFsGqP+z4oE6BG+2mpaR4+5pw4pFPlaCoqbfjbI6pVwft2rU7WNMJx52
         SE1FMCPcPFgBdomowSbteA9bqhG2jXR8pofJYg1CeYNcyt+qM4/E1/NAGiR2ekLAyRK8
         wnnPX+3fs+qmv33h0cEFLKpbrrkwMhzI8hwsXDc1hTQArZJnRu3eJplyH86l/AvYMWC2
         yn61Gw56vdkFYK4Ed8rZr91uml9xTtIg8seEyJBZgWjcnVMJUnbOuO8ms1os2figVgAA
         iC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y+egqV9L8y3eFeMhv6ZutKK7T1tzLZ/rfNLG3LUNd6o=;
        b=bBkJJ0DLpEIHD9JF/rlBmQq1rouBVRxYbLEuK1JheL/EbNDQKJXOw+zQ8LNwU49SJz
         x2rRHXYRrhqJEQS1VpW9zB/INbXn7P2l8xaWXsaa2xFcdp3TtaVCcF2oVkOv0t1l80iY
         JAo6z+ufSIRbxmcr4BaFTRmMF+ByDrue7CDnXgfawvOdjyk/5uAFuzxAkqPsO8Nj0KCy
         6dliBmNrbKSQEdz5KLArQBRQppWF8iu35UVxm/9NSCzMhfm8QiLqsikdPtbdE97wrd9s
         2r3vybnJ7X+ip3mcuQSD/5Q+vQ0InrP0xbb9RwcV4vqe80PmQGLmtHEBkzTLury32ZFY
         LsFA==
X-Gm-Message-State: AOAM532rRpQCVlKy8Fj54M7Y6xf1DkfRC1pgSTtDTtHj1BTa9lkRqruU
        HIUMogQXrRJ3089MDFyr0fcE7/BsLtcU+TqGJ5TF
X-Google-Smtp-Source: ABdhPJytz8OX8Ah3wwE7RJmgSLXQBG6U3ZrLCpoLAL0w1L0EEegRHrgq31Ox1A7WWX2jFtHyqAazvFArl8RZTJ3ftxs=
X-Received: by 2002:a05:600c:4fc9:b0:394:4317:1aa4 with SMTP id
 o9-20020a05600c4fc900b0039443171aa4mr4289427wmq.179.1651601547037; Tue, 03
 May 2022 11:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220502141524.35268-1-cgzones@googlemail.com>
In-Reply-To: <20220502141524.35268-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 14:12:16 -0400
Message-ID: <CAHC9VhSkR5J1KfC647C+7zmz85tj+U+y3HZ=9V9fv5KqMLF3ww@mail.gmail.com>
Subject: Re: [PATCH] selinux: include necessary headers in headers
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Zhongjun Tan <tanzhongjun@yulong.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 10:15 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Include header files required for struct or typedef declarations in
> header files.  This is for example helpful when working with an IDE, whic=
h
> needs to resolve those symbols.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/audit.h   | 3 +++
>  security/selinux/include/avc_ss.h  | 2 +-
>  security/selinux/include/ibpkey.h  | 2 ++
>  security/selinux/include/netnode.h | 2 ++
>  security/selinux/include/netport.h | 2 ++
>  security/selinux/include/xfrm.h    | 2 ++
>  6 files changed, 12 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
