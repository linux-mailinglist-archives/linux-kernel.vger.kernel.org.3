Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F547E874
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350120AbhLWToh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:44:37 -0500
Received: from ms.lwn.net ([45.79.88.28]:51026 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244856AbhLWToe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:44:34 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4EFD62D7;
        Thu, 23 Dec 2021 19:44:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4EFD62D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1640288674; bh=ZA0UbbwoodtgOGE6plVIZt3QIEPYFx58JVAET1UksTs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=f+MJGr5LClVMwW9IYLl//XXmlj2xECruqiY6t4wLe0jkc05CmUIQmkhn/e9otvLVg
         3z02qBI4hed6k4nMjaUP/pOSty16bvgnYK7V2JrR5r4BkylSrMgbVVO/eAYTyd57SG
         LIlQE8ZCdQsP+jfI2CoRekc5j1XCEmOndIEVv3v2bsgty7HHKuBuKLghoFEROpZlOQ
         teLvPehsPxxTJaA4qvF1NlQJNSJ9+zcaTFU/EuIRbWI9i7CBDWaoMogJqGxLZ259Wt
         y3SoSgjB7QbxiB/1Spk8ZE7zLqVv74ccAaNeJw99nBntN8E0vh/okVdAc5jupQJZgq
         XDWSdcvpZOtPw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     cgel.zte@gmail.com, alexs@kernel.org, siyanteng@loongson.cn,
        seakeel@gmail.com
Cc:     yang.yang29@zte.com.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] docs/zh_CN: Add zh_CN/accounting/delay-accounting.rst
In-Reply-To: <20211217110949.453361-1-yang.yang29@zte.com.cn>
References: <20211217110949.453361-1-yang.yang29@zte.com.cn>
Date:   Thu, 23 Dec 2021 12:44:33 -0700
Message-ID: <874k6zf6n2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:

> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Add translation zh_CN/accounting/delay-accounting.rst and links it
> to zh_CN/accounting/index.rst while clean its todo entry.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> v4:
> - removed excess RST label.
> v3:
> - add missing period.
> v2:
> - delete useless blackline.
> ---
>  .../zh_CN/accounting/delay-accounting.rst     | 111 ++++++++++++++++++
>  .../translations/zh_CN/accounting/index.rst   |   2 +-
>  2 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/accounting/delay-accounting.rst

Applied, thanks.

jon
