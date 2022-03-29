Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE74EB051
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiC2P2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiC2P2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:28:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F317E1271;
        Tue, 29 Mar 2022 08:27:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EDBAC732;
        Tue, 29 Mar 2022 15:27:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EDBAC732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648567627; bh=J4BwUFEnERHD+GXWZTxjovQvtNqH+5sYie0SgwCqXpk=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=W1k6RhGshgO420otQc6BSAwtuJAMUaHZ616+tM0WyzUJd5CAQvaLB2JaBTXbDIs8K
         Dhz1TobDSQhos4+TFz2cD4rhdW2VE27WkDEqq/FBCIhPjqWGPoZQ9w3lGy+V/9nyeN
         sTlSxFxfSLzYskogQfuYd5vTyn3bSFAN7EXKxBb4jRFq2G5IuZ2UlqLBGcZ7+kns0c
         DMVzd+8p6fYQLKe24gjotWXGSvAXgWhWvQXXtsWWgUB0B+oReA0jURqFnr8jFUwTzm
         cK+BeIcUBVPe2OWlnWNXOyaxRK3kUXjbSr/3Y6DhWUuygMO0iec1mwCwKaNvldCc6F
         JPdfv1ZApDjsQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, smangipudi@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, warthog618@gmail.com,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v5 01/11] Documentation: Add HTE subsystem guide
In-Reply-To: <db81d120-039d-f49f-9a48-c91e96777a61@gmail.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
 <20220329054521.14420-2-dipenp@nvidia.com>
 <db81d120-039d-f49f-9a48-c91e96777a61@gmail.com>
Date:   Tue, 29 Mar 2022 09:27:06 -0600
Message-ID: <875ynw7p9x.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 29/03/22 12.45, Dipen Patel wrote:
>> +============================================
>> +The Linux Hardware Timestamping Engine (HTE)
>> +============================================
>> +
>> +:Author: Dipen Patel
>> +
>
> Please learn how to convey semantics with rst format, see further comments
> below.

That is the Sphinx "field list" syntax; it's pretty heavily used
throughout the kernel documentation and doesn't seem to merit that sort
of response...?

[...]

>> +The struct hte_ts_data is used to pass timestamp details between the consumers
>> +and the providers. It expresses timestamp data in nanoseconds in u64 data
>> +type. For now all the HTE APIs using struct hte_ts_data require tsc to be in
>> +nanoseconds. An example of the typical hte_ts_data data life cycle, for the
>> +GPIO line is as follows::
>> +
>
> When we talk about name terms found in actual code (like keywords or variable
> names), it is customary to enclose them inside inline code (for example,
> ``struct what`` or ``u64 what``).

It's also customary to minimize markup.  In the case of "struct
whatever" the markup is actively harmful since it interferes with the
automatic recognition and cross-referencing of the type.

jon
