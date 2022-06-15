Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886FC54D4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354993AbiFOW6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354724AbiFOW6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:58:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD21FA49
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:58:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v14so17204851wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7d59e8cLd9zR8JBI8Qug1RRbOtLsaHXxn7NGGAbfac=;
        b=8FEQ/rKC2z2qweHx7AbNnl2OYRuMQjwUirgjoVVMGbDTTjJdWJhGsVCJJYtp5+5eK4
         XtelcaIv34qF0q9Qht2XX40NUplwFjmE4HSeV9obfyTk/EG2SiYkSsY+o+KaMg8vZ7wI
         cPdHFWwmLlrRt8JVt5BVzHT83TUcwfR8gYt6STFWC5FVCK9OdeLtCOuNFlD/ydgiWPN7
         FIxA+8CsKA9MkkwAHKLeHqcf5aIkmWD4sVM32RDt5XFgw5cWWNNKxVW1VI6j2/6kMn15
         onIlZFHJAhSSPm1pKn7i+uPJ2VlO5crOq9hJmTNO54fY0IBK2HjT49IkScVZEC5lbWF+
         nFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7d59e8cLd9zR8JBI8Qug1RRbOtLsaHXxn7NGGAbfac=;
        b=0dJwbqZ6i1rcz0MWO8Mnnd5nR/b9ofVh1brDAmBOfj57SE8V6vDmMYgaoZ0o51+CZ8
         9AG4/6koxR/Da+GsjRj2I7SyfR089lnabX+tc1hEpMEn5wprRbmDopg6/4knNht3EcTi
         fwmPjyH6D7THPkU9YgReWsZLJm8RmD8QNeuatlsQ2q9dKwQBfeIKDak48GDDv06xZsaw
         Jpltz5hdnnUpc5AsPWvpO+fTSbhRDoKhYx3VWmb7aWP6gJUK7iEjoXq1Pec2MjcxEFrY
         VSVJBZ5b/F/fDavjGfpv8UWTbp/6d3jElGi9CJgo6jWGjRkJXq+/ioHhtURQA2eqlt8W
         Hd2Q==
X-Gm-Message-State: AJIora+kECNLtN1+kF5QMA44afz3keEkRbI/+4fa6Uo+Em0mkZX8A0Ku
        3HZ+3SUew/oZR9ladHMhBUnOzgIR95kL2+Cuph9M
X-Google-Smtp-Source: AGRyM1tR/8FwEvyL+Y8ZCasyw/O1y6VLQFDMk+WfCNi0tijbHrlOJ8pcBy3IJBRxFdOtz1bgY0/pm6gf+ypXk07cW+Q=
X-Received: by 2002:a05:6000:230:b0:210:31ca:28b8 with SMTP id
 l16-20020a056000023000b0021031ca28b8mr1923497wrz.538.1655333914698; Wed, 15
 Jun 2022 15:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220614132333.143042-1-xiujianfeng@huawei.com>
 <CAHC9VhQdfPBn4kbY0xRPaCvNBJJGdQQe_90A4Hhdsj6gVr6pAQ@mail.gmail.com> <CAFqZXNswaUiHNZA65GCsgB7GNLm6tc2OFXsQrTWxBTfWviQ8+g@mail.gmail.com>
In-Reply-To: <CAFqZXNswaUiHNZA65GCsgB7GNLm6tc2OFXsQrTWxBTfWviQ8+g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Jun 2022 18:58:23 -0400
Message-ID: <CAHC9VhTjaVN1anR34s5foehSMzz1s-xXY8JZ1k44MzSqCi2_EQ@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_policy
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Austin Kim <austin.kim@lge.com>, michalorzel.eng@gmail.com,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 6:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Jun 15, 2022 at 4:03 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jun 14, 2022 at 9:25 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> > >
> > > In this function, it directly returns the result of __security_read_policy
> > > without freeing the allocated memory in *data, cause memory leak issue,
> > > so free the memory if __security_read_policy failed.
> > >
> > > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > > ---
> > >  security/selinux/ss/services.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > This is another case where there is not actually a memory leak as the
> > only caller of security_read_policy() is sel_open_policy() which will
> > free the buffer it passes to security_read_policy() on error.
> >
> > If you want you could add a comment to security_read_policy()
> > indicating that the caller is responsible for freeing the memory.
>
> Can we please not have two almost identical functions with different
> cleanup conventions? Please let's either make both functions guarantee
> cleanup on error or neither of them (adapting the caller(s) and
> comments accordingly).

Priorities Ondrej, priorities.

Every patch posted to the list has a time and effort cost associated
with it, and between reviewing other more important patches and
working on a proper SCTP/SELinux fix, I simply don't have the cycles
to spend doing the back-and-forth on a patch like this to fix a memory
leak that doesn't exist.  It definitely isn't because I don't think
the code could be improved, it is just that there are only so many
hours in a day and I need to prioritize actual bugs and important new
features that people want merged.

... oh, and I need to reply to the complaints too, that's always the
highlight of my day.

-- 
paul-moore.com
