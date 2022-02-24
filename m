Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7FE4C3978
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiBXXCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiBXXCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:02:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6351E6949;
        Thu, 24 Feb 2022 15:01:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B1F0617FB;
        Thu, 24 Feb 2022 23:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DB9C340E9;
        Thu, 24 Feb 2022 23:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645743688;
        bh=a7ZJWXlxyAuvQhWX7+dmnW1yEPIO+pGuLEjKkP7lW8Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Nl9dEl3tT14n3sMiuUHEdMMvVZqeJ4zmP5/T6RhuVJtju3xVk2rniooJoNGL61EQb
         fZM4nGgW+MhiECaJWm/my1FKPYS2o5Jt6DdFii4ie1XrnyOs7DJgfJkBAIArs+dvGv
         jMNPyyzeH1D0P1+mhaTlch3H1v4vA4hByfNJjuBmsgoDen2bQf1WBhg+/P2kI2wLHE
         KuLEveX4v+8/76z0dSWTE7T2vn2XYzqR6sqrCE5coeSFnU37VHNpSw1iiyP43mQWVL
         XCCIPrHBeW5hd6OD15Tc2aPdx0HXyGcHPCM7Mru0i9voXFMuvAXdHIaOGrK8tDKVcT
         hdH7GVPF+ta+Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220219152818.4319-3-kabel@kernel.org>
References: <20220219152818.4319-1-kabel@kernel.org> <20220219152818.4319-3-kabel@kernel.org>
Subject: Re: [PATCH v9 2/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>
Date:   Thu, 24 Feb 2022 15:01:26 -0800
User-Agent: alot/0.10
Message-Id: <20220224230128.B3DB9C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marek Beh=C3=BAn (2022-02-19 07:28:14)
> From: Pali Roh=C3=A1r <pali@kernel.org>
>=20
> Add DT bindings documentation for device nodes with compatible string
> "marvell,armada-3700-uart-clock".
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
