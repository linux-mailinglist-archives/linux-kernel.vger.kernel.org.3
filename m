Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6458F5A44D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiH2IRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiH2IRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:17:06 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768C353D30;
        Mon, 29 Aug 2022 01:17:05 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f14so5522894qkm.0;
        Mon, 29 Aug 2022 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=npuoc/yi9Nf1Viofw3xXBfcM8tin3OMo3rNYgsJsIBQ=;
        b=eha3/ykclVkNcWk+PSUSVGEG4xaMD8+gnkOvTuyVBOLJwWCLnNPyWQ5Hv6jTJq+Qzo
         ilC7ELly7FcDoLz2FDUZwF9zKb3jXMoX3dKYNmSqXLzEh1bpB7Af61XPjm7k6lkVpQWz
         uluJeC6i+g291l0U35SUgNlGy322TQOcBjc3ujUHfp8U3hkn3896twTAwcpzilg0jzbP
         JcclfFvyHwZNWK15p0ds4tLukTXH1AcTYEAXHKrpw1Ympr/qpyaI2S84FCgNuMEM2uaq
         MpztcaAXWtoskOoBO784u2NlAHM6q5K0cpQXeLZzg/IyEs+nA1s20gcEUnWQH7vhWxNL
         2drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=npuoc/yi9Nf1Viofw3xXBfcM8tin3OMo3rNYgsJsIBQ=;
        b=fsCakfE36yLUVvE0sPLADOvL7SfJ+t5PFAs4MLd2Y2bahalONiOfh4Hw2cW1ztHMgW
         JnJ9fk5viFAZTqmo2mPXg91HMmWg4MRpfUn9HscGk2MigRXD4/YlerCJFtDSYL/Ogbrc
         4ZZ2n5U6Y313Jx3Si8OGFGpIEhzdE5gJ7ohhbPgNdJ2nDwibJxU+1pmc6JxjhGG43FkR
         dTjsf95/chZ7MRgfZ67QS/OK02M1F5YiAXY/eaQFobzR6jmVC67kMJVM4YrOwvZ3efyC
         AXEtoENKIwY019UsEOCar9sjID6BVcJP2jJ087pF8BSn+QLPuQdEHb00nWdTrothf38p
         5hEA==
X-Gm-Message-State: ACgBeo3x5sqQyj6CwhXqTOejw+UhZNTa2iXF1DdDftzli4WAAibbSnWh
        gBCWDealfUQqbopTsCh6NWExa07zihvy2ZwF93T/C8QFZ/U=
X-Google-Smtp-Source: AA6agR45L2sMoeZRBU05Cncz73wTxYa2pjfSlmuF5Q58NzJvbhzbRaO4dGm+JamGJNGgzI2KAWbjVmkIgmZKGHArnxw=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr7481158qko.383.1661761024589; Mon, 29
 Aug 2022 01:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
 <20220824104002.2749075-2-vincent.whitchurch@axis.com> <CAHp75Vf4C0hauoT7F26zS7815Cps=W3o1_HHmWKVbrUi90FcrQ@mail.gmail.com>
 <Ywiwv8TZ5oomTuHK@axis.com> <CAHp75VffYzNTfrki4+o8JJayUGo1n91bP0hSzB-fR=RfcFq-fw@mail.gmail.com>
 <20220828180623.54939dd7@jic23-huawei>
In-Reply-To: <20220828180623.54939dd7@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Aug 2022 11:16:28 +0300
Message-ID: <CAHp75VfppWNbiPvF9Gem0JOhADwpiHRaJV9_c9NFtUfSK_PMrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: mcp320x: use device managed functions
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        kernel <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Axel Jonsson <Axel.Jonsson@axis.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, Aug 28, 2022 at 8:40 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 26 Aug 2022 14:57:44 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Friday, August 26, 2022, Vincent Whitchurch <vincent.whitchurch@axis.com>
> > wrote:
> > > On Thu, Aug 25, 2022 at 10:01:58PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Aug 24, 2022 at 1:46 PM Vincent Whitchurch
> > > > <vincent.whitchurch@axis.com> wrote:
> > > > >
> > > > > Use devm_* functions in probe to remove some code and to make it easier
> > > > > to add further calls to the probe function.
> > > >
> > > > ...
> > > >
> > > > > +       mutex_init(&adc->lock);
> > > >
> > > > > +       return devm_iio_device_register(&spi->dev, indio_dev);
> > > >
> > > > Do you still need to destroy the mutex? If so, you may not call devm_
> > > > variant of iio_device_register() or you have to wrap mutex_destroy()
> > > > accordingly.
> > >
> > > mutex_destroy() is only used to ensure that mutex debugging catches
> > > further use of the mutex.  Isn't it rather overkill to add specific
> > > cleanup to do only that, especially in this case when it's anyway going
> > > to get freed immediately afterwards?  The vast majority of IIO drivers
> > > don't call mutex_destroy() (256 calls to mutex_init() in HEAD vs 12 to
> > > mutex_destroy()).
> >
> >  So 256 - 12 = 244 drivers are not pedantic.
>
> I long ago decided mutex_destroy() in remove() paths just isn't worth the
> effort. It makes absolute sense in more complex flows, but in cases
> like this it's just annoying and makes the cleanup harder.
>
> Hence I'd prefer we just ignore it's existence in cases like this.
>
> If someone finds me a bug that it would have caught then I might
> change my mind ;)
>
> If anyone wants a giggle via adding a devm_mutex_init() call it
> might be interesting to see the responses.  Would be unusual in
> that it would just be mutex_init() in unless the mutex debugging
> is turned on...

Agree on these points. Sometimes too much pedanticy is too much.

-- 
With Best Regards,
Andy Shevchenko
