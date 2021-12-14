Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613394740B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhLNKpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:45:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:49699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhLNKpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639478732;
        bh=zqk/pHvVJ3FHgJ6F96DqY/QK28/RIMBWknw0SFLiL2Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iXgw147vn0lMmLM+FQuRZkRhdR/N9G3ngdkr3PI4FYkqWs1UsW1BFy3OeZFNSQMUa
         Fsi7dZo3VgNQSyv7Zd98fUkGilUcwJYzpzp2a1fYWi0wDbSve3q6lbCeNvDIx1IM/X
         WcKuLy3dFtdL4rI90weuTfUYiW8FKNc87EHD37U8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.139.19]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1mH6zr1eKt-00k953; Tue, 14
 Dec 2021 11:45:32 +0100
Message-ID: <2fa1f8fb-2a30-1445-758c-4aa2e7fc5ec0@gmx.de>
Date:   Tue, 14 Dec 2021 11:45:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] parisc: remove ARCH_DEFCONFIG
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20211213024044.1165969-1-masahiroy@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20211213024044.1165969-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y2ozY65yWjfAJcDEcEiPdW/KgeSSWMPdNCp8cYBqNEGtChdIQwF
 fGFzsc6ZzSCKrgENeUOfZp274O3v3meLvP33tmMQ0iq5+xWuXcI4EYuR21lbKJo6q/EfX3f
 3CKALTUH2HWGhZFuGIZahLrl4AXLN4izHvqtazHbhrxV2ABWA2RA/D2I2YcJtNW0TuhxUaD
 pgHrLit3H23II863BWT9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iaKuMwudLco=:oQM+5snDkc2JyCRYJIn+le
 IMgfpfLEfdd3nLEpUbRnub1bX73KhpB6ewuFye2RfLtTgl3tQhXSj9autuqtZ/Oorw6zspnfb
 bzpkL9N0uOdtDCbmXc9H9bAygDxmgcX8cG1xhbYdBemdfEKwKcSmp/lVlb27HJVXeXWdVrE3r
 zk2hpilmCiFkiMVPccJvaPSOprwXvc3BM2Qoaw8LN/CNBJjyn9UEvvlSsTxM/H8/t8VqS3S7z
 8VHgbhJzb8CipDXKl393xQwcg6LIeNq6Q/aMLyh4gbAL3o/KfH/WjwXzMfSKHGGpH8Oh2XYGz
 IIZCGQexQH7O+BBJvsdOzAg3M5ExHvi5Jp5OWj2dircR5knikh3vZiuDJGUlKdW3FSHTLC2Rq
 Bud4LThpDlWVP1AksAGSy6BBUWY6hQAaAuYpk9AkkDI/Fb9EVGVChU6fwmA1DESRYUIq4ZU7C
 jGPdEWgrIA66FVaJWEiHFmxOoiR74vShYCGcCFfISSvi2EQbjMGliyQMeLimxk4etlv349oTu
 Vj7siEuXojG0ZIM/raJhoJxZI2NthUjL7jEMu32Cb6ROnkYd5QBQ8RluduYrQ7cEvdYa0KPEg
 dh0js7yv/Q3GflhhSLZnzjFz/mPiQGHObXRI1R/yRzrL8I8Hk9ePC44Rk2Hsymraho5rK1Gt7
 oLp1DvNYsL69ojKioGiQmfMAisSsSUTp+EtCYwhamffRkMgCW9cq81EhnrWtLeNcKxmzYdcTY
 K9Zp4umVCWegd9HGgF4WE2iOE1f+IP2Zhv4GzH3IITW11RoPsVBtF8WetbcQwfnECHE5/mBlw
 eGRqLoVs+1028D3Aiu2km8HaWTwUph+imztjfgHHRyRQ7+uoZ55DFdJIEcI+KM3jzlEEcNn2O
 8Lat9nUCynEUYSsdWmJz8RYdSZKMcVi4M9h/SzvI730D3LZZPwhKYl5nIeD3+dG8HIry37vx/
 Kg5unyONW9hrdWRQH83R8oBOWEno+QvnTFBoLe+nIX3hiOSS/fsScdI9gMjhJP8dVHp3Ktb4X
 EbQldhy8r5skt7n/4vz8Bg4At3zIYbbeDbsXGLIaLE76F3pAQN3Qika8R8842i9ee9G/42Rwk
 ZxX7CUjliUnmK4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 03:40, Masahiro Yamada wrote:
> Commit 2a86f6612164 ("kbuild: use KBUILD_DEFCONFIG as the fallback for
> DEFCONFIG_LIST") removed ARCH_DEFCONFIG because it does not make much
> sense.
>
> In the same development cycle, Commit ededa081ed20 ("parisc: Fix
> defconfig selection") added ARCH_DEFCONFIG for parisc.
>
> Please use KBUILD_DEFCONFIG in arch/*/Makefile for defconfig selection.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
>
>  arch/parisc/Kconfig | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index b2188da09c73..011dc32fdb4d 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -85,11 +85,6 @@ config MMU
>  config STACK_GROWSUP
>  	def_bool y
>
> -config ARCH_DEFCONFIG
> -	string
> -	default "arch/parisc/configs/generic-32bit_defconfig" if !64BIT
> -	default "arch/parisc/configs/generic-64bit_defconfig" if 64BIT
> -
>  config GENERIC_LOCKBREAK
>  	bool
>  	default y
>

