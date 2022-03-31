Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA834ED8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiCaLok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiCaLoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:44:39 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C7208266
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:42:52 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id e7so13206637vkh.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9JAIiZystlqDHnsIruZg9DSbtqMdv6zP+X46BkhVvM=;
        b=ZkIJZGn9StXLui9Lz1TFK/CDvkJEw1tedIW+BqRnzG74AmNZmaUwWVg/FPy/pI6DOy
         dlPvO+6izAhJ2TmROCN3utIeKaJcbUOwbhXo/TwrV/DWW8qV5v02dSUEEH9jOBa5x+YA
         rxiWx3hx89lnL9/G8SxPnH7hBPwZUXQl7JyJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9JAIiZystlqDHnsIruZg9DSbtqMdv6zP+X46BkhVvM=;
        b=l62t2oTEA72WUKa8PCyC6+mU8f2zNWbJdiO+93h7JrkzrdoJoPLYmSvgKJ6GdCMpLw
         0FyCeB4YXEDe+V/1tGSlSdkMYaRGW5PbXZVxoR9aVsAU/JpSPJPjFjAXaZ9SpVlO7tuN
         hMH0SfUGABO0vzRMwAi74ZuB9X43QUu8I1OLdyyolOr1NsJKslC6rfyMLQ2ZAdGRgP82
         KqdrvRRjZbh+QQ+KH3a2Yx3QtYcYDNVWXvWkhjBHQwk9z404j8DgoyzsEzyyt5vj9y0I
         1w6P+0xm1Lgffw3PaxfuBqo9esj7pyLrPKao2AnhUELjsBZUt8iWEZ0KDFNnXfs+Gv0P
         EnHQ==
X-Gm-Message-State: AOAM531YuSJZkeAbv/ja7/q5P7dAAjI1iCWYLdEq4eDn7XSV032u35g9
        hMa0gRw+XHgdMyzcd6ss4uJq6VBOm5yyI/wajY5CRA==
X-Google-Smtp-Source: ABdhPJyHv+JRYWR+69lE+O9Ro6H6M/++dU9nRCMqSlPZKVrx7IFNDSy2/ShFmYiSYt6MZSObYhloGA4u+csov29YbY8=
X-Received: by 2002:a05:6122:9a6:b0:33f:f23e:bdee with SMTP id
 g38-20020a05612209a600b0033ff23ebdeemr1995153vkd.6.1648726971209; Thu, 31 Mar
 2022 04:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <SL2P216MB12463DE2E1E100E2498A5C33FBE19@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <SL2P216MB1246D7900A0B9620F1E1A038FBE19@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <YkWRN4ac0ivRn4aB@kroah.com>
In-Reply-To: <YkWRN4ac0ivRn4aB@kroah.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 31 Mar 2022 20:42:40 +0900
Message-ID: <CAFr9PXm3Mvr0guGoPDKmashMhFG6OQMvXHxwX-SD5ZHPi_sw4g@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] staging: media: wave5: Add TODO file
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nas Chung <nas.chung@chipsnmedia.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dafna3@gmail.com" <dafna3@gmail.com>,
        "bob.beckett@collabora.com" <bob.beckett@collabora.com>,
        "kiril.bicevski@collabora.com" <kiril.bicevski@collabora.com>,
        "lafley.kim" <lafley.kim@chipsnmedia.com>,
        Scott Woo <scott.woo@chipsnmedia.com>,
        "olivier.crete@collabora.com" <olivier.crete@collabora.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
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

Hi Greg,

On Thu, 31 Mar 2022 at 20:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> > +  Until we can test and resolve any issues on final silicon (due 2H 2021)
> > +  this driver should remain in staging.
>
> Then why not just wait?  Why merge this now?  What is the benifit of us
> taking this code at this point in time for hardware that is no one has
> as it is not even created?

FWIW there is an SoC that is supported (if console from initramfs on
uart counts..) in mainline, Sigmastar ssd202d, that has this IP so it
exists in the wild.
I have tried to get this driver running on it and it did something but
didn't get far enough to actually decode video.

Cheers,

Daniel
