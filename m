Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8425230A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiEKK0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbiEKK0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:26:24 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F828716
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:26:18 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4KyrfS4WZhz9spJ;
        Wed, 11 May 2022 12:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1652264768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/E1vKB93vrG/DjRCzLKzwqBALm4NpArvjus/ourHbI=;
        b=k8G6LO/DA2hkLYEA4a/jti/zyEqH+lLwPnhhAIg00NLSzA8dFGBzwZhjEyddtDJLG3Vqtx
        3Hfgh/KESeU2q0Gw3XmFYEv5SohRvJ9OmQ0KtNd+AsM/0RZ4CtNKQKLVz3qvG7MNiLRA/8
        hV5lPw77oNCmAbG/y34GKc2R3BkkcJkYNWyp7x4MuZlJmMDy7hV6XZvhZ48GrkYg/y6kP/
        Pe25JiyS+7TgQAiMk6Nv3aOyN9XhrIOaN1xn89Fs+TB070DOxvp+q8L1+fIyUGWK67T+KX
        bnk1uVDGBkRI0+yZao76NBnnBcpEyLkexJXAszQCzAVpSOj9nfjih2CEcl0QKA==
Message-ID: <1255a66a-121d-988a-19a7-316f703cb37d@mailbox.org>
Date:   Wed, 11 May 2022 12:26:05 +0200
MIME-Version: 1.0
Subject: Re: Adding CI results to the kernel tree was Re: [RFC v2] drm/msm:
 Add initial ci/ subdirectory
Content-Language: en-CA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Airlie <airlied@gmail.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, Sean Paul <sean@poorly.run>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220510070140.45407-1-tomeu.vizoso@collabora.com>
 <20220510141329.54414-1-tomeu.vizoso@collabora.com>
 <CAPM=9tzLR-wsLhg2ikGjoK06s-ju5XWa1rtPPiUpN=pwD1vgtA@mail.gmail.com>
 <YntWQIXSqMCd6TYV@kroah.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <YntWQIXSqMCd6TYV@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f1u1x9t1eq9gx7t66636ikwanw7e56pm
X-MBO-RS-ID: 8072a6e3cb6bccf98f1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-11 08:22, Greg Kroah-Hartman wrote:
> On Wed, May 11, 2022 at 03:06:47PM +1000, Dave Airlie wrote:
>>> And use it to store expectations about what the drm/msm driver is
>>> supposed to pass in the IGT test suite.
>>
>> I wanted to loop in Linus/Greg to see if there are any issues raised
>> by adding CI results file to the tree in their minds, or if any other
>> subsystem has done this already, and it's all fine.
> 
> Why does the results need to be added to the tree?  Shouldn't they be
> either "all is good" or "constantly changing and a constant churn"?
> 
>> I think this is a good thing after our Mesa experience, but Mesa has a
>> lot tighter integration here, so I want to get some more opinions
>> outside the group.
> 
> For systems that have "tight integration" this might make sense as proof
> that all is working for a specific commit, but I can't see how this will
> help the kernel out much.
> 
> What are you going to do with these results being checked in all the
> time?

Having the expected results in the tree keeps them consistent with the driver code itself, and allows putting in place gating CI to prevent merging driver changes which make any of the tests deviate from the expected result.

Keeping them separate inevitably results in divergence between the driver code and the expected test results, which would result in spurious failures of such CI.


I expect the main complication for the kernel will be due to driver changes merged via different trees, e.g. for cross-subsystem reworks. Since those will not go through the same CI, they may accidentally introduce inconsistencies. The ideal solution for this IMO would be centralizing CI such that the same gating tests have to pass regardless of how the code is merged. But there's likely quite a long way to go until we get there. :)


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
