Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F135A4FF04D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiDMHGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiDMHGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:06:32 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A572E6A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:04:12 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id e22so939832qvf.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BU+xGeDrL0dqggaTnsKhPbMe9pU5gcDq8YBrXIQqSms=;
        b=j25nlSHuu/5tzcW2TTcBM051LooSj8CFdP6VXZvKujMRwCsr6WOMmza1414SdddWK4
         ITM8/meETeUGEg2jjKjC3xQWHklU8EBitC+30UJ1WUF35PU2+qsxhMbKthp8bhDdnI9K
         DvBdt8UmUBk7nWwwEH3sCV5m3PKTEOAKeWKq1va10J0aj6scBkPcUs4OfcIM6p4d3zrn
         RIXeFaw0+9N+GVmNFOa63ZNE0QrtlhK5V1jeoazUCOkgyB70hjVSQRoHrnmdg2lpLOJ2
         U2+dPF20AWH7jIsbJZe7FAZJNEFEGY3p/BxSy1vuuaxdp75C87hGfLxspCT2xccr1Eyt
         1YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BU+xGeDrL0dqggaTnsKhPbMe9pU5gcDq8YBrXIQqSms=;
        b=6vsBFA5h7g6DWpvXsWMbNx2tiIqJeD64oyw7JlZX5QDmGL46Yyy6WiAGrDt4TMJ8FE
         KW4KWXGwszqGgrBztvhS9A75D5advPwwOh8tzNN8WnOcE1lGyFdvTzzR5H3u4zwx2sH7
         4wBbv/PwY7RVCEaU2zzpv1DzZ/1aWPIe1xm7PK0TPxp4IYzkfsbWJ81kQ2zVTbgqi9ar
         ZlUUDFDcV35pnbof/mjM4Qevh2vwAhwIgNRdPcKa2D3uxpMerItCtqjX1hZyI+l5P4RK
         /QG8AJyImv5m/+L/pIxvTr+hUptqBIQEDPyKnMta9pjMnr+jlPuji9oJDOiWVWvPKaxB
         8k/w==
X-Gm-Message-State: AOAM5308k2Es4xfCxki2X75z2fNWgb20Hg1KxgcrkPGGufyp6KeMz3Ig
        MO9T572raNs9muEHQ/X3uBPALUZ4yJ0o4MMEHDa4RA==
X-Google-Smtp-Source: ABdhPJzuIHESbnHURnzZxCFN8adjB+/3Hl2djJNXF6wvoqTVn5r4Dwl2bGvdrjsJ3UemVSogR2tIaz+E2GKr0lJnoLE=
X-Received: by 2002:a05:6214:921:b0:443:ce3d:577b with SMTP id
 dk1-20020a056214092100b00443ce3d577bmr34905670qvb.122.1649833451148; Wed, 13
 Apr 2022 00:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220310220723.3772-1-ansuelsmth@gmail.com> <YlY3rPpYvclK8L3z@builder.lan>
In-Reply-To: <YlY3rPpYvclK8L3z@builder.lan>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 13 Apr 2022 10:03:59 +0300
Message-ID: <CAA8EJprEYgWTp5KJ1TSGC8EKbuw1XP+jz7D5BaCP0rEsEPVsuQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: qcom_scm: Add compatible for ipq806x
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 at 05:38, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 10 Mar 16:07 CST 2022, Ansuel Smith wrote:
>
> > Add compatible for ipq806x. Just like ipq4019, ipq806x doesn't require
> > Core, Iface or Bus clock.
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/firmware/qcom_scm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index 7db8066b19fd..7348c5894821 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -1338,6 +1338,7 @@ static const struct of_device_id qcom_scm_dt_match[] = {
> >                                                            SCM_HAS_IFACE_CLK |
> >                                                            SCM_HAS_BUS_CLK)
> >       },
> > +     { .compatible = "qcom,scm-ipq806x" },
>
> If you in your dt do:
>
>         compatible = "qcom,scm-ipq806x", "qcom,scm";
>
> Then we don't need to update the driver for each platform, only the DT
> binding.
>
> And if we some day need to quirk something off qcom,scm-ipq806x we have
> that option.

I suppose that ipq806x might need SCM_HAS_CORE_CLK. Or, more likely,
an interconnect vote, once we have interconnect drivers for
ipq/apq8064 platforms.

>
> Thanks,
> Bjorn
>
> >       { .compatible = "qcom,scm-ipq4019" },
> >       { .compatible = "qcom,scm-mdm9607", .data = (void *)(SCM_HAS_CORE_CLK |
> >                                                            SCM_HAS_IFACE_CLK |
> > --
> > 2.34.1
> >



-- 
With best wishes
Dmitry
