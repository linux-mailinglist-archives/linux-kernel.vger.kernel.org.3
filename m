Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67444D5864
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345773AbiCKCzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiCKCzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:55:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4151A41E8;
        Thu, 10 Mar 2022 18:54:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DF29B829B3;
        Fri, 11 Mar 2022 02:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD226C340E8;
        Fri, 11 Mar 2022 02:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646967237;
        bh=588IBEkctxlxnnnIfppxQo+hNyEmP5ZQYDkvwdKTuuI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kea86LqXfJZkeu/UqM7dP/oYoeqwbEu1Qk2IHKwAg6wPUZLN+72NXAkXANKVT4x8F
         7deMKeAW6mjuMbL27MXOTIUzhpAxeBZFr3FDUqAAiy1KWaN4GJOFQTZyAxdBNygm65
         QmhXSXNE21SbrsrmPUsTWaJeAUAG8xyYQJZf0t2B8bIm1xWOY9EXU+PdcQqfegFZpq
         qdJBGCXY2QYgLb3g3318M3M8gKAmY8FPhGUabkfGJzW+KKcuWVZ1s4vdIC3pr394xe
         nMK1bnWyxTY2H+zg/bpxNf/ljbZps39UV5KooFOjC4s+VuDxljli30kpUfAsKPNf8s
         jqo27HYSg+krw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220126173953.1016706-4-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk> <20220126173953.1016706-4-kernel@esmil.dk>
Subject: Re: [PATCH v1 3/7] dt-bindings: clock: Add JH7100 audio clock definitions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Thu, 10 Mar 2022 18:53:56 -0800
User-Agent: alot/0.10
Message-Id: <20220311025357.CD226C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2022-01-26 09:39:49)
> Add all clock outputs for the StarFive JH7100 audio clock generator.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---

Applied to clk-next
