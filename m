Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A43F5876E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiHBFvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiHBFvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:51:41 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188246DBD
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 22:51:38 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220802055133epoutp04eb6aadfb34ae32f8ca25b51585ba866b~HcTyoNKmd3164431644epoutp04i
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:51:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220802055133epoutp04eb6aadfb34ae32f8ca25b51585ba866b~HcTyoNKmd3164431644epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659419493;
        bh=H7CRy6JDMDRuNGpJQxwZ2Kh8KSu5JTGg+Qhah4kZcCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F/74IQlNX/P07yzDjIWdvjLG8jo87p0w0j4Zz1lPB7SO9wmOl6BXBVTFymi3B4UHl
         /6TNUZoCMJL/YZVd0aiA41QDAhhaJVxsoYMEDBBPDhSQ3wwXNNPEdu2EcY9iE2+/Xu
         vR9I1J2s3C/MHq8fkKqoyLT7cIs5WcvZWe59NmwU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220802055132epcas2p2ab5e197626e79450bc585a0acad3b70e~HcTyEqjuQ1328313283epcas2p2R;
        Tue,  2 Aug 2022 05:51:32 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LxkdH60Cbz4x9Py; Tue,  2 Aug
        2022 05:51:31 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.5B.09642.36BB8E26; Tue,  2 Aug 2022 14:51:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220802055130epcas2p376afd9af794e864b91500c8081538694~HcTwpPTjh0318603186epcas2p3R;
        Tue,  2 Aug 2022 05:51:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220802055130epsmtrp149af1dd88df581b584f2422cc126129e~HcTwnbjAu1503315033epsmtrp1X;
        Tue,  2 Aug 2022 05:51:30 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-8c-62e8bb63881e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.64.08802.26BB8E26; Tue,  2 Aug 2022 14:51:30 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220802055130epsmtip2ac8d744c5c3bd285746a444659d60a97~HcTwX4JC91544015440epsmtip2s;
        Tue,  2 Aug 2022 05:51:30 +0000 (GMT)
Date:   Tue, 2 Aug 2022 15:19:42 +0900
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanho Park <chanho61.park@samsung.com>,
        hajun.sung@samsung.com, hosung0.kim@samsung.com,
        d7271.choe@samsung.com, youngmin.nam@samsung.com
Subject: Re: [PATCH] time: correct the prototype of ns_to_kernel_old_timeval
 and ns_to_timespec64
Message-ID: <YujB/of1WSWsoHkw@perf>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a17d1J7gu0W-0ojxjz8W6C+Pg+xQW8ai=Qw_q94SJAOdQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmhW7y7hdJBvsX61v8nXSM3eLyfm2L
        a3snsls07b/EbPH1+iN2iz8nNrJZXN41h83i37WNLBabN01ltlh84BO7A5fH71+TGD0WbCr1
        2LSqk83j3blz7B59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hp
        Ya6kkJeYm2qr5OIToOuWmQN0mJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxA
        rzgxt7g0L10vL7XEytDAwMgUqDAhO6N7/z3Ggm7+ijWH9jA2MH7m6WLk5JAQMJF42XuJsYuR
        i0NIYAejRO/hF2wQzidGiZ2Hr7BCOJ8ZJbb/a2OEadmy7jULRGIXo8TWFeugnIeMEvP+zWQC
        qWIRUJF4uOYMO4jNJqArse3EP7BuEQEviT2vJ7GDNDAL9DFJbJ3VB9YgLJAs8WfaRTCbV0BZ
        4tGDTywQtqDEyZlPgGwODk6BQInJ22xAeiUEejkk9p5pAYtLCLhIXPipB3GdsMSr41vYIWwp
        iZf9bVB2scSTs0sZIXobGCV2L37NApEwlpj1rB3sOGaBDIlJE2+yQsxUljhyiwUizCfRcfgv
        O0SYV6KjTQiiU03i15QN0ECRAZq4ghnC9pC4efIAMyRMbjFKNN/oYp/AKDcLyTezkGyDsHUk
        Fuz+xDYLaAWzgLTE8n8cEKamxPpd+gsYWVcxiqUWFOempxYbFRjDYzg5P3cTIziharnvYJzx
        9oPeIUYmDsZDjBIczEoivHdcnicJ8aYkVlalFuXHF5XmpBYfYjQFxs1EZinR5HxgSs8riTc0
        sTQwMTMzNDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cAUsfHyTs6nsfvUzYob0/ee
        ko7qmRZix7fDsrTn5L/d89nYvO1zVr7YeP2w9L3udS9Cz57XdXPcGGzbcOakUmPRm5tXjv5a
        wmCtxd4qe4bh39G8XvHAqz6iItllvOf1xRM+ypyZvMnicOkWlrItdxLkFs2/pDJHWr+s00On
        q1iXtyeHK6T2kdvSfS+t5DiyywLeH6h+uHv5BD3Gv5dD8//bpt4/v9qvRH3hahfBP9+v7Vq3
        8pxnwn4mic9pr2/p5/z7+m7Z9+rYFcZHK7IX1sb8+fOh69y0R7V7NQ9d1nnfe+jOrm1ax9WM
        HBeaGhQfav7fOuNYRumuwxOmvZ0azNW/sf9jo8BvzS7doCcnPcP2KLEUZyQaajEXFScCAHIR
        ySYxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvG7S7hdJBvd36Vj8nXSM3eLyfm2L
        a3snsls07b/EbPH1+iN2iz8nNrJZXN41h83i37WNLBabN01ltlh84BO7A5fH71+TGD0WbCr1
        2LSqk83j3blz7B59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVceb3VraC0zwVezcvZ29gPMPV
        xcjJISFgIrFl3WuWLkYuDiGBHYwSlx58YoRIyEjcXnmZFcIWlrjfcoQVoug+o8SOdY1gCRYB
        FYmHa86wg9hsAroS2078A2sWEfCS2PN6EjtIA7PABCaJ34tPMYEkhAWSJf5Muwhm8wooSzx6
        8Alq9S1GiQ0vr7JCJAQlTs58wgJiMwtoSdz49xKogQPIlpZY/o8DxOQUCJSYvM1mAqPALCQN
        s5A0zEJoWMDIvIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgitLR2MO5Z9UHvECMT
        B+MhRgkOZiUR3jsuz5OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoE
        k2Xi4JRqYHJpvvGqbvXdvmAj5VtfjA9NufT51+zFuvGql++wvxXS63hhduHP7eb2iXyFW8w+
        Tnsn57Bcq2PS/taNQtmGYY+l31TPLNrleDiu5Sa7rOz9qMPrPL6wveTZvK7h/41/q7999A2f
        YKlqUhU6+4Tef7nT71VNlwu4TphyeppC4/ok1n/r/DKjXXwKljSaG036MEO6vba6NPsk05IM
        Fp5N+ravtqlFnP/HWyktJOfFNMtKfEL43m+KurLrpqlY38xuYRMJ69GK+VC3z+yKq8Wh/2u5
        D+m0Xfgzpcj80eUXp9onRjQ+e1TMtPHY35M6+2R0VOW5OJSnLCpySQmdfaGJY5oDy/rflxnE
        32pcffZ31TIlluKMREMt5qLiRABi356l9wIAAA==
