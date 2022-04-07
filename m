Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8334F71D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiDGCGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiDGCGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:06:01 -0400
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD00DB7C51
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649297031;
        bh=PCUUj9sh+ZXg8xzwNDbyH1JMDapK+OEbw32C9DX7m4c=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=ewgdipJCBn/zIN1Mx5ZPSt1EkQZXnk/Orl0xU1U79+mrfgHdXoXfzSQEs8KU2UM6J
         UvJY1f3JTU9FFQaX3jyp4UgyJ1nWP3BgLfKqT+AaMvCfxLLGqSSQbYCtOdpUAnMpJv
         uHDzq3yoVX0GUT6fvupevGk7AMf4tNA5WCmKj72c=
Received: from helloworld ([59.172.176.225])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id F12E2A3; Thu, 07 Apr 2022 10:03:49 +0800
X-QQ-mid: xmsmtpt1649297029tfj245p8a
Message-ID: <tencent_0D5C6E0E160AA0702025FDFF35906EE69E07@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jSx3AS0EqrsEW80j37bKcqodxlAv3QiavnCt/RjzS00hoUWAvhA
         IOCClT2yzvoKT9d3mbSdpJmk6HWk+5Lfwza9gmmbUCSMCIXRKSD5HnQ6jebInyoanQi56MVnI2oM
         iHMjKA6r96nPsstWxs247KCatE26nfiiom23UoGCKD877Kv89VN/04cCqCfyS993Csy9UUQpoHVW
         vLCaWSYWomWvO8UX2aCsmwK5OrkBdD7DCC8WHYWQsIuYYZa3wVQK2VlEoR+a3KWGLhIos6iKosjG
         qmE4EV/RA0Hg5Ryu19etchAtyeqFF/gxIkL+Tfc1rT0G6WNeCwfZ+EU4EEfQjFWRFBJfTtKFz638
         Yu9itb9lzIq/9Lr4fReGaGeMbgrns5cXTkWUiszs+tYArDX4dOI2w/PLvkpvwsuRXi2XTDMImxAD
         vjW4DEodhrHr96zvoEGGrjhc/E0hc8CaSaHruQBx/bRQxwX1LbdJHaQTOmssOGYSOt/ZQ4NXA/eO
         BiihNq+qEXrnMCGVdNpVQ5F+91f+7J2kVL4qyZ4sIc+grcH5vcljS6GCQmhITGD0kiOkV0UUw30S
         XmZNtJp2xxAKisfM294nzuksHMFoVD9p9zgaHAPkQD77Oc5Nvw7+C5Sjr7uNKzpWbOclmmYOSN6a
         fFHKTxdpsqe/ZuhFccpOZojYW/UY/RTORHGXbsHBkZQqU3Uz/kjDLWVnkmF27KhrY1d286JJrSXn
         qh6NcmGMANnE+dnG0BW1ZVRGImU0uplZmUa1P1JljoPloz0qGJA5y2xUfc+U4U/pcSXTf7Mtf4O7
         wnKOyeM2cPJvH1chxOq6ICcMMG0PjVnADOdDW+87SRcJr5K2MoRMffiTnghXLRolMeEpIq6GjHgA
         vcj5Kb5VCnmCdrGMmNwUICuwTMe+H26OHsKUB5bIPU3ynlG5ppH/QgwztS4j3KMg==
From:   <xkernel.wang@foxmail.com>
To:     <paskripkin@gmail.com>
Cc:     <gregkh@linuxfoundation.org>, <Larry.Finger@lwfinger.net>,
        <phil@philpotter.co.uk>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <tencent_5AB92A7786438342357C5669E7BF0C249505@qq.com> <tencent_15C23F2EC8197361EE200714C54E78B45206@qq.com> <9c307f1e-aa95-08e6-3a01-825caba19a30@gmail.com>
In-Reply-To: <9c307f1e-aa95-08e6-3a01-825caba19a30@gmail.com>
Subject: Re: [PATCH v2 2/2] staging: r8188eu: check the return of kzalloc()
Date:   Thu, 7 Apr 2022 10:03:49 +0800
X-OQ-MSGID: <006d01d84a23$ba562c30$2f028490$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHFCzdkIZn1ahtT3bex/Ulo9ihwXQEIO4NAAgMPs9ys8c3LUA==
Content-Language: zh-cn
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 7, 2022 3:22 AM +0800, paskripkin@gmail.com wrote:
> > -void rtw_alloc_hwxmits(struct adapter *padapter)
> > +s32 rtw_alloc_hwxmits(struct adapter *padapter)
> >   {
> 
> What about plain 'int'? I know that s32 is typedef for 'int', but 'int'
> looks more natural
> 

I agree with you.
Since the type of `_rtw_init_xmit_priv` is `s32`, I directly changed the
type of `rtw_alloc_hwxmits` to `s32` (they are neighbors in rtw_xmit.h).
In fact, there are many places where `s32` appears together with `int` 
in related files, so maybe we can leave it as a future work to make all 
of them a unified form.

Regards,
Xiaoke Wang

