Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0552149C00C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiAZAQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:16:41 -0500
Received: from ms.lwn.net ([45.79.88.28]:51984 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234737AbiAZAQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:16:40 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 286525CC;
        Wed, 26 Jan 2022 00:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 286525CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643156200; bh=5TKsDFyI+qcFUeNe7IhzvHrjm7zM8RP13UY1RuM+3WM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RkUaSBGnBEp2+6U2f9aD3hrjCtoFFb7HX9HJDToNuNmiS6tBF28YT8L++j5mx47N4
         Qb7T9vpGRH3IMf0NPP1j9jCtd1aVIePtMPrjkiaDEgys1cJUSsyxxeN1nc+QCTV8RD
         dehrcJKXeKVpHKodqVw63zZhO5A5BJQYRKWZIdhFHUwL0pT7EFzXwdlGThZn/5Vvtz
         7QVkGD3rj/s5tfktGpRXtjyCM0Skdql4ku5C4NWGknmOqfp0PHWtsDQQI5Lsjj72hS
         hBWuyp8BG2t73E763Z2AVdK9diZN0/oNvxlYZKfyXHUnxq9mgFfJ4tpMGfYJqJVpGO
         nKZ5BrCC2HFOg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Extend Avanta list
In-Reply-To: <20220121115804.28824-1-pali@kernel.org>
References: <20220121115804.28824-1-pali@kernel.org>
Date:   Tue, 25 Jan 2022 17:17:08 -0700
Message-ID: <87fspbwdtn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Include another two SoCs from Avanta family.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  Documentation/arm/marvell.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> index 7f5233b3256d..234f4ab0578a 100644
> --- a/Documentation/arm/marvell.rst
> +++ b/Documentation/arm/marvell.rst
> @@ -265,10 +265,12 @@ Avanta family
>  -------------
>=20=20
>    Flavors:
> +       - 88F6500
>         - 88F6510
>         - 88F6530P
>         - 88F6550
>         - 88F6560
> +       - 88F6601

Applied, thanks.

jon
