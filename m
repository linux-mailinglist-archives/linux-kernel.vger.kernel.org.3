Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D72589D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiHDOb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiHDObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:31:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4939D2613B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:31:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q19so10158255pfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=XofKKYn9mg4q2gO9bGVy8AclmRqAoUii/QmsbgRgaS8=;
        b=HD+lXJyFfIstm0aujJ3DDbrX/PjX1DxWXvUKlIutcTgaczaKGQ3e1ezORvHlh4A8Gd
         /2rEXYpJM82RDeCzLexFcEdt0x5WfQ1Eyi4O4rj5LaK5N2CPBR6KRyip66xldDuJ0RyR
         L7J8XREAOyu4FzlNWngWa0gdv0bFrwlRF0upI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XofKKYn9mg4q2gO9bGVy8AclmRqAoUii/QmsbgRgaS8=;
        b=n3oM9XiEdP9+y7PAneGCGBGmsNM2lOSGCedN0QFrh2ieZWcLH5VllPKbVUCGh+8Qg0
         dfYfPs2NzNoN5qYNe/0KbNOe9/GCYpE6Qd4JCPPlB1A2PuwNavIHDUIUgzZZK5RmzcIa
         O1w//qhls+2E9CqbnFc3LTEcNSNEufk6FDrrdGSvv6WSwZHyv9SktMHwzKSN4+ssShjU
         w+LfxrET5ZJMYbmiyGowBnupogLw3JvOBCI1yXEweG1hfaZpMClhZSAF5cJ64epcW4XS
         Q42tfHgGqgU7DHLUstFzbWPlVVeaHA/HOJjtj0msqhCO7LV9R3QB9GC1KXvdqtytNPDN
         WhmA==
X-Gm-Message-State: ACgBeo3kDXvEszlWNbLOrF7nVsuauPwO5+b8bL6l9hJ3VuUHf/fesXCj
        J7FlBRCYvDA1/VtQY4PMp/NojQ==
X-Google-Smtp-Source: AA6agR6+kxmYi4rGXBBduaHFPdI7d8y6iZUYG1KmbYRV4+suVzRcXDM09XZwvIdCLtlMw66nOpQAwA==
X-Received: by 2002:a63:6d1:0:b0:41c:45d:7d49 with SMTP id 200-20020a6306d1000000b0041c045d7d49mr1860456pgg.437.1659623483705;
        Thu, 04 Aug 2022 07:31:23 -0700 (PDT)
Received: from chromium.org ([2620:0:1000:5e10:630b:1bd3:aad8:74fd])
        by smtp.gmail.com with ESMTPSA id w200-20020a627bd1000000b005281d926733sm999612pfc.199.2022.08.04.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 07:31:23 -0700 (PDT)
Date:   Thu, 4 Aug 2022 07:31:20 -0700
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6] firmware: google: Implement cbmem in sysfs driver
Message-ID: <YuvYOOvQqg424LoS@chromium.org>
References: <CAODwPW-eQ-dYvfCGZ13tOzh4gPdLU9ZoFg9joWpRTX22OXa4Ow@mail.gmail.com>
 <20220802140343.3468976-1-jrosenth@chromium.org>
 <YuuBrUmiRYoaSmPw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuuBrUmiRYoaSmPw@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-04 at 08:22 +0000, Tzung-Bi Shih wrote:
> On Tue, Aug 02, 2022 at 07:03:43AM -0700, Jack Rosenthal wrote:
> > Link: https://issuetracker.google.com/239604743
> 
> I doubt if the Link tag would be useful for public.

Thanks, made the bug public and kept the link.

> > Reported-by: kernel test robot <lkp@intel.com>
> 
> Suggest to drop the Reported-by tag even if the robot reported some compile
> errors during the development.  Given that the patch isn't a fixup but
> supporting something new (which isn't "reported by" the robot).

Done.
