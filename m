Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A357818C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiGRMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiGRMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:04:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C56D9C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:04:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r6so14935915edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=J5dOe3qrpwhe/mTO5TEDOsdj83anttAafBGUgOVvK+c=;
        b=A6LpQRPCboZ1AspzqoN4bdntSlMXB6dfD1lNPLJxeWeGkd6tfVcDUTG4jAzdnKvfxE
         TdLOcLCXKZA2+Nkj/3uZTroMW74hUFtXa6mlQHspaKwyxKx4up/f2zfGJ04zVGTjiTxH
         h8y/01xZFeQJp8sKo9Qjsd3AmqSTCpeCOAk7SmCPmGrZXYHoFGU6UVK9EDCRqSSzjibS
         T66HlPYEjU0eUzMiHvMlVtImH55Se6Avu9zEUDHHWijlmB8oOhmn//JTyNBCHdEn2yOz
         C7+sO41EtK1kpAkoXsu7DXwMc6DA61H/mtSxpNge8L0cfJX2rXb0Rx1UuVNoiUyxt2nM
         CddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=J5dOe3qrpwhe/mTO5TEDOsdj83anttAafBGUgOVvK+c=;
        b=tnFygw9g7zBxWmBCDVDim5pvnMvYc2LMGjf16QgHwyGGyvxPgBJcdpkozkb9NT9SA9
         p/CI1iZ4JNlJJ0AeFSdzgRRYgm7qIi7ppDleQqNE9Q/ETAeNRNGERnyoZ2Cv637HL++T
         TQUCy5eMPE1xPEsIy1UXdLhz95mTrmTBaIlObd7y2lSiFu/OMXdFZGcQjINGXdvQeXHg
         vVuSxgar2zhQCguKxwwBiKRTJPkBs5Ybrfz3otvT6IvKHVOb4VnhaoYjAKS2fTcFWCrB
         mgT2I4H9Jytz77ghYqTYqqB/xQ4bcNyfuzbX4pk0z5P28eCIY5u0VuWKVm7voFkFIYjt
         1bww==
X-Gm-Message-State: AJIora9cAUd3nFClH0g/wJAllrCe+ymcXPiIiwYPlx0JyV0nrW9XtcOJ
        ZMvd1aoybsbovLGvnp7qc8rgDA==
X-Google-Smtp-Source: AGRyM1tMyLWy+XGWgajL31TM0hNIHdtRpK7GdQZ1WaJ0dLa8h4P4f34Y26ViVdXKxkfb34oUe82E8w==
X-Received: by 2002:a05:6402:1e95:b0:437:ce7f:e17a with SMTP id f21-20020a0564021e9500b00437ce7fe17amr35833626edf.169.1658145844061;
        Mon, 18 Jul 2022 05:04:04 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id mb1-20020a170906eb0100b0072aa38d768esm5430355ejb.64.2022.07.18.05.04.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:04:03 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk3399-nanopi4: Fix voltage
 regulator config
Date:   Mon, 18 Jul 2022 14:04:02 +0200
References: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
 <14EE0603-99C5-49AE-BDDB-C22C5B1924E2@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <14EE0603-99C5-49AE-BDDB-C22C5B1924E2@kohlschutter.com>
Message-Id: <7AFECB02-5A87-43DD-8161-6068720AB8E3@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.07.2022 um 14:02 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>=20
> A series of issues exist around the "vcc3v0_sd" voltage regulator that
> made it necessary to mark it "always-on".
>=20
> With the patch "regulator: core: Resolve supply name earlier to =
prevent
> double-init", this option is no longer necessary.
> ...

Walking back on my claim in the commit message that no further patches =
are needed for the u-boot integration to work.
Other than that, the actual patch is unchanged.

