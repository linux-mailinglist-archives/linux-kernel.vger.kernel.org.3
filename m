Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA8A4EFA66
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351630AbiDATbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiDATbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:31:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4CE175853;
        Fri,  1 Apr 2022 12:29:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d30so3314614pjk.0;
        Fri, 01 Apr 2022 12:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0shfvy/fPUsWtO9pWkOF1b2wqeGp1bpB57Bxyy5guiI=;
        b=ZXat4C1nJtL9qvQF4az+scfE9LZ6u6+EHLhaJv4Tp87XcZ/qPqqjJvI7aJvufBRFCT
         kPS7LSQ5DruVAyMQDYJOCBV20VBPPJQqOglud7UOxwlrB4qK5jSkTSoQzg+1JkuyHq3N
         j/p4WlOZGK/1MFxttaVFDHOshbnDQbthOOsnNhLEcCl1AR0lvRrM3iQeeZO0VaD/UTb+
         SXH9cOe2DeGZXOH0c/N97GMZvnuSZoO8QIvrGZ6PWBjcMtV7gD6qwzQiXHlfFmQPk2z/
         E6yWd7wC4Je+ucbJYrlsw2tDkmpzHx9t0A6m/IggdBqU5fqv5e7oF1QFpTxhOM4Ey4lA
         XRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0shfvy/fPUsWtO9pWkOF1b2wqeGp1bpB57Bxyy5guiI=;
        b=BmdDDrUzW3Nq8jH8XRf1deFYBZ0LlIFisdexOWJJSySkz3d23To4C1lZkL4fqllRc8
         jMfwG8ztcTvBQptyQ+xu2s8xmGaX0DLEW13chVDemvoyvT+ll4H8YxhIU/lIYxm0dVW/
         jhVC8WZh5rzcbuI+mdMLipYl2OIRgeZKhtFN+9c60EhHBfNu3rslrOcir8mSLYBjZFiA
         4iOemYGJ8RV6H6T+zE9fpxCVPgtI4OJxLBjCK0TUmlWJrzvhZXPm2ilqYvP6+n1J/j85
         qaQUYezCm/gf82wbEn37ww2rpD8ZWXMAP7tfXqU9a+FCDZpjsn6+Xco8NdzajQOFpYUJ
         v2WA==
X-Gm-Message-State: AOAM533A1dDHzlDoNJ+nJZohW0x2gCzz4b9YCJcn8UvYTlDkmdsnEML9
        gNt847zIuWfEk578uI+JSBg=
X-Google-Smtp-Source: ABdhPJwpzVfyWNERknJm4J4Y4bNmiOHbAI35odkY6/BnP64cxxv+Eop9x+GRsYWZKMIxR+yz+2y3ew==
X-Received: by 2002:a17:902:d346:b0:155:d034:2cef with SMTP id l6-20020a170902d34600b00155d0342cefmr11572917plk.79.1648841381353;
        Fri, 01 Apr 2022 12:29:41 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:70b1:2e48:cb83:26e1])
        by smtp.gmail.com with ESMTPSA id s24-20020a63af58000000b003981789eadfsm3043794pgo.21.2022.04.01.12.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:29:40 -0700 (PDT)
Date:   Fri, 1 Apr 2022 12:29:38 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [git pull] Input updates for v5.18-rc0
Message-ID: <YkdSoimi0kGPqwFo@google.com>
References: <YkZ+K2Gtt75y1/O+@google.com>
 <CAHk-=wgdff1hwOzT+SHzKMGbr+3zc553WU5zvNNbZLdT1TsTNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdff1hwOzT+SHzKMGbr+3zc553WU5zvNNbZLdT1TsTNg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Apr 01, 2022 at 10:19:52AM -0700, Linus Torvalds wrote:
> On Thu, Mar 31, 2022 at 9:23 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> >         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> I've been watching _almost_ all the pull requests I get this merge
> window be nice signed tags.
> 
> Yours is one of the fairly few ones missing a signature.
> 
> I've pulled it (kernel.org and all that), but I'd like to get it to
> that "everything" stage.
> 
> I can see your pgp key in the kernel.org key repository, I just don't
> think I've ever gotten a signed tag from you.

Yeah, I have not been signing anything mainly because my kernel tree is
on my headless workstation in the office and my smart card is with me
(potentially elsewhere) and I simply ssh into my workstation. I will
need to figure out how to forward GPG agent there, especially if I am
using a Chromebook instead of my Linux laptop.

Thanks.

-- 
Dmitry
