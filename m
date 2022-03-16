Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAB84DA961
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 05:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351990AbiCPElT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 00:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiCPElQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 00:41:16 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806A63914F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 21:40:02 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220316044000epoutp039ba5cfc7efc546279e9c46f4c014ff1f~cwqpsWzHv2083020830epoutp03Y
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:40:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220316044000epoutp039ba5cfc7efc546279e9c46f4c014ff1f~cwqpsWzHv2083020830epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647405600;
        bh=Pg2YkgWrqEHxCCE72dS09UgZo3qysKXpEiubDt7UJcQ=;
        h=Date:Subject:Reply-To:From:To:CC:In-Reply-To:References:From;
        b=Xux4FJmgZ78aMOuUP73aE1LsvTQczf33VBTYgWh/otP75Gt1byUZfd4N206CEFNr9
         6twfBdhS2dt6Wmvlzb3Bf1BCtJasZc3wIRMzDn4T8buO6RxLPyaZlbb9mDVa50LQrJ
         hxCnlOSnexkhz3AvD5v3MncEAWv+/2yzCMIXyYL8=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220316044000epcas5p41a87ceb5d7c4cefee45cf344b92bd037~cwqpEBomk0863108631epcas5p4q;
        Wed, 16 Mar 2022 04:40:00 +0000 (GMT)
X-AuditID: b6c32a4a-5b7ff700000030eb-34-62316a205ad1
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.10.12523.02A61326; Wed, 16 Mar 2022 13:40:00 +0900 (KST)
Date:   Wed, 16 Mar 2022 10:09:53 +0530
Message-ID: <453510261.3922147.1647405593710@mail-kr5-2>
Mime-Version: 1.0
Subject: RE: [PATCH v3] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>,
        "atomlin@redhat.com" <atomlin@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YjDScHjMUbqYV4s4@bombadil.infradead.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20220316043953epcms5p64b6640822657cca1ceac10cc1bd94846
Content-Type: multipart/mixed;
        boundary="----=_Part_3922146_1652146221.1647405593709"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTXVchyzDJ4MJULos569ewWfQ2TWey
        ODJ/DavFg4PX2S0u75rDZtEw+zurxeNZ89gsbkx4ymixcv5yRov/j7+yWuzreMBksXvjIjaL
        43eeMlkcOjmX0aLx831GB36P2Q0XWTx2zrrL7tGy7xaQOPKW1WPTqk42jxMzfrN4zDsZ6HGh
        K9vj/b6rbB59W1YxeqzfcpXF4/MmuQCeKC6blNSczLLUIn27BK6MDa8KC6YqV/S/us/WwLhM
        vouRk0NCwESiedNF9i5GLg4hgd2MElv2b2cHSbAIqEpMfraOBcTmFbCQaL95mbWLkQPIFpT4
        u0MYJCwsEC5xcP85sBIhAUWJCzPWMIKUCAsYSPzaqgESZhPQk1i1aw9YiYiAhsS+Cb1MIKuY
        BZ6zSryf28YOcQOvxIz2pywQtrTE9uVbGUFsTgEziY3rmpkg4qISN1e/ZYex3x+bzwhhi0i0
        3jvLDGELSjz4uRsqLiOxenMvC8gyCYFuRon17/ZCOTMYJXoeTYPqMJdYv2QV1FQXiRs35oB1
        MwN9dnj/T6i4rMTUU+uYIOJ8Er2/nzDBXL1jHoytKtFycwMrzAefP36E+sZDovnSI1ZI6G5k
        lHi/6jLzBEb5WYiAnIVkHYQtL7H97RxmkBJmAU2J9bv0IcJqElP6v7BB2GYSDe1TWSBsRYkp
        3Q/ZFzCyr2KUTC0ozk1PLTYtMMpLLdcrTswtLs1L10vOz93ECE6iWl47GB8++KB3iJGJg/EQ
        owpQ+6MNqy8wSrHk5eelKonwnnmhnyTEm5JYWZValB9fVJqTWnyIUZqDRUmc93T6hkQhgfTE
        ktTs1NSC1CKYLBMHp1QDU3rr4tdcBfPL1n6ZHsLN2OVlcFVX9+Spamb7de8cMkt3VDZ8WfTv
        7JZJeg8fRhemJv3XZt14cOEhg7fMNnVyO34F7FlzwG77WQfZBbzHnl2Pc+R4nbQy84Dc3buX
        94qsD1VdujQszcH6+sZGZ+GW581W+e6rlDsso+vcxVx3HPy90bJ4Paul0PINWY/bT3Rvt77H
        HD2F/byOZ6qbsnP7wk21P5+bbl3z//fzzc+DJJUP1kt671xtHNMYl7RvRnXZ3IvPu5yjr2zT
        vLuvYb7KHZsfV4RlQ8NL9Cft8ltwI0a7jzFQ5vBaXia7e1l71uwUmXBS2fx+9JcicX+Nx/8/
        CznP1dyi9XF2a5z/D7XcN0osxRmJhlrMRcWJACtGHAEdBAAA
