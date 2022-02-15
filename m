Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06364B6776
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiBOJXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:23:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiBOJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:23:04 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA2413F39
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:22:53 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso995134wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MGallghbqZYnV5XKa1+ZW10tPrTrZGW9EkboS7fw5MQ=;
        b=wVvz2W3ESnbTzOVGKu+YOG9h+YDJ+KwFyhJTmJJzyRY5M+7hZeO8mDzNq02IwUr/w/
         DQ9Ebxsy4tukzG+Cv6VjxPGiR+YHA6KhNobCh/HL8IqlVnIy+cRSv/SolinaKdGTiEH7
         El8dS3NWdA5UVReFFH5aG1HRZ0CSbs9d1xECsLMcNdFIs5Mub3MSiNm/3F3Np9aWpXuS
         u766soTHmG4JViYSnWGynU7neqFnv7ynOCe6FTvE2+YeZOmgw+t5HeBA0zCPuLc3Po6l
         WWU1j+6BMCRYVmqMsTBzAvFQujRevjh5OkxuFxTUE9YGTKPpT+0/im0ba/1mUUF0UcjD
         BKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MGallghbqZYnV5XKa1+ZW10tPrTrZGW9EkboS7fw5MQ=;
        b=NOzWvT96wwZfL/VHqshDWtwID0RlNR6+pABgr9mVwMMDbBIGiBUMc+U291KouIE7Qb
         LarhebQKQ2iL+1nylVxD21jneQoPBif5oStlSv8iLh8op+8kh+jM0/8/VZGpCT/UmBI6
         qAafufiCMWEfwML0X3f9jOvY/A40BvBvmxpRUcX0JQTu+QGxiLw6YWjjL9IMTyY0p1Yp
         i0Y5Y+1JW8JbHieOwQb1d5fl5i4Mc+p10gxlEiXQuwbX5vt5pu7p8D8GZT2HtkD1H1ov
         bLhgnli1B1XweFCmdE5TGJOnBISHDleh8eOcmD3BpjOfNt5TSk9zntQlimNi0U/6uHBH
         dOFg==
X-Gm-Message-State: AOAM530g1G/TSZia5ZjKc0e0EIIqcD0UE+bOwpJV2aoyV1d0VaxAlOAa
        rzzFD9gNXSOR8/GA2OXiH7+R1u3fUADneA==
X-Google-Smtp-Source: ABdhPJzELvsNi/azn1IFMoIkFlgJQS6KAnNJYi5Q+IUJAj5r3qfJnM0VYiWzldu9oTmC+b3qdCyTGg==
X-Received: by 2002:a05:600c:1e8e:b0:37b:b9ab:e35d with SMTP id be14-20020a05600c1e8e00b0037bb9abe35dmr2228754wmb.109.1644916972521;
        Tue, 15 Feb 2022 01:22:52 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f14sm13569965wmq.3.2022.02.15.01.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 01:22:51 -0800 (PST)
Date:   Tue, 15 Feb 2022 09:22:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Walle <michael@walle.cc>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] MAINTAINERS: add myself as a maintainer for the sl28cpld
Message-ID: <Ygtw6hJFfDC6fd07@google.com>
References: <20220207184652.1218447-1-michael@walle.cc>
 <YgpkCyoSMg5RYfkO@google.com>
 <YgpkQMbhWAJG6oCh@google.com>
 <CAK8P3a0UWO=h6K4NpzCVC2vbOvThJH28GM5ddm9U1crr1Su7vQ@mail.gmail.com>
 <YgqE/OvNDco5wEY3@google.com>
 <CAK8P3a1aqcsD-fGBgAmsi0qf9Td_y3Ry+o32Z1fU8H3qmEn0GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1aqcsD-fGBgAmsi0qf9Td_y3Ry+o32Z1fU8H3qmEn0GA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, Arnd Bergmann wrote:

> On Mon, Feb 14, 2022 at 5:36 PM Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 14 Feb 2022, Arnd Bergmann wrote:
> > > On Mon, Feb 14, 2022 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > Hold on, you're not going to get many Acks if you don't send it to the
> > > > other subsystem maintainers. :)
> > >
> > > I've already applied this one through the soc tree.
> >
> > You did?  I missed the acceptance email.
> 
> I see now that the automated mails only get sent the submitter and
> the list that is owned by patchwork. I completely missed how this
> was sent to multiple maintainers and just grabbed it from patchwork
> along with some other maintainer changes I picked up.
> 
> > It would have been nice to give the other maintainers a chance to look
> > at it first, but I guess it's not a big deal in the great scheme.
> 
> Right, I need to find a better process to look at the actual emails
> when going through patchwork. Sorry about that.

No problem at all.  Thank you for the explanation.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
