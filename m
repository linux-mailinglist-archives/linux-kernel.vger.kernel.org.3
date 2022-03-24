Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1414E5FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348747AbiCXHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348770AbiCXHxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:53:42 -0400
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09CA99EFD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648108323;
        bh=4qRt4CTUnFYdz91fm463A4eMLDDhGfe23h62hXzxysA=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date;
        b=ZhhNlFhRgeNebpYAg2pqgGxu0q4wTl0zFOC4GtKI0QhrffYWAQgUq/TLngun8Oev5
         CbSVKEF3fJo9sme+F15t2dHUK9BqnFbCe/eU0jUS0UadbrGBpHGsZ9dGTmAalaHubI
         bwpXxto6fcbosf9w8mLM93ePIav0++Viq+9z3hSM=
X-QQ-FEAT: oHWrrGTW1dA7H/rBCZjy5XfNuaD0tECu
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: MDPfhejMR4aIPs8Cf+y1mMj67XUkSWBvQJOfP8jngt07e0MRHVoxpW/lKa1yQt
         55NE9KviXEVi7x7uXkPfaluN3fFG6NKiWCz4L6cHEUqCzEJBXTBlEYxmmwKEweT8EUwjin5YpiygD
         BPnk2hDjka/tGZrXvqnWm7VM0anLtH9jpRGEmJJ9SudcHOKcH3VUtyyjHIhVMjIqMAWRrATJNWIck
         d4N1Ba2lmAKpV/+6iXDUkz1Z8F4CJPTL9xvqa40Aa4O3o8P6wdveQgvSrAnx8Jfr6HYwSpN7WItf/
         ZFlDv+ik5XbQ2WWnbfzUBp4CbIDTnJWXyKimICZP4Cko7NX3wMIFcP3aQxrL4lM2fbeOxLBkyU+lI
         A/BowrLGj0CtWL40UqtdmGXZUM2ekhhpan2R1jI+6c0dJX8IR0HuOTTGXabZPrlSLfwWQ2y+bpmrN
         0zA+WS58NURFA63d4YkukxaxeVVgdMbZNZZEyTLw8X8ATHL1zBSCZuKJWuGfD3jxJesXI756+G8M2
         qR33NhD1pa0rGsOm954u4ye/ulPy43jabn2oczWRWuNV5h6Cs5LeG/pvU80AKa3XO4h4RtbBGeDYh
         8BbwP22iwPujkvMXqavamc54TcxKv6i92r64BuTPSfkJrdadYca0VUr9uy4tS9hIpLkWAGNuDrGab
         4StF5PUi/4duoASWVjgm2O5xoptbX5OrJUFI2LHuEgm0TZAmnlmhxR2HsnS3XLPx5UwqeKoZ+evXU
         5tQ9fh8MbKMkchmeKzdaCJe/Aa4ot/WkjX89P9rXd12l0VI2pMHv7ps6D5UpkIpXOn+tsr79+u0gt
         z4Kumyl/zggqfkaF7Oga2a3wtWBPTplz/fCfmA8rNj4ZI+9FAcLnwrtRelU7xgqHMf3b6VCu0B9Wt
         8bxkRpBwyGiXiRJiZ0BNNpPHeXY+zw/N6THPfsKcB1xbnKwZpzoPGtnCADxVeUcHnIgDgnpDVs=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 111.47.122.156
In-Reply-To: <tencent_92B89C12C6BF29881C73666E140718054E06@qq.com>
References: <tencent_92B89C12C6BF29881C73666E140718054E06@qq.com>
X-QQ-STYLE: 
X-QQ-mid: webmail813t1648108322t29954
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?eGtlcm5lbC53YW5n?=" <xkernel.wang@foxmail.com>
Cc:     "=?ISO-8859-1?B?bGl2aXUuZHVkYXU=?=" <liviu.dudau@arm.com>,
        "=?ISO-8859-1?B?YnJpYW4uc3RhcmtleQ==?=" <brian.starkey@arm.com>,
        "=?ISO-8859-1?B?YWlybGllZA==?=" <airlied@linux.ie>,
        "=?ISO-8859-1?B?ZGFuaWVs?=" <daniel@ffwll.ch>,
        "=?ISO-8859-1?B?ZHJpLWRldmVs?=" <dri-devel@lists.freedesktop.org>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re:[PATCH] drm: mali-dp: check the return value of kzalloc()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Thu, 24 Mar 2022 15:52:02 +0800
X-Priority: 3
Message-ID: <tencent_283D88183356EE2B0706054EB8B452C3FF06@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_EXCESS_BASE64,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGh1LCAyNCBNYXIgMjAyMiAxNDo0MzoxNyArMDgwMCwgeGtlcm5lbC53YW5nQGZveG1haWwu
Y29tIHdyb3RlOgoKJmd0OyBremFsbG9jKCkgaXMgYSBtZW1vcnkgYWxsb2NhdGlvbiBmdW5j
dGlvbiB3aGljaCBjYW4gcmV0dXJuIE5VTEwgd2hlbgomZ3Q7IHNvbWUgaW50ZXJuYWwgbWVt
b3J5IGVycm9ycyBoYXBwZW4uIFNvIGl0IGlzIGJldHRlciB0byBjaGVjayBpdCB0bwomZ3Q7
IHByZXZlbnQgcG90ZW50aWFsIHdyb25nIG1lbW9yeSBhY2Nlc3MuCgpXaXRoZHJhdyB0aGlz
LiBUaGUgb3JpZ2luYWwgY29kZSBpcyBhbHNvIGZpbmUgc2luY2UgdGhlcmUgaXMgYSB2YWxp
ZCBjaGVjawppbnNpZGUgX19kcm1fYXRvbWljX2hlbHBlcl9jb25uZWN0b3JfcmVzZXQoKSBi
dXQgSSBtaXNzZWQgdG8gdHJhY2sgaXQu

