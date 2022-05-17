Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FFC52A348
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346618AbiEQNYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243615AbiEQNYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:24:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBC042EF3;
        Tue, 17 May 2022 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652793876;
        bh=chPWBUzZEK38/cCzN4Tnk5e6iV1JZN6qpcNu8tbABrg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Umrk/MVOaTUOrHUnbMniaWfY9K/TeXGSBXdl2qsQU5sdUbaHPboh1hkZCYqzyc7re
         htG/4NLkAaZaCgik1fx8GS3XqJSSi6olfyIab0Le243VEbT2+sE+Cnk2CvlxM+4gCx
         YLAgv6gDKVntU8TremLkW47skYueTl7cNAeboQYQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf0BM-1nNgyc0TwQ-00gYKJ; Tue, 17
 May 2022 15:24:36 +0200
Date:   Tue, 17 May 2022 15:24:34 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Marvin Lin <milkfafa@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kwliu@nuvoton.com,
        tmaimon77@gmail.com, avifishman70@gmail.com,
        openbmc@lists.ozlabs.org, tali.perry1@gmail.com, kflin@nuvoton.com
Subject: Re: [PATCH v1 2/5] dt-bindings: media: Add dt-bindings for NPCM
 Video Capture/Encode Engine
Message-ID: <YoOiEtY822XQ+JYl@latitude>
References: <20220512072722.25005-1-kflin@nuvoton.com>
 <20220512072722.25005-3-kflin@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kYh3ep2r/8CyteCm"
Content-Disposition: inline
In-Reply-To: <20220512072722.25005-3-kflin@nuvoton.com>
X-Provags-ID: V03:K1:uE4d+DLiRj04CDPtCPs1nhzxYQaiLH/NdLjpSsQf0mbXsdhAYzk
 /XsOHXkmtR2jA8EdEevnRDvlyPxTi8ciqjvyrMTbvbN0O/qWQQr9eO2k9X2wLdl3h+fc89g
 vEpFuiELMSy8gqwo7zcoEVr5P5nq1tqtj4plFoS5DFgGJHyzyvQCN+HVYMs0DEnj+6kJVGT
 uqc+cC7sY3fg15QsAQvvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+57fJft9JUQ=:PLr42ZRI3X91jn9RNUU52S
 hpQuu9DSnkvehU80br3h36XOf+TGkwpyMBHM7myy8cLTxgAVC/MLtgIvdG9q472kEmyP0EJro
 b80NdPoPnSuc52MAASBWiLHpBgzLj66yGJP/lBC81ZIJweSTwKd9xDZOhQjHZKHbYf+QIBMyA
 Z9Of6MnUjyYsgvygvNwSdRPvRz4xqOHVMur86uplbXUcVutuOuvYRtSmH5Z7pUQiRcRd2wFmE
 ENRaxVZffu5OZywypLBwtCcGcuI89V+itqvL0AEfMMQxSJRTrmE0rKyuEf+4af3m+mmOzTqV7
 BAoQE0Cs5fEWhlcmc2gaxiiMirNJlrW0MsmiMyYP5kdP+UebCVgTpfnk3Zq6Ft1q36vVQI2os
 Q9QvtryLzh22eRGkVDYoNEH64LgsWJamMjsp4o7GFpEzRXMRVMOcjG8iujo4TXVAvC+O1R1F3
 AJ0wC6I46Uq5WtpWI1mU8vjNuEIeRSSlGNZ2FBQMwTxYdZVPcNmMVKRF92YWY2kl8BlE4u6ar
 46x/20ahaI/zVkL8QVn7b1PhQn3rSgBWeK1D1uRGDavW8g5jwNHuzZut7VuaANR4t80irdBUj
 gHhQjyWBzmFaqmOtS2FfiFx0REm/q5EJ3lk6aeZ3fFD3fXGHFz7B1yXvCWes+ghqmDJdxmDuu
 Eb1UD8C67TaJH3CpQx5/nPXo7ifDbKYNW2Xu/fNvau2D+AqW8Bcdb/xSKz/bRu440iRJUCMD7
 QO1FEreQtrz/To6tKwDUD0tA0UAL22rAlc8NYx9bEINBtZik0Ff4GQLFdTx7WiosxmRWl91oU
 WtYEJwmyszWjOayiYEPy9NhtOyZblJhnnqXlq7W2bIyX0Vuzzqq9TZUenyhfo65M5rNwntB3C
 J7KsdKdWUKmpuzKQNp9HN3zGeNhlcmPr9JyXZ0542Cb6mgAdztIWWI308Z2LDIBEkv1/GLutu
 2F0f5m4xbzO8k3H/T5HURVfEulF82tuI+y7u8mA6MKf9wDERphV8szZDIHkOBexqfnToAf9S8
 TOqdGQMQ1x0f/Wha8UIynR9FmI6a3qATeyNxk/7BwuDbHjwraSF1zcVTvry9cBxjN3bVigu3q
 gkBQ+MlS1RUTCed+RzwWawab7MO0mCbAUEyYesjhfDBtCn5dwUJSgpM5w==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kYh3ep2r/8CyteCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

