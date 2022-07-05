Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F137566A46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiGELyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiGELyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:54:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A3317069;
        Tue,  5 Jul 2022 04:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52A81B817CC;
        Tue,  5 Jul 2022 11:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104D8C341C7;
        Tue,  5 Jul 2022 11:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657022041;
        bh=xPWHUAWA1OzLNPdBjpQH6oZ2wBudhcnzPT27+wGyRK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oi2rW1/3wrIN8h/7P9KudZxtNEtk/aXqe3eatSV3nRHjBX+W4jmtl/22ARiYgljem
         XeUnkjuk2vHmu4hQxXO+0Kkt1tss5db4wCvqKfMB28OqoOlEdUE0MUEYvFEMtDQQds
         tu1mucnsITKA67vbw26cH0H5VjK8MoOdTnbw10Rltglp6pRhv9iyU8KwWedfCt3Llh
         9GbbWsiAKDWylOubRzgA1OVJ/aZ8B898qt/dakvyUmAJS8sfiaXXTMGso+Lz0tb4ep
         1rMRQolvlX1qXpfeJVllU4P2qYZXwHvdBJCjYkjoKhUQqe4yJ4jAeflWRVjAPUiSq+
         RxlwzofXOLiGQ==
Date:   Tue, 5 Jul 2022 13:53:55 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add cznic,turris1x-leds.yaml
 binding
Message-ID: <20220705135355.008f6bec@thinkpad>
In-Reply-To: <20220705114238.xwgexavgozqskwbw@pali>
References: <20220705000448.14337-1-pali@kernel.org>
        <42d837dd-fbd1-6294-2fa0-8a07ae0f8d44@linaro.org>
        <20220705114238.xwgexavgozqskwbw@pali>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 13:42:38 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> I have tested bindings on the real hardware and it is working fine
> together with the driver from patch 2/2.

I think Krzysztof meant testing with dtschema.

Marek
