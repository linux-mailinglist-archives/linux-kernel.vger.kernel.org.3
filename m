Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C2F505EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347736AbiDRTpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347734AbiDRTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:45:52 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158CC24966
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:43:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bj24so10404357oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=APMNQ0VOd3gUC3vflkGQPEv7QJLULTgT7Cf+XJq4PlU=;
        b=XIQ67C2JubBiGYT+sCav370KSdQQ0bmY05YMHN0a10iR1OWGIcXTCmayqgBXnTYPQk
         FOwWwAGoUuk33NgFGo8LjQyIIyR+8jFfppCZU5nDw3CvMdgPWzfJsRJKhc8GVY2CRfWa
         pvHjnN+sm1b8cNeSwNOmUffZLIiuAsbhlHf7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=APMNQ0VOd3gUC3vflkGQPEv7QJLULTgT7Cf+XJq4PlU=;
        b=Rz+geJakMgA3hlkBQmC+4BUEgPLcdleJPyA5f/cIe/uVdNJLL2i6RmbNFmcDCSorha
         HGoxVPsJnUy9FneNqTcJ7+QFBW+RafYQjiS6ZjHmDYIpt6V4Cf8c+tRJx1DfEi+blqTe
         TMJX3RxJhRyobmqu/v5tq0gDsZj2iaxFctk05OWUOBahhaHoCppFUsdIZLAKS0dc/bnU
         VCXxuTPiizIR6x4g0IWhSltPnbqIN5L7xLk5JwGG4c7LvMMHgINCjlmhae3KgSnb3lyf
         T+Uei6NKe4m9zfUuC1g8JDFcrY80icJP9wy9L5reANrbv+nbhMLAYjNX68SDNs4lp3wF
         8BUg==
X-Gm-Message-State: AOAM531qxYDojtvp6Vibs3s5I36vd2E6ahNI2Uy5VaQDZ61JrOAu/XHG
        t9Abq/PEMZc3PQ4Q1i35tYj0rG1HeiFoVFqe0rf+wQ==
X-Google-Smtp-Source: ABdhPJxz8/mVSXcDfE357Co4lqCJlK4Bq5DrL7FdoTy7mcDP2lYRYO9puha9GdELIR/9mRNaIG7PKesE2HH4+iorsaA=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr5836497oif.63.1650310988401; Mon, 18
 Apr 2022 12:43:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Apr 2022 12:43:07 -0700
MIME-Version: 1.0
In-Reply-To: <YlzZr/UElg690/ru@google.com>
References: <20220415003253.1973106-1-swboyd@chromium.org> <20220415003253.1973106-2-swboyd@chromium.org>
 <YlzZr/UElg690/ru@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 18 Apr 2022 12:43:07 -0700
Message-ID: <CAE-0n50Kp4PkMqvOR=eAXMYctEv1J_ziRtjKL_mDR_zrS0apzw@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_proto: Add peripheral
 charger count API
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tzung-Bi Shih (2022-04-17 20:23:27)
> On Thu, Apr 14, 2022 at 05:32:51PM -0700, Stephen Boyd wrote:
> > Add a peripheral charger count API similar to the one implemented in the
> > ChromeOS PCHG driver so we can use it to decide whether or not to
> > register the PCHG device in the cros_ec MFD driver.
> >
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daisuke Nojiri <dnojiri@chromium.org>
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: <chrome-platform@lists.linux.dev>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> With a minor comment about the naming,
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Cool thanks.

>
> > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > index df3c78c92ca2..8f5781bc2d7a 100644
> > --- a/include/linux/platform_data/cros_ec_proto.h
> > +++ b/include/linux/platform_data/cros_ec_proto.h
> > @@ -230,6 +230,7 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
> >  bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
> >
> >  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
> > +unsigned int cros_ec_pchg_port_count(struct cros_ec_dev *ec);
>
> I wonder if "cros_ec_get_pchg_port_count" would be a better name for the API.

Sure. I left out 'get' even though it's similar to
cros_ec_get_sensor_count() because it seemed redundant. We can't "set"
the port count. Anyway, I don't really care so I'll leave it up to cros
maintainers.
