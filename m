Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742954AEE0A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiBIJ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:28:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBIJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:28:27 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FD7E040DF7;
        Wed,  9 Feb 2022 01:28:22 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4JtvXs5xjjz9sks;
        Wed,  9 Feb 2022 10:22:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644398539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgbpLpaaEGPG47I00MAmDGZQfBwt9YRqZQjIkK1jtMg=;
        b=UkIoleO0FfNvl+C1vKOXO28em+LOYURsmKJpnglQz5VNxESxpVa6x19Rh2ECJhgCE60NiO
        6dZCoqq9C/qHDJX7eLAactdnDlgtJ8S5geppzhlG7avqviUefgnDp9Jk8Pcf6MjQnnrV89
        TK2A+VcF67IbvQj4zfl7PfVHyw5OioDp9yeHQ5GgStzQFbkreQISSw5Q8GmIgPiCSBkxag
        4KEnKexJIUEqqVQBTswnWqpEaK4TGcG8qPfhDf44Px5AEwudNxuD6WExWYQDtD+uTZWrS+
        Ah/YLnnP7ROJhm0xLhwJlcdLgB4Io332vv/nJOKLoxy++ZeGh4iY99Fev2W4Iw==
Message-ID: <b213a0f4a2baac25f5758acbce222d0ace0e5b35.camel@sylv.io>
Subject: Re: [PATCH v1 0/4] Support bcm6123 Bus Converter
From:   sylv <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Date:   Wed, 09 Feb 2022 10:22:02 +0100
In-Reply-To: <cover.1642434222.git.sylv@sylv.io>
References: <cover.1642434222.git.sylv@sylv.io>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since this driver actually implements the supervisor pli1209bc,
see this patch set as discontinued. A new patch set will be uploaded
soon.

Thanks,
Marcello

On Mon, 2022-01-17 at 17:12 +0100, Marcello Sylvester Bauer wrote:
> Hi,
> 
> This patchset adds support for BCM6123 Bus Converter from Vicor
> Corporation.
> 
> Marcello Sylvester Bauer (3):
>   dt-bindings: vendor-prefixes: add Vicor Corporation
>   dt-bindings: hwmon/pmbus: Add vicor,bcm6123 Bus Converter
>   pmbus: remove trailing whitespaces
> 
> Patrick Rudolph (1):
>   pmbus: Add support for bcm6123 Bus Converter
> 
>  .../bindings/hwmon/pmbus/vicor,bcm6123.yaml   | 41 +++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  drivers/hwmon/pmbus/Kconfig                   | 13 ++-
>  drivers/hwmon/pmbus/Makefile                  |  1 +
>  drivers/hwmon/pmbus/bcm6123.c                 | 90
> +++++++++++++++++++
>  5 files changed, 145 insertions(+), 2 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
>  create mode 100644 drivers/hwmon/pmbus/bcm6123.c
> 

