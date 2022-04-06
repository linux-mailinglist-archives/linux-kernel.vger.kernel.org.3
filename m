Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4D4F6A0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiDFTgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiDFTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:35:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166BD6D;
        Wed,  6 Apr 2022 10:19:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id k2so3435841edj.9;
        Wed, 06 Apr 2022 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=vdE7ENdk50E008niFssMoI/ouBHi+zXp0XKAL9+sLMU=;
        b=MLX8eLxI0+AXuN+l8u9PcFmRJgkQ8kt9A0wrp+VwWRqy23mMFhLT8whzsf7t000Ncc
         97Xt8KXreXtmlAyc/43AWxy5o4JoMImIo7MTazY8o9DuT3xSLfJ81UArwUm9a7pT4ZwC
         CEwip7418fGB8AT2ch6oEoiUwjOOD+dbHRDMFCqll0ZnjyqmH6rfwMFwR0th5ZtEW9/s
         g2zt/ziGlxVPZz9XFEu89z4Buc5QwGtHq046NsieugzH5lE37pIxdWY+Vjt6VDsOBSUV
         JlMRIarD6IZoAweQZVuW9y8wLuvDffwIMwVKCUg6g7iOa/ikjZfQHe9BQ8Kra7HRsLVd
         7nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=vdE7ENdk50E008niFssMoI/ouBHi+zXp0XKAL9+sLMU=;
        b=TUeKNzDFKbXSm6MgsCNTmHCarWovjj6Vo8xSkbmkMcjfktQc6tLsIIA4pQq3dtqWzG
         rjCZC/+AoACeU0RLyj/hjm+M+LTwq/wR5BVZyXVdQlWR3K98RYZ8gLl8H7GEjNWMTafi
         ayPn8Cj9wksEpmfFHFwB9pUn1QSfa9dVpwRrw/gB3jeb2jf3OY+FP4ZcovMi5R8FVuuZ
         OudkdTi721FuJkNPlekmxTRpbxEsYbIhG1lw1MNuX+qNXqy274Mpvs1ORrzTc4CPd38V
         rw5hkYss7VctLPmmEGff/+HlOynhNGS+Dnfghw0KTLrd43r0o7PzPMh70+/DpwOEkZhF
         RBQg==
X-Gm-Message-State: AOAM530Q0xc+9LELaep1aHg2n+af4CiCNTWjKgkvj7bjL2kzaDvSGpbq
        5vllsV5uOJTRqqanhvPm5Kk=
X-Google-Smtp-Source: ABdhPJwP6YnvLsavwQYRZtElYmnNa4TOvdQSidjbmDbmGHxOqnd2mnzm7WQStOVEdLTqWKYyw+6tLA==
X-Received: by 2002:aa7:d718:0:b0:41c:d766:7e74 with SMTP id t24-20020aa7d718000000b0041cd7667e74mr9982157edq.38.1649265566939;
        Wed, 06 Apr 2022 10:19:26 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id sb15-20020a1709076d8f00b006dfe4cda58fsm6749791ejc.95.2022.04.06.10.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:19:26 -0700 (PDT)
Message-ID: <c18a2b359046a14250cafa5a619dbe53f2872b5a.camel@gmail.com>
Subject: Re: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
From:   Bean Huo <huobean@gmail.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     linux-kernel@vger.kernel.org, maxim.uvarov@linaro.org,
        joakim.bech@linaro.org, ulf.hansson@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        bvanassche@acm.org
Date:   Wed, 06 Apr 2022 19:19:24 +0200
In-Reply-To: <87ee2ajuky.fsf@linaro.org>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
         <8b3ce88f65fd11523a4d2daab3c617f7089eb1ce.camel@gmail.com>
         <87r16bk013.fsf@linaro.org>
         <aeb64d1c4bbddfd8463c07a40ab1fc78be0d158d.camel@gmail.com>
         <87ee2ajuky.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-06 at 12:22 +0100, Alex Benn=C3=A9e wrote:
>=20
> Bean Huo <huobean@gmail.com> writes:
>=20
> > On Tue, 2022-04-05 at 16:43 +0100, Alex Benn=C3=A9e wrote:
> > >=20
> > > Bean Huo <huobean@gmail.com> writes:
> > >=20
> > > > Hi Alex,
> > > >=20
> > > > Thanks for this unified RPMB interface, I wanted to verify this
> > > > on
> > > > our
> > > > UFS, it seems you didn't add the UFS access interface in this
> > > > version=20
> > > > from your userspace tools, right?
> > >=20
> > > No I didn't but it should be easy enough to add some function
> > > pointer
> > > redirection everywhere one of the op_* functions calls a vrpmb_*
> > > function. Do you already have a UFS RPMB device driver?
> > >=20
> >=20
> > Hi Alex,
> > Thanks for your feedback.
> >=20
> > We now access UFS RPMB through the RPMB LUN BSG device, RPMB is a
> > well-
> > known LU and we have a userspace tool to access it.
> >=20
> > I see that if we're going to use your interface, "static struct
> > rpmb_ops" should be registered from a lower-level driver, for
> > example
> > in a UFS driver, yes there should be no problem with this
> > registration,
> > but I don't know with the current way Compared, what are the
> > advantages
> > to add a driver. maybe the main advantage is that we will have an
> > unified user space tool for RPMB. right?
>=20
> Pretty much. The main issue for virtio-rpmb is it doesn't really fit
> neatly into the block stack because all it does is the RPMB part so a
> non-block orientate API makes sense.
>=20
> Can you point be to where the UFS driver does it's current RPMB
> stuff?
>=20

It's the SCSI BSG driver, in fact, we don't have a dedicated UFS RPMB
driver in the kernel. RPMB is a well known LU, we are using userspace
tools to issue SCSI commands directly to the UFS RPMB LU via ioctl()
from the BSG device node in the /dev/sg/ folder.

Here is the BSG part of the code in the userspace tools:

        io_hdr_v4.guard =3D 'Q';                                       =20
        io_hdr_v4.protocol =3D BSG_PROTOCOL_SCSI;                      =20
        io_hdr_v4.subprotocol =3D BSG_SUB_PROTOCOL_SCSI_CMD;           =20
        io_hdr_v4.response =3D (__u64)sense_buffer;                    =20
        io_hdr_v4.max_response_len =3D SENSE_BUFF_LEN;                 =20
        io_hdr_v4.request_len =3D cmd_len;                             =20
        io_hdr_v4.request =3D (__u64)cdb;                              =20
                                                                           =
                                              =20
                                                                           =
     =20
        ioctl(fd, SG_IO, &io_hdr_v4))
...


> >=20
> > Kind regards,
> > Bean
>=20
>=20

