Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A0486D31
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbiAFW2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:28:02 -0500
Received: from ms.lwn.net ([45.79.88.28]:51092 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245078AbiAFW2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:28:01 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 53E314A6;
        Thu,  6 Jan 2022 22:28:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 53E314A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1641508080; bh=/n2EyPXXJQgHyMAHasj4t1toel9J8whl5UU0RPx/C/8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Y/7it+4C7JtsXjntnqu3WVW2KrY4camzafYLe3yLPkL+7wAglvIb2RaiOdXqEijq/
         BDAKiTRVpTU+qoKqX76q8zt3Es0SmPNvPyNmbUK3kN7NSxm19+yS4J/cvr94OTVp4n
         aQnUp9UsyQjvVubwOLePjPIhtvuXZ9tlpi8qdBMrW1wMeCmSjT13raeEUTcyh+/tqM
         CYXXiBbOOPi0kyWuxdiAGeExaGzqQa6FFGIYfYIW7rwsPNrOdMJLX1gUY7vbAkuYrs
         Wf8bFuJcgMqrRhRybV0fvIzErYkp2QUkFXK6TAyb46n4/O7z2qF9zhwvO6QTyiHf7O
         22g0d6qwKGECQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christian =?utf-8?Q?L=C3=B6hle?= <CLoehle@hyperstone.com>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>
Cc:     "dianders@chromium.org" <dianders@chromium.org>
Subject: Re: [PATCHv2] Documentation: kgdb: Replace deprecated remotebaud
In-Reply-To: <4050689967ed46baaa3bfadda53a0e73@hyperstone.com>
References: <13287b7914344c7995de27224cd2fa73@hyperstone.com>
 <4050689967ed46baaa3bfadda53a0e73@hyperstone.com>
Date:   Thu, 06 Jan 2022 15:28:06 -0700
Message-ID: <87ee5kpki1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian L=C3=B6hle <CLoehle@hyperstone.com> writes:

> Using set remotebaud to set the baud rate was deprecated in
> gdb-7.7 and completely removed from the command parser in gdb-7.8
> (released in 2014). Adopt set serial baud instead.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  Documentation/dev-tools/kgdb.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/k=
gdb.rst
> index 43456244651a..7c90e111b364 100644
> --- a/Documentation/dev-tools/kgdb.rst
> +++ b/Documentation/dev-tools/kgdb.rst
> @@ -557,7 +557,7 @@ Connecting with gdb to a serial port
>     Example (using a directly connected port)::
>=20=20
>             % gdb ./vmlinux
> -           (gdb) set remotebaud 115200
> +           (gdb) set serial baud 115200
>             (gdb) target remote /dev/ttyS0

I've applied this, thanks.

I can help but wonder, though, whether the historical information in the
changelog actually belongs in the document itself.  A user on some
ancient system who can't make the example work is probably unlikely to
consult the git history when looking for a solution.

jon
