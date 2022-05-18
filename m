Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666C352B8DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiERL1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiERL1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:27:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C815C166455;
        Wed, 18 May 2022 04:27:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 545681F449B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652873264;
        bh=rBbCjdKWBmSyC6DxT/Ml286Uzl18qmi9zuCiDKlWOYc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=hxETIbvhCXlF07VtM55O17KnEffGaMX0AFK2f/GIVWDG85eLSv1sKOYhVYZ5YtezQ
         6TiPUkUn21A7yKRS/tu+jQBMDeA+8JXttz9J8r5z06zYzwG8vGM3WniTpiP6ccSB2r
         CiXnGzUAZAX1MnhUAg9NYoZcQyNQ7qQAY4LK9BkP/S6iMVYW3HjoIOvAZW2ehHIMJn
         0xadwx32BRSsO+goqBa+Q1FFplkxgh55p/735ifSr9kFOA2d8rv32sSb6vyBVkz6P/
         5CNeGIeVEIf/Ifd1yMcI4moFLbHGN+RQOSgP9BFDpy9xTaaoJ7/zgPfKvIRD6Lp4QZ
         zNXZ3Wh/ky7UQ==
Message-ID: <890ae132-cf86-8c82-8280-291869183f5f@collabora.com>
Date:   Wed, 18 May 2022 16:27:35 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] platform/chrome: Use imperative mood for ChromeOS
 ACPI sysfs ABI descriptions
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
References: <20220518083524.37380-1-bagasdotme@gmail.com>
 <20220518083524.37380-3-bagasdotme@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220518083524.37380-3-bagasdotme@gmail.com>
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
> The current descriptions all begin with ("This file shows something")
> clause, which is incorrect wording since these mean return value from
> sysfs.
> 
> Use imperative mood ("Returns something") instead, in line with
> corresponding ACPI documentation at firmware-guide/.
> 
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
