Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A280A498712
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbiAXRi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:38:27 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:33033 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiAXRi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:38:26 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MI4gb-1n6G8t1YJT-00F9bj; Mon, 24 Jan 2022 18:38:24 +0100
Received: by mail-wr1-f50.google.com with SMTP id s18so15008492wrv.7;
        Mon, 24 Jan 2022 09:38:24 -0800 (PST)
X-Gm-Message-State: AOAM532wZ/7hDIwWVwGqKyTMpN/7w/SxsY5tVPI64gOAxf9MNq7pya2C
        kq2rztD30Mt58FtjPiiZAl3EMC2rz0rqlNTm6Sc=
X-Google-Smtp-Source: ABdhPJyXZF2Mj32FjIcX5YcSsfFjBiMAv8HzCU2khH2F5s44N81S3irwIWHPo6ztRa/zA18kUOwyvr7pqZEPgvvDxxk=
X-Received: by 2002:adf:fd05:: with SMTP id e5mr15019518wrr.192.1643045904049;
 Mon, 24 Jan 2022 09:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20220124160107.1683901-1-kbusch@kernel.org> <20220124160107.1683901-6-kbusch@kernel.org>
In-Reply-To: <20220124160107.1683901-6-kbusch@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Jan 2022 18:38:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0i87SHhAvG2GuruGgnTzqAuHaEQ0iq9udaMwX56aaw+Q@mail.gmail.com>
Message-ID: <CAK8P3a0i87SHhAvG2GuruGgnTzqAuHaEQ0iq9udaMwX56aaw+Q@mail.gmail.com>
Subject: Re: [RFC 5/7] asm-generic: introduce be48 unaligned accessors
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Coly Li <colyli@suse.de>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:I8h1ypcpQkRVWYDmhHD/7ZNBaRfwZbx4+VRS54tR3JyXNphMEfB
 z54KvBcDDtEa/MBE7dN53mI5dqkOoFGWp8lMih5OXZw5ukhwwAtDsoP+pUVO6CJJR91Adfd
 AoIKE/3yKOX87arMjSdbWDaB7IRqVKP3EIwThbxqSiWGa5BJ7MYyIE/Q8n85ZzHuOryD2UO
 jU9pRnU0chK/aawyX36Zg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yYbU92YJgN0=:zF7fXxd/lCqCcUbPx/Uwbz
 J9nARFuQXexhVj1/CFuxAHbI7oxDLqJS8MbsQ+LLqcMpwlLS3qR7ZLT2SaBtWPYqz6EaC6wLN
 QDE6VN4ZzgU+4xktwPmLgFJaDlz16xMWUa6aZ2qgb+vvq4iPd1OnKqOh4CvXYQ6Y8d5p+Ex+5
 W2nIf31TfHS7nGw5lkM/SOPIQK0OBQadNwIq+legAJy6B+BMF85J8LMiVr+14jLHgfxzEndYb
 Qo8bRhwquW18Nqrb4sA4tHAdepSs8pxhXkS0dGDVeoje6foumgG9l5U4442cCfDlkFdMrzRqI
 AlaWmpGuxueyFjkV7pmNnqzcMhsv0YfJizf8OIX7fVUSjYWpvFwUGWcWUaRezG8zFpDutcEsR
 Zrg1IFKGpAr33QNgxKggTpyOaytjm2oL+3U82uEq5HwJ2xlf+H1JYR01uvdVdIhEgnwQpuCxy
 rORfoynedSd5Aca0CBxmDal33N1bs9HLPLifZoTyqL1BwAAHekZKu0jhHBRILgkwQh5FX5dIJ
 w6GF1TLsGdlB2uXcrgWVPtsRWX+ScrqpqQF+MTtktqvdogq42Xvxq0BvNIiRMRQes08Y3MWyM
 HDHa5oU6tHkqcZk6JsaXmfhJtb4cDYst8FHkKVhmJ+fpFzjnPrwmlr9tqlmXp9NyKM4miUPHU
 s5Y8VYf870Kp7bMB+EdOXqQvMvdF0GU1gmQe9nUxwnWA+lKqDH2VlrtPzutP7g+faeVY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 5:01 PM Keith Busch <kbusch@kernel.org> wrote:
>
> The NVMe protocol extended data integrity fields with unaligned 48-bit
> reference tags. Provide some helper accessors in preparation for these.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

For asm-generic:
Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume you are keeping this together with the rest of the series.
