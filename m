Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA752C913
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiESBAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiESBAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:00:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F0DD11F;
        Wed, 18 May 2022 18:00:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L3Wjj28LZz4xLb;
        Thu, 19 May 2022 11:00:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652922009;
        bh=+5KuKi/mk9I9GGHwbi7Z7s7N9eWooDeNDzhO2m6DFjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CE2s7v6okQrOklbCS2FnEZuCOoU68PJ/E3YxQiWzc5nuJTljMDsNu9xgO+bevR43M
         H+K65Nrq7GKc1BeuOex5kyxD+VArrEZjSnW1uah8VKvVDTl5ogmEwga8hh1SHNqLIj
         IoT/MXbibAg53vDnho4wU9FtongxeASVPa1I/JnvTJUPNl3+qIMY+2BR4WudNDW/nG
         3CuKNFzShSYYSlJaOnAKkVRRjg7YKPYS8kV8jKzE61552LJkFGVAOMUpPYLIdxOeG9
         GPWfw7rkdfIdLsZQSfjrIJUMcMssecV1vG6Ai60OVd8b95J9iyd2PqyFINDdOcsbfQ
         m5W1XvKFWh9QA==
Date:   Thu, 19 May 2022 11:00:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bob Moore <robert.moore@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: linux-next: manual merge of the pm tree with the loongarch tree
Message-ID: <20220519110008.586bc47f@canb.auug.org.au>
In-Reply-To: <20220519105448.74a4447e@canb.auug.org.au>
References: <20220519105448.74a4447e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dnYVvSASOFpoy5aHgtQXgo6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dnYVvSASOFpoy5aHgtQXgo6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 19 May 2022 10:54:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>

>  +	u32 count;
>  +};
>  +
>  +/* LPC Interrupt Controller */
>  +
>  +struct acpi_madt_lpc_pic {
>  +	struct acpi_subtable_header header;
>  +	u8 version;
>  +	u64 address;
>  +	u16 size;
>  +	u8 cascade;
> ++
> + /* 17: OEM data */
> +=20
> + struct acpi_madt_oem_data {
> + 	u8 oem_data[0];
>   };
>  =20
>   /*

I missed adding the closing brace after struct acpi_madt_lpc_pic.  I
have added that to my resolution now.

--=20
Cheers,
Stephen Rothwell

--Sig_/dnYVvSASOFpoy5aHgtQXgo6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKFlpgACgkQAVBC80lX
0Gy55wf9HrzdvPXdZwWp+grwlz9ku6nvmm8JCbzxabgvJMjMATWMrfUWp29hzjhq
BzQANURzfSdTYq4yP59yO3tlUmc0Btek7ljATXEkceSEELqJGiTp4EPtQb67oyyx
jsH1FWy48KefQrdwxQ485wSvl8XhaoRUF/lU1BowAwrYHdGpWQG/nvcwHMVSwOWV
tE3hEwNQSQoDOTsadBFUYkQu4RwcBUmyv0c5CnP2FK2y1rFWoi3KU3n77lZXxA9X
oUW9hPJqoayhS4USoRnbsayT6TdCGEnFHPmopZSR7MBxCQwpOIKYRp/3C4xVpWZi
pS51N8RehSw6i/cNDXsPdCkpIxcAow==
=Oa71
-----END PGP SIGNATURE-----

--Sig_/dnYVvSASOFpoy5aHgtQXgo6--
