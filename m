Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6132E52974A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiEQCT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiEQCTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:19:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2210403C2;
        Mon, 16 May 2022 19:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2EA5B816D4;
        Tue, 17 May 2022 02:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7190EC385AA;
        Tue, 17 May 2022 02:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652753958;
        bh=QHq01KWSMGiuXKgXM5MI2vADm0koj3FbWwa399IU7Cc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZQmQzwx3Kwvo35oFeyW4x4xPzXjCLMhDRpISTXU7uQZA6M040CdPXJXj1QX+ZHDVx
         ZTJ3bI4n27DOJog0/MZXryVcbeY1s5hNUpRrRJ9fCUQc5CIr9wH6Qd5BrwswGMHXL2
         /0mEpteF3K6uIn0ewCkLsO0Cew0l0ayS3LrEe7380O6q/S5vq8HnIlJugn9rSaNhve
         vmkGyHudzRfQIra58ute6wyeKdZ5YDyzSg7m2iaAo3OlXMdghjbSG1GawRcvb0USBo
         uQl7AIamaku4ByCpzJLwjnozBmCxC864GJ3+SsbUbRAy85e1vTW3ncftEeUNEsg8cX
         NUF51o1SOVkuQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b5ca5d417be079a2a40a6e79ac1b246b6359a49e.1652329411.git.qinjian@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com> <b5ca5d417be079a2a40a6e79ac1b246b6359a49e.1652329411.git.qinjian@cqplus1.com>
Subject: Re: [PATCH v15 04/10] dt-bindings: clock: Add bindings for SP7021 clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
To:     Qin Jian <qinjian@cqplus1.com>
Date:   Mon, 16 May 2022 19:19:16 -0700
User-Agent: alot/0.10
Message-Id: <20220517021918.7190EC385AA@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qin Jian (2022-05-11 23:30:59)
> +
> +    extclk: osc0 {
> +      compatible =3D "fixed-clock";
> +      #clock-cells =3D <0>;
> +      clock-frequency =3D <27000000>;
> +      clock-output-names =3D "extclk";
> +    };
> +
> +    clkc: clock-controller@9c000000 {
> +      compatible =3D "sunplus,sp7021-clkc";
> +      reg =3D <0x9c000000 0x280>;

The question is what other device compatible is in here? The reset
controller?

> +      clocks =3D <&extclk>;
> +      #clock-cells =3D <1>;
> +    };
> +
