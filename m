Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6BE5A6EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiH3VLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiH3VLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:11:41 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB2786B43
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:11:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x5so9591216qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=mcx/sHs4X4J6AEh6ee0LrI/A8QoDgWNgJSp8h+tVX6M=;
        b=M3CVoWqmF4Pk226p1m6C3FLf65lZo6atNVTS+EuAVXql8XryFGtTkHDLXaXRCZ89HE
         WF0oihPQaSBR2K/HfmHApVaonEViqM4cHKVtYSMXTkCy2ToAU4jxregattjboqq4ewEN
         RI+Rv7WYgINpASeQpbYfwhvLq/gFFfQvuhbWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=mcx/sHs4X4J6AEh6ee0LrI/A8QoDgWNgJSp8h+tVX6M=;
        b=yU8TleFzbcWF9npWY1lGitq3PZx48yMA501SYRrWf71SoxSLEVXZx/LKymHp5tGXyX
         +MJmZz1PfOqWTpW/EMHcmeuTAkTM6THZJtd22py9OrqxRHOP5M7DdDX71z72jzrTBoO1
         UEsVFH5fbe3CfS/xJe7r7OoTba8izFGUSbpi+QiuidNr/n0je98CAzKyh/hJ0dsib/Hs
         kTfGMJ7bDS82EFnGtqkPq8B75Dhwjvg44gv0/jkTYIiLPt3AK5s1N8ePT3tHjMNV1zCT
         ghIC3oxQLDws18ejSENYkN/QI+DVW6CW/rw2azXeshonvNplht+bYwikRIN3Ps8VXpib
         CdSA==
X-Gm-Message-State: ACgBeo0u6LiVVcA/rRgzyPWGdz7WufkwkXptUb90w39L4yCntKpPdIyX
        Mz+u01K8GeM/aHs0H7/vmadTdQ==
X-Google-Smtp-Source: AA6agR78YzGOMcDyyluycLTfxPbafjgnV+TqpG9zdoT4ulGXe2f1Lvi7j3v+Xufb2CrGqXKB00zOOQ==
X-Received: by 2002:a05:622a:1013:b0:344:5b66:fe15 with SMTP id d19-20020a05622a101300b003445b66fe15mr16741289qte.66.1661893897023;
        Tue, 30 Aug 2022 14:11:37 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id c12-20020ac8110c000000b003437a694049sm7208382qtj.96.2022.08.30.14.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:11:36 -0700 (PDT)
Date:   Tue, 30 Aug 2022 17:11:34 -0400
From:   Tom Rini <trini@konsulko.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: nvmem: u-boot,env: add basic NVMEM cells
Message-ID: <20220830211134.GW7942@bill-the-cat>
References: <20220703084843.21922-1-zajec5@gmail.com>
 <39a59ca1-642f-40de-f71d-842f9753372b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HdZAANC5GEQnh8Bp"
Content-Disposition: inline
In-Reply-To: <39a59ca1-642f-40de-f71d-842f9753372b@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HdZAANC5GEQnh8Bp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 11:26:37AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 3.07.2022 10:48, Rafa=C5=82 Mi=C5=82ecki wrote:
> > U-Boot doesn't have cells at hardcoded addresses. They are stored in
> > internal format. It's still important to define relevant cells in DT so
> > NVMEM consumers can reference them.
> >=20
> > Update binding to allow including basic cells as NVMEM device subnodes.
>=20
> Ping :)
>=20
>=20
> For a reference you can see Broadcom's NVRAM (identical feature):
>=20
> 084973e944bec ("dt-bindings: nvmem: brcm,nvram: add basic NVMEM cells")
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D084973e944bec21804f8afb0515b25434438699a
>=20
> c8442f0fb09ca ("ARM: dts: BCM5301X: Add Ethernet MAC address to Luxul XWR=
-3150")
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc8442f0fb09ca3d842b9b23d1d0650f649fd10f8

Seems fine to me.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--HdZAANC5GEQnh8Bp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmMOfQIACgkQFHw5/5Y0
tyznWgv+NTLNw1wbSDVBOO1gGdWW3yh53GYCEZ2xidxxzKU+F1L70mWCE/2Zvoyn
SHp+sGXMKpRSOgdAx1DleOd3Bta4PvAYo9+8ldx7o4DH2hGnwsDGkIUisiq/64TN
oavrFlk1IvQgYkLzzW0B+/OYeESfYLx8VWVCDUiFctmOQcH46yzWRPNhufbiSRGW
Wh5XrDIiodOAFo2hVg+2hUUlDuZTF6iyzix/rPmXpwGaHusRxfws7WgCMRkOj24i
YKFgUY/ldLXS94CYVPddnzXZsyrXAiI7YcSunnYlM/nLgFHvSKPMAGjE+QjAME61
TlQJ4fUnjxTmabqxWuAxeGuXM9BH/NsT6qObkJCOCyMGazAMjXl4oo26Gy00CoCk
X/K3zbTetu0tC4UnMGAWJ/wg5tJeqdcdwOCMJ47xXtjy+S2yNZcm7ohRZWBWupKM
EG/plRZ+JNrThu3zMGIkJ8dw19h/5ddfbiudW4v6tRhXdqiH7olLPUIC+Bn15CZ/
mFDm+sF1
=aJlP
-----END PGP SIGNATURE-----

--HdZAANC5GEQnh8Bp--
