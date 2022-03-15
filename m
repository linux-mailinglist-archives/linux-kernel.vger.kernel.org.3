Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419154D9FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350048AbiCOQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350042AbiCOQYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:24:24 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEB8BC2F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647361386;
        bh=EYv+UViJ8a9cNs593tc2+H3b7ilBGD7+LqCErWQYEsY=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date;
        b=FmkM1kb663Wz+aoDJQcBWhZzp3ISITT133/UQTOcMvpwz1x0OJty4dfLD7XtGlN/o
         VjC1ofn8roN0IlOpNjmI+fpgMy/Wn4lXBOcbAzselem7m4zWiX1JnGcmaaqOBlmICA
         AcfXxRqE7ClyDIRhUH2nnF04G8MIvrAY1miM80qA=
X-QQ-FEAT: oHWrrGTW1dA7H/rBCZjy5XfNuaD0tECu
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: NERyOSoG0Tgwm5/3cpWYAcBb56KMjHIUMFfboOJ/FP7mHzrT9+vpwxzND0BFia
         s6SAjWvAeMSdqz66webS3U8baVEXmGK012S9Z/j2ssOnjrg0ZBuV6RhPr1KCRHbtt5zaZSoR45scj
         BwwnaQUtA/66AYHNV+ygi6/I3lL+YnMuFksk28X6t5op3bOH1MZRs8yvSYUCJ4Q0NEE3a/4ShAVrM
         bt/ovY9bDPRJltrInDe0cBMRahnoy/LEwte8gOddE9MBLIuXptGdTzUomCm3b4f3vUXIhWU9Cq6gt
         aAJmUgJsydXSl2DDPtCxfA8Me9KGR/3SZ52Lny4rR1OlSNB0HrACu7NBYQrdtuDJ9865+3rG5xQQ2
         QGN2X6RzK3eV1rzSltu+9oEQsIic1HR9+aAjnY+1+G9mzs0i/QtM8x0X4vPcaxaslsi5wQDm2Cwxj
         oOMp1jnuVKqxEPsfaMQdSqjW4MBEKV//HBBKr0miBJDop0ahBEjIc/pOuhL+xbSRYM44FHQ4yBfRy
         t8PUIW5VlQlx18EGG+8VeS/UwvFYtnKT+IyQxUf8tD8UMzQbwd8b0Y9ssrl5TYAAAnbVh45YepiuA
         llVXBU9oW5n/jijR2n2t7ZX5ogx+1fzZEH/sN2ilVtjj/KuYtifyxXCeWPU+PMBt5lm/456Ozkcg9
         qCfmsUS7C5eeYg3+zKlh79iyhtsolwenAg1PHBEZ8DKBRzKMjTX3UEfFTPEKr+p3PuZNal9hxPCST
         K4X8Yf/urZwpHxtHhqzpFTNiLivypZ3vrSPytdRaF8lRFrGO7j7/bqI3d8rC+5OIvcbG1uXB3bOqu
         GLv7QFr94fgco0SMyAs7qhgxS2o+JtOilVrAJLsgON2tcK3UmXy9tOQDCN8G/UnGXxarjfygoAtJJ
         mdVS0j3toE7HaSc8D7pWw==
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 111.47.122.156
In-Reply-To: <YjCwagaijyA2oO8r@kroah.com>
References: <tencent_7F2A8AAFF05125C6FF159033E69B5C108E07@qq.com>
        <YjCwagaijyA2oO8r@kroah.com>
X-QQ-STYLE: 
X-QQ-mid: webmail813t1647361385t4065526
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?Z3JlZ2to?=" <gregkh@linuxfoundation.org>,
        "=?ISO-8859-1?B?ZGFuLmNhcnBlbnRlcg==?=" <dan.carpenter@oracle.com>
Cc:     "=?ISO-8859-1?B?bnNhZW56?=" <nsaenz@kernel.org>,
        "=?ISO-8859-1?B?YmNtLWtlcm5lbC1mZWVkYmFjay1saXN0?=" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "=?ISO-8859-1?B?bGludXgtcnBpLWtlcm5lbA==?=" 
        <linux-rpi-kernel@lists.infradead.org>,
        "=?ISO-8859-1?B?bGludXgtYXJtLWtlcm5lbA==?=" 
        <linux-arm-kernel@lists.infradead.org>,
        "=?ISO-8859-1?B?bGludXgtc3RhZ2luZw==?=" 
        <linux-staging@lists.linux.dev>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] staging: mmal-vchiq: add a check for the return of vmalloc()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Wed, 16 Mar 2022 00:23:05 +0800
X-Priority: 3
Message-ID: <tencent_84264ACEFF062098CC35B9C01C7A1464E108@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_EXCESS_BASE64,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAxNSBNYXIgMjAyMiAxNjoyNzozOCArMDEwMCwgR3JlZyBLSCB3cm90ZToKJmd0
OyBZb3VyIGNoYW5nZSBqdXN0IGNyYXNoZWQgdGhlIGtlcm5lbCA6KAomZ3Q7CiZndDsgUGxl
YXNlIGJlIG1vcmUgY2FyZWZ1bAoKSSBhbSBzb3JyeS4gSSBldmVyIGJlZW4gdG9sZCB0aGF0
IHZmcmVlKE5VTEwpIG9yIGtmcmVlKE5VTEwpIGlzIHNhZmUsCnNvIEkganVzdCBqdW1wIHRv
IHRoZSB0YWcgYGVycl9mcmVlYCBpbiB0aGlzIHZlcnNpb24uCkkgd2lsbCByZXNlbmQgb25l
IGJ5IGFkZGluZyBhIG5ldyBwcm9wZXIgdGFnLgpBbmQgaW4gZmFjdCwgSSBkaWQgbm90IGZp
bmQgd2hlcmUgLSZndDtidWxrX3NjcmF0Y2ggaXMgdXNlZC4KClJlZ2FyZHMsClhpYW9rZSBX
YW5n
‰