since the WPCM450 also includes a VCD block, I'd be interested in
reusing the same bindings and driver there.

On Thu, May 12, 2022 at 03:27:19PM +0800, Marvin Lin wrote:
> Add dt-bindings document for NPCM Video Capture/Encode Engine.
>=20
> Signed-off-by: Marvin Lin <kflin@nuvoton.com>
> ---
>  .../bindings/media/nuvoton,npcm-video.yaml    | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-=
video.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/nuvoton,npcm-video.y=
aml b/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
> new file mode 100644
> index 000000000000..b5be7ef09038
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/nuvoton,npcm-video.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Video Capture/Encode Engine Device Tree Bindings
> +
> +maintainers:
> +  - Joseph Liu <kwliu@nuvoton.com>
> +  - Marvin Lin <kflin@nuvoton.com>
> +
> +description: |
> +  Video Capture/Differentiation Engine (VCD) and Encoding Compression En=
gine
> +  (ECE) present on Nuvoton NPCM SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-video
> +      - nuvoton,npcm845-video
> +
> +  reg:
> +    items:
> +      - description: VCD registers
> +      - description: ECE registers

I'd somewhat prefer if these were actually two separate devicetree
nodes, since there are two hardware blocks and two register ranges.

This would make reuse of the VCD binding easier on WPCM450, because it
doesn't have an ECE block.


Best regards,
Jonathan

--kYh3ep2r/8CyteCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmKDofIACgkQCDBEmo7z
X9uXtQ//ezRzp0TGXgDyumHGdn89+Zb5LoXLRPBpknkiIhQ2Ozc29lC5k12ABrAH
HOu2tBhB+JlweLPJkNQIm5JQtFmIqG4fwU97jRiKbnbDDptacAnR3WOTwcHipiLr
kfTkeEOFQZ2XuznwbMtI16Rg32AhbKLkHTmWd70zsZzmdEz3RMMOs6jCtSlz36Zt
UxUm+Egq8JD2TgL2mTorTHdbZEhx6MUBu5ByQWk/ljAPSQHpz+PDf9VEzfgb+4Bs
N03rJUT8ns2xrtw5JI5UBxNRii7YSD+qsG4RXYjo9yjpjtf4Lys3LzKnivDP5+0l
2KXsby8vPrhNvTO+x5YGvU0dE7LVXoX/xqjIq8csod6Kd6ZNNBE+OaQ832+e+ZB2
d1Xso9HRtaih3YE/M9IvR0x0k8hfAePjJImlfBBcjqlQmGFT+h1rEfBez1SrACtl
mUpLcnAEZfm+qrpTpMLoDsZxIcZoyJZ0fej9IvTuRcCjk4Dwx54OS9AxHY4HD4GN
Mjhc6ZwGONbcqYh1iZ8thWYY4natr2wh4tNJ3UJbZwtqbFqUD0ze3sm7hdjpnC5m
3PikvXzyg3GALPBUjRj+FfWVzSDxRZ0w6t15C0ynZlW8pl419yzsMf2MWtjOkA/d
ZZrBqwgv3zqNZseitWyJ2HsOoWZbRWXOanBvd5zclk1EvZQVivU=
=RkHI
-----END PGP SIGNATURE-----

--kYh3ep2r/8CyteCm--
