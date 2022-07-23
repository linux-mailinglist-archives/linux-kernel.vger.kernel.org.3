Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B58257EC66
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiGWHOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiGWHOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:14:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6846DA0;
        Sat, 23 Jul 2022 00:14:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n12so9154927wrc.8;
        Sat, 23 Jul 2022 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kFbhz9YIcWYk8daO1/U52qJaNS5RPsFummR8Ag7sOH0=;
        b=nzblBlrUeZu2ABoGQG1E4Pxd6n3acJBTSkuopD/9LZV1tu+1sCOGFu0RVNuA/i/DmI
         JLUc+fx2zET53Wm+8fjovbKGPbBRfsc5fd/4Zx9L+z/p0AjRpL29VqIQx7VAzuWZ3Yb9
         TlBN9PHz6dxTMWZT1ZGAXlQBOSLVLSccPMccdAVt3W/+4ESOdJr8Ehzm/tCrtOMsplMr
         pqxE0OABN/RG9cuBukTbDbiRH0IoF57i9ef5BC8v+QGRQYNXGluIhPo/2uar7PogxTzU
         n9x33tXdIOaRkkR9pYHDswEmsc5xAo0RkVOmVWaDVDUCZZ8IMfejvzSSwGNiGbxAosgA
         1k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kFbhz9YIcWYk8daO1/U52qJaNS5RPsFummR8Ag7sOH0=;
        b=afSl1AVZcOAau+r+ADAMKJUKfSaZ5q1NqrQwZm60lyA25gGrQ0iSYnLKgV3iLBUm8n
         jUYPZDoE0PwDG8llfYcu/Cf1ZKc7SrzNTtXvpJ3qJa2D6tQOBNeojk43ak0cQ5cb8QOO
         IBrV/jZi6oBD3+n1MUARDysYEqxeJUXQLelgyDXzCycux/borlJpukW/0rwnhlSigVfj
         6wcFBjvFP1AzJbxK23DnAGKLOH1EXEsbPPlyfEnFfiJCx6xjqHEm8t6xyBEbRruodWvd
         2q3sXRPNFEU2F7+z9XL3Q/Ke8QpQ1OqVMw5JTx0To9FdoirWAKPLaF0vNnWqXxD8aB+9
         0lyQ==
X-Gm-Message-State: AJIora+7CdXzK8QMN8TuxYb+Bw905FWJ7W9X/ohMxkt/uK7EUoKKSHDC
        ynlTD7blO8m6a1E19MPCZWEVzi0Zu3440A==
X-Google-Smtp-Source: AGRyM1uMDcu67+t+bD8sku9/QUBXwQLqRL9EFwrgpKCq73Qj3OxM5KwmH2W+ANTQBLfoRgB5ceOZ2w==
X-Received: by 2002:a5d:4689:0:b0:21e:477c:bb9e with SMTP id u9-20020a5d4689000000b0021e477cbb9emr2036555wrq.517.1658560471355;
        Sat, 23 Jul 2022 00:14:31 -0700 (PDT)
Received: from reki (62-44-238.netrun.cytanet.com.cy. [62.228.44.238])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b0021d65675583sm6126304wrr.52.2022.07.23.00.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:14:30 -0700 (PDT)
Date:   Sat, 23 Jul 2022 10:14:28 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <20220723101428.347d941e@reki>
In-Reply-To: <YtaUYmzTfKmx0Ek0@kroah.com>
References: <20220719194337.64c490e0@canb.auug.org.au>
        <20220719132559.3348c163@reki>
        <YtaUYmzTfKmx0Ek0@kroah.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 13:24:18 +0200
Greg KH <greg@kroah.com> wrote:

> On Tue, Jul 19, 2022 at 01:25:59PM +0300, Maxim Devaev wrote:
> > =D0=92 Tue, 19 Jul 2022 19:43:37 +1000
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >  =20
> > > Hi all,
> > >=20
> > > After merging the usb tree, today's linux-next build (htmldocs) produ=
ced
> > > this warning:
> > >=20
> > > Documentation/ABI/testing/configfs-usb-gadget-mass-storage:17: WARNIN=
G: Malformed table.
> > > Text in column margin in table line 14.
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > file            The path to the backing file for the LUN.
> > >                 Required if LUN is not marked as removable.
> > > ro              Flag specifying access to the LUN shall be
> > >                 read-only. This is implied if CD-ROM emulation
> > >                 is enabled as well as when it was impossible
> > >                 to open "filename" in R/W mode.
> > > removable       Flag specifying that LUN shall be indicated as
> > >                 being removable.
> > > cdrom           Flag specifying that LUN shall be reported as
> > >                 being a CD-ROM.
> > > nofua           Flag specifying that FUA flag
> > >                 in SCSI WRITE(10,12)
> > > forced_eject    This write-only file is useful only when
> > >                 the function is active. It causes the backing
> > >                 file to be forcibly detached from the LUN,
> > >                 regardless of whether the host has allowed it.
> > >                 Any non-zero number of bytes written will
> > >                 result in ejection.
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > Introduced by commit
> > >=20
> > >   421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attribute")
> > >  =20
> >=20
> > Sorry. Should I send a patch? =20
>=20
> Yes please.

JFYI the patch has been sent to linux-docs@, etc. I forgot to add you to CC.
