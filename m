Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BDC59BF93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiHVMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiHVMiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:38:17 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559E212C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:38:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661171890; bh=wS7eBcU6IrGgczgQRn/ar+Ts2JGTgJKTlU4UR4ZP25U=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=bzkKcz9aP0I6aeaU5C1aSTqv5/6IwA5HePKFdPxuaNr0X09HB12RFYLdDjGvKHbLI
         Im5zOhghXB6T4gVQMpk+IpcIBkcOQTaJdnbfoKRWr+Gn6nCWvq1N3gcxnRiAzVOJtG
         zVmVJXE0fP6qDFTxoOVix9nG9fk7IOsRP9q5DzsE=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <YwN2Pd4Ez08yDFno@sirena.org.uk>
Date:   Mon, 22 Aug 2022 14:38:09 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3234D74E-0DFF-4BB5-87ED-6135BAC1F31D@cutebit.org>
References: <20220822095242.3779-1-povik+lin@cutebit.org>
 <YwN2Pd4Ez08yDFno@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 22. 8. 2022, at 14:27, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Mon, Aug 22, 2022 at 11:52:42AM +0200, Martin Povi=C5=A1er wrote:
>=20
>> Provide a DOT summary of the DAPM graph in a newly added 'graph.dot'
>> file in debugfs, placed in the card's DAPM directory.
>=20
> There was a tool floating about in the past (last copy I knew about =
was
> on Wolfson's git but they took that down) - can we not just continue =
to
> do that?

I don=E2=80=99t know the tool or where would I find it. I think it=E2=80=99=
s neat
simply having a =E2=80=98graph.dot=E2=80=99 at hand, especially since it =
requires
little code. (Although sure there=E2=80=99s the danger of it growing.)

Martin

