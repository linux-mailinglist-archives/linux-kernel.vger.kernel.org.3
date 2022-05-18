Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628FF52B8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiERL1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbiERL1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:27:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B77B163F74;
        Wed, 18 May 2022 04:27:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id CD32E1F449B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652873236;
        bh=e8p4TR3+Gx2olOYDXG39tw2db3gvoqk5KGWU0EEerow=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=g4oIkNfPtJb5VUZtQrESG1J4U4OhFQtjew7FoNk/MT2hHujri51MXh3vtsMfftMqz
         JuZ3wQUtjPhtbGi6N+YDU6FPgvRbqLBT/ky16/XR19hy6YNomn/8yVl4DJKCqouFDM
         tPUaS55Vei16kDq2phb8A9vRkKU0X9iktBII3jzw1zcOJA1xqSkkI3RWoDz6MZcfed
         c7HEdXwLQpTKvnmHk5H9tR82TwiQSuQIFQ8HGYCGpSOI+W8IN8WtuNsx6Vs17TpXtP
         0IYsmJMDwVOn16eBbJ3oIv6nHlOVs2aMH8qCzD3MO2GIIdBKUdfQ2zqMYfdJt4hjn0
         uwdjIdeK2T58Q==
Message-ID: <aa89071a-b69c-3ea4-4f61-14904505c34d@collabora.com>
Date:   Wed, 18 May 2022 16:27:06 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] platform/chrome: Use tables for values lists of
 ChromeOS ACPI sysfs ABI
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
References: <20220518083524.37380-1-bagasdotme@gmail.com>
 <20220518083524.37380-2-bagasdotme@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220518083524.37380-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 1:35 PM, Bagas Sanjaya wrote:
> Stephen Rothwell reported htmldocs warning when merging chrome-platform
> tree:
> 
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:2: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:11: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:22: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-chromeos-acpi:56: WARNING: Unexpected indentation.
> 
> The warning is due to missing blank line separator surrounding values
> lists.
> 
> Instead of using lists, use tables to be consistent with rest of sysfs
> ABI documentation.
> 
> Link: https://lore.kernel.org/linux-next/20220516213832.19127535@canb.auug.org.au/
> Fixes: 0a4cad9c11ad46 ("platform/chrome: Add ChromeOS ACPI device
> driver")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Benson Leung <bleung@google.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

-- 
Muhammad Usama Anjum
