Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC960513B95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351083AbiD1SfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351079AbiD1Se7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:34:59 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A4BC851;
        Thu, 28 Apr 2022 11:31:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 200CB37A;
        Thu, 28 Apr 2022 18:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 200CB37A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1651170703; bh=9RTbBSdubyXbieuSV3NDuJy87KZ+iQDFdQOlLDDRTRI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q7QcXzbs88fWQT1Qdw2ss7nNNHYDW58bGibi7ZkWEMtYi0vYlNOmq2iofLvvCcahx
         LidQ5eyvMy6xgJsyDpbu62tbhX4dC1Yf996OyB5svwu5VAdRbBlKmVWH2ECmddGURr
         BdyIvccqyJCTJHWgWF22O8+CRzF8eu765/VquTaVb7KYA413ptVL+5Kc1PIBzsouN7
         rIWugTnqwjebrKiOfvn9dqAGZ4AlKWD1EaeQ4H1fKcw/1uWxWLJTzJ+IdvaJYiN/8k
         XWuIto6E9oqYK1qaCj0sGlwPH2WHhR6rfjKwVzyiJZ1uqGNoUT/T46/8zVJdKLcu+l
         05p9hXKc0GQMA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>, akiyks@gmail.com
Cc:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-kernel@vger.kernel.org,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs/ja_JP/index: update section title in Japanese
In-Reply-To: <20220425124853.8347-1-fujimotokosuke0@gmail.com>
References: <20220425124853.8347-1-fujimotokosuke0@gmail.com>
Date:   Thu, 28 Apr 2022 12:31:42 -0600
Message-ID: <8735hx6ovl.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kosuke Fujimoto <fujimotokosuke0@gmail.com> writes:

> Update section title "Japanese Translation" in Japanese.
> This change is to keep consistency with other translations.
>
> Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/translations/ja_JP/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation/t=
ranslations/ja_JP/index.rst
> index 20738c931d02..43b9fb7246d3 100644
> --- a/Documentation/translations/ja_JP/index.rst
> +++ b/Documentation/translations/ja_JP/index.rst
> @@ -5,7 +5,7 @@
>  	\kerneldocCJKon
>  	\kerneldocBeginJP{
>=20=20
> -Japanese translations
> +=E6=97=A5=E6=9C=AC=E8=AA=9E=E8=A8=B3
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Applied, thanks.

jon
