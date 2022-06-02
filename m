Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7EC53BBFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiFBP5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiFBP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:57:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3005044C;
        Thu,  2 Jun 2022 08:57:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q21so7038638wra.2;
        Thu, 02 Jun 2022 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U45oZztThwfTU4bE8oeP5EulZ4cbmdTMrasnTC5Jdpk=;
        b=WhGySQvOuchgsSe7+FbwcFf+mI+6SdW3TND8tEcZP15hSvH7EO+WJbESdN6KE67pK2
         i55m7YhNDq/U/FivXmqhRnOBGq7qmgSk50qkkKeQ9Chu2Ci5FI7sggl7TdtnUKfujZjK
         GkSKRkz8U8Nhjdf6M/jXDfrUqWE4npO+yQvSrp1Q+bIeGl7kV3WhVykb2ZV1PlCxuVZr
         OwK2iZffbwKgAV+vp+oInKlnVc+dPEj3L/COOaU3k0lSLgmJdcUjFaOHWpRbfPQP7FKk
         YXH9MbAws4dCiPoCSpNZjCgjVSmYy1Bx+5nOOpiXMQSzt/EXpwnqfk95wOVOTdo3VUlj
         nC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U45oZztThwfTU4bE8oeP5EulZ4cbmdTMrasnTC5Jdpk=;
        b=GHlke+1LiMrbnsnS3LkcBsKF3l7tGa9FJ79fVeYtvvIX+Hk16eIe+mHGckvBADwWG3
         wzrxUqZ7GcNzQg/ENU8fVedWJv6atGSiI8htXgFNfIVbSH2qehSgCVia9wmXDomlttOW
         36pZx4pNyiXyI7ngur0NK4qah4dP+oaj2DKe6dd/ssyaatHch/+zvjbuWWliMNxPAQaB
         ycms8E+FstvDDj4NZlcUQPk6TXKQvu74C9Pa8yHyTSSWv7V/fFruxnbtkq8dChTqae+y
         gDKtHQlebkIXFSrttCayqH2fThj/OajFiEUGNhNjaZ2AFrVu+drFKYNK7a1t3dNFQB2Y
         0cMQ==
X-Gm-Message-State: AOAM533giM31b4PmJS03+cU0/yLjdU2BjcghAzCvdw46Jzpc2yAQo9MN
        8n0HiJN+b49gqQxCShJQT6A=
X-Google-Smtp-Source: ABdhPJyz5Kv5HQB5RBrB9iVOmWYxmgljnyJaImOlllFIG4+8+d3kzf27yp84e7joZRyHTookq75vNw==
X-Received: by 2002:adf:f645:0:b0:20e:652d:2a4e with SMTP id x5-20020adff645000000b0020e652d2a4emr4425383wrp.344.1654185457556;
        Thu, 02 Jun 2022 08:57:37 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4707000000b002103e9c1233sm4664997wrq.56.2022.06.02.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 08:57:36 -0700 (PDT)
Date:   Thu, 2 Jun 2022 17:57:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: timestamp: Correct id path
Message-ID: <Ypjd7lsn7KCDXBXv@orome>
References: <20220523172515.5941-1-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HnqFdPgdWrRBfQgN"
Content-Disposition: inline
In-Reply-To: <20220523172515.5941-1-dipenp@nvidia.com>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HnqFdPgdWrRBfQgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2022 at 10:25:15AM -0700, Dipen Patel wrote:
> During the repository renaming from hte to timestamp, $id path was not
> updated accordingly. This patch corrects $id path.
>=20
> Fixes: af583852d2ef ("dt-bindings: Renamed hte directory to timestamp")
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  .../bindings/timestamp/hardware-timestamps-common.yaml          | 2 +-
>  Documentation/devicetree/bindings/timestamp/hte-consumer.yaml   | 2 +-
>  .../devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Sorry for the delay. I've applied this patch now and dt_binding_check
now no longer shows any errors for these files.

Thanks,
Thierry

--HnqFdPgdWrRBfQgN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKY3e0ACgkQ3SOs138+
s6Eyrw/+OmA3OMFoGE0eUxpA/a3G8BO4A+6BIw3lzA/WREnaxMpZ4DdwVhUIZzmV
oJK2DDt5zzWAf2dpl8UaM8A9FFkAjeWU6q6P2F8C0bUJXNvvUC2cnfUtl3iSHwsO
lysnFZjR2BA881grh2LtEs4309Rddf5f3FA3BqKisF+XsAcrOYGGely435TXCFby
CiGvllH4zfE5FmUtdIARVqhDbJRPDIPqik6Qdl0iPkUc4yDbeE0An2jVV2/L12uO
UUFQM0+qpxBmkkLXSWgis8U9+kGxVBWmr+8adF1AGY5D5wXU94PtHTCxtWjxVBhK
1jl6X0iW8EZ+B9ehaypjOZk7lNIxj0gq1iz/7M9e1IYN/3aNAu+p+hDdX88ii3Gp
sP0l/eH+77OTpoBN/YJUItnsK3iAh7VyjS63mFRUv9fPf1h9/acueO/f+N3ySDgs
iUAtPbyx56FiZ+omXhQ2rIRmPZaiDPm3MJj6cQyFGqThlXncinlBnQ0Sk5IeL3Q0
HaR7AFJLJ9AqHg2pvt5qU60E+MvAsO4OW6SDTnz7YeNDezEg7k9/EWWVgeNVmXbS
pXRQX2JrRc7sIVyMrGZN7c/vC3psfO572vsw0JVwZ0qZqvovKGHm9uPFfhwoKtbx
/ylsKr+7UEahxfhG3IcLv6KmDMXLwkaAyLNRf8TPpCwAdN0ari0=
=dVCk
-----END PGP SIGNATURE-----

--HnqFdPgdWrRBfQgN--
