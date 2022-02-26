Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CACB4C5895
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiBZWsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 17:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiBZWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:48:16 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F6B848;
        Sat, 26 Feb 2022 14:47:38 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id C3F62135;
        Sat, 26 Feb 2022 14:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645915658;
        bh=tIcumh48jcpGZxoz/OHLB3R+NNcH8VOgxfnwIzwaJxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mH/In1OBn/CN42PCTjp038POsrGzKe5EmHsGI8RXHUAcxGvDBsmArcN2EfZuleEV5
         qWphK0ui1OvFbdjPWvSPI7iJD3sbo7xveOY0eWa/NbvKcQkxOqOBf1qnT2umv32d59
         NUrC0VsxI/hJyKdRgPg6aY/5i5OTca0izIf/Vz3o=
Date:   Sat, 26 Feb 2022 14:47:36 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] hwmon: (nct6775) Add i2c support
Message-ID: <YhquCDp2bnY6I9ra@hatter.bewilderbeest.net>
References: <20220226133047.6226-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220226133047.6226-1-zev@bewilderbeest.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 05:30:42AM PST, Zev Weiss wrote:
>Hello,
>
>This patch series augments the existing nct6775 driver with support
>for the hardware's i2c interface.
>
> <snip>
>
>I've tested the nct6775-platform and nct6775-i2c drivers with the
>NCT6779D in an ASRock ROMED8HM3 system (the latter driver on its
>AST2500 BMC); both seem to work as expected.  Broader testing would of
>course be welcome though, as is review feedback.
>

Also, for the sake of anyone testing or otherwise applying these patches
I should mention that the series is based on Guenter's hwmon-next tree
(commit 9db3b740a801).


Zev

