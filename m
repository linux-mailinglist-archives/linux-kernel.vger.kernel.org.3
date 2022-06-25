Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7878755AD6A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiFYXYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiFYXYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:24:04 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7D8E08D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:24:03 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p136so4441404ybg.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=snp3iGaqneZhCYcg+mJvYJdoRp3WEYe5KB6c2iCBNGY=;
        b=mX7ki9rdSmFBpOM7J2F6TpAVrh+q9AOugB561QqMKdnnPsvj7lTxpDAjw1YZrpr/lK
         a6o/OSuXHO4aVEEvTgYx8Z4S0zLR7B7bqICfUPf4E519FKemyslijarshb7JNYNP7sF4
         U5yMjul43oUFF8uyxSxEzDyIl5zobf7y+ju6Zm8OiYxEpGcyxse7I1jKnapm3DAvHO+7
         D1aJo1feW7h5ZI6P//qg3y9oHuqPFu7gJw1rDlGPpNFDlHwPsohM0bhQaFMWRgY495qi
         pECOfUBgU/hXN7H8y2pXjMMYW7tCMCF2fTr4DbhBZuzwylronNmHSQO26HtfIPHr1k73
         x7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=snp3iGaqneZhCYcg+mJvYJdoRp3WEYe5KB6c2iCBNGY=;
        b=ENyzjw/ySWXtdzt3cL/+pCyDKRgM+r2qwALqIH80xC6/X5vbx64Ur4bTqZJZnqEw5b
         l9P969ITOclnRGib+zk4ABO7nJnqhrNpkoh6+EKZ70hC59Qn+QSJa9EJTB2p1STi2AVw
         DqMAHfYhMmbRSPsYnaKrLiI1KrtEFOhp3ggS4uu53VPm0ElYSUR5UIx2sxwN5+gVRQ3Q
         X1pV/noRZd7jQgarfUByVxOuojUEweBArf7Jh4sp8iMf7ISFaZb844RIceJE73tOBDn9
         x/ZS4wE7iOGaZZ6e63r5FKi5BzhDRGPtJC2m8oWkGF+OFV5MoASnZj4oEd0hr2ORpJUy
         7Ubg==
X-Gm-Message-State: AJIora+/IFswcEs76NhcvzYlE4pzDL/cq3fBV6zyR5XRro4zST75Q/Tz
        27HIChTnDK8IKMrU/SZHruprEqkU+HvFb2B+DQChYQ==
X-Google-Smtp-Source: AGRyM1v4F5AeLVv70A169NE0jVQ7LLku1NuKEEf7NHHauCphgfotPTI5cBGnpuqg7yZrgwUSLBTpBG0C9goQXoQgre4=
X-Received: by 2002:a25:7255:0:b0:668:a372:b433 with SMTP id
 n82-20020a257255000000b00668a372b433mr6460882ybc.626.1656199443079; Sat, 25
 Jun 2022 16:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220531221954.160036-1-nfraprado@collabora.com>
 <CACRpkdYe=qhUvyCw-xKRUihWiaezaEyQdHFhPt2aD6bmkWTpBw@mail.gmail.com> <20220615142349.qgxsnaln7mtbhgur@notapiano>
In-Reply-To: <20220615142349.qgxsnaln7mtbhgur@notapiano>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Jun 2022 01:23:51 +0200
Message-ID: <CACRpkda1TDihnE1u+zVqn6_H6eQ3nDvRh1KTx7m_Yp+x_15Uqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] MT8192 pinctrl properties adjustments
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 4:23 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
> On Wed, Jun 15, 2022 at 03:31:00PM +0200, Linus Walleij wrote:
> > On Wed, Jun 1, 2022 at 12:19 AM N=C3=ADcolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> >
> > > The two patches in this series substitute properties in the mt8192
> > > pinctrl dt-binding for ones which have a clearer meaning and are more
> > > standardized. At this point there's no DT using the mt8192 pinctrl
> > > binding, so if such changes are to be made, they need to happen now.
> > >
> > > v1: https://lore.kernel.org/linux-mediatek/20220525155714.1837360-1-n=
fraprado@collabora.com/
> > >
> > > Changes in v2:
> > > - Dropped Fixes tags
> > > - Added 'if' blocks to enforce mutual exclusion of properties
> >
> > This does not apply on the current pinctrl devel branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.gi=
t/log/?h=3Ddevel
> >
> > Could you please rebase onto my branch and resend as v3?
>
> Hi Linus,
>
> I checked out your branch locally and was able to apply the patch cleanly=
. Maybe
> you haven't pushed out all your local changes to that branch yet? Otherwi=
se let
> me know and I'll send a rebased v3 to see if it helps in some way.

Doing this:

[linus@fedora linux-pinctrl]$ b4 am -t -S
20220531221954.160036-1-nfraprado@collabora.com
Analyzing 8 messages in the thread
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH v2 1/2] dt-bindings: pinctrl: mt8192: Switch
drive-strength-adv for -microamp
  =E2=9C=93 [PATCH v2 2/2] dt-bindings: pinctrl: mt8192: Use generic bias
instead of pull-*-adv
  ---
  =E2=9C=93 Signed: DKIM/collabora.com
---
Total patches: 2
---
Cover: ./v2_20220531_nfraprado_mt8192_pinctrl_properties_adjustments.cover
 Link: https://lore.kernel.org/r/20220531221954.160036-1-nfraprado@collabor=
a.com
 Base: not specified
       git am ./v2_20220531_nfraprado_mt8192_pinctrl_properties_adjustments=
.mbx
[linus@fedora linux-pinctrl]$ git am --signoff
./v2_20220531_nfraprado_mt8192_pinctrl_properties_adjustments.mbx
Applying: dt-bindings: pinctrl: mt8192: Switch drive-strength-adv for -micr=
oamp
error: patch failed:
Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml:80
error: Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml:
patch does not apply
Patch failed at 0001 dt-bindings: pinctrl: mt8192: Switch
drive-strength-adv for -microamp
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Yours,
Linus Walleij
