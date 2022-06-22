Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0966D554E15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358886AbiFVO7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358870AbiFVO61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:58:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C559D34BBC;
        Wed, 22 Jun 2022 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655909892;
        bh=hy17MPdYaTPp9vfv9BzJ5mgUyjp12V+lcyXvWohnLZk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UJGlf43jXqj+j7syujC2ExZyhOGEIPRYSiSwGdO4R17YXd7ZevyTZH48d7OoPUqUH
         a0m8g4Baa9M2br+3YA3f63odk8D94lXpnZbY7lHrgWURXXewbsHjt2O3P+lQctdFzk
         MYB/Tv7BAPRUdbK+W9mnlaPzLcBF/3mfFxhdCric=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.253]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeMA-1oDxSK1IPM-00RVFp; Wed, 22
 Jun 2022 16:58:12 +0200
Message-ID: <53fd08a9-bba6-f7e1-b784-b516584dcba5@gmx.de>
Date:   Wed, 22 Jun 2022 16:57:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] video: fbdev: omap: Remove duplicate 'the' in two places.
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     b.zolnierkie@samsung.com, arnd@arndb.de, tony@atomide.com,
        jmkrzyszt@gmail.com, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220621185409.4859-1-jiangjian@cdjrlc.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220621185409.4859-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nmpmUOzNmmXaWadmNItunHxr8MwLqoztD+nCbGdutNjGhnZb28s
 u4n/v9KKHQE5KGEcB9htWc/0vrXiwKoW3eT8gY6eWX7nCrzxhqW44mU/FqYcFQpIv1db/qv
 ljPW9a7D8IUExa/OxqGAAsP1r/ZcHH+mirT/fit01kaJb5E23cNYCLox+lno4/TZqQcH8nY
 X5ILenVJXYbiFzF/r7Fgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tE39K9TAzlg=:gtH+UmqB2AZehJar0m1Wlp
 h4EJdf8/vFXiBjqq4wcFRCh3aWC/GJ6Ys2rmg2d5t53acuGcvJsxxPRPnRZVLapMnM/NzW6dE
 EJJCcot9lRxnERTgj6feE+4/n5ydgMt3iE/ACh6O0tLhSJArQZRqg7WkGbA7lAo8EN+p04b+S
 VscGwhzfI55lZIkEhIFDkEvHmeaJn9PGKRDHcI014xxg6UnOAy8ow3DYynq7huvr8vHt6thCl
 qLoTZHShMyfn+XtcIQqvK/ZtoWKG74m2v0CpeNUOseO8T4tooGUinKbk28wX0yqfBLI1e0AIF
 QqmFWAr66Dvyi/tHD8HndRqET2eRB0sqnC4EfqJGqn2oOQlinsgxFeqc2z6G5vDYN5voNxug9
 vjGRo5X3yvf6cFwYZlMPkMMZ/JaFNK6uuAC0hjcpo3R+RsshCUvEEMuXX1w+IQ5PVhMKQdTb1
 5taaql3qluYImzewjuGJIyO2WCG5UEHeDTTAaohpWh+0p3Zv1i6AtCIMnWuXmqv1EItJlQA8d
 4pJb0fsy/e3/CIE5aGqaJrOasRay/g9AW/yPSeVFJwgLtHebV58uBDt8J0aV2LNkkEb6sx3B9
 jBaG+hZiB9/BJrY1sJWrg0vwxXCHRfY7LnKfhYJ0z0YlbsnO3FNZJdMoeRwNiRVVftSw3WL8/
 9GDwE42Rd1vQYLGtLzk6bDxobsPlrYg6k1VPYodHo8NEm4PveNvEls5yQ9e6ijf5+zDqPNyaH
 VF2aL7OQB7U8pB7N9kTdSyPklICvwORKds4Lx0pv9nFOejhgsaEkZxQ8sGdcwi4dW+AO/i6tg
 hlFaRxTdeoTTlR3UsLiVuA+Zl2/B6GMVCwgpIfw9puEOjtigkdyq9Rue2w9FVwfoeDPnMNq1z
 XaNvXU1qUPp6dpEphGmwgffJd8NNjfOpF6k/ppeRtEWYgzYF7cebRiV0lLpicMm9Ix/KL8wPm
 tij+7XLTdXNp1moSCC9T/j1un5OxfTn6W6UujyNGspjDw3TksCyYscoj7geEZnzDoZIgGsZ7P
 ecpRVjroNcfLyxO0aVyhgTb36R1oGDKlnI2eBL1gJ+0wqsqyYnGN05zwf2WM6PIAfPr77GVGM
 sojRsJIapzB4fMrfR/QMF/1BwJDC4jP7Cfom89PEYuKRo3DJy9aWKdBuw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/22 20:54, Jiang Jian wrote:
> file: drivers/video/fbdev/omap/sossi.c
> line: 362
>      * We set explicitly the the bus_pick_count as well, although
> changed to
>      * We set explicitly the bus_pick_count as well, although
>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Both patches applied.

Thanks!
Helge

> ---
>  drivers/video/fbdev/omap/sossi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/omap/sossi.c b/drivers/video/fbdev/omap=
/sossi.c
> index c90eb8ca58af..66aff6cd1df0 100644
> --- a/drivers/video/fbdev/omap/sossi.c
> +++ b/drivers/video/fbdev/omap/sossi.c
> @@ -359,7 +359,7 @@ static void sossi_set_bits_per_cycle(int bpc)
>  	int bus_pick_count, bus_pick_width;
>
>  	/*
> -	 * We set explicitly the the bus_pick_count as well, although
> +	 * We set explicitly the bus_pick_count as well, although
>  	 * with remapping/reordering disabled it will be calculated by HW
>  	 * as (32 / bus_pick_width).
>  	 */

