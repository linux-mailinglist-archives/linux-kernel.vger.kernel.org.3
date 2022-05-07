Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC9051E502
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445965AbiEGHFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 03:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbiEGHF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:05:26 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400754EDF4
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:01:40 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220507070136epoutp028d29e8d59edb40e13179e722009857e5~swJIFlgoI1109811098epoutp02S
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 07:01:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220507070136epoutp028d29e8d59edb40e13179e722009857e5~swJIFlgoI1109811098epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651906896;
        bh=DZ/xtsMSdo4gSlwK4tvPIcp5OKUcNVBANjcabLyX/IM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=KRYuLMrzdBp/f6vwAc2FLiCp7Qw8+zC0lB3ooYcgQjUjr2C/sxQIW02aTTgDwqRSa
         3zCFRyTiFVnb8N2r19ryCsyWQzNRnALQOLd1c2+6Wbp0/lIbbhtxi7G0hB+5/HmnXv
         dwXTwf+Tcyu/Cvgd55WTkiZ0693TGVjZyLh8unGY=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220507070135epcas5p3e78380fb23e8b9b8d45923a62cf295d9~swJHFdgrc1447014470epcas5p3E;
        Sat,  7 May 2022 07:01:35 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-9c-6276194f5998
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.EA.09762.F4916726; Sat,  7 May 2022 16:01:35 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH 1/1] kallsyms: add kallsyms_show_value definition in
 all cases
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Vimal Agrawal <avimalin@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     Petr Mladek <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "wedsonaf@google.com" <wedsonaf@google.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "void@manifault.com" <void@manifault.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Onkarnath <onkarnath.1@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CALkUMdQanGgtahQDqQV-r6oWF=cvTsteztOoe5bqHsJApST0Rw@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220507054953epcms5p7037be09d433e1b9a80750a02ca6ec679@epcms5p7>
Date:   Sat, 07 May 2022 11:19:53 +0530
X-CMS-MailID: 20220507054953epcms5p7037be09d433e1b9a80750a02ca6ec679
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTS9dfsizJYPVaeYs569ewWfQ2TWey
        +PLzNrvFg4PX2S3WbGlksrgz6Tm7xcUzrxktjkyZxWxxedccNou7K24wWdyY8JTR4sOE/0wW
        K+cvZ7RY0fOB1eL/46+sFvs6HjBZ7N64iM3i+J2nTBaHTs5ltNi+fD2bRePn+4wWHYtXMjqI
        ecxuuMji8fXmOSaPJZ2/mDx2zrrL7tGy7xa7x4JNpR4tR96yemxa1cnmcWLGbxaPeScDPc6s
        3sbk0bdlFaPH+i1XWTzOLDjC7vF5k1wAfxSXTUpqTmZZapG+XQJXxqoZc5gLTjBXbJhwiqmB
        8SlTFyMnh4SAiUT3vElsXYxcHEICuxklJnV9Zeli5ODgFRCU+LtDGKRGWCBcout4MxuILSSg
        KHFhxhpGkBJhAQOJX1s1QMJsAnoSq3btYQGxRQR8JBoffAAbySxwgl3i0NJ/7BC7eCVmtD9l
        gbClJbYv38oIYnMKBEo0TNjJChEXlbi5+i07jP3+2HxGCFtEovXeWWYIW1Diwc/dUHEZidWb
        e6FmVks8fX0ObLGEQAujxL7dMEXmEuuXrAIbyivgKzF5/WKw51kEVCUaDhyDBoSLxIbl38Hq
        mQXkJba/ncMM8iSzgKbE+l36ECWyElNPrWOCKOGT6P39hAnmrx3zYGxViZabG1hhfvz88SPU
        bR4SG1f8YoKE80EmiffPtjJOYFSYhQjqWUg2z0LYvICReRWjZGpBcW56arFpgXFearlecWJu
        cWleul5yfu4mRnB61fLewfjowQe9Q4xMHIyHGCU4mJVEeIVnlSQJ8aYkVlalFuXHF5XmpBYf
        YpTmYFES5z2VviFRSCA9sSQ1OzW1ILUIJsvEwSnVwBRf/f9IbJ3dNeNQQ7enlzTVrEpSBVRf
        fJkrtoBDVHqp96N11Vu89jjPXRO+01nHkP9m/veEM0/+7jjy+Ve9ye019o9fSnY9/L04bvc0
        hZ49U/TytvrsFrIsvPVz1gm9021WxjyfjxWpeP/53TPPTGum35G2P7K1kZwLp1w2f7zDruz4
        zFDZf3+rT1zUW7SiIEV4rvzaTsfKIxV1RzRnvM90SmDUTd27wMb5w4ZzFVIq8rL3E0KSJi5p
        61vUL+98pZ/fMXg2F7/WD5VM1j+K6fv3B0hs0dPW1irwONq4d5Hp9Zg9LFP3PgnOL5B//yMz
        LWM27xqnj1Pc75ofLz/TOafk+4pNR9N7J7da25pprFJiKc5INNRiLipOBAAstvhiHgQAAA==
X-CMS-RootMailID: 20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2
References: <CALkUMdQanGgtahQDqQV-r6oWF=cvTsteztOoe5bqHsJApST0Rw@mail.gmail.com>
        <YlaWxh5qYCe40US7@alley> <20220413055305.1768223-1-maninder1.s@samsung.com>
        <747830777.1512786.1650256482294@mail-kr5-3>
        <YmAlAvy6aSeeJKoO@bombadil.infradead.org>
        <CGME20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2@epcms5p7>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vimal,

> Hi Maninder,
> 
> in sprint_module_info(), we need to take care of mod->init_layout
> addresses as well.
> Please test the patch against  init symbols.
> 
> Vimal

Same I updated in below thread.

https://lkml.org/lkml/2022/3/22/56

Can you check if anything else needs to be fixed or updated.

(because of office mail system, reply thread was made a new thread rather than same patch conversation)

Thanks,
Maninder Singh
