Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA87580C40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiGZHSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbiGZHSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:18:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA962AC43;
        Tue, 26 Jul 2022 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658819919;
        bh=ZPKphOeqfUw9WDoxNukLO0XgQuydZuPrmVSi1WhjzL0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=I4GxEmbkCE75KR9vBC9vuzgAS7DnwJcFXtw4wbeLRpdzQM4cFd9CzOGbn82y/z5Sw
         ORuEcPu167u79eXuU42E7wQor8PHxf/kl+sB3+6FYsUfw3Luf0oRHnG6CqBOQqWi0I
         9fGuaFWYSCMg5vd8d2rLp8VBmMO6r+3qkC7A1Vqs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.186.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU4y-1nfnch1Et2-00aY10; Tue, 26
 Jul 2022 09:18:39 +0200
Message-ID: <954de293-cd67-2f79-0529-cf7682279ae4@gmx.de>
Date:   Tue, 26 Jul 2022 09:17:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] video/fbdev/sis: fix typos in SiS_GetModeID()
Content-Language: en-US
To:     Rustam Subkhankulov <subkhankulov@ispras.ru>,
        Thomas Winischhofer <thomas@winischhofer.net>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
References: <20220718124344.46338-1-subkhankulov@ispras.ru>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220718124344.46338-1-subkhankulov@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P5mZADKMLRDWe3X4DmUtFoBv9opTumb0nFI36Uuvewk9/mngzVd
 Z/dJrhiSv1ZxtOtlsg/WRmvBg/rKy1cjRwdhZg4ttzxCD/c8Db5EUZvW4U+giGeJQ+BaePA
 kOdzkpAiCW5F2SR1m5gH5JVC1Fap1tvHBz4OV0mpKQm2FS4wZ4wqP29Kh6twEtthZEvtmcI
 n3QiYZgCikPaaQJawJMJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Bf6EBdHyyE=:7AV0ibN9HDfgns0V0wMIDK
 XNOny6vfwYjaQn7SXLbxYVpy2lN1aNQZ7Or+9OVnHJ84oSzWUXgrGInhcyWvVMtfwZMaS3whT
 o0pybl1uYo9AcF0sLRwiCh1IG4Q+W5xPlNB1EQdwvBVnCix6kLuAKCBt1D0cii9/42rObWnsI
 E7jdZnPkawhxOj0LZFDz//cpIkRjCXFN2BN6lQC3Yx0onHjYvpgKZmri4j5RlQ/Jaa5k0OGbI
 5zEV4njXELZ1XbxMS/ZLtTUIIKA80AD4I/KCG0Ue906WZhumOkcbP5aktlOH0Po3+++6b/tAQ
 bPOBELuxg03Rw8HeAIZv7tBoEbrVH7A1ZYxarU+E+vsrg49cOtLTXTdrpIFeYAMzUFqGE61o3
 fq1sisKyRvjWYWgdtlMhQNxJ5iO3oiO8fIpwna8Tx5knQAqdswBaFO70u5psOr7t9sXEgfRNF
 lP4z9rA4o222XvnVRMhpcQRwQw0lgN9e7N/CweQ8WkkhIh8ymHZyoln5pqrwA0gtniPx9YoyW
 Uz23A5uZHIiKrxrDylxQpMpr+uUyCfi+AH5I2W0NX3ZSwvn0TPLaLwRNaQ6p9n27Jl2PoyYU1
 VJd29zGsZkcOQ13172Q86DqAXJCz1I4JkaG4h9wgce9tvy0qcAM2CCel6cClw/+EucthivnyJ
 ++vNVuRMP8iewYlSnpZHRJSfrFfNRJrHRetpQSD/jpNFNzb0VTinZibFa4OnMQtbsXvGOY2vf
 ByM8YJpBn6ruOBGDiA063KMfgymQxXnaRF9GqOZPzUIsQU074wVFIC0sE9W2UgSAfHXXAhjcT
 ekI53prxcNtZoMSjN9ZTBrXmVrIAeuwqZ3YhmGmHYknc3x35unWIrHZDgVMcRrzl+Gu6BbRWa
 oomeC2Wj5dLyE13Vw58LjhOoKEga7gqMZrSvR6BuGDlPk777UGuF9sJXmELEffIDJW4EGsYlh
 eAXYph4Kz0bjcsj5l9O9EG7vHSW69bB2vMBPNSZslCm2+bXJN7F4W5iOAU96Rv5F7qML060b4
 o0AMkCHa7lJ3rMR+JQrlpmujTd0+vaD+t7HFMpLfgV1PWGUzO6G0Qj0KwLjPykJFlFCoWPQB/
 PQwr5eXl4qxVGLhJht4hMz8ibqmBHY96o3C+Nd2G8Hfd1W1mUMbjucMIg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 14:43, Rustam Subkhankulov wrote:
> The second operand of a '&&' operator has no impact on expression
> result for cases 400 and 512 in SiS_GetModeID().
>
> Judging by the logic and the names of the variables, in both cases a
> typo was made.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Rustam Subkhankulov <subkhankulov@ispras.ru>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

applied to fbdev git tree.

Thanks!
Helge


> ---
>  drivers/video/fbdev/sis/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/in=
it.c
> index b568c646a76c..2ba91d62af92 100644
> --- a/drivers/video/fbdev/sis/init.c
> +++ b/drivers/video/fbdev/sis/init.c
> @@ -355,12 +355,12 @@ SiS_GetModeID(int VGAEngine, unsigned int VBFlags,=
 int HDisplay, int VDisplay,
>  		}
>  		break;
>  	case 400:
> -		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >=3D 800) && (LCDwidth >=3D=
 600))) {
> +		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >=3D 800) && (LCDheight >=
=3D 600))) {
>  			if(VDisplay =3D=3D 300) ModeIndex =3D ModeIndex_400x300[Depth];
>  		}
>  		break;
>  	case 512:
> -		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >=3D 1024) && (LCDwidth >=
=3D 768))) {
> +		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >=3D 1024) && (LCDheight >=
=3D 768))) {
>  			if(VDisplay =3D=3D 384) ModeIndex =3D ModeIndex_512x384[Depth];
>  		}
>  		break;

