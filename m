Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77894E3AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiCVIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiCVIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:45:37 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756B62AE3B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647938642;
        bh=ZhwrLpVxeb9axPGjqfL98j6rEPtndBto6xt6FHoWVFQ=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date;
        b=b7zf73dWIOkwFECVzERXf9Tw8FBktKAlVjv63eby4QJh8wXCr70HiJqno9cWXDV9H
         iXgzxjqA0rn9JQXvGS1bcjEPMEkKmGGiUR1oTgaPMt6r+Bv53GiEpPZ57Ig/qK1YXq
         oSMLG80piuC1tzBBAC/+IV5LYfIMjYdNbmjwOS7Q=
X-QQ-FEAT: oHWrrGTW1dA7H/rBCZjy5XfNuaD0tECu
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: OG3fjXpkFjhKoqZJ8p9LShZ0qRbZgWnC4h8mcUwCvFzrNZiMSE+n1Ho72vSgu/
         yFHdBzlz2y3pTtUhmmQe6DiwarocpDiM4FeByYS8glxyv2jUFrwwX+o+4tKk4KiMP/WW/t1boRg9V
         OfkxDG3rG+CyL3f3LtSy0+HEscqwPMiY+4PCNtg1OmSaqewDKP0MDHZ27uIcsfwSPVMY8MafKjkHU
         hLhOd/h9m4RHcEjHeQ4unrTPVSUZz+EydFuACugptDljljG/IogLRYTfnOkqFxEWAE5ht2MJV+pev
         AH3/okz6pKSpkuy+nhM/pgmJMEr/7QEJEnzqH1IUNHSr2iZwAp1UgVgWy3OJWvQuFh6TwuLerOTfa
         7JjBygQgtC67/84JjKr46eJVJoO17BaNdJaUY7k3KD/8LGSuA8ThUPSk+Nb4bnK5w63nNxd8gcqHc
         zKY8kW50tBJNWgp6orrfxUgFY4P/Km+Tit5AnNEBw6fYzro05R4IjcrIQvZ1LRO/LyVAxy4hKUqxN
         blwZR0jGBLSWIgI/4frZ1wHfD5SLBO5n/JcKvnlJ86vN/fNPu1CnNj/baqLEQonzQrGnMRSN35JW+
         QIBNXWEkpBJE4ZNu+NLGIuWB3poqmxliLQMlUCrrO1lc6O36LKqdLILuIp4vxXCV19yp3A98RBmTi
         tLy8DtVj7N4Yb7PMNNoaQ1RxyYzrGp6EnZb/tnjusGLnNxZkSjlDmo/SaZfKtZP08DTUmrkGGBg99
         QitjclRRR0TVxXPjqmmjFcS8JMZdgW+VT9M7tU7PMFZ+lM1GDy2yn3yTVe3kAzubhUOIK3N+UYeA1
         ozwu3s10alC3TjgmCSrcPvO9TZ/xisl9Rr8hJ9YETenmY4chstLJRMKCmgmjakTjNaiIqgEA4katV
         D8JEv8NTBobW5Ec1e1Kdw+lhb9buoInIMvXIvU6bh8=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 111.47.122.156
In-Reply-To: <YjmImXwknNx4WXDb@B-P7TQMD6M-0146.local>
References: <tencent_010A807048A5F97F0A900866A35C648E2E07@qq.com>
        <YjmImXwknNx4WXDb@B-P7TQMD6M-0146.local>
X-QQ-STYLE: 
X-QQ-mid: webmail813t1647938642t1340443
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?aHNpYW5na2Fv?=" <hsiangkao@linux.alibaba.com>
Cc:     "=?ISO-8859-1?B?eGlhbmc=?=" <xiang@kernel.org>,
        "=?ISO-8859-1?B?Y2hhbw==?=" <chao@kernel.org>,
        "=?ISO-8859-1?B?bGludXgtZXJvZnM=?=" <linux-erofs@lists.ozlabs.org>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix a potential NULL dereference of alloc_pages()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Tue, 22 Mar 2022 16:44:02 +0800
X-Priority: 3
Message-ID: <tencent_A9204DCC4AB98B1CA0144FE1794AD8FFD708@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_EXCESS_BASE64,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMiBNYXIgMjAyMiAxNjoyODowOSArMDgwMCwgaHNpYW5na2FvQGxpbnV4LmFs
aWJhYmEuY29tIHdyb3RlOgoKJmd0OyBJdCdzIHJlYWxseSBhIG5vZmFpbCBhbGxvY2F0aW9u
LCBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPwoKU29ycnksIEkgZGlkIG5vdCBjYXJlZnVsbHkg
bm90aWNlIHRoZSBmbGFnIGBfX0dGUF9OT0ZBSUxgLgpQbGVhc2UgaWdub3JlIHRoaXMgcGF0
Y2ggaWYgdGhpcyBkb2VzIG5vdCBuZWVkIHRvIGRlYWwgd2l0aCBmYWlsdXJlLgoKUmVnYXJk
cywKWGlhb2tlIFdhbmc=

