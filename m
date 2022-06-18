Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB35550773
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 01:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiFRXVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 19:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFRXVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 19:21:34 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DEDB4AC
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 16:21:32 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7DD0183C0C;
        Sun, 19 Jun 2022 01:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1655594490;
        bh=U5BqOByUR4nqHwrXJbD2/kGAg8RBIhQcD8v9uASeFE4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A80HIAdCGRlNl9OyVXIc7PJUTsOkuwX0BYpEQ2pPc+2IjCqwNJaruNf8NNLh/h04K
         wWbGVpdBqdD1zOvwdCT0EIxc7PpvAxHuCdtqMIZIwSF9MpBSQfQ7JEfLpc4lQl714q
         WeoxysR9eCfju/sy7Gx/LsGdzrWMjO0liHzPpcTwojmJ9mh6CkDmd5jLo8AOF4TH39
         46EkvKs0znazHyUK8hYtLqbrf2otsJZp7OVsvKEDKbDO6tAOZtWrvSysWOZAVzlpC2
         udbqvErCeljNfMgpKrcSTLIwmUh8pjYMBHhVEuuq1g8EC8uBahD+CJlTU9RcOhU1sb
         DVcQsp1dPe8eA==
Message-ID: <ddbb74c0-6a28-7a1a-83a7-ed8e39d0259e@denx.de>
Date:   Sun, 19 Jun 2022 00:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] regmap: Re-introduce bulk read support check in
 regmap_bulk_read()
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220616073435.1988219-1-javierm@redhat.com>
 <20220616073435.1988219-2-javierm@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220616073435.1988219-2-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 09:34, Javier Martinez Canillas wrote:
> Support for drivers to define bulk read/write callbacks in regmap_config
> was introduced by the commit d77e74561368 ("regmap: Add bulk read/write
> callbacks into regmap_config"), but this commit wrongly dropped a check
> in regmap_bulk_read() to determine whether bulk reads can be done or not.
> 
> Before that commit, it was checked if map->bus was set. Now has to check
> if a map->read callback has been set.
> 
> Fixes: d77e74561368 ("regmap: Add bulk read/write callbacks into regmap_config")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Marek Vasut <marex@denx.de>
