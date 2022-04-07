Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1C4F7222
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiDGCiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiDGCiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:38:17 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF2029829
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:36:17 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i15so4045128qvh.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 19:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=+wiEiEBvfqMK7vD0yutIlibA0Tc+znw73+00dq2SFVo=;
        b=OG+xhOfQK5Xuxz2rciHCm6J8j5xZrHaAmhfjLTh7X3aAb+0SEsUOeeVAky5AqMNjx7
         mli22qVHf1BqUPj52/PXEtOHyjGM/Qv2sQgJb0G4qFIbHuBRfX8TG99kagvH4B7QL4LT
         PxGqqKLvC28yxfgAqIeMkdIDrKMjMm/2aFAfvgSPpPCb5mSnz4VY4/WOl+G4svNzdcio
         VgeJVZE2YhwAHATo17Ij5GAHFwzUZznPWF8AU90u79mUXdSxCqqlllOjFOJ7L1C5HexA
         0iCtG2VidJVwJE+6ChMjNEAGnSitTOv1VWY9owMLN6AuEvI5EOm67q7zkTe1KCa7xKaZ
         nqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=+wiEiEBvfqMK7vD0yutIlibA0Tc+znw73+00dq2SFVo=;
        b=eMO4bPRyqc1IHRzbIfF9rCMVdlTlPmTxvEq1+reHdr0JPE5QiXuGFCGu3/wJccutB3
         bodxIAlVET7aMkBZ0eVEAsBjX5bvd/GbEI7CTNhqybIlAHG6OqV6PKlghqWHdqEcyGkO
         iCx+zX4atvoKthPEFrfyqDUaQ/Y4cc+NIwQ9cvCQTvcTjnVjMk5TZNuulit2gs0MmBJt
         X2pzHbN1Ov+HQcrrUJ+0XdSKeWK6XxamoIhz9IxFNigNp+Zkj8x60jeRzFpIwExoVVHT
         wyP+a6rDt8+0+sUcNhpPYsYGkYADcfnGALL2Mx8OEotVH2onEKyV0JXmI4N5vH0jKAGW
         6DXA==
X-Gm-Message-State: AOAM530RrOliz5Sk29wPU6xZgOOrFkr5Ur50sRynnUPqUSDdfR9edXTZ
        eBBlGWXGqegrnPTv1TJt8UM=
X-Google-Smtp-Source: ABdhPJw/UuIJfR5hw6G26YaITwV+j30lXwkq/19u9f8SWv2XCjz9iu2ixasewCWkA7dvK6GnzkkiJg==
X-Received: by 2002:a05:6214:411e:b0:443:d734:df45 with SMTP id kc30-20020a056214411e00b00443d734df45mr9934133qvb.46.1649298976620;
        Wed, 06 Apr 2022 19:36:16 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a9-20020ac85b89000000b002e2072c9dedsm15758392qta.67.2022.04.06.19.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 19:36:15 -0700 (PDT)
Message-ID: <624e4e1f.1c69fb81.7e74e.f971@mx.google.com>
X-Google-Original-Message-ID: <20220407023612.GA2490044@cgel.zte@gmail.com>
Date:   Thu, 7 Apr 2022 02:36:12 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, kbuild-all@lists.01.org,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        eparis@redhat.com, dai.shixin@zte.com.cn,
        Yang Yang <yang.yang29@zte.com.cn>, linux-audit@redhat.com,
        ink@jurassic.park.msu.ru, huang.junhua@zte.com.cn,
        guo.xiaofeng@zte.com.cn, mattst88@gmail.com
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <CAHC9VhTaCNqfTOi8X5G3AheBFzTYCzGnt_-=fNFc5Z1o8gPm9Q@mail.gmail.com>
 <62465bf3.1c69fb81.d5424.365e@mx.google.com>
 <2777189.mvXUDI8C0e@x2>
 <CAHC9VhRYHhHPx42BKa0gp974uzwHoXZWqmwt9o=1rox7tHyy1w@mail.gmail.com>
 <624803f7.1c69fb81.972da.2dd0@mx.google.com>
 <YksVuhfv8weLCxX/@madcap2.tricolour.ca>
 <624cea8e.1c69fb81.422be.e03b@mx.google.com>
 <Yk3Esn2Fu0lVX2SZ@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk3Esn2Fu0lVX2SZ@madcap2.tricolour.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 12:49:54PM -0400, Richard Guy Briggs wrote:
