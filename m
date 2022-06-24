Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD693558EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiFXDJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiFXDJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:09:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA4C313AE;
        Thu, 23 Jun 2022 20:09:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LThsm5TPjz4xLT;
        Fri, 24 Jun 2022 13:09:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1656040142;
        bh=K++hI2FDkjV3G5478DzfpzmGcEObLlrEm0qg0VKmAH4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JHX2Ao+4jSwUp4Lj3ajWxHaaPO+OTH7kx/LBQVq9vuerTA4WfbzY9j1VeA0zTZGbv
         gcWkiP8DEDI6VrW7PNNv7SmUrjOTBHcGIoIKzsLffPV4aq49KcTKjF1roSxxvzMKok
         tiRC1n0QTPGF7Bzel47PCPX+J+KSGmVd+Ui9HJ9soXKau2mD1hHEjSNxiyVVXLTlpF
         lWYq24g9zZHP87qx2D4YMG9CXWdExUBszaJL74+t+p7QKOCh3XK7byz3HiuelNGnza
         q1+9XMBDq6/VqO8NipT1I3rObNZs3VaiOK6VHqpdduGeZxQWDhaEsMY8ks7q4Vzsoi
         lnyvRUex8xctA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Marek Behun <marek.behun@nic.cz>,
        Josef Schlehofer <josef.schlehofer@nic.cz>
Subject: Re: [PATCH] powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers
In-Reply-To: <20220511143712.22550-1-pali@kernel.org>
References: <20220511143712.22550-1-pali@kernel.org>
Date:   Fri, 24 Jun 2022 13:08:59 +1000
Message-ID: <877d5669mc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:
> CZ.NIC Turris 1.0 and 1.1 are open source routers, they have dual-core
> PowerPC Freescale P2020 CPU and are based on Freescale P2020RDB-PC-A boar=
d.
> Hardware design is fully open source, all firmware and hardware design
> files are available at Turris project website:
>
> https://docs.turris.cz/hw/turris-1x/turris-1x/
> https://project.turris.cz/en/hardware.html
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  arch/powerpc/boot/dts/turris1x.dts | 470 +++++++++++++++++++++++++++++
>  1 file changed, 470 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/turris1x.dts

The headers say you Cc'ed this to the devicetree list, but I don't see
it in the devicetree patchwork:

  https://patchwork.ozlabs.org/project/devicetree-bindings/list/?state=3D*&=
q=3Dturris&archive=3Dboth

Which means it hasn't been run through Rob's CI scripts.

Maybe try a resend?

cheers
