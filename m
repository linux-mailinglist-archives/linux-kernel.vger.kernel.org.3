Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59BD516144
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 04:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiEAC6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 22:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiEAC6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 22:58:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3886457165;
        Sat, 30 Apr 2022 19:54:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l18so22117344ejc.7;
        Sat, 30 Apr 2022 19:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vtEgEgvSSjpz3nKvUKDHSWfXwEKAllpdOTPmgbe3VTU=;
        b=WZlOgahsRkrmuzO/r4wOaLfAz/ZuvgTNA1Zk40/AfCYLiYF6tUiUNsZJ9OlbR+4d9B
         jsbxe7QuhkWbS4yF2IiMCNXMEmW/Ba1z9IGD39xpfmrP79oXApPV/TUy8L4dfgKwCjJO
         uUWSus0iSWfXtiy30aH6xP3TrD0rAvGg78aTW45Bkfua3G85OxJZMz/dN7HzMc9uX6M+
         52V+7ds89VCI0+JYX1TKdM1BszkULmgwS2eSK0VCdfGfmJXog3ST7UAnaPJz4TE5e0wv
         D1pHyJpI/3zVJKPuHym6aJpU0ti65cpTjRL3Gn/KReVPQXDtVAOp3XzotGfQzIBWoLRU
         sImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vtEgEgvSSjpz3nKvUKDHSWfXwEKAllpdOTPmgbe3VTU=;
        b=Hprr0GnkdXu920xN1EhjBlccR+85DGf7hMcfgvSHFQKSa4xDl2OOno26hFGW+KxNxa
         C2ajgE1B2daSL/QK/qwGp5A/sJt+wrgtGcrjdC6XsYeMoNJNN9pBhgCkRuooxx8KZtKr
         PZNVkFzSW3hBapwMMo8jUqLZneq8yBORWZtL87v/MSq0/tN6YJLy5nQXd9qSuFqTpS+i
         C2FmusbucV4JFx2OmjT+uAnnAjQH2rys8OKqCnfr7uvCtOvO0/x6hUNiMuDihhz4IBJn
         PeUdeaaVajzuhVovXwU+2jmJSc+slqjyh/AR7wTnpxOPs9RfXQjjIBcEhpOk0DjoTcOw
         w18w==
X-Gm-Message-State: AOAM533wgEQJZoBK3NtKEVIfNKMTtUHpKzYHESJcpjjqpE/xvCu115Tz
        5NiFbFXWfkLMHnqLzKJiBX9yjq6basgo5NWy0+4=
X-Google-Smtp-Source: ABdhPJz+Tih7i4xXMFnHO3J7aRp+hxiEmn2HRzTfHYwq1cqS8fVNVGmW987agqV2cborfDXGLQR4MmfvN7SorBr7OXk=
X-Received: by 2002:a17:907:7b9d:b0:6df:fb8f:fe82 with SMTP id
 ne29-20020a1709077b9d00b006dffb8ffe82mr5908361ejc.652.1651373694643; Sat, 30
 Apr 2022 19:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220429032621.674865-1-starzhangzsd@gmail.com>
 <20220429095104.GA11365@alpha.franken.de> <alpine.DEB.2.21.2204291559490.9383@angie.orcam.me.uk>
 <CANubcdWykz0j5BaGNhYMW16wX9UbfgsLdEs-ebNWCWP+p1OKWw@mail.gmail.com> <alpine.DEB.2.21.2204301609310.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204301609310.9383@angie.orcam.me.uk>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Sun, 1 May 2022 10:54:17 +0800
Message-ID: <CANubcdUxobBn968rtz0z-zZVJQfV5k3PQcdLdXNbsw3mEphk0A@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: undefine and redefine cpu_has_fpu when it is overrided
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        liam.howlett@oracle.com, ebiederm@xmission.com, alobakin@pm.me,
        f.fainelli@gmail.com, paul@crapouillou.net, linux@roeck-us.net,
        anemo@mba.ocn.ne.jp, zhangshida <zhangshida@kylinos.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki <macro@orcam.me.uk> =E4=BA=8E2022=E5=B9=B44=E6=9C=8830=E6=
=97=A5=E5=91=A8=E5=85=AD 23:38=E5=86=99=E9=81=93=EF=BC=9A
>
>  Adding a safety check would be a separate improvement.  Please feel free
> to submit one.
>
>  We need to keep fixes and improvements as separate changes.  For one
> fixes can be candidates for backporting while improvements are never
> backported; cf. Documentation/process/stable-kernel-rules.rst.
>
>  I hope this clears your concerns.  Let me know if you have further
> questions.
>
>   Maciej

Thanks for your elaboration.It helps a lot.
I want to submit a v3 patch like:

#if cpu_has_fpu
# error "Forcing `cpu_has_fpu' to non-zero is not supported"
#endif

but this will cause the link error if not combined with the fix:

MIPS: IP30: Remove incorrect `cpu_has_fpu' override

Maybe I should submit one first, and see how it goes then.
