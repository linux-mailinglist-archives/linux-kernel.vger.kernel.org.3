Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5902752B800
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiERKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiERKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:39:25 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED7340E8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:39:22 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id x2so2597820ybi.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIo0+jAZVz4Yxlhwrlq1Z7PbqEin+fkk3AOXZtUT/6g=;
        b=iV8TRbJSRpfQvAEcTpMm0CZiJqiz0jqwGauSIol9w+Xtw0JDFNG8DQN+tcwk1SBjZb
         QIhHkI4tocIbftoYt1/FDg7Heprewt/yv7swXnk9vMIVLXtVejVNNGKbR+nJ4NHnq6I/
         jgXNjfDV70rWPbhou+F8ROUvTeuNCumZrDFec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIo0+jAZVz4Yxlhwrlq1Z7PbqEin+fkk3AOXZtUT/6g=;
        b=sXnMvRbucSlrrxF3jK7hgyqFQLpavjWC3BCaKkK5yXO6V+Uvi27/jui9rdOObXE9sH
         Ar4N7FA5hzE7gM8uZm4KiRbrAvrOPIPY8cYZfkuYZHCDKg0IIL9u5yNwL5at5ZsJ3woI
         EF8seDSXt6FkFYS5DErXA/LNvDTh/lnlPFeE9UmqFU6RJzJ8tAOcn9DIg7CzS4x26U8o
         wIvDGQlYjKnEffpcLD5sfqvywAfMl7VceLSzhqO2GkOtiWdAHm+8iUP966vqfNEF+OlO
         K5pnmjIF2lFKmexoQvYNlT8li9I0qljvi6a9uXnaKR9KizmZ2bA9o4trnQVuVRrs8F4G
         tvIg==
X-Gm-Message-State: AOAM5336Lz5CntsLt0iwOrJ5pwKOONjrDueI14YpwoDgSRy3ozU1tAB1
        W0Z8kDW1Z5O08V99IMl2x/tHDi3zwnQcCB2wj8P2pKx9gds=
X-Google-Smtp-Source: ABdhPJwZAzPOtY3hjC/L3Ea0I8RcPaN91yjCvK0GKg7jOtNI9J51WFghWJGZdHwSKR5MQDdKJkKUU0lGSwLThGt67Zg=
X-Received: by 2002:a25:b197:0:b0:64e:ae59:e2d0 with SMTP id
 h23-20020a25b197000000b0064eae59e2d0mr619095ybj.523.1652870361313; Wed, 18
 May 2022 03:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220429064051.61552-1-linmiaohe@huawei.com> <20220517164553.29d6b76eb0cc656556916372@linux-foundation.org>
 <6f42e812-ab51-9b24-13f2-2493b917cb98@huawei.com>
In-Reply-To: <6f42e812-ab51-9b24-13f2-2493b917cb98@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 18 May 2022 12:39:10 +0200
Message-ID: <CAM4kBBKicBu-MsJ+=1QRwA4xpOUaz_iRj15+qkK4URyLzVSmCQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] A few fixup patches for z3fold
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 4:02 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/5/18 7:45, Andrew Morton wrote:
> > On Fri, 29 Apr 2022 14:40:42 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> >
> >> This series contains a few fixup patches to fix sheduling while atomic,
> >> fix possible null pointer dereferencing, fix various race conditions and
> >> so on. More details can be found in the respective changelogs.
> >
> > We haven't heard from Vitaly but this series has been in mm-unstable
>
> I will be really grateful if Vitaly has the time to review. :)

I absolutely will, sorry for the delay.

~Vitaly

>
>
> > and linux-next for three weeks, so I plan to move it into mm-stable
> > later this week.
>
> Thanks!
>
> > .
> >
>
