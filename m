Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120C5170BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385381AbiEBNnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385346AbiEBNnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:43:22 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A60DEBA;
        Mon,  2 May 2022 06:39:53 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d39f741ba0so14261651fac.13;
        Mon, 02 May 2022 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OuyIqKgz7v/jbyUuzEx+I0jFYUsMql7jJYGwohLQ7z4=;
        b=FoDa4O3w1YnLfGkhByVVNp/RW+p57HZ7yApGqWHu9GSVGyEpJad2x5JEXsyPeDuZXS
         +DzW3jUh9gQi5mObpeb+MTcA50G6q8xTWEtHeCFHIaSbuSW/ehEZkQkaQ3VR9TxmE0lZ
         bxgYCEsANOG8jEgXj6Z5A8bZKlyJEN3agOY9UBJXv4nwvDIIX47hFezBAdeQNzzNvYA1
         LsXCvKKkk6rDMpQWYstlOiPfbaO6jmVh9CefF2pWBBYMIOOvREI8xjcPplEOAs3eWwKq
         qJxnVes7XxJodpQRyrOw0NdKocFHn4Lbk/LGgfLCHTLcR4j5qVom4RXSJ9vNQzII89VV
         7K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OuyIqKgz7v/jbyUuzEx+I0jFYUsMql7jJYGwohLQ7z4=;
        b=fpg1epXskggu9gKs9AWcpZ7LxgH6fK/peYL+7nnOuEXnAL50hdg49Qwm5MpAXh8pDT
         rbvNCMfQlew9sBU1IHX3Q05Lsylf3ST+wU76HufPRa0mzXnMe8q9Tq/UmH+zoAPCafxN
         7A5VrmAtKFGoEJpoZ0XPYxdFrW3CAgeJx7Ur8e/nEolLQeW6GOIYQqGWcQiRrE4pu2Bs
         onKrV4Q/sN3r/srq/5IhZxVdgNVq5kI6ofeYWwBcEZw2Gi0el0lAnrIE1X7JddSN5kCB
         VTxuFldg41MZABiHA8b6c3wccRm55i3d3ur1EJbcC1qkbHRGt7xf/m59snZ85KDcdxmT
         kXeA==
X-Gm-Message-State: AOAM532hObMu1DX/3jibTMLRFFrqHRk7UYBdlgdd+2ECzDs8bJwRjco0
        V0aPXcK4WC618xpngfqPzRJPaq8rxJKmwvRR8TE=
X-Google-Smtp-Source: ABdhPJw0Ryw/RSHATVqCXNRWVRRNOIv5RPnkcGlQCgXM2sPEtUWORGEHmkj2h38IZdTlC5H9k3cGxKGZML6BiK4qojs=
X-Received: by 2002:a05:6870:5b8a:b0:e6:589e:201d with SMTP id
 em10-20020a0568705b8a00b000e6589e201dmr6382090oab.71.1651498792514; Mon, 02
 May 2022 06:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220217143457.75229-1-cgzones@googlemail.com>
 <20220308170928.58040-1-cgzones@googlemail.com> <CAHC9VhSiqvCbKQHYTGAj3vqECNto6eNm0MyzLd92kcJnvZSw1A@mail.gmail.com>
 <CAHC9VhR1d2aLKsZOxLb6b1uuTcWOpnJ22S5=mXygvjcv6Sm=xg@mail.gmail.com>
In-Reply-To: <CAHC9VhR1d2aLKsZOxLb6b1uuTcWOpnJ22S5=mXygvjcv6Sm=xg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 2 May 2022 15:39:41 +0200
Message-ID: <CAJ2a_DeWWoSYwhmbNpSuDhve9KUfEnoPiHdd5s_CpKHRUbi8Bw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: log anon inode class name
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Guy Briggs <rgb@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 at 15:19, Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Apr 4, 2022 at 4:18 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Mar 8, 2022 at 12:09 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Log the anonymous inode class name in the security hook
> > > inode_init_security_anon.  This name is the key for name based type
> > > transitions on the anon_inode security class on creation.  Example:
> > >
> > >     type=3DAVC msg=3Daudit(02/16/22 22:02:50.585:216) : avc:  granted=
 \
> > >         { create } for  pid=3D2136 comm=3Dmariadbd anonclass=3D"[io_u=
ring]" \
> > >         scontext=3Dsystem_u:system_r:mysqld_t:s0 \
> > >         tcontext=3Dsystem_u:system_r:mysqld_iouring_t:s0 tclass=3Dano=
n_inode
> > >
> > > Add a new LSM audit data type holding the inode and the class name.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > ---
> > > v2:
> > >   - drop dev=3D and name=3D output for anonymous inodes, and hence si=
mplify
> > >     the common_audit_data union member.
> > >   - drop WARN_ON() on empty name passed to inode_init_security_anon h=
ook
> > > ---
> > >  include/linux/lsm_audit.h | 2 ++
> > >  security/lsm_audit.c      | 4 ++++
> > >  security/selinux/hooks.c  | 4 ++--
> > >  3 files changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> > > index 17d02eda9538..97a8b21eb033 100644
> > > --- a/include/linux/lsm_audit.h
> > > +++ b/include/linux/lsm_audit.h
> > > @@ -76,6 +76,7 @@ struct common_audit_data {
> > >  #define LSM_AUDIT_DATA_IBENDPORT 14
> > >  #define LSM_AUDIT_DATA_LOCKDOWN 15
> > >  #define LSM_AUDIT_DATA_NOTIFICATION 16
> > > +#define LSM_AUDIT_DATA_ANONINODE       17
> > >         union   {
> > >                 struct path path;
> > >                 struct dentry *dentry;
> > > @@ -96,6 +97,7 @@ struct common_audit_data {
> > >                 struct lsm_ibpkey_audit *ibpkey;
> > >                 struct lsm_ibendport_audit *ibendport;
> > >                 int reason;
> > > +               const char *anonclass;
> > >         } u;
> > >         /* this union contains LSM specific data */
> > >         union {
> > > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > > index 1897cbf6fc69..981f6a4e4590 100644
> > > --- a/security/lsm_audit.c
> > > +++ b/security/lsm_audit.c
> > > @@ -433,6 +433,10 @@ static void dump_common_audit_data(struct audit_=
buffer *ab,
> > >                 audit_log_format(ab, " lockdown_reason=3D\"%s\"",
> > >                                  lockdown_reasons[a->u.reason]);
> > >                 break;
> > > +       case LSM_AUDIT_DATA_ANONINODE:
> > > +               audit_log_format(ab, " anonclass=3D");
> > > +               audit_log_untrustedstring(ab, a->u.anonclass);
> >
> > My apologies, I didn't notice this in the previous patch ... I don't
> > think we need to log this as an untrusted string as the string value
> > is coming from the kernel, not userspace, so we could rewrite the
> > above as the following:
> >
> >   audit_log_format(ab, " anonclass=3D%s", a->u.anonclass);
> >
> > ... if you are okay with that, I can make the change when I merge the
> > patch or you can submit another revision, let me know which you would
> > prefer.

Feel free to adjust while merging, thanks.

> >
> > The rest of the patch looks good, thanks!
>
> Hi Christian,
>
> I just wanted to follow up on this as we are at -rc4 this week and if
> we want this to go during the next merge window this would need to be
> merged soon ...
>
> --
> paul-moore.com
