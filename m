Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3F48F424
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiAOB3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:29:34 -0500
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64]:55385 "EHLO
        out162-62-57-64.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbiAOB3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642210170;
        bh=AWjIEeU8M90gvfUQSZ0cXyepKC8Jutpx7AUkKvY6v24=;
        h=From:To:Cc:Subject:Date;
        b=StbzuePMWap3dvoI8OIL5+BQvsqS8u+gqTQ1RgVI+hzVUVwlGOkXLD2ZvjL+amsQ2
         jn+XxXsxkfZIIZrL7sEnBozxtvTPxOSu9Ad0tSjK0PXPuJdItnFEbj4VVQaCoTmL7k
         ziCrq6qSFKxWps+MWlW2iKfUSXjSgcbC6My1Ai8o=
X-QQ-FEAT: oHWrrGTW1dDQiAipz2ZtDt0sp8RnsZZi
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMAILINFO: NThFvZp7Q7whzHwMGDRMd6M9tOBLNqMaIGYlog8sDHUuPsr83uOccX5r8CbAuG
         grYT5SdZJ/oDxlDfoImBMw0zKz07K1CPMLmhWtj1xGHyNqDOX/FiQQE86EHYfjO9F293xcyS72/TU
         412EUzA8VhH06xL/jsyo+6fuVDLkKwIXx1HMng8JTY3DyhlEqIdV2ZaRBBkN+uhyRCTdeg332wsSL
         uPkgfYoYgPi7nVMMf/btCk3h2TZ16myk66YM3SB7H4WhLMqSLAFkrEVDgDqc+AELhhxwCUbQpPJGc
         lR0JD63GgWkuZFDkqHxifOus9VIat1h+eHz2fgdLvB16iRxAXMOwCsFn1UoQMz51cOSOFXTeR6KBC
         JJfi4TPGpzpjzm9M5/bwoyOBUBzsKPHyQAF7oZ/um4PAqmuHCbhkWukJg1NUX1sIq62NIFTvEjh1y
         7kXA+Jxth8qUQwbClqrhY+n1RQ1PZPEE/R4zAb0jwagZpnC92ru3gfwQMpwfUadNaatB53LLwVAoC
         97f6ZKymvnx6ng+Zy5qo16TzeMp+PKPZ5Bo6vgGJld4+0bFlNqdrvIIihn8b05EQ1gw5l/VPAREsR
         CwUp827c3FDQV70J0Wj7UycJgXK5uE5ldGa1LqT9TAeYaJDkIe0X27Jn8AZ1by6l8vVbcN9VJ9KZ8
         SxuULblycFKmu0CnkvzeWg4DaPspyKM9V9Z8woY21+FBFj6a0cpS47NV2x0eCANsxNaMuYci9Hyxe
         5hm6u177QN5fMhSEeUti5vxpVcdCbYdyE1m2fEXahguLsREVX6Lhtx8Ej/jRqHzZOe9J+0br6OOUF
         6KZXzisH6bZLjyLziDRk1V4ivM7NPBPOi/tKDJqzxcA2nmB2rsfpfsX732yVRvm6GmIzAQUDn23d
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 223.75.155.17
X-QQ-STYLE: 
X-QQ-mid: webmail813t1642209737t8649820
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
Cc:     "=?ISO-8859-1?B?cGF1bA==?=" <paul@paul-moore.com>,
        "=?ISO-8859-1?B?U3RlcGhlbiBTbWFsbGV5?=" 
        <stephen.smalley.work@gmail.com>,
        "=?ISO-8859-1?B?ZXBhcmlz?=" <eparis@parisplace.org>,
        "=?ISO-8859-1?B?c2VsaW51eA==?=" <selinux@vger.kernel.org>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re:[PATCH] selinux: check the return value of audit_log_start()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Sat, 15 Jan 2022 09:22:16 +0800
X-Priority: 3
Message-ID: <tencent_E80FE492D924578DC3838234FC5AC9E61F05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgYWJvdXQgdGhpcy4gTXkgc2NyaXB0IG1pc3Rha2VubHkgc2VudCB0aGlzIGVtYWls
IGJlY2F1c2Ugb2YgdGhlCnNhbWUgcHJlZml4IHdpdGggYW5vdGhlciBwYXRjaC4=

