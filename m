Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3184EFBB0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352255AbiDAUhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiDAUhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:37:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D066136679;
        Fri,  1 Apr 2022 13:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648845326;
        bh=KhaGB3atsf3KEfKKRTv8/oR3KgpmXQY/nWfznhF6wbc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=G7MlB7uhnx40RE8DsTcV5kVTrCO786SLm0yR2v49Hx94QhaEZZXvfi3Bok+gEkkLs
         6NQzDwAmiLORb9BGQ4F629gHZUkQ1VAz8dlumilq6+pTCKxmSSmu0QmGR2V6kljDXl
         aCPewTQf62hJ1ffzodVBe9rzVx+Rx9ew6bw1vK4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.191.12]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1oOHoL0e4Z-00paI2; Fri, 01
 Apr 2022 22:35:26 +0200
Date:   Fri, 1 Apr 2022 22:35:24 +0200
From:   Helge Deller <deller@gmx.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Helge Deller <deller@gmx.de>,
        James.Bottomley@hansenpartnership.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: Switch from GENERIC_CPU_DEVICES to
 GENERIC_ARCH_TOPOLOGY
Message-ID: <YkdiDJZ/XHODymRk@p100>
References: <20220401154137.GA3745625@roeck-us.net>
 <57e79014-25e6-62d3-27de-64797e43992b@gmx.de>
 <927a54f9-b413-0c71-461d-28ed9d5ece96@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <927a54f9-b413-0c71-461d-28ed9d5ece96@roeck-us.net>
X-Provags-ID: V03:K1:vmqPUhhSTDahmotqM5/IEWT4jC5wtwRDYvWwP+z3RNkD94tj/qn
 iFbUhDUWcd/fIzopCD/CBiaKF8dzgORiE09+Jh3TE2v6GBriS/LZ0zcCpHZjpM8A+KYct7K
 pBeNwWfCdpPlG/Q7JlyniUVl8oostRSEFyIk9oALk0vzlrdb4wrhXk72aPbNtQbSRaadoVm
 Jtvra5wPaXaQVjmIdgCoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4TQIAszq+6Y=:4L3g9nYrWWnSWuifuMXx+3
 8P/xpyGlR7XpmJkKaS7YfJeCssKt7lJpJrIpoHA+tr0huBO38unQDXZ8IH37Q8n0pBtiCW00t
 MU/lH+MBhpTDt29QAAIyIFpbdTgXi04ClshUIOxiBbkKjzqpPxdJVWRzcsuvvkypu5CtWOeyQ
 k+/BL+7sArUiZxQOfIILbcpvwCxFMetlx6HA4Ud7eG+0Nurfh1hSAo8IAiw2hH6IG1GCndTiX
 5UxZ5Rok1rMErVbxLPuGQFO+BJrApGUbfBx1HLimIq7uUHKhC5JYIaHuBB2abU2pCTG7NjTkI
 Y88V3TSWrYCa87uX9RYjYKr1fiD/aBF/9Z1+JyCWLtVPH7kGuwpsrbVYJAM2cJp+LCp9j1aaa
 qWl7PLksvN3qdtOPGziO0atMJCJMQio3IIEp1z+lt6cyj0SnWXyHsVuD1SuVTsSc9HMKBJ2o5
 d9jYGWyJMV/RRymypnMW1c5GbQLO+BjaRFWbmw6QjUmpYJlLUdNtqPO4L40ffyv7NkxOuyuH4
 osd8p+S+O4/7RQFO45ft9EZj3B6cMAx6615XBOj5zPca1rvkmidbIw1mD0F8So6BD+cn0TzSk
 tve2bqe8svcfFdZMZfGV7Cw2H2kwGYw8vwMdUkzFMJnWEMjjk75QHUy3viPPZTU6FawJxrN2m
 9wxOVIQ65rTLUFLj77pzmrOdxKBsBRDHc0h51lT2lQqRKYlYfSSbj8dJJZaj/GMzYimsaqgd3
 7FyOBcxlCySg4JSEGfDVyI9RhqNnVwwxuBFyNdwdjS4SFRGHx9sxRmSdRBM/jrh/8lLnzoHA2
 3gWTiyk0iD6D9l+6mZrETr69rQcM3t/G9Cnh35qa8K2aA+zIjtlzcsaZk1BUmZylChiX9eEj8
 e8xi6srzYwGgLSEIVIHLyUpoJJ0qAbEIJzC80MInZlOZyVgKYZBZJELwFZ4tUeH+tCrUToeR5
 UNqQBjUIdHeYn6l4mBI+uv3dDW6iPQ7yt8laIlj82987odQy5anVTmhXcIEzYZ32ylTgwspeI
 KrW9fss5uzbM4E3XAhMz8TyJJYYQCIA7udMGMWrctbrwDNYQgm9wM4E9AKbnexJuqfBTB5AHX
 xcYe/nc+vc0Odo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi G=FCnter,

* Guenter Roeck <linux@roeck-us.net>:
> On 4/1/22 09:47, Helge Deller wrote:
> > Hi G=FCnter,
> >
> > On 4/1/22 17:41, Guenter Roeck wrote:
> > > On Thu, Mar 24, 2022 at 07:46:50PM +0100, Helge Deller wrote:
> > > > Switch away from the own cpu topology code to common code which is=
 used
> > > > by ARM64 and RISCV. That will allow us to enable CPU hotplug later=
 on.
> > > >
> > > > Signed-off-by: Helge Deller <deller@gmx.de>
> > >
> > > This patch results in the following traceback when
> > > booting generic-32bit_defconfig - SMP in qemu.
> >
> > That's strange, because I just built this generic-32bit_defconfig myse=
lf and
> > it boots up nicely in qemu for me. The only thing missing is CONFIG_CG=
ROUPS=3Dy so that
> > systemd can start.
> >
>
> Did you disable SMP (that is what - SMP was supposed to mean) ?
> Also, note that the system does boot fine, it just spits out the warning=
.

The patch below fixes the warning for me.
Could you try?

Helge


From: Helge Deller <deller@gmx.de>
Subject: [PATCH] parisc: Re-enable GENERIC_CPU_DEVICES for !SMP

In commit 62773112acc5 ("parisc: Switch from GENERIC_CPU_DEVICES to
GENERIC_ARCH_TOPOLOGY") GENERIC_CPU_DEVICES was unconditionally turned
off, but this triggers a warning in topology_add_dev(). Turning it back
on for the !SMP case avoids this warning.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 62773112acc5 ("parisc: Switch from GENERIC_CPU_DEVICES to GENERIC_A=
RCH_TOPOLOGY")
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 52e550b45692..bd22578859d0 100644
=2D-- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -38,6 +38,7 @@ config PARISC
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_ARCH_TOPOLOGY if SMP
+	select GENERIC_CPU_DEVICES if !SMP
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_EXCEPTION_TRACE
