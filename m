Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CF146B5AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhLGI17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhLGI16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:27:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1BDC061746;
        Tue,  7 Dec 2021 00:24:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c4so27728252wrd.9;
        Tue, 07 Dec 2021 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CGQxHcZ8H0ueG4j2XagujWeXk5IDBCbZgPJ7D3M94sk=;
        b=hcZrt4mLTod+gaRghcvCOn+gN6qk72Mwbc5bWLJ0mIiUy5TnYBUBw6xibGCq3H+p9e
         tdimqn5FyPIvcM0NN7WWs+cr+iJUORqw3waVueUR78fPYSgIp6w48drXLMCtDXtQBSw0
         MeiKOoTEyWbA/2Hmql0K2b6dDKyQMqHBEGe+YA1osjKOW0ZZCeD9l/ueFYcCV3shLJBB
         z6hMGJ1GvNBqpwEHema5nL+MLMN8R34RurF5Z5FfO+WOlHJO+as+oHA89ZcyLRVLD6XS
         Xu2nT1SOndYCzW4YPjHiZ/GuutnB7Er/Nerc/fA2ZYf0xObeUl57QRQMRvOft0OJ9c5U
         JFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CGQxHcZ8H0ueG4j2XagujWeXk5IDBCbZgPJ7D3M94sk=;
        b=jy13LykogHRmpG+fiuaGYtXbK3aXsJmFLJiTSPIvAYX3TNDilFgINbVHBD9iRUhQcN
         2rLfNwXbf3bGMz3n5iQ3jcohS36/sdsA+pWK1sf7BV4NK0V+ShtB5vQa9XtRbeVQdANd
         6nodXEdCnZAoXyIBtvHXkdC3+SFdEdGcWjFLfZe3iaNizzbi3k6cv14+oW1ihupD/oDQ
         HcZGcnNw+8/JWbXzeNg3TvF2vhG/jdaycg8NrjncsWxC37TKQ1eJC4KGqCWJ0k1PhVAd
         RD813WMImwIplYlLTgLQFkO7mpBThv6veQgji6LEURaMTweA93kTYbGwXyA18frjAvra
         q5zQ==
X-Gm-Message-State: AOAM533pKwhGJrwT3iSaNfvWFo3a5PMLGNXOIucyGwJsj6HDFYBQ8Ixl
        WIkVHmqx5OheUEcvi3Rdbs+aMz0VUaroAQ==
X-Google-Smtp-Source: ABdhPJwkXWsAGqdvcqhLLWE4lqaGDbN1J7BWUDOVnXihaVIwVEiMKDkZgPgsHg00MBH7domL/T2xBA==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr47601358wrx.329.1638865466766;
        Tue, 07 Dec 2021 00:24:26 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id g18sm13949473wrv.42.2021.12.07.00.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:24:25 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:24:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: Add missing properties used in examples
Message-ID: <Ya8aNy1Mqa6t5OJg@orome.fritz.box>
References: <20211206174113.2295616-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LTXbiCdQlecc6zQr"
Content-Disposition: inline
In-Reply-To: <20211206174113.2295616-1-robh@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LTXbiCdQlecc6zQr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 11:41:12AM -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the following warnings
> are generated in the usb examples:
>=20
> Documentation/devicetree/bindings/usb/intel,keembay-dwc3.example.dt.yaml:=
 usb: usb@34000000: Unevaluated properties are not allowed ('reg' was unexp=
ected)
> Documentation/devicetree/bindings/usb/snps,dwc3.example.dt.yaml: usb@4a03=
0000: Unevaluated properties are not allowed ('reg' was unexpected)
>=20
> Add the missing property definitions.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/usb/intel,keembay-dwc3.yaml         | 3 +++
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml        | 6 ++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--LTXbiCdQlecc6zQr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvGjcACgkQ3SOs138+
s6HkwQ//cTOM5OZSNCr0s/+vnHIX3lu7vbmULrzt1xFHNi+4N2eqjQiFQ8uy9Z3w
Rnt1sNFdNLs7MQW06vpMld5RZYHNdunr8cnkfeAMb/WBQjddF7chx4daNrLB0kkT
yyZtk1yKfurbXJXH0QGbqCj7Z4JKXf8a8usJWx7cqq0ytbQLj48NLRPJYdddF/6c
8UXQJaOk/FAK+/EFMOuuNxltTUT3fk2+xZu1XQCXlyXoa1UoOEEeQj67V3nvkt9J
M7S3zDjEqp3R7QlNjeBS4Orw1Y3gm6a+WdJIwg8QXh/xk95kS5y2A37Smzhn7/c5
AUesIugratVoR0q6pJ9Sp1nMQcD9Yxu2G9YHnKG4SfV126MCDO2gWK5J0u2sX/Ol
boE6h6qldfFL8rzo6/x+01IBkN20dkr43PvaEwmHKaEKxGu2Fg5G+4UGJsfAl4Qf
U4g+IPxphiI39t0HZSG4SAqaiYQXdVwOdU0PQSAqw4/xOKE+RFcCP2Qtxrc2IBDc
F3a0iQpyJBxCDUMlDk9ocsXMDzFVA8wmhCy3qln+w0G5hMXBQ1br5ZhtWTIhxWoN
MgoqHhkta4JUmXOvBEl/ErIx24nOybMsBuUDQ52vbiXuB3r4Xal9dv0WypmlFZbN
mgf7YdOUopFb2iIw8LzjPGJjODOJMnDvO0XlWQ7LHNLtiIbt65Y=
=OQUj
-----END PGP SIGNATURE-----

--LTXbiCdQlecc6zQr--
