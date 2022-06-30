Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3F561FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiF3QJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiF3QJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:09:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D127CC8;
        Thu, 30 Jun 2022 09:09:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a15so18539975pfv.13;
        Thu, 30 Jun 2022 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KwsSHKLHRHeZ0d5jA7PWaCGAaPUqT4/TqEpXIIwB1VY=;
        b=VIFAbWG/kO4gzWSlyJ9yQgKHfRV/ICX1iG9a/ei94noNZzpa9U/dWDAe9JSWDUBRoh
         qy9T486Wu3Q4nLrNRiQNa1HrCjqw99DJbxlKTzkgix/osKU5IYKhpiE5KRKq6Xyj8laA
         cevib/mnKf6TB6lMjzCR55DT1LOMc6jsF8RM3vrlTKmdzYALB2EMuwU6gGsTiFDdjWHQ
         eTI8x8gXst8QHFIgZANgIEiBRWs1SOfm6Nk+QjZWCKDOUomUuvd3rXybh/NV1MpDOnbE
         kBA/UERHkSIv5Fwm/GKXG5xuSkOIblaIlg6HjnYSAq8pR4n1KGR1TONZNkvLWdyorhJz
         GN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KwsSHKLHRHeZ0d5jA7PWaCGAaPUqT4/TqEpXIIwB1VY=;
        b=ccL5lQ2Z3NuJ84f9dhMhFIBYToLGdS/JQ8h/si8S9+pKPT8VSwrJBMo7N5yOhkw/9N
         tZu15MoZ4zKIRyywAfVkT33FQPQXpm/tUvZwVlGohmoKCur5dYSiUbJV/XqUQwrj3BPB
         xlEg7PFLFgIxMwCWkb48GfjIEOOFtovsHBzd4h9L63xJS7gcEKUfBkES3cVMJQtsK7MN
         ltp0v5gROBM77bAO9BB0nkM0bqWv6v9yqYsLW7LNvufvDBDvpxU2RRmGL1av3503fyza
         RwRqz1I1K0K2B96eCC6pDY+kjxPRsS/hS1yPVYNUCXhJmSTt39kQCzIwy5tey2GW8vmV
         OLig==
X-Gm-Message-State: AJIora9ys+DpyEzOHmnarZg/r0rA2DmWIrjkRJU0ykhNu/ls5jBr/hVp
        uYFgjkQH+AtdAloE6nEN9K4=
X-Google-Smtp-Source: AGRyM1sMsMYRLHKnhpVNZxh9qvjcZFmYSohiiYSVMmKD5eVHyVENMkBfA55O3jSOPBloWV3IOQ/IOA==
X-Received: by 2002:a65:684c:0:b0:411:b3d3:a7f7 with SMTP id q12-20020a65684c000000b00411b3d3a7f7mr2083847pgt.448.1656605389072;
        Thu, 30 Jun 2022 09:09:49 -0700 (PDT)
Received: from praghadeesh ([2409:4072:6d1a:bac4:80b2:d21d:c273:e2aa])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090b078400b001ec92575e83sm4715815pjz.4.2022.06.30.09.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 09:09:48 -0700 (PDT)
Date:   Thu, 30 Jun 2022 21:39:41 +0530
From:   Praghadeesh T K S <praghadeeshthevendria@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, praghadeeshtks@zohomail.in
Subject: Re: [PATCH] docs: fix 'make htmldocs' warning in leds
Message-ID: <20220630160941.GA70425@praghadeesh>
References: <20220627214311.7817-1-praghadeeshthevendria@gmail.com>
 <e2eee869-3e72-ea18-6afc-73fe5bc5dbd3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2eee869-3e72-ea18-6afc-73fe5bc5dbd3@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 07:31:54AM +0700, Bagas Sanjaya wrote:
> On 6/28/22 04:43, Praghadeesh T K S wrote:
> > Fix following 'make htmldocs' warnings:
> > ./Documentation/leds/leds-qcom-lpg.rst: WARNING:
> > document isn't included in any toctree
> > 
> > Signed-off-by: Praghadeesh T K S <praghadeeshthevendria@gmail.com>
> > ---
> >  Documentation/leds/index.rst | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
> > index e5d63b9..b9ca081 100644
> > --- a/Documentation/leds/index.rst
> > +++ b/Documentation/leds/index.rst
> > @@ -26,3 +26,4 @@ LEDs
> >     leds-lp55xx
> >     leds-mlxcpld
> >     leds-sc27xx
> > +   leds-qcom-lpg
> 
> Hi,
> 
> I had already sent the fix at [1] (resend at [2]). Thanks anyway.
> 
> [1]: https://lore.kernel.org/linux-doc/20220604015735.249707-1-bagasdotme@gmail.com/
> [2]: https://lore.kernel.org/linux-doc/20220612000125.9777-1-bagasdotme@gmail.com/
> 
> -- 
> An old man doll... just what I always wanted! - Clara

Hi,

Thanks for your reply.

Thanks,
Praghadeesh
