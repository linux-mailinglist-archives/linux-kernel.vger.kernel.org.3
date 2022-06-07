Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676975426ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388752AbiFHAcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442755AbiFGW7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:59:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A93C27A91E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:05:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k16so25598807wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd5HmXzw2LiQl7Nbi5AmuOCXhxxQgLw+foKsZ+NlrZ8=;
        b=YSpmaKxMgWWXWlkkxWlzGY152XPpIKdfkW2FYUJ0o2OzjW8oslWYxLwlxMVkDxQm31
         s232FPT5okj5Amzsq9Kax2MHFPwDtgcEfsdFCIiQM8g9ILorj+a13NTCdvYwWk5zRlv6
         Dp4X+p6w9PBdDbdxntT/6zVjAhqLz0aMkbzXJnBfi7RSxhUsHnrTIAk5UbtfzSeYQ0Q0
         CQWZtPnV2X3WXO1ulVOZkztNFWDAgPOlWdbMuxOSgkjZUVZ0H1WEIANoeVrtjTqnKYco
         bX1gAbs5yHuHcxi6rYpuSQ3mK0+H53uEbyM46hwmBf122WwOgQd1v3mM9qx8nyvYjBM1
         wSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd5HmXzw2LiQl7Nbi5AmuOCXhxxQgLw+foKsZ+NlrZ8=;
        b=DYKjbacY5sh4q8X3s/u6xKDnWPV1jOFdj40OAeOwLxXxfX3V2OY3gH2r+tpY8kyfiQ
         Q8uSuOPmMwWnl2ZlauDdOrOeM6ygqC2m/m0ACeCnYKULmErbTvExLhleTI6FmrnCLA3K
         MvJ3DVwcLqWp2ljqQ7muBfv91/5qpEQgpegXnYlszpO+2kAS1ZaIs74gzJPqPMy8tkui
         4NfM9K3DbPo80ZkCGhivkBTtA++l47kn126PEfJGwIw7M4zrklWtXB0WY55FS3IQMvnP
         KOEYvxMMJ9wRr20X3LvGgkYCsCHGlaRJyJ2Qk6KUcDy2OpOLrNyUlrCfD7qDzD4o/OnX
         4Law==
X-Gm-Message-State: AOAM530O41kXIDE9CixedH9JWeMkKvb7BnOKtbdNpan2Vs8QwFKwELuf
        KzIyi2zotKLt/qygCnRmDJ01harpV3SVQlKyNbvaRbAlfA==
X-Google-Smtp-Source: ABdhPJyut9JzrwEhHN7uQfxWKSV6Z0lT4wSLEWR6jyWzpXrAYWB13JGzRQc+WT0vDTTfKFSSVrE7yduFRivHG5t6/js=
X-Received: by 2002:a5d:6d8c:0:b0:217:a419:c3f8 with SMTP id
 l12-20020a5d6d8c000000b00217a419c3f8mr15256654wrs.260.1654632342187; Tue, 07
 Jun 2022 13:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092137.141626-1-gongruiqi1@huawei.com>
 <CAHC9VhTj365p3SJvX+8eBqRO3wddnj0sXtRDp=jEhSdADwiGrg@mail.gmail.com>
 <6e2534c3-9af1-0c84-96ac-79075f79ab39@huawei.com> <CAHC9VhQRPqyMrja5L+8VTb-dsUrmb1cJq+wrQ5GyA5NupPLfZg@mail.gmail.com>
In-Reply-To: <CAHC9VhQRPqyMrja5L+8VTb-dsUrmb1cJq+wrQ5GyA5NupPLfZg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jun 2022 16:05:31 -0400
Message-ID: <CAHC9VhQypD0NdqVk2uW4NhMjf=zhv5Vb+LmATaEwY-RT+tF9hA@mail.gmail.com>
Subject: Re: [PATCH] selinux: add __randomize_layout to selinux_audit_data
To:     Gong Ruiqi <gongruiqi1@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 12:03 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, May 18, 2022 at 2:53 AM Gong Ruiqi <gongruiqi1@huawei.com> wrote:
> > On 2022/05/18 9:39, Paul Moore wrote:
> > > On Tue, May 17, 2022 at 9:21 PM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
> > >>
> > >> Randomize the layout of struct selinux_audit_data as suggested in [1],
> > >> since it contains a pointer to struct selinux_state, an already
> > >> randomized strucure.
> > >>
> > >> [1]: https://github.com/KSPP/linux/issues/188
> > >>
> > >> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> > >> ---
> > >>  security/selinux/include/avc.h | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> > >> index 2b372f98f2d7..5525b94fd266 100644
> > >> --- a/security/selinux/include/avc.h
> > >> +++ b/security/selinux/include/avc.h
> > >> @@ -53,7 +53,7 @@ struct selinux_audit_data {
> > >>         u32 denied;
> > >>         int result;
> > >>         struct selinux_state *state;
> > >> -};
> > >> +} __randomize_layout;
> > >
> > > I'll apologize in advance for the stupid question, but does
> >
> > Not at all :)
> >
> > > __randomize_layout result in any problems when the struct is used in a
> > > trace event?  (see include/trace/events/avc.h)
> >
> > No, as least it doesn't in the testing I did. I believe we can use the
> > struct tagged with __randomize_layout as normal except that 1) it should
> > be initialized with a designated initializer, and 2) pointers to this
> > type can't be cast to/from pointers to another type. Other operations
> > like dereferencing members of the struct (as in
> > include/trace/events/avc.h) shouldn't be a problem.
> >
> > I did a testing to the patch on a qemu vm by running the selinux
> > testsuite with tracing events "avc:selinux_audited" enabled. The
> > testsuite completed successfully and from the tracing log I saw nothing
> > abnormal with my bare eyes. You can do more testing if you want or you
> > have other ideas of how to do so ;)
>
> That's great, thanks for verifying this.  I was aware of the other
> restrictions but wasn't sure about tracing.  Now I know :)
>
> It's too late to go into selinux/next for this dev cycle, but I'll
> queue this up for selinux/next once the merge window closes.

I just merged this into my local selinux/next branch and I'll be
pushing it up to the mail selinux tree later today - thanks!

-- 
paul-moore.com