X-CMS-RootMailID: 20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c
References: <YjDScHjMUbqYV4s4@bombadil.infradead.org>
        <20220315155100.516107-1-maninder1.s@samsung.com>
        <CGME20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c@epcms5p6>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3922146_1652146221.1647405593709
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

Hi Luis,

>> ---
>> commit id 'kallsyms: print module name in %ps/S case when KALLSYMS is disabled'
>>         needs to be removed from mm(linux-next) tree, current change is
>>         with ignorance of this commit. I was not sure how to send patch, with 2 patches
>>         consisting reversal commit also, or current approach is correct.
>> 
>> v1->v2: hash base address of module, change *fmt to fmt[0] and removed
>>         copy paste.
>> v2->v3: fixed review comments from Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> 
>>  include/linux/kallsyms.h |  2 +
>>  include/linux/module.h   | 20 ++++++++++
>>  kernel/kallsyms.c        | 27 +++++++------
>>  kernel/module.c          |  4 +-
>>  lib/vsprintf.c           | 85 ++++++++++++++++++++++++++++++++++------
> 
> Hey Maninder, thanks for your patch!
>  
> Since this touches kernel/module.c and include/linux/module.h I'd prefer
> this go through modules-next [0], and as you will see that's a different
> world right now. I also have a set of at least 2 other patch sets to
> merge there before yours.
>  
> Also, what is on modules-next is not intended to go to Linus for the
> next merge window as the changes there got merged only late, and I want
> at least 2 months of testing on linux-newt before any pull requiest is
> sent to Linus.
>  
> Can you rebase to modules-next? I can evaluate the patches then for
> integration there once the other stuff gets merged into that tree too.
>  
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next
>  
>   Luis

prepared and verified patch(KALLSYMS enabled and disabled both) on module-next rebase and sent in new mail.
[PATCH 1/1 module-next] kallsyms: enhance %pS/s/b printing when KALLSYSMS is disabled

https://lkml.org/lkml/2022/3/16/7

Thanks,
Maninder Singh
------=_Part_3922146_1652146221.1647405593709
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBSZTogW1BBVENIIHYzXSBr
YWxsc3ltczogZW5oYW5jZSAlcFMvcy9iIHByaW50aW5nIHdoZW4gS0FMTFNZU01TIGlzIGRpc2Fi
bGVkDQogICAgICBGcm9tICAgICAgIDogbnVsbA0KICAgICAgU2VudCBEYXRlICA6IDIwMjItMDMt
MTUgMjM6MjMgIEdNVCs1OjMwDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgICAgICAgICAgICAg
IE5hbWUgICAgICAgICAgICAgICAgVHlwZSAgICAgICAgICBKb2IgVGl0bGUgICAgICAgICAgICAg
ICAgICAgICAgIERlcHQuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENvbXBhbnkgICAg
ICAgICAgICAgICAgDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIE1hbmluZGVyIFNpbmdoICAg
ICAgICAgICAgICAgICBUTyAgICAgICAgIFN0YWZmIEVuZ2luZWVyICAgICAgICAgICAgIFN5c3Rl
bSBTL1cgR3JvdXAgL1NSSS1EZWxoaSAgICAgICAgICAgICAgIFNhbXN1bmfCoEVsZWN0cm9uaWNz
wqANCiAgICAgIHBtbGFkZWtAc3VzZS5jb20gICAgICAgICAgICAgICBDQw0KICAgICAgcm9zdGVk
dEBnb29kbWlzLm9yZyAgICAgICAgICAgIENDDQogICAgICBzZW5vemhhdHNreUBjaHJvbWl1bS5v
cmcgICAgICAgQ0MNCiAgICAgIGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmkuLi4gICBDQw0KICAg
ICAgbGludXhAcmFzbXVzdmlsbGVtb2VzLmRrICAgICAgIENDDQogICAgICBha3BtQGxpbnV4LWZv
dW5kYXRpb24ub3JnICAgICAgQ0MNCiAgICAgIHdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tICAg
ICBDQw0KICAgICAgVmFuZWV0IE5hcmFuZyAgICAgICAgICAgICAgICAgIENDICAgICAgICAgQXNz
b2NpYXRlIEFyY2hpdGVjdCAgICAgICAgU3lzdGVtIFMvVyBHcm91cCAvU1JJLURlbGhpICAgICAg
ICAgICAgICAgU2Ftc3VuZyBFbGVjdHJvbmljcw0KICAgICAgc3dib3lkQGNocm9taXVtLm9yZyAg
ICAgICAgICAgIENDDQogICAgICBvamVkYUBrZXJuZWwub3JnICAgICAgICAgICAgICAgQ0MNCiAg
ICAgIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgICBDQw0KICAgICAgbGludXgtbW9kdWxl
c0B2Z2VyLmtlcm5lbC4uLiAgIENDDQogICAgICBhdmltYWxpbkBnbWFpbC5jb20gICAgICAgICAg
ICAgQ0MNCiAgICAgIGF0b21saW5AcmVkaGF0LmNvbSAgICAgICAgICAgICBDQw0KICAgPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo=

------=_Part_3922146_1652146221.1647405593709--