> On 2022-04-06 01:19, CGEL wrote:
> > On Mon, Apr 04, 2022 at 11:58:50AM -0400, Richard Guy Briggs wrote:
> > > On 2022-04-02 08:06, CGEL wrote:
> > > > On Fri, Apr 01, 2022 at 10:16:45AM -0400, Paul Moore wrote:
> > > > > On Fri, Apr 1, 2022 at 9:39 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > > > On Thursday, March 31, 2022 9:57:05 PM EDT CGEL wrote:
> > > > > > > On Thu, Mar 31, 2022 at 10:16:23AM -0400, Paul Moore wrote:
> > > > > > > > On Wed, Mar 30, 2022 at 10:29 PM CGEL <cgel.zte@gmail.com> wrote:
> > > > > > > > > On Wed, Mar 30, 2022 at 10:48:12AM -0400, Paul Moore wrote:
> > > > > > > > > > If audit is not generating SYSCALL records, even for invalid/ENOSYS
> > > > > > > > > > syscalls, I would consider that a bug which should be fixed.
> > > > > > > > >
> > > > > > > > > If we fix this bug, do you think audit invalid/ENOSYS syscalls better
> > > > > > > > > be forcible or be a rule that can be configure? I think configure is
> > > > > > > > > better.
> > > > > > > >
> > > > > > > > It isn't clear to me exactly what you are asking, but I would expect
> > > > > > > > the existing audit syscall filtering mechanism to work regardless if
> > > > > > > > the syscall is valid or not.
> > > > > > >
> > > > > > > Thanks, I try to make it more clear. We found that auditctl would only
> > > > > > > set rule with syscall number (>=0 && <2047) ...
> > > > > 
> > > > > That is exactly why I wrote the warning below in my response ...
> > > > >
> > > > I think the question is more clear now.
> > > > 
> > > > 1) libaudit.c wants to forbid setting invalid syscall, but inconsistent
> > > > Currently way(>=0 && <2047) is inconsistent, syscall with number 2000 and
> > > > syscall with number 3000 are both invalid syscall. But 2000 can be set by
> > > > auditctl, and 3000 cannot be set by auditctl.
> > > > A better way to do this forbidden is to use __NR_syscalls(asm-generic/unistd.h).
> > > > 
> > > > 2) if libaudit.c do the right forbidden, kernel better ignore invalid syscall
> > > > See this patch.
> > > > 
> > > > If we want audit invalid syscall as you said before. libaudit.c should not
> > > > do the forbidden, auditctl should allow setting syscall rule with 'any' number.
> > > > So do you think we should fix libaudit.c?
> > > 
> > > I'm having a bit of trouble understanding what you've said above.
> > > 
> > > The kernel ultimately must protect itself from malice and mistakes, so
> > > it must verify all data sent to it.
> > > 
> > > Userspace can help by knowing what that kernel policy is so it can avoid
> > > violating that policy or provide useful feedback if it can't.  Userspace
> > > can be used to make things more efficient, but the kernel is the last
> > > step for security.
> > > 
> > > If userspace and the kernel are mismatched or out of sync, then the
> > > kernel enforces policy to protect itself.
> >
> > Much appreciate for your interpretation. Have you get any idea of how
> > to solve the mismatched? From your viewpoint, I think it's better for
> > kernel to not handle syscall of syscall number<0, because it's invaild
> > of all arch, and has no value for attacker to probing for specific
> > syscall numbers.
> 
> Going back to the very first quoted line above, if you can generate a
> test case that shows that audit is missing an auditable event, that is a
> bug that should be fixed.
>
To reproduce "missing auditing invalid syscall":
1.add audit rule
auditctl -a always,exit -F arch=b64 -S all
2.run program with invalid syscalls
Code as below. Both syscall can not be audited.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <fcntl.h>
#include <errno.h>

int main(int argc, char * argv[])
{
	int syscall_num = -1;
	syscall(syscall_num, 0, NULL);
	printf("syscall num is %d errno is %d, %s, %d\n",syscall_num, errno, __FILE__, __LINE__);
	
	syscall_num = 3000;
	syscall(syscall_num, 0, NULL);
	printf("syscall num is %d errno is %d, %s, %d\n",syscall_num, errno, __FILE__, __LINE__);
	return 1;
}
> > > > > > > > to the audit syscall filter, which are unfortunately baked into the
> > > > > > > > current design/implementation, which may affect this to some extent.
> > > > > 
> > > > > -- 
> > > > > paul-moore.com
> > > 
> > > - RGB
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
