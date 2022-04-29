Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926D3515029
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378739AbiD2QGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359029AbiD2QGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:06:03 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8385B3D7;
        Fri, 29 Apr 2022 09:02:43 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id iy15so5641729qvb.9;
        Fri, 29 Apr 2022 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYJZsvyOkea/9Q9eJc08SVbCYt0tvNcpUbqVcHGxyq4=;
        b=jPeYnPbJRXQD0BX3W7jrdWUYJmD7N8mN6+/pC8+nlDf3j7JU8geIsPlI87igho4K1I
         byuawC1unF1Z0oDe2W4t/5IPETGXvTeM2aq16clko+nH9SHevwesvXqYtP+0b33I5h/E
         EBhRSIuyxAy3VKxC1elSJAPseZ2IfwKOYv88C8eOtWD4Jq0u8HxkUmT10yfwJNbEzqji
         T4RlWfeSBVot08KfvT+eE4NwmiKr56Ya+6P38B693PvIx6nObZ/4rim4qAKCt+tlGEQ5
         sHYyqbaZCa08RCNevQQ2OJLdHOScmSAJzBi9c8ICb+oNgxiVuzCOrY46cKB3LvMECDEF
         rmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYJZsvyOkea/9Q9eJc08SVbCYt0tvNcpUbqVcHGxyq4=;
        b=Rxp+FmblwiDUTbMlYCcjeVreos6R8yk2dT+6kXBbJrupLoFNbX71WpwFcZkbinuUsc
         PZzb0T85ZmEh26mADAIJlDTqrbuyQFQu6h5xSEq3pElC31+3agfRm4567Qt/wu7BujR7
         jvOg2fR4hCyh+EpJE/5YljXt9sTulvhhXtGlmQYO2P0nAyfB4r3mPQgSJOAoGZILGvs0
         LgTeD5h141efsuGRM7wrw+/Lpb9LTRvwjgABWDvEn9vJdgFAvvNj1D94cyJ8pUz+FmSr
         8CyMkanxRfmyCTA8V91sYAiHPNrW/DpcvhwnT+9muKjyDg10gWF0P1KsIOYwqMSR8Dce
         s6/g==
X-Gm-Message-State: AOAM531A5z1V72hZoo9F7LvBvithioXT9TWLnDluZ6G2xp7Is0HzZT7f
        ZDyl5M1yGu8QL64gfsbIEBPqzvPFfW4XOYFEpDQ=
X-Google-Smtp-Source: ABdhPJzdWlVtYLa+B+4LyiD79fGPDUp75fRe3KQuWcZb2b8cU/HDhsxHqmB8kyhr4IxxVNrLEevlt1WPs9mwB1mPoIs=
X-Received: by 2002:ad4:4f48:0:b0:458:12bb:1321 with SMTP id
 eu8-20020ad44f48000000b0045812bb1321mr2313282qvb.50.1651248163056; Fri, 29
 Apr 2022 09:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220429114330.59026-1-robimarko@gmail.com> <20220429114330.59026-5-robimarko@gmail.com>
 <CABb+yY3dPwT4ASdxHqRidRBEq19YHsp8RfAgO0tr_rZ+Dde2hA@mail.gmail.com>
In-Reply-To: <CABb+yY3dPwT4ASdxHqRidRBEq19YHsp8RfAgO0tr_rZ+Dde2hA@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 29 Apr 2022 18:02:32 +0200
Message-ID: <CAOX2RU5umgktA1kWfKiuDAC-VAH0U-DrPhk8FqX-kpkQ9RTPpQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: mailbox: set correct #clock-cells
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-clk@vger.kernel.org
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

On Fri, 29 Apr 2022 at 17:39, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Fri, Apr 29, 2022 at 6:43 AM Robert Marko <robimarko@gmail.com> wrote:
> >
> > IPQ6018 and IPQ8074 require #clock-cells to be set to 1 as their APSS
> > clock driver provides multiple clock outputs.
> >
> > So allow setting 1 as #clock-cells and check that its set to 1 for IPQ6018
> > and IPQ8074, check others for 0 as its currently.
> >
> Please include qcom specific marker in the subject line.
Yeah, I see that I forgot to include the actual binding name.

Will fixup in v2.
Regards,
Robert
>
> thanks.
