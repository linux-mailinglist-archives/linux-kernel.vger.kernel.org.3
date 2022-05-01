Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177395164EF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348091AbiEAPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 11:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348033AbiEAPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 11:21:31 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E979DBE3E;
        Sun,  1 May 2022 08:18:04 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id A6484EB7D61;
        Sun,  1 May 2022 17:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1651418281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/J2Qg4ZGrbgM3NsVfkQsNh+Hr88w3IF90qf5ZNZMp2w=;
        b=fkfLpaOP5/1e3t2DI9GF8I86Q2n5h+eGzw/0mMs6eWFWFoX+F8t8lhAHtSOA4JZKL0lV83
        jn2p/5Pl0Utc/wlWAoS00jyylnWb5AIoDiSS35T9ZuIL1qfpvxgkg4yQNJyWTaOLDUYRIN
        FDU8FysoGKxcQ5HF/n7bgrSVFYilQkM=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Renze Nicolai <renze@rnplus.nl>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] hwmon: (nct6775) Convert to regmap, add i2c support
Date:   Sun, 01 May 2022 17:18:00 +0200
Message-ID: <2508913.OsOuS879W0@natalenko.name>
In-Reply-To: <bc46d60e-7c89-ad05-780c-9e9fd19f788e@roeck-us.net>
References: <20220427010154.29749-1-zev@bewilderbeest.net> <bc46d60e-7c89-ad05-780c-9e9fd19f788e@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On st=C5=99eda 27. dubna 2022 15:37:07 CEST Guenter Roeck wrote:
> On 4/26/22 18:01, Zev Weiss wrote:
> > This is v4 of my effort to add i2c support to the nct6775 hwmon
> > driver.
> >=20
>=20
> Thanks a lot for your effort.
>=20
> I applied patches 2..6 to hwmon-next. The first and the last
> patch of the series will have to wait for DT maintainer approval.

Zev, sorry I'm late. I've just tested what went into hwmon-next (patches 2.=
=2E6), and it didn't affect `sensors` output for me, so I guess this confir=
ms what you asked me to do ("I don't have access to any asuswmi hardware, s=
o testing of the nct6775-platform driver on that to ensure it doesn't break=
 there would be appreciated (Oleksandr, perhaps?).").

Guenter, if it's not too late, please consider this as Tested-by: from me o=
n this part of the submission.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


