Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9676E596124
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiHPR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiHPR2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:28:55 -0400
Received: from sonic316-54.consmr.mail.gq1.yahoo.com (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CAD4A10A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660670926; bh=KCxALGeHtNmf+3+P8Y4LRK3Lfy1e+K4XtBP8EuNrVm4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=M4nhksOD3u9NZzS/9aLZOPrS6gLu5DR9iCwBT0C8drb4ZlMuS+MFHgE/y3HhwbYtUufLeMsO31b+hYR37uYZSGVnBBH6fDqKcTRT4EIzXc7ueBlfFRunsEQT87PQ5TLV3os5wZbDwUHcRFLzjozujwVLwzPkUZUE4kLwvhzqwwZVNSShfKeXsFjc5r3W85iafy8GOx9Wgf5orhU7Av7jE0dHvpoDBvGHR+JFYO4qhtCc2qQAsQKDUy0B81Zzst1p1hsWpdergS8lwxz0c+8gJOKVZPz3kT8L/bA0N2EhNZuWHThFeSZkIw5qz/AH5+fAdABtazbmwviscGXy78hmmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660670926; bh=bkF1+RMhS2K5zivCW5WL/yunorG7Ih+jBW05ZZmojUM=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UPZ2XB8BTTjE3rUkAUIy1MR7E9Ngk3JICAFA8AELE9jVzjnwXfU3S7U/tmvWPd/Rfk+HBAQoZ18ey/H26fG8LPI48G12a4eRYf+UE2I3Queq6q91qjdnB53NJEJrOtKa+z4qVqcytEbsbUnv2576gxCV1AqWTQln09NPY+6xYRBdjtfmXqPn7o05nOP7prZXwD3asNA8D4PXj8mlFJQRVXdqKSsauEQUZ7ajUILRScusnku2gSfAf5IRhuYlngDEukcKeYUEDIJyHhDWite+2CVkyXtnWZ/YxFQ/X36E9gPpZdvx5EAkmZibxjqkAPoFJQl3vsLzMwrBgEf0As+Vhg==
X-YMail-OSG: eOwkS4MVM1myXdKg7_PGSnkSBeSzvsuUpKD7HJgzqIWkOcngW8.D1i9kBHAfCPh
 _RwIcAx_fxxLIYYnvtNAPVGk9tKKGSbNnJ6w.EvnEnNjiz5AabaFjIQTpb.nPOxWaVTIU_TtNJnj
 yoOxs6SGGqBf4vs0MVBswIC1ypaVPSI8jiGEUgcVKMN4QXOa2YRBlQxqm_3YIflnNnLDl6zvc.ZJ
 BtZ0rN77G8MBmQ6mb4Zvgy.z5oR6CaC4rteXNkibPa3yfZ8guysNECNrfMPoEaPVx1agKJGwPU3Y
 Xo6uIuq2Ha8s1g9VBoDdLKRgHSVZI_XMGIJtrHS46OQ5XHtuxSGz29yX3evsokvW.LxM3K6qTT62
 6vOUlJCKu6yW5WgsaENFeqCH3ASZVzKMgfE4NjFpTNM6NwKxHBYyeFy6GH8TWe74pLkawTz5.OwA
 qFyUC8Oks2nUYybY20sCfjd01sL3Hj6VUEN8AkJQEH1ufT4wkVDTgfu8kwSA7d5thElsmrvfqppj
 ut2N5nsxmvEfnm6S5BAGX1d8naDAEh1Kw15JTX4NwOEJp3qB4rEZ0nms9W4ynkPlgQki3ePyHo2n
 OgH1xWtbHiEjFoBag8ngTuFXZqWUFYPhoFQmnnx.v.aIQfWWx1.jDoJ1T6o21EUrhCMF4qaZfL2p
 jJyX8QFDyTIZGXHdqRJPW3BEOYUGupQWWW3934M_mmRIH_z4_aTAslk5_mPwCe3opgRqzKOHbmut
 xkJfvk0FI8M.mIwPRobNEDrLyELGKf51dN4DRtH9qSb8r12Ej.9Nahz7krJ.nXTLvWXCPsE0JpmX
 e6eIrlwj3pExi38ZlD4iKHwVS.TBikSSvjRhDy.ycw_FCi_evtm.64JSSKObgQPOZvcgSPnpgL2w
 0b4JL217wlYu_8ngi.jsOPzKr7Ledlqgj6IvcIn9l6zOs7DbffkdaKTXmfuXtTMHtw7zTWSPdC1v
 quyNdM_71gqk8HuvM2dMTBE.CjzMlBnEWRNwKLcZjnodkAifgXI3O685vbU6aYu7Ckgy_gDHncHC
 IkAudF_0yTrG3tu_mrc08Rcw1r7v90mGQLqVWEZ5wr3MQX.iT7i_O5HcPueDz1ECvhnPVT2JPLoZ
 eb28Eac9z.0y2Nv9cndKScZJhdVBIuV1NkkMPTMERW9AeBoUMRSpDn8kSl3yU0J0oULz3JKC1OQU
 u46g9cao0q8e56Z1H.up_tlm0DGGLTXaU4NXeFAjSOjs.h0yAhJh4RsQPatclGSUj4Il3eXMkNor
 cCU4dU5lvNZYJxA.5KBdx_CE21W4mKHpfvYu6xsuawCM3053t027pbXXHtWnHWsK_K1.Zn_4iZRx
 _Ry79F8PYo1WzQqIvlOx8gGrTaiRkDhdLa_KgwepDFpl5xD8sOhR1cSfyiZs9hTfNLyvvXRNTN4o
 RWd0N64Cdu0jMGBbQ.pCOsRJa.bT9kPbR5H6JROPnTsCU8mdqNFwbK5M_LgtCwWAqbtkDy8.lgFc
 sUz1mGrrFJPqq476R0MELwKvKxgn0WgA7tYarBcEJu_H9rjcUX8wmIcdWkeTi_B29JOqv7NDkG.b
 3.9qPDAohRnUK7mFgbbXZvFSs9FGmvsbwpgMVxQd2wldCBPo5HmXtO_gOn0TKJKZq8In96CbjWhj
 9qHdWQLvLPyYW5VJH1OqU7NcgLMu82w9EPt4INTIDRrOjjduwygCGVp4NO2mbJ0ncGVjhNSOhwGG
 WzroZwl4kI6EyLdHR_9ByoZPDiX8ZwnndqMvB2AQlH8znUAwSmWknyKxBIxaFwtPEWvYgiR0Jssi
 345DCR6mFXP2jlEnOzeLib48xo4psO2yq7Q4I9oSPqzI3VFXYiE6pd.x2uHNzLhKApXYmbj1NT1P
 FvyEYgKIixMKag0lVIXMfkWg2N.vWl29mwpLks0GSufqDaore2rJxFLT_txsRHR4uB5jhUGLXvSB
 479jMtNfcoutSQvFjpMTAqBj12_xK_A66ItvWaNOPs.aghuwijBAuPsPQST9LBur4RiZERTKu.CD
 _aGZ2ButJUkh3ldMkUY5HelBig.xSGusNci5BNCHrerFW9gxeoYL2MkPZrUJA50ltUV1Khe5I._I
 doYNLsdtZWuBJwVtolqPq.aVs5Qk0e_Vw9UG4jBT_Vqy3HQJ0yPkhXeBB8efX4Re1Hv88l_ygIfN
 ZpKi81dSiYCUlbujzMAscqZyj8kmQmT16UDgkJv3y_8eZ18E3DiSUputUK0Tx7hf1d8xrFW1QMj.
 aK.gbRODmwrBrGAjMqcvS
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Tue, 16 Aug 2022 17:28:46 +0000
Received: by hermes--production-bf1-7586675c46-6jlzf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f5181726492e835e0f6b4b78a77ba927;
          Tue, 16 Aug 2022 17:28:40 +0000 (UTC)
Message-ID: <5c40a423-f70a-abb8-360c-a601c5b157fe@netscape.net>
Date:   Tue, 16 Aug 2022 13:28:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     jbeulich@suse.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Juergen Gross <jgross@suse.com>
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
 <c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com>
 <bd66b5bc-4d07-d968-f46c-40cf624499a7@netscape.net>
 <a29a66e0-2075-8084-84ad-8bd3e8a9fd4a@netscape.net>
 <a7d10605-87e3-c4bd-4a76-f07a04f5751c@leemhuis.info>
 <8d148826-62a5-95f9-8662-be14f56a6336@netscape.net>
 <6b40ecc3-a2d3-3efd-4a19-2faf737f098b@leemhuis.info>
 <be9d077c-ed4d-d5e3-a134-33afff027af4@netscape.net>
 <6294958a-177a-5c67-47c6-3a95c23ac58e@leemhuis.info>
Content-Language: en-US
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <6294958a-177a-5c67-47c6-3a95c23ac58e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20531 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/2022 12:53 PM, Thorsten Leemhuis wrote:
> On 16.08.22 18:16, Chuck Zmudzinski wrote:
> > On 8/16/2022 10:41 AM, Thorsten Leemhuis wrote:
> >> On 15.08.22 20:17, Chuck Zmudzinski wrote:
> >>> On 8/15/2022 2:00 PM, Thorsten Leemhuis wrote:
> >>>
> >>>> And FWIW: I've seen indicators that a solution to resolve this is
> >>>> hopefully pretty close now.
> >>> That's good to know. But I must ask, can you provide a link to a public
> >>> discussion that indicates a fix is close?
> >> I just searched for the commit id of the culprit yesterday like this:
> >> https://lore.kernel.org/all/?q=bdd8b6c982*
> >>
> >> Which brought me to this message, which looks like Boris applied a
> >> slightly(?) modified version of Jan's patch to a branch that afaik is
> >> regularly pushed to Linus:
> >> https://lore.kernel.org/all/166055884287.401.612271624942869534.tip-bot2@tip-bot2/
> >>
> >> So unless problems show up in linux-next I expect this will land in
> >> master soon (and a bit later be backported to stable due to the CC
> >> stable tag).
> > 
> > OK, that's exactly the kind of thing I am looking for. It would be
> > nice if regzbot could have found that patch in that tree and
> > display it in the web interface as a notable patch. Currently,
> > regzbot is only linking to a dead patch that does not even fix
> > the regression as a notable patch associated with this regression.
> > 
> > If regzbot is not yet smart enough to find it, could you take the
> > time to manually intervene with a regzbot command so that
> > patch is displayed as a notable patch for this regression?
>
> regzbot will notice when the patch hit's Linux next,

IIUC, regzbot might not notice because the patch lacks a Link: tag
to the original regression report. The Link tag is to Jan's patch
that was posted sometime in April, I think, which also lacks the
Link tag to the original report of the regression which did not
happen until May 4. If regzbot is smart enough to notice that the
patch also has a Fixes: tag for the commit that was identified as
bad in the original regression report, then I expect regzbot will
find it.

Best regards,

Chuck
