Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F99D4D5C49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347173AbiCKH1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240189AbiCKH1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:27:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F81B6E1D;
        Thu, 10 Mar 2022 23:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646983552;
        bh=tb9da2vliY1QQTm6kyIGSzjr3e4h0kXK9SeRdQvrfr8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=i4fEm40CgZn7fcVYKtJObjuy0qSJvvuy/1qk4V3wue+LK7pgYyHmS5jFqBD3FlLzf
         EWv4O/J6+VOBsnJhWJzAg5CzeWKKmj36pda7c+o+BeyEjsjWuSLubcxrdc/frPE1m5
         jwp8pTUaTmoS/Lz8+inXBBLC+1OIT17mO+0lZxSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.134.231]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmfi-1nYVy62kiQ-00TFb0; Fri, 11
 Mar 2022 08:25:52 +0100
Message-ID: <648cd020-a275-ea0b-e0bf-ff064dde16b0@gmx.de>
Date:   Fri, 11 Mar 2022 08:24:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] video: fbdev: fix warning comparing pointer to 0
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1646967409-27868-1-git-send-email-baihaowen@meizu.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <1646967409-27868-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9oHRzazegTYr+s16w14CND5n3RyXpeXOh+Y9VrQJYT7QBCkwN7D
 NXyPXPpNvAipyCienSK4HucCXNaM6vB4+ngkxx/fHFap4JmUgs7JA5nm5pWbuOg2anoccpi
 YUJV570vjxqDLFehKcewTagQsjQLTB+cRq0Q7s3G/WD2cLEWrGNzYHD0bzauyPs8+Ydg2C0
 /cy+rcNy+7FaUjqcR1TaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VNOq6dyrtT8=:EmOPAaPuupqWtIOfvgapHL
 FqBCLVShH5WDoTQn04cj+c+TeFajMbtN90vC0d4wce4jfNSqLjywCk9B5l7U9/vkb8arMudRh
 0H/AnBAGYdCugjfK6UqA+YMXNlgP6TLJYHDMI40yi0eruc+gIsEU7RPI+KfjW0EQU4Wg8uZRJ
 B6ap2liCYZUnOFRhrrlRMkzU5uO+Wvu/t23i62aKWZcaG1eaUQVixNagNacpug8RPVJkWCFvo
 3GXVtlOXEEK1XzEVuWCMSJW5RZdRUPpIzPHm6g5aIcrNL618pWH+kZ7ZwUPfrS7skeLn6odYe
 gy/prYGr/N44VB0srG9pp46fXKV4EAd4TxisMEeIFrpwoJ3KjWGvOakn6NgnY8xJwhhCLoPrA
 mSy9ItlZVg7ec/X0oZJYqKHrZYakfrK5orYpIKVVLUp17TG9UvVtX3wiuAm7HRQmCbhvmqPD3
 C4xgG1PQjTEIaZd4j9eXLHeuy9RGcaLS/rWkIB1X8zvbFLcuod50w5auiTS3jDY0XEaCkS/uJ
 wu0t9ViOjR3ekFK4/J7SaHEAgS0bv1EPN9qMtUqlAsUIjXti+++jSSuM2n3sK9RWaEtjhL0a+
 8duHdsY49mUqKtcs5Jffg55+3JPXkQQ4EdN9SGTimFZ8DYJJq+TORiWmPDvJbwDlCLHy85myD
 zUwc22WPgk6DMNDVyldX7lT4Q8Xn0rDaRhufXf3MkG2AwS0nE8UTZLVFkzO2N3oJIC+kxN14K
 aXFeMHQAOr/3kEExH+LUdimaKJJGbu2EZycFfVSvx0q2DKE5w/tW2mGQE7HJJkYxrcHx+liIF
 qlShWQ5nDYK7d+ceoogi3QxekzzS1Ukjo6T8AN9dqcAYmlfaTFlW/6Te4fHXVV97dCn70qX5N
 xwQe7ew61b02tp4+WWyOsF7+k32O/dqmRCgYwcqB07kGIq5DtCKqpMZqpfVREpkj/iuM9N2oA
 G1ba1aXAMhlXIYTNDY5INSEFHTiwNEtl4g7JvjB/DkP3tr1S8PYZw+JLzAspJR1VK7jD8pDDP
 qahOC37lGt/V/VbCTeBdrQZpL/W68qx44U+PshgtFFZISUlFx+0sDLEBOtMCxK6Ta4mIwXexT
 TR0Hejbcadi0pY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 03:56, Haowen Bai wrote:
> Fix the following coccicheck warning:
> drivers/video/fbdev/offb.c:415:13-14: WARNING comparing pointer to 0
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

applied.

Thanks!
Helge

> ---
>  drivers/video/fbdev/offb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 4501e84..afdb6aa 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -412,7 +412,7 @@ static void __init offb_init_fb(const char *name,
>
>  	info =3D framebuffer_alloc(sizeof(u32) * 16, NULL);
>
> -	if (info =3D=3D 0) {
> +	if (!info) {
>  		release_mem_region(res_start, res_size);
>  		return;
>  	}

