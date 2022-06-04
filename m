Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C756C53D7C2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 18:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiFDQ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 12:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiFDQ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 12:29:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8771F38DBD;
        Sat,  4 Jun 2022 09:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D279B802C7;
        Sat,  4 Jun 2022 16:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB044C385B8;
        Sat,  4 Jun 2022 16:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654360170;
        bh=7d5aAfbuVsokc3Hx6f2bqfKTB2fqGiox7OK0FoJLvRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s71uDuBCowx87YXKE1+4/eD6ZJ7hQ2foZJDi8NsPiasrmanOfxbTO6LVhMyOuxglR
         RzGz2pUVoVisij4vV0S5KkLNVlJD+xmgQNk4g3fDt0aaYIpQpp2V24Q9f/wgNeOpgL
         ZIRwp4YjCw4wj1XA6EPzz07ihhVTgPiTOQgcLTVajvjQ9XQOB7s844GzkLTnQCCSUP
         iHxZAfs+O5hQTIRmKkasMBDQNCRWEIGBcatHvfRzI+2mKQMin7p/8EdzI7lprZNoci
         /Use13KB1l0gebHp8hwcbSkWaZZrBzKaZZse3DmdqZQzSf75cRh99d1eVDC7FSl7Bg
         pinF2a5XXMtGA==
Date:   Sat, 4 Jun 2022 17:38:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] iio: sx9324: Support CS idle mode
Message-ID: <20220604173831.254345c2@jic23-huawei>
In-Reply-To: <20220503193937.3794477-1-swboyd@chromium.org>
References: <20220503193937.3794477-1-swboyd@chromium.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 May 2022 12:39:35 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> I need one more property to set another regsiter field for 
> how to configure the CS pins during idle and sleep modes. This is based
> on the latest patch series from Gwendal[1]
> 
> Changes from v1 (https://lore.kernel.org/r/20220503004156.3559940-1-swboyd@chromium.org):
>  * Change 'hz' to 'hi-z'
>  * Add property to example

Series applied to the togreg branch of iio.git and pushed out as testing to
let 0-day poke at them a bit before I make a mess of linux-next.

Thanks,

Jonathan

> 
> Stephen Boyd (2):
>   dt-bindings: iio: sx9324: Add CS idle/sleep mode
>   iio: sx9324: Add setting for CS idle mode
> 
>  .../bindings/iio/proximity/semtech,sx9324.yaml   |  9 +++++++++
>  drivers/iio/proximity/sx9324.c                   | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> [1] https://lore.kernel.org/all/20220429220144.1476049-1-gwendal@chromium.org/
> 
> 
> base-commit: d79478a79cfa393cde46bccb05d52fc7d875d2e2
> prerequisite-patch-id: 05986765e921df4c9725d10a3f51e68b0b5cc211
> prerequisite-patch-id: 5e47b28af046dce1eb7d7ca492c466df0f30e07c
> prerequisite-patch-id: adb59d1a14b74ddfe02c442da8bcca04765e7d15
> prerequisite-patch-id: ec6069ee00463db27826962537ff880e69522f70
> prerequisite-patch-id: e40f2a3048da2ff28bb426b85e41d277f29f18ef
> prerequisite-patch-id: 82077662b97c09014c5b291fe5a42938a29ddbcd
> prerequisite-patch-id: d02f0ec3be1fa9cdbf02a22c700982008d0550bd
> prerequisite-patch-id: a02a8faefc5b7b68b99c0cc326973948c9356b60
> prerequisite-patch-id: 522c808e4b8bf99b8404c01d495526a685e5b97a

