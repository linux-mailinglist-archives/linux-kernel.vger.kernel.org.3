Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5545457979F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiGSK0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbiGSK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:26:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A20108D;
        Tue, 19 Jul 2022 03:26:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so20919659wrc.2;
        Tue, 19 Jul 2022 03:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzSFZ78lgI9iG17MnsfDhwrDmMpT3R48jVXgkJqabv0=;
        b=egMr9GMuUh8TrHTr3yRmEcM+QdUmqjx8zKWs6heRDRNXo3nJbUomvwS8JKXarhjF9l
         zpE/Mv6p2+h4fsSu7Nw/KTYRWHXO470hIhRZ5C0K61U4ZktKoSHoaVlj+kl2p+UjS4GO
         mLuU66AdyvdX/ASmzVfNbbZax/SKJu8Ipj2tie6oxxN1tQTnEdwrrL7oDiLqz6BWHiRh
         mVyLB9uPHhJdazMkzd4jALskzn1p4pcQSHJMWC/UXRvNenmwe34SLAv+w3qDAKGZYj/F
         qMIb7V+qNM2ntxkAAms/F99gkMX/GdLzCgTlVwZmam351cIvBcwM+sJq6SqcCSEb/Z3t
         SqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzSFZ78lgI9iG17MnsfDhwrDmMpT3R48jVXgkJqabv0=;
        b=o53mVesHNW9r/lBmSYMiAwhi/bgFsP9Aep6peKLJ/nXeklM/EOBiOFZrwXFaqOaAGp
         TiYH8BT7MSlbTrhBFn3o0Ya/FeZyxeA5wgdV1HfrTBXNRXrN+uM4N8mrHWr2J6KbaMDy
         GOQjLdkeP2TJvmlvdLUnKJCGTYc+pqSjgN1a88e0TQ60ZtVpeVdQ52NT9e0Xy+m0D3b+
         fsxq6Yz0cUtTdptiTEpLFvWKLR37zChqjqNxYxandnbNdTZbaphBQ8Ctiiq+Akzh7o17
         4VRZ1nPUY1f4YImag48X5it+GI8cWOelvw0QLLGo0kTKdrZtWEtOqx4DSH4hSK0JH4wA
         wu/w==
X-Gm-Message-State: AJIora/SbbR6X1ClilPpqF+xGf4AMlnqqvdWENg+1l2h/KyZDroE85rJ
        BhHoUgwO/d3ccWLXAo+A4wXLcgfq0WQ=
X-Google-Smtp-Source: AGRyM1vwfsYW3mmgxSkGdc1KIkBe71ZnjGhyrkEgSZhOxIxhoIFS3at1qhhQ3S33eBwQ6TbZo6t3qQ==
X-Received: by 2002:adf:dc01:0:b0:21e:28ea:5d41 with SMTP id t1-20020adfdc01000000b0021e28ea5d41mr4350648wri.440.1658226362726;
        Tue, 19 Jul 2022 03:26:02 -0700 (PDT)
Received: from reki (62-170-35.netrun.cytanet.com.cy. [62.228.170.35])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c545a000000b0039c454067ddsm19570811wmi.15.2022.07.19.03.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 03:26:02 -0700 (PDT)
Date:   Tue, 19 Jul 2022 13:25:59 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <20220719132559.3348c163@reki>
In-Reply-To: <20220719194337.64c490e0@canb.auug.org.au>
References: <20220719194337.64c490e0@canb.auug.org.au>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

=D0=92 Tue, 19 Jul 2022 19:43:37 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
>=20
> After merging the usb tree, today's linux-next build (htmldocs) produced
> this warning:
>=20
> Documentation/ABI/testing/configfs-usb-gadget-mass-storage:17: WARNING: M=
alformed table.
> Text in column margin in table line 14.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> file            The path to the backing file for the LUN.
>                 Required if LUN is not marked as removable.
> ro              Flag specifying access to the LUN shall be
>                 read-only. This is implied if CD-ROM emulation
>                 is enabled as well as when it was impossible
>                 to open "filename" in R/W mode.
> removable       Flag specifying that LUN shall be indicated as
>                 being removable.
> cdrom           Flag specifying that LUN shall be reported as
>                 being a CD-ROM.
> nofua           Flag specifying that FUA flag
>                 in SCSI WRITE(10,12)
> forced_eject    This write-only file is useful only when
>                 the function is active. It causes the backing
>                 file to be forcibly detached from the LUN,
>                 regardless of whether the host has allowed it.
>                 Any non-zero number of bytes written will
>                 result in ejection.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Introduced by commit
>=20
>   421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attribute")
>=20

Sorry. Should I send a patch?
