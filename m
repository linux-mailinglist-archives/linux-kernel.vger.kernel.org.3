Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E91846B661
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhLGIwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbhLGIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:52:26 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5CEC061746;
        Tue,  7 Dec 2021 00:48:56 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-184-96.tukw.qwest.net [174.21.184.96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 08CB513C;
        Tue,  7 Dec 2021 00:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1638866936;
        bh=rFG3fPh/GO6YZe67EweUIEV/cR182XtK+FWjQnWRVC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKANB7yzY70JDvU99+fu26wXvQtyT4eeJlWmbsq4yWKP2qhUAG0P/RnG8GgmoOScb
         Bm9rDusBbcmf7Uco8MZNIM8cNBbXWwyGl6JR4V04xYIfzq8e3u4WelOSnzr74RunT5
         uCEYQ5ztHKOrqbGBxILlwE8equ6/r0lb+msO12oI=
Date:   Tue, 7 Dec 2021 00:48:51 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, openbmc@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: add Delta AHE-50DC fan control module
Message-ID: <Ya8f81AQKTmQnYde@hatter.bewilderbeest.net>
References: <20211207071521.543-1-zev@bewilderbeest.net>
 <20211207071521.543-3-zev@bewilderbeest.net>
 <498caafa-fdc5-eb5a-312f-13968a088448@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <498caafa-fdc5-eb5a-312f-13968a088448@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:58:14PM PST, Krzysztof Kozlowski wrote:
>On 07/12/2021 08:15, Zev Weiss wrote:
>> This is the integrated fan control module of the Delta AHE-50DC Open19
>> power shelf.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>
>This is a third version sent within one night, without changelog and any
>indication why sending the same three times. Please do not send multiple
>versions the same day and give people some time to respond. When
>creating a new version, add a changelog under ---.
>

Sorry for the noise -- I wrote changelogs in the cover letter 
(https://lore.kernel.org/linux-hwmon/20211207071521.543-1-zev@bewilderbeest.net/), 
but forgot to include all the recipients of the component patches in the 
CC list of the cover (which I presume would have been preferred), I just 
used git send-email's --cc-cmd flag with get_maintainer.pl.


Zev

