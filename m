Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EBC565660
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiGDNCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbiGDNCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:02:14 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE2B7650;
        Mon,  4 Jul 2022 06:02:13 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3137316bb69so81248507b3.10;
        Mon, 04 Jul 2022 06:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/WAa+FA2OPU9UHOFsfNsoHyWgYz2aEv+swmJGaV8ok=;
        b=LXpMy8vV5Tgwg4ggUby6rb092+eBbT8tDL4/nbljmfEmZl+l763SMe0kXQDFj4BHAL
         SO3U15HVmNY4dltXz2WosqcIJTWTbzxBnNwsIIxIkaKDh74GUdwz5GsVbK6DSMszVu7u
         yd5FiJpVQH1YDbO58dP3onrO5GO1XYWRrkwzYDWCeGBLn7UM0TgiYqBLWKhp9rhXJ6z/
         oBNmqsqlqWMdhceiGv8Z6gr6klG1YOoIFSDvCK50LzoTgsRgOzBdgyUSVI4agTjJSLeo
         w3orR6FjJyYTpryLNulJ7crd/Iuj+T+mQ9dempkYVRuKSjw2L7gpzuAPts9pDOxhptYJ
         XrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/WAa+FA2OPU9UHOFsfNsoHyWgYz2aEv+swmJGaV8ok=;
        b=P/2iG+HSJJVO6o/t4MojxArFBZukgHKG+3my4kGIxc/rCyQ/Oyu6alVrhKa1xjsxdq
         LOapP6iyqVpwWVaXMImQbzFKYBX0PFpXgiSbiNkcaYGXgTUTEc68ojq7UiSf0d9m48OA
         /OjMiXmZsZgTHBGQhupKxn2uoxIvBiLCrCEvraUHiihsyP4eUnuDvzLIXWhjKk7HaqMV
         zY74HMnYop3X7EjfM24KIDcbnhHH9oneWx3UB8lWRKQKoC1CV8a/dMXlzAVL5x1E+nuM
         KBefj36L/kZ0RKBl/kb0SeKkJDkzeFx0BSFeauL8ddRNIK8WXOKp7EzbRLOUF6wQgpEJ
         PxPQ==
X-Gm-Message-State: AJIora8MtCCsQeOh9w3MTW2GekAzGtpHf+BEi2YWQBzkUrw4WJAw8Kao
        qbxaoFWw1JCd6ylF/HK7PlqrN0JODfxjJucAPDA=
X-Google-Smtp-Source: AGRyM1sI/tzlaoftsLV3su+NET07t9IRl4DQbevcpFmKt2ApgRmbHStsCYOoPVSuhn7ylHvKmKllRMaNokprfFKJb7A=
X-Received: by 2002:a81:5211:0:b0:31c:89a8:b63 with SMTP id
 g17-20020a815211000000b0031c89a80b63mr8973562ywb.104.1656939732512; Mon, 04
 Jul 2022 06:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com> <87y1xenju5.fsf@meer.lwn.net>
In-Reply-To: <87y1xenju5.fsf@meer.lwn.net>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 4 Jul 2022 15:02:01 +0200
Message-ID: <CAKXUXMwBV79aWBByBaq+uicpKB4pJG8Nd=RWT55bVcqkV4YR9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] docs: remove submitting-drivers.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
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

On Thu, Jun 30, 2022 at 7:26 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
>
> > Dear Jonathan, dear Federico, dear Alex, dear Yanteng, dear Hu,
> >
> > Here is an attempt to delete submitting-drivers with some improvements
> > and clean-up in other documentation places to convince ourselves that
> > nothing valuable is lost when deleting this checklist.
>
> I am totally in favor of doing this; that document has not served any
> real purpose for a long time.  Resend with the translation tweaks and
> such, and I'll happily apply it.
>

I send out the tuned patch series, ready to be picked:

https://lore.kernel.org/linux-doc/20220704122537.3407-1-lukas.bulwahn@gmail.com/

> > As future work---with this one submitting checklist gone---I see the harder
> > follow-up task to synchronize and clean up the various submission hints/
> > guidelines/checklists in the remaining kernel documentation that partly
> > overlap and differ in detail, their structure (unstructured, unordered
> > lists vs. sections and subsections) and their state of being outdated:
> >
> >   Documentation/process/submit-checklist.rst
> >   Documentation/process/submitting-patches.rst
> >   MAINTAINERS#Tips for patch submitters
> >
> > My next task at hand is to read through all three documents, figure out
> > what still applies and what is outdated, determine a good common structure
> > for all three documents, include cross-links and make them to some extent
> > follow a clear consistent policy. E.g., one document is a more detailed
> > description of everything mentioned in the short list of another document.
> > I will try to work through that in the next months or motivate and guide
> > some colleague or mentee to work together with me on that.
>
> This seems like a good exercise as well.  I think the MAINTAINERS text
> should go away entirely, that's not really an appropriate place for it.
> submit-checklist.rst hasn't seen any real attention for some time; I'm
> not sure how useful it really is.
>
> What I would *really* like is a version of submitting-patches.rst that
> is not a "War and Peace" sort of reading experience.  That is a lot for
> somebody to get through before they can send their first patch...but
> it's not easy to make it shorter without losing important stuff.
>

We share the same vision. I will try to propose a good submit
checklist that covers the content of submitting-patches.rst as a short
bullet-point list. That should then also cover the valuable (not
outdated) parts of Documentation/process/submit-checklist.rst and
'MAINTAINERS#Tips for patch submitters' as well. With that new
checklist included with proper references and considered good by our
peers, we will use the earned credits to delete the previous tips and
checklists.

Lukas