X-CMS-MailID: 20220802055130epcas2p376afd9af794e864b91500c8081538694
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----mcIzWul-aJjzbW66W2I1I_HLrMa1How3AbEvH_uUKQqXJy0E=_79a72_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220712091922epcas2p34d7c89f02780afa58950b103a62eb59a
References: <CGME20220712091922epcas2p34d7c89f02780afa58950b103a62eb59a@epcas2p3.samsung.com>
        <20220712094715.2918823-1-youngmin.nam@samsung.com>
        <CAK8P3a17d1J7gu0W-0ojxjz8W6C+Pg+xQW8ai=Qw_q94SJAOdQ@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------mcIzWul-aJjzbW66W2I1I_HLrMa1How3AbEvH_uUKQqXJy0E=_79a72_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Jone, Thomas.

Could you consider applying this patch ?

Thanks

On Tue, Jul 12, 2022 at 11:25:22AM +0200, Arnd Bergmann wrote:
> On Tue, Jul 12, 2022 at 11:47 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> >
> > In ns_to_kernel_old_timeval() definition,
> > the function argument is defined with const identifier in kernel/time/time.c,
> > but the prototype in include/linux/time32.h looks different.
> >
> > - The function is defined in kernel/time/time.c as below:
> > struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
> >
> > - The function is decalared in include/linux/time32.h as below:
> > extern struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec);
> >
> > Because the variable of arithmethic types isn't modified in the calling scope,
> > there's no need to mark arguments as const.
> > And there is a review in Link[1] why it was omitted during review stage,
> > so they should be matched.
> >
> > Likewise, we can remove the "const" keyword in both definition and declaration
> > of ns_to_timespec64() as it was metentined below Link[2] and Link[3].
> >
> > Link[1]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1637458.html
> > Link[2]: https://lore.kernel.org/all/20220531064346.51677-1-chanho61.park@samsung.com/T/
> > Link[3]: https://lore.kernel.org/lkml/CAK8P3a3nknJgEDESGdJH91jMj6R_xydFqWASd8r5BbesdvMBgA@mail.gmail.com
> > Fixes: a84d1169164b ("y2038: Introduce struct __kernel_old_timeval")
> > Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 

------mcIzWul-aJjzbW66W2I1I_HLrMa1How3AbEvH_uUKQqXJy0E=_79a72_
Content-Type: text/plain; charset="utf-8"


------mcIzWul-aJjzbW66W2I1I_HLrMa1How3AbEvH_uUKQqXJy0E=_79a72_--
