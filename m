Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC64B7B17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbiBOXQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:16:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbiBOXQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:16:13 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A9F8B93;
        Tue, 15 Feb 2022 15:16:02 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5ECC4385;
        Tue, 15 Feb 2022 23:16:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5ECC4385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1644966962; bh=vpOsw9X1kqHqWwkdogeCZakYlpuIkHDxESWMtj103W0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Bc5haah1QXE5NxadYz6KqD10lX5DPDeH0N32CWjgJG5N47yn+E1CuXH5qUTveQn53
         BHx1h91ypKYXtPaxCInraeE/g6E0fJV76HNc33maI4g4E6L0QK6SQxumeeJ+eEO6mL
         PYDNPNB6SfTZlMTZ7eXmxtEsQfSm+LNqLQvEszgoju85pIuQHXrf7qZoM6TgK1h/K0
         3j/7PIcSnV35RiW4pgRj2y7kjLpAdsuo6BlqDgnVeiTJRwd701g/BYL/gbwBJW8uTt
         Fbn585/gPJHBZ8zKoL6DqccJvD+pyFOxJsjAHXgNZAqQBBXXY2bGLPIOPK0Vl1bm7d
         UEMMW114jDDFw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix links for udftools project and
 pktcdvd tool
In-Reply-To: <20220210192200.30828-1-pali@kernel.org>
References: <20220210192200.30828-1-pali@kernel.org>
Date:   Tue, 15 Feb 2022 16:16:01 -0700
Message-ID: <87o8377mby.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  Documentation/cdrom/packet-writing.rst             | 4 ++--
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon
