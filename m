Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AA85573A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiFWHNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiFWHNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:13:39 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E1E457AF;
        Thu, 23 Jun 2022 00:13:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f39so16144887lfv.3;
        Thu, 23 Jun 2022 00:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=HKFgy2ePSsWBd5WuvWRCAAgtGzNsGiovMzKJw9WuAWA=;
        b=YHqD16i1gy7q5AU1NQ3/V1N310bWjVPrieL93A3boF19PSadG6dWxkVlfmG842U47g
         74r/2zMgBXhaCoa8PyF27NUbb49451lSdYuvYHjO1SH4Z7CLaEO7qbFB8v5IYhWSq3in
         KAlV+lxQcrfa+6sMhYT/L1EEvAMQgiFeRS4Ppis5ftyOo2GJrVhQLlSIG4NkPzHWUcP0
         n5aIft2UUuStF45XBP1WPOoleMZ3qWKjk3iqQKtHYN7iDfelqf+/GRsPE5atiyleDAH6
         FLhnCHEU0i85+0ALhH3ZHYriyxt0/Wh58BDqsU/4rm1kv/x79LyFg0fQpqcCnbxFvr39
         M9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=HKFgy2ePSsWBd5WuvWRCAAgtGzNsGiovMzKJw9WuAWA=;
        b=fztBsPh7Bkwa+Oqu3oHXs/Rqi/zxmIHsAs9KNW7g0es7csAxrdlqgh0QzicgMNkrVg
         9lVdBhv5GgB4u2YeZO9GuqlryW5swIhpOgUPgnzVDaRnn8xEsDpvoniMaJqS7hf2AFp0
         cQMpMrN/AOgFrsifF2mkny83HK4MKQH3vrbADzTLwQTNKVECG3NFCOOjYDvEG3sgGK2I
         2xL6niUXnfpguW46O1IoxIjwzcnIDMvSP3GGJ4QC1v+5clkPcgvOFuYzXO6d4mM7ziLK
         hHCK/ZEuczTyb2muQLEXMOsNmGn6JfW7fb+mBnxHHd+Wz4EB2sMoNqmjt+pQ40C0+y3V
         qa4g==
X-Gm-Message-State: AJIora+ks9bcNgdt3tnGzT3g8++1xAUiprBG/dfnI0FfZOyQQ8eVGMdP
        GAxzwrQ0IO2GTuyB2jgsST8=
X-Google-Smtp-Source: AGRyM1tQKqOwQskRGxDVvZp5ecHNyZRyMLFkiEcuNVszS7TJ5maJeX2lgHeXtpbyA72kS7dUtzTlrQ==
X-Received: by 2002:a05:6512:3f15:b0:477:ce24:4e1f with SMTP id y21-20020a0565123f1500b00477ce244e1fmr4473530lfa.355.1655968416440;
        Thu, 23 Jun 2022 00:13:36 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id q20-20020a2eb4b4000000b0025a6a8bdcc7sm1655874ljm.1.2022.06.23.00.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 00:13:36 -0700 (PDT)
Date:   Thu, 23 Jun 2022 10:13:26 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Daniel Stone <daniel@fooishbar.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Sharma, Shashank" <Shashank.Sharma@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media <linux-media@vger.kernel.org>
Subject: Re: DMA-buf and uncached system memory
Message-ID: <20220623101326.18beeab3@eldfell>
In-Reply-To: <c6e65ee1-531e-d72c-a6a6-da7149e34f18@amd.com>
References: <91ff0bbb-ea3a-2663-3453-dea96ccd6dd8@amd.com>
        <YCuPhOT4GhY3RR/6@phenom.ffwll.local>
        <9178e19f5c0e141772b61b759abaa0d176f902b6.camel@ndufresne.ca>
        <CAPj87rPYQNkgVEdHECQcHcYe2nCpgF3RYQKk_=wwhvJSxwHXCg@mail.gmail.com>
        <c6e65ee1-531e-d72c-a6a6-da7149e34f18@amd.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QmOTkLNi2kJF4_bkXoJdUR3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QmOTkLNi2kJF4_bkXoJdUR3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jun 2022 08:59:41 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> The exporter isn't doing anything wrong here. DMA-buf are supposed to be=
=20
> CPU cached and can also be cache hot.

Hi,

what is that statement based on?

Were the (mandatory for CPU access) cpu_access_begin/end functions &
ioctls not supposed to ensure that CPU cache is up-to-date / CPU cache
is fully flushed out?


Thanks,
pq

--Sig_/QmOTkLNi2kJF4_bkXoJdUR3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmK0EpYACgkQI1/ltBGq
qqcw7w//QVXYLoKhIBnGN34yEmHzycIRr1pys6yOt0O61O+o3mO+5B9sUxkiNZT7
AOtn1CRxJMBYC0sTSWhi6TZyN6MP0GW80CMGtCLmLCb8T19U7CBsBflVtc8e0aM8
GXiSbIW3BJEt2pXAUa+jVDeI7TyVjw6it6k21PVv6EV/iIR84BYuGZIBbOwRi/UU
A3aNvFyTfhbi5fHwZJxgkv6SLsRBgTkHnyAVOcJ90FJgz1mHYONcsZKGp6q77tAt
r9+jBo+5HWfPZSzAAcJg9tIGr77VNjq0YX/jj4R7MWd5Sb2EPFR0df3mXvIIQNR+
7LqslvdNaaQkfh23bcGXvtbOgceboy+DUj/rPvC0eHQnGUop/hTJySw9p6n7QU3Z
q8ubKBzmWllcwNhwnb/aun23LBuBh4Nx5RI+oxg8Bwz4uvMg9WK0cjGm+AInFLTU
+GmmjUw2NK7jLF13Iu8n+5Z2SsxjAojoIsKQSkdH1buFdEcQNp2lzZH8RjIAkOGC
4D5AQMl0t891tH0XXRWxC3HOGi1RdfS1NzgG/mrG41NLdCG/bq79xsP56cFVUceb
ACGl3uxrxlabcFxEiP9peR8ebtEnRn0ZCRcpd02RgIgsM7+jzuuOZ8EdBGBK+fVz
fuz2KKG0X7sQT/03x7Zbi0VQWf8SAR1C9JBkiJsLjvOkFBZV4Gc=
=WrtI
-----END PGP SIGNATURE-----

--Sig_/QmOTkLNi2kJF4_bkXoJdUR3--
