Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B148E59A66A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350857AbiHSTYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349705AbiHSTYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:24:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E87C4F684;
        Fri, 19 Aug 2022 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660937030;
        bh=xO0rYpoFj+vOKj4sXf03GtVK1Czt+4SANo4Rb7BA6iI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SLZfydjeOB8r7XURETyPCICh1sC2E5Cut1fUmKOj6MpTQIuA9IJXdld/V3uG3yD6s
         /Ky8ij8B3LjnmUMjdDOOnVQGMfiDZjLFPulPNQWi0F7B7n3vOcn4DwaBLitXtAPXxX
         c/ZSrB4lku2szGsbeskYf/5IyuKH8cQtYxv+wU68=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.153.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1nxn9R0kJH-00RM7a; Fri, 19
 Aug 2022 21:23:50 +0200
Message-ID: <5b54b8a5-3ab7-c009-c42a-247c987888c5@gmx.de>
Date:   Fri, 19 Aug 2022 21:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] parisc: ccio-dma.c: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220811135953.27950-1-wangborong@cdjrlc.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220811135953.27950-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WM/naeTXWCPlDGUwOznRhfYr7U4E37Z9McjvDx09pjq21lNk+sY
 qtXMmula5/kUfkJ7m/YwyFIIBbmwKNJjd0Dg+FrCa4+cYF/zKjGYlEbxKAlVwI5+i/1wk1j
 sn3S6z+Z3VszhGlEOYHzQqYRMBRzUgfNohsGSEGFciKmSvReRq/ytCSql0jUk5l05fqPs5C
 J7ofad2cDCMpB+3KHft6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xDpWXXPNTf0=:2XG+1BPj3ed1aoqIgFecmS
 wpQLkqQGQ0pzf7sgJMtJ43zKYydsWpJlXqPBCbnT2Q6OnZlW+uNyHz30uiQ5RhCrgUGc/sHBG
 BOrH/xgeebwFY5G6wTXZDbz6GivSadmI1vAzIpKbKesi8dHTgNWrhfa9DsZtxA7L6T/u5y1FQ
 u91xVxvG+U1iLB+fIBwcautu+m4uT/ioYCjj9R3wXLGJto1prtouOkAlPJjbEnks+jnc2JTtR
 guZEq61zOsD6IYIHEBicR5GOdxllZprltEzS0A4gBOkg4VZplpODRjlRnukaAtslkWi1mPxjq
 6LR7mtHrBjLzFUIQsK9xebg6djez74r403BkuHxI8T0uiOQAZL7hQP/QSKH6KCGGw/U3Nrw+p
 s/j0BqngwrqOvL1zYcqTRx0g6cQ3uZO525lF1sthI+O7nCFlF/a9AvvVPt/2QABWLCWjqVJGN
 u2hQyKifrwBy+pl7TVY1oAQsyZ/bxKzpRzDePMtu+gnhlnYGvPFfKAPYBb3MjGEMWtgLaOLdd
 z63v87fM+6U+pjf+CRmxI6FNXb1dbSCv3A03iFgVD753Hk+z5z7wOP04m+yBz6HkGn8J7wEMl
 9EEFUEJ7zd6N8qoVExm3MucoMilUJ0xSBMBI2ODe+JsOJ5bhw8kmwkHD98h2ZbUYMq75TsNPe
 I6jHj0tAC/qUm8WYhQzDRdLMCicSJtjFSVMEGimKFzMcZxjxaNIJtTUwOGh61Bn7iyT9mz7df
 r/fnD8RI3hT9JdfcXmT7pl7Gu7t2OdnGBLloa9lt43zdQE/p0C8Pdq+arfqQ7OMYVCaYDkXiw
 HQgO8cKGC8jRAiH6K++I/0utOouqBtYwCoe+zKzPXjrCCkp3LhCOMtH2WL0SCHjubdfCbe1rH
 OQdHMIMHQSeS0QOshHq38gurESpmmnjxs/TyP0LUY9QhXKzq7mhzKN8hX+wKVVyEm3c8o5omh
 GXDwJLi/Lto2Rl6opRhmbTKFj0bcbleBTTg6qnriXk61FLyxQesxHr1MRQPm3pO/AKTCS/jfk
 1ik10YFLUIP8SrT5I9h283Dg7bsjJcCFhdGaKjf1hXV2UkE4pfwxkLizbjLQ49phrkUwmjdwu
 q4d4U3R3FFJxObWJ+kcqHKdXgvD9W7wnl6G0ZbpwE/jL1O2WmLxaPL3pw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 15:59, Jason Wang wrote:
> The double `was' is duplicated in the comment, remove one.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

applied.
Thanks!
Helge

> ---
>  drivers/parisc/ccio-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
> index 9be007c9420f..e863eb648379 100644
> --- a/drivers/parisc/ccio-dma.c
> +++ b/drivers/parisc/ccio-dma.c
> @@ -268,7 +268,7 @@ static int ioc_count;
>  *   Each bit can represent a number of pages.
>  *   LSbs represent lower addresses (IOVA's).
>  *
> -*   This was was copied from sba_iommu.c. Don't try to unify
> +*   This was copied from sba_iommu.c. Don't try to unify
>  *   the two resource managers unless a way to have different
>  *   allocation policies is also adjusted. We'd like to avoid
>  *   I/O TLB thrashing by having resource allocation policy

