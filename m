Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAE15554CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358756AbiFVTjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358574AbiFVTi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:38:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF217E0E;
        Wed, 22 Jun 2022 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jzZ8niIo7Smg65/52ka6uwTAHWOyxG3OOMUtsy1PEeE=; b=frN2qRKLQlK5xMP5cQT3Lb9HVI
        62WleJi7obpCi+3NJcwyjVzbqMUv/A6bothq/yL01s1j0b27k6EIsNFLe2zlnAZ3u/qyea7ep6jRG
        OWdN4qSgIs4Kf8e1FPIGsnUKcLjCjPDdnPUHTX4Iu52F3zr8L4elecDhTr6fdmAT/ZObCJltnrtvc
        VgpR65+FbzffP8eLhU+qX7j/2P851jaQhS4oZ9d6qJh1COdadmSJy6HZu3ls4Alk1xLSd8AaGVC7q
        DtSW53jX8g8vvZ7FzFBDwnULpwRuY95QoTBBAvkW+Mxx23lGlNihpqne20stVeHbO+J1ImLxYljE/
        JqUGhlzA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o46AI-00BGiS-IS; Wed, 22 Jun 2022 19:38:16 +0000
Message-ID: <afe8b072-466f-c180-eeef-5c501bf523e3@infradead.org>
Date:   Wed, 22 Jun 2022 12:37:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQ29tbW9uIGNsb2NrOiDigIvigItUbyBsaXN0IGFj?=
 =?UTF-8?Q?tive_consumers_of_clocks?=
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com,
        inux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        badolevishal1116@gmail.com
Cc:     chinmoyghosh2001@gmail.com, mintupatel89@gmail.com
References: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
 <20220610194013.DD39DC34114@smtp.kernel.org> <20220622163209.GA6246@Mahakal>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220622163209.GA6246@Mahakal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/22 09:32, <Vishal Badole> wrote:
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c44247d..549cdda 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -23,6 +23,14 @@ config COMMON_CLK
>  menu "Common Clock Framework"
>  	depends on COMMON_CLK
>  
> +config DEBUG_CLK_CONSUMER
> +	bool "Debug feature to list clocks and their active consumers"
> +	depends on DEBUG_FS && COMMON_CLK
> +	help
> +	  Clock consumer debug feature supports for clock debugging. Chose y

	                                                             Choose y

> +	  to get debug entry in file system to list clocks and their active
> +	  consumer devices.

-- 
~Randy
