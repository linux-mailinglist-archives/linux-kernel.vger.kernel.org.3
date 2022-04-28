Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A95512DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbiD1IKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343809AbiD1IKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:10:41 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25905FF22;
        Thu, 28 Apr 2022 01:07:23 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A3CCB20014;
        Thu, 28 Apr 2022 08:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651133242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OgdzcTozFEXOc5nis4y/bqNo2BFl7HCpt8t/Qg1ao2I=;
        b=mHEA5MLCK9+jcAr3vWQsAIKpZckVY+FUgOCNMiMP1SXRkfVtqtuiRep8XuKxBEaZ0cs2kc
        iKXOwY4qOoi+rW2ZE5l2bTTNh0bFNG9bVklK5w4slvIEvYCFKAFXvXZMjGF0NAgAJOY7gP
        T3qCFl41r6YkAwVYHv/e/heC14i7SW+vCqZfygdtjQmuXbGA4S8zdm4OgbgGBNuUS0VYuO
        wH+GMaFVo45+Hb7F+Z64gjFkv6H1XeIeRDcfW7Dsah4BhMZXJPlLPcckRaYq3U79XglayW
        hZKw5LR3F1i7O0rkyCCjn8hSrbBENOyAuBr+XORQSpkz1OYXAe+qPg16mC1E6g==
Date:   Thu, 28 Apr 2022 10:07:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the iio tree
Message-ID: <20220428100719.4a29e68f@xps13>
In-Reply-To: <20220428173758.2e642f54@canb.auug.org.au>
References: <20220428173758.2e642f54@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sfr@canb.auug.org.au wrote on Thu, 28 Apr 2022 17:37:58 +1000:

> Hi all,
>=20
> After merging the iio tree, today's linux-next build (htmldocs) produced
> this warning:
>=20
> include/linux/iio/iio.h:319: warning: This comment starts with '/**', but=
 isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Device operating modes
>=20
> Introduced by commit
>=20
>   831d87089ca8 ("iio: core: Clarify the modes")

Looks like there is no kdoc specific format for #define's
(Documentation/doc-guide/kernel-doc.rst), which is disappointing, I
really hoped this could be brought to the developer's attention this
way.

But that's not a big deal. Jonathan, if you don't mind, you may just
drop that extra start s|/**|/*| to make the htmldocs target happy
again.

Thanks,
Miqu=C3=A8l
